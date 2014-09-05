package ics

import grails.converters.JSON

class CountryController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        if(request.xhr)
        	{
		def query = params.term
		def c = Country.createCriteria()
		def result = c.list(max:10)
			{
			like("name", "%"+query+"%")
			order("name", "asc")
			}
		response.setHeader("Cache-Control", "no-store")

		def results = result.collect {
		    [  
		       id: it.id,
		       value: it.toString(),
		       label: it.toString() ]
			}
		render results as JSON        	
        	}
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [countryInstanceList: Country.list(params), countryInstanceTotal: Country.count()]
    }

    def create = {
        def countryInstance = new Country()
        countryInstance.properties = params
        return [countryInstance: countryInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def countryInstance = new Country(params)
        if (countryInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'country.label', default: 'Country'), countryInstance.id])}"
            redirect(action: "show", id: countryInstance.id)
        }
        else {
            render(view: "create", model: [countryInstance: countryInstance])
        }
    }

    def show = {
        def countryInstance = Country.get(params.id)
        if (!countryInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'country.label', default: 'Country'), params.id])}"
            redirect(action: "list")
        }
        else {
            [countryInstance: countryInstance]
        }
    }

    def edit = {
        def countryInstance = Country.get(params.id)
        if (!countryInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'country.label', default: 'Country'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [countryInstance: countryInstance]
        }
    }

    def update = {
        def countryInstance = Country.get(params.id)
        if (countryInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (countryInstance.version > version) {
                    
                    countryInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'country.label', default: 'Country')] as Object[], "Another user has updated this Country while you were editing")
                    render(view: "edit", model: [countryInstance: countryInstance])
                    return
                }
            }
 	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

           countryInstance.properties = params
            if (!countryInstance.hasErrors() && countryInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'country.label', default: 'Country'), countryInstance.id])}"
                redirect(action: "show", id: countryInstance.id)
            }
            else {
                render(view: "edit", model: [countryInstance: countryInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'country.label', default: 'Country'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def countryInstance = Country.get(params.id)
        if (countryInstance) {
            try {
                countryInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'country.label', default: 'Country'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'country.label', default: 'Country'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'country.label', default: 'Country'), params.id])}"
            redirect(action: "list")
        }
    }
}
