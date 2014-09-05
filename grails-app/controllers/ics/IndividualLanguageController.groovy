package ics

import grails.converters.JSON


import org.springframework.dao.DataIntegrityViolationException

class IndividualLanguageController {

    def springSecurityService


    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [individualLanguageInstanceList: IndividualLanguage.list(params), individualLanguageInstanceTotal: IndividualLanguage.count()]
    }

    def create() {
        [individualLanguageInstance: new IndividualLanguage(params)]
    }

    def save() {
    
    if (springSecurityService.isLoggedIn()) {
    		params.creator=springSecurityService.principal.username
    	}
    	else
    		params.creator=""
    	params.updator=params.creator

        def individualLanguageInstance = new IndividualLanguage(params)
        if (!individualLanguageInstance.save(flush: true)) {
            render(view: "create", model: [individualLanguageInstance: individualLanguageInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'individualLanguage.label', default: 'IndividualLanguage'), individualLanguageInstance.id])
        redirect(action: "show", id: individualLanguageInstance.id)
    }

    def show() {
        def individualLanguageInstance = IndividualLanguage.get(params.id)
        if (!individualLanguageInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualLanguage.label', default: 'IndividualLanguage'), params.id])
            redirect(action: "list")
            return
        }

        [individualLanguageInstance: individualLanguageInstance]
    }

    def edit() {
        def individualLanguageInstance = IndividualLanguage.get(params.id)
        if (!individualLanguageInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualLanguage.label', default: 'IndividualLanguage'), params.id])
            redirect(action: "list")
            return
        }

        [individualLanguageInstance: individualLanguageInstance]
    }

    def update() {
        def individualLanguageInstance = IndividualLanguage.get(params.id)
        if (!individualLanguageInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualLanguage.label', default: 'IndividualLanguage'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (individualLanguageInstance.version > version) {
                individualLanguageInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'individualLanguage.label', default: 'IndividualLanguage')] as Object[],
                          "Another user has updated this IndividualLanguage while you were editing")
                render(view: "edit", model: [individualLanguageInstance: individualLanguageInstance])
                return
            }
        }
        if (springSecurityService.isLoggedIn()) {
			params.updator=springSecurityService.principal.username
		}
		else
		params.updator="unknown"
        individualLanguageInstance.properties = params

        if (!individualLanguageInstance.save(flush: true)) {
            render(view: "edit", model: [individualLanguageInstance: individualLanguageInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'individualLanguage.label', default: 'IndividualLanguage'), individualLanguageInstance.id])
        redirect(action: "show", id: individualLanguageInstance.id)
    }

    def delete() {
        def individualLanguageInstance = IndividualLanguage.get(params.id)
        if (!individualLanguageInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualLanguage.label', default: 'IndividualLanguage'), params.id])
            redirect(action: "list")
            return
        }

        try {
            individualLanguageInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'individualLanguage.label', default: 'IndividualLanguage'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'individualLanguage.label', default: 'IndividualLanguage'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

def jq_individualLanguage_list = {
                       def sortIndex = params.sidx ?: 'language'
                       def sortOrder  = params.sord ?: 'asc'
                 
                       def maxRows = Integer.valueOf(params.rows)
                       def currentPage = Integer.valueOf(params.page) ?: 1
                 
                       def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
                 
                 	def result = IndividualLanguage.createCriteria().list(max:maxRows, offset:rowOffset) {
                 		
                 		if (params.'individual.id')
             		    			individual{
             		    			eq('id',new Long(params.'individual.id'))
             		    			}
             
                 		
                 		if (params.'language.name')
                 			ilike('name','%'+'language.name' + '%')
                 		
                 		if (params.motherTongue)
				          ilike('motherTongue','%'+params.motherTongue + '%')

                 		                		
                 		if (params.readFluency)
                 			ilike('readFluency','%'+params.readFluency + '%')
                 		if (params.writeFluency)
                 			ilike('writeFluency','%'+params.writeFluency + '%')
                 		                 
                 		
                 		
                 		order(sortIndex, sortOrder)
                 
                 	}
                       
                       def totalRows = result.totalCount
                       def numberOfPages = Math.ceil(totalRows / maxRows)
                 
                       def jsonCells = result.collect {
                             [cell: [
                                        
                             	    it.language.name,
                             	    it.motherTongue,
                             	    it.readFluency,
                             	    it.writeFluency
                             	                             	    
                             	    
                                 ], id: it.id]
                         }
                         def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
                         render jsonData as JSON
                         }
                 
                 	def jq_edit_individualLanguage = {
                 	      log.debug('In jq_individualLanguage_edit:'+params)
                 	      
                 	      def message = ""
                 	      def state = "FAIL"
                 	      def id
                 	      def individualLanguage
                 
                 	      // determine our action
                 	      switch (params.oper) {
                 		case 'add':
                 		
                 		 		
                 		  individualLanguage = new IndividualLanguage(params)
                 		
                 		individualLanguage.creator=springSecurityService.principal.username
                 		individualLanguage.updator = individualLanguage.creator
                 		
                 		  if (! individualLanguage.hasErrors() && individualLanguage.save()) {
                 		    message = "Course Saved.."
                 		    id = individualLanguage.id
                 		    state = "OK"
                 		  } else {
                 		    individualLanguage.errors.allErrors.each {
                 			log.debug(it)
                 			}
                 		    message = "Could Not Save Language"
                 		  }
                 		  break;
                 		case 'del':
                 		  	def idList = params.id.tokenize(',')
                 		  	idList.each
                 		  	{
                 			  // check 
                 			  individualLanguage  = IndividualLanguage.get(it)
                 			  if (individualLanguage) {
                 			    
                 			    if(!individualLanguage.delete())
                 			    	{
                 				    individualLanguage.errors.allErrors.each {
                 					log.debug("In jq_individualLanguage_edit: error in deleting email:"+ it)
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
                 		  individualLanguage = IndividualLanguage.get(params.id)
                 		  if (individualLanguage) {
                 		    // set the properties according to passed in parameters
                 		    individualLanguage.properties = params
                 			  
                 		    if (! individualLanguage.hasErrors() && individualLanguage.save()) {
                 		      message = "Language  ${individualLanguage.language} Updated"
                 		      id = individualLanguage.id
                 		      state = "OK"
                 		    } else {
                 			    individualLanguage.errors.allErrors.each {
                 				println it
                 				}
                 		      message = "Could Not Update Language"
                 		    }
                 		  }
                 		  break;
                  	 }
                 
                 	      def response = [message:message,state:state,id:id]
                 
                 	      render response as JSON
                 	    }
                 	    
        def indlangList = {
			    	    if (request.xhr) {
			    		render(template: "individualLanguage", model: [individualid:params.'individual.id'])
			    		//render "Hare Krishna!!"
			    		return
			    	    }
	   }


}
