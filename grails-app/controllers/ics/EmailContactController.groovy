package ics

import grails.converters.JSON


class EmailContactController {
    def springSecurityService


    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [emailContactInstanceList: EmailContact.list(params), emailContactInstanceTotal: EmailContact.count()]
    }

    def create = {
        def emailContactInstance = new EmailContact()
        emailContactInstance.properties = params
        return [emailContactInstance: emailContactInstance]
    }

    def save = {
        	if (springSecurityService.isLoggedIn()) {
			params.creator=springSecurityService.principal.username
		}
		else
			params.creator=""
		params.updator=params.creator

        def emailContactInstance = new EmailContact(params)
        if (emailContactInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'emailContact.label', default: 'EmailContact'), emailContactInstance.id])}"
            //redirect(controller: "individual", action: "edit", id: emailContactInstance?.individual?.id)
            render "OK"
        }
        else {
            render(view: "create", model: [emailContactInstance: emailContactInstance])
        }
    }

    def show = {
        def emailContactInstance = EmailContact.get(params.id)
        if (!emailContactInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'emailContact.label', default: 'EmailContact'), params.id])}"
            redirect(action: "list")
        }
        else {
            [emailContactInstance: emailContactInstance]
        }
    }

    def edit = {
        def emailContactInstance = EmailContact.get(params.id)
        if (!emailContactInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'emailContact.label', default: 'EmailContact'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [emailContactInstance: emailContactInstance]
        }
    }

    def update = {
        def emailContactInstance = EmailContact.get(params.id)
        if (emailContactInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (emailContactInstance.version > version) {
                    
                    emailContactInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'emailContact.label', default: 'EmailContact')] as Object[], "Another user has updated this EmailContact while you were editing")
                    render(view: "edit", model: [emailContactInstance: emailContactInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            emailContactInstance.properties = params
            if (!emailContactInstance.hasErrors() && emailContactInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'emailContact.label', default: 'EmailContact'), emailContactInstance.id])}"
                redirect(action: "show", id: emailContactInstance.id)
            }
            else {
                render(view: "edit", model: [emailContactInstance: emailContactInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'emailContact.label', default: 'EmailContact'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def emailContactInstance = EmailContact.get(params.id)
        if (emailContactInstance) {
            try {
                emailContactInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'emailContact.label', default: 'EmailContact'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'emailContact.label', default: 'EmailContact'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'emailContact.label', default: 'EmailContact'), params.id])}"
            redirect(action: "list")
        }
    }
    
    def jq_email_list = {
                   def sortIndex = params.sidx ?: 'emailAddress'
                   def sortOrder  = params.sord ?: 'asc'
             
                   def maxRows = Integer.valueOf(params.rows)
                   def currentPage = Integer.valueOf(params.page) ?: 1
             
                   def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
             
             	def result = EmailContact.createCriteria().list(max:maxRows, offset:rowOffset) {
             		
             		if (params.'individual.id')
         		    			individual{
         		    			eq('id',new Long(params.'individual.id'))
         		    			}
         
             		
             		if (params.category)
             			ilike('category','%'+params.category + '%')
             
             		if (params.emailAddress)
             				ilike('emailAddress','%'+params.emailAddress + '%')
             
             		
             		order(sortIndex, sortOrder)
             
             	}
                   
                   def totalRows = result.totalCount
                   def numberOfPages = Math.ceil(totalRows / maxRows)
             
                   def jsonCells = result.collect {
                         [cell: [
                                    
                         	    it.category,
                         	    it.emailAddress
                         	    
                             ], id: it.id]
                     }
                     def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
                     render jsonData as JSON
                     }
             
             	def jq_edit_email = {
             	      log.debug('In jq_email_edit:'+params)
             	      def email = null
             	      def message = ""
             	      def state = "FAIL"
             	      def id
             	      def emailContact
             
             	      // determine our action
             	      switch (params.oper) {
             		case 'add':
             		
             		 		
             		  emailContact = new EmailContact(params)
             		
             		emailContact.creator=springSecurityService.principal.username
             		emailContact.updator = emailContact.creator
             		
             		  if (! emailContact.hasErrors() && emailContact.save()) {
             		    message = "Email Saved.."
             		    id = emailContact.id
             		    state = "OK"
             		  } else {
             		    emailContact.errors.allErrors.each {
             			log.debug(it)
             			}
             		    message = "Could Not Save Email"
             		  }
             		  break;
             		case 'del':
             		  	def idList = params.id.tokenize(',')
             		  	idList.each
             		  	{
             			  // check vehicle exists
             			  emailContact  = EmailContact.get(it)
             			  if (emailContact) {
             			    // delete vehicle
             			    if(!emailContact.delete())
             			    	{
             				    emailContact.errors.allErrors.each {
             					log.debug("In jq_email_edit: error in deleting email:"+ it)
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
             		  emailContact = EmailContact.get(params.id)
             		  if (emailContact) {
             		    // set the properties according to passed in parameters
             		    emailContact.properties = params
             			  
             		    if (! emailContact.hasErrors() && emailContact.save()) {
             		      message = "Email  ${emailContact.category} Updated"
             		      id = emailContact.id
             		      state = "OK"
             		    } else {
             			    emailContact.errors.allErrors.each {
             				println it
             				}
             		      message = "Could Not Update email"
             		    }
             		  }
             		  break;
              	 }
             
             	      def response = [message:message,state:state,id:id]
             
             	      render response as JSON
             	    }

}
