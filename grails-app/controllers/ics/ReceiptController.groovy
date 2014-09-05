package ics
import grails.converters.JSON

class ReceiptController {
    def springSecurityService


    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [receiptInstanceList: Receipt.list(params), receiptInstanceTotal: Receipt.count()]
    }

    def create = {
        def receiptInstance = new Receipt()
        receiptInstance.properties = params
        return [receiptInstance: receiptInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def receiptInstance = new Receipt(params)
        if (receiptInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'receipt.label', default: 'Receipt'), receiptInstance.id])}"
            redirect(action: "show", id: receiptInstance.id)
        }
        else {
            render(view: "create", model: [receiptInstance: receiptInstance])
        }
    }

    def show = {
        def receiptInstance = Receipt.get(params.id)
        if (!receiptInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'receipt.label', default: 'Receipt'), params.id])}"
            redirect(action: "list")
        }
        else {
            [receiptInstance: receiptInstance]
        }
    }

    def edit = {
        def receiptInstance = Receipt.get(params.id)
        if (!receiptInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'receipt.label', default: 'Receipt'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [receiptInstance: receiptInstance]
        }
    }

    def update = {
        def receiptInstance = Receipt.get(params.id)
        if (receiptInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (receiptInstance.version > version) {
                    
                    receiptInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'receipt.label', default: 'Receipt')] as Object[], "Another user has updated this Receipt while you were editing")
                    render(view: "edit", model: [receiptInstance: receiptInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            receiptInstance.properties = params
            if (!receiptInstance.hasErrors() && receiptInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'receipt.label', default: 'Receipt'), receiptInstance.id])}"
                redirect(action: "show", id: receiptInstance.id)
            }
            else {
                render(view: "edit", model: [receiptInstance: receiptInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'receipt.label', default: 'Receipt'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def receiptInstance = Receipt.get(params.id)
        if (receiptInstance) {
            try {
                receiptInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'receipt.label', default: 'Receipt'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'receipt.label', default: 'Receipt'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'receipt.label', default: 'Receipt'), params.id])}"
            redirect(action: "list")
        }
    }
    
    def findReceiptsAsJSON = {
	def query = params.query
	def receipts = Receipt.findAllByReceiptNumberLikeAndIsBlank("%"+query+"%", true,[sort:"receiptNumber", order:"asc"])
        response.setHeader("Cache-Control", "no-store")

        def results = receipts.collect {
            [  id: it.id,
               name: it.toString() ]
        }

        def data = [ result: results ]
        render data as JSON
    }

    def ajaxGetReceiptAsJSON = {
	def query = params.query
	def receipts = Receipt.findAllByReceiptNumberLike("%"+query+"%", [sort:"receiptNumber", order:"asc"])
        response.setHeader("Cache-Control", "no-store")

        def results = receipts.collect {
            [  id: it.id,
               name: it.toString() ]
        }

        def data = [ result: results ]
        render data as JSON
    }


	def ajaxGetReceipts = {
	println 'params:'+params
		def rb = ReceiptBook.get(params.id)
		def receipt = (Receipt.findAllByReceiptBook(rb)).toString()
		println 'receipts:'+receipt
		render receipt as JSON
		//render receipts
		//return [receipts: receipts]
	}

    
}
