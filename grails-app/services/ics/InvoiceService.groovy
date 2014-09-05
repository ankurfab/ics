package ics
import groovy.sql.Sql;
import org.codehaus.groovy.grails.plugins.springsecurity.*
import org.springframework.web.context.request.RequestContextHolder

class InvoiceService {

    def springSecurityService
    def individualService
    def receiptSequenceService
    def housekeepingService
    def dataSource
    
    def serviceMethod() {
    }
    
    def createInvoice(Map params) {	
	def invoice = new Invoice()
	invoice.properties = params
	if(!params.invoiceNumber)
		invoice.invoiceNumber = housekeepingService.getFY() +"/"+ receiptSequenceService.getNext("KITCHEN")
	if(!params.invoiceDate)
		invoice.invoiceDate = new Date()
	if(!params.from)
		invoice.preparedBy = Individual.findByLoginid(springSecurityService.principal.username)
	else
		{
		//check if existing individual or new
		try{
			invoice.preparedBy = Individual.get(params.from)
		}
		catch(Exception e)
		{}
		if(!invoice.preparedBy)
			invoice.preparedBy = individualService.createBasicIndividual([name:params.from,category:'VENDOR'])
		}
	if(!params.itemTotalAmount)
		invoice.itemTotalAmount = 0	
	if(!params.extraAmount)
		invoice.extraAmount = 0
	if(!params.discountAmount)
		invoice.discountAmount = 0
	if(!params.invoiceAmount)
		invoice.invoiceAmount = 0
	if(!params.status)
		invoice.status='DRAFT'	//hardcoded
	invoice.updator=invoice.creator=springSecurityService.principal.username    
    	if(!invoice.save())
    		invoice.errors.each {println it}
    	return invoice	
    }
    
    def getJsonCellsForPurchase(grails.orm.PagedResultList result) {
      def jsonCells = result.collect {
            [cell: [
            	    it.invoiceNumber,
            	    it.invoiceDate.format('dd-MM-yyyy'),
            	    it.preparedBy?.toString(),
            	    it.itemTotalAmount,
            	    it.itemTotalAmountWithTax,
            	    it.extraAmount,
            	    it.discountAmount,
            	    it.invoiceAmount,
            	    it.status,
            	    it.description,
            	    it.comments,
            	    it.mode,
            	    it.dueDate?.format('dd-MM-yyyy'),
            	    it.paymentReference?.toString(),
            	    it.preparedBy?.id
                ], id: it.id]
        }
      return jsonCells
    }
    
    def getJsonCellsForSales(grails.orm.PagedResultList result) {
      def jsonCells = result.collect {
            [cell: [
            	    it.invoiceNumber,
            	    it.invoiceDate.format('dd-MM-yyyy'),
            	    it.preparedBy?.toString(),
            	    it.departmentBy?.toString(),
            	    it.personTo,
            	    it.departmentTo?.toString(),
            	    it.dueDate?.format('dd-MM-yyyy'),
            	    it.itemTotalAmount,
            	    it.extraAmount,
            	    it.discountAmount,
            	    it.invoiceAmount,
            	    it.status,
            	    it.description,
            	    it.comments,
            	    it.mode,
            	    it.paymentReference?.toString(),
                ], id: it.id]
        }
      return jsonCells
    }
    
    def savePaymentReference(Map params) {	
	if(params.paymentDate)
		params.paymentDate = Date.parse('dd-MM-yyyy',params.paymentDate)
    	def paymentReference = new PaymentReference(params)
    	paymentReference.updator=paymentReference.creator=springSecurityService.principal.username    
    	if(!paymentReference.save())
    		paymentReference.errors.each {println it}
    	else
    		{
    		//saved the payment ref succsessfully
    		switch(params.idType) {
    			case "Assessment" :
    					def er = EventRegistration.get(params.erid)
    					if(er)
    						{
    						er.paymentReference = paymentReference
						if(!er.save())
							er.errors.each {println it}    						
    						}
    					break
    			default:
    				//Invoices being linked
				//now link it to the respective invoices
				def invoice
				def idList = params.invoiceids.tokenize(',')
				idList.each
				{
				  // check if exists
				  invoice  = Invoice.get(it)
				  if (invoice) {
				    // update
				    invoice.paymentReference = paymentReference
				    if(!invoice.save())
					{
					    invoice.errors.allErrors.each {
						log.debug("In savePaymentReference: error in updating invoice:"+ it)
						}
					}
				  }
				}
				break
    			}
    		}
    	return paymentReference	    	
    }
    
