package ics

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class CentreController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [centreInstanceList: Centre.list(params), centreInstanceTotal: Centre.count()]
    }

    def create() {
        [centreInstance: new Centre(params)]
    }

    def save() {
        params.creator=springSecurityService.principal.username
        params.updator=params.creator

        def centreInstance = new Centre(params)
        if (!centreInstance.save(flush: true)) {
            render(view: "create", model: [centreInstance: centreInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'centre.label', default: 'Centre'), centreInstance.id])
        redirect(action: "show", id: centreInstance.id)
    }

    def show() {
        def centreInstance = Centre.get(params.id)
        if (!centreInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'centre.label', default: 'Centre'), params.id])
            redirect(action: "list")
            return
        }

        [centreInstance: centreInstance]
    }

    def edit() {
        def centreInstance = Centre.get(params.id)
        if (!centreInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'centre.label', default: 'Centre'), params.id])
            redirect(action: "list")
            return
        }

        [centreInstance: centreInstance]
    }

    def update() {
        def centreInstance = Centre.get(params.id)
        if (!centreInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'centre.label', default: 'Centre'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (centreInstance.version > version) {
                centreInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'centre.label', default: 'Centre')] as Object[],
                          "Another user has updated this Centre while you were editing")
                render(view: "edit", model: [centreInstance: centreInstance])
                return
            }
        }

        params.updator=springSecurityService.principal.username
        centreInstance.properties = params

        if (!centreInstance.save(flush: true)) {
            render(view: "edit", model: [centreInstance: centreInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'centre.label', default: 'Centre'), centreInstance.id])
        redirect(action: "show", id: centreInstance.id)
    }

    def delete() {
        def centreInstance = Centre.get(params.id)
        if (!centreInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'centre.label', default: 'Centre'), params.id])
            redirect(action: "list")
            return
        }

        try {
            centreInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'centre.label', default: 'Centre'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'centre.label', default: 'Centre'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

// return JSON list of centres
    def jq_centre_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def centres = Centre.createCriteria().list(max:maxRows, offset:rowOffset) {
            // name case insensitive where the field contains with the search term
            if (params.name)
                ilike('name','%'+params.name + '%')
            if (params.address)
                ilike('address','%'+params.address + '%')
            if (params.description)
                ilike('description','%'+params.description + '%')

            order(sortIndex, sortOrder)
      }
      def totalRows = centres.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = centres.collect {
            [cell: [it.name,
            	it.address,
            	it.description
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }
    
	def jq_edit_centre = {
	      def centre = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add instruction sent
		  params.creator = springSecurityService.principal.username
		  params.updator = params.creator
		  centre = new Centre(params)
		  if (! centre.hasErrors() && centre.save()) {
		    message = "Centre ${centre.name} Added"
		    id = centre.id
		    state = "OK"
		  } else {
		    centre.errors.allErrors.each {
			println it
		    }		    
		    message = "Could Not Save Centre"
		  }
		  break;
		case 'del':
		  // check centre exists
		  centre = Centre.get(params.id)
		  if (centre) {
		    // delete centre
		    centre.delete()
		    message = "Centre  ${centre.name} Deleted"
		    state = "OK"
		  }
		  break;
		 default :
		  // edit action
		  // first retrieve the centre by its ID
		  centre = Centre.get(params.id)
		  if (centre) {
		    // set the properties according to passed in parameters
		  	params.updator = springSecurityService.principal.username
		    centre.properties = params
		    if (! centre.hasErrors() && centre.save()) {
		      message = "Centre  ${centre.name} Updated"
		      id = centre.id
		      state = "OK"
		    } else {
		    centre.errors.allErrors.each {
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

}
