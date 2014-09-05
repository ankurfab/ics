package ics

class TitleController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [titleInstanceList: Title.list(params), titleInstanceTotal: Title.count()]
    }

    def create = {
        def titleInstance = new Title()
        titleInstance.properties = params
        return [titleInstance: titleInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def titleInstance = new Title(params)
        if (titleInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'title.label', default: 'Title'), titleInstance.id])}"
            redirect(action: "show", id: titleInstance.id)
        }
        else {
            render(view: "create", model: [titleInstance: titleInstance])
        }
    }

    def show = {
        def titleInstance = Title.get(params.id)
        if (!titleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'title.label', default: 'Title'), params.id])}"
            redirect(action: "list")
        }
        else {
            [titleInstance: titleInstance]
        }
    }

    def edit = {
        def titleInstance = Title.get(params.id)
        if (!titleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'title.label', default: 'Title'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [titleInstance: titleInstance]
        }
    }

    def update = {
        def titleInstance = Title.get(params.id)
        if (titleInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (titleInstance.version > version) {
                    
                    titleInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'title.label', default: 'Title')] as Object[], "Another user has updated this Title while you were editing")
                    render(view: "edit", model: [titleInstance: titleInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            titleInstance.properties = params
            if (!titleInstance.hasErrors() && titleInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'title.label', default: 'Title'), titleInstance.id])}"
                redirect(action: "show", id: titleInstance.id)
            }
            else {
                render(view: "edit", model: [titleInstance: titleInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'title.label', default: 'Title'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def titleInstance = Title.get(params.id)
        if (titleInstance) {
            try {
                titleInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'title.label', default: 'Title'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'title.label', default: 'Title'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'title.label', default: 'Title'), params.id])}"
            redirect(action: "list")
        }
    }
}
