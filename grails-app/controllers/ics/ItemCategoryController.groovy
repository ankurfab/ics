package ics

import org.springframework.dao.DataIntegrityViolationException

class ItemCategoryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [itemCategoryInstanceList: ItemCategory.list(params), itemCategoryInstanceTotal: ItemCategory.count()]
    }

    def create() {
        [itemCategoryInstance: new ItemCategory(params)]
    }

    def save() {
        def itemCategoryInstance = new ItemCategory(params)
        if (!itemCategoryInstance.save(flush: true)) {
            render(view: "create", model: [itemCategoryInstance: itemCategoryInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'itemCategory.label', default: 'ItemCategory'), itemCategoryInstance.id])
        redirect(action: "show", id: itemCategoryInstance.id)
    }

    def show() {
        def itemCategoryInstance = ItemCategory.get(params.id)
        if (!itemCategoryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemCategory.label', default: 'ItemCategory'), params.id])
            redirect(action: "list")
            return
        }

        [itemCategoryInstance: itemCategoryInstance]
    }

    def edit() {
        def itemCategoryInstance = ItemCategory.get(params.id)
        if (!itemCategoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemCategory.label', default: 'ItemCategory'), params.id])
            redirect(action: "list")
            return
        }

        [itemCategoryInstance: itemCategoryInstance]
    }

    def update() {
        def itemCategoryInstance = ItemCategory.get(params.id)
        if (!itemCategoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemCategory.label', default: 'ItemCategory'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (itemCategoryInstance.version > version) {
                itemCategoryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'itemCategory.label', default: 'ItemCategory')] as Object[],
                          "Another user has updated this ItemCategory while you were editing")
                render(view: "edit", model: [itemCategoryInstance: itemCategoryInstance])
                return
            }
        }

        itemCategoryInstance.properties = params

        if (!itemCategoryInstance.save(flush: true)) {
            render(view: "edit", model: [itemCategoryInstance: itemCategoryInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'itemCategory.label', default: 'ItemCategory'), itemCategoryInstance.id])
        redirect(action: "show", id: itemCategoryInstance.id)
    }

    def delete() {
        def itemCategoryInstance = ItemCategory.get(params.id)
        if (!itemCategoryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemCategory.label', default: 'ItemCategory'), params.id])
            redirect(action: "list")
            return
        }

        try {
            itemCategoryInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'itemCategory.label', default: 'ItemCategory'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'itemCategory.label', default: 'ItemCategory'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
