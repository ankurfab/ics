package ics

import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils



import org.springframework.dao.DataIntegrityViolationException

class IndividualSevaController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        def individualSevaInstanceList = []
        if(params."seva.id")
        	{
        	def seva = Seva.get(params."seva.id")
        	individualSevaInstanceList = IndividualSeva.findAllBySeva(seva)
        	}
        else
        	individualSevaInstanceList = IndividualSeva.list()
        [individualSevaInstanceList: individualSevaInstanceList]
    }

    def create() {
        [individualSevaInstance: new IndividualSeva(params)]
    }

    def save() {
        def individualSevaInstance = new IndividualSeva(params)
        if (!individualSevaInstance.save(flush: true)) {
            render(view: "create", model: [individualSevaInstance: individualSevaInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'individualSeva.label', default: 'IndividualSeva'), individualSevaInstance.id])
        redirect(action: "show", id: individualSevaInstance.id)
    }

    def show() {
        def individualSevaInstance = IndividualSeva.get(params.id)
        if (!individualSevaInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualSeva.label', default: 'IndividualSeva'), params.id])
            redirect(action: "list")
            return
        }

        [individualSevaInstance: individualSevaInstance]
    }

    def edit() {
        def individualSevaInstance = IndividualSeva.get(params.id)
        if (!individualSevaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualSeva.label', default: 'IndividualSeva'), params.id])
            redirect(action: "list")
            return
        }

        [individualSevaInstance: individualSevaInstance]
    }

    def update() {
        def individualSevaInstance = IndividualSeva.get(params.id)
        if (!individualSevaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualSeva.label', default: 'IndividualSeva'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (individualSevaInstance.version > version) {
                individualSevaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'individualSeva.label', default: 'IndividualSeva')] as Object[],
                          "Another user has updated this IndividualSeva while you were editing")
                render(view: "edit", model: [individualSevaInstance: individualSevaInstance])
                return
            }
        }

        individualSevaInstance.properties = params

        if (!individualSevaInstance.save(flush: true)) {
            render(view: "edit", model: [individualSevaInstance: individualSevaInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'individualSeva.label', default: 'IndividualSeva'), individualSevaInstance.id])
        redirect(action: "show", id: individualSevaInstance.id)
    }

    def delete() {
        def individualSevaInstance = IndividualSeva.get(params.id)
        if (!individualSevaInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualSeva.label', default: 'IndividualSeva'), params.id])
            redirect(action: "list")
            return
        }

        try {
            individualSevaInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'individualSeva.label', default: 'IndividualSeva'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'individualSeva.label', default: 'IndividualSeva'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
    def jq_indSeva_list = {
                           def sortIndex = params.sidx ?: 'seva'
                           def sortOrder  = params.sord ?: 'asc'
                     
                           def maxRows = Integer.valueOf(params.rows)
                           def currentPage = Integer.valueOf(params.page) ?: 1
                     
                           def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
                     
                     	def result = IndividualSeva.createCriteria().list(max:maxRows, offset:rowOffset) {
                     		
                     		if (params.'individual.id')
                 		    			individual{
                 		    			eq('id',new Long(params.'individual.id'))
                 		    			}
                 
                     		
                     		if (params.'seva.name')
                     			seva{
                     				ilike('name','%'+params.'seva.name' + '%')
                     			}

                                 if (params.rendered)
                     			eq('rendered',params.rendered)
                                 if (params.interested)
                     			eq('interested',params.interested)
                     
                     		                 
                     		
                     		order(sortIndex, sortOrder)
                     
                     	}
                           
                           def totalRows = result.totalCount
                           def numberOfPages = Math.ceil(totalRows / maxRows)
                     
                           def jsonCells = result.collect {
                                 [cell: [
                                            
                                 	    it.seva.name,
                                 	    it.rendered,
                                 	    it.interested,
                                 	    
                                     ], id: it.id]
                             }
                             def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
                             render jsonData as JSON
                             }
                     
                     	def jq_edit_indSeva = {
                     	      log.debug('In jq_indSeva_edit:'+params)
                     	      //def email = null
                     	      def message = ""
                     	      def state = "FAIL"
                     	      def id
                     	      def indSeva
                     
                     	      // determine our action
                     	      switch (params.oper) {
                     		case 'add':
                     		
                     		 		
                     		  indSeva = new IndividualSeva(params)
                     		  indSeva.status='VALID'
                     		  indSeva.creator=indSeva.updator=springSecurityService.principal.username
                     		  
                     		
                     		
                     		  if (!indSeva.hasErrors() && indSeva.save()) {
                     		    message = "Seva Saved.."
                     		    id = indSeva.id
                     		    state = "OK"
                     		  } else {
                     		    indSeva.errors.allErrors.each {
                     			log.debug(it)
                     			}
                     		    message = "Could Not Save Seva"
                     		  }
                     		  break;
                     		case 'del':
                     		  	def idList = params.id.tokenize(',')
                     		  	idList.each
                     		  	{
                     			  // check vehicle exists
                     			  indSeva  = IndividualSeva.get(it)
                     			  if (indSeva) {
                     			    // delete 
                     			    if(!indSeva.delete())
                     			    	{
                     				    indSeva.errors.allErrors.each {
                     					log.debug("In jq_indSeva_edit: error in deleting email:"+ it)
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
                     		  // first retrieve the vehicle by its ID
                     		  indSeva = IndividualSeva.get(params.id)
                     		  if (indSeva) {
                     		    // set the properties according to passed in parameters
                     		    indSeva.properties = params
                     			  
                     		    if (! indSeva.hasErrors() && indSeva.save()) {
                     		      message = "Seva  ${indSeva.category} Updated"
                     		      id = indSeva.id
                     		      state = "OK"
                     		    } else {
                     			    indSeva.errors.allErrors.each {
                     				println it
                     				}
                     		      message = "Could Not Update Seva"
                     		    }
                     		  }
                     		  break;
                      	 }
                     
                     	      def response = [message:message,state:state,id:id]
                     
                     	      render response as JSON
                     	    }

def indsevaList = {
	    if (request.xhr) {
		render(template: "grid", model: [individualid:params.'individual.id'])
		//render "Hare Krishna!!"
		return
	    }
	   }

// return JSON list of sevas
    def jq_depseva_list = {
      log.debug("In jq_depseva_list with params: "+params)
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def deps = IndividualSeva.createCriteria().list(max:maxRows, offset:rowOffset) {
            // name case insensitive where the field contains with the search term
            if (params.name)
                individual{
                	or{
                	ilike('legalName',params.name)
                	ilike('initiatedName',params.name)
                	}
                	}

            if (params.'seva.id')
                eq('seva.id',new Long(params."seva.id"))

           switch(sortIndex) {
           	case 'name': 
			individual{
				 order('initiatedName', sortOrder)
				 order('legalName', sortOrder)           	
			}
			break
		default:
			order(sortIndex, sortOrder)
			break
           }
      }
      def totalRows = deps.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = deps.collect {
            [cell: [it.individual?.toString(),
            	VoiceContact.findByIndividualAndCategory(it.individual,'CellPhone')?.number,
            	EmailContact.findByIndividualAndCategory(it.individual,'Personal')?.emailAddress,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }

	def jq_edit_depseva = {
	      def seva = null
	      if(params."seva.id")
	      	seva = Seva.get(params."seva.id")
	       
	      def department = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add instruction sent
		  params.creator = springSecurityService.principal.username
		  params.updator = params.creator
		  department = new Department(params)
		  if (! department.hasErrors() && department.save()) {
		    message = "Department ${department.name} Added"
		    id = department.id
		    state = "OK"
		  } else {
		    department.errors.allErrors.each {
			println it
		    }		    
		    message = "Could Not Save Department"
		  }
		  break;
		case 'del':
		  // check department exists
		  department = Department.get(params.id)
		  if (department) {
		    // delete department
		    department.delete()
		    message = "Department  ${department.name} Deleted"
		    state = "OK"
		  }
		  break;
		 default :
		  // edit action
		  // first retrieve the department by its ID
		  department = Department.get(params.id)
		  if (department) {
		    // set the properties according to passed in parameters
		  	params.updator = springSecurityService.principal.username
		    department.properties = params
		    if (! department.hasErrors() && department.save()) {
		      message = "Department  ${department.name} Updated"
		      id = department.id
		      state = "OK"
		    } else {
		    department.errors.allErrors.each {
			println it
		    }		    
		      message = "Could Not Update Department"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

}
