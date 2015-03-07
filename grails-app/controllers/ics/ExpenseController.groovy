package ics
import grails.converters.JSON

class ExpenseController {

    def financeService
    
    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [expenseInstanceList: Expense.list(params), expenseInstanceTotal: Expense.count()]
    }

    def create = {
        def expenseInstance = new Expense()
        expenseInstance.properties = params
        return [expenseInstance: expenseInstance]
    }

    def save = {
        def expenseInstance = new Expense(params)
        if (!expenseInstance.hasErrors() && expenseInstance.save()) {
            flash.message = "expense.created"
            flash.args = [expenseInstance.id]
            flash.defaultMessage = "Expense ${expenseInstance.id} created"
            redirect(action: "show", id: expenseInstance.id)
        }
        else {
            render(view: "create", model: [expenseInstance: expenseInstance])
        }
    }

    def show = {
        def expenseInstance = Expense.get(params.id)
        if (!expenseInstance) {
            flash.message = "expense.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Expense not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [expenseInstance: expenseInstance]
        }
    }

    def edit = {
        def expenseInstance = Expense.get(params.id)
        if (!expenseInstance) {
            flash.message = "expense.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Expense not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [expenseInstance: expenseInstance]
        }
    }

    def update = {
        def expenseInstance = Expense.get(params.id)
        if (expenseInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (expenseInstance.version > version) {
                    
                    expenseInstance.errors.rejectValue("version", "expense.optimistic.locking.failure", "Another user has updated this Expense while you were editing")
                    render(view: "edit", model: [expenseInstance: expenseInstance])
                    return
                }
            }
            expenseInstance.properties = params
            if (!expenseInstance.hasErrors() && expenseInstance.save()) {
                flash.message = "expense.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Expense ${params.id} updated"
                redirect(action: "show", id: expenseInstance.id)
            }
            else {
                render(view: "edit", model: [expenseInstance: expenseInstance])
            }
        }
        else {
            flash.message = "expense.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Expense not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def expenseInstance = Expense.get(params.id)
        if (expenseInstance) {
            try {
                expenseInstance.delete()
                flash.message = "expense.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Expense ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "expense.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Expense ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "expense.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Expense not found with id ${params.id}"
            redirect(action: "list")
        }
    }

    def gridlist() {}
    
    
    def jq_expense_list = 
             {
              def sortIndex = params.sidx ?: 'id'
              def sortOrder  = params.sord ?: 'asc'
        
              def maxRows = Integer.valueOf(params.rows)
              def currentPage = Integer.valueOf(params.page) ?: 1
        
              def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
          
        		
        	def result = Expense.createCriteria().list(max: maxRows, offset: rowOffset) 
        	{   
        	
        	   			if (params.department)
        	   				ilike('department', params.department)
        	   		
        	
        	   			if (params.raisedBy)
        	   				ilike('raisedBy', params.raisedBy)
        	   
        	   			if (params.type)
        	   				ilike('type', params.type)
        	   
        	   			if (params.category) 
        	   				ilike('category', params.category)
        	   				
        	   			if (params.description) 
        	   				ilike('description', params.description)	
        	   				
        	   			if (params.amount) 
					        ilike('amount', params.amount)	
					         
        	   			if (params.status)
        	   			        ilike('status', params.status)
        	   			
           			order(sortIndex, sortOrder)
        
        	}
              
              def totalRows = result.totalCount
              def numberOfPages = Math.ceil(totalRows / maxRows)
        
              def jsonCells = result.collect {
                    [cell: [
                    
                       
                    	    it.department.toString(),
                   	             it.raisedBy.toString(),
                   	              it.type,
                   	               it.category,
                   	                it.description,
                   	                 it.amount,
                   	                it.status,
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
			    // edit action
			    // first retrieve the customer by its ID
			    expense = Expense.get(params.id)
			    if (expense)
			    {
			     // def raisedByName = params.raisedBy
			     // params.remove(raisedBy)
			      
			      //params.'raisedBy.legalName' = raisedByName
			       if(params.raisedBy)
		         	params.remove('raisedBy')
			      
			      
			      expense.properties = params
			      if (! expense.hasErrors() && expense.save()) {
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
      
        def pending(Integer max) 
        {
        
        	  [count:financeService.expenseSummaryData()]
			  params.max = Math.min(max ?: 10, 100)
			  println(params.max) 
		  [ExpenseInstanceList: Expense.list(params), ExpenseInstanceTotal: Expense.count()]
        }
        
        
        def expenseapprovalform()
        {
        println params
        }
        
        def createexpense()
        {
         println params
        }
       
       def summaryData() {
       		def serl0 = [6,  11, 10, 13, 11,  7];
       	          def result = [serl0]
              render( result as JSON)
       }
        
        
	  
      def chart(){}
 
}
