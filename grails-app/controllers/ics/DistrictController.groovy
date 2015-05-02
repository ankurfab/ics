package ics

import grails.converters.JSON

class DistrictController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [districtInstanceList: District.list(params), districtInstanceTotal: District.count()]
    }

    def create = {
        def districtInstance = new District()
        districtInstance.properties = params
        return [districtInstance: districtInstance]
    }

    def save = {
        def districtInstance = new District(params)
        if (!districtInstance.hasErrors() && districtInstance.save()) {
            flash.message = "district.created"
            flash.args = [districtInstance.id]
            flash.defaultMessage = "District ${districtInstance.id} created"
            redirect(action: "show", id: districtInstance.id)
        }
        else {
            render(view: "create", model: [districtInstance: districtInstance])
        }
    }

    def show = {
        def districtInstance = District.get(params.id)
        if (!districtInstance) {
            flash.message = "district.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "District not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [districtInstance: districtInstance]
        }
    }

    def edit = {
        def districtInstance = District.get(params.id)
        if (!districtInstance) {
            flash.message = "district.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "District not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [districtInstance: districtInstance]
        }
    }

    def update = {
        def districtInstance = District.get(params.id)
        if (districtInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (districtInstance.version > version) {
                    
                    districtInstance.errors.rejectValue("version", "district.optimistic.locking.failure", "Another user has updated this District while you were editing")
                    render(view: "edit", model: [districtInstance: districtInstance])
                    return
                }
            }
            districtInstance.properties = params
            if (!districtInstance.hasErrors() && districtInstance.save()) {
                flash.message = "district.updated"
                flash.args = [params.id]
                flash.defaultMessage = "District ${params.id} updated"
                redirect(action: "show", id: districtInstance.id)
            }
            else {
                render(view: "edit", model: [districtInstance: districtInstance])
            }
        }
        else {
            flash.message = "district.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "District not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def districtInstance = District.get(params.id)
        if (districtInstance) {
            try {
                districtInstance.delete()
                flash.message = "district.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "District ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "district.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "District ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "district.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "District not found with id ${params.id}"
            redirect(action: "list")
        }
    }

    def allAsJSON_JQ = {
		def query = params.term
		def c = District.createCriteria()
		def result = c.list(max:10)
			{
			ilike("name", query+"%")
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
}
