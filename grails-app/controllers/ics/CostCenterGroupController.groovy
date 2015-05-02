package ics
import groovy.sql.Sql;
import java.util.zip.ZipOutputStream  
import java.util.zip.ZipEntry  
import org.grails.plugins.csv.CSVWriter
import org.apache.commons.lang.StringEscapeUtils.*

class CostCenterGroupController {

    def financeService
    def dataSource

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [costCenterGroupInstanceList: CostCenterGroup.list(params), costCenterGroupInstanceTotal: CostCenterGroup.count()]
    }

    def create = {
        def costCenterGroupInstance = new CostCenterGroup()
        costCenterGroupInstance.properties = params
        return [costCenterGroupInstance: costCenterGroupInstance]
    }

    def save = {
        def costCenterGroupInstance = new CostCenterGroup(params)
        if (!costCenterGroupInstance.hasErrors() && costCenterGroupInstance.save()) {
            flash.message = "costCenterGroup.created"
            flash.args = [costCenterGroupInstance.id]
            flash.defaultMessage = "CostCenterGroup ${costCenterGroupInstance.id} created"
            redirect(action: "show", id: costCenterGroupInstance.id)
        }
        else {
            render(view: "create", model: [costCenterGroupInstance: costCenterGroupInstance])
        }
    }

    def show = {
        def costCenterGroupInstance = CostCenterGroup.get(params.id)
        if (!costCenterGroupInstance) {
            flash.message = "costCenterGroup.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CostCenterGroup not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [costCenterGroupInstance: costCenterGroupInstance]
        }
    }

    def edit = {
        def costCenterGroupInstance = CostCenterGroup.get(params.id)
        if (!costCenterGroupInstance) {
            flash.message = "costCenterGroup.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CostCenterGroup not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [costCenterGroupInstance: costCenterGroupInstance]
        }
    }

    def update = {
        def costCenterGroupInstance = CostCenterGroup.get(params.id)
        if (costCenterGroupInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (costCenterGroupInstance.version > version) {
                    
                    costCenterGroupInstance.errors.rejectValue("version", "costCenterGroup.optimistic.locking.failure", "Another user has updated this CostCenterGroup while you were editing")
                    render(view: "edit", model: [costCenterGroupInstance: costCenterGroupInstance])
                    return
                }
            }
            costCenterGroupInstance.properties = params
            if (!costCenterGroupInstance.hasErrors() && costCenterGroupInstance.save()) {
                flash.message = "costCenterGroup.updated"
                flash.args = [params.id]
                flash.defaultMessage = "CostCenterGroup ${params.id} updated"
                redirect(action: "show", id: costCenterGroupInstance.id)
            }
            else {
                render(view: "edit", model: [costCenterGroupInstance: costCenterGroupInstance])
            }
        }
        else {
            flash.message = "costCenterGroup.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CostCenterGroup not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def costCenterGroupInstance = CostCenterGroup.get(params.id)
        if (costCenterGroupInstance) {
            try {
                costCenterGroupInstance.delete()
                flash.message = "costCenterGroup.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "CostCenterGroup ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "costCenterGroup.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "CostCenterGroup ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "costCenterGroup.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CostCenterGroup not found with id ${params.id}"
            redirect(action: "list")
        }
    }
    
    def showOwner() {
                def ownerid = CostCenterGroup.get(params.id)?.owner1?.id
                redirect(controller:"individual",action: "show", id: ownerid)    	
                return
    }

    def uploadForCG() {
	    log.debug("Inside uploadForCG")
	    
	    def f = request.getFile('myFile')
	    if (f.empty) {
		flash.message = 'file cannot be empty'
		render flash.message
		return
	    }

	    def numRecords = 0, numCreated=0
	    //format
	    //name,description,loginid,owner_icsid
	    f.inputStream.toCsvReader(['skipLines':'1']).eachLine{ tokens ->
	    	numRecords++
	    	if(financeService.createCG(tokens))
	    		numCreated++
	    }
	    
	    flash.message="Created "+numCreated+"/"+numRecords+" CGs!!"
	    render flash.message
	    
    }	

    def cgBackup() {
    	response.contentType = 'application/zip'
    	def query = "SELECT cg.id,name,i.icsid,cg.updator,cg.last_updated FROM cost_center_group cg,individual i where cg.owner1_id=i.id"
    	def sql = new Sql(dataSource)
    	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		def fileName = "cg_"+new Date().format('ddMMyyHHmmss')+".csv"
		zipOutputStream.putNextEntry(new ZipEntry(fileName))
		//header
		def headers = null; //["id","name"]

		sql.rows(query).each{ row ->
			   if (headers == null) {
				headers = row.keySet()
				log.debug("headers:"+headers)
				zipOutputStream << headers
			        zipOutputStream << "\n"
			   }
			//with escaping for excel
			log.debug("row:"+row)
			zipOutputStream << row.values().collect{it.toString()}
			zipOutputStream << "\n"
		}
	}    	
    }

}