    def setCalculatedFields(InvoiceLineItem ili) {
    	//if rate is specified then set the total
    	if(ili.rate)
    		{
    		ili.totalWithoutTax = ili.qty*ili.rate
    		if(ili.taxRate)
    			ili.totalWithTax = ili.totalWithoutTax*(1+ili.taxRate/100)
    		else
    			ili.totalWithTax = ili.totalWithoutTax
    		}
    	else if(ili.totalWithoutTax) //if total is specified then set the calculate total
    		{
    		ili.rate = ili.totalWithoutTax/ili.qty
    		if(ili.taxRate)
    			ili.totalWithTax = ili.totalWithoutTax*(1+ili.taxRate/100)
    		else
    			ili.totalWithTax = ili.totalWithoutTax    		
    		}
    	else if(ili.totalWithTax) //if tax total is specified then set the calculate total, rate and taxrate
    		{
    		ili.totalWithoutTax = ili.totalWithTax/(1+ili.taxRate/100)
    		ili.rate = ili.totalWithoutTax/ili.qty
    		}
    	return ili
    }
    
    def checkTrip(Map params) {	
    	def message = ""
    	def purchaseTrip = PurchaseTrip.get(params.id)
    	if(purchaseTrip) {
    		//calculate the amounts as per invoices and cross check with Purchase Trip
		def sql = new Sql(dataSource);
    		def query = "select mode,sum(invoice_amount) amount from purchase_trip_invoice pti, invoice i where pti.purchase_trip_invoices_id="+ params.id+" and pti.invoice_id=i.id group by i.mode"; 
    		def results = sql.rows(query)
    		sql.close()
    		
    		//update the fields 
    		results.each{it->
    			switch(it.mode) {
    				case 'CASH':
    					purchaseTrip.cashPurchase = it.amount
    					break
    				case 'CREDIT':
    					purchaseTrip.creditPurchase = it.amount
    					break
    				default:
    					//@TODO: harcoded to donation
    					purchaseTrip.donationReceived = it.amount
    					break
    			}
    		}
    		
	    if(!purchaseTrip.save())
		{
		    purchaseTrip.errors.allErrors.each {
			log.debug("In checkTrip: error in updating purchaseTrip:"+ it)
			}
		}
		
    		message = results.toString()+" updated!!"
    		
    	}
    	return message	    	
    }
    
    def vendorReport(Map params) {
	def invoices = Invoice.createCriteria().list{
			eq('type','PURCHASE')
			ne('status','DRAFT')
			ne('status','CANCELLED')
			if(params.vendorid)
				preparedBy{eq('id',new Long(params.vendorid))}
			if(params.from)
				ge('invoiceDate',params.from)
			if(params.to)
				le('invoiceDate',params.to)
			preparedBy{
				order("legalName", "asc")
				}
			order("invoiceDate", "asc")
			}
	return invoices	
    }

    def paymentReport(Map params) {
	def invoices = Invoice.createCriteria().list{
			eq('type','PURCHASE')
			ne('status','DRAFT')
			ne('status','CANCELLED')
			eq('mode','CREDIT')
			if(params.vendorid)
				preparedBy{eq('id',new Long(params.vendorid))}
			if(params.from)
				ge('invoiceDate',params.from)
			if(params.to)
				le('invoiceDate',params.to)
			order("invoiceDate", "asc")
			}
	return invoices	
    }
    
    
}
