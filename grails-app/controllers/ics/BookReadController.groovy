package ics

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import grails.converters.JSON

import org.springframework.dao.DataIntegrityViolationException

class BookReadController {

   def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        def bookReadInstanceList = []
        if(params."book.id")
        	{
        	def book = Book.get(params."book.id")
        	bookReadInstanceList = BookRead.findAllByBook(book)
        	}
        else
        	bookReadInstanceList = BookRead.list()
        [bookReadInstanceList: bookReadInstanceList]
    }

    def create() {
        [bookReadInstance: new BookRead(params)]
    }

    def save() {
        def bookReadInstance = new BookRead(params)
        if (!bookReadInstance.save(flush: true)) {
            render(view: "create", model: [bookReadInstance: bookReadInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'bookRead.label', default: 'BookRead'), bookReadInstance.id])
        redirect(action: "show", id: bookReadInstance.id)
    }

    def show() {
        def bookReadInstance = BookRead.get(params.id)
        if (!bookReadInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'bookRead.label', default: 'BookRead'), params.id])
            redirect(action: "list")
            return
        }

        [bookReadInstance: bookReadInstance]
    }

    def edit() {
        def bookReadInstance = BookRead.get(params.id)
        if (!bookReadInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bookRead.label', default: 'BookRead'), params.id])
            redirect(action: "list")
            return
        }

        [bookReadInstance: bookReadInstance]
    }

    def update() {
        def bookReadInstance = BookRead.get(params.id)
        if (!bookReadInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bookRead.label', default: 'BookRead'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (bookReadInstance.version > version) {
                bookReadInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'bookRead.label', default: 'BookRead')] as Object[],
                          "Another user has updated this BookRead while you were editing")
                render(view: "edit", model: [bookReadInstance: bookReadInstance])
                return
            }
        }

        bookReadInstance.properties = params

        if (!bookReadInstance.save(flush: true)) {
            render(view: "edit", model: [bookReadInstance: bookReadInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'bookRead.label', default: 'BookRead'), bookReadInstance.id])
        redirect(action: "show", id: bookReadInstance.id)
    }

    def delete() {
        def bookReadInstance = BookRead.get(params.id)
        if (!bookReadInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'bookRead.label', default: 'BookRead'), params.id])
            redirect(action: "list")
            return
        }

        try {
            bookReadInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'bookRead.label', default: 'BookRead'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'bookRead.label', default: 'BookRead'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
     def jq_bookRead_list = {
                           log.debug("in jq_bookRead_list:"+params)
                           def sortIndex = params.sidx ?: 'book'
                           def sortOrder  = params.sord ?: 'asc'
                     
                           def maxRows = Integer.valueOf(params.rows)
                           def currentPage = Integer.valueOf(params.page) ?: 1
                     
                           def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
                     
                     	def result = BookRead.createCriteria().list(max:maxRows, offset:rowOffset) {
                     		
                     		if (params.'individual.id')
                 		    			individual{
                 		    			eq('id',new Long(params.'individual.id'))
                 		    			}
                 
                     		
                     		if (params.'book.name')
                     			ilike('book','%'+params.'book.name' + '%')
                     
                     		
                     		
                     		order(sortIndex, sortOrder)
                     
                     	}
                           
                           def totalRows = result.totalCount
                           def numberOfPages = Math.ceil(totalRows / maxRows)
                     
                           def jsonCells = result.collect {
                                 [cell: [
                                            
                                 	    it.book.name,
                                 	    
                                 	    
                                     ], id: it.id]
                             }
                             def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
                             render jsonData as JSON
                             }
                     
                     	def jq_edit_bookRead = {
                     	      log.debug('In jq_bookRead_edit:'+params)
                     	      
                     	      def message = ""
                     	      def state = "FAIL"
                     	      def id
                     	      def bookRead
                     
                     	      // determine our action
                     	      switch (params.oper) {
                     		case 'add':
                     		
                     		 		
                     		  bookRead = new BookRead(params)
                     		
                     		bookRead.creator=springSecurityService.principal.username
                     		bookRead.updator = bookRead.creator
                     		
                     		  if (! bookRead.hasErrors() && bookRead.save()) {
                     		    message = "Book Saved.."
                     		    id = bookRead.id
                     		    state = "OK"
                     		  } else {
                     		    bookRead.errors.allErrors.each {
                     			log.debug(it)
                     			}
                     		    message = "Could Not Save Book"
                     		  }
                     		  break;
                     		case 'del':
                     		  	def idList = params.id.tokenize(',')
                     		  	idList.each
                     		  	{
                     			  // check 
                     			  bookRead  = BookRead.get(it)
                     			  if (bookRead) {
                     			    // delete 
                     			    if(!bookRead.delete())
                     			    	{
                     				    bookRead.errors.allErrors.each {
                     					log.debug("In jq_bookRead_edit: error in deleting Book:"+ it)
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
                     		  bookRead = BookRead.get(params.id)
                     		  if (bookRead) {
                     		    // set the properties according to passed in parameters
                     		    bookRead.properties = params
                     			  
                     		    if (! bookRead.hasErrors() && bookRead.save()) {
                     		      message = "Course  ${bookRead.book} Updated"
                     		      id = bookRead.id
                     		      state = "OK"
                     		    } else {
                     			    bookRead.errors.allErrors.each {
                     				println it
                     				}
                     		      message = "Could Not Update Book"
                     		    }
                     		  }
                     		  break;
                      	 }
                     
                     	      def response = [message:message,state:state,id:id]
                     
                     	      render response as JSON
                     	    }

// return JSON list of books
    def jq_depbook_list = {
      log.debug("In jq_depbook_list with params: "+params)
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def deps = BookRead.createCriteria().list(max:maxRows, offset:rowOffset) {
            // name case insensitive where the field contains with the search term
            if (params.name)
                individual{
                	or{
                	ilike('legalName',params.name)
                	ilike('initiatedName',params.name)
                	}
                	}

            if (params.'book.id')
                eq('book.id',new Long(params."book.id"))

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

	def jq_edit_depbook = {
	      def book = null
	      if(params."book.id")
	      	book = Book.get(params."book.id")
	       
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
