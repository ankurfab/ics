package ics

class LeaveRecordController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [leaveRecordInstanceList: LeaveRecord.list(params), leaveRecordInstanceTotal: LeaveRecord.count()]
    }

    def create = {
        def leaveRecordInstance = new LeaveRecord()
        leaveRecordInstance.properties = params
        return [leaveRecordInstance: leaveRecordInstance]
    }

    def save = {
        def leaveRecordInstance = new LeaveRecord(params)
        if (!leaveRecordInstance.hasErrors() && leaveRecordInstance.save()) {
            flash.message = "leaveRecord.created"
            flash.args = [leaveRecordInstance.id]
            flash.defaultMessage = "LeaveRecord ${leaveRecordInstance.id} created"
            redirect(action: "show", id: leaveRecordInstance.id)
        }
        else {
            render(view: "create", model: [leaveRecordInstance: leaveRecordInstance])
        }
    }

    def show = {
        def leaveRecordInstance = LeaveRecord.get(params.id)
        if (!leaveRecordInstance) {
            flash.message = "leaveRecord.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "LeaveRecord not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [leaveRecordInstance: leaveRecordInstance]
        }
    }

    def edit = {
        def leaveRecordInstance = LeaveRecord.get(params.id)
        if (!leaveRecordInstance) {
            flash.message = "leaveRecord.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "LeaveRecord not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [leaveRecordInstance: leaveRecordInstance]
        }
    }

    def update = {
        def leaveRecordInstance = LeaveRecord.get(params.id)
        if (leaveRecordInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (leaveRecordInstance.version > version) {
                    
                    leaveRecordInstance.errors.rejectValue("version", "leaveRecord.optimistic.locking.failure", "Another user has updated this LeaveRecord while you were editing")
                    render(view: "edit", model: [leaveRecordInstance: leaveRecordInstance])
                    return
                }
            }
            leaveRecordInstance.properties = params
            if (!leaveRecordInstance.hasErrors() && leaveRecordInstance.save()) {
                flash.message = "leaveRecord.updated"
                flash.args = [params.id]
                flash.defaultMessage = "LeaveRecord ${params.id} updated"
                redirect(action: "show", id: leaveRecordInstance.id)
            }
            else {
                render(view: "edit", model: [leaveRecordInstance: leaveRecordInstance])
            }
        }
        else {
            flash.message = "leaveRecord.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "LeaveRecord not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def leaveRecordInstance = LeaveRecord.get(params.id)
        if (leaveRecordInstance) {
            try {
                leaveRecordInstance.delete()
                flash.message = "leaveRecord.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "LeaveRecord ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "leaveRecord.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "LeaveRecord ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "leaveRecord.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "LeaveRecord not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
