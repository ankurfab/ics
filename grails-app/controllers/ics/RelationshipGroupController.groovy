package ics

import grails.converters.JSON

class RelationshipGroupController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        	redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [relationshipGroupInstanceList: RelationshipGroup.list(params), relationshipGroupInstanceTotal: RelationshipGroup.count()]
    }

    def create = {
        def relationshipGroupInstance = new RelationshipGroup()
        relationshipGroupInstance.properties = params
        return [relationshipGroupInstance: relationshipGroupInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def relationshipGroupInstance = new RelationshipGroup(params)

        println 'In relationship group: params.linkedid='+params.linkedid
        if(params.linkedid)
        	{
        	relationshipGroupInstance.refid=new Integer(params.linkedid) //TODO should be long
        	}
        else
        	{
        	//person not found
        	flash.message = "Group leader not chosen/found! Pls create one!!"
        	render(view: "create", model: [relationshipGroupInstance: relationshipGroupInstance])
        	return
        	}

        if (relationshipGroupInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'relationshipGroup.label', default: 'RelationshipGroup'), relationshipGroupInstance.id])}"
            redirect(action: "show", id: relationshipGroupInstance.id)
        }
        else {
            render(view: "create", model: [relationshipGroupInstance: relationshipGroupInstance])
        }
    }

    def show = {
        def relationshipGroupInstance
        if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAllGranted('ROLE_COUNSELLOR_GROUP'))
        	{
        	relationshipGroupInstance = RelationshipGroup.findByRefidAndGroupNameLike(session.individualid,'CG%')
        	}
        else
        	relationshipGroupInstance = RelationshipGroup.get(params.id)
        if (!relationshipGroupInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'relationshipGroup.label', default: 'RelationshipGroup'), params.id])}"
            redirect(action: "list")
        }
        else {
            [relationshipGroupInstance: relationshipGroupInstance]
        }
    }

    def edit = {
        def relationshipGroupInstance = RelationshipGroup.get(params.id)
        if (!relationshipGroupInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'relationshipGroup.label', default: 'RelationshipGroup'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [relationshipGroupInstance: relationshipGroupInstance]
        }
    }

    def update = {
        def relationshipGroupInstance = RelationshipGroup.get(params.id)
        if (relationshipGroupInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (relationshipGroupInstance.version > version) {
                    
                    relationshipGroupInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'relationshipGroup.label', default: 'RelationshipGroup')] as Object[], "Another user has updated this RelationshipGroup while you were editing")
                    render(view: "edit", model: [relationshipGroupInstance: relationshipGroupInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            relationshipGroupInstance.properties = params
            if (!relationshipGroupInstance.hasErrors() && relationshipGroupInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'relationshipGroup.label', default: 'RelationshipGroup'), relationshipGroupInstance.id])}"
                redirect(action: "show", id: relationshipGroupInstance.id)
            }
            else {
                render(view: "edit", model: [relationshipGroupInstance: relationshipGroupInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'relationshipGroup.label', default: 'RelationshipGroup'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def relationshipGroupInstance = RelationshipGroup.get(params.id)
        if (relationshipGroupInstance) {
            try {
                relationshipGroupInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'relationshipGroup.label', default: 'RelationshipGroup'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'relationshipGroup.label', default: 'RelationshipGroup'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'relationshipGroup.label', default: 'RelationshipGroup'), params.id])}"
            redirect(action: "list")
        }
    }

    def findRelationshipGroupsAsJSON = {
    		def query = params.query
        	def c = RelationshipGroup.findAllByGroupNameLike("%"+query+"%",[sort:'groupName'])
        response.setHeader("Cache-Control", "no-store")

        def results = c.collect {
            [  id: it.id,
               name: it.groupName ]
        }

        def data = [ result: results ]
        render data as JSON
    }
 

}
