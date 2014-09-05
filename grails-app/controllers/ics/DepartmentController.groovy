package ics

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class DepartmentController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [departmentInstanceList: Department.list(params), departmentInstanceTotal: Department.count()]
    }

    def create() {
        [departmentInstance: new Department(params)]
    }

    def save() {
        def departmentInstance = new Department(params)
        if (!departmentInstance.save(flush: true)) {
            render(view: "create", model: [departmentInstance: departmentInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'department.label', default: 'Department'), departmentInstance.id])
        redirect(action: "show", id: departmentInstance.id)
    }

    def show() {
        def departmentInstance = Department.get(params.id)
        if (!departmentInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), params.id])
            redirect(action: "list")
            return
        }

        [departmentInstance: departmentInstance]
    }

    def edit() {
        def departmentInstance = Department.get(params.id)
        if (!departmentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), params.id])
            redirect(action: "list")
            return
        }

        [departmentInstance: departmentInstance]
    }

    def update() {
        def departmentInstance = Department.get(params.id)
        if (!departmentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (departmentInstance.version > version) {
                departmentInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'department.label', default: 'Department')] as Object[],
                          "Another user has updated this Department while you were editing")
                render(view: "edit", model: [departmentInstance: departmentInstance])
                return
            }
        }

        departmentInstance.properties = params

        if (!departmentInstance.save(flush: true)) {
            render(view: "edit", model: [departmentInstance: departmentInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'department.label', default: 'Department'), departmentInstance.id])
        redirect(action: "show", id: departmentInstance.id)
    }

    def delete() {
        def departmentInstance = Department.get(params.id)
        if (!departmentInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), params.id])
            redirect(action: "list")
            return
        }

        try {
            departmentInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'department.label', default: 'Department'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'department.label', default: 'Department'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

// return JSON list of centres
    def jq_depcentre_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def deps = Department.createCriteria().list(max:maxRows, offset:rowOffset) {
            // name case insensitive where the field contains with the search term
            if (params.name)
                ilike('name','%'+params.name + '%')

            if (params.description)
                ilike('description','%'+params.description + '%')

            if (params.alias)
                ilike('alias','%'+params.alias + '%')

            if (params.'centre.id')
                eq('centre.id',new Long(params."centre.id"))

            order(sortIndex, sortOrder)
      }
      def totalRows = deps.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = deps.collect {
            [cell: [it.name,
            	it.description,
            	it.alias
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }

	def jq_edit_depcentre = {
	      def centre = null
	      if(params."centre.id")
	      	centre = Centre.get(params."centre.id")
	       
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
