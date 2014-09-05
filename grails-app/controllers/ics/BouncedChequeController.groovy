package ics

class BouncedChequeController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        if(!params.sort)
        	params.sort = "id"
        if(!params.order)
        	params.order = "desc"
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [bouncedChequeInstanceList: BouncedCheque.list(params), bouncedChequeInstanceTotal: BouncedCheque.count()]
    }

    def create = {
        def bouncedChequeInstance = new BouncedCheque()
        bouncedChequeInstance.properties = params
        return [bouncedChequeInstance: bouncedChequeInstance]
    }

    def save = {
    
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator
	if(params.chequeDate)
		params.chequeDate = Date.parse('dd-MM-yyyy', params.chequeDate)
	if(params.presentedOn)
		params.presentedOn = Date.parse('dd-MM-yyyy', params.presentedOn)

        
        //bouncedChequeInstance.bankName = 
        /*println 'params.bank.id='+params.bank.id
        def bank = Bank.findById(params.bank.id)
        
        println 'bank='+bank
        //params.bankName = bankInstance?.name
        params.bankName = bank.name
        println params*/
        
        def bouncedChequeInstance = new BouncedCheque(params)
        bouncedChequeInstance.status = "OPEN"
        println 'bouncedChequeInstance.id='+bouncedChequeInstance.id
        if (bouncedChequeInstance.save(flush: true)) {
            /* Already being marked while creating from donation
            //mark the donation as bounced
            def donation = bouncedChequeInstance.donation
            donation.status="BOUNCED"
            donation.save(flush:true)*/
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'bouncedCheque.label', default: 'Dishonoured Cheque'), bouncedChequeInstance.id])}"
            redirect(action: "show", id: bouncedChequeInstance.id)
        }
        else {
            render(view: "create", model: [bouncedChequeInstance: bouncedChequeInstance])
        }
    }

    def show = {
        def bouncedChequeInstance = BouncedCheque.get(params.id)
        if (!bouncedChequeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'bouncedCheque.label', default: 'BouncedCheque'), params.id])}"
            redirect(action: "list")
        }
        else {
            [bouncedChequeInstance: bouncedChequeInstance]
        }
    }

    def edit = {
        def bouncedChequeInstance = BouncedCheque.get(params.id)
        if (!bouncedChequeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'bouncedCheque.label', default: 'BouncedCheque'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [bouncedChequeInstance: bouncedChequeInstance]
        }
    }

    def update = {
        def bouncedChequeInstance = BouncedCheque.get(params.id)
	if(params.chequeDate)
		params.chequeDate = Date.parse('dd-MM-yyyy', params.chequeDate)
	if(params.presentedOn)
		params.presentedOn = Date.parse('dd-MM-yyyy', params.presentedOn)
        
        if (bouncedChequeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (bouncedChequeInstance.version > version) {
                    
                    bouncedChequeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'bouncedCheque.label', default: 'BouncedCheque')] as Object[], "Another user has updated this BouncedCheque while you were editing")
                    render(view: "edit", model: [bouncedChequeInstance: bouncedChequeInstance])
                    return
                }
            }
            if (bouncedChequeInstance.status=="CLOSED" || bouncedChequeInstance.status=="DELETED") {
            		flash.message = "Can not edit a CLOSED or DELETED entry!!"
                    render(view: "show", model: [bouncedChequeInstance: bouncedChequeInstance])
                    return
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            bouncedChequeInstance.properties = params
            if (!bouncedChequeInstance.hasErrors() && bouncedChequeInstance.save(flush: true)) {
            	if(bouncedChequeInstance.status=="CLOSED")
			{
                            //mark the donation as bounced
		            def donation = bouncedChequeInstance.donation
		            donation.status=null
		            donation.save(flush:true)
		        }

                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'bouncedCheque.label', default: 'BouncedCheque'), bouncedChequeInstance.id])}"
                redirect(action: "show", id: bouncedChequeInstance.id)
            }
            else {
                render(view: "edit", model: [bouncedChequeInstance: bouncedChequeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'bouncedCheque.label', default: 'BouncedCheque'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def bouncedChequeInstance = BouncedCheque.get(params.id)
        if (bouncedChequeInstance) {
            try {
                //soft delete
                bouncedChequeInstance.status = "DELETED"
                bouncedChequeInstance.save()
                //bouncedChequeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'bouncedCheque.label', default: 'BouncedCheque'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'bouncedCheque.label', default: 'BouncedCheque'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'bouncedCheque.label', default: 'BouncedCheque'), params.id])}"
            redirect(action: "list")
        }
    }
}
