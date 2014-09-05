package ics

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import grails.converters.JSON

class VehicleController {

    def springSecurityService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [vehicleInstanceList: Vehicle.list(params), vehicleInstanceTotal: Vehicle.count()]
    }

    def create = {
        def vehicleInstance = new Vehicle()
        vehicleInstance.properties = params
        return [vehicleInstance: vehicleInstance]
    }

    def save = {
        params.creator=springSecurityService.principal.username
        params.updator=params.creator
        if(params.availableFrom)
        	params.availableFrom = Date.parse('dd-MM-yyyy HH:mm', params.availableFrom)
        if(params.availableTill)
        	params.availableTill = Date.parse('dd-MM-yyyy HH:mm', params.availableTill)
        def vehicleInstance = new Vehicle(params)
	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION'))
		vehicleInstance.status = "VIP"
	else 
	        vehicleInstance.status = "NORMAL"
	        
        vehicleInstance.regNum = params.regNum?.replaceAll('[^a-zA-Z0-9]+','') //just store letters and digits
        if (!vehicleInstance.hasErrors() && vehicleInstance.save()) {
            flash.message = "vehicle.created"
            flash.args = [vehicleInstance.id]
            flash.defaultMessage = "Vehicle ${vehicleInstance.id} created"
            //redirect(action: "show", id: vehicleInstance.id)
            redirect(controller: "Trip", action: "list")
        }
        else {
            render(view: "create", model: [vehicleInstance: vehicleInstance])
        }
    }

    def show = {
        def vehicleInstance = null
        if(params.domainid=="Trip")
        	vehicleInstance = Trip.get(params.id)?.vehicle
        else
        	vehicleInstance = Vehicle.get(params.id)
        if (!vehicleInstance) {
            flash.message = "vehicle.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Vehicle not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [vehicleInstance: vehicleInstance]
        }
    }

    def edit = {
        def vehicleInstance = Vehicle.get(params.id)
        if (!vehicleInstance) {
            flash.message = "vehicle.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Vehicle not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [vehicleInstance: vehicleInstance]
        }
    }

    def update = {
        def vehicleInstance = Vehicle.get(params.id)
        if (vehicleInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (vehicleInstance.version > version) {
                    
                    vehicleInstance.errors.rejectValue("version", "vehicle.optimistic.locking.failure", "Another user has updated this Vehicle while you were editing")
                    render(view: "edit", model: [vehicleInstance: vehicleInstance])
                    return
                }
            }
            params.updator=springSecurityService.principal.username
            vehicleInstance.properties = params
            if (!vehicleInstance.hasErrors() && vehicleInstance.save()) {
                flash.message = "vehicle.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Vehicle ${params.id} updated"
                redirect(action: "show", id: vehicleInstance.id)
            }
            else {
                render(view: "edit", model: [vehicleInstance: vehicleInstance])
            }
        }
        else {
            flash.message = "vehicle.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Vehicle not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def vehicleInstance = Vehicle.get(params.id)
        if (vehicleInstance) {
            try {
                vehicleInstance.delete()
                flash.message = "vehicle.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Vehicle ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "vehicle.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Vehicle ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "vehicle.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Vehicle not found with id ${params.id}"
            redirect(action: "list")
        }
    }
    
    def jq_vehicle_list = {
      def sortIndex = params.sidx ?: 'regNum'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = Vehicle.createCriteria().list(max:maxRows, offset:rowOffset) {
		if(SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION'))
			eq('vipExclusive',true)
		else 
			eq('vipExclusive',false)

		if (params.regNum)
			ilike('regNum','%'+params.regNum + '%')

		if (params.model)
				ilike('model','%'+params.model + '%')

		if (params.type)
			ilike('type','%'+params.type + '%')

		if (params.numCapacity)
			ge('numCapacity',params.int('numCapacity'))

		if (params.ownerName)
			ilike('ownerName','%'+params.ownerName + '%')

		if (params.ownerNumber)
			ilike('ownerNumber','%'+params.ownerNumber + '%')

		if (params.driverName)
			ilike('driverName','%'+params.driverName + '%')

		if (params.driverNumber)
			ilike('driverNumber','%'+params.driverNumber + '%')

		if (params.assistantName)
			ilike('assistantName','%'+params.assistantName + '%')

		if (params.assistantNumber)
			ilike('assistantNumber','%'+params.assistantNumber + '%')

		if (params.comments)//service
			ilike('comments','%'+params.comments + '%')

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.regNum,
            	    it.model,
            	    it.type,
            	    it.numCapacity,
            	    it.ownerName,
            	    it.ownerNumber,
            	    it.driverName,
            	    it.driverNumber,
            	    it.comments
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_vehicle = {
	      log.debug('In jq_vehicle_edit:'+params)
	      def vehicle = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add vehicle sent
		  /*//format the dates
		  params.availableFrom = Date.parse('dd-MM-yyyy HH:mm',params.availableFrom)
		  params.availableTill = Date.parse('dd-MM-yyyy HH:mm',params.availableTill)*/
			if(SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION'))
				params.'vipExclusive'=true
			else 
				params.'vipExclusive'=false
				
		  vehicle = new Vehicle(params)
		  vehicle.availableFrom = vehicle.availableTill = new Date()
		  vehicle.make=""
		  vehicle.updator=vehicle.creator=springSecurityService.principal.username
		  if (! vehicle.hasErrors() && vehicle.save()) {
		    message = "Vehicle Saved.."
		    id = vehicle.id
		    state = "OK"
		  } else {
		    vehicle.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save Vehicle"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check vehicle exists
			  vehicle  = Vehicle.get(it)
			  if (vehicle) {
			    // delete vehicle
			    if(!vehicle.delete())
			    	{
				    vehicle.errors.allErrors.each {
					log.debug("In jq_vehicle_edit: error in deleting vehicle:"+ it)
					}
			    	}
			    else {
				    message = "Deleted!!"
				    state = "OK"
			    }
			  }
		  	}
		  break;
		 default :
		  // edit action
		  // first retrieve the vehicle by its ID
		  vehicle = Vehicle.get(params.id)
		  if (vehicle) {
		    // set the properties according to passed in parameters
		    vehicle.properties = params
			  vehicle.updator = springSecurityService.principal.username
		    if (! vehicle.hasErrors() && vehicle.save()) {
		      message = "Vehicle  ${vehicle.regNum} Updated"
		      id = vehicle.id
		      state = "OK"
		    } else {
			    vehicle.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Vehicle"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def jq_trip_list = {
      def sortIndex = params.sidx ?: 'departureTime'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def vehicle = null
	if(params.vehicleid)
		vehicle=Vehicle.get(params.vehicleid)
		
	def result = Trip.createCriteria().list(max:maxRows, offset:rowOffset) {
		eq('vehicle',vehicle)

		if (params.source)
				ilike('source','%'+params.source + '%')

		if (params.destination)
			ilike('destination','%'+params.destination + '%')

		if (params.inchargeName)
			ilike('inchargeName','%'+params.ownerName + '%')

		if (params.inchargeNumber)
			ilike('inchargeNumber','%'+params.ownerNumber + '%')

		if (params.driverName)
			ilike('driverName','%'+params.ownerName + '%')

		if (params.driverNumber)
			ilike('driverNumber','%'+params.ownerNumber + '%')

		if (params.comments)//service
			ilike('comments','%'+params.comments + '%')

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.departureTime?.format('dd-MM-yyyy HH:mm'),
            	    it.source,
            	    it.destination,
            	    it.arrivalTime?.format('dd-MM-yyyy HH:mm'),
            	    it.inchargeName,
            	    it.inchargeNumber,
            	    it.driverName,
            	    it.driverNumber,
            	    it.comments
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_trip = {
	      def trip = null
	      def message = ""
	      def state = "FAIL"
	      def id

		def vehicle = null
		if(params.vehicleid)
			vehicle=Vehicle.get(params.vehicleid)

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add trip sent
		  //format the dates
		  params.departureTime = Date.parse('dd-MM-yyyy HH:mm',params.departureTime)
		  if(params.arrivalTime)
		  	params.arrivalTime = Date.parse('dd-MM-yyyy HH:mm',params.arrivalTime)
		  
		  trip = new Trip(params)
		  trip.updator=trip.creator=springSecurityService.principal.username
		  if (! trip.hasErrors() && trip.save()) {
		    message = "Trip Saved.."
		    id = trip.id
		    state = "OK"
		  } else {
		    trip.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save Trip"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check trip exists
			  trip  = Trip.get(it)
			  if (trip) {
			    // delete trip
			    if(!trip.delete())
			    	{
				    trip.errors.allErrors.each {
					log.debug("In jq_trip_edit: error in deleting trip:"+ it)
					}
			    	}
			    else {
				    message = "Deleted!!"
				    state = "OK"
			    }
			  }
		  	}
		  break;
		 default :
		  // edit action
		  // first retrieve the trip by its ID
		  trip = Trip.get(params.id)
		  if (trip) {
		    // set the properties according to passed in parameters
		    trip.properties = params
			  trip.updator = springSecurityService.principal.username
		    if (! trip.hasErrors() && trip.save()) {
		      message = "Trip  ${trip.regNum} Updated"
		      id = trip.id
		      state = "OK"
		    } else {
			    trip.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Trip"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }
    
}
