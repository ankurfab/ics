package ics
import groovy.sql.Sql;
import org.codehaus.groovy.grails.plugins.springsecurity.*
import org.springframework.web.context.request.RequestContextHolder

class ChallanService {

    def springSecurityService
    def housekeepingService
    def receiptSequenceService
    def bookService
    
    def getJsonCellsForInward(grails.orm.PagedResultList result) {
      def jsonCells = result.collect {
            [cell: [
            	    it.refNo,
            	    it.issueDate.format('dd-MM-yyyy'),
            	    it.issuedBy?.toString(),
            	    it.totalAmount,
            	    it.status,
            	    it.comments,
            	    it.settleDate?.format('dd-MM-yyyy'),
            	    it.advanceAmount,
            	    it.issuedTo?.id
                ], id: it.id]
        }
      return jsonCells
    }

    def getJsonCellsForOutward(grails.orm.PagedResultList result) {
      def jsonCells = result.collect {
            def challanAmount = it.lineItems?.sum{it.issuedQuantity*it.rate}?:0
            def paymentAmount = it.paymentReferences?.sum{it.amount}?:0
            def expenseAmount = it.expenses?.sum{it.approvedAmount}?:0
            def returnValue = (it.status=='SETTLED')?(it.lineItems?.sum{it.returnedQuantity*it.rate}?:0):''
            def saleValue = (it.status=='SETTLED')?(challanAmount - returnValue):'' 
            
            [cell: [
            	    it.refNo,
            	    it.issueDate.format('dd-MM-yyyy'),
            	    it.issuedTo?.toString(),
            	    it.status,
            	    it.comments,
            	    it.settleDate?.format('dd-MM-yyyy'),
            	    challanAmount,
            	    paymentAmount,
            	    expenseAmount,
            	    returnValue,
            	    saleValue,
            	    it.settleAmount,
            	    it.advanceAmount,
            	    it.issuedBy?.id
                ], id: it.id]
        }
      return jsonCells
    }
    
    def addPaymentReference(Map params) {
	      //parse date
	      if(params.paymentDate)
	      	params.paymentDate = Date.parse('dd-MM-yyyy', params.paymentDate)
	      else
	      	params.paymentDate = new Date()
	      
	  def message,id,state
	  def challan = Challan.get(params.'challan.id')
	  def payRef = new PaymentReference(params)
	  payRef.ref = "JDCHLNPMNT"+housekeepingService.getFY() +"/"+ receiptSequenceService.getNext("JD-Challan-Payment")
	  payRef.updator=payRef.creator=springSecurityService.principal.username
	  if (! payRef.hasErrors() && payRef.save()) {
	    message = "PaymentReference Saved.."
	    id = payRef.id
	    state = "OK"
	    //now add this to the challan
	    if(!challan.paymentReferences)
	    	challan.paymentReferences = []
	    challan.paymentReferences.add(payRef)
	    if(!challan.save())
		    challan.errors.allErrors.each {
			log.debug(it)
			}
	    else {
	    	//autocreate donation record
	    	try{
	    		createDonationRecord(challan,payRef)
	    		}
	    	catch(Exception e){
	    		log.debug("ChallanService.addPaymentReference: Some exception occured while creating donation record"+e)
	    	}
	    }
	    	
	    
	  } else {
	    payRef.errors.allErrors.each {
		log.debug(it)
		}
	    message = "Could Not Save PaymentReference"
	  }
	  return payRef
    }

    def deletePaymentReference(String challanid,PaymentReference payRef) {
	  def challan = Challan.get(challanid)
	  if (challanid) {
	  	challan.paymentReferences.remove(payRef)
	  	if(!challan.save())
		    challan.errors.allErrors.each {
			log.debug(it)
			}
		//now delete payRef	 
		    if(!payRef.delete())
			{
			    payRef.errors.allErrors.each {
				log.debug("In deletePaymentReference: error in deleting payRef:"+ it)
				}
			}
	  }
	  return ""
    }

