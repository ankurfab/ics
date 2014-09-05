package ics

import grails.converters.JSON

class SchemeController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [schemeInstanceList: Scheme.list(params), schemeInstanceTotal: Scheme.count()]
    }

    def create = {
        def schemeInstance = new Scheme()
        schemeInstance.properties = params
        return [schemeInstance: schemeInstance]
    }

    def save = {
    	if(params.effectiveFrom)
			params.effectiveFrom = Date.parse('dd-MM-yyyy', params.effectiveFrom)
	if(params.effectiveTill)
		params.effectiveTill = Date.parse('dd-MM-yyyy', params.effectiveTill)
    
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def schemeInstance = new Scheme(params)
        if (schemeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'scheme.label', default: 'Scheme'), schemeInstance.id])}"
            redirect(action: "show", id: schemeInstance.id)
        }
        else {
            render(view: "create", model: [schemeInstance: schemeInstance])
        }
    }

    def show = {
        def schemeInstance = Scheme.get(params.id)
        def schemeMemberInstance = SchemeMember.findAllByScheme(Scheme.get(params.id))
        if (!schemeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'scheme.label', default: 'Scheme'), params.id])}"
            redirect(action: "list")
        }
        else {
            [schemeInstance: schemeInstance, schemeMemberInstance: schemeMemberInstance]
        }
    }

    def edit = {
        def schemeInstance = Scheme.get(params.id)
        if (!schemeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'scheme.label', default: 'Scheme'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [schemeInstance: schemeInstance]
        }
    }

    def update = {
        def schemeInstance = Scheme.get(params.id)
    	if(params.effectiveFrom)
			params.effectiveFrom = Date.parse('dd-MM-yyyy', params.effectiveFrom)
	if(params.effectiveTill)
		params.effectiveTill = Date.parse('dd-MM-yyyy', params.effectiveTill)
        
        if (schemeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (schemeInstance.version > version) {
                    
                    schemeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'scheme.label', default: 'Scheme')] as Object[], "Another user has updated this Scheme while you were editing")
                    render(view: "edit", model: [schemeInstance: schemeInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            schemeInstance.properties = params
            if (!schemeInstance.hasErrors() && schemeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'scheme.label', default: 'Scheme'), schemeInstance.id])}"
                redirect(action: "show", id: schemeInstance.id)
            }
            else {
                render(view: "edit", model: [schemeInstance: schemeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'scheme.label', default: 'Scheme'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def schemeInstance = Scheme.get(params.id)
        if (schemeInstance) {
            try {
                schemeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'scheme.label', default: 'Scheme'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'scheme.label', default: 'Scheme'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'scheme.label', default: 'Scheme'), params.id])}"
            redirect(action: "list")
        }
    }

    def findSchemesAsJSON = {
	def query = params.query
	def schemes = Scheme.findAllByNameLike("%"+query+"%", [sort:"name", order:"asc"])
        response.setHeader("Cache-Control", "no-store")

        def results = schemes.collect {
            [  id: it.id,
               name: it.toString() ]
        }

        def data = [ result: results ]
        render data as JSON
    }

}
