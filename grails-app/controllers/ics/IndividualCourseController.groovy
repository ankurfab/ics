package ics

import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils


import org.springframework.dao.DataIntegrityViolationException


class IndividualCourseController {

   def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        def icInstanceList = []
        if(params."course.id")
        	{
        	def course = Course.get(params."course.id")
        	icInstanceList = IndividualCourse.findAllByCourse(course)
        	}
        else
        	icInstanceList = IndividualCourse.list()
        [individualCourseInstanceList: icInstanceList]
    }

    def create() {
        [individualCourseInstance: new IndividualCourse(params)]
    }

    def save() {
    
    if (springSecurityService.isLoggedIn()) {
    				params.creator=springSecurityService.principal.username
    			}
    			else
    				params.creator=""
    		params.updator=params.creator

        def individualCourseInstance = new IndividualCourse(params)
        if (!individualCourseInstance.save(flush: true)) {
            render(view: "create", model: [individualCourseInstance: individualCourseInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'individualCourse.label', default: 'IndividualCourse'), individualCourseInstance.id])
        redirect(action: "show", id: individualCourseInstance.id)
    }

    def show() {
        def individualCourseInstance = IndividualCourse.get(params.id)
        if (!individualCourseInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualCourse.label', default: 'IndividualCourse'), params.id])
            redirect(action: "list")
            return
        }

        [individualCourseInstance: individualCourseInstance]
    }

    def edit() {
        def individualCourseInstance = IndividualCourse.get(params.id)
        if (!individualCourseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualCourse.label', default: 'IndividualCourse'), params.id])
            redirect(action: "list")
            return
        }

        [individualCourseInstance: individualCourseInstance]
    }

    def update() {
        def individualCourseInstance = IndividualCourse.get(params.id)
        if (!individualCourseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualCourse.label', default: 'IndividualCourse'), params.id])
            redirect(action: "list")
            return
        }
        if (springSecurityService.isLoggedIn()) {
			params.updator=springSecurityService.principal.username
		}
		else
		params.updator="unknown"

        if (params.version) {
            def version = params.version.toLong()
            if (individualCourseInstance.version > version) {
                individualCourseInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'individualCourse.label', default: 'IndividualCourse')] as Object[],
                          "Another user has updated this IndividualCourse while you were editing")
                render(view: "edit", model: [individualCourseInstance: individualCourseInstance])
                return
            }
        }

        individualCourseInstance.properties = params

        if (!individualCourseInstance.save(flush: true)) {
            render(view: "edit", model: [individualCourseInstance: individualCourseInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'individualCourse.label', default: 'IndividualCourse'), individualCourseInstance.id])
        redirect(action: "show", id: individualCourseInstance.id)
    }

    def delete() {
        def individualCourseInstance = IndividualCourse.get(params.id)
        if (!individualCourseInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualCourse.label', default: 'IndividualCourse'), params.id])
            redirect(action: "list")
            return
        }

        try {
            individualCourseInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'individualCourse.label', default: 'IndividualCourse'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'individualCourse.label', default: 'IndividualCourse'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
    def jq_individualCourse_list = {
                       def sortIndex = params.sidx ?: 'course'
                       def sortOrder  = params.sord ?: 'asc'
                 
                       def maxRows = Integer.valueOf(params.rows)
                       def currentPage = Integer.valueOf(params.page) ?: 1
                 
                       def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
                 
                 	def result = IndividualCourse.createCriteria().list(max:maxRows, offset:rowOffset) {
                 		
                 		if (params.'individual.id')
             		    			individual{
             		    			eq('id',new Long(params.'individual.id'))
             		    			}
             
                 		
                 		if (params.'course.name')
                 			ilike('course','%'+params.'course.name' + '%')
                 
                 		
                 		
                 		order(sortIndex, sortOrder)
                 
                 	}
                       
                       def totalRows = result.totalCount
                       def numberOfPages = Math.ceil(totalRows / maxRows)
                 
                       def jsonCells = result.collect {
                             [cell: [
                                        
                             	    it.course.name,
                             	    
                             	    
                                 ], id: it.id]
                         }
                         def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
                         render jsonData as JSON
                         }
                 
                 	def jq_edit_individualCourse = {
                 	      log.debug('In jq_individualCourse_edit:'+params)
                 	      
                 	      def message = ""
                 	      def state = "FAIL"
                 	      def id
                 	      def individualCourse
                 
                 	      // determine our action
                 	      switch (params.oper) {
                 		case 'add':
                 		
                 		 		
                 		  individualCourse = new IndividualCourse(params)
                 		
                 		individualCourse.creator=springSecurityService.principal.username
                 		individualCourse.updator = individualCourse.creator
                 		
                 		  if (! individualCourse.hasErrors() && individualCourse.save()) {
                 		    message = "Course Saved.."
                 		    id = individualCourse.id
                 		    state = "OK"
                 		  } else {
                 		    individualCourse.errors.allErrors.each {
                 			log.debug(it)
                 			}
                 		    message = "Could Not Save Course"
                 		  }
                 		  break;
                 		case 'del':
                 		  	def idList = params.id.tokenize(',')
                 		  	idList.each
                 		  	{
                 			  // check 
                 			  individualCourse  = IndividualCourse.get(it)
                 			  if (individualCourse) {
                 			    // delete vehicle
                 			    if(!individualCourse.delete())
                 			    	{
                 				    individualCourse.errors.allErrors.each {
                 					log.debug("In jq_individualCourse_edit: error in deleting email:"+ it)
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
                 		  individualCourse = IndividualCourse.get(params.id)
                 		  if (individualCourse) {
                 		    // set the properties according to passed in parameters
                 		    individualCourse.properties = params
                 			  
                 		    if (! individualCourse.hasErrors() && individualCourse.save()) {
                 		      message = "Course  ${individualCourse.course} Updated"
                 		      id = individualCourse.id
                 		      state = "OK"
                 		    } else {
                 			    individualCourse.errors.allErrors.each {
                 				println it
                 				}
                 		      message = "Could Not Update course"
                 		    }
                 		  }
                 		  break;
                  	 }
                 
                 	      def response = [message:message,state:state,id:id]
                 
                 	      render response as JSON
                 	    }
                 	    
        def indcourseList = {
			    	    if (request.xhr) {
			    		render(template: "individualCourse", model: [individualid:params.'individual.id'])
			    		//render "Hare Krishna!!"
			    		return
			    	    }
	   }
	   
// return JSON list of courses
    def jq_depcourse_list = {
      log.debug("In jq_depcourse_list with params: "+params)
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def deps = IndividualCourse.createCriteria().list(max:maxRows, offset:rowOffset) {
            // name case insensitive where the field contains with the search term
            if (params.name)
                individual{
                	or{
                	ilike('legalName',params.name)
                	ilike('initiatedName',params.name)
                	}
                	}

            if (params.'course.id')
                eq('course.id',new Long(params."course.id"))

           switch(sortIndex) {
           	case 'name': 
			individual{
				 order('initiatedName', sortOrder)
				 order('legalName', sortOrder)           	
			}
			break
		default:
			order(sortIndex, sortOrder)
			break
           }
      }
      def totalRows = deps.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = deps.collect {
            [cell: [it.individual?.toString(),
            	VoiceContact.findByIndividualAndCategory(it.individual,'CellPhone')?.number,
            	EmailContact.findByIndividualAndCategory(it.individual,'Personal')?.emailAddress,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }

	def jq_edit_depcourse = {
	      def course = null
	      if(params."course.id")
	      	course = Course.get(params."course.id")
	       
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
