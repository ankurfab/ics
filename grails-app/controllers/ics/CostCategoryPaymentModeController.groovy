package ics

class CostCategoryPaymentModeController {
    def springSecurityService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [costCategoryPaymentModeInstanceList: CostCategoryPaymentMode.list(params), costCategoryPaymentModeInstanceTotal: CostCategoryPaymentMode.count()]
    }

    def create = {
        def costCategoryPaymentModeInstance = new CostCategoryPaymentMode()
        costCategoryPaymentModeInstance.properties = params
        return [costCategoryPaymentModeInstance: costCategoryPaymentModeInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def costCategoryPaymentModeInstance = new CostCategoryPaymentMode(params)
        if (!costCategoryPaymentModeInstance.hasErrors() && costCategoryPaymentModeInstance.save()) {
            flash.message = "costCategoryPaymentMode.created"
            flash.args = [costCategoryPaymentModeInstance.id]
            flash.defaultMessage = "CostCategoryPaymentMode ${costCategoryPaymentModeInstance.id} created"
            redirect(action: "show", id: costCategoryPaymentModeInstance.id)
        }
        else {
            render(view: "create", model: [costCategoryPaymentModeInstance: costCategoryPaymentModeInstance])
        }
    }

    def show = {
        def costCategoryPaymentModeInstance = CostCategoryPaymentMode.get(params.id)
        if (!costCategoryPaymentModeInstance) {
            flash.message = "costCategoryPaymentMode.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CostCategoryPaymentMode not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [costCategoryPaymentModeInstance: costCategoryPaymentModeInstance]
        }
    }

    def edit = {
        def costCategoryPaymentModeInstance = CostCategoryPaymentMode.get(params.id)
        if (!costCategoryPaymentModeInstance) {
            flash.message = "costCategoryPaymentMode.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CostCategoryPaymentMode not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [costCategoryPaymentModeInstance: costCategoryPaymentModeInstance]
        }
    }

    def update = {
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator=""

        def costCategoryPaymentModeInstance = CostCategoryPaymentMode.get(params.id)
        if (costCategoryPaymentModeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (costCategoryPaymentModeInstance.version > version) {
                    
                    costCategoryPaymentModeInstance.errors.rejectValue("version", "costCategoryPaymentMode.optimistic.locking.failure", "Another user has updated this CostCategoryPaymentMode while you were editing")
                    render(view: "edit", model: [costCategoryPaymentModeInstance: costCategoryPaymentModeInstance])
                    return
                }
            }
            costCategoryPaymentModeInstance.properties = params
            if (!costCategoryPaymentModeInstance.hasErrors() && costCategoryPaymentModeInstance.save()) {
                flash.message = "costCategoryPaymentMode.updated"
                flash.args = [params.id]
                flash.defaultMessage = "CostCategoryPaymentMode ${params.id} updated"
                redirect(action: "show", id: costCategoryPaymentModeInstance.id)
            }
            else {
                render(view: "edit", model: [costCategoryPaymentModeInstance: costCategoryPaymentModeInstance])
            }
        }
        else {
            flash.message = "costCategoryPaymentMode.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CostCategoryPaymentMode not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def costCategoryPaymentModeInstance = CostCategoryPaymentMode.get(params.id)
        if (costCategoryPaymentModeInstance) {
            try {
                costCategoryPaymentModeInstance.delete()
                flash.message = "costCategoryPaymentMode.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "CostCategoryPaymentMode ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "costCategoryPaymentMode.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "CostCategoryPaymentMode ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "costCategoryPaymentMode.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CostCategoryPaymentMode not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
