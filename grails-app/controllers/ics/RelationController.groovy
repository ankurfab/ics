package ics

import grails.converters.JSON

class RelationController {
    def springSecurityService


    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [relationInstanceList: Relation.list(params), relationInstanceTotal: Relation.count()]
    }

    def create = {
        def relationInstance = new Relation()
        relationInstance.properties = params
        return [relationInstance: relationInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def relationInstance = new Relation(params)
        if (relationInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'relation.label', default: 'Relation'), relationInstance.id])}"
            redirect(action: "show", id: relationInstance.id)
        }
        else {
            render(view: "create", model: [relationInstance: relationInstance])
        }
    }

    def show = {
        def relationInstance = Relation.get(params.id)
        if (!relationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'relation.label', default: 'Relation'), params.id])}"
            redirect(action: "list")
        }
        else {
            [relationInstance: relationInstance]
        }
    }

    def edit = {
        def relationInstance = Relation.get(params.id)
        if (!relationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'relation.label', default: 'Relation'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [relationInstance: relationInstance]
        }
    }

    def update = {
        def relationInstance = Relation.get(params.id)
        if (relationInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (relationInstance.version > version) {
                    
                    relationInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'relation.label', default: 'Relation')] as Object[], "Another user has updated this Relation while you were editing")
                    render(view: "edit", model: [relationInstance: relationInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            relationInstance.properties = params
            if (!relationInstance.hasErrors() && relationInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'relation.label', default: 'Relation'), relationInstance.id])}"
                redirect(action: "show", id: relationInstance.id)
            }
            else {
                render(view: "edit", model: [relationInstance: relationInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'relation.label', default: 'Relation'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def relationInstance = Relation.get(params.id)
        if (relationInstance) {
            try {
                relationInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'relation.label', default: 'Relation'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'relation.label', default: 'Relation'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'relation.label', default: 'Relation'), params.id])}"
            redirect(action: "list")
        }
    }

    def findRelationsAsJSON = {
    		def query = params.query
        	def c = Relation.findAllByNameLike("%"+query+"%",[sort:'name'])
        response.setHeader("Cache-Control", "no-store")

        def results = c.collect {
            [  id: it.id,
               name: it.name ]
        }

        def data = [ result: results ]
        render data as JSON
    }


}
