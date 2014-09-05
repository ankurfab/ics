package ics

import org.springframework.dao.DataIntegrityViolationException

class MenuItemController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [menuItemInstanceList: MenuItem.list(params), menuItemInstanceTotal: MenuItem.count()]
    }

    def create() {
        [menuItemInstance: new MenuItem(params)]
    }

    def save() {
        def menuItemInstance = new MenuItem(params)
        if (!menuItemInstance.save(flush: true)) {
            render(view: "create", model: [menuItemInstance: menuItemInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'menuItem.label', default: 'MenuItem'), menuItemInstance.id])
        redirect(action: "show", id: menuItemInstance.id)
    }

    def show() {
        def menuItemInstance = MenuItem.get(params.id)
        if (!menuItemInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuItem.label', default: 'MenuItem'), params.id])
            redirect(action: "list")
            return
        }

        [menuItemInstance: menuItemInstance]
    }

    def edit() {
        def menuItemInstance = MenuItem.get(params.id)
        if (!menuItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuItem.label', default: 'MenuItem'), params.id])
            redirect(action: "list")
            return
        }

        [menuItemInstance: menuItemInstance]
    }

    def update() {
        def menuItemInstance = MenuItem.get(params.id)
        if (!menuItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuItem.label', default: 'MenuItem'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (menuItemInstance.version > version) {
                menuItemInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'menuItem.label', default: 'MenuItem')] as Object[],
                          "Another user has updated this MenuItem while you were editing")
                render(view: "edit", model: [menuItemInstance: menuItemInstance])
                return
            }
        }

        menuItemInstance.properties = params

        if (!menuItemInstance.save(flush: true)) {
            render(view: "edit", model: [menuItemInstance: menuItemInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'menuItem.label', default: 'MenuItem'), menuItemInstance.id])
        redirect(action: "show", id: menuItemInstance.id)
    }

    def delete() {
        def menuItemInstance = MenuItem.get(params.id)
        if (!menuItemInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuItem.label', default: 'MenuItem'), params.id])
            redirect(action: "list")
            return
        }

        try {
            menuItemInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'menuItem.label', default: 'MenuItem'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'menuItem.label', default: 'MenuItem'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
