package ics

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class CourseController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [courseInstanceList: Course.list(params), courseInstanceTotal: Course.count()]
    }

    def create() {
        [courseInstance: new Course(params)]
    }

    def save() {
        params.creator=springSecurityService.principal.username
        params.updator=params.creator
        
        def courseInstance = new Course(params)
        if (!courseInstance.save(flush: true)) {
            render(view: "create", model: [courseInstance: courseInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'course.label', default: 'Course'), courseInstance.id])
        redirect(action: "show", id: courseInstance.id)
    }

    def show() {
        def courseInstance = Course.get(params.id)
        if (!courseInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'course.label', default: 'Course'), params.id])
            redirect(action: "list")
            return
        }

        [courseInstance: courseInstance]
    }

    def edit() {
        def courseInstance = Course.get(params.id)
        if (!courseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'course.label', default: 'Course'), params.id])
            redirect(action: "list")
            return
        }

        [courseInstance: courseInstance]
    }

    def update() {
        def courseInstance = Course.get(params.id)
        if (!courseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'course.label', default: 'Course'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (courseInstance.version > version) {
                courseInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'course.label', default: 'Course')] as Object[],
                          "Another user has updated this Course while you were editing")
                render(view: "edit", model: [courseInstance: courseInstance])
                return
            }
        }

        params.updator=springSecurityService.principal.username
        courseInstance.properties = params

        if (!courseInstance.save(flush: true)) {
            render(view: "edit", model: [courseInstance: courseInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'course.label', default: 'Course'), courseInstance.id])
        redirect(action: "show", id: courseInstance.id)
    }

    def delete() {
        def courseInstance = Course.get(params.id)
        if (!courseInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'course.label', default: 'Course'), params.id])
            redirect(action: "list")
            return
        }

        try {
            courseInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'course.label', default: 'Course'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'course.label', default: 'Course'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
    
// return JSON list of courses
    def jq_course_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def courses = Course.createCriteria().list(max:maxRows, offset:rowOffset) {
            // name case insensitive where the field contains with the search term
            if (params.name)
                ilike('name',params.name)
            if (params.description)
                ilike('description',params.description)
            if (params.category)
                ilike('category',params.category)
            if (params.type)
                ilike('type',params.type)
	if (params.instructor)
		instructor{
			or {
				ilike('legalName',params.instructor)
				ilike('initiatedName',params.instructor)
			   }
			}
            order(sortIndex, sortOrder)
      }
      def totalRows = courses.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = courses.collect {
            [cell: [it.name,
            	it.description,
            	it.type,
            	it.category,
            	it.instructor?.toString()
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }
    
	def jq_edit_course = {
	      def course = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add instruction sent
		  params.creator = springSecurityService.principal.username
		  params.updator = params.creator
		  course = new Course(params)
		  if (! course.hasErrors() && course.save()) {
		    message = "Course ${course.name} Added"
		    id = course.id
		    state = "OK"
		  } else {
		    course.errors.allErrors.each {
			println it
		    }		    
		    message = "Could Not Save Course"
		  }
		  break;
		case 'del':
		  // check course exists
		  course = Course.get(params.id)
		  if (course) {
		    // delete course
		    course.delete()
		    message = "Course  ${course.name} Deleted"
		    state = "OK"
		  }
		  break;
		 default :
		  // edit action
		  // first retrieve the course by its ID
		  course = Course.get(params.id)
		  if (course) {
		    // set the properties according to passed in parameters
		  	params.updator = springSecurityService.principal.username
		    course.properties = params
		    if (! course.hasErrors() && course.save()) {
		      message = "Course  ${course.name} Updated"
		      id = course.id
		      state = "OK"
		    } else {
		    course.errors.allErrors.each {
			println it
		    }		    
		      message = "Could Not Update Course"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }
	    
	def gridList() {}    
}
