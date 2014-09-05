package ics

import grails.converters.*


class ReceiptBookController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def housekeepingService
    def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
    println 'params='+params
        params.max = Math.min(params.max ? params.int('max') : 25, 100)
        [receiptBookInstanceList: ReceiptBook.list(params), receiptBookInstanceTotal: ReceiptBook.count()]
    }

    def create = {
        def receiptBookInstance = new ReceiptBook()
        receiptBookInstance.properties = params
        return [receiptBookInstance: receiptBookInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def receiptBookInstance = new ReceiptBook(params)
        if (receiptBookInstance.save(flush: true)) {
            //create the receipts as well
		for (int j=0;j<params.numPages?.toInteger();j++)
		{
			def receipt = new Receipt()
			receipt.receiptBook = receiptBookInstance
			receipt.receiptNumber = (receiptBookInstance.bookSeries?:"")+(receiptBookInstance.startingReceiptNumber+j)
			//receipt.isBlank = true
			receipt.creator = springSecurityService.principal.username
			receipt.updator = springSecurityService.principal.username
			if(!receipt.save(flush:true))

			{
			    println "Some problem in saving receipts for RB "+receiptBookInstance+" Leaf no: "+j
			    if(receipt.hasErrors()) {
				receipt.errors.each {
				  println it
				}
			    }
			}

		}
            
            
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'receiptBook.label', default: 'ReceiptBook'), receiptBookInstance.id])}"
            redirect(action: "show", id: receiptBookInstance.id)
        }
        else {
            render(view: "create", model: [receiptBookInstance: receiptBookInstance])
        }
    }

    def show = {
        def receiptBookInstance = ReceiptBook.get(params.id)
        def totalCollection = 0
        println "ReceiptBook.receipts = "+ receiptBookInstance.receipts
        
        //for(int i=0; i<receiptBookInstance?.receipts?.size(); i++)
        	println "ReceiptBook.receipts = "+ receiptBookInstance?.receipts
        	
		//def rcpts = receiptBook.receipts.sort{ it.id }
		receiptBookInstance.receipts.eachWithIndex{ item, pos ->
			println 'item='+item
			println 'donation='+(ics.Donation.findByDonationReceipt(item))?.amount
			if ((ics.Donation.findByDonationReceipt(item))?.amount)
				totalCollection = totalCollection + (ics.Donation.findByDonationReceipt(item))?.amount
			println 'totalCollection='+totalCollection
 		}
        	
        	
        if (!receiptBookInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'receiptBook.label', default: 'ReceiptBook'), params.id])}"
            redirect(action: "list")
        }
        else {
            [receiptBookInstance: receiptBookInstance, totalCollection: totalCollection]
        }
    }

    def edit = {
        def receiptBookInstance = ReceiptBook.get(params.id)
        if (!receiptBookInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'receiptBook.label', default: 'ReceiptBook'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [receiptBookInstance: receiptBookInstance]
        }
    }

    def update = {
        def receiptBookInstance = ReceiptBook.get(params.id)
        if (receiptBookInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (receiptBookInstance.version > version) {
                    
                    receiptBookInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'receiptBook.label', default: 'ReceiptBook')] as Object[], "Another user has updated this ReceiptBook while you were editing")
                    render(view: "edit", model: [receiptBookInstance: receiptBookInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            receiptBookInstance.properties = params
            if (!receiptBookInstance.hasErrors() && receiptBookInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'receiptBook.label', default: 'ReceiptBook'), receiptBookInstance.id])}"
                redirect(action: "list", id: receiptBookInstance.id)
            }
            else {
                render(view: "edit", model: [receiptBookInstance: receiptBookInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'receiptBook.label', default: 'ReceiptBook'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def receiptBookInstance = ReceiptBook.get(params.id)
        if (receiptBookInstance) {
            try {
            	//delete all receipts for the receipt book
            	//println 'receiptBookInstance.receipts='+receiptBookInstance.receipts
            	println '------------in delete---------------'
            	/*for (receipts in params)
            	{
            		println receiptBookInstance.receipts
            	}
            	def recpts = []
	    		receiptBookInstance.receipts.each{recpts.push(it.receiptBookInstance.receipts)}
	    		println 'recpts='+recpts
            	receiptBookInstance.receipts.delete(flush: true)
            	flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'receipts.label', default: 'Receipt'), params.id])}"*/
                
                receiptBookInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'receiptBook.label', default: 'ReceiptBook'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'receiptBook.label', default: 'ReceiptBook'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'receiptBook.label', default: 'ReceiptBook'), params.id])}"
            redirect(action: "list")
        }
    }

    def bulksave = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

    	//params.isBlank = true

        def receiptBookInstance = new ReceiptBook(params)

        if (receiptBookInstance.save(flush: true)) {
            def lastRBId = housekeepingService.bulkReceicpt(receiptBookInstance,params.bookLastSerialNumber)
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'receiptBook.label', default: 'ReceiptBook'), receiptBookInstance.id])}"
            redirect(action: "show", id: lastRBId)
        }
        else {
            render(view: "create", model: [receiptBookInstance: receiptBookInstance])
        }
    }

	def ajaxGetReceiptBooks = {
		//def receiptBooks = ReceiptBook.findAllByCategoryAndIsBlank(params.category,true)
		def receiptBooks = ReceiptBook.findAllByCategoryAndStatus(params.category,"Blank")
		println "receiptBooks="+receiptBooks
		render receiptBooks as JSON
	}

	def ajaxGetReceiptBookCategoriesAsJSON = {
	
			def catc = ReceiptBook.createCriteria()
			def category = catc.list { projections { 
					//distinct("category") 
					 distinct 'category', 'cat'}
					 order 'cat'
					 }

		response.setHeader("Cache-Control", "no-store")
		def query = params.query
		def list = (query) ?  category.findAll {  it.contains(query)   } : category

		def results = list.collect {
		    [   id: it,
			name: it ]
		}
		def data = [ result: results ]
		render data as JSON
	}

	def ajaxGetReceiptBookAsJSON = {
		response.setHeader("Cache-Control", "no-store")
		def query = params.query
		def list = (query) ?  ReceiptBook.findAllByBookSerialNumberLikeAndCategory("%"+params.query+"%",params.dependsOn) : ReceiptBook.findAllByCategory(params.dependsOn)

		def results = list.collect {
		    [   id: it.id,
			name: it.toString() ]
		}
		def data = [ result: results ]
		render data as JSON
	}

    def search = {
    def criteria = ReceiptBook.createCriteria()
    def receiptBookList = criteria {
			and {
				if (params.category!=null && params.category.trim().length()>0)
			    		like("category", "%"+params.category+"%")
				if (params.comments!=null && params.comments.trim().length()>0)
			    		like("comments", "%"+params.comments+"%")
				if (params.status!=null && params.status.trim().length()>0)
			    		like("status", "%"+params.status+"%")
				if (params.bookSerialNumber!=null && params.bookSerialNumber.trim().length()>0)
					    eq('bookSerialNumber',new Integer(params.bookSerialNumber))
				}
       		 	}
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
       		 	
                render(view: "list", model: [receiptBookInstanceList: receiptBookList, receiptBookInstanceTotal: receiptBookList.size()])

    }

}
