package ics

import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class EventController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
        def eventInstanceList = Event.list(params)

        withFormat {
            html {
                [eventInstanceList: eventInstanceList, eventInstanceTotal: Event.count()]
            }
            json {
		def eventList = []
		eventInstanceList.each {event ->
			 eventList << [
				id: "E"+event.id,
				title: event.title,
				allDay: false,
				start: event.startDate,
				end: event.endDate
			]
		}
		//get all the objectived assigned to the logged in user as well
		def objectiveInstanceList = Objective.findAllByAssignedTo(Individual.findByLoginid(springSecurityService.principal.username))
		objectiveInstanceList?.each {objective ->
			 eventList << [
				id: "O"+objective.id,
				title: "Objective: "+objective.name,
				allDay: false,
				start: objective.objFrom,
				end: objective.objTo
			]
		}
                render eventList as JSON
            }
        }
    }

    def create = {
        def eventInstance = new Event()
        eventInstance.properties = params
        return [eventInstance: eventInstance]
    }

    def save = {
    	log.debug("Saving event with params:"+params)
    	if(params.startDate)
			params.startDate = Date.parse('dd-MM-yyyy HH:mm', params.startDate)
	if(params.endDate)
		params.endDate = Date.parse('dd-MM-yyyy HH:mm', params.endDate)
    	if(params.regstartDate)
			params.regstartDate = Date.parse('dd-MM-yyyy HH:mm', params.regstartDate)
	if(params.regendDate)
		params.regendDate = Date.parse('dd-MM-yyyy HH:mm', params.regendDate)
    
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator
	params."contactPerson.id" = params."acContactPerson_id"
        def eventInstance = new Event(params)
        if (eventInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'event.label', default: 'Event'), eventInstance.id])}"
            redirect(action: "show", id: eventInstance.id)
        }
        else {
            render(view: "create", model: [eventInstance: eventInstance])
        }
    }

    def show = {
        def eventInstance
        
        //check if the id is prepended, to handle the calendar
        switch(params.id?.getAt(0))
        	{
        		case 'E':
        			eventInstance = Event.get(params.id.substring(1))
        			break
         		case 'O':
        			redirect(controller: "Objective", action: "show", id: params.id.substring(1))
        			return
        		default:
        			eventInstance = Event.get(params.id)

        	}

        if (!eventInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
            redirect(action: "list")
        }
        else {
            def model = [eventInstance: eventInstance, occurrenceStart: eventInstance.startDate, occurrenceEnd: eventInstance.endDate]
            if (request.xhr) {
                render(template: "showPopup", model: model)
            }
            else {
                model
            }
        }
    }

    def edit = {
        def eventInstance = Event.get(params.id)
        if (!eventInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [eventInstance: eventInstance]
        }
    }

    def update = {
        log.debug("Event.update params: "+params)
        def eventInstance = Event.get(params.id)
    	if(params.startDate)
			params.startDate = Date.parse('dd-MM-yyyy HH:mm', params.startDate)
	if(params.endDate)
		params.endDate = Date.parse('dd-MM-yyyy HH:mm', params.endDate)
    	if(params.regstartDate)
			params.regstartDate = Date.parse('dd-MM-yyyy HH:mm', params.regstartDate)
	if(params.regendDate)
		params.regendDate = Date.parse('dd-MM-yyyy HH:mm', params.regendDate)
	if(params."acContactPerson_id")
     	params."contactPerson.id" = params."acContactPerson_id"
    else
    {
		if (params.contactPersonChkBox)
		{
			println 'CHK='+params.contactPersonChkBox.value.toString()
			if (params.contactPersonChkBox.value.toString()=="on")
					params."contactPerson.id"= params.h_contactPerson.id
			else
			{
				flash.message = "Contact Person Not Entered!"
				render(view: "edit", model: [eventInstance: eventInstance])
				return [eventInstance: eventInstance]
			}
		}
		else
		{
			//println 'NO CHECKBOX'
			flash.message = "Contact Person Not Entered!"
			render(view: "edit", model: [eventInstance: eventInstance])
			return [eventInstance: eventInstance] 
		}
	}	

        if (eventInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (eventInstance.version > version) {
                    
                    eventInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'event.label', default: 'Event')] as Object[], "Another user has updated this Event while you were editing")
                    render(view: "edit", model: [eventInstance: eventInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"
		println 'params='+params
            eventInstance.properties = params
            if (!eventInstance.hasErrors() && eventInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'event.label', default: 'Event'), eventInstance.id])}"
                redirect(action: "show", id: eventInstance.id)
            }
            else {
                render(view: "edit", model: [eventInstance: eventInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def eventInstance = Event.get(params.id)
        if (eventInstance) {
            try {
                eventInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
            redirect(action: "list")
        }
    }

    def findEventsAsJSON = {
    		def query = params.query
        	def c = Event.findAllByTitleLike("%"+query+"%",[sort:'title'])
        response.setHeader("Cache-Control", "no-store")

        def results = c.collect {
            [  id: it.id,
               name: it.title ]
        }

        def data = [ result: results ]
        render data as JSON
      }
      
      def gridlist() {}
      
    def jq_event_list = {
      def sortIndex = params.sidx ?: 'title'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = Event.createCriteria().list(max:maxRows, offset:rowOffset) {
		if (params.title)
			ilike('title',params.title)

		if (params.description)
				ilike('description',params.description)
		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.title,
            	    it.description
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_event = {
	      log.debug('In jq_event_edit:'+params)
	      def event = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add event sent
				
		  event = new Event(params)
		  event.updator=event.creator=springSecurityService.principal.username
		  if (! event.hasErrors() && event.save()) {
		    message = "Event Saved.."
		    id = event.id
		    state = "OK"
		  } else {
		    event.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save Event"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check event exists
			  event  = Event.get(it)
			  if (event) {
			    // delete event
			    if(!event.delete())
			    	{
				    event.errors.allErrors.each {
					log.debug("In jq_event_edit: error in deleting event:"+ it)
					}
			    	}
			    else {
				    message = "Deleted!!"
				    state = "OK"
			    }
			  }
		  	}
		  break;
		 default :
		  // edit action
		  // first retrieve the event by its ID
		  event = Event.get(params.id)
		  if (event) {
		    // set the properties according to passed in parameters
		    event.properties = params
			  event.updator = springSecurityService.principal.username
		    if (! event.hasErrors() && event.save()) {
		      message = "Event  ${event.id} Updated"
		      id = event.id
		      state = "OK"
		    } else {
			    event.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Event"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def jq_participant_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def event = null
	if(params.eventid)
		event=Event.get(params.eventid)
		
	def result = EventParticipant.createCriteria().list(max:maxRows, offset:rowOffset) {
		eq('event',event)

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.individual?.toString(),
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_participant = {
	      def participant = null
	      def message = ""
	      def state = "FAIL"
	      def id

		def event = null
		if(params.eventid)
			event=Event.get(params.eventid)

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add participant sent
		  //format the dates
		  params.departureTime = Date.parse('dd-MM-yyyy HH:mm',params.departureTime)
		  if(params.arrivalTime)
		  	params.arrivalTime = Date.parse('dd-MM-yyyy HH:mm',params.arrivalTime)
		  
		  participant = new EventParticipant(params)
		  participant.updator=participant.creator=springSecurityService.principal.username
		  if (! participant.hasErrors() && participant.save()) {
		    message = "Participant Saved.."
		    id = participant.id
		    state = "OK"
		  } else {
		    participant.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save Participant"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check participant exists
			  participant  = Participant.get(it)
			  if (participant) {
			    // delete participant
			    if(!participant.delete())
			    	{
				    participant.errors.allErrors.each {
					log.debug("In jq_participant_edit: error in deleting participant:"+ it)
					}
			    	}
			    else {
				    message = "Deleted!!"
				    state = "OK"
			    }
			  }
		  	}
		  break;
		 default :
		  // edit action
		  // first retrieve the participant by its ID
		  participant = Participant.get(params.id)
		  if (participant) {
		    // set the properties according to passed in parameters
		    participant.properties = params
			  participant.updator = springSecurityService.principal.username
		    if (! participant.hasErrors() && participant.save()) {
		      message = "Participant  ${participant.id} Updated"
		      id = participant.id
		      state = "OK"
		    } else {
			    participant.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Participant"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }      


}
