package ics

class AttributeValueController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [attributeValueInstanceList: AttributeValue.list(params), attributeValueInstanceTotal: AttributeValue.count()]
    }

    def create = {
        def attributeValueInstance = new AttributeValue()
        attributeValueInstance.properties = params
        return [attributeValueInstance: attributeValueInstance]
    }

    def save = {
        def attributeValueInstance = new AttributeValue(params)
        if (!attributeValueInstance.hasErrors() && attributeValueInstance.save()) {
            flash.message = "attributeValue.created"
            flash.args = [attributeValueInstance.id]
            flash.defaultMessage = "AttributeValue ${attributeValueInstance.id} created"
            redirect(action: "show", id: attributeValueInstance.id)
        }
        else {
            render(view: "create", model: [attributeValueInstance: attributeValueInstance])
        }
    }

    def show = {
        def attributeValueInstance = AttributeValue.get(params.id)
        if (!attributeValueInstance) {
            flash.message = "attributeValue.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "AttributeValue not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [attributeValueInstance: attributeValueInstance]
        }
    }

    def edit = {
        def attributeValueInstance = AttributeValue.get(params.id)
        if (!attributeValueInstance) {
            flash.message = "attributeValue.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "AttributeValue not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [attributeValueInstance: attributeValueInstance]
        }
    }

    def update = {
        def attributeValueInstance = AttributeValue.get(params.id)
        if (attributeValueInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (attributeValueInstance.version > version) {
                    
                    attributeValueInstance.errors.rejectValue("version", "attributeValue.optimistic.locking.failure", "Another user has updated this AttributeValue while you were editing")
                    render(view: "edit", model: [attributeValueInstance: attributeValueInstance])
                    return
                }
            }
            attributeValueInstance.properties = params
            if (!attributeValueInstance.hasErrors() && attributeValueInstance.save()) {
                flash.message = "attributeValue.updated"
                flash.args = [params.id]
                flash.defaultMessage = "AttributeValue ${params.id} updated"
                redirect(action: "show", id: attributeValueInstance.id)
            }
            else {
                render(view: "edit", model: [attributeValueInstance: attributeValueInstance])
            }
        }
        else {
            flash.message = "attributeValue.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "AttributeValue not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def attributeValueInstance = AttributeValue.get(params.id)
        if (attributeValueInstance) {
            try {
                attributeValueInstance.delete()
                flash.message = "attributeValue.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "AttributeValue ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "attributeValue.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "AttributeValue ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "attributeValue.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "AttributeValue not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
