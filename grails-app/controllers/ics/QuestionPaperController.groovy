package ics

class QuestionPaperController {

    def springSecurityService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [questionPaperInstanceList: QuestionPaper.list(params), questionPaperInstanceTotal: QuestionPaper.count()]
    }

    def create = {
        def questionPaperInstance = new QuestionPaper()
        questionPaperInstance.properties = params
        return [questionPaperInstance: questionPaperInstance]
    }

    def save = {
	params.updator = params.creator=springSecurityService.principal.username
        def questionPaperInstance = new QuestionPaper(params)
        if (!questionPaperInstance.hasErrors() && questionPaperInstance.save()) {
            flash.message = "questionPaper.created"
            flash.args = [questionPaperInstance.id]
            flash.defaultMessage = "QuestionPaper ${questionPaperInstance.id} created"
            redirect(action: "show", id: questionPaperInstance.id)
        }
        else {
            render(view: "create", model: [questionPaperInstance: questionPaperInstance])
        }
    }

    def show = {
        def questionPaperInstance = QuestionPaper.get(params.id)
        if (!questionPaperInstance) {
            flash.message = "questionPaper.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "QuestionPaper not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [questionPaperInstance: questionPaperInstance]
        }
    }

    def edit = {
        def questionPaperInstance = QuestionPaper.get(params.id)
        if (!questionPaperInstance) {
            flash.message = "questionPaper.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "QuestionPaper not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [questionPaperInstance: questionPaperInstance]
        }
    }

    def update = {
        def questionPaperInstance = QuestionPaper.get(params.id)
        if (questionPaperInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (questionPaperInstance.version > version) {
                    
                    questionPaperInstance.errors.rejectValue("version", "questionPaper.optimistic.locking.failure", "Another user has updated this QuestionPaper while you were editing")
                    render(view: "edit", model: [questionPaperInstance: questionPaperInstance])
                    return
                }
            }
            params.updator=springSecurityService.principal.username
            questionPaperInstance.properties = params
            if (!questionPaperInstance.hasErrors() && questionPaperInstance.save()) {
                flash.message = "questionPaper.updated"
                flash.args = [params.id]
                flash.defaultMessage = "QuestionPaper ${params.id} updated"
                redirect(action: "show", id: questionPaperInstance.id)
            }
            else {
                render(view: "edit", model: [questionPaperInstance: questionPaperInstance])
            }
        }
        else {
            flash.message = "questionPaper.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "QuestionPaper not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def questionPaperInstance = QuestionPaper.get(params.id)
        if (questionPaperInstance) {
            try {
                questionPaperInstance.delete()
                flash.message = "questionPaper.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "QuestionPaper ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "questionPaper.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "QuestionPaper ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "questionPaper.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "QuestionPaper not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