    def addExpense(Map params) {
	      //parse date
	      if(params.expenseDate)
	      	params.expenseDate = Date.parse('dd-MM-yyyy', params.expenseDate)
	      if(params.approvalDate)
	      	params.approvalDate = Date.parse('dd-MM-yyyy', params.approvalDate)
	      if(params.raisedOn)
	      	params.raisedOn = Date.parse('dd-MM-yyyy', params.raisedOn)
	      
	  def message,id,state
	  def challan = Challan.get(params.'challan.id')
	  def expense = new Expense(params)
	  expense.department=Department.findByName('Jivadaya Dept') //@TODO: hardcoding
	  expense.raisedBy=challan.issuedTo
	  expense.updator=expense.creator=springSecurityService.principal.username
	  if (! expense.hasErrors() && expense.save()) {
	    message = "Expense Saved.."
	    id = expense.id
	    state = "OK"
	    //now add this to the challan
	    if(!challan.expenses)
	    	challan.expenses = []
	    challan.expenses.add(expense)
	    if(!challan.save())
		    challan.errors.allErrors.each {
			log.debug(it)
			}
	    else {
	    }
	    	
	    
	  } else {
	    expense.errors.allErrors.each {
		log.debug(it)
		}
	    message = "Could Not Save Expense"
	  }
	  return expense
    }

    def deleteExpense(String challanid,Expense expense) {
	  def challan = Challan.get(challanid)
	  if (challanid) {
	  	challan.expenseReferences.remove(expense)
	  	if(!challan.save())
		    challan.errors.allErrors.each {
			log.debug(it)
			}
		//now delete expense	 
		    if(!expense.delete())
			{
			    expense.errors.allErrors.each {
				log.debug("In deleteExpense: error in deleting expense:"+ it)
				}
			}
	  }
	  return ""
    }

    def summary(Individual issuedTo) {
    	def challans
    	if(issuedTo) {
    		challans = Challan.findAllByIssuedTo(issuedTo,[max: 3, sort: "issueDate", order: "desc"])
    	}
    	return challans?.collect{'Challan Date:'+it.issueDate?.format('dd-MM-yyyy')+' Amount:'+it.totalAmount+' Status:'+it.status}
    }

    def settle(Map params) {
    	def retVal = "Invalid challan"
    	def challan = Challan.get(params.challanid)
    	def paymentReference
    	if(challan && challan.status=='PREPARED' && challan.lineItems && challan.lineItems.size()>0) {
    		
    		//record the books returned
    		processReturnedBooks(challan,params)
    		
    		challan.status='SETTLED'
    		challan.settleDate = new Date()
    		//challan.settleBy = Individual.findByLoginid(springSecurityService.principal.username)
    		challan.settleBy = params.individual

    		if(params.amountDue && (new BigDecimal(params.amountDue))>0)
    			paymentReference = addPaymentReference(['challan.id':params.challanid,amount:params.amountDue,'mode.id':params.'mode.id',details:params.details,paymentTo:challan.settleBy])
    			
    		//capture team members
    		if(params.teamMembers)
    			bookService.createTeam(challan,params.teamMembers)

    		try{
    			challan.settleAmount = (challan.paymentReferences?.sum{it.amount}?:0) - (challan.expenses?.sum{it.amount}?:0) - (challan.lineItems?.sum{(it.issuedQuantity-it.returnedQuantity)*it.rate}?:0) - (challan.advanceAmount?:0)
    		}
    		catch(Exception e){
    			log.debug("Exception occurred in calculating settled amount!!"+e)
    		}
    		if(!challan.save())
			    challan.errors.allErrors.each {
				log.debug("error in settling challan:"+ it)
				}    	
		else
			{
    			retVal = "Challan Settled!!"
    		
			//create new challan for pending items if required
			if(params.settleoper=="settleAndCarryForward")
				carryForwardChallan(challan)
    			}
    	}
    	//return retVal+" "+params.state
    	return [challan:challan, paymentReference: paymentReference]
    }
    
