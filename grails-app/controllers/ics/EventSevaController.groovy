package ics
import grails.converters.JSON
import groovy.sql.Sql;

class EventSevaController {

    def springSecurityService
def dataSource

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
    }

    def listvolunteer = {
    }

    def create = {
        def eventSevaInstance = new EventSeva()
        eventSevaInstance.properties = params
        return [eventSevaInstance: eventSevaInstance]
    }

    def save = {
        def eventSevaInstance = new EventSeva(params)
        if (!eventSevaInstance.hasErrors() && eventSevaInstance.save()) {
            flash.message = "eventSeva.created"
            flash.args = [eventSevaInstance.id]
            flash.defaultMessage = "EventSeva ${eventSevaInstance.id} created"
            redirect(action: "show", id: eventSevaInstance.id)
        }
        else {
            render(view: "create", model: [eventSevaInstance: eventSevaInstance])
        }
    }

    def show = {
        def eventSevaInstance = EventSeva.get(params.id)
        if (!eventSevaInstance) {
            flash.message = "eventSeva.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventSeva not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [eventSevaInstance: eventSevaInstance]
        }
    }

    def edit = {
        def eventSevaInstance = EventSeva.get(params.id)
        if (!eventSevaInstance) {
            flash.message = "eventSeva.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventSeva not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [eventSevaInstance: eventSevaInstance]
        }
    }

    def update = {
        def eventSevaInstance = EventSeva.get(params.id)
        if (eventSevaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (eventSevaInstance.version > version) {
                    
                    eventSevaInstance.errors.rejectValue("version", "eventSeva.optimistic.locking.failure", "Another user has updated this EventSeva while you were editing")
                    render(view: "edit", model: [eventSevaInstance: eventSevaInstance])
                    return
                }
            }
            eventSevaInstance.properties = params
            if (!eventSevaInstance.hasErrors() && eventSevaInstance.save()) {
                flash.message = "eventSeva.updated"
                flash.args = [params.id]
                flash.defaultMessage = "EventSeva ${params.id} updated"
                redirect(action: "show", id: eventSevaInstance.id)
            }
            else {
                render(view: "edit", model: [eventSevaInstance: eventSevaInstance])
            }
        }
        else {
            flash.message = "eventSeva.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventSeva not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def eventSevaInstance = EventSeva.get(params.id)
        if (eventSevaInstance) {
            try {
                eventSevaInstance.delete()
                flash.message = "eventSeva.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "EventSeva ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "eventSeva.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "EventSeva ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "eventSeva.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventSeva not found with id ${params.id}"
            redirect(action: "list")
        }
    }

    def jq_eventSeva_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def result = EventSeva.createCriteria().list(max:maxRows, offset:rowOffset) {
            //createAlias "sn", "seva.name"
            if(params."seva.name")
            	seva{ilike('name',"%"+params."seva.name"+"%")}
            if(params.inchargeName)
            	ilike('inchargeName',"%"+params.inchargeName+"%")
            if(params.inchargeContact)
            	ilike('inchargeContact',"%"+params.inchargeContact+"%")
            if(params.inchargeEmail)
            	ilike('inchargeEmail',"%"+params.inchargeEmail+"%")
            if(params.comments)
            	ilike('comments',"%"+params.comments+"%")
            if(sortIndex=="seva.name")
            	seva{order("name", sortOrder)}
            else
            	order(sortIndex, sortOrder)
      }
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.seva.name,
                    it.inchargeName,
                    it.inchargeContact,
                    it.inchargeEmail,
                    it.comments,
                    /*it.maxRequired,
                    it.maxPrjiRequired,
                    it.maxMatajiRequired,
                    it.maxBrahmachariRequired,
                    it.totalAllotted,
                    it.prjiAllotted,
                    it.matajiAllotted,
                    it.brahmachariAllotted,*/
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_eventSeva = {
	      def eventSeva = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  def seva = new Seva()
		  seva.name=params."seva.name"?.trim()
		  seva.category="RVTO"
		  seva.description=""
		  seva.type=""
		  seva.updator=seva.creator=springSecurityService.principal.username
		  if (! seva.hasErrors() && seva.save()) {
		    eventSeva = new EventSeva(params)
		    eventSeva.event = Event.findByTitle("RVTO")
		    eventSeva.seva = seva
		    eventSeva.updator=eventSeva.creator=springSecurityService.principal.username
			  if (! eventSeva.hasErrors() && eventSeva.save()) {
			    message = "EventSeva Saved.."
			    id = eventSeva.id
			    state = "OK"
			  } else {
			    eventSeva.errors.allErrors.each {
				log.debug("Error in adding eventSeva"+it)
				}
			    message = "Could Not Save EventSeva"
			  }
		  } else {
		    seva.errors.allErrors.each {
			log.debug("Error in adding seva in eventSeva"+it)
			}
		    message = "Could Not Save Seva"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check person exists
			  eventSeva = EventSeva.get(it)
			  if (eventSeva) {
			    // if no requirement then only delete person
			    if((eventSeva.maxRequired+eventSeva.totalOpted+eventSeva.totalAllotted)==0)
			    	{
			    	eventSeva.delete()
			    	message = "eventSeva  ${eventSeva.id} Deleted"
			    	state = "OK"
			    	}
			    else
			    	log.debug("In jq_edit_eventSeva: Can't delete eventSeva  ${eventSeva.id}")
			  }
		  	}
		  break;
		 default :
		  // edit action
		  // first retrieve the eventSeva by its ID
		  eventSeva = EventSeva.get(params.id)
		  if (eventSeva) {
		    // set the properties according to passed in parameters
		    eventSeva.inchargeName = params.inchargeName
		    eventSeva.inchargeContact = params.inchargeContact
		    eventSeva.inchargeEmail = params.inchargeEmail
		    eventSeva.comments = params.comments
		    eventSeva.maxRequired = params.int("maxRequired")?:0
		    eventSeva.maxPrjiRequired = params.int("maxPrjiRequired")?:0
		    eventSeva.maxMatajiRequired = params.int("maxMatajiRequired")?:0
		    eventSeva.maxBrahmachariRequired = params.int("maxBrahmachariRequired")?:0
		    eventSeva.updator = springSecurityService.principal.username
		    if (! eventSeva.hasErrors() && eventSeva.save()) {
		      message = "eventSeva  ${eventSeva.id} Updated"
		      id = eventSeva.id
		      state = "OK"
		    } else {
			    eventSeva.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update eventSeva"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def jq_pool_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def result = Person.createCriteria().list(max:maxRows, offset:rowOffset) {
			eq('status','RVTO_LOCAL_REG')
			
			or
			{
				and
				{
					or
					{
						eq('reference','Not Yet Decided')
						eq('reference','')
						isNull('reference')
					}
					isNull('comments')
				}
				eq('comments','Unallotted')
				eq('comments','MovedToPool')
			}
			
			if (params.name)
				ilike('name','%'+params.name + '%')

			if (params.category)
					ilike('category','%'+params.category + '%')

			if (params.phone)
				ilike('phone','%'+params.phone + '%')

			if (params.relation)//counselor
				ilike('relation','%'+params.relation + '%')

            order(sortIndex, sortOrder)
      }
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.name,
                    it.category,
                    it.phone,
                    it.relation
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def jq_eventSevaAllotment_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def result = EventSevaAllotment.createCriteria().list(max:maxRows, offset:rowOffset) {
			if(params.sevaid)
				eq('eventSeva',EventSeva.get(params.sevaid))
			if (params.name)
				person{ilike('name','%'+params.name + '%')}

			if (params.category)
					person{ilike('category','%'+params.category + '%')}

			if (params.phone)
				person{ilike('phone','%'+params.phone + '%')}

			if (params.relation)//counselor
				person{ilike('relation','%'+params.relation + '%')}

			if (params.'seva.name')
				eventSeva{seva{ilike('name','%'+params.'seva.name' + '%')}}

			if(sortIndex=='seva.name')
				eventSeva{seva{order('name', sortOrder)}}
			else
            			person{order(sortIndex, sortOrder)}
      }
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.person.name,
                    it.person.category,
                    it.person.phone,
                    it.person.relation,
                    it.eventSeva.seva.name
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def jq_preference_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def result = null
	      result = Person.createCriteria().list(max:maxRows, offset:rowOffset) {
				eq('status','RVTO_LOCAL_REG')

				if(params.sevaid)
					eq('reference',EventSeva.get(params.sevaid)?.seva?.name)

				isNull('comments')

				if (params.name)
					ilike('name','%'+params.name + '%')

				if (params.category)
						ilike('category','%'+params.category + '%')

				if (params.phone)
					ilike('phone','%'+params.phone + '%')

				if (params.relation)//counselor
					ilike('relation','%'+params.relation + '%')

				if (params.'seva.name')
					ilike('reference','%'+params.'seva.name' + '%')

				if(sortIndex=='seva.name')
					order('reference', sortOrder)
				else
					order(sortIndex, sortOrder)

	      }
      def totalRows = result?.totalCount?:0
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result?.collect {
            [cell: [
            	    it.name,
                    it.category,
                    it.phone,
                    it.relation,
                    it.reference
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def allot() {
      def message = ""
      def state = "FAIL"
      int count = 0
      def eventSeva = EventSeva.get(params.sevaid)
      if(eventSeva)
      	{
      	params.idlist?.tokenize(',').each {
      		def eventSevaAllotment = new EventSevaAllotment()
      		eventSevaAllotment.eventSeva = eventSeva
      		eventSevaAllotment.person = Person.get(it)
      		eventSevaAllotment.updator = eventSevaAllotment.creator = springSecurityService.principal.username
      		eventSevaAllotment.person.comments = "Allotted"
      		if(!eventSevaAllotment.save())
			    eventSevaAllotment.errors.allErrors.each {
				log.debug("Error in saving eventSevaAllotment: "+ it)
				}
		else
			count++
      		}
      	}
      if(count>0)
      	state = "OK"
      def response = [message:count+" allotted!",state:state]
      render response as JSON
    }

    def unallot() {
      def message = ""
      def state = "FAIL"
      int count = 0
	params.idlist?.tokenize(',').each {
		def eventSevaAllotment = EventSevaAllotment.get(it)
		//log.debug(eventSevaAllotment)
		eventSevaAllotment?.person.comments = "Unallotted"
		if(!eventSevaAllotment?.person.save())
			    eventSevaAllotment.person.errors.allErrors.each {
				log.debug("Error in deleting eventSevaAllotment (updating person): "+ it)
				}
		
		if(!eventSevaAllotment.delete())
			    eventSevaAllotment.errors.allErrors.each {
				log.debug("Error in deleting eventSevaAllotment: "+ it)
				}
		else
			count++
		}
      if(count>0)
      	state = "OK"
      def response = [message:count+" unallotted!",state:state]
      render response as JSON
    }

    def change() {
      def message = ""
      def state = "FAIL"
      int count = 0
      def newEventSeva = EventSeva.get(params.eventsevaid)
	params.idlist?.tokenize(',').each {
		def eventSevaAllotment = EventSevaAllotment.get(it)
		//log.debug(eventSevaAllotment)
		eventSevaAllotment.eventSeva = newEventSeva
		if(!eventSevaAllotment.save())
			    eventSevaAllotment.errors.allErrors.each {
				log.debug("Error in changing eventSevaAllotment id:"+eventSevaAllotment.id+":"+ it)
				}
		else
			count++
		}
      if(count>0)
      	state = "OK"
      def response = [message:count+" changed!",state:state]
      render response as JSON
    }

    def assign() {
      def message = ""
      def state = "FAIL"
      int count = 0
      def newEventSeva=null
      if(params.eventsevaid)
      	newEventSeva = EventSeva.get(params.eventsevaid)
	
	params.idlist?.tokenize(',').each {
		def person = Person.get(it)
		def eventSevaAllotment = EventSevaAllotment.findByPerson(person)
		if(eventSevaAllotment)
			{
			if(newEventSeva)
				eventSevaAllotment.eventSeva = newEventSeva
			else
				if(!eventSevaAllotment.delete())
				    eventSevaAllotment.errors.allErrors.each {
					log.debug("Error in deleting eventSevaAllotment id:"+eventSevaAllotment.id+":"+ it)
					}

			}
		else if(newEventSeva)
			{
			//create new eventseva allotment
			eventSevaAllotment = new EventSevaAllotment()
			eventSevaAllotment.eventSeva = newEventSeva
			eventSevaAllotment.person = person
			eventSevaAllotment.updator = eventSevaAllotment.creator = springSecurityService.principal.username
			eventSevaAllotment.person.comments = "Allotted"
			}
		if(!eventSevaAllotment.save())
			    eventSevaAllotment.errors.allErrors.each {
				log.debug("Error in assigning eventSevaAllotment id:"+eventSevaAllotment.id+":"+ it)
				}
		else
			count++
		}
      if(count>0)
      	state = "OK"
      def response = [message:count+" changed!",state:state]
      render response as JSON
    }

    def move() {
      def message = ""
      def state = "FAIL"
      int count = 0
	params.idlist?.tokenize(',').each {
		def person = Person.get(it)
		person.comments = "MovedToPool"
		if(!person.save())
			    person.errors.allErrors.each {
				log.debug("Error in moving person to pool:"+ it)
				}
		else
			count++
		}
      if(count>0)
      	state = "OK"
      def response = [message:count+" moved!",state:state]
      render response as JSON
    }

    def jq_op_volunteer_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def result = EventRegistration.createCriteria().list(max:maxRows, offset:rowOffset) {
            eq('verificationStatus',VerificationStatus.VERIFIED)
            isNull('status')
            isNull('volunteerStatus')
            eq('isVolunteersAvailable',true)

		if (params.name)
			ilike('name','%'+params.name + '%')

		if (params.regCode)
			ilike('regCode','%'+params.regCode + '%')

		if (params.connectedIskconCenter)
			ilike('connectedIskconCenter','%'+params.connectedIskconCenter + '%')

		if (params.contactNumber)
			ilike('contactNumber','%'+params.contactNumber + '%')
            order(sortIndex, sortOrder)
      }
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.name,
                    it.regCode,
                    it.connectedIskconCenter,
                    it.contactNumber,
                    it.arrivalDate?.format('dd-MM-yy HH:mm'),
                    it.departureDate?.format('dd-MM-yy HH:mm'),
                    it.numPrjiVolunteer,
                    it.numMatajiVolunteer,
                    it.numBrahmacharisVolunteer,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def allotOP() {
      def message = ""
      def state = "FAIL"
      int count = 0
      def eventSeva = EventSeva.get(params.sevaid)
      if(eventSeva)
      	{
      	params.idlist?.tokenize(',').each {
      		def eventSevaGroupAllotment = new EventSevaGroupAllotment()
      		eventSevaGroupAllotment.eventSeva = eventSeva
      		eventSevaGroupAllotment.eventRegistration = EventRegistration.get(it)
      		eventSevaGroupAllotment.updator = eventSevaGroupAllotment.creator = springSecurityService.principal.username
		//update the EventRegistration as allotted
      		eventSevaGroupAllotment.eventRegistration.volunteerStatus="ServiceAllotted"
      		if(!eventSevaGroupAllotment.save())
			    eventSevaGroupAllotment.errors.allErrors.each {
				log.debug("Error in saving eventSevaGroupAllotment: "+ it)
				}
		else
			count++
      		}
      	}
      if(count>0)
      	state = "OK"
      def response = [message:count+" allotted!",state:state]
      render response as JSON
    }

    def unallotOP() {
      def message = ""
      def state = "FAIL"
      int count = 0
      	params.idlist?.tokenize(',').each {
      		def eventSevaGroupAllotment = EventSevaGroupAllotment.get(it)
      		def er = eventSevaGroupAllotment.eventRegistration
		//reset the EventRegistration volunteer status
		er.volunteerStatus=null
		if(!er.save())
			    er.errors.allErrors.each {
				log.debug("unallotOP: Error in updating er "+ it)
				}
      		if(!eventSevaGroupAllotment.delete())
			    eventSevaGroupAllotment.errors.allErrors.each {
				log.debug("Error in deleting eventSevaGroupAllotment: "+ it)
				}
		else
			{
			count++
			}
      		}
      if(count>0)
      	state = "OK"
      def response = [message:count+" unallotted!",state:state]
      render response as JSON
    }

    def jq_op_allocation_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def result = EventSevaGroupAllotment.createCriteria().list(max:maxRows, offset:rowOffset) {
            eq('eventRegistration',EventRegistration.get(params.erid))
		if (params.seva)
			eventSeva{seva{ilike('name','%'+params.name + '%')}}

		if (params.name)
			eventRegistration{ilike('name','%'+params.name + '%')}

		if (params.regCode)
			eventRegistration{ilike('regCode','%'+params.regCode + '%')}

		if (params.connectedIskconCenter)
			eventRegistration{ilike('connectedIskconCenter','%'+params.connectedIskconCenter + '%')}

		if (params.contactNumber)
			eventRegistration{ilike('contactNumber','%'+params.contactNumber + '%')}
            order(sortIndex, sortOrder)
      }
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.eventSeva.seva.name,
            	    it.eventRegistration.name,
                    it.eventRegistration.regCode,
                    it.eventRegistration.connectedIskconCenter,
                    it.eventRegistration.contactNumber,
                    it.eventRegistration.arrivalDate?.format('dd-MM-yy HH:mm'),
                    it.eventRegistration.departureDate?.format('dd-MM-yy HH:mm'),
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def jq_op_allotted_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def eventSeva = EventSeva.get(params.sevaid)     
      def result = EventSevaGroupAllotment.createCriteria().list(max:maxRows, offset:rowOffset) {
            eq('eventSeva',eventSeva)
		if (params.seva)
			eventSeva{seva{ilike('name','%'+params.name + '%')}}

		if (params.name)
			eventRegistration{ilike('name','%'+params.name + '%')}

		if (params.regCode)
			eventRegistration{ilike('regCode','%'+params.regCode + '%')}

		if (params.connectedIskconCenter)
			eventRegistration{ilike('connectedIskconCenter','%'+params.connectedIskconCenter + '%')}

		if (params.contactNumber)
			eventRegistration{ilike('contactNumber','%'+params.contactNumber + '%')}
				
            order(sortIndex, sortOrder)
      }
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.eventRegistration.name,
                    it.eventRegistration.regCode,
                    it.eventRegistration.connectedIskconCenter,
                    it.eventRegistration.contactNumber,
                    it.eventRegistration.arrivalDate?.format('dd-MM-yy HH:mm'),
                    it.eventRegistration.departureDate?.format('dd-MM-yy HH:mm'),
                    it.eventRegistration.numPrjiVolunteer,
                    it.eventRegistration.numMatajiVolunteer,
                    it.eventRegistration.numBrahmacharisVolunteer,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def jq_summary_list = {

      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
    	def result

      def sql = new Sql(dataSource);
      String query = ""

	      query = "select p.id, p.name,p.category, p.phone, p.relation counselor,p.reference preferredService,q.name allottedService  from person p left join (select a.person_id, s.name from event_seva_allotment a,event_seva es,seva s where a.event_seva_id=es.id and es.seva_id=s.id) q on p.id=q.person_id where p.status='RVTO_LOCAL_REG'"
	      //add conditions
	      
	      if(params.name || params.category || params.phone || params.counselor || params.preferredService || params.allottedService)
	      	query += " and "
	      
	      def numCondns = 0
	      
	      if (params.name)
	      {
	      	query += " p.name like '%"+params.name+"%'"
	      	numCondns++
	      }
	      
	      if (params.category)
	      {
	      	if(numCondns>0)
	      		query += " and p.category like '%"+params.category+"%'"
	      	else
	      		query += " p.category like '%"+params.category+"%'"
	      	numCondns++
	      }
	      
	      if (params.phone)
	      {
	      	if(numCondns>0)
	      		query += " and p.phone like '%"+params.phone+"%'"
	      	else
	      		query += " p.phone like '%"+params.phone+"%'"
	      	numCondns++
	      }
	      
	      if (params.counselor)
	      {
	      	if(numCondns>0)
	      		query += " and p.relation like '%"+params.counselor+"%'"
	      	else
	      		query += " p.relation like '%"+params.counselor+"%'"
	      	numCondns++
	      }
	      
	      if (params.preferredService)
	      {
	      	if(numCondns>0)
	      		query += " and p.reference like '%"+params.preferredService+"%'"
	      	else
	      		query += " p.reference like '%"+params.preferredService+"%'"
	      	numCondns++
	      }
	      
	      if (params.allottedService)
	      {
	      	if(numCondns>0)
	      		query += " and q.name like '%"+params.allottedService+"%'"
	      	else
	      		query += " q.name like '%"+params.allottedService+"%'"
	      	numCondns++
	      }
	      

      //add sorting,ordering
      query += " order by "+sortIndex+" "+sortOrder
      
      //println query
      result = sql.rows(query,rowOffset,maxRows)

	//println 'result='+result
      String countQuery = "select count(1) cnt from ("+query+") q"
      //println countQuery
      
      def totalRows = sql.firstRow(countQuery)?.cnt
      def numberOfPages = Math.ceil(totalRows / maxRows)
      
      sql.close()

      def jsonCells = result.collect {
            [cell: [
                    it.name,
                    it.category,
                    it.phone,
                    it.counselor,
                    it.preferredService,
                    it.allottedService,
                ], id: it.id]
        }
        
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }

    def jq_seva_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = EventSeva.createCriteria().list(max:maxRows, offset:rowOffset) {
		//TODO: Event is hardcoded now
		eq('inchargeName',session.individualname)	//TODO It should have been derived directly from Individual in EventSeva
		seva{order(sortIndex, sortOrder)}
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.seva.name,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def jq_volunteer_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def eventSeva = null
	if(params.eventsevaid)
		eventSeva=EventSeva.get(params.eventsevaid)
		
	def result = EventSevaAllotment.createCriteria().list(max:maxRows, offset:rowOffset) {
		eq('eventSeva',eventSeva)

		if (params.name)
				person{ilike('name','%'+params.name + '%')}
		if (params.category)
				person{ilike('category','%'+params.category + '%')}
		if (params.phone)
				person{ilike('phone','%'+params.phone + '%')}
		if (params.relation)
				person{ilike('relation','%'+params.relation + '%')}

		person{order(sortIndex, sortOrder)}

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.person.name,
            	    it.person.category,
            	    it.person.phone,
            	    it.person.relation,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }
}
