package ics

class PeriodController {

    def springSecurityService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [periodInstanceList: Period.list(params), periodInstanceTotal: Period.count()]
    }

    def create = {
        def periodInstance = new Period()
        periodInstance.properties = params
        return [periodInstance: periodInstance]
    }

    def save = {
	params.creator=springSecurityService.principal.username
	params.updator=params.creator

        def periodInstance = new Period(params)
        if (!periodInstance.hasErrors() && periodInstance.save()) {
            flash.message = "period.created"
            flash.args = [periodInstance.id]
            flash.defaultMessage = "Period ${periodInstance.id} created"
            redirect(action: "show", id: periodInstance.id)
        }
        else {
            render(view: "create", model: [periodInstance: periodInstance])
        }
    }

    def show = {
        def periodInstance = Period.get(params.id)
        if (!periodInstance) {
            flash.message = "period.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Period not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [periodInstance: periodInstance]
        }
    }

    def edit = {
        def periodInstance = Period.get(params.id)
        if (!periodInstance) {
            flash.message = "period.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Period not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [periodInstance: periodInstance]
        }
    }

    def update = {
        def periodInstance = Period.get(params.id)
        if (periodInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (periodInstance.version > version) {
                    
                    periodInstance.errors.rejectValue("version", "period.optimistic.locking.failure", "Another user has updated this Period while you were editing")
                    render(view: "edit", model: [periodInstance: periodInstance])
                    return
                }
            }
	    params.updator=springSecurityService.principal.username
            periodInstance.properties = params
            if (!periodInstance.hasErrors() && periodInstance.save()) {
                flash.message = "period.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Period ${params.id} updated"
                redirect(action: "show", id: periodInstance.id)
            }
            else {
                render(view: "edit", model: [periodInstance: periodInstance])
            }
        }
        else {
            flash.message = "period.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Period not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def periodInstance = Period.get(params.id)
        if (periodInstance) {
            try {
                periodInstance.delete()
                flash.message = "period.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Period ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "period.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Period ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "period.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Period not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
