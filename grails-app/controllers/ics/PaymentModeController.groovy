package ics

class PaymentModeController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [paymentModeInstanceList: PaymentMode.list(params), paymentModeInstanceTotal: PaymentMode.count()]
    }

    def create = {
        def paymentModeInstance = new PaymentMode()
        paymentModeInstance.properties = params
        return [paymentModeInstance: paymentModeInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def paymentModeInstance = new PaymentMode(params)
        if (paymentModeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'paymentMode.label', default: 'PaymentMode'), paymentModeInstance.id])}"
            redirect(action: "show", id: paymentModeInstance.id)
        }
        else {
            render(view: "create", model: [paymentModeInstance: paymentModeInstance])
        }
    }

    def show = {
        def paymentModeInstance = PaymentMode.get(params.id)
        if (!paymentModeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'paymentMode.label', default: 'PaymentMode'), params.id])}"
            redirect(action: "list")
        }
        else {
            [paymentModeInstance: paymentModeInstance]
        }
    }

    def edit = {
        def paymentModeInstance = PaymentMode.get(params.id)
        if (!paymentModeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'paymentMode.label', default: 'PaymentMode'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [paymentModeInstance: paymentModeInstance]
        }
    }

    def update = {
        def paymentModeInstance = PaymentMode.get(params.id)
        if (paymentModeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (paymentModeInstance.version > version) {
                    
                    paymentModeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'paymentMode.label', default: 'PaymentMode')] as Object[], "Another user has updated this PaymentMode while you were editing")
                    render(view: "edit", model: [paymentModeInstance: paymentModeInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            paymentModeInstance.properties = params
            if (!paymentModeInstance.hasErrors() && paymentModeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'paymentMode.label', default: 'PaymentMode'), paymentModeInstance.id])}"
                redirect(action: "show", id: paymentModeInstance.id)
            }
            else {
                render(view: "edit", model: [paymentModeInstance: paymentModeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'paymentMode.label', default: 'PaymentMode'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def paymentModeInstance = PaymentMode.get(params.id)
        if (paymentModeInstance) {
            try {
                paymentModeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'paymentMode.label', default: 'PaymentMode'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'paymentMode.label', default: 'PaymentMode'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'paymentMode.label', default: 'PaymentMode'), params.id])}"
            redirect(action: "list")
        }
    }
}
