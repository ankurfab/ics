package ics

class EventSevaGroupAllotmentController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [eventSevaGroupAllotmentInstanceList: EventSevaGroupAllotment.list(params), eventSevaGroupAllotmentInstanceTotal: EventSevaGroupAllotment.count()]
    }

    def create = {
        def eventSevaGroupAllotmentInstance = new EventSevaGroupAllotment()
        eventSevaGroupAllotmentInstance.properties = params
        return [eventSevaGroupAllotmentInstance: eventSevaGroupAllotmentInstance]
    }

    def save = {
        def eventSevaGroupAllotmentInstance = new EventSevaGroupAllotment(params)
        if (!eventSevaGroupAllotmentInstance.hasErrors() && eventSevaGroupAllotmentInstance.save()) {
            flash.message = "eventSevaGroupAllotment.created"
            flash.args = [eventSevaGroupAllotmentInstance.id]
            flash.defaultMessage = "EventSevaGroupAllotment ${eventSevaGroupAllotmentInstance.id} created"
            redirect(action: "show", id: eventSevaGroupAllotmentInstance.id)
        }
        else {
            render(view: "create", model: [eventSevaGroupAllotmentInstance: eventSevaGroupAllotmentInstance])
        }
    }

    def show = {
        def eventSevaGroupAllotmentInstance = EventSevaGroupAllotment.get(params.id)
        if (!eventSevaGroupAllotmentInstance) {
            flash.message = "eventSevaGroupAllotment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventSevaGroupAllotment not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [eventSevaGroupAllotmentInstance: eventSevaGroupAllotmentInstance]
        }
    }

    def edit = {
        def eventSevaGroupAllotmentInstance = EventSevaGroupAllotment.get(params.id)
        if (!eventSevaGroupAllotmentInstance) {
            flash.message = "eventSevaGroupAllotment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventSevaGroupAllotment not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [eventSevaGroupAllotmentInstance: eventSevaGroupAllotmentInstance]
        }
    }

    def update = {
        def eventSevaGroupAllotmentInstance = EventSevaGroupAllotment.get(params.id)
        if (eventSevaGroupAllotmentInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (eventSevaGroupAllotmentInstance.version > version) {
                    
                    eventSevaGroupAllotmentInstance.errors.rejectValue("version", "eventSevaGroupAllotment.optimistic.locking.failure", "Another user has updated this EventSevaGroupAllotment while you were editing")
                    render(view: "edit", model: [eventSevaGroupAllotmentInstance: eventSevaGroupAllotmentInstance])
                    return
                }
            }
            eventSevaGroupAllotmentInstance.properties = params
            if (!eventSevaGroupAllotmentInstance.hasErrors() && eventSevaGroupAllotmentInstance.save()) {
                flash.message = "eventSevaGroupAllotment.updated"
                flash.args = [params.id]
                flash.defaultMessage = "EventSevaGroupAllotment ${params.id} updated"
                redirect(action: "show", id: eventSevaGroupAllotmentInstance.id)
            }
            else {
                render(view: "edit", model: [eventSevaGroupAllotmentInstance: eventSevaGroupAllotmentInstance])
            }
        }
        else {
            flash.message = "eventSevaGroupAllotment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventSevaGroupAllotment not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def eventSevaGroupAllotmentInstance = EventSevaGroupAllotment.get(params.id)
        if (eventSevaGroupAllotmentInstance) {
            try {
                eventSevaGroupAllotmentInstance.delete()
                flash.message = "eventSevaGroupAllotment.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "EventSevaGroupAllotment ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "eventSevaGroupAllotment.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "EventSevaGroupAllotment ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "eventSevaGroupAllotment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventSevaGroupAllotment not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
