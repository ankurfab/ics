package ics

class LanguageController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [languageInstanceList: Language.list(params), languageInstanceTotal: Language.count()]
    }

    def create = {
        def languageInstance = new Language()
        languageInstance.properties = params
        return [languageInstance: languageInstance]
    }

    def save = {
        def languageInstance = new Language(params)
        if (languageInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'language.label', default: 'Language'), languageInstance.id])}"
            redirect(action: "show", id: languageInstance.id)
        }
        else {
            render(view: "create", model: [languageInstance: languageInstance])
        }
    }

    def show = {
        def languageInstance = Language.get(params.id)
        if (!languageInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'language.label', default: 'Language'), params.id])}"
            redirect(action: "list")
        }
        else {
            [languageInstance: languageInstance]
        }
    }

    def edit = {
        def languageInstance = Language.get(params.id)
        if (!languageInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'language.label', default: 'Language'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [languageInstance: languageInstance]
        }
    }

    def update = {
        def languageInstance = Language.get(params.id)
        if (languageInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (languageInstance.version > version) {
                    
                    languageInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'language.label', default: 'Language')] as Object[], "Another user has updated this Language while you were editing")
                    render(view: "edit", model: [languageInstance: languageInstance])
                    return
                }
            }
            languageInstance.properties = params
            if (!languageInstance.hasErrors() && languageInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'language.label', default: 'Language'), languageInstance.id])}"
                redirect(action: "show", id: languageInstance.id)
            }
            else {
                render(view: "edit", model: [languageInstance: languageInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'language.label', default: 'Language'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def languageInstance = Language.get(params.id)
        if (languageInstance) {
            try {
                languageInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'language.label', default: 'Language'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'language.label', default: 'Language'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'language.label', default: 'Language'), params.id])}"
            redirect(action: "list")
        }
    }
}
