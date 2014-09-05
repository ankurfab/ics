package ics

class EventSevaAllotmentController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [eventSevaAllotmentInstanceList: EventSevaAllotment.list(params), eventSevaAllotmentInstanceTotal: EventSevaAllotment.count()]
    }

    def create = {
        def eventSevaAllotmentInstance = new EventSevaAllotment()
        eventSevaAllotmentInstance.properties = params
        return [eventSevaAllotmentInstance: eventSevaAllotmentInstance]
    }

    def save = {
        def eventSevaAllotmentInstance = new EventSevaAllotment(params)
        if (!eventSevaAllotmentInstance.hasErrors() && eventSevaAllotmentInstance.save()) {
            flash.message = "eventSevaAllotment.created"
            flash.args = [eventSevaAllotmentInstance.id]
            flash.defaultMessage = "EventSevaAllotment ${eventSevaAllotmentInstance.id} created"
            redirect(action: "show", id: eventSevaAllotmentInstance.id)
        }
        else {
            render(view: "create", model: [eventSevaAllotmentInstance: eventSevaAllotmentInstance])
        }
    }

    def show = {
        def eventSevaAllotmentInstance = EventSevaAllotment.get(params.id)
        if (!eventSevaAllotmentInstance) {
            flash.message = "eventSevaAllotment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventSevaAllotment not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [eventSevaAllotmentInstance: eventSevaAllotmentInstance]
        }
    }

    def edit = {
        def eventSevaAllotmentInstance = EventSevaAllotment.get(params.id)
        if (!eventSevaAllotmentInstance) {
            flash.message = "eventSevaAllotment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventSevaAllotment not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [eventSevaAllotmentInstance: eventSevaAllotmentInstance]
        }
    }

    def update = {
        def eventSevaAllotmentInstance = EventSevaAllotment.get(params.id)
        if (eventSevaAllotmentInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (eventSevaAllotmentInstance.version > version) {
                    
                    eventSevaAllotmentInstance.errors.rejectValue("version", "eventSevaAllotment.optimistic.locking.failure", "Another user has updated this EventSevaAllotment while you were editing")
                    render(view: "edit", model: [eventSevaAllotmentInstance: eventSevaAllotmentInstance])
                    return
                }
            }
            eventSevaAllotmentInstance.properties = params
            if (!eventSevaAllotmentInstance.hasErrors() && eventSevaAllotmentInstance.save()) {
                flash.message = "eventSevaAllotment.updated"
                flash.args = [params.id]
                flash.defaultMessage = "EventSevaAllotment ${params.id} updated"
                redirect(action: "show", id: eventSevaAllotmentInstance.id)
            }
            else {
                render(view: "edit", model: [eventSevaAllotmentInstance: eventSevaAllotmentInstance])
            }
        }
        else {
            flash.message = "eventSevaAllotment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventSevaAllotment not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def eventSevaAllotmentInstance = EventSevaAllotment.get(params.id)
        if (eventSevaAllotmentInstance) {
            try {
                eventSevaAllotmentInstance.delete()
                flash.message = "eventSevaAllotment.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "EventSevaAllotment ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "eventSevaAllotment.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "EventSevaAllotment ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "eventSevaAllotment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventSevaAllotment not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
