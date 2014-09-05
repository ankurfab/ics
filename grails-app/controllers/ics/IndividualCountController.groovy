package ics

import org.springframework.dao.DataIntegrityViolationException

class IndividualCountController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [individualCountInstanceList: IndividualCount.list(params), individualCountInstanceTotal: IndividualCount.count()]
    }

    def create() {
        [individualCountInstance: new IndividualCount(params)]
    }

    def save() {
        def individualCountInstance = new IndividualCount(params)
        if (!individualCountInstance.save(flush: true)) {
            render(view: "create", model: [individualCountInstance: individualCountInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'individualCount.label', default: 'IndividualCount'), individualCountInstance.id])
        redirect(action: "show", id: individualCountInstance.id)
    }

    def show() {
        def individualCountInstance = IndividualCount.get(params.id)
        if (!individualCountInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualCount.label', default: 'IndividualCount'), params.id])
            redirect(action: "list")
            return
        }

        [individualCountInstance: individualCountInstance]
    }

    def edit() {
        def individualCountInstance = IndividualCount.get(params.id)
        if (!individualCountInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualCount.label', default: 'IndividualCount'), params.id])
            redirect(action: "list")
            return
        }

        [individualCountInstance: individualCountInstance]
    }

    def update() {
        def individualCountInstance = IndividualCount.get(params.id)
        if (!individualCountInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualCount.label', default: 'IndividualCount'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (individualCountInstance.version > version) {
                individualCountInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'individualCount.label', default: 'IndividualCount')] as Object[],
                          "Another user has updated this IndividualCount while you were editing")
                render(view: "edit", model: [individualCountInstance: individualCountInstance])
                return
            }
        }

        individualCountInstance.properties = params

        if (!individualCountInstance.save(flush: true)) {
            render(view: "edit", model: [individualCountInstance: individualCountInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'individualCount.label', default: 'IndividualCount'), individualCountInstance.id])
        redirect(action: "show", id: individualCountInstance.id)
    }

    def delete() {
        def individualCountInstance = IndividualCount.get(params.id)
        if (!individualCountInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'individualCount.label', default: 'IndividualCount'), params.id])
            redirect(action: "list")
            return
        }

        try {
            individualCountInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'individualCount.label', default: 'IndividualCount'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'individualCount.label', default: 'IndividualCount'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
