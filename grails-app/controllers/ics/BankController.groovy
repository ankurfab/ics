package ics
import org.codehaus.groovy.grails.commons.ConfigurationHolder

class BankController {
    def springSecurityService
    def exportService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if(params?.format && params.format != "html"){ 
        response.contentType = ConfigurationHolder.config.grails.mime.types[params.format] 
        response.setHeader("Content-disposition", "attachment; filename=bank.${params.extension}")
		
exportService.export(params.format, response.outputStream,Bank.list(params), [:], [:]) 
}
        [bankInstanceList: Bank.list(params), bankInstanceTotal: Bank.count()]
    }

    def create = {
        def bankInstance = new Bank()
        bankInstance.properties = params
        return [bankInstance: bankInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def bankInstance = new Bank(params)
        if (bankInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'bank.label', default: 'Bank'), bankInstance.id])}"
            redirect(action: "show", id: bankInstance.id)
        }
        else {
            render(view: "create", model: [bankInstance: bankInstance])
        }
    }

    def show = {
        def bankInstance = Bank.get(params.id)
        if (!bankInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'bank.label', default: 'Bank'), params.id])}"
            redirect(action: "list")
        }
        else {
            [bankInstance: bankInstance]
        }
    }

    def edit = {
        def bankInstance = Bank.get(params.id)
        if (!bankInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'bank.label', default: 'Bank'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [bankInstance: bankInstance]
        }
    }

    def update = {
        def bankInstance = Bank.get(params.id)
        if (bankInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (bankInstance.version > version) {
                    
                    bankInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'bank.label', default: 'Bank')] as Object[], "Another user has updated this Bank while you were editing")
                    render(view: "edit", model: [bankInstance: bankInstance])
                    return
                }
            }

	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            bankInstance.properties = params
            if (!bankInstance.hasErrors() && bankInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'bank.label', default: 'Bank'), bankInstance.id])}"
                redirect(action: "show", id: bankInstance.id)
            }
            else {
                render(view: "edit", model: [bankInstance: bankInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'bank.label', default: 'Bank'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def bankInstance = Bank.get(params.id)
        if (bankInstance) {
            try {
                bankInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'bank.label', default: 'Bank'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'bank.label', default: 'Bank'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'bank.label', default: 'Bank'), params.id])}"
            redirect(action: "list")
        }
    }
}
