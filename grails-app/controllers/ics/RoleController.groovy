package ics

import com.krishna.*
import grails.converters.JSON

class RoleController {
    def springSecurityService
    def dataService


    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 100, 100)
        [roleInstanceList: Role.list(params), roleInstanceTotal: Role.count()]
    }

    def create = {
        def roleInstance = new Role()
        roleInstance.properties = params
        return [roleInstance: roleInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def roleInstance = new Role(params)
        if (roleInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'role.label', default: 'Role'), roleInstance.id])}"
            //create role to integrate with spring security core, depending on flag in role
            //todo need to manage updates and deletes
            //def ir = new com.krishna.IcsRole()
            //ir.authority = "ROLE_"+roleInstance.name?.toUpperCase()
            redirect(action: "show", id: roleInstance.id)
        }
        else {
            render(view: "create", model: [roleInstance: roleInstance])
        }
    }

    def show = {
        def roleInstance = Role.get(params.id)
        if (!roleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), params.id])}"
            redirect(action: "list")
        }
        else {
            [roleInstance: roleInstance]
        }
    }

    def edit = {
        def roleInstance = Role.get(params.id)
        if (!roleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [roleInstance: roleInstance]
        }
    }

    def update = {
        def roleInstance = Role.get(params.id)
        if (roleInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (roleInstance.version > version) {
                    
                    roleInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'role.label', default: 'Role')] as Object[], "Another user has updated this Role while you were editing")
                    render(view: "edit", model: [roleInstance: roleInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            roleInstance.properties = params
            if (!roleInstance.hasErrors() && roleInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'role.label', default: 'Role'), roleInstance.id])}"
                redirect(action: "show", id: roleInstance.id)
            }
            else {
                render(view: "edit", model: [roleInstance: roleInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def roleInstance = Role.get(params.id)
        if (roleInstance) {
            try {
                roleInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'role.label', default: 'Role'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'role.label', default: 'Role'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), params.id])}"
            redirect(action: "list")
        }
    }

// return JSON list of roles
    def jq_role_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def roles = Role.createCriteria().list(max:maxRows, offset:rowOffset) {
            // name case insensitive where the field contains with the search term
            if (params.name)
                ilike('name',params.name)
            if (params.description)
                ilike('description',params.description)
            if (params.category)
                ilike('category',params.category)

            order(sortIndex, sortOrder)
      }
      def totalRows = roles.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = roles.collect {
            [cell: [it.name,
            	it.description,
            	it.category
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }
    
	def jq_edit_role = {
	      def role = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add instruction sent
		  params.creator = springSecurityService.principal.username
		  params.updator = params.creator
		  role = new Role(params)
		  if (! role.hasErrors() && role.save()) {
		    message = "Role ${role.name} Added"
		    id = role.id
		    state = "OK"
		  } else {
		    role.errors.allErrors.each {
			println it
		    }		    
		    message = "Could Not Save Role"
		  }
		  break;
		case 'del':
		  // check role exists
		  role = Role.get(params.id)
		  if (role) {
		    // delete role
		    role.delete()
		    message = "Role  ${role.name} Deleted"
		    state = "OK"
		  }
		  break;
		 default :
		  // edit action
		  // first retrieve the role by its ID
		  role = Role.get(params.id)
		  if (role) {
		    // set the properties according to passed in parameters
		  	params.updator = springSecurityService.principal.username
		    role.properties = params
		    if (! role.hasErrors() && role.save()) {
		      message = "Role  ${role.name} Updated"
		      id = role.id
		      state = "OK"
		    } else {
		    role.errors.allErrors.each {
			println it
		    }		    
		      message = "Could Not Update Role"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }
	    
	def gridlist() {}
	
	def pairs() {
		log.debug("inside pairs with params:"+params)
		def retMap =  dataService.indrolesInPairs(params)
		[id:params.id,retMap:retMap]
	}

	def sheet() {
		def results =  dataService.sheet(params)
		[id:params.id,results:results]
	}


}
