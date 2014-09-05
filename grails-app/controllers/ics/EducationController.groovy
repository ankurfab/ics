package ics

class EducationController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [educationInstanceList: Education.list(params), educationInstanceTotal: Education.count()]
    }

    def create = {
        def educationInstance = new Education()
        educationInstance.properties = params
        return [educationInstance: educationInstance]
    }

    def save = {
        def educationInstance = new Education(params)
        if (!educationInstance.hasErrors() && educationInstance.save()) {
            flash.message = "education.created"
            flash.args = [educationInstance.id]
            flash.defaultMessage = "Education ${educationInstance.id} created"
            redirect(action: "show", id: educationInstance.id)
        }
        else {
            render(view: "create", model: [educationInstance: educationInstance])
        }
    }

    def show = {
        def educationInstance = Education.get(params.id)
        if (!educationInstance) {
            flash.message = "education.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Education not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [educationInstance: educationInstance]
        }
    }

    def edit = {
        def educationInstance = Education.get(params.id)
        if (!educationInstance) {
            flash.message = "education.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Education not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [educationInstance: educationInstance]
        }
    }

    def update = {
        def educationInstance = Education.get(params.id)
        if (educationInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (educationInstance.version > version) {
                    
                    educationInstance.errors.rejectValue("version", "education.optimistic.locking.failure", "Another user has updated this Education while you were editing")
                    render(view: "edit", model: [educationInstance: educationInstance])
                    return
                }
            }
            educationInstance.properties = params
            if (!educationInstance.hasErrors() && educationInstance.save()) {
                flash.message = "education.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Education ${params.id} updated"
                redirect(action: "show", id: educationInstance.id)
            }
            else {
                render(view: "edit", model: [educationInstance: educationInstance])
            }
        }
        else {
            flash.message = "education.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Education not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def educationInstance = Education.get(params.id)
        if (educationInstance) {
            try {
                educationInstance.delete()
                flash.message = "education.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Education ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "education.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Education ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "education.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Education not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
