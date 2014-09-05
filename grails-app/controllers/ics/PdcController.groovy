package ics

class PdcController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if(!params.sort)
        	params.sort = "id"
        if(!params.order)
        	params.order = "desc"
        [pdcInstanceList: Pdc.list(params), pdcInstanceTotal: Pdc.count()]
    }

    def create = {
    	if(session.isReceiver==null)
    		{
		def individual = Individual.get(session.individualid)
		def flag=false
		individual?.individualRoles?.each{if (it.role.name == "Receiver") flag=true}
		if(flag)
			session.isReceiver = true
		else
			session.isReceiver = false
		}
	
        
        if(session.isReceiver)
        	{
		def pdcInstance = new Pdc()
		pdcInstance.properties = params
		return [pdcInstance: pdcInstance]
        	}
        else
        	{
        	flash.message = "PDC can be accepted only by a RECEIVER!!"
        	redirect(action: "list", params: params)
        	}
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

	params."issuedBy.id"= params."acIndividual_id"?:params."issuedBy.id"
	params."collectedBy.id"= params."acCollector_id"?:params."collectedBy.id"

	if(params.chequeDate)
		params.chequeDate = Date.parse('dd-MM-yyyy', params.chequeDate)

        def pdcInstance = new Pdc(params)
        pdcInstance.receivedBy = Individual.get(session.individualid)
        pdcInstance.receiptDate = new Date()
        pdcInstance.status = "PENDING"
        if (pdcInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'pdc.label', default: 'Pdc'), pdcInstance.id])}"
            redirect(action: "show", id: pdcInstance.id)
        }
        else {
            render(view: "create", model: [pdcInstance: pdcInstance])
        }
    }

    def show = {
        def pdcInstance = Pdc.get(params.id)
        if (!pdcInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pdc.label', default: 'Pdc'), params.id])}"
            redirect(action: "list")
        }
        else {
            [pdcInstance: pdcInstance]
        }
    }

    def edit = {
        def pdcInstance = Pdc.get(params.id)
        if (!pdcInstance || pdcInstance.status!='PENDING' || pdcInstance.receivedBy?.id!=session.individualid) {
            flash.message = "Only self created and PENDING PDCs can be edited!!"
            redirect(action: "list")
        }
        else {
            return [pdcInstance: pdcInstance]
        }
    }

    def update = {
        def pdcInstance = Pdc.get(params.id)
        if (pdcInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (pdcInstance.version > version) {
                    
                    pdcInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'pdc.label', default: 'Pdc')] as Object[], "Another user has updated this Pdc while you were editing")
                    render(view: "edit", model: [pdcInstance: pdcInstance])
                    return
                }
            }

		if (springSecurityService.isLoggedIn()) {
			params.updator=springSecurityService.principal.username
		}

		params."issuedBy.id"= params."acIndividual_id"?:pdcInstance.issuedBy.id
		params."collectedBy.id"= params."acCollector_id"?:pdcInstance.collectedBy.id

		if(params.chequeDate)
			params.chequeDate = Date.parse('dd-MM-yyyy', params.chequeDate)

            pdcInstance.properties = params
            
            if (!pdcInstance.hasErrors() && pdcInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'pdc.label', default: 'Pdc'), pdcInstance.id])}"
                redirect(action: "show", id: pdcInstance.id)
            }
            else {
                render(view: "edit", model: [pdcInstance: pdcInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pdc.label', default: 'Pdc'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def pdcInstance = Pdc.get(params.id)
        if (pdcInstance) {
            try {
		if (pdcInstance.status!='PENDING' || pdcInstance.receivedBy?.id!=session.individualid) {
		    flash.message = "Only self created and PENDING PDCs can be deleted!!"
		    redirect(action: "list")
		    return
		}
                pdcInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'pdc.label', default: 'Pdc'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'pdc.label', default: 'Pdc'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pdc.label', default: 'Pdc'), params.id])}"
            redirect(action: "list")
        }
    }

    def search = {
    	println "Search params in PDC"+params
	if(params.sChequeDate)
		params.sChequeDate = Date.parse('dd-MM-yyyy', params.sChequeDate)
	if(params.sReceiptDate)
		params.sReceiptDate = Date.parse('dd-MM-yyyy', params.sReceiptDate)


	    def criteria = Pdc.createCriteria()
	    def pdcList = criteria {
			and {
				if (params.sComments)
			    		like("comments", "%"+params.sComments+"%")
				if (params.sStatus)
			    		like("status", "%"+params.sStatus+"%")
			    		println 'params.sAmount='+params.sAmount
			    		
				if (params.sAmount)
			    		eq("amount", new BigDecimal(params.sAmount))
				if (params.sChequeDate)
			    		eq("chequeDate", params.sChequeDate)
				if (params.sReceiptDate)
			    		eq("receiptDate", params.sReceiptDate)
				if (params.sBranch)
			    		like("branch", "%"+params.sBranch+"%")
				if (params.sChequeNo)
			    		like("chequeNo", "%"+params.sChequeNo+"%")
				if (params.sCollector)
					{
					collectedBy {
						or
							{
							like("legalName", "%"+params.sCollector+"%")
							like("initiatedName", "%"+params.sCollector+"%")
							}
					    }
					}
				if (params.sReceiver)
					{
					receivedBy {
						or
							{
							like("legalName", "%"+params.sReceiver+"%")
							like("initiatedName", "%"+params.sReceiver+"%")
							}
					    }
					}
				if (params.sIssName)
					{
					issuedBy {
						or
							{
							like("legalName", "%"+params.sIssName+"%")
							like("initiatedName", "%"+params.sIssName+"%")
							}
					    }
					}
				if (params.sBankName)
					{
					bank {
						like("name", "%"+params.sBankName+"%")
					    }
					}
				}
			order(params.sort?:"id", params.order?:"asc")
       		 	}
                render(view: "list", model: [pdcInstanceList: pdcList, searchparams: params, search: true])
    }
    
    def createdonation = {
	    def pdc = Pdc.get(params.id)
		if (springSecurityService.isLoggedIn()) {
			params.updator=springSecurityService.principal.username
		}
		pdc.status = "SUBMITTED"
		pdc.save(flush:true)
		
		def donation = new Donation()
		donation.donatedBy = pdc.issuedBy
		donation.amount = pdc.amount
		donation.currency = "INR"
		donation.mode = PaymentMode.findByName("Cheque")
		donation.bank = pdc.bank
		donation.bankBranch = pdc.branch
		donation.chequeNo = pdc.chequeNo
		donation.chequeDate = pdc.chequeDate
		donation.collectedBy = pdc.collectedBy
		donation.creator = springSecurityService.principal.username
		donation.updator = springSecurityService.principal.username
		donation.donationDate = new Date()
		donation.donationReceipt = Receipt.get(1)
		donation.fundReceiptDate = new Date()
		donation.scheme = pdc.scheme
		donation.receivedBy = pdc.receivedBy
		if(pdc.comments)
			donation.paymentComments = pdc.comments
		
		
		if(!donation.save(flush:true))
		{
			println "Some problem in auto creating donation"+donation
			if(donation.hasErrors()) {
			    donation.errors.each {
				  println it
			    }
			}
		}
		
		redirect(controller: "donation", action: "edit", id: donation.id)
		
    }

}
