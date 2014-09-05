package ics

import org.springframework.dao.DataIntegrityViolationException

class RecipeTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [recipeTypeInstanceList: RecipeType.list(params), recipeTypeInstanceTotal: RecipeType.count()]
    }

    def create() {
        [recipeTypeInstance: new RecipeType(params)]
    }

    def save() {
        def recipeTypeInstance = new RecipeType(params)
        if (!recipeTypeInstance.save(flush: true)) {
            render(view: "create", model: [recipeTypeInstance: recipeTypeInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'recipeType.label', default: 'RecipeType'), recipeTypeInstance.id])
        redirect(action: "show", id: recipeTypeInstance.id)
    }

    def show() {
        def recipeTypeInstance = RecipeType.get(params.id)
        if (!recipeTypeInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'recipeType.label', default: 'RecipeType'), params.id])
            redirect(action: "list")
            return
        }

        [recipeTypeInstance: recipeTypeInstance]
    }

    def edit() {
        def recipeTypeInstance = RecipeType.get(params.id)
        if (!recipeTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'recipeType.label', default: 'RecipeType'), params.id])
            redirect(action: "list")
            return
        }

        [recipeTypeInstance: recipeTypeInstance]
    }

    def update() {
        def recipeTypeInstance = RecipeType.get(params.id)
        if (!recipeTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'recipeType.label', default: 'RecipeType'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (recipeTypeInstance.version > version) {
                recipeTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'recipeType.label', default: 'RecipeType')] as Object[],
                          "Another user has updated this RecipeType while you were editing")
                render(view: "edit", model: [recipeTypeInstance: recipeTypeInstance])
                return
            }
        }

        recipeTypeInstance.properties = params

        if (!recipeTypeInstance.save(flush: true)) {
            render(view: "edit", model: [recipeTypeInstance: recipeTypeInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'recipeType.label', default: 'RecipeType'), recipeTypeInstance.id])
        redirect(action: "show", id: recipeTypeInstance.id)
    }

    def delete() {
        def recipeTypeInstance = RecipeType.get(params.id)
        if (!recipeTypeInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'recipeType.label', default: 'RecipeType'), params.id])
            redirect(action: "list")
            return
        }

        try {
            recipeTypeInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'recipeType.label', default: 'RecipeType'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'recipeType.label', default: 'RecipeType'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
