package ics

class MbProfileController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [mbProfileInstanceList: MbProfile.list(params), mbProfileInstanceTotal: MbProfile.count()]
    }

    def create = {
        def mbProfileInstance = new MbProfile()
        mbProfileInstance.properties = params
        return [mbProfileInstance: mbProfileInstance]
    }

    def save = {
        def mbProfileInstance = new MbProfile(params)
        if (!mbProfileInstance.hasErrors() && mbProfileInstance.save()) {
            flash.message = "mbProfile.created"
            flash.args = [mbProfileInstance.id]
            flash.defaultMessage = "MbProfile ${mbProfileInstance.id} created"
            redirect(action: "show", id: mbProfileInstance.id)
        }
        else {
            render(view: "create", model: [mbProfileInstance: mbProfileInstance])
        }
    }

    def show = {
        def mbProfileInstance = MbProfile.get(params.id)
        if (!mbProfileInstance) {
            flash.message = "mbProfile.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "MbProfile not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [mbProfileInstance: mbProfileInstance]
        }
    }

    def edit = {
        def mbProfileInstance = MbProfile.get(params.id)
        if (!mbProfileInstance) {
            flash.message = "mbProfile.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "MbProfile not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [mbProfileInstance: mbProfileInstance]
        }
    }

    def update = {
        def mbProfileInstance = MbProfile.get(params.id)
        if (mbProfileInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (mbProfileInstance.version > version) {
                    
                    mbProfileInstance.errors.rejectValue("version", "mbProfile.optimistic.locking.failure", "Another user has updated this MbProfile while you were editing")
                    render(view: "edit", model: [mbProfileInstance: mbProfileInstance])
                    return
                }
            }
            mbProfileInstance.properties = params
            if (!mbProfileInstance.hasErrors() && mbProfileInstance.save()) {
                flash.message = "mbProfile.updated"
                flash.args = [params.id]
                flash.defaultMessage = "MbProfile ${params.id} updated"
                redirect(action: "show", id: mbProfileInstance.id)
            }
            else {
                render(view: "edit", model: [mbProfileInstance: mbProfileInstance])
            }
        }
        else {
            flash.message = "mbProfile.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "MbProfile not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def mbProfileInstance = MbProfile.get(params.id)
        if (mbProfileInstance) {
            try {
                mbProfileInstance.delete()
                flash.message = "mbProfile.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "MbProfile ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "mbProfile.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "MbProfile ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "mbProfile.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "MbProfile not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
