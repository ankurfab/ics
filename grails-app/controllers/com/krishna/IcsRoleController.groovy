package com.krishna

class IcsRoleController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [icsRoleInstanceList: IcsRole.list(params), icsRoleInstanceTotal: IcsRole.count()]
    }

    def create = {
        def icsRoleInstance = new IcsRole()
        icsRoleInstance.properties = params
        return [icsRoleInstance: icsRoleInstance]
    }

    def save = {
        def icsRoleInstance = new IcsRole(params)
        if (icsRoleInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'icsRole.label', default: 'IcsRole'), icsRoleInstance.id])}"
            redirect(action: "show", id: icsRoleInstance.id)
        }
        else {
            render(view: "create", model: [icsRoleInstance: icsRoleInstance])
        }
    }

    def show = {
        def icsRoleInstance = IcsRole.get(params.id)
        if (!icsRoleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'icsRole.label', default: 'IcsRole'), params.id])}"
            redirect(action: "list")
        }
        else {
            [icsRoleInstance: icsRoleInstance]
        }
    }

    def edit = {
        def icsRoleInstance = IcsRole.get(params.id)
        if (!icsRoleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'icsRole.label', default: 'IcsRole'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [icsRoleInstance: icsRoleInstance]
        }
    }

    def update = {
        def icsRoleInstance = IcsRole.get(params.id)
        if (icsRoleInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (icsRoleInstance.version > version) {
                    
                    icsRoleInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'icsRole.label', default: 'IcsRole')] as Object[], "Another user has updated this IcsRole while you were editing")
                    render(view: "edit", model: [icsRoleInstance: icsRoleInstance])
                    return
                }
            }
            icsRoleInstance.properties = params
            if (!icsRoleInstance.hasErrors() && icsRoleInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'icsRole.label', default: 'IcsRole'), icsRoleInstance.id])}"
                redirect(action: "show", id: icsRoleInstance.id)
            }
            else {
                render(view: "edit", model: [icsRoleInstance: icsRoleInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'icsRole.label', default: 'IcsRole'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def icsRoleInstance = IcsRole.get(params.id)
        if (icsRoleInstance) {
            try {
                icsRoleInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'icsRole.label', default: 'IcsRole'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'icsRole.label', default: 'IcsRole'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'icsRole.label', default: 'IcsRole'), params.id])}"
            redirect(action: "list")
        }
    }
}
