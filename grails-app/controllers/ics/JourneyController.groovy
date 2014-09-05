package ics

import org.springframework.dao.DataIntegrityViolationException

class JourneyController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [journeyInstanceList: Journey.list(params), journeyInstanceTotal: Journey.count()]
    }

    def create() {
        [journeyInstance: new Journey(params)]
    }

    def save() {
        def journeyInstance = new Journey(params)
        if (!journeyInstance.save(flush: true)) {
            render(view: "create", model: [journeyInstance: journeyInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'journey.label', default: 'Journey'), journeyInstance.id])
        redirect(action: "show", id: journeyInstance.id)
    }

    def show() {
        def journeyInstance = Journey.get(params.id)
        if (!journeyInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'journey.label', default: 'Journey'), params.id])
            redirect(action: "list")
            return
        }

        [journeyInstance: journeyInstance]
    }

    def edit() {
        def journeyInstance = Journey.get(params.id)
        if (!journeyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'journey.label', default: 'Journey'), params.id])
            redirect(action: "list")
            return
        }

        [journeyInstance: journeyInstance]
    }

    def update() {
        def journeyInstance = Journey.get(params.id)
        if (!journeyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'journey.label', default: 'Journey'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (journeyInstance.version > version) {
                journeyInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'journey.label', default: 'Journey')] as Object[],
                          "Another user has updated this Journey while you were editing")
                render(view: "edit", model: [journeyInstance: journeyInstance])
                return
            }
        }

        journeyInstance.properties = params

        if (!journeyInstance.save(flush: true)) {
            render(view: "edit", model: [journeyInstance: journeyInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'journey.label', default: 'Journey'), journeyInstance.id])
        redirect(action: "show", id: journeyInstance.id)
    }

    def delete() {
        def journeyInstance = Journey.get(params.id)
        if (!journeyInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'journey.label', default: 'Journey'), params.id])
            redirect(action: "list")
            return
        }

        try {
            journeyInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'journey.label', default: 'Journey'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'journey.label', default: 'Journey'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
