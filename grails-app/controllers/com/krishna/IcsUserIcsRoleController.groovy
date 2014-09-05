package com.krishna

import grails.converters.*
class IcsUserIcsRoleController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [icsUserIcsRoleInstanceList: IcsUserIcsRole.list(params), icsUserIcsRoleInstanceTotal: IcsUserIcsRole.count()]
    }

    def create = {
        def icsUserIcsRoleInstance = new IcsUserIcsRole()
        icsUserIcsRoleInstance.properties = params
        return [icsUserIcsRoleInstance: icsUserIcsRoleInstance]
    }

    def save = {
        def icsUserIcsRoleInstance = new IcsUserIcsRole(params)
        if (icsUserIcsRoleInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'icsUserIcsRole.label', default: 'IcsUserIcsRole'), icsUserIcsRoleInstance.id])}"
            redirect(action: "show", id: icsUserIcsRoleInstance.id)
        }
        else {
            render(view: "create", model: [icsUserIcsRoleInstance: icsUserIcsRoleInstance])
        }
    }

    def show = {
        def icsUserIcsRoleInstance = IcsUserIcsRole.get(params.id)
        if (!icsUserIcsRoleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'icsUserIcsRole.label', default: 'IcsUserIcsRole'), params.id])}"
            redirect(action: "list")
        }
        else {
            [icsUserIcsRoleInstance: icsUserIcsRoleInstance]
        }
    }

    def edit = {
        def icsUserIcsRoleInstance = IcsUserIcsRole.get(params.id)
        if (!icsUserIcsRoleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'icsUserIcsRole.label', default: 'IcsUserIcsRole'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [icsUserIcsRoleInstance: icsUserIcsRoleInstance]
        }
    }

    def update = {
        def icsUserIcsRoleInstance = IcsUserIcsRole.get(params.id)
        if (icsUserIcsRoleInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (icsUserIcsRoleInstance.version > version) {
                    
                    icsUserIcsRoleInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'icsUserIcsRole.label', default: 'IcsUserIcsRole')] as Object[], "Another user has updated this IcsUserIcsRole while you were editing")
                    render(view: "edit", model: [icsUserIcsRoleInstance: icsUserIcsRoleInstance])
                    return
                }
            }
            icsUserIcsRoleInstance.properties = params
            if (!icsUserIcsRoleInstance.hasErrors() && icsUserIcsRoleInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'icsUserIcsRole.label', default: 'IcsUserIcsRole'), icsUserIcsRoleInstance.id])}"
                redirect(action: "show", id: icsUserIcsRoleInstance.id)
            }
            else {
                render(view: "edit", model: [icsUserIcsRoleInstance: icsUserIcsRoleInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'icsUserIcsRole.label', default: 'IcsUserIcsRole'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def icsUserIcsRoleInstance = IcsUserIcsRole.get(params.id)
        if (icsUserIcsRoleInstance) {
            try {
                icsUserIcsRoleInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'icsUserIcsRole.label', default: 'IcsUserIcsRole'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'icsUserIcsRole.label', default: 'IcsUserIcsRole'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'icsUserIcsRole.label', default: 'IcsUserIcsRole'), params.id])}"
            redirect(action: "list")
        }
    }
    
}
