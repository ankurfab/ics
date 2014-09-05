package ics

import org.springframework.dao.DataIntegrityViolationException

class MenuOrderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [menuOrderInstanceList: MenuOrder.list(params), menuOrderInstanceTotal: MenuOrder.count()]
    }

    def create() {
        [menuOrderInstance: new MenuOrder(params)]
    }

    def save() {
        def menuOrderInstance = new MenuOrder(params)
        if (!menuOrderInstance.save(flush: true)) {
            render(view: "create", model: [menuOrderInstance: menuOrderInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'menuOrder.label', default: 'MenuOrder'), menuOrderInstance.id])
        redirect(action: "show", id: menuOrderInstance.id)
    }

    def show() {
        def menuOrderInstance = MenuOrder.get(params.id)
        if (!menuOrderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuOrder.label', default: 'MenuOrder'), params.id])
            redirect(action: "list")
            return
        }

        [menuOrderInstance: menuOrderInstance]
    }

    def edit() {
        def menuOrderInstance = MenuOrder.get(params.id)
        if (!menuOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuOrder.label', default: 'MenuOrder'), params.id])
            redirect(action: "list")
            return
        }

        [menuOrderInstance: menuOrderInstance]
    }

    def update() {
        def menuOrderInstance = MenuOrder.get(params.id)
        if (!menuOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuOrder.label', default: 'MenuOrder'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (menuOrderInstance.version > version) {
                menuOrderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'menuOrder.label', default: 'MenuOrder')] as Object[],
                          "Another user has updated this MenuOrder while you were editing")
                render(view: "edit", model: [menuOrderInstance: menuOrderInstance])
                return
            }
        }

        menuOrderInstance.properties = params

        if (!menuOrderInstance.save(flush: true)) {
            render(view: "edit", model: [menuOrderInstance: menuOrderInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'menuOrder.label', default: 'MenuOrder'), menuOrderInstance.id])
        redirect(action: "show", id: menuOrderInstance.id)
    }

    def delete() {
        def menuOrderInstance = MenuOrder.get(params.id)
        if (!menuOrderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuOrder.label', default: 'MenuOrder'), params.id])
            redirect(action: "list")
            return
        }

        try {
            menuOrderInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'menuOrder.label', default: 'MenuOrder'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'menuOrder.label', default: 'MenuOrder'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
