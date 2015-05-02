package ics

class BatchItemController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [batchItemInstanceList: BatchItem.list(params), batchItemInstanceTotal: BatchItem.count()]
    }

    def create = {
        def batchItemInstance = new BatchItem()
        batchItemInstance.properties = params
        return [batchItemInstance: batchItemInstance]
    }

    def save = {
        def batchItemInstance = new BatchItem(params)
        if (!batchItemInstance.hasErrors() && batchItemInstance.save()) {
            flash.message = "batchItem.created"
            flash.args = [batchItemInstance.id]
            flash.defaultMessage = "BatchItem ${batchItemInstance.id} created"
            redirect(action: "show", id: batchItemInstance.id)
        }
        else {
            render(view: "create", model: [batchItemInstance: batchItemInstance])
        }
    }

    def show = {
        def batchItemInstance = BatchItem.get(params.id)
        if (!batchItemInstance) {
            flash.message = "batchItem.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "BatchItem not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [batchItemInstance: batchItemInstance]
        }
    }

    def edit = {
        def batchItemInstance = BatchItem.get(params.id)
        if (!batchItemInstance) {
            flash.message = "batchItem.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "BatchItem not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [batchItemInstance: batchItemInstance]
        }
    }

    def update = {
        def batchItemInstance = BatchItem.get(params.id)
        if (batchItemInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (batchItemInstance.version > version) {
                    
                    batchItemInstance.errors.rejectValue("version", "batchItem.optimistic.locking.failure", "Another user has updated this BatchItem while you were editing")
                    render(view: "edit", model: [batchItemInstance: batchItemInstance])
                    return
                }
            }
            batchItemInstance.properties = params
            if (!batchItemInstance.hasErrors() && batchItemInstance.save()) {
                flash.message = "batchItem.updated"
                flash.args = [params.id]
                flash.defaultMessage = "BatchItem ${params.id} updated"
                redirect(action: "show", id: batchItemInstance.id)
            }
            else {
                render(view: "edit", model: [batchItemInstance: batchItemInstance])
            }
        }
        else {
            flash.message = "batchItem.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "BatchItem not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def batchItemInstance = BatchItem.get(params.id)
        if (batchItemInstance) {
            try {
                batchItemInstance.delete()
                flash.message = "batchItem.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "BatchItem ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "batchItem.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "BatchItem ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "batchItem.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "BatchItem not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
