package ics

class DevoteeCategoryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [devoteeCategoryInstanceList: DevoteeCategory.list(params), devoteeCategoryInstanceTotal: DevoteeCategory.count()]
    }

    def create = {
        def devoteeCategoryInstance = new DevoteeCategory()
        devoteeCategoryInstance.properties = params
        return [devoteeCategoryInstance: devoteeCategoryInstance]
    }

    def save = {
        def devoteeCategoryInstance = new DevoteeCategory(params)
        if (devoteeCategoryInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'devoteeCategory.label', default: 'DevoteeCategory'), devoteeCategoryInstance.id])}"
            redirect(action: "show", id: devoteeCategoryInstance.id)
        }
        else {
            render(view: "create", model: [devoteeCategoryInstance: devoteeCategoryInstance])
        }
    }

    def show = {
        def devoteeCategoryInstance = DevoteeCategory.get(params.id)
        if (!devoteeCategoryInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'devoteeCategory.label', default: 'DevoteeCategory'), params.id])}"
            redirect(action: "list")
        }
        else {
            [devoteeCategoryInstance: devoteeCategoryInstance]
        }
    }

    def edit = {
        def devoteeCategoryInstance = DevoteeCategory.get(params.id)
        if (!devoteeCategoryInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'devoteeCategory.label', default: 'DevoteeCategory'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [devoteeCategoryInstance: devoteeCategoryInstance]
        }
    }

    def update = {
        def devoteeCategoryInstance = DevoteeCategory.get(params.id)
        if (devoteeCategoryInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (devoteeCategoryInstance.version > version) {
                    
                    devoteeCategoryInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'devoteeCategory.label', default: 'DevoteeCategory')] as Object[], "Another user has updated this DevoteeCategory while you were editing")
                    render(view: "edit", model: [devoteeCategoryInstance: devoteeCategoryInstance])
                    return
                }
            }
            devoteeCategoryInstance.properties = params
            if (!devoteeCategoryInstance.hasErrors() && devoteeCategoryInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'devoteeCategory.label', default: 'DevoteeCategory'), devoteeCategoryInstance.id])}"
                redirect(action: "show", id: devoteeCategoryInstance.id)
            }
            else {
                render(view: "edit", model: [devoteeCategoryInstance: devoteeCategoryInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'devoteeCategory.label', default: 'DevoteeCategory'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def devoteeCategoryInstance = DevoteeCategory.get(params.id)
        if (devoteeCategoryInstance) {
            try {
                devoteeCategoryInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'devoteeCategory.label', default: 'DevoteeCategory'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'devoteeCategory.label', default: 'DevoteeCategory'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'devoteeCategory.label', default: 'DevoteeCategory'), params.id])}"
            redirect(action: "list")
        }
    }
}
