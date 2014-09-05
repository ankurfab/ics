package ics

import org.springframework.dao.DataIntegrityViolationException

class RecipeVersionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [recipeVersionInstanceList: RecipeVersion.list(params), recipeVersionInstanceTotal: RecipeVersion.count()]
    }

    def create() {
        [recipeVersionInstance: new RecipeVersion(params)]
    }

    def save() {
        def recipeVersionInstance = new RecipeVersion(params)
        if (!recipeVersionInstance.save(flush: true)) {
            render(view: "create", model: [recipeVersionInstance: recipeVersionInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'recipeVersion.label', default: 'RecipeVersion'), recipeVersionInstance.id])
        redirect(controller: "instructionGroup", action: "create", , params: ['recipeVersion.id': recipeVersionInstance.id])
    }

    def show() {
        def recipeVersionInstance = RecipeVersion.get(params.id)
        if (!recipeVersionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'recipeVersion.label', default: 'RecipeVersion'), params.id])
            redirect(action: "list")
            return
        }

        [recipeVersionInstance: recipeVersionInstance]
    }

    def edit() {
        def recipeVersionInstance = RecipeVersion.get(params.id)
        if (!recipeVersionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'recipeVersion.label', default: 'RecipeVersion'), params.id])
            redirect(action: "list")
            return
        }

        [recipeVersionInstance: recipeVersionInstance]
    }

    def update() {
        def recipeVersionInstance = RecipeVersion.get(params.id)
        if (!recipeVersionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'recipeVersion.label', default: 'RecipeVersion'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (recipeVersionInstance.version > version) {
                recipeVersionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'recipeVersion.label', default: 'RecipeVersion')] as Object[],
                          "Another user has updated this RecipeVersion while you were editing")
                render(view: "edit", model: [recipeVersionInstance: recipeVersionInstance])
                return
            }
        }

        recipeVersionInstance.properties = params

        if (!recipeVersionInstance.save(flush: true)) {
            render(view: "edit", model: [recipeVersionInstance: recipeVersionInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'recipeVersion.label', default: 'RecipeVersion'), recipeVersionInstance.id])
        redirect(action: "show", id: recipeVersionInstance.id)
    }

    def delete() {
        def recipeVersionInstance = RecipeVersion.get(params.id)
        if (!recipeVersionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'recipeVersion.label', default: 'RecipeVersion'), params.id])
            redirect(action: "list")
            return
        }

        try {
            recipeVersionInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'recipeVersion.label', default: 'RecipeVersion'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'recipeVersion.label', default: 'RecipeVersion'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
