package ics

class IndividualAssessmentQAController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [individualAssessmentQAInstanceList: IndividualAssessmentQA.list(params), individualAssessmentQAInstanceTotal: IndividualAssessmentQA.count()]
    }

    def create = {
        def individualAssessmentQAInstance = new IndividualAssessmentQA()
        individualAssessmentQAInstance.properties = params
        return [individualAssessmentQAInstance: individualAssessmentQAInstance]
    }

    def save = {
        def individualAssessmentQAInstance = new IndividualAssessmentQA(params)
        if (!individualAssessmentQAInstance.hasErrors() && individualAssessmentQAInstance.save()) {
            flash.message = "individualAssessmentQA.created"
            flash.args = [individualAssessmentQAInstance.id]
            flash.defaultMessage = "IndividualAssessmentQA ${individualAssessmentQAInstance.id} created"
            redirect(action: "show", id: individualAssessmentQAInstance.id)
        }
        else {
            render(view: "create", model: [individualAssessmentQAInstance: individualAssessmentQAInstance])
        }
    }

    def show = {
        def individualAssessmentQAInstance = IndividualAssessmentQA.get(params.id)
        if (!individualAssessmentQAInstance) {
            flash.message = "individualAssessmentQA.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "IndividualAssessmentQA not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [individualAssessmentQAInstance: individualAssessmentQAInstance]
        }
    }

    def edit = {
        def individualAssessmentQAInstance = IndividualAssessmentQA.get(params.id)
        if (!individualAssessmentQAInstance) {
            flash.message = "individualAssessmentQA.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "IndividualAssessmentQA not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [individualAssessmentQAInstance: individualAssessmentQAInstance]
        }
    }

    def update = {
        def individualAssessmentQAInstance = IndividualAssessmentQA.get(params.id)
        if (individualAssessmentQAInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (individualAssessmentQAInstance.version > version) {
                    
                    individualAssessmentQAInstance.errors.rejectValue("version", "individualAssessmentQA.optimistic.locking.failure", "Another user has updated this IndividualAssessmentQA while you were editing")
                    render(view: "edit", model: [individualAssessmentQAInstance: individualAssessmentQAInstance])
                    return
                }
            }
            individualAssessmentQAInstance.properties = params
            if (!individualAssessmentQAInstance.hasErrors() && individualAssessmentQAInstance.save()) {
                flash.message = "individualAssessmentQA.updated"
                flash.args = [params.id]
                flash.defaultMessage = "IndividualAssessmentQA ${params.id} updated"
                redirect(action: "show", id: individualAssessmentQAInstance.id)
            }
            else {
                render(view: "edit", model: [individualAssessmentQAInstance: individualAssessmentQAInstance])
            }
        }
        else {
            flash.message = "individualAssessmentQA.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "IndividualAssessmentQA not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def individualAssessmentQAInstance = IndividualAssessmentQA.get(params.id)
        if (individualAssessmentQAInstance) {
            try {
                individualAssessmentQAInstance.delete()
                flash.message = "individualAssessmentQA.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "IndividualAssessmentQA ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "individualAssessmentQA.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "IndividualAssessmentQA ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "individualAssessmentQA.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "IndividualAssessmentQA not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
