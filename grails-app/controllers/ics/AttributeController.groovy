package ics

class AttributeController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [attributeInstanceList: Attribute.list(params), attributeInstanceTotal: Attribute.count()]
    }

    def create = {
        def attributeInstance = new Attribute()
        attributeInstance.properties = params
        return [attributeInstance: attributeInstance]
    }

    def save = {
        def attributeInstance = new Attribute(params)
        if (!attributeInstance.hasErrors() && attributeInstance.save()) {
            flash.message = "attribute.created"
            flash.args = [attributeInstance.id]
            flash.defaultMessage = "Attribute ${attributeInstance.id} created"
            redirect(action: "show", id: attributeInstance.id)
        }
        else {
            render(view: "create", model: [attributeInstance: attributeInstance])
        }
    }

    def show = {
        def attributeInstance = Attribute.get(params.id)
        if (!attributeInstance) {
            flash.message = "attribute.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Attribute not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [attributeInstance: attributeInstance]
        }
    }

    def edit = {
        def attributeInstance = Attribute.get(params.id)
        if (!attributeInstance) {
            flash.message = "attribute.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Attribute not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [attributeInstance: attributeInstance]
        }
    }

    def update = {
        def attributeInstance = Attribute.get(params.id)
        if (attributeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (attributeInstance.version > version) {
                    
                    attributeInstance.errors.rejectValue("version", "attribute.optimistic.locking.failure", "Another user has updated this Attribute while you were editing")
                    render(view: "edit", model: [attributeInstance: attributeInstance])
                    return
                }
            }
            attributeInstance.properties = params
            if (!attributeInstance.hasErrors() && attributeInstance.save()) {
                flash.message = "attribute.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Attribute ${params.id} updated"
                redirect(action: "show", id: attributeInstance.id)
            }
            else {
                render(view: "edit", model: [attributeInstance: attributeInstance])
            }
        }
        else {
            flash.message = "attribute.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Attribute not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def attributeInstance = Attribute.get(params.id)
        if (attributeInstance) {
            try {
                attributeInstance.delete()
                flash.message = "attribute.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Attribute ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "attribute.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Attribute ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "attribute.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Attribute not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
