package ics

class TemplateController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [templateInstanceList: Template.list(params), templateInstanceTotal: Template.count()]
    }

    def create = {
        def templateInstance = new Template()
        templateInstance.properties = params
        return [templateInstance: templateInstance]
    }

    def save = {
        def templateInstance = new Template(params)
        if (!templateInstance.hasErrors() && templateInstance.save()) {
            flash.message = "template.created"
            flash.args = [templateInstance.id]
            flash.defaultMessage = "Template ${templateInstance.id} created"
            redirect(action: "show", id: templateInstance.id)
        }
        else {
            render(view: "create", model: [templateInstance: templateInstance])
        }
    }

    def show = {
        def templateInstance = Template.get(params.id)
        if (!templateInstance) {
            flash.message = "template.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Template not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [templateInstance: templateInstance]
        }
    }

    def edit = {
        def templateInstance = Template.get(params.id)
        if (!templateInstance) {
            flash.message = "template.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Template not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [templateInstance: templateInstance]
        }
    }

    def update = {
        def templateInstance = Template.get(params.id)
        if (templateInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (templateInstance.version > version) {
                    
                    templateInstance.errors.rejectValue("version", "template.optimistic.locking.failure", "Another user has updated this Template while you were editing")
                    render(view: "edit", model: [templateInstance: templateInstance])
                    return
                }
            }
            templateInstance.properties = params
            if (!templateInstance.hasErrors() && templateInstance.save()) {
                flash.message = "template.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Template ${params.id} updated"
                redirect(action: "show", id: templateInstance.id)
            }
            else {
                render(view: "edit", model: [templateInstance: templateInstance])
            }
        }
        else {
            flash.message = "template.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Template not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def templateInstance = Template.get(params.id)
        if (templateInstance) {
            try {
                templateInstance.delete()
                flash.message = "template.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Template ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "template.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Template ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "template.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Template not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
