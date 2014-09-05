package ics

class ProfessionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [professionInstanceList: Profession.list(params), professionInstanceTotal: Profession.count()]
    }

    def create = {
        def professionInstance = new Profession()
        professionInstance.properties = params
        return [professionInstance: professionInstance]
    }

    def save = {
        def professionInstance = new Profession(params)
        if (professionInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'profession.label', default: 'Profession'), professionInstance.id])}"
            redirect(action: "show", id: professionInstance.id)
        }
        else {
            render(view: "create", model: [professionInstance: professionInstance])
        }
    }

    def show = {
        def professionInstance = Profession.get(params.id)
        if (!professionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'profession.label', default: 'Profession'), params.id])}"
            redirect(action: "list")
        }
        else {
            [professionInstance: professionInstance]
        }
    }

    def edit = {
        def professionInstance = Profession.get(params.id)
        if (!professionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'profession.label', default: 'Profession'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [professionInstance: professionInstance]
        }
    }

    def update = {
        def professionInstance = Profession.get(params.id)
        if (professionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (professionInstance.version > version) {
                    
                    professionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'profession.label', default: 'Profession')] as Object[], "Another user has updated this Profession while you were editing")
                    render(view: "edit", model: [professionInstance: professionInstance])
                    return
                }
            }
            professionInstance.properties = params
            if (!professionInstance.hasErrors() && professionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'profession.label', default: 'Profession'), professionInstance.id])}"
                redirect(action: "show", id: professionInstance.id)
            }
            else {
                render(view: "edit", model: [professionInstance: professionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'profession.label', default: 'Profession'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def professionInstance = Profession.get(params.id)
        if (professionInstance) {
            try {
                professionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'profession.label', default: 'Profession'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'profession.label', default: 'Profession'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'profession.label', default: 'Profession'), params.id])}"
            redirect(action: "list")
        }
    }
}
