package ics

import grails.converters.JSON
class AddressController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [addressInstanceList: Address.list(params), addressInstanceTotal: Address.count()]
    }

    def create = {
        def addressInstance = new Address()
        addressInstance.properties = params
        return [addressInstance: addressInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def addressInstance = new Address(params)
        if (addressInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'address.label', default: 'Address'), addressInstance.id])}"
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
		{
			redirect(controller: "individual", action: "editPatronCare", id: addressInstance?.individual?.id)
		}
		else
	            redirect(controller: "individual", action: "edit", id: addressInstance?.individual?.id)
        }
        else {
            render(view: "create", model: [addressInstance: addressInstance])
        }
    }

    def show = {
        def addressInstance = Address.get(params.id)
        if (!addressInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'address.label', default: 'Address'), params.id])}"
            redirect(action: "list")
        }
        else {
            [addressInstance: addressInstance]
        }
    }

    def edit = {
        def addressInstance = Address.get(params.id)
        if (!addressInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'address.label', default: 'Address'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [addressInstance: addressInstance]
        }
    }

    def update = {
        def addressInstance = Address.get(params.id)
        if (addressInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (addressInstance.version > version) {
                    
                    addressInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'address.label', default: 'Address')] as Object[], "Another user has updated this Address while you were editing")
                    render(view: "edit", model: [addressInstance: addressInstance])
                    return
                }
            }

	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            addressInstance.properties = params
            if (!addressInstance.hasErrors() && addressInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'address.label', default: 'Address'), addressInstance.id])}"
                redirect(action: "show", id: addressInstance.id)
            }
            else {
                render(view: "edit", model: [addressInstance: addressInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'address.label', default: 'Address'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def addressInstance = Address.get(params.id)
        if (addressInstance) {
            try {
                addressInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'address.label', default: 'Address'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'address.label', default: 'Address'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'address.label', default: 'Address'), params.id])}"
            redirect(action: "list")
        }
    }
    
    def findDepAddressAsJSON = {   
 	response.setHeader("Cache-Control", "no-store")
   
    		def results
    		if (params.individualid!=null)
    			{
    			def ind = Individual.get(params.individualid)
    			def addrs = Address.findAllByIndividual(ind,[sort:"addressLine1"])

		results = addrs.collect {
		    [  id: it.id,
		       name: it.toString() ]
		}

		def data = [ result: results ]
		render data as JSON
		println "result->"+data
		}

    }
    def jq_address_list = {
                            def sortIndex = params.sidx ?: 'city'
                            def sortOrder  = params.sord ?: 'asc'
                      
                            def maxRows = Integer.valueOf(params.rows)
                            def currentPage = Integer.valueOf(params.page) ?: 1
                      
                            def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
                      
                      	def result = Address.createCriteria().list(max:maxRows, offset:rowOffset) {
                      		
                      		if (params.'individual.id')
                  		    			individual{
                  		    			eq('id',new Long(params.'individual.id'))
                  		    			}
                  
                      		
                      		if (params.category)
                      			ilike('category','%'+params.category + '%')
                      
                      		if (params.addressLine1)
                      			  ilike('addressLine1','%'+params.addressLine1 + '%')
                      				
                      	       if (params.city)
    			                  ilike('city','%'+params.city + '%')
                      
                                   if (params.state)
    		                    	ilike('state','%'+params.state + '%')
                      
                                   if (params.country)
    			                 ilike('country','%'+params.country + '%')
    			       if (params.pincode)
    			                 ilike('pincode','%'+params.pincode + '%')
                      
                      		
                      		order(sortIndex, sortOrder)
                      
                      	}
                            
                            def totalRows = result.totalCount
                            def numberOfPages = Math.ceil(totalRows / maxRows)
                      
                            def jsonCells = result.collect {
                                  [cell: [
                                             
                                  	    it.category,
                                  	    it.addressLine1,
                                  	    it.city?.name,
                                  	    it.state?.name,
                                  	    it.country?.name,
                                  	    it.pincode
                                  	    
                                      ], id: it.id]
                              }
                              def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
                              render jsonData as JSON
                              }
                      
                      	def jq_edit_address = {
                      	      log.debug('In jq_address_edit:'+params)
                      	      def email = null
                      	      def message = ""
                      	      def state = "FAIL"
                      	      def id
                      	      def address
                      
                      	      // determine our action
                      	      switch (params.oper) {
                      		case 'add':
                      		
                      		 		
                      		  address = new Address(params)
                      		
                      		address.creator=springSecurityService.principal.username
                      		address.updator = address.creator
                      		
                      		  if (!address.hasErrors() && address.save()) {
                      		    message = "Address Saved.."
                      		    id = address.id
                      		    state = "OK"
                      		  } else {
                      		    address.errors.allErrors.each {
                      			log.debug(it)
                      			}
                      		    message = "Could Not Save Address"
                      		  }
                      		  break;
                      		case 'del':
                      		  	def idList = params.id.tokenize(',')
                      		  	idList.each
                      		  	{
                      			  
                      			  address  = Address.get(it)
                      			  if (address) {
                      			    
                      			    if(!address.delete())
                      			    	{
                      				    address.errors.allErrors.each {
                      					log.debug("In jq_address_edit: error in deleting address:"+ it)
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
                      		  
                      		  address = Address.get(params.id)
                      		  if (address) {
                      		    // set the properties according to passed in parameters
                      		    address.properties = params
                      			  
                      		    if (!address.hasErrors() && address.save()) {
                      		      message = "Address  ${address.category} Updated"
                      		      id = address.id
                      		      state = "OK"
                      		    } else {
                      			    address.errors.allErrors.each {
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
