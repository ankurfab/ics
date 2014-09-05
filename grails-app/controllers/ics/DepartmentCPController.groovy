package ics

class DepartmentCPController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [departmentCPInstanceList: DepartmentCP.list(params), departmentCPInstanceTotal: DepartmentCP.count()]
    }

    def create = {
        def departmentCPInstance = new DepartmentCP()
        departmentCPInstance.properties = params
        return [departmentCPInstance: departmentCPInstance]
    }

    def save = {
        def departmentCPInstance = new DepartmentCP(params)
        if (!departmentCPInstance.hasErrors() && departmentCPInstance.save()) {
            flash.message = "departmentCP.created"
            flash.args = [departmentCPInstance.id]
            flash.defaultMessage = "DepartmentCP ${departmentCPInstance.id} created"
            redirect(action: "show", id: departmentCPInstance.id)
        }
        else {
            render(view: "create", model: [departmentCPInstance: departmentCPInstance])
        }
    }

    def show = {
        def departmentCPInstance = DepartmentCP.get(params.id)
        if (!departmentCPInstance) {
            flash.message = "departmentCP.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DepartmentCP not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [departmentCPInstance: departmentCPInstance]
        }
    }

    def edit = {
        def departmentCPInstance = DepartmentCP.get(params.id)
        if (!departmentCPInstance) {
            flash.message = "departmentCP.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DepartmentCP not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [departmentCPInstance: departmentCPInstance]
        }
    }

    def update = {
        def departmentCPInstance = DepartmentCP.get(params.id)
        if (departmentCPInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (departmentCPInstance.version > version) {
                    
                    departmentCPInstance.errors.rejectValue("version", "departmentCP.optimistic.locking.failure", "Another user has updated this DepartmentCP while you were editing")
                    render(view: "edit", model: [departmentCPInstance: departmentCPInstance])
                    return
                }
            }
            departmentCPInstance.properties = params
            if (!departmentCPInstance.hasErrors() && departmentCPInstance.save()) {
                flash.message = "departmentCP.updated"
                flash.args = [params.id]
                flash.defaultMessage = "DepartmentCP ${params.id} updated"
                redirect(action: "show", id: departmentCPInstance.id)
            }
            else {
                render(view: "edit", model: [departmentCPInstance: departmentCPInstance])
            }
        }
        else {
            flash.message = "departmentCP.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DepartmentCP not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def departmentCPInstance = DepartmentCP.get(params.id)
        if (departmentCPInstance) {
            try {
                departmentCPInstance.delete()
                flash.message = "departmentCP.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "DepartmentCP ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "departmentCP.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "DepartmentCP ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "departmentCP.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DepartmentCP not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
