package ics

import org.springframework.dao.DataIntegrityViolationException

class ItemTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [itemTypeInstanceList: ItemType.list(params), itemTypeInstanceTotal: ItemType.count()]
    }

    def create() {
        [itemTypeInstance: new ItemType(params)]
    }

    def save() {
        def itemTypeInstance = new ItemType(params)
        if (!itemTypeInstance.save(flush: true)) {
            render(view: "create", model: [itemTypeInstance: itemTypeInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'itemType.label', default: 'ItemType'), itemTypeInstance.id])
        redirect(action: "show", id: itemTypeInstance.id)
    }

    def show() {
        def itemTypeInstance = ItemType.get(params.id)
        if (!itemTypeInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemType.label', default: 'ItemType'), params.id])
            redirect(action: "list")
            return
        }

        [itemTypeInstance: itemTypeInstance]
    }

    def edit() {
        def itemTypeInstance = ItemType.get(params.id)
        if (!itemTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemType.label', default: 'ItemType'), params.id])
            redirect(action: "list")
            return
        }

        [itemTypeInstance: itemTypeInstance]
    }

    def update() {
        def itemTypeInstance = ItemType.get(params.id)
        if (!itemTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemType.label', default: 'ItemType'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (itemTypeInstance.version > version) {
                itemTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'itemType.label', default: 'ItemType')] as Object[],
                          "Another user has updated this ItemType while you were editing")
                render(view: "edit", model: [itemTypeInstance: itemTypeInstance])
                return
            }
        }

        itemTypeInstance.properties = params

        if (!itemTypeInstance.save(flush: true)) {
            render(view: "edit", model: [itemTypeInstance: itemTypeInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'itemType.label', default: 'ItemType'), itemTypeInstance.id])
        redirect(action: "show", id: itemTypeInstance.id)
    }

    def delete() {
        def itemTypeInstance = ItemType.get(params.id)
        if (!itemTypeInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemType.label', default: 'ItemType'), params.id])
            redirect(action: "list")
            return
        }

        try {
            itemTypeInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'itemType.label', default: 'ItemType'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'itemType.label', default: 'ItemType'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
