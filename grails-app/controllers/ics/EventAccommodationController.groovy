package ics

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.dao.DataIntegrityViolationException
import groovy.sql.Sql;
import grails.converters.JSON
import org.codehaus.groovy.grails.commons.ConfigurationHolder

import com.krishna.IcsRole;
import com.krishna.IcsUser;
import com.krishna.IcsUserIcsRole;

import org.apache.commons.codec.binary.Hex

import org.apache.commons.codec.digest.DigestUtils
import java.security.SecureRandom

class EventAccommodationController {

    def housekeepingService
    def springSecurityService
    def dataSource
    def accommodationService
   
    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
    }

    def create = {
        def eventAccommodationInstance = new EventAccommodation()
        eventAccommodationInstance.properties = params
        return [eventAccommodationInstance: eventAccommodationInstance]
    }

    def setManualMode() {
        def eventAccommodationInstance = EventAccommodation.get(params.id)
    	if (eventAccommodationInstance.chart)
    		eventAccommodationInstance.chart.delete()
    	eventAccommodationInstance.chart = null
    	eventAccommodationInstance.manualMode = true
    	eventAccommodationInstance.save()
    	redirect(action: "show", id: params.id)
    }
    
    def save = {
        
	if(params.availableFromDate)
		params.availableFromDate = Date.parse('dd-MM-yyyy HH:mm', params.availableFromDate)
	if(params.availableTillDate)
		params.availableTillDate = Date.parse('dd-MM-yyyy HH:mm', params.availableTillDate)
	if(params.dateofBooking)
		params.dateofBooking = Date.parse('dd-MM-yyyy', params.dateofBooking)
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else {
		params.creator=""
	}
	params.updator=params.creator
	
	def eventAccommodationInstance = new EventAccommodation(params)

	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION'))
		eventAccommodationInstance.isVipAccommodation = true
	else 
		eventAccommodationInstance.isVipAccommodation = false

	eventAccommodationInstance.availableCapacity = eventAccommodationInstance.maxCapacity?:0
	eventAccommodationInstance.availablePrabhujis = eventAccommodationInstance.maxPrabhujis?:0
	eventAccommodationInstance.availableMatajis = eventAccommodationInstance.maxMatajis?:0
	eventAccommodationInstance.availableChildrens = eventAccommodationInstance.maxChildrens?:0
	eventAccommodationInstance.availableBrahmacharis = eventAccommodationInstance.maxBrahmacharis?:0

	def eventInstance = Event.findByTitle('RVTO')
	eventAccommodationInstance.event = eventInstance

	if (!eventAccommodationInstance.hasErrors() && eventAccommodationInstance.save(flush:true)) {
            flash.message = "eventAccommodation.created"
            flash.args = [eventAccommodationInstance.id]
            flash.defaultMessage = "EventAccommodation ${eventAccommodationInstance.id} created"
            redirect(action: "show", id: eventAccommodationInstance.id)
        }
        else {
             eventAccommodationInstance.errors.allErrors.each {
			 println "eventAccommodationInstance error"+it
		    }
	    render(view: "create", model: [eventAccommodationInstance: eventAccommodationInstance])
        }
    }

    def show = {
        def eventAccommodationInstance
        if(params.domainId=='AA')
        	eventAccommodationInstance= AccommodationAllotment.get(params.id)?.eventAccommodation
        else
        	eventAccommodationInstance = EventAccommodation.get(params.id)
        if (!eventAccommodationInstance) {
            flash.message = "eventAccommodation.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventAccommodation not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [eventAccommodationInstance: eventAccommodationInstance]
        }
    }

    def edit = {
        
	System.out.println("Here" + params.id);

	def eventAccommodationInstance = EventAccommodation.get(params.id)

	//toDo check if accommodation number is changed.

        if (!eventAccommodationInstance) {
            flash.message = "eventAccommodation.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventAccommodation not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [eventAccommodationInstance: eventAccommodationInstance]
        }
    }

    def prepareChart = {
	def eventAccommodationInstance = EventAccommodation.get(params.id)
        if (!eventAccommodationInstance) {
            flash.message = "eventAccommodation.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventAccommodation not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            def flag = accommodationService.initializeChart(eventAccommodationInstance)
            if (flag)
            	flash.message = "Chart Prepared!!"
            else
            	flash.message = "Some error occured in chart preparation!!"
            	
            redirect(action: "show", id: eventAccommodationInstance.id)
        }
    }

    def update = {

        if(params.availableFromDate)
		params.availableFromDate = Date.parse('dd-MM-yyyy HH:mm', params.availableFromDate)
	if(params.availableTillDate)
		params.availableTillDate = Date.parse('dd-MM-yyyy HH:mm', params.availableTillDate)
	if(params.dateofBooking)
		params.dateofBooking = Date.parse('dd-MM-yyyy', params.dateofBooking)
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else {
		params.creator=""
	}
	params.updator=params.creator

        def eventAccommodationInstance = EventAccommodation.get(params.id)
        if (eventAccommodationInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (eventAccommodationInstance.version > version) {
                    
                    eventAccommodationInstance.errors.rejectValue("version", "eventAccommodation.optimistic.locking.failure", "Another user has updated this EventAccommodation while you were editing")
                    render(view: "edit", model: [eventAccommodationInstance: eventAccommodationInstance])
                    return
                }
            }
            int addedCapacity = (params.int('maxCapacity')?:0) - eventAccommodationInstance.maxCapacity
            log.debug("In update eventAccommodation capcityAddition="+addedCapacity)
            
            eventAccommodationInstance.properties = params

	log.debug("In ea update: availability before update="+eventAccommodationInstance.availableCapacity)
	eventAccommodationInstance.availableCapacity += addedCapacity
	log.debug("In ea update: availability after update="+eventAccommodationInstance.availableCapacity)
	/*eventAccommodationInstance.availablePrabhujis = eventAccommodationInstance.maxPrabhujis?:0
	eventAccommodationInstance.availableMatajis = eventAccommodationInstance.maxMatajis?:0
	eventAccommodationInstance.availableChildrens = eventAccommodationInstance.maxChildrens?:0
	eventAccommodationInstance.availableBrahmacharis = eventAccommodationInstance.maxBrahmacharis?:0*/


            if (!eventAccommodationInstance.hasErrors() && eventAccommodationInstance.save()) {
                flash.message = "eventAccommodation.updated"
                flash.args = [params.id]
                flash.defaultMessage = "EventAccommodation ${params.id} updated"
                redirect(action: "show", id: eventAccommodationInstance.id)
            }
            else {
                render(view: "edit", model: [eventAccommodationInstance: eventAccommodationInstance])
            }
        }
        else {
            flash.message = "eventAccommodation.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventAccommodation not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def eventAccommodationInstance = EventAccommodation.get(params.id)
        if (eventAccommodationInstance) {
            try {
                //eventAccommodationInstance.delete()
                //first check if there are any allotments
                def allotments = AccommodationAllotment.findAllByEventAccommodation(eventAccommodationInstance)
                if(allotments?.size()>0)
                	{
				flash.message = "eventAccommodation.cannot.deleted"
				flash.args = [params.id]
                		flash.defaultMessage = "Can not delete EventAccommodation ${params.id} as there are existing allotments!!"
                		redirect(action: "show", id:eventAccommodationInstance.id)
                		return
                	}
                eventAccommodationInstance.status="DELETED" //soft delete
                if(!eventAccommodationInstance.save())
                	{
			    eventAccommodationInstance.errors.allErrors.each {
				 log.debug("In eventAccommodation delete:"+ it)
			    }
                	}
                flash.message = "eventAccommodation.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "EventAccommodation ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "eventAccommodation.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "EventAccommodation ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "eventAccommodation.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventAccommodation not found with id ${params.id}"
            redirect(action: "list")
        }
    }

     def jq_accommodation_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = EventAccommodation.createCriteria().list(max:maxRows, offset:rowOffset) {
		isNull('status')
		
		if(SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION'))
			eq('isVipAccommodation',true)
		else if(SpringSecurityUtils.ifNotGranted('ROLE_EVENTADMIN'))
			eq('isVipAccommodation',false)

		if (params.name)
			ilike('name','%'+params.name + '%')

		if (params.address)
			ilike('address','%'+params.address + '%')

		if (params.comments)
			ilike('comments','%'+params.comments + '%')

		if (params.rankOverall)
				ge('rankOverall',params.int('rankOverall'))

		if (params.accommodationInChargeName)
			ilike('accommodationInChargeName','%'+params.accommodationInChargeName + '%')

		if (params.accommodationInChargeContactNumber)
			ilike('accommodationInChargeContactNumber','%'+params.accommodationInChargeContactNumber + '%')

		if (params.maxCapacity)
				ge('maxCapacity',params.int('maxCapacity'))

		if (params.availableCapacity)
				ge('availableCapacity',params.int('availableCapacity'))

		if (params.totalCheckedin)
				ge('totalCheckedin',params.int('totalCheckedin'))

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def totalAllotted = 0
      def totalCapacity=0,grandTotalAllotted=0,totalAvailable=0,totalCheckedin=0,totalStillToCheckin=0
      
      def jsonCells = result.collect {
            totalAllotted = it.availablePrabhujis+it.availableMatajis+it.availableChildrens+it.availableBrahmacharis
            totalCapacity += it.maxCapacity
            grandTotalAllotted += totalAllotted
            totalAvailable += it.availableCapacity
            totalCheckedin += it.totalCheckedin
            totalStillToCheckin += (totalAllotted - it.totalCheckedin)

            [cell: [
			    it.name,
			    it.address,
			    it.comments,
			    it.rankOverall,
			    it.availableFromDate?.format('dd-MM HH:mm'), 
			    it.availableTillDate?.format('dd-MM HH:mm'), 
			    it.accommodationInChargeName,
			    it.accommodationInChargeContactNumber,
			    it.maxCapacity,
			    totalAllotted,
			    it.availableCapacity,
			    it.totalCheckedin,
			    totalAllotted - it.totalCheckedin,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages, userdata:[accommodationInChargeContactNumber:'Total',maxCapacity:totalCapacity,totalAllotted:grandTotalAllotted,availableCapacity:totalAvailable,totalCheckedin:totalCheckedin,stillToCheckin:totalStillToCheckin]]
        render jsonData as JSON
   }


     def jq_summary_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'
      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1
      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
      def totalRows = 5
      def numberOfPages = Math.ceil(totalRows / maxRows)
      
      def jsonCells = []
      def eventAcco = EventAccommodation.get(params.id)
      
      def totalAllotted = eventAcco.availablePrabhujis+eventAcco.availableMatajis+eventAcco.availableChildrens+eventAcco.availableBrahmacharis
    
      jsonCells.add(
            [cell: [
			    'Capacity',
			    eventAcco.maxCapacity,
			    '',
			    '',
			    '',
			    ''
                ], id: 1]
        )
      //allotted
      jsonCells.add(
            [cell: [
			    'Allocations',
			    totalAllotted,
			    eventAcco.availablePrabhujis,
			    eventAcco.availableMatajis,
			    eventAcco.availableChildrens,
			    eventAcco.availableBrahmacharis
                ], id: 2]
        )
      //available
      jsonCells.add(
            [cell: [
			    'Available for Allocations',
			    eventAcco.availableCapacity,
			    '',
			    '',
			    '',
			    ''
                ], id: 3]
        )
      //checkedin
      jsonCells.add(
            [cell: [
			    'Checked-In',
			    eventAcco.totalCheckedin,
			    eventAcco.totalPrjiCheckedin,
			    eventAcco.totalMatajiCheckedin,
			    eventAcco.totalChildrenCheckedin,
			    eventAcco.totalBrahmachariCheckedin
                ], id: 4]
        )
      //still to checkin
      jsonCells.add(
            [cell: [
			    'Still to Check-In',
			    totalAllotted - eventAcco.totalCheckedin,
			    eventAcco.availablePrabhujis - eventAcco.totalPrjiCheckedin,
			    eventAcco.availableMatajis - eventAcco.totalMatajiCheckedin,
			    eventAcco.availableChildrens - eventAcco.totalChildrenCheckedin,
			    eventAcco.availableBrahmacharis - eventAcco.totalBrahmachariCheckedin
                ], id: 5]
        )
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
   }

  def jq_registration_list = {
              def now = new Date()
	      def today = now.format('D')
	      
	      def sortIndex = params.sidx ?: 'r.name'
	      def sortOrder  = params.sord ?: 'asc'

	      def maxRows = Integer.valueOf(params.rows)
	      def currentPage = Integer.valueOf(params.page) ?: 1

	      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
	      def result
	      def sql = new Sql(dataSource);
	      String query = ""
	      query = "SELECT r.id, r.name as GuestName, r.contact_number contactNumber, r.reg_code, aa.allott_from, aa.allott_till,aa.number_allotted, aa.numberof_prabhujis_allotted, aa.numberof_matajis_allotted, aa.numberof_children_allotted, aa.numberof_brahmacharis_allotted FROM event_accommodation a, accommodation_allotment aa,event_registration r WHERE a.id=aa.event_accommodation_id and aa.event_registration_id = r.id and a.id="+params.id
		
	      //add conditions
	      if (params.GuestName)
	      {
		query += " and r.name like '%"+params.GuestName+"%'"
	      }

	      if (params.contactNumber)
	      {
		query += " and r.contact_Number like '%"+params.contactNumber+"%'"
	      }

	      if (params.reg_code)
	      {
		query += " and r.reg_code like '%"+params.reg_code+"%'"
	      }

	      //add sorting,ordering
	      query += " order by "+sortIndex+" "+sortOrder
	      
	      result = sql.rows(query,rowOffset,maxRows)

	      String countQuery = "select count(1) cnt from ("+query+") q"
	      
	      def totalRows = sql.firstRow(countQuery)?.cnt
	      def numberOfPages = Math.ceil(totalRows / maxRows)
	      
	      sql.close()
		
	
	      def ta=0,pa=0,ma=0,ca=0,ba=0
	      def jsonCells = result.collect {
		    ta += it.number_allotted
		    pa += it.numberof_prabhujis_allotted
		    ma += it.numberof_matajis_allotted
		    ca += it.numberof_children_allotted
		    ba += it.numberof_brahmacharis_allotted
		    [cell: [it.GuestName, 
		            it.contactNumber, 
		            it.reg_code, 
			    it.allott_from?.format('dd-MM HH:mm'), 
			    it.allott_till?.format('dd-MM HH:mm'), 
			    it.number_allotted, 
			    it.numberof_prabhujis_allotted, 
			    it.numberof_matajis_allotted, 
			    it.numberof_children_allotted,
			    it.numberof_brahmacharis_allotted,
			], id: it.id]
		}
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages,userdata:[date_till:'Total',number_allotted:ta,numberof_prabhujis_allotted:pa,numberof_matajis_allotted:ma,numberof_children_allotted:ca,numberof_brahmacharis_allotted:ba]]
	        render jsonData as JSON
		
   }
    
	def jq_edit_registrations = {
	      
	      print("In Edit-->"+params)

	      def accommodationAllotment = AccommodationAllotment.get(params.id) 

	      int noPrabhujis
	      int noMatajis
	      int noChildrens

	      if (accommodationAllotment.numberofPrabhujisAllotted != params.int('prabhujisAllotted')){
		  noPrabhujis = params.int('prabhujisAllotted')	
	      } else {
	          noPrabhujis = 0
	      }
	      
	      if (accommodationAllotment.numberofMatajisAllotted != params.int('matajisAllotted')){
		  noMatajis = params.int('matajisAllotted')	
	      } else {
	          noMatajis = 0
	      }

	      if (accommodationAllotment.numberofChildrenAllotted != params.int('childrensAllotted')){
		  noChildrens = params.int('childrensAllotted')	
	      } else {
	          noChildrens = 0
	      }

	      //Calculated the difference

	      int diffPrabhujis = accommodationAllotment.numberofPrabhujisAllotted - noPrabhujis
	      int diffMatajis = accommodationAllotment.numberofMatajisAllotted - noMatajis
	      int diffChildrens = accommodationAllotment.numberofChildrenAllotted - noChildrens

	      
	      def eventRegistration = EventRegistration.get(accommodationAllotment.eventRegistration.id)
	      def eventAccommodation = EventAccommodation.get(accommodationAllotment.eventAccommodation.id)

	      def allotments = AccommodationAllotment.findAllByEventRegistration(eventRegistration)

	      int prabhjisAccommodatedTillNow = 0
	      int matajisAccommodatedTillNow = 0
	      int childrensAccommodatedTillNow = 0

	      int allotmentIsCorrect
	      String message = ""

	      allotments.each { allotment ->
	          if (allotment.eventAccommodation.id == eventAccommodation.id){
			prabhjisAccommodatedTillNow = prabhjisAccommodatedTillNow + noPrabhujis
			matajisAccommodatedTillNow = matajisAccommodatedTillNow + noMatajis
			childrensAccommodatedTillNow = childrensAccommodatedTillNow + noChildrens
	          } else {
			prabhjisAccommodatedTillNow = prabhjisAccommodatedTillNow + allotment.numberofPrabhujisAllotted
			matajisAccommodatedTillNow = matajisAccommodatedTillNow + allotment.numberofMatajisAllotted
			childrensAccommodatedTillNow = childrensAccommodatedTillNow + allotment.numberofChildrenAllotted
		  }
		  
	      }

	      //check new allotment for guest requirement
	      if(eventRegistration.numberofPrabhujis >= prabhjisAccommodatedTillNow &&
		 eventRegistration.numberofMatajis >= matajisAccommodatedTillNow &&
		 eventRegistration.numberofChildren >= childrensAccommodatedTillNow
		 ) {
		 allotmentIsCorrect = 1
	      } else {
                 allotmentIsCorrect = 0	          
		 message = message.concat("New allotment is exceeding guest requirement.")
	      }
	      
	      //check new allotment for maximum limit 
	      if(eventAccommodation.maxPrabhujis >= (eventAccommodation.availablePrabhujis + noPrabhujis) &&
		 eventAccommodation.maxMatajis >= (eventAccommodation.availableMatajis + noMatajis) &&
		 eventAccommodation.maxChildrens >= (eventAccommodation.availableChildrens + noChildrens) &&
		 allotmentIsCorrect == 1
		 ) {
		 allotmentIsCorrect = 1
	      } else {
		 allotmentIsCorrect = 0
		 message = message.concat("New allotment is exceeding maximum limit.")
	      }
	      	      
	      if (noPrabhujis != 0 ){
		 accommodationAllotment.numberofPrabhujisAllotted = noPrabhujis
	      }
	      if (noMatajis != 0 ){
		 accommodationAllotment.numberofMatajisAllotted = noMatajis
	      }
	      if (noChildrens != 0 ){
		 accommodationAllotment.numberofChildrenAllotted = noChildrens
	      }
	      accommodationAllotment.creator = "temp"
	      accommodationAllotment.updator = "temp"

	      print("Allotment-"+allotmentIsCorrect)
	      print("message-"+message)

	      if (allotmentIsCorrect == 1) {
	         
		 if(accommodationAllotment.save(flush: true)) {
		    
		    // check if allotment status of registration needs to be change 

		    if(prabhjisAccommodatedTillNow + noPrabhujis == eventRegistration.numberofPrabhujis &&
		       matajisAccommodatedTillNow + noMatajis == eventRegistration.numberofMatajis &&
		       childrensAccommodatedTillNow + noChildrens == eventRegistration.numberofChildren ) {
			
			eventRegistration.accommodationAllotmentStatus = AccommodationAllotmentStatus.ALLOTEMENT_COMPLETE
		    } else {
			eventRegistration.accommodationAllotmentStatus = AccommodationAllotmentStatus.ALLOTEMENT_IN_PROGRESS
		    }
		    
		    if (!eventRegistration.save(flush: false)) {
			    eventRegistration.errors.allErrors.each {
				 println it
		            }
		    }
		    
			
		    eventAccommodation.availablePrabhujis = eventAccommodation.availablePrabhujis + diffPrabhujis
		    eventAccommodation.availableMatajis = eventAccommodation.availableMatajis + diffMatajis
		    eventAccommodation.availableChildrens = eventAccommodation.availableChildrens + diffChildrens
		    if (!eventAccommodation.save(flush: false)) {
			eventAccommodation.errors.allErrors.each {
				println it
			}
		    }

		    message = message.concat("Allotment successfully saved.") 

	      } else {
		    accommodationAllotment.errors.allErrors.each {
			 println it
		    }
	      }
	 
	   }

	   flash.message = message

	   def response = [id:eventRegistration.id,message:message]

	   render response as JSON
       }
       
       def allot() {
	        log.debug("Inside allot: "+params)
	        def vip = ''
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION'))
			vip = 'VIP'
		else 
			vip = ''
	      
       		//accommodationService.allocate(EventRegistration.get(params.erid), EventAccommodation.get(params.id),vip,Date.parse('dd-MM-yyyy HH:mm',params.fromDate), Date.parse('dd-MM-yyyy HH:mm',params.toDate), params.int('numR'), params.int('numP'), params.int('numM'), params.int('numC'), params.int('numB'))
       		def result = accommodationService.simpleallocate(params.erid, params.id,vip, params.int('numPreq'), params.int('numMreq'), params.int('numCreq'), params.int('numBreq'))
       		//redirect(controller: "AccommodationAllotment", action: "accommodationAllotment", id: params.erid)
       		//render([status: cardsArrived.size(), text: cardsArrivedMsg] as JSON)
       		render(result as JSON)
       		
       }

       def jq_checkin_list = {
	      def sortIndex = params.sidx ?: 'id'
	      def sortOrder  = params.sord ?: 'asc'

	      def maxRows = Integer.valueOf(params.rows)
	      def currentPage = Integer.valueOf(params.page) ?: 1

	      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
	      
	      def result = AccommodationAllotment.createCriteria().list(max:maxRows, offset:rowOffset) {
		    if (params.id)
			eq('eventAccommodation',EventAccommodation.get(params.id))
		    isNotNull('subEventRegistration')
		    if(sortIndex=="sglname")
		    	subEventRegistration{order("name", sortOrder)}
		    else if(sortIndex=="mglname")
		    	eventRegistration{order("name", sortOrder)}
		    else
		    	order(sortIndex, sortOrder)
	      }
	      def totalRows = result.totalCount
	      def numberOfPages = Math.ceil(totalRows / maxRows)
		
	      def tc=0,pc=0,mc=0,cc=0,bc=0
		
	      def jsonCells = result.collect {
		    tc += it.numberCheckedin
		    pc += it.numberofPrabhujisCheckedin
		    mc += it.numberofMatajisCheckedin
		    cc += it.numberofChildrenCheckedin
		    bc += it.numberofBrahmacharisCheckedin

		    [cell: [it.eventRegistration?.name,
			    it.eventRegistration?.contactNumber,
			    it.eventRegistration?.regCode,
			    it.subEventRegistration?.name,
			    it.subEventRegistration?.contactNumber,
			    it.numberCheckedin,
			    it.numberofPrabhujisCheckedin,
			    it.numberofMatajisCheckedin,
			    it.numberofChildrenCheckedin,
			    it.numberofBrahmacharisCheckedin,
			], id: it.eventRegistration?.id]
		}
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages,userdata:[sglcontact:'Total',numberCheckedin:tc,numberofPrabhujisCheckedin:pc,numberofMatajisCheckedin:mc,numberofChildrenCheckedin:cc,numberofBrahmacharisCheckedin:bc]]
	        render jsonData as JSON
		
   }
}
