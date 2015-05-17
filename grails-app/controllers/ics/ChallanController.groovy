package ics

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import grails.converters.JSON
import groovy.sql.Sql;

class ChallanController {

    def dataSource
    def springSecurityService
    def challanService
    def bookService
    def housekeepingService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [challanInstanceList: Challan.list(params), challanInstanceTotal: Challan.count()]
    }

    def create = {
        def challanInstance = new Challan()
        challanInstance.properties = params
        return [challanInstance: challanInstance]
    }

    def save = {
        def challanInstance = new Challan(params)
        if (!challanInstance.hasErrors() && challanInstance.save()) {
            flash.message = "challan.created"
            flash.args = [challanInstance.id]
            flash.defaultMessage = "Challan ${challanInstance.id} created"
            redirect(action: "show", id: challanInstance.id)
        }
        else {
            render(view: "create", model: [challanInstance: challanInstance])
        }
    }

    def show = {
        def challanInstance = Challan.get(params.id)
        if (!challanInstance) {
            flash.message = "challan.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Challan not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [challanInstance: challanInstance]
        }
    }

    def edit = {
        def challanInstance = Challan.get(params.id)
        if (!challanInstance) {
            flash.message = "challan.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Challan not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [challanInstance: challanInstance]
        }
    }

    def update = {
        def challanInstance = Challan.get(params.id)
        if (challanInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (challanInstance.version > version) {
                    
                    challanInstance.errors.rejectValue("version", "challan.optimistic.locking.failure", "Another user has updated this Challan while you were editing")
                    render(view: "edit", model: [challanInstance: challanInstance])
                    return
                }
            }
            challanInstance.properties = params
            if (!challanInstance.hasErrors() && challanInstance.save()) {
                flash.message = "challan.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Challan ${params.id} updated"
                redirect(action: "show", id: challanInstance.id)
            }
            else {
                render(view: "edit", model: [challanInstance: challanInstance])
            }
        }
        else {
            flash.message = "challan.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Challan not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def challanInstance = Challan.get(params.id)
        if (challanInstance) {
            try {
                challanInstance.delete()
                flash.message = "challan.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Challan ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "challan.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Challan ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "challan.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Challan not found with id ${params.id}"
            redirect(action: "list")
        }
    }

    def inward = {
    }

    def outward = {
    }

    def jq_challan_list = {
      log.debug("Inside jq_challan_list with params : "+params)
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'
      
      def refstr="JDCHLN"

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
      
	def result = Challan.createCriteria().list(max:maxRows, offset:rowOffset) {
		eq('type',params.type)
		if (params.refNo) {
			if(params.refNo.contains('/'))
				refstr = refstr+"FY"
			else
				refstr = refstr+housekeepingService.getFY()+"/"
				
			eq('refNo',refstr+params.refNo)				
		}
		if (params.issueDate)
			le('issueDate',Date.parse('dd-MM-yyyy',params.issueDate))
		if (params.settleDate)
			ge('settleDate',Date.parse('dd-MM-yyyy',params.settleDate))
		if (params.from)
			issuedBy{or{ilike('legalName',params.from) ilike('initiatedName',params.from)}}
		if (params.issuedTo)
			issuedTo{or{ilike('legalName',params.issuedTo) ilike('initiatedName',params.issuedTo)}}
		if (params.dueDate)
			le('dueDate',Date.parse('dd-MM-yyyy',params.dueDate))
		if (params.challanAmount)
			ge('challanAmount',new BigDecimal(params.challanAmount))
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
      	case 'INWARD': 
      		jsonCells = challanService.getJsonCellsForInward(result)
      		break
      	case 'OUTWARD':
      		jsonCells = challanService.getJsonCellsForOutward(result)
      		break
      	default:
      		break
      	
      }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_challan = {
	      log.debug('In jq_challan_edit:'+params)
	      def challan = null
	      def message = ""
	      def state = "FAIL"
	      def id

		if(params.settleDate)
			params.settleDate = Date.parse('dd-MM-yyyy',params.settleDate)
		if(params.issueDate)
			params.issueDate = Date.parse('dd-MM-yyyy',params.issueDate)

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add challan sent
		  challan = challanService.createChallan(params)
		  if (! challan.hasErrors()) {
		    message = "Challan Saved.."
		    id = challan.id
		    state = "OK"
		  } else {
		    challan.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save Challan"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check challan exists
			  challan  = Challan.get(it)
			  if (challan) {
			    // delete challan
			    if(!challan.delete())
			    	{
				    challan.errors.allErrors.each {
					log.debug("In jq_challan_edit: error in deleting challan:"+ it)
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
		  // first retrieve the challan by its ID
		  challan = Challan.get(params.id)
		  if (challan) {
		    // set the properties according to passed in parameters		    
		    challan.properties = params
		    challan.updator = springSecurityService.principal.username
		    if (! challan.hasErrors() && challan.save()) {
		      message = "Challan  ${challan.toString()} Updated"
		      id = challan.id
		      state = "OK"
		    } else {
			    challan.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Challan"
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

	def challan = null
	if(params.challanid)
		challan=Challan.get(params.challanid)
		
	def result = ChallanLineItem.createCriteria().list(max:maxRows, offset:rowOffset) {
		eq('challan',challan)
		if(params.bookname)
			book{ilike('name',params.bookname)}
		if(params.rate)
			ge('rate',new BigDecimal(params.rate))
		if(params.issuedQuantity)
			ge('issuedQuantity',new Integer(params.issuedQuantity))
		if(params.returnedQuantity)
			ge('returnedQuantity',new Integer(params.returnedQuantity))
		if(sortIndex=='bookname')
			book{order('name', sortOrder)}
		else
			order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            def soldQuantity = (it.challan.status=='SETTLED')?((it.issuedQuantity?:0)-(it.returnedQuantity?:0)):''
            [cell: [
            	    it.book?.name+":"+(it.book?.language?:'')+":"+(it.book?.type?:''),
           	    it.rate,
           	    it.issuedQuantity,
           	    it.returnedQuantity,
           	    soldQuantity,
           	    soldQuantity?(soldQuantity*(it.rate?:0)):'',
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
	      
	      //cli quirks
	      
	      if(params.'item.id')
	      	{
	      	//if(Book.get(new Long(params.'item.id'))?.name==params.bookname)
	      		params.'book.id' = params.'item.id'
	      	}

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add lineItem sent
		  //first add item if not existing
		  if(!params.rate)
		  	params.rate = Book.get(params.'item.id')?.sellPrice
		      params.returnedQuantity = 0
		      params.discountedRate = 0
		  lineItem = new ChallanLineItem(params)
		  lineItem.updator=lineItem.creator=springSecurityService.principal.username
		  if (! lineItem.hasErrors() && lineItem.save()) {
		    message = "ChallanLineItem Saved.."
		    id = lineItem.id
		    state = "OK"
		  } else {
		    lineItem.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save ChallanLineItem"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check lineItem exists
			  lineItem  = ChallanLineItem.get(it)
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
		  lineItem = ChallanLineItem.get(params.id)
		  if (lineItem) {
		    // set the properties according to passed in parameters
		    lineItem.properties = params
		    lineItem.updator = springSecurityService.principal.username
		    if (! lineItem.hasErrors() && lineItem.save()) {
		      message = "ChallanLineItem  ${lineItem.toString()} Updated"
		      id = lineItem.id
		      state = "OK"
		    } else {
			    lineItem.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update ChallanLineItem"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def jq_payment_list = {
      def sortIndex = 'payment_reference_id'
      def sortOrder  = 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def sql = new Sql(dataSource);
	def query = "select payment_reference_id from challan_payment_reference where challan_payment_references_id="+params.challanid+" order by "+sortIndex+" "+sortOrder
	def countquery = "select count(payment_reference_id) cnt from challan_payment_reference where challan_payment_references_id="+params.challanid
	def result = sql.rows(query,rowOffset,maxRows)
	def totalRows = sql.firstRow(countquery)?.cnt
	sql.close()

      def numberOfPages = Math.ceil(totalRows / maxRows)
	
	def ref
      def jsonCells = result.collect {
            ref = PaymentReference.get(it.payment_reference_id)
            [cell: [
            	    ref.amount,
            	    ref.mode?.toString(),
            	    ref.details,
            	    ref.paymentDate?.format('dd-MM-yyyy HH:mm'),
            	    ref.ref?:''
                ], id: ref.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_payment = {
	      log.debug('In jq_edit_payment:'+params)
	      def payRef = null
	      def message = ""
	      def state = "FAIL"
	      def id,item
	      
	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add payRef sent
		  message = challanService.addPaymentReference(params)
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check payRef exists
			  payRef  = PaymentReference.get(it)
			  if (payRef) {
			    //delete payRef from challan
			    message = challanService.deletePaymentReference(params.'challan.id',payRef)
			  }
		  	}
		  break;
		 default :
		  // edit action
		  // first retrieve the payRef by its ID
		  payRef = PaymentReference.get(params.id)
		  if (payRef) {
		    // set the properties according to passed in parameters
		    payRef.properties = params
		    payRef.updator = springSecurityService.principal.username
		    if (! payRef.hasErrors() && payRef.save()) {
		      message = "PaymentReference  ${payRef.toString()} Updated"
		      id = payRef.id
		      state = "OK"
		    } else {
			    payRef.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update PaymentReference"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def jq_expense_list = {
      def sortIndex = 'expense_id'
      def sortOrder  = 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def sql = new Sql(dataSource);
	def query = "select expense_id from challan_expense where challan_expenses_id="+params.challanid+" order by "+sortIndex+" "+sortOrder
	def countquery = "select count(expense_id) cnt from challan_expense where challan_expenses_id="+params.challanid
	def result = sql.rows(query,rowOffset,maxRows)
	def totalRows = sql.firstRow(countquery)?.cnt
	sql.close()

      def numberOfPages = Math.ceil(totalRows / maxRows)
	
	def ref
      def jsonCells = result.collect {
            ref = Expense.get(it.expense_id)
            [cell: [
            	    ref.amount,
            	    ref.expenseDate?.format('dd-MM-yyyy'),
            	    ref.type,
            	    ref.category,
            	    ref.description,
            	    ref.raisedOn?.format('dd-MM-yyyy'),
            	    ref.status,
            	    ref.approvedAmount,
            	    ref.approvalDate?.format('dd-MM-yyyy'),
            	    ref.approvalComments
                ], id: ref.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_expense = {
	      log.debug('In jq_edit_expense:'+params)
	      def expense = null
	      def message = ""
	      def state = "FAIL"
	      def id,item
	      
	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add expense sent
		  message = challanService.addExpense(params)
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check expense exists
			  expense  = Expense.get(it)
			  if (expense) {
			    //delete expense from challan
			    message = challanService.deleteExpense(params.'challan.id',expense)
			  }
		  	}
		  break;
		 default :
		  // edit action
		  // first retrieve the expense by its ID
		  expense = Expense.get(params.id)
		  if (expense) {
		    // set the properties according to passed in parameters
		    expense.properties = params
		    expense.updator = springSecurityService.principal.username
		    if (! expense.hasErrors() && expense.save()) {
		      message = "Expense  ${expense.toString()} Updated"
		      id = expense.id
		      state = "OK"
		    } else {
			    expense.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Expense"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

	def summary() {
		def issuedTo = Individual.get(params.id)
		def summary = challanService.summary(issuedTo)
		render([name:issuedTo?.toString(),summary: summary] as JSON)
	}

    def prepareChallan() {
    	def challan = Challan.get(params.challanid)
    	if(challan)
    		{
    		//change the status and do other computations
    		if(challan.status=='DRAFT')
    			{
    				 challanService.prepareChallan(challan)
    			}
    		render(template: "printChallan", model: [challan: challan])
    		}
    	else
    		render "No challan found with the specified id. Kindly contact admin!!"
    }

    def printChallan() {
    	def challan = Challan.get(params.challanid)
    	if(challan)
    		{
    		render(template: "settleChallanPrint", model: [challan: challan])
    		}
    	else
    		render "No challan found with the specified id. Kindly contact admin!!"
    }

    def settleChallan() {
    	log.debug("inside settleChallan:"+params)
    	def challan = Challan.get(params.challanid)
    	if(challan)
    		{
    		//change the status and do other computations
    		if(challan.status=='PREPARED')
    				 render(template: "settleChallan", model: [challan: challan])
    		else
    			render "Challan not yet PREPARED!!. Kindly contact admin!!"
    		}
	else
		render "No challan found with the specified id. Kindly contact admin!!"
    }

	def settle() {
		log.debug("settling with params"+params)
		params.individual = Individual.get(session.individualid)
		if(params.settlechallanid && !params.challanid)
			params.challanid = params.settlechallanid
		def retMap = challanService.settle(params)
	      render(template: "settleChallanPrint", model: retMap)
	}

    def savePaymentReference() {
      log.debug("Inside challan.savePaymentReference "+params)
      def challan = Challan.get(params.paymentReferenceEntityId)
      params.'paymentTo.id'=session.individualid
      params.'paymentBy.id'=challan?.issuedTo?.id
      params.'challan.id'=params.paymentReferenceEntityId
      def paymentReference = challanService.addPaymentReference(params)
	render(template: "printPaymentReference", model: [challan:challan,paymentReference: paymentReference])
	}

    def printPaymentReference() {
    	def challan = Challan.get(params.challanid)
    	def paymentReference= PaymentReference.get(params.paymentReferenceid)
    	render(template: "printPaymentReference", model: [challan:challan,paymentReference: paymentReference])
    }

	def getTeam() {
		def challan = Challan.get(params.challanid)
		def teamMembers = bookService.getTeam(challan)
		render([teamMembers:teamMembers] as JSON)
	}

	def setTeam() {
		def challan = Challan.get(params.challanid)
		bookService.createTeam(challan,params.teamMembers)
		render([status:"OK"] as JSON)
	}
	
	def search() {
		if(params.type)
			render challanService.search(params)
	}

}
