package ics
import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class ProjectController {

    def springSecurityService
    def financeService

    def index = {
    	def stats
    	stats = financeService.stats(springSecurityService?.principal.username?:'')
    	log.debug("stats:"+stats)
    	[stats:stats]
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        def result = Project.createCriteria().list(){
			      if(SpringSecurityUtils.ifAllGranted('ROLE_CC_OWNER')) {
			      	submitter{eq('loginid',springSecurityService?.principal.username)}
			      }
			      if(SpringSecurityUtils.ifAllGranted('ROLE_CG_OWNER')) {
			      	costCenter{costCenterGroup{owner{eq('loginid',springSecurityService?.principal.username)}}}
			      }
        		
        		if(params.status)
        			eq('status',params.status)
        		order("dateCreated", "desc")
        		order("priority", "desc")
        	}
        log.debug("Project:list:params:"+params+":result"+result)
        [projectInstanceList: result]
    }

    def create = {
      if(SpringSecurityUtils.ifAllGranted('ROLE_CC_OWNER')) {
        //check if allowed in the first place
        def costCenter = financeService.getCostCenter(session.individualid)
       	def retval =  financeService.check(costCenter)
       	if(params.id)
       		{
       		def projectInstance
       		try {
       			projectInstance = Project.get(params.id)
       		}
       		catch(Exception e){log.debug("Project create:"+e)}
       		if(projectInstance)
       			retval.put('projectInstance',projectInstance)
       		}
       	log.debug("Project create:"+retval)
       	retval.put('costCenter',costCenter)
       	retval.put('locked',financeService.checkExpenseCreationLock())
       	return retval
      }
      else
      	flash.message="Operation not allowed!!"

      	redirect(action: "index")
    }

    def save = {
      if(SpringSecurityUtils.ifAllGranted('ROLE_CC_OWNER')) {
      	params.costCenter = financeService.getCostCenter(session.individualid)
        def response = financeService.saveProject(params)
        if(!response?.balCheck?.allow) {
        	render(view: "create", model: [projectInstance: response.projectInstance,balCheck:response.balCheck])
        	return
        }
        else
        	flash.message=(response.projectInstance?.ref?:'') +" "+response.message
      }
      redirect(action: "index")        
    }

    def edit = {
        def projectInstance = Project.get(params.id)
        if (!projectInstance) {
            flash.message = "project.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Project not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [projectInstance: projectInstance]
        }
    }

    def update = {
        def projectInstance = Project.get(params.id)
        def message='',state=''
        if (projectInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (projectInstance.version > version) {                    
                    message="Some one else has modified the record!!"
                    state="Error"
                }
            }
            //@TODO: enhance this logic
            //modify the params as per state of the project
            def toupdate = false
	    if(SpringSecurityUtils.ifAnyGranted('ROLE_CC_OWNER') && projectInstance.status=='DRAFT_REQUEST') {            
		    projectInstance.properties = params
		    toupdate = true
            }
	    if(SpringSecurityUtils.ifAllGranted('ROLE_CG_OWNER') && projectInstance.status=='SUBMITTED_REQUEST') {            
		    projectInstance.review1Status = params.review1Status
		    projectInstance.review1Comments = params.review1Comments
		    if(params.review1Status=="APPROVED")
		    	projectInstance.status = "APPROVED_REQUEST"	//update latest project status
		    toupdate = true
            }
	    if(SpringSecurityUtils.ifAllGranted('ROLE_ACC_USER') && projectInstance.status=='APPROVED_REQUEST') {            
		    if(params.advanceAmountIssued) {
			    projectInstance.advanceAmountIssued = params.advanceAmountIssued
			    projectInstance.advanceIssued = true
			    toupdate = true
		    }
            }
		    if (toupdate && !projectInstance.hasErrors() && projectInstance.save()) {
			message="Update succeded!!"
			state="OK"
		    }
		    else {
			message="Update failed or not allowed!!"
			state="ERROR"
		    }
        }
        else {
		message="Invalid operation!!"
		state="ERROR"
        }
        def response = [message:message,state:state]
        render response as JSON
    }

    def deleteRequest = {
        def projectInstance = Project.get(params.id)
        if (projectInstance && projectInstance.submitter.loginid==springSecurityService.principal.username && projectInstance.status=='DRAFT_REQUEST') {
            try {
                projectInstance.delete()
                flash.message = "Expense deleted!!"
                redirect(action: "index")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Could not delete expense. Please contact Admin!!"
                redirect(action: "index", id: params.id)
            }
        }
        else {
            flash.message = "Expense not found!!"
            redirect(action: "index")
        }
    }

    def deleteReport = {
        def projectInstance = Project.get(params.projectid)
        if (projectInstance && projectInstance.submitter.loginid==springSecurityService.principal.username && projectInstance.status=='DRAFT_REPORT') {
            try {
                Expense.findAllByProject(projectInstance).each{it.delete()}
                flash.message = "Expense items deleted!!"
                redirect(action: "index")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Could not delete expense items!!"
                redirect(action: "index", id: params.id)
            }
        }
        else {
            flash.message = "Expense not found"
            redirect(action: "index")
        }
    }

    def gridlist(){
    [status:params.status]
    }