    //move all remaining items from this challan to a new one
    def carryForwardChallan(Challan challan) {
    	def newChallan = new Challan()
    	newChallan.issuedTo = challan.issuedTo
    	newChallan.issuedBy = challan.settleBy
    	newChallan.issueDate = new Date()
    	newChallan.type = challan.type
    	newChallan.status = 'DRAFT'
    	newChallan.issuedTo = challan.issuedTo
    	newChallan.updator=newChallan.creator=springSecurityService.principal.username
	if(!newChallan.save())
		    newChallan.errors.allErrors.each {
			log.debug("error in cf challan:"+ it)
			}    	
	else
		{
    		//generate challan refNo
		    newChallan.refNo = "JDCHLN"+housekeepingService.getFY() +"/"+ receiptSequenceService.getNext("JD-Challan")
		    if(!newChallan.save())
			    newChallan.errors.allErrors.each {
				log.debug("error in cf challan refno:"+ it)
				}
			else {
			//add challan line items
			newChallan.lineItems = []
			challan.lineItems?.each{
				if(it.returnedQuantity>0)
					newChallan.lineItems.add(createChallanLineItem(newChallan,it))
				}
			//update challan total
			newChallan.totalAmount = newChallan.lineItems?.sum{it.issuedQuantity*it.rate}
			    if(!newChallan.save())
				    newChallan.errors.allErrors.each {
					log.debug("error in cf challan after adding cli:"+ it)
					}			
			}
		}
    }

    def createChallanLineItem(Challan challan, ChallanLineItem cli) {
    	def challanLineItem = new ChallanLineItem()
    	challanLineItem.updator = challanLineItem.creator = springSecurityService.principal.username
    	challanLineItem.book = cli.book
    	challanLineItem.issuedQuantity = cli.returnedQuantity?:0
    	challanLineItem.rate = cli.rate
    	challanLineItem.discountedRate = 0
    	challanLineItem.returnedQuantity = 0
    	challanLineItem.challan = challan
    	if(!challanLineItem.save())
			    challanLineItem.errors.allErrors.each {
				log.debug(it)
				}
	return challanLineItem
    }
    
    //post the payment to the DR
    def createDonationRecord(Challan challan, PaymentReference payRef) {
    	def dr = new DonationRecord()
    	dr.donatedBy = Individual.findByLegalName('Jivadaya Collection')
    	dr.donationDate = new Date()
    	dr.amount = payRef.amount
    	dr.scheme = Scheme.findByName('JIVADAYA DEPT')	//@TODO: hardcodings here
    	dr.centre = Centre.findByName('Pune')	//@TODO: hardcodings here
    	dr.mode = payRef.mode
    	if(dr.mode?.name?.toUpperCase()!='CASH') {
	    	dr.paymentDetails = payRef.details?.replaceAll('[^a-zA-Z0-9]+',' ')	//bankname field
		dr.transactionId = '000000'	//chq no
		dr.transactionDetails = 'NA'	//branch name
    	}
    	def (rbno, rno) = payRef.ref.tokenize( '/' )
    	dr.rbno = rbno
    	dr.rno = rno
    	dr.receiptReceivedStatus = 'NOTGENERATED'
    	def user = 'jdauto'
    	try{
    		user = springSecurityService.principal.username
    	}
    	catch(Exception e){}
    	dr.updator = dr.creator = user
    	if(!dr.save())
    		dr.errors.allErrors.each {log.debug(it)}
    }
    
    def prepareChallan(Challan challan) {
	challan.issueDate = new Date()
	challan.status='PREPARED'
	challan.totalAmount = challan.lineItems?.sum{it.issuedQuantity*it.rate}
	challan.lineItems.each{	
		bookService.updateBookStock(it.book,it.issuedQuantity,'decrement')
	}
	try{
		challan.updator = springSecurityService.principal.username
	}
	catch(Exception e){
		challan.updator = "jdchlnmgr"
	}
		
	if(!challan.save())
	    challan.errors.allErrors.each {
		println it
		} 
	return challan
    }
    
    def processReturnedBooks(Challan challan,Map params) {
    	challan.lineItems?.each{cli->
    		if(params.('returnedQuantity_'+cli.id))
    			{
    			try{
    			cli.returnedQuantity = new Integer(params.('returnedQuantity_'+cli.id))
    			}
    			catch(Exception e){
    			cli.returnedQuantity = new Integer(0)
    			}
    			}
    		//update book stock
    		bookService.updateBookStock(cli.book,cli.returnedQuantity,'increment')
    	}
    }


}
