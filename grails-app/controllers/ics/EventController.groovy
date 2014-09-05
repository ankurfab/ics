package ics

import grails.converters.JSON
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
    	if(params.startDate)
			params.startDate = Date.parse('dd-MM-yyyy HH:mm', params.startDate)
	if(params.endDate)
		params.endDate = Date.parse('dd-MM-yyyy HH:mm', params.endDate)
    
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


}