def jq_project_list = 
         {
          def sortIndex = params.sidx ?: 'id'
          def sortOrder  = params.sord ?: 'asc'
    
          def maxRows = Integer.valueOf(params.rows)
          def currentPage = Integer.valueOf(params.page) ?: 1
    
          def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
      
    		
    	def result = Project.createCriteria().list(max: maxRows, offset: rowOffset) 
    	{
   	   	if(SpringSecurityUtils.ifAllGranted('ROLE_CC_OWNER'))
   	   	eq('costCenter',financeService.getCostCenter(session.individualid))
   	   	else if (params.costCenter)
    	   		costCenter{ilike('name', params.costCenter)}
    	   
    	   	if (params.name) 
    	   		ilike('name', params.name)
    	   				
    	   				
    	   	if (params.description) 
    	   		ilike('description', params.description)
    	   				
    	   	if (params.category) 
    	   		ilike('category', params.category)
    	   				
    	   	if (params.type) 
    	   		ilike('type', params.type)	
    	   				
    	   	if (params.expectedStartDate) 
    	   		eq('expectedStartDate', Date.parse('dd-MM-yyyy', params.expectedStartDate))	
    	   				
    	   	if (params.submitDate) 
    	   		eq('submitDate', Date.parse('dd-MM-yyyy', params.submitDate))	
    	   				
    	   	if (params.amount) 
    	   		eq('amount', params.amount)	
    	   				
    	   	if (params.advanceAmount) 
    	   		eq('advanceAmount', params.advanceAmount)	
    	   				
    	   	if (params.advanceAmountIssued) 
    	   		eq('advanceAmountIssued', params.advanceAmountIssued)	
    	   				
    	   	if (params.priority) 
    	   		eq('priority', params.priority)	
    	   				
    	   	if (params.status) 
    	   		eq('status', params.status)	
    	   				
    	   	if (params.ref) 
    	   		eq('ref', params.ref)	
    	   				
    	   			
       		order(sortIndex, sortOrder)
    
    	}  
          
          def totalRows = result.totalCount
          def numberOfPages = Math.ceil(totalRows / maxRows)
    
          def jsonCells = result.collect {
                [cell: [
                	it.costCenter?.name,
                	it.name,
                	it.description,
                	it.category,
                	it.submitDate?.format('dd-MM-yyyy'),
                	it.amount,
                	it.advanceAmount,
                	it.advanceAmountIssued,
                	it.priority,                  
                	it.status,                  
                	it.ref,                  
                    ], id: it.id]
            }
         def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
               render jsonData as JSON
        }
    
    
    
          def jq_edit_project = 
          {
          	      log.debug('In jq_edit_project:'+(params.id))
          	    
          	        def project = null
          	        
    	        def message = null
    	        def state = "FAIL"
                    def id
                    
                    switch (params.oper) {
    		        case 'add':
    		          // add instruction sent
    		        
    		         if(params.id)
    		         	params.remove('id')	//id is autogenerated
    		         	
    		         project = new Project(params)
    		           if (!project.hasErrors() && project.save())
    		           {
    		            
    		            message = "project   ${project.name}  is Added  Sucessfully"
    		            id = project.id
    			    state = "OK"
    			            }
    			            else 
    			            {
    			            
    			              message = "Could Not Save project"
    			            }
    
    		          break;
    		          
    		            case 'edit':
    			    // edit action
    			    // first retrieve the customer by its ID
    			    project = Project.get(params.id)
    			    if (project)
    			    {
    			     // def raisedByName = params.raisedBy
    			     // params.remove(raisedBy)
    			      
    			      //params.'raisedBy.legalName' = raisedByName
    			       if(params.raisedBy)
    		         	params.remove('raisedBy')
    			      
    			      
    			      project.properties = params
    			      if (! project.hasErrors() && project.save()) {
    			        message = "project  ${project.name} Updated Sucessfully "
    			        id = project.id
    			        state = "OK"
    			      } else {
    			        message = "Could Not Update Project"
    			      }
    			    }
    			    
                             break;
    		          
    		          
    		          case 'del':
    			   
    			    project = Project.get(new Long(params.id))
    			    
    			    
    			    if (project) {
    			      
    			      project.delete()
    			      message = "project  ${project.name} is Deleted"
    			      println "deleted"
    			      state = "OK"
    			    }
                            break;
    		      
    		       
    		      default :
    		      		 
    		      		  project = Project.get(new Long(params.id))
    		      		  if (project) {
    		      		 
    		      		    project.properties = params
    		      		    project.updator = springSecurityService.principal.username
    		      		   		    
    		      		    if (! project.hasErrors() && project.save()) {
    		      		      message = "project  ${project.toString()} Updated"
    		      		      id = project.id
    		      		      state = "OK"
    		      		    } else {
    		      			    project.errors.allErrors.each {
    		      				println it
    		      				}
    		      		      message = "Could Not Update project"
    		      		    }
    		      		  }
    		      		  break;
     	 }
    		
                  
          	      def response = [message:message,state:state,id:id]
          
          	      render response as JSON
	    }

    def jq_expense_list = 
             {
              def sortIndex = params.sidx ?: 'id'
              def sortOrder  = params.sord ?: 'desc'
        
              def maxRows = Integer.valueOf(params.rows)
              def currentPage = Integer.valueOf(params.page) ?: 1
        
              def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
          
        		
        	def result = Expense.createCriteria().list(max: maxRows, offset: rowOffset) 
        	{   
        				isNotNull('project')
        				
        	   			if (params.projectid)
        	   				project{eq('id', new Long(params.projectid))}

        	   			if (params.costCenter)
        	   				project{costCenter{ilike('name', params.costCenter)}}
        	   		        	
        	   			if (params.expenseDate)
        	   				eq('expenseDate', Date.parse('dd-MM-yyyy', params.expenseDate))
        	   
        	   			
        	   
        	   			if (params.ledgerHead)
        	   				ledgerHead{ilike('name', params.ledgerHead)}

        	   			if (params.category) 
        	   				eq('category', params.category)
        	   				
        	   			if (params.description) 
        	   				ilike('description', params.description)	
        	   				
        	   			if (params.amount) 
					        eq('amount', params.amount)	
					         
        	   			/*if (params.status)
        	   			        eq('status', params.status)
        	   			else
        	   				eq('status', 'SUBMITTED')*/
        	   			
        	   			if (params.invoiceRaisedBy) 
					        invoiceRaisedBy{ilike('legalName', params.invoiceRaisedBy)}

        	   			if (params.invoiceNo) 
					        eq('invoiceNo', params.invoiceNo)	

        	   			if (params.invoiceDate)
        	   				eq('invoiceDate', Date.parse('dd-MM-yyyy', params.invoiceDate))

        	   			if (params.invoicePaymentMode) 
					        invoicePaymentMode{eq('name', params.invoicePaymentMode)}

           			order(sortIndex, sortOrder)
        
        	}
              
              def totalRows = result.totalCount
              def numberOfPages = Math.ceil(totalRows / maxRows)
        
              def jsonCells = result.collect {
                    [cell: [
                    	    it.project?.costCenter?.name,
                   	             
                   	                 it.description,
                   	                 it.ledgerHead?.name?:'',
                   	                 it.amount,
                   	                 it.invoiceRaisedBy,
                   	                 it.invoiceNo,
                   	                 it.invoiceDate?.format('dd-MM-yyyy'),
                   	                 it.invoicePaymentMode?.name,
                   	                it.status,
                   	                it.ref,
                   	                it.paymentVoucher?.voucherNo,
                        ], id: it.id]
                }
             def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
                   render jsonData as JSON
        }
        
        
      def jq_edit_expense = 
      {
      	      log.debug('In jq_edit_expense:'+(params.id))
      	    
      	        def expense = null
      	        
	        def message = null
	        def state = "FAIL"
                def id
                
                switch (params.oper) {
		        case 'add':
		          // add instruction sent
		        
		         if(params.id)
		         	params.remove('id')	//id is autogenerated
		         	
		         expense = new Expense(params)
		           if (!expense.hasErrors() && expense.save())
		           {
		            
		            message = "Expense is Added by   ${expense.raisedBy}  Sucessfully"
		            id = expense.id
			    state = "OK"
			            }
			            else 
			            {
			            
			              message = "Could Not Save Expense"
			            }

		          break;
		          
		            case 'edit':
			   
			    expense = Expense.get(params.id) 
                          
                            expense.costCenter = params.costCenter
                            expense.description = params.description
                       
                            expense.raisedBy = params.raisedBy
                            expense.category = params.category
                            expense.invoiceNo = params.invoiceNo
                            expense.invoiceDate = new Date()//(params.invoiceDate)
                            expense.amount = new BigDecimal(params.amount)
                           //expense.invoicePaymentMode = params.invoicePaymentMode  //PaymentMode
                            //@Pk to do
                            
			    if (expense)
			    {
			    println params
			      if (!expense.hasErrors() && expense.save(flush: true,insert:true)) { 
			     
			        message = "Expense raised by   ${expense.raisedBy} Updated Sucessfully "
			        id = expense.id
			        state = "OK"
			      } else {
			        message = "Could Not Update Expense"
			      }
			    }
			    
                         break;
		          
		          
		          case 'del':
			    
			    expense = Expense.get(new Long(params.id))
			    if (expense) {
			      
			      expense.delete()
			      message = "Expense  Added by ${expense.raisedBy} is Deleted"
			      println "deleted"
			      state = "OK"
			    }
                        break;
		      
		       
		      default :
		      		 
		      		  expense = Expense.get(new Long(params.id))
		      		  if (expense) {
		      		 
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

    
    def show() {
	def projectInstance = Project.get(params.id)
	if (!projectInstance) {
	    render "Project not found with id:"+params.id
	}
	else {
	    render(template: "show", model: [projectInstance: projectInstance])
	}
    }
    
    def advance() {
	def projectInstance = Project.get(params.id)
	if (!projectInstance) {
	    render "Project not found with id:"+params.id
	}
	else 
	    if(!projectInstance.advanceAmountIssued){
	    	render(template: "advance", model: [projectInstance: projectInstance])}
	    else
	    {	render "Advance already issued for Expense ref:"+projectInstance.ref
	    
	}
    }

    def ledgerHead() {
	def expenseInstance = Expense.get(params.id) 
	if (!expenseInstance) {
	    render "Expense not found with id:"+params.id
	}
	else {
	    render(template: "ledgerHead", model: [expenseInstance: expenseInstance])
	}
    }

    def printApproval() {
    	def projectInstance = Project.get(params.projectid)
    	render(template: "expenseApproval", model: [projectInstance: projectInstance])
    }

    def printReimbursement() {
    	def projectInstance = Project.get(params.projectid)
    	def expenses = Expense.findAllByProjectAndStatus(projectInstance,'SUBMITTED')
    	render(template: "expenseReimburesemt", model: [projectInstance: projectInstance,expenses: expenses])
    }
    
    def changeState() {
    	log.debug("changeState:"+params)
    	flash.message = financeService.changeState(params)
    	redirect(action: "index")
    }
    
    def selectProject() {    	
	log.debug("inside selectProject:"+params)
	if(SpringSecurityUtils.ifNotGranted('ROLE_CC_OWNER')) {
		flash.message  = "Operation not permitted!!"
		redirect(action: "index")
		return
	}
	//get the relevant projects
        def costCenter = financeService.getCostCenter(session.individualid)
	def projects = financeService.getProjects(costCenter,'APPROVED_REQUEST')
	if(!projects || projects.size()==0) {
		flash.message  = "No approved expensed found!!"
		redirect(action: "index")
		return
		}
	[projects:projects]
    }
    
    def createReport() {
	log.debug("inside createReport:"+params)
	if(SpringSecurityUtils.ifNotGranted('ROLE_CC_OWNER')) {
		flash.message  = "Operation not permitted!!"
		redirect(action: "index")
		return
	}
	if(!params.projectid) {
		flash.message  = "Please select an expense!!"
		redirect(action: "index")
		return
	}
	def projectInstance = Project.get(params.projectid)
	[projectInstance:projectInstance]
    }
    
    def saveReport() {
    	log.debug("inside saveReport:"+params)
    	flash.message = financeService.saveReport(params)
    	redirect(action: "index")
    }
    
    def rejectExpense() {
    	log.debug("Inside rejectExpense with params:"+params)
    	def expense = Expense.get(params.expenseid)
    	def message=""
    	if(expense) {
    		expense.status="REJECTED"
    		expense.updator = springSecurityService.principal.username
    		if(!expense.save()) {
    			expense.errors.allErrors.each {log.debug("Exception in updating expense"+e)}
    			message = "Some exception occurred!"
    		}
    		else
    			message = "Expense item rejected"
    			
    	}
    	else
    		message = "Expense item not found!!"
    	render ([message:message] as JSON)
    }
    
    def issueAdvance() {
    	log.debug("Inside issueAdvance with params:"+params)
    	def message=""
    	def project = Project.get(params.id)
    	if(project && params.advanceAmountIssued && !project.advanceIssued) {
    		project.advanceIssued = true
    		project.advanceAmountIssued = new BigDecimal(params.advanceAmountIssued)
    		project.updator = springSecurityService.principal.username
    		if((project.advanceAmountIssued<=project.advanceAmount) && project.save()) {
    			message = "Expense updated!!"
    		}
    		else {
    			project.errors.allErrors.each {log.debug("Exception in updating project"+e)}
    			message = "Some exception occurred!"
    		}
    		
    	}
    	else
    		message = "Expense not found!!"
    	render message
    }

    def assignLedgerHead() {
    	log.debug("Inside assignLedgerHead with params:"+params)
    	def message=""
    	def expense = Expense.get(params.id)
    	if(expense && params.'ledgerHead.id') {
    		expense.ledgerHead = LedgerHead.get(params.'ledgerHead.id')
    		expense.updator = springSecurityService.principal.username
    		if(expense.save()) {
    			message = "LedgerHead for expense item updated!!"
    		}
    		else {
    			expense.errors.allErrors.each {log.debug("Exception in updating expense item"+e)}
    			message = "Some exception occurred!"
    		}
    		
    	}
    	else
    		message = "Expense item not found!!"
    	render message
    }

 def ledgerHeadGridList(){}
 def jq_ledger_head_list = 
     {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		
	def result = LedgerHead.createCriteria().list(max: maxRows, offset: rowOffset) 
	{
	        println params
	   	if (params.name)
	   		ilike('name', "Expenseparams.name")
	   	
	   	if (params.type)
	   		ilike('type', "Expenseparams.type")
	   		
	   	if (params.category)
	   		ilike('category', "Expenseparams.category")
	   
	   	if (params.description)
	   		ilike('description', "Expenseparams.description")
	   
	   		
	   	
	   	
   			order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
                    it.name,
            	    it.type,
            	    it.category,
           	    it.description,
           	   
                ], id: it.id]
        }
      def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        
        }
        	  
      def jq_edit_ledgerhead =
      {
        log.debug('In jq_edit_ledgerhead:'+(params.id))
      	    
      	        def ledgerhead = null
      	        def message = null
	        def state = "FAIL"
	        def id
                switch (params.oper) {
		     case 'add':
		     
		    if(params.id)
		     params.remove('id')	//id is autogenerated
		     params.creator=params.updator=springSecurityService.principal.username?:'System'  
		    
		     ledgerhead = new LedgerHead(params)
		      if (!ledgerhead.hasErrors() && ledgerhead.save())
		      {
		    message = "LedgerHead is Added by   Sucessfully"
		    id = ledgerhead.id
		    state = "OK"
	                }
			else 
			{
			message = "Could Not Save LedgerHead"
			 }

		    break;
		          
		    case 'edit':
		    ledgerhead = LedgerHead.get(params.id)
			if (ledgerhead)
			{
			 ledgerhead.properties = params
			 if (!ledgerhead.hasErrors() && ledgerhead.save()) {
			  message = "LedgerHead  ${ledgerhead.name} Updated Sucessfully "
			        id = ledgerhead.id
			        state = "OK"
			      } else {
			        message = "Could Not Update LedgerHead"
			      }
			    }
			    
                         break;
		          
		          
		      case 'del':
		      ledgerhead = LedgerHead.get(new Long(params.id))
			    if (ledgerhead)
			    {
			      ledgerhead.delete()
			      message = "LedgerHead  Added by ${ledgerhead.name} is Deleted"
			      println "deleted"
			      state = "OK"
			    }
                        break;
                        
                        default :
		           ledgerhead = LedgerHead.get(new Long(params.id))
		      	   if (ledgerhead) {
		      		 
		      		ledgerhead.properties = params
		      		ledgerhead.updator = ledgerhead.updator =springSecurityService?.principal.username?:'System'
		      		   		    
		      		    if (!ledgerhead.hasErrors() && ledgerhead.save()) {
		      		      message = "LedgerHead  ${ledgerhead.name} Updated"
		      		      id = ledgerhead.id
		      		      state = "OK"
		      		    } else {
		      			    ledgerhead.errors.allErrors.each {
		      				println it
		      				}
		      		      message = "Could Not Update LedgerHead"
		      		    }
		      		  }
		      		  break;		      
		       
		     
 	                     }
		
              
      	      def response = [message:message,state:state,id:id]
      
      	      render response as JSON
	    }  

	def costCategoryGridlist(){}
	
	 def jq_costcategory_list = 
	     {
	      def sortIndex = params.sidx ?: 'id'
	      def sortOrder  = params.sord ?: 'asc'

	      def maxRows = Integer.valueOf(params.rows)
	      def currentPage = Integer.valueOf(params.page) ?: 1

	      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows


		def result = CostCategory.createCriteria().list(max: maxRows, offset: rowOffset) 
		{
			if (params.name)
				ilike('name', params.name)

			if (params.owner)
				owner{
					or{
						ilike('legalName', params.owner)
						ilike('initiatedName', params.owner)
					}
					}

			   order(sortIndex, sortOrder)

		}

	      def totalRows = result.totalCount
	      def numberOfPages = Math.ceil(totalRows / maxRows)

	      def jsonCells = result.collect {
		    [cell: [  
			    it.name,
			    it.alias,
			    it.owner?.toString(),
			    it.owner?(VoiceContact.findByIndividualAndCategory(it.owner,'CellPhone')?.number?:''):'',
			    it.owner?(EmailContact.findByIndividualAndCategory(it.owner,'Personal')?.emailAddress?:''):''		
			], id: it.id]
		}
	      def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		render jsonData as JSON

		}

	      def jq_edit_costcategory =
	      {
        log.debug('In jq_edit_costcategory:'+(params.id))    // name owner dateCreated dateCreated lastUpdated
      	    
      	        def costcategory = null
      	        def message = null
	        def state = "FAIL"
	        def id
                switch (params.oper) {
		     case 'add':
		     
		    if(params.id)
		     params.remove('id')	//id is autogenerated
		     params.creator=params.updator=springSecurityService.principal.username?:'System'  
		    
		     costcategory = new CostCategory(params)
		      if (!costcategory.hasErrors() && costcategory.save())
		      {
		    message = "CostCategory is Added by   Sucessfully"
		    id = costcategory.id
		    state = "OK"
	                }
			else 
			{
			message = "Could Not Save CostCategory"
			 }

		    break;
		          
		    case 'edit':
		    costcategory = CostCategory.get(params.id)
			if (costcategory)
			{
			 costcategory.properties = params
			 if (!costcategory.hasErrors() && costcategory.save()) {
			  message = "CostCategory  ${costcategory.name} Updated Sucessfully "
			        id = costcategory.id
			        state = "OK"
			      } else {
			        message = "Could Not Update CostCategory"
			      }
			    }
			    
                         break;
		          
		          
		      case 'del':
		      costcategory = CostCategory.get(new Long(params.id))
			    if (costcategory)
			    {
			      costcategory.delete()
			      message = "CostCategory  ${costcategory.name} is Deleted"
			      println "deleted"
			      state = "OK"
			    }
                        break;
                        
                        default :
		           costcategory = CostCategory.get(new Long(params.id))
		      	   if (costcategory) {
		      		 
		      		costcategory.properties = params
		      		costcategory.updator = ledgerhead.updator =springSecurityService?.principal.username?:'System'
		      		   		    
		      		    if (!costcategory.hasErrors() && costcategory.save()) {
		      		      message = "CostCategory  ${costcategory.name} Updated"
		      		      id = costcategory.id
		      		      state = "OK"
		      		    } else {
		      			    costcategory.errors.allErrors.each {
		      				println it
		      				}
		      		      message = "Could Not Update CostCategory"
		      		    }
		      		  }
		      		  break;		      
		       
		     
 	                     }
		
              
      	      def response = [message:message,state:state,id:id]
      
      	      render response as JSON
	    }




              def jq_costcenter_list = 
	     {
	      def username=''
	      def individual
	      def sortIndex = params.sidx ?: 'id'
	      def sortOrder  = params.sord ?: 'asc'

	      def maxRows = Integer.valueOf(params.rows)
	      def currentPage = Integer.valueOf(params.page) ?: 1

	      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows


		def result = CostCenter.createCriteria().list(max: maxRows, offset: rowOffset) 
		{       
			if(params.ccatid)
				costCategory{eq('id',new Long(params.ccatid))}
			
			if(params.cgid)
				costCenterGroup{eq('id',new Long(params.cgid))}
			
			if (params.name)
				ilike('name', params.name)
				
	                if (params.alias)
				ilike('alias', params.alias)			
                      
			if (params.owner)
				owner{
					or{
						ilike('legalName', params.owner)
						ilike('initiatedName', params.owner)
					}
					}

			if (params.loginid)
				owner{eq('loginid',params.loginid)}

                                order(sortIndex, sortOrder)
		}

	      def totalRows = result.totalCount
	      def numberOfPages = Math.ceil(totalRows / maxRows)

	      def jsonCells = result.collect {
		    [cell: [  
			    it.name,
			    it.alias,
			    it.owner?.toString(),
			    it.owner?(VoiceContact.findByIndividualAndCategory(it.owner,'CellPhone')?.number?:''):'',
			    it.owner?(EmailContact.findByIndividualAndCategory(it.owner,'Personal')?.emailAddress?:''):'',
			    it.owner?.loginid
			], id: it.id]
		}
	      def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		render jsonData as JSON

		}

	      def jq_edit_costcenter = 
	      {
                log.debug('In costcenter:'+(params.id)) 
      	    
      	        def costcenter = null
      	        def message = null
	        def state = "FAIL"
	        def id
                switch (params.oper) {
		     case 'add':
		     
		    if(params.id)
		     params.remove('id')	//id is autogenerated
		     params.creator=params.updator=springSecurityService.principal.username?:'System'  
		    
		     costcenter = new CostCenter(params)
		      if (!costcenter.hasErrors() && costcenter.save())
		      {
		    message = "CostCenter is Added by   Sucessfully"
		    id = costcenter.id
		    state = "OK"
	                }
			else 
			{
			message = "Could Not Save CostCenter"
			 }

		    break;
		          
		    case 'edit':
		    costcenter = CostCenter.get(params.id)
			if (costcenter)
			{
			 costcenter.properties = params
			 if (!costcenter.hasErrors() && costcenter.save()) {
			  message = "CostCenter  ${costcenter.name} Updated Sucessfully "
			        id = costcenter.id
			        state = "OK"
			      } else {
			        message = "Could Not Update CostCenter"
			      }
			    }
			    
                      break;
		          
		          
		      case 'del':
		      costcenter = CostCenter.get(new Long(params.id))
			    if (costcenter)
			    {
			      costcenter.delete()
			      message = "CostCenter  ${costcenter.name} is Deleted"
			      println "deleted"
			      state = "OK"
			    }
                       break;
                        
                       default :
		           costcenter = CostCenter.get(new Long(params.id))
		      	   if (costcenter) {
		      		 
		      		costcenter.properties = params
		      		costcenter.updator = ledgerhead.updator =springSecurityService?.principal.username?:'System'
		      		   		    
		      		    if (!costcenter.hasErrors() && costcenter.save()) {
		      		      message = "CostCenter  ${costcenter.name} Updated"
		      		      id = costcenter.id
		      		      state = "OK"
		      		    } else {
		      			    costcenter.errors.allErrors.each {
		      				println it
		      				}
		      		      message = "Could Not Update CostCenter"
		      		    }
		      		  }
		      		  break;		      
		       
		     
 	                     }
		
              
      	      def response = [message:message,state:state,id:id]
      
      	      render response as JSON
	    }
	    
	    
	    
	    
            def costCenterGroupGridList(){}
            
     def jq_costcentergroup_list = 
	     {
	      def sortIndex = params.sidx ?: 'id'
	      def sortOrder  = params.sord ?: 'asc'

	      def maxRows = Integer.valueOf(params.rows)
	      def currentPage = Integer.valueOf(params.page) ?: 1

	      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows


		def result = CostCenterGroup.createCriteria().list(max: maxRows, offset: rowOffset) 
		{ 
			
			if (params.name)
				ilike('name', params.name)
				
	                if (params.description)
				ilike('alias', params.description)			

			if (params.owner)
				owner{
					or{
						ilike('legalName', params.owner)
						ilike('initiatedName', params.owner)
					}
					}

			if (params.loginid)
				owner{eq('loginid',params.loginid)}
                      	

                                order(sortIndex, sortOrder)
		}

	      def totalRows = result.totalCount
	      def numberOfPages = Math.ceil(totalRows / maxRows)

	      def jsonCells = result.collect {
		    [cell: [  		  
			    it.name,
			    it.description,
			    it.owner?.toString(),
			    it.owner?(VoiceContact.findByIndividualAndCategory(it.owner,'CellPhone')?.number?:''):'',
			    it.owner?(EmailContact.findByIndividualAndCategory(it.owner,'Personal')?.emailAddress?:''):'',
			    it.owner?.loginid
			], id: it.id]
		}
	      def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		render jsonData as JSON

		}

	      def jq_edit_costcentergroup = 
	      {
                log.debug('In costcenter:'+(params.id))  
      	    
      	        def costcentergroup = null
      	        def message = null
	        def state = "FAIL"
	        def id
                switch (params.oper) {
		     case 'add':
		    
		    if(params.id)
		     params.remove('id')	//id is autogenerated
		     params.creator=params.updator=springSecurityService.principal.username?:'System'  
		    
		     costcentergroup = new CostCenterGroup(params)
		      if (!costcentergroup.hasErrors() && costcentergroup.save())
		      {
		    message = "CostCenterGroup is Added by   Sucessfully"
		    id = costcentergroup.id
		    state = "OK"
	                }
			else 
			{
			message = "Could Not Save CostCenterGroup"
			 }
 
		    break;
	
                 case 'edit':
		    costcentergroup = CostCenterGroup.get(params.id)
			if (costcentergroup)
			{
			 costcentergroup.properties = params
			 if (!costcentergroup.hasErrors() && costcentergroup.save()) {
			  message = "CostCenterGroup  ${costcentergroup.name} Updated Sucessfully "
			        id = costcentergroup.id
			        state = "OK"
			      } else {
			        message = "Could Not Update CostCenterGroup"
			      }
			    }
			    
                         break;		
		
		          
		          
		      case 'del':
		      costcentergroup = CostCenterGroup.get(new Long(params.id))
			    if (costcentergroup)
			    {
			      costcentergroup.delete()
			      message = "CostCenterGroup  ${costcentergroup.name} is Deleted"
			      println "deleted"
			      state = "OK"
			    }
                       break;
                    
                       default :
		           costcentergroup = CostCenterGroup.get(new Long(params.id))
		      	   if (costcentergroup) {
		      		 
		      		costcentergroup.properties = params
		      		costcentergroup.updator = costcentergroup.updator =springSecurityService?.principal.username?:'System'
		      		   		    
		      		    if (!costcentergroup.hasErrors() && costcentergroup.save()) {
		      		      message = "CostCenterGroup  ${costcentergroup.name} Updated"
		      		      id = costcentergroup.id
		      		      state = "OK"
		      		    } else {
		      			    costcentergroup.errors.allErrors.each {
		      				println it
		      				}
		      		      message = "Could Not Update CostCenterGroup"
		      		    }
		      		  }
		      		  break;		      
		       
		     
 	                     }
		
              
      	      def response = [message:message,state:state,id:id]
      
      	      render response as JSON
	    }         

	def markSettled() {
		def project = Project.get(params.projectid)
		if(project)
			{
			//change the status and do other computations
			if(project.status=='APPROVED_REPORT')
				{
					 project.status='SETTLED_REPORT'
					 if(!project.save())
		      			    project.errors.allErrors.each {
		      				log.debug("Exception in markSettled:"+it)
		      				}					 	
				}
    			def expenses = Expense.findAllByProjectAndStatus(project,'SUBMITTED')
			render(template: "expenseReimburesemt", model: [projectInstance: project,expenses: expenses])
			}
		else
			render "No expense found with the specified id. Kindly contact admin!!"
	}
	
	def addCostCenterGroup() {
		log.debug("Inside addCostCenterGroup with params:"+params)
		financeService.addCostCenterGroup(params)		
		render ([message:"Done"] as JSON)
	}
	
	def saveRejectProject() {
		log.debug("Inside saveRejectProject:"+params)
		financeService.saveRejectProject(params)		
		render ([message:"Done"] as JSON)		
	}
	
	def generateCGOLoginId() {
		log.debug("Inside generateCGOLoginId with params:"+params)
		def loginid = ''
      		if(SpringSecurityUtils.ifAllGranted('ROLE_FINANCE')) {
			loginid = financeService.generateLoginId(CostCenterGroup.get(params.cgid)?.owner,'ROLE_CG_OWNER')
		}
		render ([message:loginid] as JSON)			
	}

	def generateCCLoginid() {
		log.debug("Inside generateCCLoginid with params:"+params)
		def loginid = ''
      		if(SpringSecurityUtils.ifAllGranted('ROLE_FINANCE')) {
			loginid = financeService.generateLoginId(CostCenter.get(params.ccid)?.owner,'ROLE_CC_OWNER')
		}
		render ([message:loginid] as JSON)			
	}

}
