package ics

class CropController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [cropInstanceList: Crop.list(params), cropInstanceTotal: Crop.count()]
    }

    def create = {
        def cropInstance = new Crop()
        cropInstance.properties = params
        return [cropInstance: cropInstance]
    }

    def save = {
        def cropInstance = new Crop(params)
        if (!cropInstance.hasErrors() && cropInstance.save()) {
            flash.message = "crop.created"
            flash.args = [cropInstance.id]
            flash.defaultMessage = "Crop ${cropInstance.id} created"
            redirect(action: "show", id: cropInstance.id)
        }
        else {
            render(view: "create", model: [cropInstance: cropInstance])
        }
    }

    def show = {
        def cropInstance = Crop.get(params.id)
        if (!cropInstance) {
            flash.message = "crop.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Crop not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [cropInstance: cropInstance]
        }
    }

    def edit = {
        def cropInstance = Crop.get(params.id)
        if (!cropInstance) {
            flash.message = "crop.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Crop not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [cropInstance: cropInstance]
        }
    }

    def update = {
        def cropInstance = Crop.get(params.id)
        if (cropInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (cropInstance.version > version) {
                    
                    cropInstance.errors.rejectValue("version", "crop.optimistic.locking.failure", "Another user has updated this Crop while you were editing")
                    render(view: "edit", model: [cropInstance: cropInstance])
                    return
                }
            }
            cropInstance.properties = params
            if (!cropInstance.hasErrors() && cropInstance.save()) {
                flash.message = "crop.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Crop ${params.id} updated"
                redirect(action: "show", id: cropInstance.id)
            }
            else {
                render(view: "edit", model: [cropInstance: cropInstance])
            }
        }
        else {
            flash.message = "crop.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Crop not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def cropInstance = Crop.get(params.id)
        if (cropInstance) {
            try {
                cropInstance.delete()
                flash.message = "crop.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Crop ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "crop.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Crop ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "crop.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Crop not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
