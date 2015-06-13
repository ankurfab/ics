package ics
import java.util.zip.ZipOutputStream  
import java.util.zip.ZipEntry  
import org.grails.plugins.csv.CSVWriter
import org.apache.commons.lang.StringEscapeUtils.*
import org.codehaus.groovy.grails.plugins.springsecurity.*
import grails.converters.JSON

class VoucherController {
    def springSecurityService
    def financeService
    def housekeepingService
    def receiptSequenceService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        if(!params.sort)
        	params.sort='lastUpdated'
        if(!params.order)
        	params.order='desc'
        [voucherInstanceList: Voucher.list(params), voucherInstanceTotal: Voucher.count()]
    }

    def create = {
        def voucherInstance = new Voucher()
        voucherInstance.properties = params
        return [voucherInstance: voucherInstance]
    }

    def save = {
        params.creator=springSecurityService.principal.username
        params.updator=params.creator
	if(params.voucherDate)
		params.voucherDate = Date.parse('dd-MM-yyyy', params.voucherDate)
        def voucherInstance = new Voucher(params)

	if(!params.voucherNo)
	try{
		def voucherCode = financeService.voucherKeyCode(voucherInstance,false,voucherInstance?.mode?.name)
		def key = housekeepingService?.getFY()+'-'+voucherCode
		voucherInstance.voucherNo = key+'-'+receiptSequenceService.getNext(key)
	}
	catch(Exception e){log.debug("payExpenseSave:CANT GET VOUCHER NO:"+e)}


        if (!voucherInstance.hasErrors() && voucherInstance.save()) {
            flash.message = "voucher.created"
            flash.args = [voucherInstance.id]
            flash.defaultMessage = "Voucher ${voucherInstance.voucherNo} entered!"
            if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_ACC_VE'))
            	render(view: "create", model: [voucherInstance: new Voucher()])
            else
            	redirect(action: "show", id: voucherInstance.id)
        }
        else {
            render(view: "create", model: [voucherInstance: voucherInstance])
        }
    }

    def show = {
        def voucherInstance = Voucher.get(params.id)
        if (!voucherInstance) {
            flash.message = "voucher.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Voucher not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [voucherInstance: voucherInstance]
        }
    }

    def edit = {
        def voucherInstance = Voucher.get(params.id)
        if (!voucherInstance) {
            flash.message = "voucher.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Voucher not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [voucherInstance: voucherInstance]
        }
    }

    def update = {
        def voucherInstance = Voucher.get(params.id)
        if (voucherInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (voucherInstance.version > version) {
                    
                    voucherInstance.errors.rejectValue("version", "voucher.optimistic.locking.failure", "Another user has updated this Voucher while you were editing")
                    render(view: "edit", model: [voucherInstance: voucherInstance])
                    return
                }
            }
	params.updator=springSecurityService.principal.username
	if(params.voucherDate)
		params.voucherDate = Date.parse('dd-MM-yyyy', params.voucherDate)
            voucherInstance.properties = params
            if (!voucherInstance.hasErrors() && voucherInstance.save()) {
                flash.message = "voucher.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Voucher ${params.id} updated"
                redirect(action: "show", id: voucherInstance.id)
            }
            else {
                render(view: "edit", model: [voucherInstance: voucherInstance])
            }
        }
        else {
            flash.message = "voucher.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Voucher not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def voucherInstance = Voucher.get(params.id)
        if (voucherInstance) {
            try {
                voucherInstance.delete()
                flash.message = "voucher.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Voucher ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "voucher.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Voucher ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "voucher.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Voucher not found with id ${params.id}"
            redirect(action: "list")
        }
    }

     def jq_voucher_list = {
          def sortIndex = params.sidx ?: 'id'
          def sortOrder  = params.sord ?: 'desc'
    
          def maxRows = Integer.valueOf(params.rows)
          def currentPage = Integer.valueOf(params.page) ?: 1
    
          def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
          
          if(params.oper=="excel" )
          		{
          			maxRows = 100000
          			rowOffset = 0
          			sortIndex = "id"
          			sortOrder = "asc"
    		}
    
    
    	def result = Voucher.createCriteria().list(max:maxRows, offset:rowOffset) {
    				
	ne('status','DELETED')
	
	if (params.voucherDate) {
		def voucherDate = Date.parse('dd-MM-yyyy', params.voucherDate)
		ge('voucherDate', voucherDate)	
		lt('voucherDate', voucherDate+1)	
		}
    
    	if(params.departmentCode)
    		departmentCode{eq('id',new Long(params.departmentCode))}
    		    
    	if(params.voucherNo)
    		ilike('voucherNo',params.voucherNo)
    
    	if(params.description)
    		ilike('description',params.description)
    
    	if(params.amount)
    		eq('amount',new BigDecimal(params.amount))
    
    	if(params.amountSettled)
    		eq('amountSettled',new BigDecimal(params.amountSettled))
    
    	if(params.updator)
    		eq('updator',params.updator)
    
    	if(params.type)
    		eq('type',params.type)
    
    	if(params.ledger)
    		ilike('ledger',params.ledger)
    
    	if(params.anotherLedger)
    		ilike('anotherLedger',params.anotherLedger)
    
    	if(params.amount)
    		eq('amount',new BigDecimal(params.amount))
    
    	if(params.debit) {
    		if(params.debit=='Dr')
    			eq('debit',true)
    
		if(params.debit=='Cr')
			eq('debit',false)
    	}
    
    	if(params.instrumentReady) {
    		if(params.instrumentReady=='YES')
    			eq('instrumentReady',true)
    		else
    			eq('instrumentReady',false)
    	}

    	if(params.instrumentCollected) {
    		if(params.instrumentCollected=='YES')
    			eq('instrumentCollected',true)
    		else
    			eq('instrumentCollected',false)
    	}

    	if(params.dataCaptured) {
    		if(params.dataCaptured=='YES')
    			eq('dataCaptured',true)
    		else
    			eq('dataCaptured',false)
    	}

    	if(params.refNo)
    		ilike('refNo',params.refNo)
    		
    	if(params.instrumentNo)
    		eq('instrumentNo',params.instrumentNo)
    		
	if (params.instrumentDate) {
		def instrumentDate = Date.parse('dd-MM-yyyy', params.instrumentDate)
		ge('instrumentDate', instrumentDate)	
		lt('instrumentDate', instrumentDate+1)	
		}
    
    		
    	if(params.bankName)
    		ilike('bankName',params.bankName)
    		
    	if(params.bankBranch)
    		ilike('bankBranch',params.bankBranch)
    		
    	if(params.status)
		eq('status',params.status)	
    
    	order(sortIndex, sortOrder)
    	}
          
          def totalRows = result.totalCount
          def numberOfPages = Math.ceil(totalRows / maxRows)
          
         
         if(params.oper=="excel")
            {
         
    	def fileName = "voucher_"+new Date().format('ddMMyyyyHHmmss')+".csv"
    	response.contentType = 'application/zip'
    	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
    	zipOutputStream.putNextEntry(new ZipEntry(fileName))
    	
    	zipOutputStream << "SNo,VoucherDate,VoucherNo,DepartmentCode,Description,Deposit(Dr),Withdrawal(Cr),Type,From,To,Amount,Debit/Credit,RefNo" 
    	def sno = 0
    	result.each{ row ->
    	sno++
    	//log.debug(sno+" start")
    
    	zipOutputStream <<"\n"
    	zipOutputStream <<sno +","+row.voucherDate?.format('dd-MM-yyyy') +","+
    	
    	
    	row.voucherNo?.replaceAll(',',';') +","+
    	(row.departmentCode?.name?.replaceAll(',',';')?:'') +","+
    	
    	(row.description?.tr('\n\r\t',' ')?.replaceAll(',',';')?:'') +","+
    	(row.amountSettled?:'') +","+
    	(row.amount?:'') +","+
    	(row.type?.replaceAll(',',';')?:'') +","+
    	(row.ledger?.replaceAll(',',';')?:'') +","+
    	(row.anotherLedger?.replaceAll(',',';')?:'') +","+
    	(row.amount?:'') +","+
    	(row.debit?'Dr':'Cr') +","+
    	(row.refNo?.replaceAll(',',';')?:'')
    	    }
    	 }    		
    	return
    		 }
        else
    	{
          
          def jsonCells
          jsonCells = result.collect {
                [cell: [
                	    it.voucherDate?.format("dd-MM-yyyy"),
                	    it.voucherNo,
                	    it.departmentCode?.toString(),
                	    it.description,
                	    it.amountSettled,
                	    it.amount,
                	    it.type,
                	    it.ledger,
                	    it.anotherLedger,
                	    it.amount,
                	    it.debit?'Dr':'Cr',
                	    it.instrumentReady?(it.instrumentReadyDate?.format('dd-MM-yyyy HH:mm:ss')):'',
                	    it.instrumentNo,
                	    it.instrumentDate?.format('dd-MM-yyyy'),
                	    it.bankName,
                	    it.bankBranch,
                	    it.instrumentCollected?(it.instrumentCollectedDate?.format('dd-MM-yyyy HH:mm:ss')):'',
                	    it.dataCaptured?(it.dataCaptureDate?.format('dd-MM-yyyy HH:mm:ss')):'',
                	    it.refNo
                    ], id: it.id]
            }
            def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
            render jsonData as JSON
            }
          }
    


    def createJournal = {
        def voucherInstance = new Voucher()
        voucherInstance.properties = params
        return [voucherInstance: voucherInstance]
    }

    def createPayment = {
        def voucherInstance = new Voucher()
        voucherInstance.properties = params
        return [voucherInstance: voucherInstance]
    }

    def createReceipt = {
        def voucherInstance = new Voucher()
        voucherInstance.properties = params
        return [voucherInstance: voucherInstance]
    }

    def createContra = {
        def voucherInstance = new Voucher()
        voucherInstance.properties = params
        return [voucherInstance: voucherInstance]
    }
    
    def showRef() {
    	log.debug("Inside showRef with params:"+params)
  	def controller,action,id

    	def voucherInstance = Voucher.get(params.id)
    	if(voucherInstance?.refNo) {
    		def tokens = voucherInstance?.refNo.tokenize('/')
    		if(tokens.size()==3) {
			controller=tokens[0]
			action=tokens[1]
			id=tokens[2]    			
    		}
    	}
    	else {
    		controller="Voucher"
    		action="list"
    		id=""
    		
    	}

 	redirect controller:controller, action:action, id:id
    }
    
    def payExpense() {
    	if(financeService.checkVoucherStatus(params.expids))
	    	render(template: "create", model: [expids:params.expids])
	else
		render "One or more expense items already have vouchers assoicated with them or Ledger Heads have  not been assigned. Please choose correct items!!"
    }
    
    def payExpenseSave() {
    	log.debug("payExpenseSave:"+params)
    	financeService.payExpenseSave(params)
    	render([message:"OK"] as JSON)
    }
    
    def ready() {
    	log.debug("ready:"+params)
    	def msg = financeService.ready(params)
    	render([message:msg] as JSON)
    }
    
    def collected() {
    	log.debug("collected:"+params)
    	def msg = financeService.collected(params)
    	render([message:msg] as JSON)
    }
 
    def dataEntered() {
    	log.debug("dataEntered:"+params)
    	def msg = financeService.dataEntered(params)
    	render([message:msg] as JSON)
    }
 
    def bounceCheque() {
		log.debug("params from within bounceCheque:"+params)
		def voucherInstance = Voucher.get(params.id)
		def result = Expense.createCriteria().list(max:20, offset:0) {
			isNotNull('paymentVoucher')
			paymentVoucher{eq('voucherNo', voucherInstance.voucherNo)}
		}
		voucherInstance.refNo = null;
		voucherInstance.status = "BOUNCED_CHEQUE";
		result.collect {
			it.paymentVoucher = null;
			it.status = "BOUNCED_CHEQUE";
		}
		
		return
	}

	def printVoucher() {
        def voucherInstance
        
        if(params.id) {
        	voucherInstance = Voucher.get(params.id)
        	if(voucherInstance.type=='Payment') {
        	if (voucherInstance.refNo?.startsWith('expense/show/'))
        		params.settlement = true
        	else if (voucherInstance.refNo?.startsWith('project/show/'))
        		params.advance = true
        	}
        }
        else if(params.projectid)
        	voucherInstance = Project.get(params.projectid)?.advancePaymentVoucher
        else if(params.expenseid) {
        	voucherInstance = Expense.get(params.expenseid)?.paymentVoucher
        	if(voucherInstance?.type=='Journal')
        		params.settlement = false
        	}

        if(params.advance) {
		def projectInstance = Project.get(voucherInstance.refNo.substring(13))
		//advance req slip to be printed only in case of CASH...else normal payment/debit voucher
		if (!projectInstance.advancePaymentMode || projectInstance.advancePaymentMode.name.toUpperCase()=='CASH')
			render(template: "/project/expenseApproval", model: [projectInstance: projectInstance])
	    	else
	    		render(template: "/voucher/printPaymentVoucher", model: [voucherInstance: projectInstance?.advancePaymentVoucher])
		return
        }
        	
        if(params.settlement) {
		def expids
		def projectInstance,childProjects,expenses=[]
		
		if (voucherInstance.refNo?.startsWith('expense/show/')) {
			expids = voucherInstance.refNo.substring(13)
			expids?.tokenize(',').each{eid->
			expenses.add(Expense.get(eid))
			}
		}
		if(expenses.size()>0) {
			projectInstance = expenses[0].project
			if(projectInstance.type=='CREDIT')
				childProjects = Project.findAllByMainProject(projectInstance)
		}
		render(template: "printSettlementVoucher", model: [voucherInstance: voucherInstance,projectInstance: projectInstance,expenses: expenses,childProjects:childProjects])
		return
        }
        	
        switch(voucherInstance.type) {
        	case 'Receipt':
	        	render(template: "printReceiptVoucher", model: [voucherInstance: voucherInstance])
	        	return
        		break
        	case 'Journal':
	        	render(template: "printJournalVoucher", model: [voucherInstance: voucherInstance])
	        	return
        		break
        	case 'Contra':
	        	render(template: "printContraVoucher", model: [voucherInstance: voucherInstance])
	        	return
        		break
        	case 'Payment':
	        	render(template: "printPaymentVoucher", model: [voucherInstance: voucherInstance])
	        	return
        		break
        	default:
	        	render(template: "printVoucher", model: [voucherInstance: voucherInstance])
	        	return
        		break
        }
       	return
    }
    
    def showFromProject() {
    	if(params.id) {
    		def voucherInstance = Project.get(params.id)?.advancePaymentVoucher
    		render(view: "show", model: [voucherInstance: voucherInstance])
    		return
    	}
    	render 'Not found!!'
    }

    def showFromExpense() {
    	if(params.id) {
    		def voucherInstance = Expense.get(params.id)?.paymentVoucher
    		render(view: "show", model: [voucherInstance: voucherInstance])
    		return
    	}
    	render 'Not found!!'
    }

}