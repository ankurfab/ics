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
        		if(params.status)
        			eq('status',params.status)
        		order("expectedStartDate", "asc")
        		order("priority", "asc")
        	}
        log.debug("Project:list:params:"+params+":result"+result)
        [projectInstanceList: result]
    }

    def create = {
      if(SpringSecurityUtils.ifAllGranted('ROLE_CC_OWNER')) {
        //check if allowed in the first place
        def costCenter = financeService.getCostCenter(session.individualid)
       	return financeService.check(costCenter)
      }
      else
      	flash.message="Operation not allowed!!"

      	redirect(action: "index")
    }

    def save = {
      if(SpringSecurityUtils.ifAllGranted('ROLE_CC_OWNER')) {
      	params.costCenter = financeService.getCostCenter(session.individualid)
        def response = financeService.saveProject(params)
        if(!response.balCheck.allow) {
        	render(view: "create", model: [projectInstance: response.projectInstance,balCheck:response.balCheck])
        	return
        }
        else
        	flash.message=response.projectInstance?.ref +" "+response.message
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
	    if(SpringSecurityUtils.ifAllGranted('ROLE_CCAT_OWNER') && projectInstance.status=='SUBMITTED_REQUEST') {            
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

    def delete = {
        def projectInstance = Project.get(params.id)
        if (projectInstance) {
            try {
                projectInstance.delete()
                flash.message = "project.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Project ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "project.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Project ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "project.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Project not found with id ${params.id}"
            redirect(action: "list")
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
    	   				ge('expectedStartDate', Date.parse('dd-MM-yyyy', params.expectedStartDate))	
    	   				
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
                	it.type,
                	it.amount,
                	it.expectedStartDate?.format('dd-MM-yyyy'),
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
	else {
	    render(template: "advance", model: [projectInstance: projectInstance])
	}
    }

    def printApproval() {
    	def projectInstance = Project.get(params.projectid)
    	render(template: "expenseApproval", model: [projectInstance: projectInstance])
    }

    def printReimbursement() {
    	def projectInstance = Project.get(params.projectid)
    	def expenses = Expense.findAllByProject(projectInstance)
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

}
