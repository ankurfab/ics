package ics

class SalaryRecordController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [salaryRecordInstanceList: SalaryRecord.list(params), salaryRecordInstanceTotal: SalaryRecord.count()]
    }

    def create = {
        def salaryRecordInstance = new SalaryRecord()
        salaryRecordInstance.properties = params
        return [salaryRecordInstance: salaryRecordInstance]
    }

    def save = {
        def salaryRecordInstance = new SalaryRecord(params)
        if (!salaryRecordInstance.hasErrors() && salaryRecordInstance.save()) {
            flash.message = "salaryRecord.created"
            flash.args = [salaryRecordInstance.id]
            flash.defaultMessage = "SalaryRecord ${salaryRecordInstance.id} created"
            redirect(action: "show", id: salaryRecordInstance.id)
        }
        else {
            render(view: "create", model: [salaryRecordInstance: salaryRecordInstance])
        }
    }

    def show = {
        def salaryRecordInstance = SalaryRecord.get(params.id)
        if (!salaryRecordInstance) {
            flash.message = "salaryRecord.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "SalaryRecord not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [salaryRecordInstance: salaryRecordInstance]
        }
    }

    def edit = {
        def salaryRecordInstance = SalaryRecord.get(params.id)
        if (!salaryRecordInstance) {
            flash.message = "salaryRecord.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "SalaryRecord not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [salaryRecordInstance: salaryRecordInstance]
        }
    }

    def update = {
        def salaryRecordInstance = SalaryRecord.get(params.id)
        if (salaryRecordInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (salaryRecordInstance.version > version) {
                    
                    salaryRecordInstance.errors.rejectValue("version", "salaryRecord.optimistic.locking.failure", "Another user has updated this SalaryRecord while you were editing")
                    render(view: "edit", model: [salaryRecordInstance: salaryRecordInstance])
                    return
                }
            }
            salaryRecordInstance.properties = params
            if (!salaryRecordInstance.hasErrors() && salaryRecordInstance.save()) {
                flash.message = "salaryRecord.updated"
                flash.args = [params.id]
                flash.defaultMessage = "SalaryRecord ${params.id} updated"
                redirect(action: "show", id: salaryRecordInstance.id)
            }
            else {
                render(view: "edit", model: [salaryRecordInstance: salaryRecordInstance])
            }
        }
        else {
            flash.message = "salaryRecord.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "SalaryRecord not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def salaryRecordInstance = SalaryRecord.get(params.id)
        if (salaryRecordInstance) {
            try {
                salaryRecordInstance.delete()
                flash.message = "salaryRecord.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "SalaryRecord ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "salaryRecord.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "SalaryRecord ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "salaryRecord.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "SalaryRecord not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
