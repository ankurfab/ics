package ics

import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils



import org.springframework.dao.DataIntegrityViolationException


class IndividualCentreController {

       def springSecurityService


    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
	params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_COORDINATOR'))
        	{
        	//get the relevant centre
        	//first get the relevant role
        	def ir
        	def donationRole = Role.findByAuthority('ROLE_DONATION_COORDINATOR')
        	if(donationRole)
        		ir = IndividualRole.findWhere('individual.id':session.individualid,role:donationRole,status:'VALID')
        	if(ir)
        		{
			return [individualCentreInstanceList: IndividualCentre.findAllByCentreAndStatus(ir.centre,'VALID',params), individualCentreInstanceTotal: IndividualCentre.count()]
			}        		
        	}
        else
        	return [individualCentreInstanceList: IndividualCentre.list(params), individualCentreInstanceTotal: IndividualCentre.count()]
    }

    def create() {
        [individualCentreInstance: new IndividualCentre(params)]
    }

    def save() {
    
       if (springSecurityService.isLoggedIn()) {
       		params.creator=springSecurityService.principal.username
       	}
       	else
       		params.creator=""
	params.updator=params.creator
	
        def individualCentreInstance = new IndividualCentre(params)
        if (!individualCentreInstance.save(flush: true)) {
            render(view: "create", model: [individualCentreInstance: individualCentreInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'individualCentre.label', default: 'IndividualCentre'), individualCentreInstance.id])
        redirect(action: "show", id: individualCentreInstance.id)
    }

    def show() {
        def individualCentreInstance = IndividualCentre.get(params.id)
        if (!individualCentreInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualCentre.label', default: 'IndividualCentre'), params.id])
            redirect(action: "list")
            return
        }

        [individualCentreInstance: individualCentreInstance]
    }

    def edit() {
        def individualCentreInstance = IndividualCentre.get(params.id)
        if (!individualCentreInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualCentre.label', default: 'IndividualCentre'), params.id])
            redirect(action: "list")
            return
        }

        [individualCentreInstance: individualCentreInstance]
    }

    def update() {
        def individualCentreInstance = IndividualCentre.get(params.id)
        if (!individualCentreInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualCentre.label', default: 'IndividualCentre'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (individualCentreInstance.version > version) {
                individualCentreInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'individualCentre.label', default: 'IndividualCentre')] as Object[],
                          "Another user has updated this IndividualCentre while you were editing")
                render(view: "edit", model: [individualCentreInstance: individualCentreInstance])
                return
            }
        }

       if (springSecurityService.isLoggedIn()) {
       			params.updator=springSecurityService.principal.username
       		}
       		else
       		params.updator="unknown"
               individualLanguageInstance.properties = params

        individualCentreInstance.properties = params

        if (!individualCentreInstance.save(flush: true)) {
            render(view: "edit", model: [individualCentreInstance: individualCentreInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'individualCentre.label', default: 'IndividualCentre'), individualCentreInstance.id])
        redirect(action: "show", id: individualCentreInstance.id)
    }

    def delete() {
        def individualCentreInstance = IndividualCentre.get(params.id)
        if (!individualCentreInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualCentre.label', default: 'IndividualCentre'), params.id])
            redirect(action: "list")
            return
        }

        try {
            individualCentreInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'individualCentre.label', default: 'IndividualCentre'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'individualCentre.label', default: 'IndividualCentre'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
    def jq_individualCentre_list = {
                           def sortIndex = params.sidx ?: 'centre'
                           def sortOrder  = params.sord ?: 'asc'
                     
                           def maxRows = Integer.valueOf(params.rows)
                           def currentPage = Integer.valueOf(params.page) ?: 1
                     
                           def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
                     
                     	def result = IndividualCentre.createCriteria().list(max:maxRows, offset:rowOffset) {
                     		
                     		if (params.'individual.id')
                 		    			individual{
                 		    			eq('id',new Long(params.'individual.id'))
                 		    			}
                 
                     		
                     		if (params.'centre.name')
                     			ilike('name','%'+params.'centre.name' + '%')
    
                                    if (params.status)
                     			ilike('status','%'+params.status + '%')
                     
                                 if (params.comments)
					ilike('comments','%'+params.comments + '%')

                     		
                     		
                     		order(sortIndex, sortOrder)
                     
                     	}
                           
                           def totalRows = result.totalCount
                           def numberOfPages = Math.ceil(totalRows / maxRows)
                     
                           def jsonCells = result.collect {
                                 [cell: [
                                            
                                 	    it.centre.name,
                                 	    it.status,
                                 	    it.comments
                                 	    
                                     ], id: it.id]
                             }
                             def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
                             render jsonData as JSON
                             }
                     
                     	def jq_edit_individualCentre = {
                     	      log.debug('In jq_individualCentre_edit:'+params)
                     	      
                     	      def message = ""
                     	      def state = "FAIL"
                     	      def id
                     	      def individualCentre
                     
                     	      // determine our action
                     	      switch (params.oper) {
                     		case 'add':
                     		
                     		 		
                     		  individualCentre = new IndividualCentre(params)
                     		
                     		individualCentre.creator=springSecurityService.principal.username
                     		individualCentre.updator = individualCentre.creator
                     		
                     		  if (! individualCentre.hasErrors() && individualCentre.save()) {
                     		    message = "Course Saved.."
                     		    id = individualCentre.id
                     		    state = "OK"
                     		  } else {
                     		    individualCentre.errors.allErrors.each {
                     			log.debug(it)
                     			}
                     		    message = "Could Not Save Centre"
                     		  }
                     		  break;
                     		case 'del':
                     		  	def idList = params.id.tokenize(',')
                     		  	idList.each
                     		  	{
                     			  // check 
                     			  individualCentre  = IndividualCentre.get(it)
                     			  if (individualCentre) {
                     			    
                     			    if(!individualCentre.delete())
                     			    	{
                     				    individualCentre.errors.allErrors.each {
                     					log.debug("In jq_individualCentre_edit: error in deleting Centre:"+ it)
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
                     		  // first retrieve  by its ID
                     		  individualCentre = IndividualCentre.get(params.id)
                     		  if (individualCentre) {
                     		    // set the properties according to passed in parameters
                     		    individualCentre.properties = params
                     			  
                     		    if (! individualCentre.hasErrors() && individualCentre.save()) {
                     		      message = "Centre  ${individualCentre.course} Updated"
                     		      id = individualCentre.id
                     		      state = "OK"
                     		    } else {
                     			    individualCentre.errors.allErrors.each {
                     				println it
                     				}
                     		      message = "Could Not Update Centre"
                     		    }
                     		  }
                     		  break;
                      	 }
                     
                     	      def response = [message:message,state:state,id:id]
                     
                     	      render response as JSON
                     	    }

    
    def indCenList = {
    			    	    if (request.xhr) {
    			    		render(template: "individualCentre", model: [individualid:params.'individual.id'])
    			    		//render "Hare Krishna!!"
    			    		return
    			    	    }
	   }
}
