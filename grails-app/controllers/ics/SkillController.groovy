package ics

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class SkillController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [skillInstanceList: Skill.list(params), skillInstanceTotal: Skill.count()]
    }

    def create() {
        [skillInstance: new Skill(params)]
    }

    def save() {
        params.creator=springSecurityService.principal.username
        params.updator=params.creator
        def skillInstance = new Skill(params)
        if (!skillInstance.save(flush: true)) {
            render(view: "create", model: [skillInstance: skillInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'skill.label', default: 'Skill'), skillInstance.id])
        redirect(action: "show", id: skillInstance.id)
    }

    def show() {
        def skillInstance = Skill.get(params.id)
        if (!skillInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'skill.label', default: 'Skill'), params.id])
            redirect(action: "list")
            return
        }

        [skillInstance: skillInstance]
    }

    def edit() {
        def skillInstance = Skill.get(params.id)
        if (!skillInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'skill.label', default: 'Skill'), params.id])
            redirect(action: "list")
            return
        }

        [skillInstance: skillInstance]
    }

    def update() {
        def skillInstance = Skill.get(params.id)
        if (!skillInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'skill.label', default: 'Skill'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (skillInstance.version > version) {
                skillInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'skill.label', default: 'Skill')] as Object[],
                          "Another user has updated this Skill while you were editing")
                render(view: "edit", model: [skillInstance: skillInstance])
                return
            }
        }

        params.updator=springSecurityService.principal.username
        skillInstance.properties = params

        if (!skillInstance.save(flush: true)) {
            render(view: "edit", model: [skillInstance: skillInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'skill.label', default: 'Skill'), skillInstance.id])
        redirect(action: "show", id: skillInstance.id)
    }

    def delete() {
        def skillInstance = Skill.get(params.id)
        if (!skillInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'skill.label', default: 'Skill'), params.id])
            redirect(action: "list")
            return
        }

        try {
            skillInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'skill.label', default: 'Skill'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'skill.label', default: 'Skill'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

// return JSON list of skills
    def jq_skill_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def skills = Skill.createCriteria().list(max:maxRows, offset:rowOffset) {
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
      def totalRows = skills.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = skills.collect {
            [cell: [it.name,
            	it.description,
            	it.type,
            	it.category
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }
    
	def jq_edit_skill = {
	      def skill = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add instruction sent
		  params.creator = springSecurityService.principal.username
		  params.updator = params.creator
		  skill = new Skill(params)
		  if (! skill.hasErrors() && skill.save()) {
		    message = "Skill ${skill.name} Added"
		    id = skill.id
		    state = "OK"
		  } else {
		    skill.errors.allErrors.each {
			println it
		    }		    
		    message = "Could Not Save Skill"
		  }
		  break;
		case 'del':
		  // check skill exists
		  skill = Skill.get(params.id)
		  if (skill) {
		    // delete skill
		    skill.delete()
		    message = "Skill  ${skill.name} Deleted"
		    state = "OK"
		  }
		  break;
		 default :
		  // edit action
		  // first retrieve the skill by its ID
		  skill = Skill.get(params.id)
		  if (skill) {
		    // set the properties according to passed in parameters
		  	params.updator = springSecurityService.principal.username
		    skill.properties = params
		    if (! skill.hasErrors() && skill.save()) {
		      message = "Skill  ${skill.name} Updated"
		      id = skill.id
		      state = "OK"
		    } else {
		    skill.errors.allErrors.each {
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
	    
	def gridList() {}

}
