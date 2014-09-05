package ics

class CostCategoryController {
    def springSecurityService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [costCategoryInstanceList: CostCategory.list(params), costCategoryInstanceTotal: CostCategory.count()]
    }

    def create = {
        def costCategoryInstance = new CostCategory()
        costCategoryInstance.properties = params
        return [costCategoryInstance: costCategoryInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def costCategoryInstance = new CostCategory(params)
        if (!costCategoryInstance.hasErrors() && costCategoryInstance.save()) {
            flash.message = "costCategory.created"
            flash.args = [costCategoryInstance.id]
            flash.defaultMessage = "CostCategory ${costCategoryInstance.id} created"
            redirect(action: "show", id: costCategoryInstance.id)
        }
        else {
            render(view: "create", model: [costCategoryInstance: costCategoryInstance])
        }
    }

    def show = {
        def costCategoryInstance = CostCategory.get(params.id)
        if (!costCategoryInstance) {
            flash.message = "costCategory.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CostCategory not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [costCategoryInstance: costCategoryInstance]
        }
    }

    def edit = {
        def costCategoryInstance = CostCategory.get(params.id)
        if (!costCategoryInstance) {
            flash.message = "costCategory.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CostCategory not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [costCategoryInstance: costCategoryInstance]
        }
    }

    def update = {
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator=""

        def costCategoryInstance = CostCategory.get(params.id)
        if (costCategoryInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (costCategoryInstance.version > version) {
                    
                    costCategoryInstance.errors.rejectValue("version", "costCategory.optimistic.locking.failure", "Another user has updated this CostCategory while you were editing")
                    render(view: "edit", model: [costCategoryInstance: costCategoryInstance])
                    return
                }
            }
            costCategoryInstance.properties = params
            if (!costCategoryInstance.hasErrors() && costCategoryInstance.save()) {
                flash.message = "costCategory.updated"
                flash.args = [params.id]
                flash.defaultMessage = "CostCategory ${params.id} updated"
                redirect(action: "show", id: costCategoryInstance.id)
            }
            else {
                render(view: "edit", model: [costCategoryInstance: costCategoryInstance])
            }
        }
        else {
            flash.message = "costCategory.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CostCategory not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def costCategoryInstance = CostCategory.get(params.id)
        if (costCategoryInstance) {
            try {
                costCategoryInstance.delete()
                flash.message = "costCategory.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "CostCategory ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "costCategory.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "CostCategory ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "costCategory.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CostCategory not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
