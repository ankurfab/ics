package ics
import grails.converters.JSON

class OtherContactController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [otherContactInstanceList: OtherContact.list(params), otherContactInstanceTotal: OtherContact.count()]
    }

    def create = {
        def otherContactInstance = new OtherContact()
        otherContactInstance.properties = params
        return [otherContactInstance: otherContactInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def otherContactInstance = new OtherContact(params)
        if (otherContactInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'otherContact.label', default: 'OtherContact'), otherContactInstance.id])}"
            redirect(action: "show", id: otherContactInstance.id)
        }
        else {
            render(view: "create", model: [otherContactInstance: otherContactInstance])
        }
    }

    def show = {
        def otherContactInstance = OtherContact.get(params.id)
        if (!otherContactInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'otherContact.label', default: 'OtherContact'), params.id])}"
            redirect(action: "list")
        }
        else {
            [otherContactInstance: otherContactInstance]
        }
    }

    def edit = {
        def otherContactInstance = OtherContact.get(params.id)
        if (!otherContactInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'otherContact.label', default: 'OtherContact'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [otherContactInstance: otherContactInstance]
        }
    }

    def update = {
        def otherContactInstance = OtherContact.get(params.id)
        if (otherContactInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (otherContactInstance.version > version) {
                    
                    otherContactInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'otherContact.label', default: 'OtherContact')] as Object[], "Another user has updated this OtherContact while you were editing")
                    render(view: "edit", model: [otherContactInstance: otherContactInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            otherContactInstance.properties = params
            if (!otherContactInstance.hasErrors() && otherContactInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'otherContact.label', default: 'OtherContact'), otherContactInstance.id])}"
                redirect(action: "show", id: otherContactInstance.id)
            }
            else {
                render(view: "edit", model: [otherContactInstance: otherContactInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'otherContact.label', default: 'OtherContact'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def otherContactInstance = OtherContact.get(params.id)
        if (otherContactInstance) {
            try {
                otherContactInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'otherContact.label', default: 'OtherContact'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'otherContact.label', default: 'OtherContact'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'otherContact.label', default: 'OtherContact'), params.id])}"
            redirect(action: "list")
        }
    }

     def jq_otherContact_list = {
     
     log.debug("jq_otherContact_list"+params)
                      def sortIndex = params.sidx ?: 'contactType'
                      def sortOrder  = params.sord ?: 'asc'
                
                      def maxRows = Integer.valueOf(params.rows)
                      def currentPage = Integer.valueOf(params.page) ?: 1
                
                      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
                
                	def result = OtherContact.createCriteria().list(max:maxRows, offset:rowOffset) {
                		
                		if (params.'individual.id')
            		    			individual{
            		    			eq('id',new Long(params.'individual.id'))
            		    			}
            
                		
                		if (params.category)
                			ilike('category','%'+params.category + '%')
                
                		if (params.contactType)
                				ilike('contactType','%'+params.contactType + '%')
                
                		if (params.contactValue)
                				ilike('contactValue','%'+params.contactValue + '%')
                
                		
                		order(sortIndex, sortOrder)
                
                	}
                      
                      def totalRows = result.totalCount
                      def numberOfPages = Math.ceil(totalRows / maxRows)
                
                      def jsonCells = result.collect {
                            [cell: [
                                       
                            	    it.category,
                            	    it.contactType,
                            	    it.contactValue
                            	    
                                ], id: it.id]
                        }
                        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
                        render jsonData as JSON
                        }
                
                	def jq_edit_otherContact = {
                	      log.debug('In jq_otherContact_edit:'+params)
                	      def email = null
                	      def message = ""
                	      def state = "FAIL"
                	      def id
                	      def otherContactContact
                
                	      // determine our action
                	      switch (params.oper) {
                		case 'add':
                		
                		 		
                		  otherContactContact = new OtherContact(params)
                		
                		otherContactContact.creator=springSecurityService.principal.username
                		otherContactContact.updator = otherContactContact.creator
                		
                		  if (! otherContactContact.hasErrors() && otherContactContact.save()) {
                		    message = "OtherContact Saved.."
                		    id = otherContactContact.id
                		    state = "OK"
                		  } else {
                		    otherContactContact.errors.allErrors.each {
                			log.debug(it)
                			}
                		    message = "Could Not Save OtherContact"
                		  }
                		  break;
                		case 'del':
                		  	def idList = params.id.tokenize(',')
                		  	idList.each
                		  	{
                			  // check vehicle exists
                			  otherContactContact  = OtherContact.get(it)
                			  if (otherContactContact) {
                			    
                			    if(!otherContactContact.delete())
                			    	{
                				    otherContactContact.errors.allErrors.each {
                					log.debug("In jq_otherContact_edit: error in deleting number:"+ it)
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
                		  
                		  otherContactContact = OtherContact.get(params.id)
                		  if (otherContactContact) {
                		    // set the properties according to passed in parameters
                		    otherContactContact.properties = params
                			  
                		    if (!otherContactContact.hasErrors() && otherContactContact.save()) {
                		      message = "Phone  ${otherContactContact.category} Updated"
                		      id = otherContactContact.id
                		      state = "OK"
                		    } else {
                			    otherContactContact.errors.allErrors.each {
                				println it
                				}
                		      message = "Could Not Update OtherContact"
                		    }
                		  }
                		  break;
                 	 }
                
                	      def response = [message:message,state:state,id:id]
                
                	      render response as JSON
            	    }
}
