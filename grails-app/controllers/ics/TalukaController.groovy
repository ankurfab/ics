package ics

class TalukaController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [talukaInstanceList: Taluka.list(params), talukaInstanceTotal: Taluka.count()]
    }

    def create = {
        def talukaInstance = new Taluka()
        talukaInstance.properties = params
        return [talukaInstance: talukaInstance]
    }

    def save = {
        def talukaInstance = new Taluka(params)
        if (!talukaInstance.hasErrors() && talukaInstance.save()) {
            flash.message = "taluka.created"
            flash.args = [talukaInstance.id]
            flash.defaultMessage = "Taluka ${talukaInstance.id} created"
            redirect(action: "show", id: talukaInstance.id)
        }
        else {
            render(view: "create", model: [talukaInstance: talukaInstance])
        }
    }

    def show = {
        def talukaInstance = Taluka.get(params.id)
        if (!talukaInstance) {
            flash.message = "taluka.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Taluka not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [talukaInstance: talukaInstance]
        }
    }

    def edit = {
        def talukaInstance = Taluka.get(params.id)
        if (!talukaInstance) {
            flash.message = "taluka.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Taluka not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [talukaInstance: talukaInstance]
        }
    }

    def update = {
        def talukaInstance = Taluka.get(params.id)
        if (talukaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (talukaInstance.version > version) {
                    
                    talukaInstance.errors.rejectValue("version", "taluka.optimistic.locking.failure", "Another user has updated this Taluka while you were editing")
                    render(view: "edit", model: [talukaInstance: talukaInstance])
                    return
                }
            }
            talukaInstance.properties = params
            if (!talukaInstance.hasErrors() && talukaInstance.save()) {
                flash.message = "taluka.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Taluka ${params.id} updated"
                redirect(action: "show", id: talukaInstance.id)
            }
            else {
                render(view: "edit", model: [talukaInstance: talukaInstance])
            }
        }
        else {
            flash.message = "taluka.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Taluka not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def talukaInstance = Taluka.get(params.id)
        if (talukaInstance) {
            try {
                talukaInstance.delete()
                flash.message = "taluka.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Taluka ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "taluka.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Taluka ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "taluka.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Taluka not found with id ${params.id}"
            redirect(action: "list")
        }
    }

  def districtSelected = {
    def district = District.findById(params.id)
    render g.select(optionKey: 'id', from: district.talukas.sort{it.name}, id: 'taluka', name: "taluka",noSelection:['':'Select Taluka...'])
  }


}
