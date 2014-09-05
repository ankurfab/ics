package ics

import org.springframework.dao.DataIntegrityViolationException

class CuisineController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cuisineInstanceList: Cuisine.list(params), cuisineInstanceTotal: Cuisine.count()]
    }

    def create() {
        [cuisineInstance: new Cuisine(params)]
    }

    def save() {
        def cuisineInstance = new Cuisine(params)
        if (!cuisineInstance.save(flush: true)) {
            render(view: "create", model: [cuisineInstance: cuisineInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'cuisine.label', default: 'Cuisine'), cuisineInstance.id])
        redirect(action: "show", id: cuisineInstance.id)
    }

    def show() {
        def cuisineInstance = Cuisine.get(params.id)
        if (!cuisineInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cuisine.label', default: 'Cuisine'), params.id])
            redirect(action: "list")
            return
        }

        [cuisineInstance: cuisineInstance]
    }

    def edit() {
        def cuisineInstance = Cuisine.get(params.id)
        if (!cuisineInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cuisine.label', default: 'Cuisine'), params.id])
            redirect(action: "list")
            return
        }

        [cuisineInstance: cuisineInstance]
    }

    def update() {
        def cuisineInstance = Cuisine.get(params.id)
        if (!cuisineInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cuisine.label', default: 'Cuisine'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (cuisineInstance.version > version) {
                cuisineInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cuisine.label', default: 'Cuisine')] as Object[],
                          "Another user has updated this Cuisine while you were editing")
                render(view: "edit", model: [cuisineInstance: cuisineInstance])
                return
            }
        }

        cuisineInstance.properties = params

        if (!cuisineInstance.save(flush: true)) {
            render(view: "edit", model: [cuisineInstance: cuisineInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'cuisine.label', default: 'Cuisine'), cuisineInstance.id])
        redirect(action: "show", id: cuisineInstance.id)
    }

    def delete() {
        def cuisineInstance = Cuisine.get(params.id)
        if (!cuisineInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cuisine.label', default: 'Cuisine'), params.id])
            redirect(action: "list")
            return
        }

        try {
            cuisineInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'cuisine.label', default: 'Cuisine'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cuisine.label', default: 'Cuisine'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
