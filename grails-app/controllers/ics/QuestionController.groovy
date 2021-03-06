package ics

class QuestionController {

    def springSecurityService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        //params.max = 200
        def language  = params.language
        if(!language)
        	language = 'ENGLISH'
        def course = Course.get(params.'course.id')
        def courses = Course.findAllByDepartment(IndividualRole.findWhere(individual:Individual.findByLoginid(springSecurityService.principal.username),role:Role.findByName('AssessmentAdmin'),status:'VALID')?.department)
        if(!course && courses?.size()==1)
        	course = courses[0]
        [questionInstanceList: course?Question.findAllByCourseAndLanguage(course,language,params):[], courses:courses, course:course, language:language]
    }

    def create = {
        def questionInstance = new Question()
        questionInstance.properties = params
        return [questionInstance: questionInstance]
    }

    def save = {
	params.updator = params.creator=springSecurityService.principal.username
        def questionInstance = new Question(params)
        if (!questionInstance.hasErrors() && questionInstance.save()) {
            flash.message = "question.created"
            flash.args = [questionInstance.id]
            flash.defaultMessage = "Question ${questionInstance.id} created"
            redirect(action: "show", id: questionInstance.id)
        }
        else {
            render(view: "create", model: [questionInstance: questionInstance])
        }
    }

    def show = {
        def questionInstance = Question.get(params.id)
        if (!questionInstance) {
            flash.message = "question.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Question not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [questionInstance: questionInstance]
        }
    }

    def edit = {
        def questionInstance = Question.get(params.id)
        if (!questionInstance) {
            flash.message = "question.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Question not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [questionInstance: questionInstance]
        }
    }

    def update = {
        def questionInstance = Question.get(params.id)
        if (questionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (questionInstance.version > version) {
                    
                    questionInstance.errors.rejectValue("version", "question.optimistic.locking.failure", "Another user has updated this Question while you were editing")
                    render(view: "edit", model: [questionInstance: questionInstance])
                    return
                }
            }
            params.updator=springSecurityService.principal.username
            questionInstance.properties = params
            if (!questionInstance.hasErrors() && questionInstance.save()) {
                flash.message = "question.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Question ${params.id} updated"
                redirect(action: "show", id: questionInstance.id)
            }
            else {
                render(view: "edit", model: [questionInstance: questionInstance])
            }
        }
        else {
            flash.message = "question.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Question not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def questionInstance = Question.get(params.id)
        if (questionInstance) {
            try {
                questionInstance.delete()
                flash.message = "question.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Question ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "question.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Question ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "question.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Question not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
