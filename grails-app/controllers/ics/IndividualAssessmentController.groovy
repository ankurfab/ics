package ics

class IndividualAssessmentController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [individualAssessmentInstanceList: IndividualAssessment.list(params), individualAssessmentInstanceTotal: IndividualAssessment.count()]
    }

    def create = {
        def individualAssessmentInstance = new IndividualAssessment()
        individualAssessmentInstance.properties = params
        return [individualAssessmentInstance: individualAssessmentInstance]
    }

    def save = {
        def individualAssessmentInstance = new IndividualAssessment(params)
        if (!individualAssessmentInstance.hasErrors() && individualAssessmentInstance.save()) {
            flash.message = "individualAssessment.created"
            flash.args = [individualAssessmentInstance.id]
            flash.defaultMessage = "IndividualAssessment ${individualAssessmentInstance.id} created"
            redirect(action: "show", id: individualAssessmentInstance.id)
        }
        else {
            render(view: "create", model: [individualAssessmentInstance: individualAssessmentInstance])
        }
    }

    def show = {
        def individualAssessmentInstance = IndividualAssessment.get(params.id)
        if (!individualAssessmentInstance) {
            flash.message = "individualAssessment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "IndividualAssessment not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [individualAssessmentInstance: individualAssessmentInstance]
        }
    }

    def edit = {
        def individualAssessmentInstance = IndividualAssessment.get(params.id)
        if (!individualAssessmentInstance) {
            flash.message = "individualAssessment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "IndividualAssessment not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [individualAssessmentInstance: individualAssessmentInstance]
        }
    }

    def update = {
        def individualAssessmentInstance = IndividualAssessment.get(params.id)
        if (individualAssessmentInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (individualAssessmentInstance.version > version) {
                    
                    individualAssessmentInstance.errors.rejectValue("version", "individualAssessment.optimistic.locking.failure", "Another user has updated this IndividualAssessment while you were editing")
                    render(view: "edit", model: [individualAssessmentInstance: individualAssessmentInstance])
                    return
                }
            }
            individualAssessmentInstance.properties = params
            if (!individualAssessmentInstance.hasErrors() && individualAssessmentInstance.save()) {
                flash.message = "individualAssessment.updated"
                flash.args = [params.id]
                flash.defaultMessage = "IndividualAssessment ${params.id} updated"
                redirect(action: "show", id: individualAssessmentInstance.id)
            }
            else {
                render(view: "edit", model: [individualAssessmentInstance: individualAssessmentInstance])
            }
        }
        else {
            flash.message = "individualAssessment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "IndividualAssessment not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def individualAssessmentInstance = IndividualAssessment.get(params.id)
        if (individualAssessmentInstance) {
            try {
                individualAssessmentInstance.delete()
                flash.message = "individualAssessment.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "IndividualAssessment ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "individualAssessment.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "IndividualAssessment ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "individualAssessment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "IndividualAssessment not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
