package ics

class EventDetailController {

    def springSecurityService
    
    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [eventDetailInstanceList: EventDetail.list(params), eventDetailInstanceTotal: EventDetail.count()]
    }

    def create = {
        def eventDetailInstance = new EventDetail()
        eventDetailInstance.properties = params
        return [eventDetailInstance: eventDetailInstance]
    }

    def save = {
	
	params.updator=params.creator=springSecurityService.principal.username

        def eventDetailInstance = new EventDetail(params)
        if (!eventDetailInstance.hasErrors() && eventDetailInstance.save()) {
            flash.message = "eventDetail.created"
            flash.args = [eventDetailInstance.id]
            flash.defaultMessage = "EventDetail ${eventDetailInstance.id} created"
            redirect(action: "show", id: eventDetailInstance.id)
        }
        else {
            render(view: "create", model: [eventDetailInstance: eventDetailInstance])
        }
    }

    def show = {
        def eventDetailInstance = EventDetail.get(params.id)
        if (!eventDetailInstance) {
            flash.message = "eventDetail.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventDetail not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [eventDetailInstance: eventDetailInstance]
        }
    }

    def edit = {
        def eventDetailInstance = EventDetail.get(params.id)
        if (!eventDetailInstance) {
            flash.message = "eventDetail.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventDetail not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [eventDetailInstance: eventDetailInstance]
        }
    }

    def update = {
        def eventDetailInstance = EventDetail.get(params.id)
        if (eventDetailInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (eventDetailInstance.version > version) {
                    
                    eventDetailInstance.errors.rejectValue("version", "eventDetail.optimistic.locking.failure", "Another user has updated this EventDetail while you were editing")
                    render(view: "edit", model: [eventDetailInstance: eventDetailInstance])
                    return
                }
            }
            params.updator=springSecurityService.principal.username
            eventDetailInstance.properties = params
            if (!eventDetailInstance.hasErrors() && eventDetailInstance.save()) {
                flash.message = "eventDetail.updated"
                flash.args = [params.id]
                flash.defaultMessage = "EventDetail ${params.id} updated"
                redirect(action: "show", id: eventDetailInstance.id)
            }
            else {
                render(view: "edit", model: [eventDetailInstance: eventDetailInstance])
            }
        }
        else {
            flash.message = "eventDetail.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventDetail not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def eventDetailInstance = EventDetail.get(params.id)
        if (eventDetailInstance) {
            try {
                eventDetailInstance.delete()
                flash.message = "eventDetail.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "EventDetail ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "eventDetail.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "EventDetail ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "eventDetail.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventDetail not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
