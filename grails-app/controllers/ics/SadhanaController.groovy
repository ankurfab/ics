package ics

import grails.converters.JSON

class SadhanaController {

    def index = {  }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [sadhanaInstanceList: Sadhana.list(params), sadhanaInstanceTotal: Sadhana.count()]
    }

    def create = {
        def sadhanaInstance = new Sadhana()
        sadhanaInstance.properties = params
        return [sadhanaInstance: sadhanaInstance]
    }

    def save = {
        def sadhanaInstance = new Sadhana(params)
        if (!sadhanaInstance.hasErrors() && sadhanaInstance.save()) {
            flash.message = "sadhana.created"
            flash.args = [sadhanaInstance.id]
            flash.defaultMessage = "Sadhana ${sadhanaInstance.id} created"
            redirect(action: "show", id: sadhanaInstance.id)
        }
        else {
            render(view: "create", model: [sadhanaInstance: sadhanaInstance])
        }
    }

    def show = {
        def sadhanaInstance = Sadhana.get(params.id)
        if (!sadhanaInstance) {
            flash.message = "sadhana.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Sadhana not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [sadhanaInstance: sadhanaInstance]
        }
    }

    def edit = {
        def sadhanaInstance = Sadhana.get(params.id)
        if (!sadhanaInstance) {
            flash.message = "sadhana.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Sadhana not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [sadhanaInstance: sadhanaInstance]
        }
    }

    def update = {
        def sadhanaInstance = Sadhana.get(params.id)
        if (sadhanaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (sadhanaInstance.version > version) {
                    
                    sadhanaInstance.errors.rejectValue("version", "sadhana.optimistic.locking.failure", "Another user has updated this Sadhana while you were editing")
                    render(view: "edit", model: [sadhanaInstance: sadhanaInstance])
                    return
                }
            }
            sadhanaInstance.properties = params
            if (!sadhanaInstance.hasErrors() && sadhanaInstance.save()) {
                flash.message = "sadhana.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Sadhana ${params.id} updated"
                redirect(action: "show", id: sadhanaInstance.id)
            }
            else {
                render(view: "edit", model: [sadhanaInstance: sadhanaInstance])
            }
        }
        else {
            flash.message = "sadhana.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Sadhana not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def sadhanaInstance = Sadhana.get(params.id)
        if (sadhanaInstance) {
            try {
                sadhanaInstance.delete()
                flash.message = "sadhana.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Sadhana ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "sadhana.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Sadhana ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "sadhana.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Sadhana not found with id ${params.id}"
            redirect(action: "list")
        }
    }

// return JSON list of sadhana
    def jq_sadhana_list = {      
      
      def sortIndex = params.sidx ?: 'day'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
      
      def result = Sadhana.createCriteria().list(max:maxRows, offset:rowOffset) {
            eq("devotee",Individual.get(session.individualid))
            order(sortIndex, sortOrder)
      }
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)
      
      def jsonCells = []
      result.each {
	    
	    jsonCells.add([cell: [
		    it.day?.format('w'),
		    it.day?.format('EEE'),
		    it.day?.format('dd-MM-yy'),
		    it.attendedMangalAratik,
		    it.attendedSandhyaAratik,
		    it.numRoundsBefore9,
		    it.numRoundsBetween9And12,
		    it.numRoundsBetween12And6,
		    it.numRoundsBetween6And9,
		    it.numRoundsAfter9,
		    it.minutesRead,
		    it.minutesHeard,
		    it.minutesAssociated,
		    it.comments,
		], id: it.id])
        }
        
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }
    
	def jq_edit_sadhana = {
	      println "inside jq_edit_sadhana: "+params
	      def sadhana
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add sadhana sent
		  //format the dates
		  params.day = Date.parse('dd-MM-yyyy',params.Date)
		  params.devotee = Individual.get(session.individualid)
		  sadhana = new Sadhana(params)
		  if (! sadhana.hasErrors() && sadhana.save()) {
		    message = "Sadhana Saved.."
		    id = sadhana.id
		    state = "OK"
		  } else {
		    sadhana.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save Sadhana"
		  }
		  break;
		case 'del':
		  // check menu exists
		  sadhana = Sadhana.get(params.id)
		  if (sadhana) {
		    // delete menu
		    sadhana.delete()
		    message = "sadhana Deleted"
		    state = "OK"
		  }
		  break;
		 default :
		  // edit action
		  // first retrieve the menu by its ID
		  sadhana = Sadhana.get(params.id)
		  if (sadhana) {
		    // set the properties according to passed in parameters
		  //format the dates
		  params.day = Date.parse('dd-MM-yyyy',params.Date)
		    sadhana.properties = params
		    if (! sadhana.hasErrors() && sadhana.save()) {
		      message = "sadhana  Updated"
		      id = sadhana.id
		      state = "OK"
		    } else {
			    sadhana.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update sadhana"
		    }
		  }
		  break;
 	 }

      def response = [message:message,state:state,id:id]

      render response as JSON
    }
}
