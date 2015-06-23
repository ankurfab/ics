package ics
import grails.converters.JSON
import java.util.zip.ZipOutputStream
import java.util.zip.ZipEntry
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import groovy.sql.Sql;

class ProjectController {

    def springSecurityService
    def financeService
    def reportService
    def dataSource
    def housekeepingService
    def receiptSequenceService

    def index = {
    	def stats
    	stats = financeService.stats(springSecurityService?.principal.username?:'')
    	//log.debug("stats:"+stats)
    	[stats:stats]
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        def result = Project.createCriteria().list(){
			      if(SpringSecurityUtils.ifAllGranted('ROLE_CC_OWNER')) {
			      	costCenter{owner{eq('loginid',springSecurityService?.principal.username)}}
			      }
			      if(SpringSecurityUtils.ifAllGranted('ROLE_CG_OWNER')) {
			      	costCenter{costCenterGroup{owner{eq('loginid',springSecurityService?.principal.username)}}}
			      	isNull('mainProject')
			      }
        		
        		if(params.status) {
        			if(SpringSecurityUtils.ifAllGranted('ROLE_CG_OWNER') && params.status=='APPROVED_REQUEST') {
        				or{
        					eq('status','APPROVED_REQUEST')
        					eq('status','DRAFT_REPORT')
        				}
        			}
        			else
        				eq('status',params.status)
        		}
				if (params.status == 'REJECTED_REQUEST' || params.status == 'SETTLED_REPORT') {
					def currDate = new Date()
					ge('submitDate', currDate-30)//displaying records not more than 30 days old
				}

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
       		if(projectInstance) {
       			retval.put('projectInstance',projectInstance)
       			}
       		}
	//also existing vendor list
	try{
	def vendors = Individual.findAllByCategoryAndCreator('EMS_VENDOR',springSecurityService.principal.username)
	log.debug(springSecurityService.principal.username+" got vendors "+vendors)
	retval.put('vendors',vendors)
	}
	catch(Exception e){log.debug(e)}

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
        	render(view: "create", model: [projectInstance: response.projectInstance,balCheck:response.balCheck,costCenter:params.costCenter])
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
        log.debug("deleteRequest:"+params)
        def projectInstance = Project.get(params.id)
        if (projectInstance && projectInstance.costCenter.owner.loginid==springSecurityService.principal.username && projectInstance.status=='DRAFT_REQUEST') {
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
        log.debug("deleteReport:"+params)
        def projectInstance = Project.get(params.projectid)
        log.debug("project status:"+projectInstance+":"+projectInstance.costCenter.owner.loginid)
        if (projectInstance && projectInstance.costCenter.owner.loginid==springSecurityService.principal.username && (projectInstance.status=='DRAFT_REPORT'||projectInstance.status=='REJECTED_REPORT')) {
            try {
                Expense.findAllByProject(projectInstance).each{it.delete()}
                projectInstance.status='APPROVED_REQUEST'
                if(!projectInstance.save())
                	projectInstance.errors.allErrors.each {log.debug("Exception in deleteReport"+e)}
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
	    def lock
	    if(SpringSecurityUtils.ifAllGranted('ROLE_ACC_USER')) {
		    lock = AttributeValue.findByAttribute(Attribute.findByNameAndType('EMS_ACCUSER_LOCK','LOCK'))?.value?:'NOTSET'
	    }
	    //lock only for cheque overdue for now
	    //if(lock=='ON' && ((params.OVERDUE_CHEQUEVOUCHER && new Integer(params.OVERDUE_CHEQUEVOUCHER) >0) || (params.INCOMPLETE_SETTLEMENT && new Integer(params.INCOMPLETE_SETTLEMENT) >0)) )
	    if(lock=='ON' && ((params.OVERDUE_CHEQUEVOUCHER && new Integer(params.OVERDUE_CHEQUEVOUCHER) >0)) )
		redirect(action:'message',params:[msg:"OPERATION BLOCKED!!....Please complete the pending actions first..Thank you.."])	    
	    else    	
		[s_status:params.s_status,onlyAdv:params.onlyAdv, advAmtIssued:params.advAmtIssued, pids:params.pids]
    }
    
    def message() {
    	[message:params.msg]
    }

def jq_partproject_list = 
         {
          log.debug("jq_partproject_list:"+params)
          def sortIndex = params.sidx ?: 'id'
          def sortOrder  = params.sord ?: 'asc'
    
          def maxRows = Integer.valueOf(params.rows)
          def currentPage = Integer.valueOf(params.page) ?: 1
    
          def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
      
    		
    	def result = Project.createCriteria().list(max: maxRows, offset: rowOffset) 
    	{
		mainProject{eq('id',new Long(params.projectid?:0))}

   	   	if(SpringSecurityUtils.ifAllGranted('ROLE_CC_OWNER'))
   	   	eq('costCenter',financeService.getCostCenter(session.individualid))
   	   	else if (params.costCenter)
    	   		costCenter{eq('id', new Long(params.costCenter))}
    	   
    	   	eq('type','PARTPAYMENT')
    	   	
    	   	if (params.name) 
    	   		ilike('name', params.name)
    	   				
    	   				
    	   	if (params.description) 
    	   		ilike('description', params.description)
    	   				
    	   	if (params.category) 
    	   		ilike('category', params.category)
    	   				
    	   	if (params.expectedStartDate) 
    	   		eq('expectedStartDate', Date.parse('dd-MM-yyyy', params.expectedStartDate))	
    	   				
    	   	if (params.submitDate) {
    	   		def submitDate = Date.parse('dd-MM-yyyy', params.submitDate)
    	   		ge('submitDate', submitDate)	
    	   		lt('submitDate', submitDate+1)	
    	   		}
    	   				
    	   	if (params.amount) 
    	   		eq('amount', new BigDecimal(params.amount))	
    	   				
    	   	if(params.onlyAdv && params.onlyAdv=='onlyAdv') {
				gt('advanceAmount', new BigDecimal(0))
    	   	}
    	   		
    	   	if (params.advanceAmount) 
    	   		eq('advanceAmount', new BigDecimal(params.advanceAmount))	
    	   				

    	   	if (params.advanceAmountIssued) {
    	   		if (params.advanceAmountIssued=='NO')
    	   			isNull('advanceAmountIssued')	
    	   		else
    	   			isNotNull('advanceAmountIssued')
    	   	}
    	   				
    	   	if (params.priority) 
    	   		eq('priority', params.priority)	
    	   				
    	   	if (params.s_status && params.s_status!='SU' && !params.status) {
    	   		eq('status', params.s_status)
    	   		if(params.s_status=='APPROVED_REPORT' && !params.status)
    	   			ne('type', 'PARTPAYMENT')	
    	   	}
    	   	
    	   	if (params.status) 
    	   		eq('status', params.status)	

    	   	if (params.ref) 
    	   		ilike('ref', params.ref)	
    	   				
    	   	if (params.type) 
    	   		eq('type', params.type)	

    	   	if (params.issueTo) 
    	   		advanceIssuedTo{
    	   			eq('category', 'EMS_VENDOR')
    	   			ilike('legalName', params.issueTo)
    	   		}

    	   	if (params.mode) 
    	   		advancePaymentMode{
    	   			eq('name', params.mode)
    	   			}

    	   	if (params.issueComments) 
    	   		ilike('advancePaymentComments', params.issueComments)	

    	   	if (params.billNo) 
    	   		ilike('billNo', params.billNo)	

    	   	if (params.billAmount) 
    	   		eq('billAmount', new BigDecimal(params.billAmount))	

    	   	if (params.billDate) {
    	   		def billDate = Date.parse('dd-MM-yyyy', params.billDate)
    	   		ge('billDate', billDate)	
    	   		lt('billDate', billDate+1)	
    	   		}

    	   	if (params.advancePaymentVoucher) 
    	   		advancePaymentVoucher{
    	   			ilike('voucherNo', params.advancePaymentVoucher)
    	   			}

    	   	if (params.mainProject) {
    	   		if (params.mainProject=='YES')
    	   			isNull('mainProject')	
    	   		else
    	   			isNotNull('mainProject')
    	   	}
    	   			
       		order(sortIndex, sortOrder)
    
    	}  
          
          def totalRows = result.totalCount
          def numberOfPages = Math.ceil(totalRows / maxRows)
    
          def jsonCells = result.collect {
                [cell: [
                	it.costCenter?.name,
                	it.name,
                	it.description,
                	//it.category,
                	it.submitDate?.format('dd-MM-yyyy'),
                	it.amount,
                	it.advanceAmount,
                	it.advanceAmountIssued,
                	it.type,                  
                	/*it.advancePaymentMode?.name,                  
                	it.advanceIssuedTo?.toString(),                  
                	it.advancePaymentComments,
                	it.billNo,
                	it.billDate,*/
                	it.advancePaymentVoucher?.voucherNo,
                	it.mainProject?.ref,
                	it.priority,                  
                	it.status,                  
                	it.ref,                  
                    ], id: it.id]
            }
         def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
               render jsonData as JSON
        }

def jq_project_list = 
         {
          log.debug("jq_project_list:"+params)
          def sortIndex = params.sidx ?: 'id'
          def sortOrder  = params.sord ?: 'asc'
    
          def maxRows = Integer.valueOf(params.rows)
          def currentPage = Integer.valueOf(params.page) ?: 1
    
          def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
      

   	   	def pidList = []
   	   	if(SpringSecurityUtils.ifAllGranted('ROLE_ACC_USER') && params.pids) {
   	   		 pidList = params.pids.tokenize(',').collect{
   	   					if(it)
   	   						new Long(it)
   	   					}
   	   	}
   	   	
   	   	//log.debug(pidList)
    		
    	def result = Project.createCriteria().list(max: maxRows, offset: rowOffset) 
    	{

		if (pidList)
			'in'('id',pidList)

   	   	if(SpringSecurityUtils.ifAllGranted('ROLE_CC_OWNER'))
   	   	eq('costCenter',financeService.getCostCenter(session.individualid))
   	   	else if (params.costCenter)
    	   		costCenter{eq('id', new Long(params.costCenter))}
    	   
    	   	if (params.name) 
    	   		ilike('name', params.name)
    	   				
    	   				
    	   	if (params.description) 
    	   		ilike('description', params.description)
    	   				
    	   	if (params.category) 
    	   		ilike('category', params.category)
    	   				
    	   	if (params.expectedStartDate) 
    	   		eq('expectedStartDate', Date.parse('dd-MM-yyyy', params.expectedStartDate))	
    	   				
    	   	if (params.submitDate) {
    	   		def submitDate = Date.parse('dd-MM-yyyy', params.submitDate)
    	   		ge('submitDate', submitDate)	
    	   		lt('submitDate', submitDate+1)	
    	   		}
    	   				
    	   	if (params.amount) 
    	   		eq('amount', new BigDecimal(params.amount))	
    	   				
    	   	if(params.onlyAdv && params.onlyAdv=='onlyAdv') {
				gt('advanceAmount', new BigDecimal(0))
    	   	}
    	   		
    	   	if (params.advanceAmount) 
    	   		eq('advanceAmount', new BigDecimal(params.advanceAmount))	
    	   				
    	   	if (params.advAmtIssued && !params.advanceAmountIssued) {
    	   		if (params.advAmtIssued=='NO')
    	   			isNull('advanceAmountIssued')	
    	   		else
    	   			isNotNull('advanceAmountIssued')
    	   	}

    	   	if (params.advanceAmountIssued) {
    	   		if (params.advanceAmountIssued=='NO')
    	   			isNull('advanceAmountIssued')	
    	   		else if (params.advanceAmountIssued=='YES')
    	   			isNotNull('advanceAmountIssued')
    	   		/*else if(SpringSecurityUtils.ifAllGranted('ROLE_ACC_USER'))    	   		
    	   			gt('advanceAmount',new BigDecimal(0))*/
    	   	}
    	   				
    	   	if (params.priority) 
    	   		eq('priority', params.priority)	
    	   				
    	   	if (params.s_status && params.s_status!='SU' && !params.status && !params.advanceAmountIssued) {
    	   		eq('status', params.s_status)
    	   		if(params.s_status=='APPROVED_REPORT' && !params.status)
    	   			ne('type', 'PARTPAYMENT')	
    	   	}
    	   	
    	   	if (params.status) 
    	   		eq('status', params.status)	

    	   	if (params.ref) 
    	   		ilike('ref', params.ref)	
    	   				
    	   	if (params.type) 
    	   		eq('type', params.type)	

    	   	if (params.issueTo) 
    	   		advanceIssuedTo{
    	   			eq('category', 'EMS_VENDOR')
    	   			ilike('legalName', params.issueTo)
    	   		}

    	   	if (params.mode) 
    	   		advancePaymentMode{
    	   			eq('name', params.mode)
    	   			}

    	   	if (params.issueComments) 
    	   		ilike('advancePaymentComments', params.issueComments)	

    	   	if (params.billNo) 
    	   		ilike('billNo', params.billNo)	

    	   	if (params.billAmount) 
    	   		eq('billAmount', new BigDecimal(params.billAmount))	

    	   	if (params.billDate) {
    	   		def billDate = Date.parse('dd-MM-yyyy', params.billDate)
    	   		ge('billDate', billDate)	
    	   		lt('billDate', billDate+1)	
    	   		}

    	   	if (params.advancePaymentVoucher) 
    	   		advancePaymentVoucher{
    	   			ilike('voucherNo', params.advancePaymentVoucher)
    	   			}

    	   	if (params.mainProject) {
    	   		if (params.mainProject=='YES')
    	   			isNull('mainProject')	
    	   		else
    	   			isNotNull('mainProject')
    	   	}
    	   			
    	   	if (params.settleDate) {
    	   		if (params.settleDate=='YES') {
    	   			isNotNull('review3Date')
    	   		}
    	   		else {
    	   			isNull('review3Date')
    	   			eq('status','APPROVED_REPORT')    	   			
    	   		}
    	   	}
    	   			
    	   	if (params.settleAmount) 
    	   		eq('settleAmount', new BigDecimal(params.settleAmount))	

       		order(sortIndex, sortOrder)
    
    	}  
          
          def totalRows = result.totalCount
          def numberOfPages = Math.ceil(totalRows / maxRows)
    
          def jsonCells = result.collect {
                [cell: [
                	it.costCenter?.name,
                	it.name,
                	it.description,
                	//it.category,
                	it.submitDate?.format('dd-MM-yyyy'),
                	it.amount,
                	it.advanceAmount,
                	it.advanceAmountIssued,
                	it.type,                  
                	/*it.advancePaymentMode?.name,                  
                	it.advanceIssuedTo?.toString(),                  
                	it.advancePaymentComments,
                	it.billNo,
                	it.billDate,*/
                	it.advancePaymentVoucher?.voucherNo,
                	/*it.mainProject?.ref,
                	it.priority,*/                  
                	it.review3Date?.format('dd-MM-yyyy'),
                	it.settleAmount,                  
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
              log.debug("jq_expense_list:"+params)
              def sortIndex = params.sidx ?: 'id'
              def sortOrder  = params.sord ?: 'desc'
        
              def maxRows = Integer.valueOf(params.rows)
              def currentPage = Integer.valueOf(params.page) ?: 1
        
              def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
          
        		
        	def result = Expense.createCriteria().list(max: maxRows, offset: rowOffset) 
        	{   
        				isNotNull('project')
        				
        	   			project{eq('id', new Long(params.projectid?:0))}

        	   			if (params.costCenter)
        	   				project{costCenter{eq('id', new Long(params.costCenter))}}
        	   		        	
        	   			if (params.expenseDate)
        	   				eq('expenseDate', Date.parse('dd-MM-yyyy', params.expenseDate))
        	   
        	   			
        	   
        	   			if (params.ledgerHead)
        	   				ledgerHead{eq('id', new Long(params.ledgerHead))}

        	   			if (params.category) 
        	   				eq('category', params.category)
        	   				
        	   			if (params.description) 
        	   				ilike('description', params.description)	
        	   				
        	   			if (params.amount) 
					        eq('amount', new BigDecimal(params.amount))	

        	   			if (params.deduction) {
					        if(params.deduction=='YES')
					        	isNotNull('deductionType')	
					        else
					        	isNull('deductionType')
					}
					         
        	   			/*if (params.status)
        	   			        eq('status', params.status)
        	   			else
        	   				eq('status', 'SUBMITTED')*/
        	   			
        	   			if (params.invoiceRaisedBy) 
					        invoiceRaisedBy{ilike('legalName', params.invoiceRaisedBy)}

        	   			if (params.invoiceAvailable) 
					        eq('invoiceAvailable', params.invoiceAvailable)	

        	   			if (params.invoiceNo) 
					        ilike('invoiceNo', params.invoiceNo)	

					if (params.invoiceDate) {
						def invoiceDate = Date.parse('dd-MM-yyyy', params.invoiceDate)
						ge('invoiceDate', invoiceDate)	
						lt('invoiceDate', invoiceDate+1)	
						}

        	   			if (params.invoicePaymentMode) 
					        invoicePaymentMode{eq('name', params.invoicePaymentMode)}

        	   			if (params.ref) 
					        ilike('ref', params.ref)	

        	   			if (params.paymentVoucher) 
					        paymentVoucher{ilike('voucherNo', params.paymentVoucher)}

           			order(sortIndex, sortOrder)
        
        	}
              
              def totalRows = result.totalCount
              def numberOfPages = Math.ceil(totalRows / maxRows)
        
              def totalAmount = 0
              def jsonCells = result.collect {
                    totalAmount += (it.amount?:0)
                    [cell: [
                    	    it.project?.costCenter?.name,
                   	                 it.description,
                   	                 it.ledgerHead?.name?:'',
                   	                 it.amount,
                   	                 ((it.deductionType?:'')+' '+(it.deductionPercentage?:'')+' '+(it.deductionAmount?:'')+' '+(it.deductionDescription?:'')),
                   	                 it.invoiceRaisedBy,
                   	                 it.invoiceAvailable,
                   	                 it.invoiceNo,
                   	                 it.invoiceDate?.format('dd-MM-yyyy'),
                   	                 it.invoicePaymentMode?.name,
                   	                it.paymentVoucher?.voucherNo,
                   	                it.status,
                   	                it.ref,
                        ], id: it.id]
                }
             def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages,userdata:[ledgerHead:'Total',amount:totalAmount]]
                   render jsonData as JSON
        }
        
        
      def jq_edit_expense = 
      {
      	      log.debug('In jq_edit_expense:'+params)
      	    
      	        def expense = null
      	        
	        def message = null
	        def state = "FAIL"
                def id
                
                switch (params.oper) {
		        case 'add':			   
			    try{
			    def project = Project.get(params.projectid)
			    def amount = new BigDecimal(params.amount?:0)
			    if(project && project.type=='NORMAL' && amount>0) {
				expense = new Expense()
				expense.department = Department.findByCostCenter(project.costCenter)?:Department.findByName("Finance")//@TODO: hardcoded
				expense.project = project
				expense.costCenter = project.costCenter
				expense.raisedBy = project.submitter
				expense.raisedOn = new Date()
				expense.category = "EMS"
				try{
				def key = 'EXI-'+housekeepingService?.getFY()+'-'+project.costCenter?.costCategory?.alias+project.costCenter?.alias
				expense.ref = key+'-'+receiptSequenceService.getNext(key)
				}
				catch(Exception e){log.debug(e)}
				expense.updator = expense.creator = springSecurityService.principal.username
				expense.type=''
    				expense.description = params.description
    				expense.amount = amount
    				if(params.invoiceAvailable)
    					expense.invoiceAvailable = params.invoiceAvailable
    				expense.invoiceRaisedBy = params.invoiceRaisedBy
    				expense.invoiceNo = params.invoiceNo
    				try{
    					expense.invoiceDate = params.invoiceDate?(Date.parse('dd-MM-yyyy', params.invoiceDate)):null
    				}
    				catch(Exception e){log.debug(e)}
    				expense.invoicePaymentMode = PaymentMode.findByNameAndInperson(params.invoicePaymentMode,true)?:null
    				expense.status = 'SUBMITTED'
    				expense.expenseDate = new Date()

                            //recalculate total expense amount before saving
                            def amountOK = false
                            def allOtherExpenses = Expense.createCriteria().list{
                            				eq('project',project)
                            				}
                            def allOtherExpensesAmount = 0
                            if(allOtherExpenses?.size()>0)
                            	allOtherExpensesAmount = allOtherExpenses.sum{it.amount}
                            if(expense.amount+allOtherExpensesAmount <= project.amount)
                            	amountOK = true
                            else
                            	log.debug("jq_edit_expense: ADD:Total amount exceeds approved amount:pid:"+project.id+":expenseamount="+expense.amount+":allotheramount="+allOtherExpensesAmount+":approved amount="+project.amount)
                            
                            
			      if (amountOK && !expense.hasErrors() && expense.save()) { 
			     
			        message = "Expense raised by   ${expense.raisedBy} Updated Sucessfully "
			        id = expense.id
			        state = "OK"
			      } else {
			        message = "Could Not Add Expense"
				    expense.errors.allErrors.each {
						log.debug("jq_edit_expense: ADD::Exception in saving expense"+it)
					    }
			      }
			    }
			    else
			    	message = "Addition not allowed!!"
			   }
			    catch(Exception e)  {log.debug("Add of expense item:"+e)}
			    
                         break;		          
		        case 'edit':			   
			    try{
			    expense = Expense.get(params.id)
			    if(!expense.paymentVoucher && expense.project.type=='NORMAL') {
                          
                            expense.updator = springSecurityService.principal.username
                            
                            if(params.description)
                            	expense.description = params.description                       
                            if(params.amount)
                            	expense.amount = new BigDecimal(params.amount)

                            if(params.invoiceRaisedBy && params.invoiceRaisedBy!=expense.invoiceRaisedBy) {
                            	def new_invoiceRaisedBy = Individual.findByCategoryAndLegalName('EMS_VENDOR',params.invoiceRaisedBy)                            	
                            		expense.invoiceRaisedBy = params.invoiceRaisedBy
                            }

                            if(params.invoiceAvailable)
                            	expense.invoiceAvailable = params.invoiceAvailable
                            if(params.invoiceNo)
                            	expense.invoiceNo = params.invoiceNo
                            if(params.invoiceDate)
                            	expense.invoiceDate = Date.parse('dd-MM-yyyy', params.invoiceDate)
                            if(params.invoicePaymentMode) {
                            	def new_invoicePaymentMode = PaymentMode.findByNameAndInperson(params.invoicePaymentMode,true)                            	
                            	expense.invoicePaymentMode = new_invoicePaymentMode
                            }
                            
                            //recalculate total expense amount before saving
                            def amountOK = false
                            def project = expense.project
                            def allOtherExpenses = Expense.createCriteria().list{
                            				eq('project',expense.project)
                            				ne('id',expense.id)
                            				}
                            def allOtherExpensesAmount = 0
                            if(allOtherExpenses?.size()>0)
                            	allOtherExpensesAmount = allOtherExpenses.sum{it.amount}
                            if(expense.amount+allOtherExpensesAmount <= expense.project.amount)
                            	amountOK = true
                            else
                            	log.debug("jq_edit_expense: Total amount exceeds approved amount:expenseid:"+expense.id+":expenseamount="+expense.amount+":allotheramount="+allOtherExpensesAmount+":approved amount="+expense.project.amount)
                            
			      if (amountOK && !expense.hasErrors() && expense.save()) { 
			     
			        message = "Expense raised by   ${expense.raisedBy} Updated Sucessfully "
			        id = expense.id
			        state = "OK"
			      } else {
			        message = "Could Not Update Expense"
			      }
			    }
			    else
			    	message = "Edit not allowed!!"
			   }
			    catch(Exception e)  {log.debug("Edit of expense item:"+e)}
			    
                         break;		          
		case 'del':
				def idList = params.id.tokenize(',')
				idList.each
				{
					financeService.deleteExpense(it)
				}
			    message = "Deleted!!"
			    state = "OK"				
		  break;
		          
		        default:
                        	break;
 	 }
		
              
      	      def response = [message:message,state:state,id:id]
      
      	      render response as JSON
	    }

    
    def show() {
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
	if (!expenseInstance || expenseInstance.paymentVoucher) {
	    render "Expense Invalid!!"
	}
	else {
	    render(template: "ledgerHead", model: [expenseInstance: expenseInstance])
	}
    }

    def printApproval() {
    	def projectInstance = Project.get(params.projectid)
	//advance req slip to be printed only in case of CASH...else normal payment/debit voucher
	if (!projectInstance.advancePaymentMode || projectInstance.advancePaymentMode.name.toUpperCase()=='CASH')
    		render(template: "expenseApproval", model: [projectInstance: projectInstance])
    	else
    		render(template: "/voucher/printPaymentVoucher", model: [voucherInstance: projectInstance?.advancePaymentVoucher])
    		
    }

    def printReimbursement() {
    	def projectInstance = Project.get(params.projectid)
    	def expenses = Expense.findAllByProjectAndStatus(projectInstance,'SUBMITTED')
    	render(template: "expenseReimburesemt", model: [projectInstance: projectInstance,expenses: expenses])
    }
    
    def changeState() {
    	log.debug("changeState:"+params)
    	flash.message = financeService.changeState(params)
    	//handle redirection appropriately
    	if(params.approver=='ROLE_CG_OWNER') {
		try{
			def project = Project.get(params.projectid)
			if(project?.status?.endsWith('REQUEST')) {
				redirect(action: "list",params:['status':'SUBMITTED_REQUEST'])
				return
			}
			else{
				redirect(action: "list",params:['status':'SUBMITTED_REPORT'])
				return
			}
		}
		catch(Exception e){log.debug("Exception in changeState:"+e)}
    	}
    	else
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
	def projectInstance		
	def creditProjects=[], ppProjects = [], projects = [], vendors=[]
	def editScenario = false
	def expenses
	if(!params.projectid) {	//projectid would be specified if the ERR is supposed to be edited
		if(params.specificProjectIds) {
			//partpayment/credit scenario
			def project
			params.specificProjectIds.tokenize(',').each{
				project = Project.get(it)
				if(project.advanceIssuedTo)
					vendors.add(project.advanceIssuedTo.legalName)
				switch(project.type) {
					case 'CREDIT':
						creditProjects.add(project)
						break
					case 'PARTPAYMENT':
						ppProjects.add(project)
						break
					default :
						projects.add(project)
						break
						
					}
				}
		}
		else {
		flash.message  = "Please select an expense!!"
		redirect(action: "index")
		return
		}
	}
	else  {	
		log.debug("Editing ERR for Projectid:"+params.projectid)
		projectInstance = Project.get(params.projectid)
		if(projectInstance.type=='CREDIT') {
			creditProjects.add(projectInstance)
			ppProjects = Project.findAllByMainProject(projectInstance)
		}
		editScenario = true
		expenses = Expense.findAllByProject(projectInstance,[sort:'id'])
	}

	def validSelection=false
	if(!editScenario) {
		if(creditProjects.size()==1 && projects.size()==0) {
			projectInstance = creditProjects[0]
			log.debug("Vendors before unq:"+vendors)
			vendors.unique { a, b -> a <=> b }
			log.debug("Vendors after unq:"+vendors)
			if(vendors.size()==1)
				validSelection = true
		}
		else if(creditProjects.size()==0 && ppProjects.size()==0 && projects.size()==1)
			validSelection=true
	}
	else
		validSelection=true
		
	if(!projectInstance && projects.size()>0)
		projectInstance = projects[0]	

	def numRows = 10
	if(params.numItems)
		numRows = params.numItems
	else {	//edit scenario
		def numExpenses = expenses.size()
		def maxRowsToAdd = 50-numExpenses
		if(maxRowsToAdd>10)
			numRows = numExpenses+10
		else
			numRows = numExpenses+maxRowsToAdd
	}
		
	if(validSelection && projectInstance) {		
		if(creditProjects?.size()>0) {
			try{
				def availableBudget = creditProjects[0].costCenter.budget - creditProjects[0].costCenter.balance
				def ccAmount = creditProjects[0].amount
				def ppAmount = (ppProjects?.sum{it.amount})?:0
				log.debug("CREDIT settlement check..Final CREDIT amount="+ccAmount+" Sum of all PARTPAYMENTS="+ppAmount+" Available budget="+availableBudget)
				if((ccAmount-ppAmount)>availableBudget) {
					render "Insufficient available budget..Final CREDIT amount="+ccAmount+" Sum of all PARTPAYMENTS="+ppAmount+" Available budget="+availableBudget+" Amount Required="+(ccAmount-ppAmount)
				}
			}
			catch(Exception e){
			}
		}
		
		[projectInstance:projectInstance, creditProjects: creditProjects, ppProjects:ppProjects, projects:projects, numRows:numRows,expenses:expenses]
	}
	else
		render "Please choose correct expenses!!"
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
    	if(expense && !expense.paymentVoucher) {
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
    		message = "Expense item invalid!!"
    	render ([message:message] as JSON)
    }
    
    def issueAdvance() {
    	log.debug("Inside issueAdvance with params:"+params)
    	def message=financeService.issueAdvance(params)
    	render message
    }

    def assignLedgerHead() {
    	log.debug("Inside assignLedgerHead with params:"+params)
    	def count=0
    	def message=""
    	def expense
	
	if(params.'ledgerHead.id') {
		params.expidsForLedgerHead?.tokenize(',').each{eid->
			expense = Expense.get(eid)
			if(expense && !expense.paymentVoucher) {
				expense.ledgerHead = LedgerHead.get(params.'ledgerHead.id')
				expense.updator = springSecurityService.principal.username
				if(expense.save()) {
					count++
				}
				else {
					expense.errors.allErrors.each {log.debug("assignLedgerHead:Exception in updating expense item"+e)}
				}

			}
    		}
    	}
    	render count +" ledgers updated!!"
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
			isNull('status')
			
			if(params.ccatid)
				costCategory{eq('id',new Long(params.ccatid))}
			
			if(params.cgid)
				costCenterGroup{eq('id',new Long(params.cgid))}
			
			if (params.name)
				ilike('name', params.name)
				
	                if (params.alias)
				ilike('alias', params.alias)			
                      
			if (params.owner)
				owner1{
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
			    it.owner1?.toString(),
			    it.owner1?(VoiceContact.findByIndividualAndCategory(it.owner1,'CellPhone')?.number?:''):'',
			    it.owner1?(EmailContact.findByIndividualAndCategory(it.owner1,'Personal')?.emailAddress?:''):'',
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
				owner1{
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
			    it.owner1?.toString(),
			    it.owner1?(VoiceContact.findByIndividualAndCategory(it.owner1,'CellPhone')?.number?:''):'',
			    it.owner1?(EmailContact.findByIndividualAndCategory(it.owner1,'Personal')?.emailAddress?:''):'',
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

         def reviewer3 = null
         def username=''
         try{
		 username = springSecurityService.principal.username
		 reviewer3 = Individual.findByLoginid(username)
         }
         catch(Exception e){username='unknown'}


		def project = Project.get(params.projectid)
		if(project)
			{
    			def expensesWithoutVouchers = Expense.findAllByProjectAndStatusAndPaymentVoucherIsNull(project,'SUBMITTED')
    			if(expensesWithoutVouchers.size()>0) {
    				render "Voucher not created for one or more expenses has not been created!!"
    				return
    			}

    			def expenses = Expense.findAllByProject(project)
			//change the status and do other computations
			if(project.status=='APPROVED_REPORT')
				{
					 project.settleAmount = expenses.sum{it.amount}
					 log.debug("markSettled:pid:"+project.id+":settleAmount="+project.settleAmount+" :ccbalance="+project?.costCenter?.balance)
					 project.status='SETTLED_REPORT'
					 project.reviewer3 = reviewer3
					 project.review3Date = new Date()
					 if(!project.save()) {
		      			    project.errors.allErrors.each {
		      				log.debug("Exception in markSettled:"+it)
		      				}
		      			} else {
		      				//now calculate and adjust the budgets
		      				financeService.adjustBudgetAfterSettlement(project)
		      				//now update liked PP's if any
		      				if(project.type=='CREDIT')
		      					financeService.markSettleLinkedPP(project)
		      			}
				}
			render(template: "expenseReimburesemt", model: [projectInstance: project,expenses: expenses])
			}
		else
			render "No expense found with the specified id. Kindly contact admin!!"
	}
	
	def addCostCenterGroup() {
		log.debug("Inside addCostCenterGroup with params:"+params)
		//financeService.addCostCenterGroup(params)		
		def tokens = [params.name,params.description,params.loginid,Individual.get(params.'owner1.id')?.icsid?.toString()]
		financeService.createCG(tokens)
		render ([message:"Done"] as JSON)
	}
	
	def addCostCenter() {
		log.debug("Inside addCostCenter with params:"+params)
	    //format
	    //name,alias,cg_id,ccat_id,loginid,owner_icsid
		def tokens = [params.name,params.alias,params.cg_id,params.ccat_id,params.loginid,Individual.get(params.'ccOwner.id')?.icsid?.toString()]
		financeService.createCC(tokens)
		render ([message:"Done"] as JSON)
	}
	
	def saveRejectProject() {
		log.debug("Inside saveRejectProject:"+params)
		financeService.saveRejectProject(params)		
		render ([message:"Done"] as JSON)		
	}
	
	def saveRejectExpense() {
		log.debug("Inside saveRejectExpense:"+params)
		financeService.saveRejectExpense(params)		
		render ([message:"Done"] as JSON)		
	}
	
	def saveCompleteReject() {
		log.debug("Inside saveCompleteReject:"+params)
		def msg = "Unauthorized"
      		if(SpringSecurityUtils.ifAllGranted('ROLE_FINANCE'))
			msg = financeService.saveCompleteReject(params)		
		render ([message:msg] as JSON)		
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
	
	def calculateDeduction() {
		log.debug("Inside calculateDeduction with params:"+params)
      		def retmsg
      		if(SpringSecurityUtils.ifAllGranted('ROLE_ACC_USER')) {
			retmsg = financeService.calculateDeduction(params)
		}
		render ([message:retmsg] as JSON)					
	}

def jq_approvedProject_list = 
         {
          log.debug("jq_approvedProject_list:"+params)
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
    	   		costCenter{eq('id', new Long(params.costCenter))}
    	   		
    	   	eq('status','APPROVED_REQUEST')
    	   
    	   	if (params.name) 
    	   		ilike('name', params.name)    	   				
    	   				
    	   	if (params.description) 
    	   		ilike('description', params.description)
    	   				
    	   	if (params.category) 
    	   		eq('category', params.category)
    	   				    	   				
    	   	if (params.submitDate) {
    	   		def submitDate = Date.parse('dd-MM-yyyy', params.submitDate)
    	   		ge('submitDate', submitDate)	
    	   		lt('submitDate', submitDate+1)	
    	   		}
    	   				
    	   	if (params.amount) 
    	   		eq('amount', params.amount)	
    	   		
    	   	if (params.advanceAmount) 
    	   		eq('advanceAmount', new BigDecimal(params.advanceAmount))	
    	   				    	   				
    	   	if (params.advanceAmountIssued) 
    	   		eq('advanceAmountIssued', new BigDecimal(params.advanceAmountIssued))	
    	   				    	   				
    	   	if (params.priority) 
    	   		eq('priority', params.priority)	
    	   				
    	   	if (params.ref) 
    	   		ilike('ref', params.ref)	
    	   				
    	   	if (params.type) { 
    	   		if (params.type=='NORMAL') {
    	   			or {
					isNull('type')
					eq('type', params.type)
    	   			}
    	   		}
    	   		else {
    	   			or {
					eq('type', 'PARTPAYMENT')
					eq('type', 'CREDIT')
    	   			}
    	   		}
    	   			
    	   	}

    	   	if (params.issueTo) 
    	   		advanceIssuedTo{
    	   			eq('category', 'EMS_VENDOR')
    	   			ilike('legalName', params.issueTo)
    	   		}

    	   	if (params.mode) 
    	   		advancePaymentMode{
    	   			eq('name', params.mode)
    	   			}

    	   	if (params.issueComments) 
    	   		ilike('advancePaymentComments', params.issueComments)	

    	   	if (params.billNo) 
    	   		ilike('billNo', params.billNo)	

    	   	if (params.billAmount) 
    	   		eq('billAmount', new BigDecimal(params.billAmount))	

    	   	if (params.billDate) {
    	   		def billDate = Date.parse('dd-MM-yyyy', params.billDate)
    	   		ge('billDate', billDate)	
    	   		lt('billDate', billDate+1)	
    	   		}

    	   	if (params.advancePaymentVoucher) 
    	   		advancePaymentVoucher{
    	   			ilike('voucherNo', params.advancePaymentVoucher)
    	   			}
    	   			
       		order(sortIndex, sortOrder)
    
    	}  
          
          def totalRows = result.totalCount
          def numberOfPages = Math.ceil(totalRows / maxRows)
    
          def jsonCells = result.collect {
                [cell: [
                	it.ref,                  
                	it.name,
                	it.category,
                	it.submitDate?.format('dd-MM-yyyy'),
                	it.amount,
                	it.advanceAmountIssued,
                	it.type,                  
                	it.advanceIssuedTo?.toString(),                  
                    ], id: it.id]
            }
         def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
               render jsonData as JSON
        }

	def showChildProjects() {
		log.debug("showChildProjects:"+params)
		def mainProject = Project.get(params.pid)
		def childProjects = Project.findAllByMainProject(mainProject)
		if(childProjects.size()>0)
			render(template: "childProjects", model: [childProjects: childProjects]) 
		else
			render "No Part Payments found!!"
	}

    def unlockAndResetVH() {
	financeService.unlockAndResetVH(params)
	render([message:"DONE"] as JSON)
    }

    def unlockAndResetHOD() {
	financeService.unlockAndResetHOD(params)
	render([message:"DONE"] as JSON)
    }

	def expenseSummary() {
		def costCenters = []
		costCenters = CostCenter.createCriteria().list{
			isNull('status')
			if(SpringSecurityUtils.ifAllGranted('ROLE_CC_OWNER')) {
				owner{eq('loginid',springSecurityService?.principal.username)}
				}
			if(SpringSecurityUtils.ifAllGranted('ROLE_CG_OWNER')) {
				costCenterGroup{owner{eq('loginid',springSecurityService?.principal.username)}}
				}
			order('name')
			}
		[costCenters:costCenters]	
	}

    def jq_audit_list = {
      log.debug("jq_audit_list:"+params)
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
	  def ccList = CostCenter.createCriteria().list(max:maxRows, offset:rowOffset){
		  owner{eq('loginid',springSecurityService?.principal.username)}
	  }
	  def ccId = ccList.first()?.id

	def result = AttributeValue.createCriteria().list(max:maxRows, offset:rowOffset) {
		eq('objectClassName','CostCenter')
		eq('objectId',new Long(ccId))
		attribute{eq('name','BudgetAuditTrail')}
		order(sortIndex, sortOrder)
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)
            
          def jsonCells = result.collect {
                [cell: [
                	it.dateCreated.format('dd-MM-yyyy HH:mm:ss'),
                	it.creator,
                	it.value,
                    ], id: it.id]
            }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }	
		
	def jq_budgetDetails_list = {
      log.debug("jq_audit_list:"+params)
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
	  def result = CostCenter.createCriteria().list(max:maxRows, offset:rowOffset){
		  owner{eq('loginid',springSecurityService?.principal.username)}
	  }

      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)
	  def initialBudget = 0, sumOfAllManualUpdates = 0, sumOfAllIncomes = 0, currentAllocatedBudget = 0, consumedBudget = 0, availableBudget = 0
      def jsonCells = result.collect {
					initialBudget = getInitialBudget(it.id.toString())?.toLong()?:0
					sumOfAllManualUpdates = getSumOfAllManualUpdates(it.id.toString())?.toLong()?:0
					sumOfAllIncomes = getSumOfAllIncomes(it.id.toString())?.toLong()?:0
					consumedBudget = getSumOfAllExpenses(it.id.toString())?.toLong()?:0
					currentAllocatedBudget = initialBudget + sumOfAllManualUpdates + sumOfAllIncomes
					availableBudget = currentAllocatedBudget - consumedBudget
                [cell: [
                	it.costCategory?.name,
					it.name,
					initialBudget,
					sumOfAllManualUpdates,
					sumOfAllIncomes,
					currentAllocatedBudget,
					consumedBudget,
					availableBudget,
                    ], id: it.id]
            }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }
	
	def getSumOfAllExpenses (String ccId) {
		def cc = CostCenter.get(ccId)
		Date toDate = new Date()
		Date fromDate = new Date()
		fromDate.set(date: 1)
		fromDate.clearTime()
		toDate.clearTime()
		def result = reportService.ccStatement(cc,fromDate,toDate)
		def totalExpense = 0
		result.each {
			totalExpense += it.expense?:0
		}
		return totalExpense
	}

	def getSumOfAllIncomes (String ccId) {
		def cc = CostCenter.get(ccId)
		def totalIncome = 0
		if(cc.isProfitCenter){
			Date toDate = new Date()
			Date fromDate = new Date()
			fromDate.set(date: 1)
			fromDate.clearTime()
			toDate.clearTime()
			def result = reportService.ccStatement(cc,fromDate,toDate)
			result.each {
				totalIncome += it.income?:0
			}
		}
		return totalIncome
	}

	def getSumOfAllManualUpdates (String ccId) {
		def result = AttributeValue.createCriteria().list() {
			eq('objectClassName','CostCenter')
			eq('objectId',new Long(ccId))
			attribute{eq('name','BudgetAuditTrail')}
			//attribute{eq('type','BudgetUpdateAuditTrail')}
			order('id', 'desc')
		}
		def sumOfAllUpdates = 0
		def numOfAttrVals = result.size()
		result.collect{
			String value = it.value
			def valueItems = value.tokenize(' ')
			def newBudgetStringItems = valueItems[1]?.tokenize('=')
			def oldBudgetStringItems = valueItems[0]?.tokenize('=')
			def newBudget = newBudgetStringItems[1]?.toLong()
			def oldBudget = oldBudgetStringItems[1]?.toLong()
			sumOfAllUpdates += (newBudget?:0 - oldBudget?:0)
		}
		return sumOfAllUpdates
	}

	def getInitialBudget (String ccId) {
		def result = AttributeValue.createCriteria().list() {
			eq('objectClassName','CostCenter')
			eq('objectId',new Long(ccId))
			attribute{eq('name','BudgetAuditTrail')}
			attribute{eq('type','InitialBudgetUploadAuditTrail')}
			order('id', 'desc')
		}
		def numOfRows = result.size()
		def initialBudget = 0
		if(1 == numOfRows) {
			String value = result?.first()?.value
			def valueItems = value.tokenize(' ')
			initialBudget = valueItems[10]
		}
		else {
			log.debug("There cannot be more than one instance of budget upload in a month!!!")
		}
		return initialBudget
	}

	def jq_expenseSummary_list = {
      log.debug("jq_expenseSummary_list:"+params)
      def sortIndex = "id"
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = Expense.createCriteria().list(max:maxRows, offset:rowOffset) {
		if(SpringSecurityUtils.ifAllGranted('ROLE_CC_OWNER')) {
			project{costCenter{owner{eq('loginid',springSecurityService?.principal.username)}}}
			}
		if(SpringSecurityUtils.ifAllGranted('ROLE_CG_OWNER')) {
			project{costCenter{costCenterGroup{owner{eq('loginid',springSecurityService?.principal.username)}}}}
			}
		if(params.ccat)
			project{costCenter{costCategory{ilike('name',params.ccat)}}}
		if(params.name)
			project{costCenter{ilike('name',params.name)}}
		if(params.alias)
			project{costCenter{eq('alias',params.alias)}}
		
		order(sortIndex, sortOrder)
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)
      
      def totalExpense=0
      
          def jsonCells = result.collect {
                totalExpense += it.amount
                [cell: [
                	it.project?.costCenter?.costCategory?.name,
                	it.project?.costCenter?.name,
                	it.invoiceDate?.format('dd-MM-yyyy'),
                	it.description,
                	it.ledgerHead?.name,
                	it.invoiceRaisedBy,
                	it.amount,
                	it.project?.ref,
                	it.paymentVoucher?.voucherNo,
                    ], id: it.id]
            }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages,userdata:[invoiceRaisedBy:'Total',amount:totalExpense]]
        render jsonData as JSON
        }	

	def oldadvance(){}
	
	//generic method to create auto approved EARs for old advances
	def uploadOldAdvances() {
	    log.debug("Inside uploadOldAdvances")
	    
	    def f = request.getFile('myFile')
	    if (f.empty) {
		render 'file cannot be empty'
		return
	    }

	    def numRecords = 0, numCreated=0
	    def category = ""
	    f.inputStream.toCsvReader(['skipLines':'1']).eachLine{ tokens ->
	    	numRecords++
	    	try{
	    		if(financeService.uploadOldAdvance(tokens))
	    			numCreated++
	    	}
	    	catch(Exception e){log.debug("uploadOldAdvances:Exception:"+e)}
	    }
	    
	    render "Old advances uploaded "+numCreated+"/"+numRecords+" records!!"
	    return
	}
	
	def exportCostCenterGroupEntries () {
		log.debug("from within exportCostCenterGroupEntries")
		response.contentType = 'application/zip'
		def maxRows = 1000000
		def rowOffset = 0
		def result = CostCenterGroup.createCriteria().list(max: maxRows, offset: rowOffset)
		{
			if (params.name)
				ilike('name', params.name)
			if (params.alias)
				ilike('alias', params.alias)
			if (params.owner)
				owner1 {
					or{
						ilike('legalName', params.owner)
						ilike('initiatedName', params.owner)
					}
				}
			if (params.loginid)
				owner{eq('loginid',params.loginid)}
			order(params.sidx, params.sord)
		}

		new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
			zipOutputStream.putNextEntry(new ZipEntry("costCenterGroupList.csv"))
			zipOutputStream << "Name,Description,Owner,Phone,Email,Loginid"

			result.each{ row ->
			zipOutputStream << "\n"
			def contactNum = row.owner1?(VoiceContact.findByIndividualAndCategory(row.owner1,'CellPhone')?.number?:''):''
			def emailAdd = row.owner1?(EmailContact.findByIndividualAndCategory(row.owner1,'Personal')?.emailAddress?:''):''
			zipOutputStream << row.name+","+row.description+","+row.owner1?.toString()+","+contactNum+","+emailAdd+","+row.owner1?.loginid
			}
		}
	}

	def exportCostCenterEntries () {
		log.debug("from within exportCostCenterEntries")
		response.contentType = 'application/zip'
		def maxRows = 1000000
		def rowOffset = 0
		def result = CostCenter.createCriteria().list(max: maxRows, offset: rowOffset) 
		{       
			isNull('status')
			if(params.ccatid)
				costCategory{eq('id',new Long(params.ccatid))}
			if(params.cgid)
				costCenterGroup{eq('id',new Long(params.cgid))}
			if (params.name)
				ilike('name', params.name)
			if (params.alias)
				ilike('alias', params.alias)
			if (params.owner)
				owner1{
					or{
						ilike('legalName', params.owner)
						ilike('initiatedName', params.owner)
					}
				}
			if (params.loginid)
				owner{eq('loginid',params.loginid)}
			order(params.sidx, params.sord)
		}

		new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
			zipOutputStream.putNextEntry(new ZipEntry("costCenterList.csv"))
			zipOutputStream << "Name,Alias,Owner,Phone,Email,Loginid"

			result.each{ row ->
			zipOutputStream << "\n"
			def contactNum = row.owner1?(VoiceContact.findByIndividualAndCategory(row.owner1,'CellPhone')?.number?:''):''
			def emailAdd = row.owner1?(EmailContact.findByIndividualAndCategory(row.owner1,'Personal')?.emailAddress?:''):''
			zipOutputStream << row.name+","+row.alias+","+row.owner1?.toString()+","+contactNum+","+emailAdd+","+row.owner1?.loginid
			}
		}
	}
	
	def exportExpenseList () {
		log.debug("from within exportExpenseList")
		log.debug("params from within exportExpenseList:"+params)
		response.contentType = 'application/zip'
		def maxRows = 1000000
		def rowOffset = 0
		def result = Project.createCriteria().list(max: maxRows, offset: rowOffset)
    	{
			if(SpringSecurityUtils.ifAllGranted('ROLE_CC_OWNER'))
				eq('costCenter',financeService.getCostCenter(session.individualid))
			order(params.sidx, params.sord)
    	}

		new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
			zipOutputStream.putNextEntry(new ZipEntry("expenseList.csv"))
			zipOutputStream << "CostCenter,Name,Description,SubmitDate,Amount,Requested Advance Amount,Issued Advance Amount,Type,Voucher,MainExpense,Priority,Status,Reference,Id"

			result.each{ row ->
				zipOutputStream << "\n"
				zipOutputStream << row.name+","+row.description+","+row.submitDate?.format('dd-MM-yyyy')+","+row.amount+","+row.advanceAmount+","+row.advanceAmountIssued+","+row.type+","+row.advancePaymentVoucher?.voucherNo+","+row.mainProject?.ref+","+row.priority+","+row.status+","+row.ref+","+row.id
			}
		}
	}
	
	def report() {
	}
	
	def reportFMA() {
	}

	def jq_fma_list = {
		def sortIndex = "id"
		def sortOrder  = params.sord ?: 'desc'

		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1

		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def result = Expense.createCriteria().list(max:maxRows, offset:rowOffset) {
			if(params.costCategory)
				project{costCenter{costCategory{ilike('name',params.costCategory)}}}
			if(params.costCenter)
				project{costCenter{ilike('name',params.costCenter)}}
			if(params.ref)
				project{eq('ref',params.ref)}
			if(params.invoicePaymentMode)
				invoicePaymentMode{eq('name',params.invoicePaymentMode)}
			if(params.description)
				ilike('description',params.description)
			else
				ilike('description','FMA%')
			if(params.invoiceRaisedBy)
				ilike('invoiceRaisedBy',params.invoiceRaisedBy)
			if(params.invoiceNo)
				ilike('invoiceNo',params.invoiceNo)
			if(params.amount)
				eq('amount',new BigDecimal(params.amount))
			if(params.voucherNo)
				paymentVoucher{eq('voucherNo',params.voucherNo)}
			if(params.instrumentNo)
				paymentVoucher{eq('instrumentNo',params.instrumentNo)}
			if(params.bankName)
				paymentVoucher{eq('bankName',params.bankName)}
			if(params.bankBranch)
				paymentVoucher{eq('bankBranch',params.bankBranch)}
			if(params.instrumentDate) {
				def instrumentDate = Date.parse('dd-MM-yyyy', params.instrumentDate)
				paymentVoucher{ge('instrumentDate', instrumentDate)}	
				paymentVoucher{lt('instrumentDate', instrumentDate+1)}	
				}
			if(params.invoiceDate) {
				def invoiceDate = Date.parse('dd-MM-yyyy', params.invoiceDate)
				sqlRestriction "month(invoice_date) = "+((invoiceDate.month).toInteger()+(1*1).toInteger())*1
				}
			order(sortIndex, sortOrder)
		}

		def totalRows = result.totalCount
		def numberOfPages = Math.ceil(totalRows / maxRows)

		def jsonCells = result.collect {
		[cell: [
			it.project?.costCenter?.costCategory?.name,
			it.project?.costCenter?.name,
			it.project?.ref,
			it.invoiceDate?.format('dd-MM-yyyy'),
			it.invoicePaymentMode?.name,
			it.description,
			it.invoiceRaisedBy,
			it.invoiceNo,
			it.amount,
			it.paymentVoucher?.voucherNo,
			it.paymentVoucher?.instrumentNo,
			it.paymentVoucher?.instrumentDate,
			it.paymentVoucher?.bankName,
			it.paymentVoucher?.bankBranch
		    ], id: it.id]
		}
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		render jsonData as JSON
        }
        
	def reportMonthlyExpenses() {
		response.contentType = 'application/zip'
		def query = "select ccat.name costcategory,cc.name ccname, year(p.submit_date) expyear,month(p.submit_date) expmonth, l.name ledgerhead, sum(e.amount) expamount from project p, cost_center cc, cost_category ccat, expense e, ledger_head l where p.cost_center_id=cc.id and cc.cost_category_id=ccat.id and e.project_id=p.id and e.ledger_head_id=l.id and p.status='SETTLED_REPORT' group by ccat.name, cc.name, year(p.submit_date),month(p.submit_date),l.name"
		def sql = new Sql(dataSource)
		new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
			def fileName = "month_wise_expenses_"+new Date().format('ddMMyyHHmmss')+".csv"
			zipOutputStream.putNextEntry(new ZipEntry(fileName))
			//header
			def headers = null;

			sql.rows(query).each{ row ->
				   if (headers == null) {
					headers = row.keySet()
					zipOutputStream << headers.toString().replace('[','').replace(']','')
					zipOutputStream << "\n"
				   }
				//with escaping for excel
				zipOutputStream << row.values().collect{it.toString()}.toString().replace('[','').replace(']','')
				zipOutputStream << "\n"
			}
		}    	
	}
        
	def reportMonthlyExpensesVC() {
		response.contentType = 'application/zip'
		def query = "select ccat.name costcategory,cc.name ccname, year(p.submit_date) expyear,month(p.submit_date) expmonth, l.name ledgerhead, sum(e.amount) expamount from project p, cost_center cc, cost_category ccat, expense e, ledger_head l where p.cost_center_id=cc.id and cc.cost_category_id=ccat.id and e.project_id=p.id and e.ledger_head_id=l.id and e.status='VOUCHER_CREATED' group by ccat.name, cc.name, year(p.submit_date),month(p.submit_date),l.name"
		def sql = new Sql(dataSource)
		new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
			def fileName = "month_wise_expenses_vc_"+new Date().format('ddMMyyHHmmss')+".csv"
			zipOutputStream.putNextEntry(new ZipEntry(fileName))
			//header
			def headers = null;

			sql.rows(query).each{ row ->
				   if (headers == null) {
					headers = row.keySet()
					zipOutputStream << headers.toString().replace('[','').replace(']','')
					zipOutputStream << "\n"
				   }
				//with escaping for excel
				zipOutputStream << row.values().collect{it.toString()}.toString().replace('[','').replace(']','')
				zipOutputStream << "\n"
			}
		}    	
	}
        
        def createDepartments() {
        	financeService.createDepartments()
        	render "OK"
        }

	def reportCurrentMonthExpenses() {
	}

	def jq_expensevoucher_list = {
		def sortIndex = "id"
		def sortOrder  = params.sord ?: 'desc'

		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1

		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def result = Voucher.createCriteria().list(max:maxRows, offset:rowOffset) {
			not {'in'("type",['RECEIPT','CONTRA'])}
			//exclude settled advance vouchers
			not {
				eq('type','PAYMENT')
				ilike('refNo','Project%')
				eq('status','SETTLED')
				
			    }
			if(params.costCategory)
				departmentCode{costCategory{ilike('name',params.costCategory)}}
			if(params.costCenter)
				departmentCode{ilike('name',params.costCenter)}
			if(params.amount)
				eq('amount',new BigDecimal(params.amount))
			if(params.voucherNo)
				eq('voucherNo',params.voucherNo)
			if(params.instrumentNo)
				eq('instrumentNo',params.instrumentNo)
			if(params.bankName)
				eq('bankName',params.bankName)
			if(params.bankBranch)
				eq('bankBranch',params.bankBranch)
			if(params.instrumentDate) {
				def instrumentDate = Date.parse('dd-MM-yyyy', params.instrumentDate)
				ge('instrumentDate', instrumentDate)	
				lt('instrumentDate', instrumentDate+1)
				}
			order(sortIndex, sortOrder)
		}

		def totalRows = result.totalCount
		def numberOfPages = Math.ceil(totalRows / maxRows)

		def jsonCells = result.collect {
		[cell: [
			it.departmentCode?.costCategory?.name,
			it.departmentCode?.name,
			it.voucherNo,
			it.type,
			it.voucherDate?.format('dd-MM-yyyy'),
			it.amount,
			it.instrumentNo,
			it.instrumentDate?.format('dd-MM-yyyy'),
			it.bankName,
			it.bankBranch
		    ], id: it.id]
		}
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		render jsonData as JSON
        }
        
	def jq_voucherexpense_list = {
		def sortIndex = "id"
		def sortOrder  = params.sord ?: 'desc'

		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1

		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def result = Expense.createCriteria().list(max:maxRows, offset:rowOffset) {
			paymentVoucher{eq('id',new Long(params.voucherid?:-1))}
			order(sortIndex, sortOrder)
		}

		def totalRows = result.totalCount
		def numberOfPages = Math.ceil(totalRows / maxRows)

		def jsonCells = result.collect {
		[cell: [
			it.project.ref,
			it.description,
			it.invoiceDate?.format('dd-MM-yyyy'),
			it.amount
		    ], id: it.id]
		}
		
		//add EAR for adv voucher if any
		def projectList = Project.createCriteria().list{
					advancePaymentVoucher{eq('id',new Long(params.voucherid?:-1))}
				}
		def jsonCellsProject = projectList.collect {
		[cell: [
			it.ref,
			it.name,
			it.submitDate?.format('dd-MM-yyyy'),
			it.amount
		    ], id: it.id]
		}
			
		def jsonData= [rows: (jsonCells+jsonCellsProject),page:currentPage,records:totalRows+(jsonCellsProject?.size()?:0),total:numberOfPages]
		render jsonData as JSON
        }


	def reportCurrentMonthBudgetSummary() {
	}

	def jq_CurrentMonthBudgetSummary_list = {
		def sortIndex = "id"
		def sortOrder  = params.sord ?: 'desc'

		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1

		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def result = CostCenter.createCriteria().list(max:maxRows, offset:rowOffset) {
			isNull('status')
			      if(SpringSecurityUtils.ifAllGranted('ROLE_CC_OWNER')) {
				owner{eq('loginid',springSecurityService?.principal.username)}
			      }
			      else
			      if(SpringSecurityUtils.ifAllGranted('ROLE_CG_OWNER')) {
				costCenterGroup{owner{eq('loginid',springSecurityService?.principal.username)}}
			      }
			      else
			      if(SpringSecurityUtils.ifAllGranted('ROLE_FINANCE')) {
				if(params.costCategory)
					costCategory{ilike('name',params.costCategory)}
				if(params.costCenter)
					ilike('name',params.costCenter)
			      }
			order(sortIndex, sortOrder)
		}

		def totalRows = result.totalCount
		def numberOfPages = Math.ceil(totalRows / maxRows)
      
          def jsonCells = result.collect {
                def budgetstats = financeService.getBudgetSummaryStats(it)
                def stats = financeService.getMonthSummaryStats(it)
                
                [cell: [
                	it.costCategory?.name,
                	it.name,
                	//budgetstats.initialBudget,
                	//budgetstats.manualUpdates,
                	it.isProfitCenter?budgetstats.donations:'NA',
                	it.budget,
                	it.balance,
                	(it.budget?:0)-(it.balance?:0),
                	stats.submittedExpense,
                	stats.approvedExpense,
                	stats.draftSettlement,
                	stats.rejectedSettlement,
                	stats.submittedSettlement,
                	stats.approvedSettlement,
                	stats.settledExpense
                    ], id: it.id]
            }

		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		render jsonData as JSON
        }
        
	def jq_manualupdates_list = {
		def sortIndex = "id"
		def sortOrder  = params.sord ?: 'desc'

		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1

		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def result = AttributeValue.createCriteria().list(max:maxRows, offset:rowOffset) {
			eq('objectClassName','CostCenter')
			eq('objectId',new Long(params.ccid?:0))
			attribute{
				eq('name','BudgetAuditTrail')
				eq('type','BudgetUpdateAuditTrail')
				}		
			order(sortIndex, sortOrder)
		}

		def totalRows = result.totalCount
		def numberOfPages = Math.ceil(totalRows / maxRows)

		def jsonCells = result.collect {
			def parsedValueMap = financeService.parseBudgetUpdateAuditTrailValue(it.value)
			[cell: [
				it.dateCreated.format('dd-MM-yyyy HH:mm:ss'),
				it.creator,
				parsedValueMap.old,
				parsedValueMap.new,
				parsedValueMap.new - parsedValueMap.old,
				it.value,
			    ], id: it.id]
		}
					
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		render jsonData as JSON
        }

	def jq_budgetupdates_list = {
		def sortIndex = "id"
		def sortOrder  = params.sord ?: 'desc'

		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1

		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def result = AttributeValue.createCriteria().list(max:maxRows, offset:rowOffset) {
			eq('objectClassName','CostCenter')
			eq('objectId',new Long(params.ccid?:0))
			attribute{
				or{
					and{
						eq('name','BudgetAuditTrail')
						eq('type','AutoBudgetUpdateByDonation')
					}
					and{
						eq('name','BalanceAuditTrail')
						eq('type','BalanceUpdate')
					}					
				}
			}
			order(sortIndex, sortOrder)
		}

		def totalRows = result.totalCount
		def numberOfPages = Math.ceil(totalRows / maxRows)
		
		def parsedBudgetValueMap
		def parsedConsumptionValueMap

		def jsonCells = result.collect {

			if(it.attribute.type=='AutoBudgetUpdateByDonation')
				parsedBudgetValueMap = financeService.parseAutoBudgetUpdateByDonationAuditTrailValue(it.value)
			else
				parsedBudgetValueMap = [:]

			if(it.attribute.type=='BalanceUpdate')
				parsedConsumptionValueMap = financeService.parseBalanceUpdateAuditTrailValue(it.value)
			else
				parsedConsumptionValueMap = [:]

			[cell: [
				it.dateCreated.format('dd-MM-yyyy HH:mm:ss'),
				it.creator,
				parsedBudgetValueMap?.oldBudget,
				parsedBudgetValueMap?(parsedBudgetValueMap?.oldBudget + parsedBudgetValueMap?.differenceBudget):'',
				parsedBudgetValueMap?.differenceBudget,
				parsedConsumptionValueMap?(parsedConsumptionValueMap?.newConsumption - parsedConsumptionValueMap?.differenceConsumption):'',
				parsedConsumptionValueMap?.newConsumption,
				parsedConsumptionValueMap?.differenceConsumption,
				it.value,
			    ], id: it.id]
		}
					
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		render jsonData as JSON
        }

	def jq_donationsummary_list = {
		def sortIndex = "id"
		def sortOrder  = params.sord ?: 'desc'

		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1

		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def cc = CostCenter.get(params.ccid?:-1)
		if(cc && !cc.isProfitCenter)
			cc = null

		def result = Donation.createCriteria().list() {
			//@TODO: Hardcoding REMOVE
			ge('fundReceiptDate',Date.parse('dd-MM-yyyy', '01-04-2015'))
			scheme{eq('cc',cc)}
			createAlias('mode','mode')
			projections{
				groupProperty("mode.name", 'mode.name')
				sum("amount")
			}
		}
		
		def totalRows = 1
		def numberOfPages = Math.ceil(totalRows / maxRows)

		def jsonCells = result.collect {
		[cell: [
			it[0],
			it[1]
		    ], id: -1]
		}
					
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		render jsonData as JSON
        }

	def jq_donations_list = {
		def sortIndex = "id"
		def sortOrder  = params.sord ?: 'desc'

		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1

		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def cc = CostCenter.get(params.ccid?:-1)
		if(cc && !cc.isProfitCenter)
			cc = null
		def result = Donation.createCriteria().list(max:maxRows, offset:rowOffset) {
			scheme{eq('cc',cc)}
			//@TODO: Hardcoding REMOVE
			ge('fundReceiptDate',Date.parse('dd-MM-yyyy', '01-04-2015'))
			order(sortIndex, sortOrder)
		}

		def totalRows = result.totalCount
		def numberOfPages = Math.ceil(totalRows / maxRows)

		def jsonCells = result.collect {
		[cell: [
			it.donatedBy?.toString(),
			it.amount,
			it.mode?.name,
			it.donationDate?.format('dd-MM-yyyy'),
			it.fundReceiptDate?.format('dd-MM-yyyy'),
			it.nvccReceiptBookNo,
			it.nvccReceiptNo
		    ], id: it.id]
		}
					
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		render jsonData as JSON
        }
        
        def locks(){}
        
        def updateLocks() {
        	log.debug("updateLocks:"+params) 
        	def msg = financeService.updateLocks(params)
        	redirect(action:'message',params:[msg:msg])
        }

}
