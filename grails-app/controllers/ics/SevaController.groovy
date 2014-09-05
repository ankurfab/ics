package ics

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class SevaController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [sevaInstanceList: Seva.list(params), sevaInstanceTotal: Seva.count()]
    }

    def create() {
        [sevaInstance: new Seva(params)]
    }

    def save() {
        params.creator=springSecurityService.principal.username
        params.updator=params.creator
        def sevaInstance = new Seva(params)
        if (!sevaInstance.save(flush: true)) {
            render(view: "create", model: [sevaInstance: sevaInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'seva.label', default: 'Seva'), sevaInstance.id])
        redirect(action: "show", id: sevaInstance.id)
    }

    def show() {
        def sevaInstance = Seva.get(params.id)
        if (!sevaInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'seva.label', default: 'Seva'), params.id])
            redirect(action: "list")
            return
        }

        [sevaInstance: sevaInstance]
    }

    def edit() {
        def sevaInstance = Seva.get(params.id)
        if (!sevaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'seva.label', default: 'Seva'), params.id])
            redirect(action: "list")
            return
        }

        [sevaInstance: sevaInstance]
    }

    def update() {
        def sevaInstance = Seva.get(params.id)
        if (!sevaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'seva.label', default: 'Seva'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (sevaInstance.version > version) {
                sevaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'seva.label', default: 'Seva')] as Object[],
                          "Another user has updated this Seva while you were editing")
                render(view: "edit", model: [sevaInstance: sevaInstance])
                return
            }
        }

        params.updator=springSecurityService.principal.username
        sevaInstance.properties = params

        if (!sevaInstance.save(flush: true)) {
            render(view: "edit", model: [sevaInstance: sevaInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'seva.label', default: 'Seva'), sevaInstance.id])
        redirect(action: "show", id: sevaInstance.id)
    }

    def delete() {
        def sevaInstance = Seva.get(params.id)
        if (!sevaInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'seva.label', default: 'Seva'), params.id])
            redirect(action: "list")
            return
        }

        try {
            sevaInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'seva.label', default: 'Seva'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'seva.label', default: 'Seva'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

// return JSON list of sevas
    def jq_seva_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def sevas = Seva.createCriteria().list(max:maxRows, offset:rowOffset) {
            // name case insensitive where the field contains with the search term
            if (params.name)
                ilike('name',params.name)
            if (params.description)
                ilike('description',params.description)
            if (params.type)
                ilike('type',params.type)
            if (params.category)
                ilike('category',params.category)

            order(sortIndex, sortOrder)
      }
      def totalRows = sevas.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = sevas.collect {
            [cell: [it.name,
            	it.description,
            	it.type,
            	it.category
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }
    
	def jq_edit_seva = {
	      def seva = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add instruction sent
		  params.creator = springSecurityService.principal.username
		  params.updator = params.creator
		  seva = new Seva(params)
		  if (! seva.hasErrors() && seva.save()) {
		    message = "Seva ${seva.name} Added"
		    id = seva.id
		    state = "OK"
		  } else {
		    seva.errors.allErrors.each {
			println it
		    }		    
		    message = "Could Not Save Seva"
		  }
		  break;
		case 'del':
		  // check seva exists
		  seva = Seva.get(params.id)
		  if (seva) {
		    // delete seva
		    seva.delete()
		    message = "Seva  ${seva.name} Deleted"
		    state = "OK"
		  }
		  break;
		 default :
		  // edit action
		  // first retrieve the seva by its ID
		  seva = Seva.get(params.id)
		  if (seva) {
		    // set the properties according to passed in parameters
		  	params.updator = springSecurityService.principal.username
		    seva.properties = params
		    if (! seva.hasErrors() && seva.save()) {
		      message = "Seva  ${seva.name} Updated"
		      id = seva.id
		      state = "OK"
		    } else {
		    seva.errors.allErrors.each {
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
	    
	def gridList() {}


}
