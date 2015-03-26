package ics

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import grails.converters.JSON

class InvoiceController {

    def springSecurityService
    def invoiceService

    def index = { redirect(action: "gridlist", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def salesList = {
    }

    def purchaseList = {
    }

    def jq_invoice_list = {
      log.debug("Inside jq_invoice_list with params : "+params)
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
      
      def invoiceList=[]
	if(params.'purchaseTrip.id')
		{
		invoiceList = PurchaseTrip.get(params.'purchaseTrip.id').invoices?.collect{it.id}
		}
      
      

	def result = Invoice.createCriteria().list(max:maxRows, offset:rowOffset) {
		if(params.type=='PURCHASE')
			{
			if(invoiceList.size()>0)
				'in'('id',PurchaseTrip.get(params.'purchaseTrip.id').invoices?.collect{it.id})
			else if(params.'purchaseTrip.id')
				eq('id',new Long(-1))
			}
		eq('type',params.type)
		if (params.invoiceNumber)
			ilike('invoiceNumber','%'+params.invoiceNumber + '%')
		if (params.invoiceDate)
			ge('invoiceDate',Date.parse('dd-MM-yyyy',params.invoiceDate))
		if (params.from)
			preparedBy{or{ilike('legalName','%'+params.from + '%') ilike('initiatedName','%'+params.from + '%')}}
		if (params.'departmentBy.id')
			departmentBy{eq('id',new Long(params.'departmentBy.id'))}
		if (params.personTo)
			ilike('personTo','%'+params.personTo + '%')
		if (params.'departmentTo.id')
			departmentTo{eq('id',new Long(params.'departmentTo.id'))}
		if (params.dueDate)
			le('dueDate',Date.parse('dd-MM-yyyy',params.dueDate))
		if (params.itemTotalAmount)
			ge('itemTotalAmount',new BigDecimal(params.itemTotalAmount))
		if (params.itemTotalAmountWithTax)
			ge('itemTotalAmountWithTax',new BigDecimal(params.itemTotalAmountWithTax))
		if (params.extraAmount)
			ge('extraAmount',new BigDecimal(params.extraAmount))
		if (params.discountAmount)
			ge('discountAmount',new BigDecimal(params.discountAmount))
		if (params.invoiceAmount)
			ge('invoiceAmount',new BigDecimal(params.invoiceAmount))
		if (params.status)
			eq('status',params.status)
		if (params.description)
			ilike('description','%'+params.description + '%')
		if (params.comments)
			ilike('comments','%'+params.comments + '%')
		if (params.mode)
			eq('mode',params.mode)
		if (params.paymentReference)
			paymentReference{ilike('details','%'+params.paymentReference + '%')}

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells
      switch(params.type) {
      	case 'SALES': 
      		jsonCells = invoiceService.getJsonCellsForSales(result)
      		break
      	case 'PURCHASE':
      		jsonCells = invoiceService.getJsonCellsForPurchase(result)
      		break
      	default:
      		break
      	
      }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_invoice = {
	      log.debug('In jq_invoice_edit:'+params)
	      def invoice = null
	      def message = ""
	      def state = "FAIL"
	      def id

		if(params.dueDate)
			params.dueDate = Date.parse('dd-MM-yyyy',params.dueDate)
		if(params.invoiceDate)
			params.invoiceDate = Date.parse('dd-MM-yyyy',params.invoiceDate)

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add invoice sent
		  invoice = invoiceService.createInvoice(params)
		  if (! invoice.hasErrors()) {
		    message = "Invoice Saved.."
		    id = invoice.id
		    state = "OK"
		    //incase it was a purchase invoice, update the trip as well
		    if(params.type=='PURCHASE')
		    	{
		    	def purchaseTrip = PurchaseTrip.get(params.'purchaseTrip.id')
		    	if(purchaseTrip)
		    		{
		    		purchaseTrip.invoices.add(invoice)
		    		if(!purchaseTrip.save())
		    			purchaseTrip.errors.allErrors.each {
								log.debug(it)
						}
		    		}
		    	
		    	}
		  } else {
		    invoice.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save Invoice"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check invoice exists
			  invoice  = Invoice.get(it)
			  if (invoice) {
			    // delete invoice
			    if(!invoice.delete())
			    	{
				    invoice.errors.allErrors.each {
					log.debug("In jq_invoice_edit: error in deleting invoice:"+ it)
					}
			    	}
			    else {
				    message = "Deleted!!"
				    state = "OK"
			    }
			  }
		  	}
		  break;
		 default :
		  // edit action
		  // first retrieve the invoice by its ID
		  invoice = Invoice.get(params.id)
		  if (invoice) {
		    // set the properties according to passed in parameters
		    //@TODO: remove vendor and payment reference
		    params.remove('from')
		    params.remove('paymentReference')
		    if(params.'from.id')
		    	params.'preparedBy.id'=params.'from.id'
		    invoice.properties = params
		    invoice.updator = springSecurityService.principal.username
		    //update calculated fields
		    invoice.itemTotalAmount = 0
		    invoice.itemTotalAmountWithTax = 0
		    invoice.lineItems?.each{
		    		invoice.itemTotalAmount += (it.qty*it.rate)
		    		invoice.itemTotalAmountWithTax += (it.qty*it.rate*(1+(it.taxRate?:0)/100)) 
		    		}
		    invoice.invoiceAmount = invoice.itemTotalAmountWithTax + invoice.extraAmount - invoice.discountAmount
		    //also check status
		    if(invoice.status=='PREPARED' && invoice.mode=="CASH")
		    	invoice.status='PAID'	//since alread paid in cash
		    if (! invoice.hasErrors() && invoice.save()) {
		      message = "Invoice  ${invoice.toString()} Updated"
		      id = invoice.id
		      state = "OK"
		    } else {
			    invoice.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Invoice"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def jq_lineitem_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def invoice = null
	if(params.invoiceid)
		invoice=Invoice.get(params.invoiceid)
		
	def result = InvoiceLineItem.createCriteria().list(max:maxRows, offset:rowOffset) {
		eq('invoice',invoice)
		if (params.itemname)
			item{ilike('name',params.itemname + '%')}
		if (params.qty)
			eq('qty',new BigDecimal(params.qty))
		if (params.unitSize)
			eq('unitSize',new BigDecimal(params.unitSize))
		if (params.unit)
			eq('unit',params.unit)
		if (params.rate)
			eq('rate',new BigDecimal(params.rate))
		if (params.description)
			ilike('description','%'+params.description + '%')
			
		if(sortIndex=='itemname')
			item{order('name', sortOrder)}
		else
			order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.item.toString(),
           	    it.qty,
           	    it.unitSize,
            	    it.unit?.toString(),
            	    it.rate,
            	    it.taxRate,
            	    it.totalWithoutTax,
            	    it.totalWithTax,
            	    it.description,
            	    it.item.id
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_lineitem = {
	      log.debug('In jq_edit_lineitem:'+params)
	      def lineItem = null
	      def message = ""
	      def state = "FAIL"
	      def id,item

	  //format the dates
	  if(params.dateFrom)
		  params.dateFrom = Date.parse('dd-MM-yyyy HH:mm',params.dateFrom)
	  if(params.dateTill)
		params.dateTill = Date.parse('dd-MM-yyyy HH:mm',params.dateTill)

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add lineItem sent
		  if(!params.rate && params.'item.id') {
			def masterItem = Item.get(params.'item.id')
			params.rate=masterItem?.rate?:0
			params.taxRate=masterItem?.taxRate?:0
			}
		  //first add item if not existing
		def newItem = false
		if(!params.'item.id')
			{
				//create this item
				item = new Item()
				item.name = params.itemname
				item.otherNames = params.otherNames
				item.category = params.category
				item.variety = params.variety
				item.brand = params.brand
				item.updator=item.creator=springSecurityService.principal.username
				if(!item.save())
				    item.errors.allErrors.each {
					log.debug(it)
					}
				else
					newItem = true

			}
		  lineItem = new InvoiceLineItem(params)	  	
		  if(newItem)
		  	lineItem.item = item
		  lineItem = invoiceService.setCalculatedFields(lineItem)
		  lineItem.updator=lineItem.creator=springSecurityService.principal.username
		  if (! lineItem.hasErrors() && lineItem.save()) {
		    message = "InvoiceLineItem Saved.."
		    id = lineItem.id
		    state = "OK"
		  } else {
		    lineItem.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save InvoiceLineItem"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check lineItem exists
			  lineItem  = InvoiceLineItem.get(it)
			  if (lineItem) {
			    // delete lineItem
			    if(!lineItem.delete())
			    	{
				    lineItem.errors.allErrors.each {
					log.debug("In jq_lineItem_edit: error in deleting lineItem:"+ it)
					}
			    	}
			    else {
				    message = "Deleted!!"
				    state = "OK"
			    }
			  }
		  	}
		  break;
		 default :
		  // edit action
		  // first retrieve the lineItem by its ID
		  lineItem = InvoiceLineItem.get(params.id)
		  if (lineItem) {
		    // set the properties according to passed in parameters
		    lineItem.properties = params
		    lineItem.updator = springSecurityService.principal.username
		    lineItem = invoiceService.setCalculatedFields(lineItem)		    
		    if (! lineItem.hasErrors() && lineItem.save()) {
		      message = "InvoiceLineItem  ${lineItem.toString()} Updated"
		      id = lineItem.id
		      state = "OK"
		    } else {
			    lineItem.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update InvoiceLineItem"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def jq_trip_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = PurchaseTrip.createCriteria().list(max:maxRows, offset:rowOffset) {
		trip{
			if (params.departureTime)
				ge('departureTime',Date.parse('dd-MM-yy HH:mm',params.departureTime))
			if (params.arrivalTime)
				le('arrivalTime',Date.parse('dd-MM-yy HH:mm',params.arrivalTime))
			if (params.'incharge.id')
				incharge{eq('id',new Long(params.'incharge.id'))}
			if (params.'driver.id')
				driver{eq('id',new Long(params.'driver.id'))}
			if (params.'vehicle.id')
				vehicle{eq('id',new Long(params.'vehicle.id'))}
			if (params.comments)
				ilike('comments','%'+params.comments + '%')
			if (params.amountTaken)
				ge('amountTaken',new BigDecimal(params.amountTaken))
			if (params.cashPurchase)
				ge('cashPurchase',new BigDecimal(params.cashPurchase))
			if (params.balance)
				ge('balance',new BigDecimal(params.balance))
			if (params.creditPurchase)
				ge('creditPurchase',new BigDecimal(params.creditPurchase))
			if (params.donationReceived)
				ge('donationReceived',new BigDecimal(params.donationReceived))
			order(sortIndex, sortOrder)
		}

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.trip.departureTime?.format('dd-MM-yy HH:mm'),
             	    it.trip.arrivalTime?.format('dd-MM-yy HH:mm'),
           	    it.trip.incharge?.toString(),
            	    it.trip.driver?.toString(),
           	    it.trip.vehicle?.toString(),
           	    it.trip.comments,
           	    it.amountTaken?:'',
           	    it.balance?:'',
           	    it.cashPurchase?:'',
           	    it.creditPurchase?:'',
           	    it.donationReceived?:'',
           	    (it.cashPurchase?:0)+(it.creditPurchase?:0)+(it.donationReceived?:0), 
           	    (it.amountTaken?:0) - (it.cashPurchase?:0)
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_trip = {
	      log.debug('In jq_edit_trip:'+params)
	      def purchaseTrip = null
	      def trip = null
	      def message = ""
	      def state = "FAIL"
	      def id,item

	  //format the dates
	  if(params.departureTime)
		  params.departureTime = Date.parse('dd-MM-yyyy HH:mm',params.departureTime)
	  if(params.arrivalTime)
		params.arrivalTime = Date.parse('dd-MM-yyyy HH:mm',params.arrivalTime)

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // first add trip
		  trip = new Trip(params)
		  trip.source = trip.destination = "PURCHASE"
		  trip.updator=trip.creator=springSecurityService.principal.username
		  if (! trip.hasErrors() && trip.save()) {
			  purchaseTrip = new PurchaseTrip()
			  purchaseTrip.trip = trip
			  purchaseTrip.updator=purchaseTrip.creator=springSecurityService.principal.username
			  if (! purchaseTrip.hasErrors() && purchaseTrip.save()) {
			    message = "PurchaseTrip Saved.."
			    id = purchaseTrip.id
			    state = "OK"
			  } else {
			    purchaseTrip.errors.allErrors.each {
				log.debug(it)
				}
			    message = "Could Not Save PurchaseTrip"
			  }
		  } else {
		    trip.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save Trip"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check lineItem exists
			  purchaseTrip  = PurchaseTrip.get(it)
			  if (purchaseTrip) {
			    // delete purchaseTrip
			    if(!purchaseTrip.delete())
			    	{
				    purchaseTrip.errors.allErrors.each {
					log.debug("In jq_trip_edit: error in deleting purchaseTrip:"+ it)
					}
			    	}
			    else {
				    message = "Deleted!!"
				    state = "OK"
			    }
			  }
		  	}
		  break;
		 default :
		  // edit action
		  // first retrieve the purchaseTrip by its ID
		  purchaseTrip = PurchaseTrip.get(params.id)
		  if (purchaseTrip) {
		    // set the properties according to passed in parameters
		    purchaseTrip.properties = params
			  purchaseTrip.updator = springSecurityService.principal.username
		    if (! purchaseTrip.hasErrors() && purchaseTrip.save()) {
		      message = "PurchaseTrip  ${purchaseTrip.toString()} Updated"
		      id = purchaseTrip.id
		      state = "OK"
		    } else {
			    purchaseTrip.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Purchase Trip"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def allVendorsAsJSON_JQ = {
	def query = params.term
	def c = Individual.createCriteria()
	def items = c.list(max:10)
		{
		eq('category','VENDOR')
		like("legalName", query+"%")
		order("legalName", "asc")
		}
        response.setHeader("Cache-Control", "no-store")

        def results = items.collect {
            [  
               id: it.id,
               value: it.toString(),
               label: it.toString() ]
        }

        render results as JSON
    }
    
    def print() {
    	def invoiceInstance = Invoice.get(params.id)
    	if(invoiceInstance) {
    		if(invoiceInstance.type=="SALES")
    			{
    			invoiceInstance.status = "PREPARED"
    			invoiceInstance.invoiceAmount = invoiceInstance.lineItems?.sum{it.qty*it.rate*(1+((it.taxRate?:0)/100))}?:0
    			if(!invoiceInstance.save())
    				invoiceInstance.errors.allErrors.each {log.debug(it)}
    			render(template: "salesprint", model: [invoiceInstance: invoiceInstance])
    			}
    		else
    			render(template: "print", model: [invoiceInstance: invoiceInstance])
    	}
    	else
    		render "No invoice found with the specified id. Kindly contact admin!!"
    }


    def savePaymentReference() {
      log.debug("Inside savePaymentReference with params : "+params)
      def retVal = invoiceService.savePaymentReference(params)
      def response = [message:retVal?.toString(),state:"OK",id:0]
      render response as JSON
    }

    def checkTrip() {
      log.debug("Inside checkTrip with params : "+params)
      def retVal = invoiceService.checkTrip(params)
      def response = [message:retVal?.toString(),state:"OK",id:0]
      render response as JSON
    }
    
    def report() {
    }
    
    def vendorReport() {
    }
    
    def vendorReportResult() {
    	log.debug("Inside vendorReportResult with params : "+params)
	
	if(params.from)
		  params.from = Date.parse('dd-MM-yyyy',params.from)
	if(params.to)
		  params.to = Date.parse('dd-MM-yyyy',params.to)
    	
    	def invoices = invoiceService.vendorReport(params)
    	
    	render(template: "vendorReport", model: [invoices: invoices])
    }

    def salesReport() {
    	def consumers = Invoice.createCriteria().list{
    		eq('type','SALES')
    		projections{
    			distinct('personTo')
    			}
    		order('personTo')
    		}
    	log.debug("Got consumers:"+consumers)
    	[consumers:consumers]
    }
    
    def salesReportResult() {
    	log.debug("Inside salesReportResult with params : "+params)
	
	if(params.from)
		  params.from = Date.parse('dd-MM-yyyy',params.from)
	if(params.to)
		  params.to = Date.parse('dd-MM-yyyy',params.to)
    	
    	def invoices = invoiceService.salesReport(params)
    	
    	render(template: "salesReport", model: [invoices: invoices])
    }

    def consumptionReport() {
    	def consumers = Invoice.createCriteria().list{
    		eq('type','SALES')
    		projections{
    			distinct('personTo')
    			}
    		order('personTo')
    		}
    	log.debug("Got consumers:"+consumers)
    	[consumers:consumers]
    }
    
    def consumptionReportResult() {
    	log.debug("Inside consumptionReportResult with params : "+params)
	
	if(params.from)
		  params.from = Date.parse('dd-MM-yyyy',params.from)
	if(params.to)
		  params.to = Date.parse('dd-MM-yyyy',params.to)
    	
    	def consumptions = invoiceService.consumptionReport(params)
    	
    	render(template: "consumptionReport", model: [consumptions: consumptions])
    }

    def stockReport() {
    	def items = Item.createCriteria().list{
    		order('name')
    		}
    	[items:items]
    }
    
    def stockReportResult() {
    	log.debug("Inside stockReportResult with params : "+params)
	
	if(params.from)
		  params.from = Date.parse('dd-MM-yyyy',params.from)
	if(params.to)
		  params.to = Date.parse('dd-MM-yyyy',params.to)
    	
    	def stock = invoiceService.stockReport(params)
    	
    	render(template: "stockReport", model: [stock: stock])
    }

    def paymentReport() {
    }

    def paymentReportResult() {
    	log.debug("Inside paymentReportResult with params : "+params)
	
	if(params.from)
		  params.from = Date.parse('dd-MM-yyyy',params.from)
	if(params.to)
		  params.to = Date.parse('dd-MM-yyyy',params.to)
    	
    	def invoices = invoiceService.paymentReport(params)
    	
    	render(template: "paymentReport", model: [invoices: invoices])
    }
    
    def fillGaps() {
    	def result = invoiceService.fillGaps(params)
    	render result
    }

    
}
