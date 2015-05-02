package ics

class VillageController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [villageInstanceList: Village.list(params), villageInstanceTotal: Village.count()]
    }

    def create = {
        def villageInstance = new Village()
        villageInstance.properties = params
        return [villageInstance: villageInstance]
    }

    def save = {
        def villageInstance = new Village(params)
        if (!villageInstance.hasErrors() && villageInstance.save()) {
            flash.message = "village.created"
            flash.args = [villageInstance.id]
            flash.defaultMessage = "Village ${villageInstance.id} created"
            redirect(action: "show", id: villageInstance.id)
        }
        else {
            render(view: "create", model: [villageInstance: villageInstance])
        }
    }

    def show = {
        def villageInstance = Village.get(params.id)
        if (!villageInstance) {
            flash.message = "village.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Village not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [villageInstance: villageInstance]
        }
    }

    def edit = {
        def villageInstance = Village.get(params.id)
        if (!villageInstance) {
            flash.message = "village.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Village not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [villageInstance: villageInstance]
        }
    }

    def update = {
        def villageInstance = Village.get(params.id)
        if (villageInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (villageInstance.version > version) {
                    
                    villageInstance.errors.rejectValue("version", "village.optimistic.locking.failure", "Another user has updated this Village while you were editing")
                    render(view: "edit", model: [villageInstance: villageInstance])
                    return
                }
            }
            villageInstance.properties = params
            if (!villageInstance.hasErrors() && villageInstance.save()) {
                flash.message = "village.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Village ${params.id} updated"
                redirect(action: "show", id: villageInstance.id)
            }
            else {
                render(view: "edit", model: [villageInstance: villageInstance])
            }
        }
        else {
            flash.message = "village.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Village not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def villageInstance = Village.get(params.id)
        if (villageInstance) {
            try {
                villageInstance.delete()
                flash.message = "village.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Village ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "village.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Village ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "village.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Village not found with id ${params.id}"
            redirect(action: "list")
        }
    }

  def talukaSelected = {
    def taluka = Taluka.findById(params.id)
    render g.select(optionKey: 'id', from: taluka.villages.sort{it.name}, id: 'village', name: "village",noSelection:['':'Select Village...'])+"ZZZ"+g.select(optionKey: 'id', from: taluka.villages.sort{it.name}, id: 'postVillage', name: "postVillage",noSelection:['':'Select Post Village...'])
  }

}
