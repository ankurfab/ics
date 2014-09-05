package ics
import grails.converters.JSON

class EventVolunteerController {

    def springSecurityService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
    }

    def create = {
        def eventVolunteerInstance = new EventVolunteer()
        eventVolunteerInstance.properties = params
        return [eventVolunteerInstance: eventVolunteerInstance]
    }

    def save = {
        params.creator=springSecurityService.principal.username
        params.updator=params.creator
        def eventVolunteerInstance = new EventVolunteer(params)
        if (!eventVolunteerInstance.hasErrors() && eventVolunteerInstance.save()) {
            flash.message = "eventVolunteer.created"
            flash.args = [eventVolunteerInstance.id]
            flash.defaultMessage = "EventVolunteer ${eventVolunteerInstance.id} created"
            redirect(action: "show", id: eventVolunteerInstance.id)
        }
        else {
            render(view: "create", model: [eventVolunteerInstance: eventVolunteerInstance])
        }
    }

    def show = {
        def eventVolunteerInstance = EventVolunteer.get(params.id)
        if (!eventVolunteerInstance) {
            flash.message = "eventVolunteer.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventVolunteer not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [eventVolunteerInstance: eventVolunteerInstance]
        }
    }

    def edit = {
        def eventVolunteerInstance = EventVolunteer.get(params.id)
        if (!eventVolunteerInstance) {
            flash.message = "eventVolunteer.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventVolunteer not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [eventVolunteerInstance: eventVolunteerInstance]
        }
    }

    def update = {
        def eventVolunteerInstance = EventVolunteer.get(params.id)
        if (eventVolunteerInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (eventVolunteerInstance.version > version) {
                    
                    eventVolunteerInstance.errors.rejectValue("version", "eventVolunteer.optimistic.locking.failure", "Another user has updated this EventVolunteer while you were editing")
                    render(view: "edit", model: [eventVolunteerInstance: eventVolunteerInstance])
                    return
                }
            }
            params.updator=springSecurityService.principal.username
            eventVolunteerInstance.properties = params
            if (!eventVolunteerInstance.hasErrors() && eventVolunteerInstance.save()) {
                flash.message = "eventVolunteer.updated"
                flash.args = [params.id]
                flash.defaultMessage = "EventVolunteer ${params.id} updated"
                redirect(action: "show", id: eventVolunteerInstance.id)
            }
            else {
                render(view: "edit", model: [eventVolunteerInstance: eventVolunteerInstance])
            }
        }
        else {
            flash.message = "eventVolunteer.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventVolunteer not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def eventVolunteerInstance = EventVolunteer.get(params.id)
        if (eventVolunteerInstance) {
            try {
                eventVolunteerInstance.delete()
                flash.message = "eventVolunteer.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "EventVolunteer ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "eventVolunteer.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "EventVolunteer ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "eventVolunteer.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventVolunteer not found with id ${params.id}"
            redirect(action: "list")
        }
    }

// return JSON list of volunteers
    def jq_volunteer_list = {
    println 'volunteer LIST Params:'+params
      def event = Event.findByTitle('RVTO')	//todo hardcoding
      def sortIndex = params.sidx ?: 'department'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def volunteers = EventVolunteer.createCriteria().list(max:maxRows, offset:rowOffset) {
            
            order(sortIndex, sortOrder)
      }
      def totalRows = volunteers.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = volunteers.collect {
            [cell: [
            	    it.department,
                    it.seva,
                    it.requiredFrom?.format('dd-MM-yy HH:mm'),
                    it.requiredTill?.format('dd-MM-yy HH:mm'),
                    it.numPrjiRequired,
                    it.numMatajiRequired,
                    it.numPrjiAllotted,
                    it.numMatajiAllotted,
                    it.updator,
                    it.lastUpdated?.format('dd-MM-yy HH:mm'),
                    it.creator,
                    it.dateCreated?.format('dd-MM-yy HH:mm'),
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_volunteer = {
	      def volunteer = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add instruction sent
		  params.requiredFrom = Date.parse('dd-MM-yyyy HH:mm', params.requiredFrom)
		  params.requiredTill = Date.parse('dd-MM-yyyy HH:mm', params.requiredFrom)
		  volunteer = new EventVolunteer(params)
		  volunteer.creator = springSecurityService.principal.username
		  volunteer.updator = volunteer.creator
		  volunteer.event = Event.findByTitle('RVTO')
		  
		  if (! volunteer.hasErrors() && volunteer.save()) {
		    message = "volunteer ${volunteer.id} Added"
		    id = volunteer.id
		    state = "OK"
		  } else {
		    volunteer.errors.allErrors.each {
			println it
			}
		    message = "Could Not Save volunteer"
		  }
		  break;
		case 'del':
		  // check volunteer exists
		  volunteer = volunteer.get(params.id)
		  if (volunteer) {
		    // delete volunteer
		    volunteer.delete()
		    message = "volunteer  ${volunteer.id} Deleted"
		    state = "OK"
		  }
		  break;
		 default :
		  // edit action
		  // first retrieve the volunteer by its ID
		  volunteer = EventVolunteer.get(params.id)
		  if (volunteer) {
		    // set the properties according to passed in parameters
		    params.requiredFrom = Date.parse('dd-MM-yyyy HH:mm', params.requiredFrom)
		    params.requiredTill = Date.parse('dd-MM-yyyy HH:mm', params.requiredFrom)
		    volunteer.properties = params
		    volunteer.updator = springSecurityService.principal.username
		    if (! volunteer.hasErrors() && volunteer.save()) {
		      message = "volunteer  ${volunteer.id} Updated"
		      id = volunteer.id
		      state = "OK"
		    } else {
			    volunteer.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update volunteer"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def jq_op_volunteer_list = {
      println 'jq_op_volunteer_list Params:'+params
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def result = EventRegistration.createCriteria().list(max:maxRows, offset:rowOffset) {
            eq('verificationStatus',VerificationStatus.VERIFIED)
            eq('isVolunteersAvailable',true)
            isNull('status')
            order(sortIndex, sortOrder)
      }
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.name,
                    it.regCode,
                    it.connectedIskconCenter,
                    it.contactNumber,
                    it.arrivalDate?.format('dd-MM-yy HH:mm'),
                    it.departureDate?.format('dd-MM-yy HH:mm'),
                    it.numPrjiVolunteer,
                    it.numMatajiVolunteer,
                    it.numBrahmacharisVolunteer,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

}
