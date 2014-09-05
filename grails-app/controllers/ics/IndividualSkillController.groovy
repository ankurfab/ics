package ics

import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils


import org.springframework.dao.DataIntegrityViolationException

class IndividualSkillController {

    def springSecurityService


    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [individualSkillInstanceList: IndividualSkill.list(params), individualSkillInstanceTotal: IndividualSkill.count()]
    }

    def create() {
        [individualSkillInstance: new IndividualSkill(params)]
    }

    def save() {
    
        if (springSecurityService.isLoggedIn()) {
				params.creator=springSecurityService.principal.username
			}
			else
				params.creator=""
		params.updator=params.creator
		
        def individualSkillInstance = new IndividualSkill(params)
        if (!individualSkillInstance.save(flush: true)) {
            render(view: "create", model: [individualSkillInstance: individualSkillInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'individualSkill.label', default: 'IndividualSkill'), individualSkillInstance.id])
        redirect(action: "show", id: individualSkillInstance.id)
    }

    def show() {
        def individualSkillInstance = IndividualSkill.get(params.id)
        if (!individualSkillInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualSkill.label', default: 'IndividualSkill'), params.id])
            redirect(action: "list")
            return
        }

        [individualSkillInstance: individualSkillInstance]
    }

    def edit() {
        def individualSkillInstance = IndividualSkill.get(params.id)
        if (!individualSkillInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualSkill.label', default: 'IndividualSkill'), params.id])
            redirect(action: "list")
            return
        }

        [individualSkillInstance: individualSkillInstance]
    }

    def update() {
        def individualSkillInstance = IndividualSkill.get(params.id)
        if (!individualSkillInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualSkill.label', default: 'IndividualSkill'), params.id])
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
            if (individualSkillInstance.version > version) {
                individualSkillInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'individualSkill.label', default: 'IndividualSkill')] as Object[],
                          "Another user has updated this IndividualSkill while you were editing")
                render(view: "edit", model: [individualSkillInstance: individualSkillInstance])
                return
            }
        }

        individualSkillInstance.properties = params

        if (!individualSkillInstance.save(flush: true)) {
            render(view: "edit", model: [individualSkillInstance: individualSkillInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'individualSkill.label', default: 'IndividualSkill'), individualSkillInstance.id])
        redirect(action: "show", id: individualSkillInstance.id)
    }

    def delete() {
        def individualSkillInstance = IndividualSkill.get(params.id)
        if (!individualSkillInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualSkill.label', default: 'IndividualSkill'), params.id])
            redirect(action: "list")
            return
        }

        try {
            individualSkillInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'individualSkill.label', default: 'IndividualSkill'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'individualSkill.label', default: 'IndividualSkill'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
    
    def jq_individualSkill_list = {
                       def sortIndex = params.sidx ?: 'skill'
                       def sortOrder  = params.sord ?: 'asc'
                 
                       def maxRows = Integer.valueOf(params.rows)
                       def currentPage = Integer.valueOf(params.page) ?: 1
                 
                       def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
                 
                 	def result = IndividualSkill.createCriteria().list(max:maxRows, offset:rowOffset) {
                 		
                 		if (params.'individual.id')
             		    			individual{
             		    			eq('id',new Long(params.'individual.id'))
             		    			}
             
                 		
                 		if (params.'skill.name')
                 			ilike('name','%'+params.'skill.name' + '%')
                 
                 		if (params.status)
                 				ilike('status','%'+params.status + '%')
                 
                 		
                 		order(sortIndex, sortOrder)
                 
                 	}
                       
                       def totalRows = result.totalCount
                       def numberOfPages = Math.ceil(totalRows / maxRows)
                 
                       def jsonCells = result.collect {
                             [cell: [
                                        
                             	    it.skill.name,
                             	    it.status
                             	    
                                 ], id: it.id]
                         }
                         def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
                         render jsonData as JSON
                         }
                 
                 	def jq_edit_individualSkill = {
                 	      log.debug('In jq_individualSkill_edit:'+params)
                 	      def email = null
                 	      def message = ""
                 	      def state = "FAIL"
                 	      def id
                 	      def individualSkill
                 
                 	      // determine our action
                 	      switch (params.oper) {
                 		case 'add':
                 		
                 		 		
                 		  individualSkill = new IndividualSkill(params)
                 		
                 		individualSkill.creator=springSecurityService.principal.username
                 		individualSkill.updator = individualSkill.creator
                 		
                 		  if (! individualSkill.hasErrors() && individualSkill.save()) {
                 		    message = "Skill Saved.."
                 		    id = individualSkill.id
                 		    state = "OK"
                 		  } else {
                 		    individualSkill.errors.allErrors.each {
                 			log.debug(it)
                 			}
                 		    message = "Could Not Save Skill"
                 		  }
                 		  break;
                 		case 'del':
                 		  	def idList = params.id.tokenize(',')
                 		  	idList.each
                 		  	{
                 			  // check vehicle exists
                 			  individualSkill  = IndividualSkill.get(it)
                 			  if (individualSkill) {
                 			    // delete vehicle
                 			    if(!individualSkill.delete())
                 			    	{
                 				    individualSkill.errors.allErrors.each {
                 					log.debug("In jq_individualSkill_edit: error in deleting email:"+ it)
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
                 		  // first retrieve the vehicle by its ID
                 		  individualSkill = IndividualSkill.get(params.id)
                 		  if (individualSkill) {
                 		    // set the properties according to passed in parameters
                 		    individualSkill.properties = params
                 			  
                 		    if (! individualSkill.hasErrors() && individualSkill.save()) {
                 		      message = "Skill  ${individualSkill.skill} Updated"
                 		      id = individualSkill.id
                 		      state = "OK"
                 		    } else {
                 			    individualSkill.errors.allErrors.each {
                 				println it
                 				}
                 		      message = "Could Not Update Skill"
                 		    }
                 		  }
                 		  break;
                  	 }
                 
                 	      def response = [message:message,state:state,id:id]
                 
                 	      render response as JSON
                 	    }

def indskillList = {
	    if (request.xhr) {
		render(template: "individualSkill", model: [individualid:params.'individual.id'])
		//render "Hare Krishna!!"
		return
	    }
	   }

// return JSON list of skills
    def jq_depskill_list = {
      log.debug("In jq_depskill_list with params: "+params)
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def deps = IndividualSkill.createCriteria().list(max:maxRows, offset:rowOffset) {
            // name case insensitive where the field contains with the search term
            if (params.name)
                individual{
                	or{
                	ilike('legalName',params.name)
                	ilike('initiatedName',params.name)
                	}
                	}

            if (params.'skill.id')
                eq('skill.id',new Long(params."skill.id"))

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

	def jq_edit_depskill = {
	      def skill = null
	      if(params."skill.id")
	      	skill = Skill.get(params."skill.id")
	       
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
