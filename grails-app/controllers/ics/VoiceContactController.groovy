package ics

import grails.converters.JSON


class VoiceContactController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [voiceContactInstanceList: VoiceContact.list(params), voiceContactInstanceTotal: VoiceContact.count()]
    }

    def create = {
        def voiceContactInstance = new VoiceContact()
        voiceContactInstance.properties = params
        return [voiceContactInstance: voiceContactInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def voiceContactInstance = new VoiceContact(params)
        if (voiceContactInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'voiceContact.label', default: 'VoiceContact'), voiceContactInstance.id])}"
            //redirect(controller: "individual", action: "edit", id: voiceContactInstance?.individual?.id)
            render "OK"
        }
        else {
            render(view: "create", model: [voiceContactInstance: voiceContactInstance])
        }
    }

    def show = {
        def voiceContactInstance = VoiceContact.get(params.id)
        if (!voiceContactInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'voiceContact.label', default: 'VoiceContact'), params.id])}"
            redirect(action: "list")
        }
        else {
            [voiceContactInstance: voiceContactInstance]
        }
    }

    def edit = {
        def voiceContactInstance = VoiceContact.get(params.id)
        if (!voiceContactInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'voiceContact.label', default: 'VoiceContact'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [voiceContactInstance: voiceContactInstance]
        }
    }

    def update = {
        def voiceContactInstance = VoiceContact.get(params.id)
        if (voiceContactInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (voiceContactInstance.version > version) {
                    
                    voiceContactInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'voiceContact.label', default: 'VoiceContact')] as Object[], "Another user has updated this VoiceContact while you were editing")
                    render(view: "edit", model: [voiceContactInstance: voiceContactInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            voiceContactInstance.properties = params
            if (!voiceContactInstance.hasErrors() && voiceContactInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'voiceContact.label', default: 'VoiceContact'), voiceContactInstance.id])}"
                redirect(action: "show", id: voiceContactInstance.id)
            }
            else {
                render(view: "edit", model: [voiceContactInstance: voiceContactInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'voiceContact.label', default: 'VoiceContact'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def voiceContactInstance = VoiceContact.get(params.id)
        if (voiceContactInstance) {
            try {
                voiceContactInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'voiceContact.label', default: 'VoiceContact'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'voiceContact.label', default: 'VoiceContact'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'voiceContact.label', default: 'VoiceContact'), params.id])}"
            redirect(action: "list")
        }
    }
     def jq_mobile_list = {
     
     log.debug("jq_mobile_list"+params)
                      def sortIndex = params.sidx ?: 'number'
                      def sortOrder  = params.sord ?: 'asc'
                
                      def maxRows = Integer.valueOf(params.rows)
                      def currentPage = Integer.valueOf(params.page) ?: 1
                
                      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
                
                	def result = VoiceContact.createCriteria().list(max:maxRows, offset:rowOffset) {
                		
                		if (params.'individual.id')
            		    			individual{
            		    			eq('id',new Long(params.'individual.id'))
            		    			}
            
                		
                		if (params.category)
                			ilike('category','%'+params.category + '%')
                
                		if (params.number)
                				ilike('number','%'+params.number + '%')
                
                		
                		order(sortIndex, sortOrder)
                
                	}
                      
                      def totalRows = result.totalCount
                      def numberOfPages = Math.ceil(totalRows / maxRows)
                
                      def jsonCells = result.collect {
                            [cell: [
                                       
                            	    it.category,
                            	    it.number
                            	    
                                ], id: it.id]
                        }
                        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
                        render jsonData as JSON
                        }
                
                	def jq_edit_mobile = {
                	      log.debug('In jq_mobile_edit:'+params)
                	      def email = null
                	      def message = ""
                	      def state = "FAIL"
                	      def id
                	      def mobileContact
                
                	      // determine our action
                	      switch (params.oper) {
                		case 'add':
                		
                		 		
                		  mobileContact = new VoiceContact(params)
                		
                		mobileContact.creator=springSecurityService.principal.username
                		mobileContact.updator = mobileContact.creator
                		
                		  if (! mobileContact.hasErrors() && mobileContact.save()) {
                		    message = "Email Saved.."
                		    id = mobileContact.id
                		    state = "OK"
                		  } else {
                		    mobileContact.errors.allErrors.each {
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
                			  mobileContact  = VoiceContact.get(it)
                			  if (mobileContact) {
                			    
                			    if(!mobileContact.delete())
                			    	{
                				    mobileContact.errors.allErrors.each {
                					log.debug("In jq_mobile_edit: error in deleting number:"+ it)
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
                		  
                		  mobileContact = VoiceContact.get(params.id)
                		  if (mobileContact) {
                		    // set the properties according to passed in parameters
                		    mobileContact.properties = params
                			  
                		    if (!mobileContact.hasErrors() && mobileContact.save()) {
                		      message = "Phone  ${mobileContact.category} Updated"
                		      id = mobileContact.id
                		      state = "OK"
                		    } else {
                			    mobileContact.errors.allErrors.each {
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
