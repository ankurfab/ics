package ics

class CommsProviderController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [commsProviderInstanceList: CommsProvider.list(params), commsProviderInstanceTotal: CommsProvider.count()]
    }

    def create = {
        def commsProviderInstance = new CommsProvider()
        commsProviderInstance.properties = params
        return [commsProviderInstance: commsProviderInstance]
    }

    def save = {
        def commsProviderInstance = new CommsProvider(params)
        if (!commsProviderInstance.hasErrors() && commsProviderInstance.save()) {
            flash.message = "commsProvider.created"
            flash.args = [commsProviderInstance.id]
            flash.defaultMessage = "CommsProvider ${commsProviderInstance.id} created"
            redirect(action: "show", id: commsProviderInstance.id)
        }
        else {
            render(view: "create", model: [commsProviderInstance: commsProviderInstance])
        }
    }

    def show = {
        def commsProviderInstance = CommsProvider.get(params.id)
        if (!commsProviderInstance) {
            flash.message = "commsProvider.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CommsProvider not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [commsProviderInstance: commsProviderInstance]
        }
    }

    def edit = {
        def commsProviderInstance = CommsProvider.get(params.id)
        if (!commsProviderInstance) {
            flash.message = "commsProvider.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CommsProvider not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [commsProviderInstance: commsProviderInstance]
        }
    }

    def update = {
        def commsProviderInstance = CommsProvider.get(params.id)
        if (commsProviderInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (commsProviderInstance.version > version) {
                    
                    commsProviderInstance.errors.rejectValue("version", "commsProvider.optimistic.locking.failure", "Another user has updated this CommsProvider while you were editing")
                    render(view: "edit", model: [commsProviderInstance: commsProviderInstance])
                    return
                }
            }
            commsProviderInstance.properties = params
            if (!commsProviderInstance.hasErrors() && commsProviderInstance.save()) {
                flash.message = "commsProvider.updated"
                flash.args = [params.id]
                flash.defaultMessage = "CommsProvider ${params.id} updated"
                redirect(action: "show", id: commsProviderInstance.id)
            }
            else {
                render(view: "edit", model: [commsProviderInstance: commsProviderInstance])
            }
        }
        else {
            flash.message = "commsProvider.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CommsProvider not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def commsProviderInstance = CommsProvider.get(params.id)
        if (commsProviderInstance) {
            try {
                commsProviderInstance.delete()
                flash.message = "commsProvider.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "CommsProvider ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "commsProvider.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "CommsProvider ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "commsProvider.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CommsProvider not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
