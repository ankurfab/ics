package ics

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class ObjectiveController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def objectiveInstanceList = Objective.list(params)
        //determine if the logged in user is PatronCare or PatronCareSevak
	def login = springSecurityService.principal.username
	println "Loggedin user: "+login
	def individual = Individual.findByLoginid(login)
	println "setSessionParams for: "+individual

	def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
	println 'pcRole='+pcRole
	def LoggedInUserRole
	for(int i=0; i<pcRole.size(); i++)
	{
		if(pcRole[i].toString() == "PatronCare")
		{
			LoggedInUserRole = "PatronCare"
			break
		}
		if(pcRole[i].toString() == "PatronCareSevak")
		{
			LoggedInUserRole = "PatronCareSevak"
			break
		}
	}
        println 'LoggedInUserRole='+LoggedInUserRole
        [objectiveInstanceList: objectiveInstanceList, objectiveInstanceTotal: Objective.count(), LoggedInUserRole: LoggedInUserRole]
    }

    def create() {
        [objectiveInstance: new Objective(params)]
    }

    def save() {
    	if(params.objFrom)
			params.objFrom = Date.parse('dd-MM-yyyy HH:mm', params.objFrom)
	if(params.objTo)
		params.objTo = Date.parse('dd-MM-yyyy HH:mm', params.objTo)
    
	params.creator=springSecurityService.principal.username
	params.updator=params.creator

	params."assignedBy.id" = params."acassignedBy_id"
	params."assignedTo.id" = params."acassignedTo_id"

        def objectiveInstance = new Objective(params)
        if (!objectiveInstance.save(flush: true)) {
            render(view: "create", model: [objectiveInstance: objectiveInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'objective.label', default: 'Objective'), objectiveInstance.id])
        redirect(action: "show", id: objectiveInstance.id)
    }

    def show() {
        def objectiveInstance

	objectiveInstance = Objective.get(params.id)

        if (!objectiveInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'objective.label', default: 'Objective'), params.id])
            redirect(action: "list")
            return
        }
        else {
            def model = [objectiveInstance: objectiveInstance, title: "Objective: "+objectiveInstance.name, occurrenceStart: objectiveInstance.objFrom, occurrenceEnd: objectiveInstance.objTo]
            if (request.xhr) {
                render(template: "showPopup", model: model)
            }
            else {
                model
            }
        }
    }

    def edit() {
        def objectiveInstance = Objective.get(params.id)
        if (!objectiveInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'objective.label', default: 'Objective'), params.id])
            redirect(action: "list")
            return
        }

        [objectiveInstance: objectiveInstance]
    }

    def update() {
        def objectiveInstance = Objective.get(params.id)
        if (!objectiveInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'objective.label', default: 'Objective'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (objectiveInstance.version > version) {
                objectiveInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'objective.label', default: 'Objective')] as Object[],
                          "Another user has updated this Objective while you were editing")
                render(view: "edit", model: [objectiveInstance: objectiveInstance])
                return
            }
        }

        objectiveInstance.properties = params

        if (!objectiveInstance.save(flush: true)) {
            render(view: "edit", model: [objectiveInstance: objectiveInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'objective.label', default: 'Objective'), objectiveInstance.id])
        redirect(action: "show", id: objectiveInstance.id)
    }

    def delete() {
        def objectiveInstance = Objective.get(params.id)
        if (!objectiveInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'objective.label', default: 'Objective'), params.id])
            redirect(action: "list")
            return
        }

        try {
            objectiveInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'objective.label', default: 'Objective'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'objective.label', default: 'Objective'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
