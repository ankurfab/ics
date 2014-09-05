package ics
import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class TripController {

    def springSecurityService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        //params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        //[tripInstanceList: Trip.list(params), tripInstanceTotal: Trip.count()]
    }

    def create = {
        def tripInstance = new Trip()
        tripInstance.properties = params
        return [tripInstance: tripInstance]
    }

    def save = {
        params.creator=springSecurityService.principal.username
        params.updator=params.creator
        def tripInstance = new Trip(params)
        if (!tripInstance.hasErrors() && tripInstance.save()) {
            flash.message = "trip.created"
            flash.args = [tripInstance.id]
            flash.defaultMessage = "Trip ${tripInstance.id} created"
            redirect(action: "show", id: tripInstance.id)
        }
        else {
            render(view: "create", model: [tripInstance: tripInstance])
        }
    }

    def show = {
        def tripInstance = Trip.get(params.id)
        if (!tripInstance) {
            flash.message = "trip.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Trip not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [tripInstance: tripInstance]
        }
    }

    def edit = {
        def tripInstance = Trip.get(params.id)
        if (!tripInstance) {
            flash.message = "trip.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Trip not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [tripInstance: tripInstance]
        }
    }

    def update = {
        def tripInstance = Trip.get(params.id)
        if (tripInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tripInstance.version > version) {
                    
                    tripInstance.errors.rejectValue("version", "trip.optimistic.locking.failure", "Another user has updated this Trip while you were editing")
                    render(view: "edit", model: [tripInstance: tripInstance])
                    return
                }
            }
            params.updator=springSecurityService.principal.username
            tripInstance.properties = params
            if (!tripInstance.hasErrors() && tripInstance.save()) {
                flash.message = "trip.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Trip ${params.id} updated"
                redirect(action: "show", id: tripInstance.id)
            }
            else {
                render(view: "edit", model: [tripInstance: tripInstance])
            }
        }
        else {
            flash.message = "trip.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Trip not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def tripInstance = Trip.get(params.id)
        if (tripInstance) {
            try {
                tripInstance.delete()
                flash.message = "trip.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Trip ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "trip.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Trip ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "trip.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Trip not found with id ${params.id}"
            redirect(action: "list")
        }
    }

    def jq_trip_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = Trip.createCriteria().list(max:maxRows, offset:rowOffset) {
		if(SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION'))
			vehicle{eq('vipExclusive',true)}
		else 
			vehicle{eq('vipExclusive',false)}

		if (params.'vehicle.id')
			vehicle{ilike('regNum','%'+params.'vehicle.id' + '%')}

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
            	    it.vehicle.toString(),
            	    it.source,
            	    it.departureTime?.format('dd-MM-yyyy HH:mm'),
            	    it.destination,
            	    it.arrivalTime?.format('dd-MM-yy HH:mm'),
            	    it.inchargeName,
            	    it.inchargeNumber,
            	    it.driverName,
            	    it.driverNumber,
            	    it.comments,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def jq_arr_list = {
      def sortIndex = params.sidx ?: 'arrivalDate'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def result = EventRegistration.createCriteria().list(max:maxRows, offset:rowOffset) {

		    eq('verificationStatus',VerificationStatus.VERIFIED)
		    isNull('status')
		    eq('pickUpRequired',true)

	     	    if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION'))
	     	    	eq('isVipDevotee',true)
	     	    else
	     	    	eq('isVipDevotee',false)
		    

		    if (params.arrivalPoint)
			ilike('arrivalPoint','%'+params.arrivalPoint + '%')

		    if (params.arrivalDate)
		    {
			def dt=Date.parse('dd-MM-yyyy', params.arrivalDate)
			and{
			    ge('arrivalDate',dt )
			    le('arrivalDate',dt+1 )
			}
		    }

		    if (params.name)
			ilike('name','%'+params.name + '%')

		    if (params.contactNumber)
			ilike('contactNumber','%'+params.contactNumber + '%')

		    if (params.regCode)
			eq('regCode',params.regCode)

		    if (params.arrivalTransportMode)
			ilike('arrivalTransportMode','%'+params.arrivalTransportMode + '%')

		    if (params.arrivalNumber)
			ilike('arrivalNumber','%'+params.arrivalNumber + '%')

		    if (params.arrivalName)
			ilike('arrivalName','%'+params.arrivalName + '%')

		    if (params.arrivalTravelingDetails)
			ilike('arrivalTravelingDetails','%'+params.arrivalTravelingDetails + '%')

            order(sortIndex, sortOrder)
      }
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
                    it.arrivalDate.format('dd-MM HH:mm'),
            	    it.arrivalPoint,
                    it.name,
                    it.contactNumber,
                    it.regCode,
                    it.arrivalTransportMode?.toString(),
                    it.arrivalNumber,
                    it.arrivalName,
                    it.arrivalTravelingDetails,
                    ((it.numberofBrahmacharis?:0)+(it.numberofPrabhujis?:0)+(it.numberofMatajis?:0)+(it.numberofChildren?:0))+" (B"+it.numberofBrahmacharis+" P"+it.numberofPrabhujis+" M"+it.numberofMatajis+" C"+it.numberofChildren+")",
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def jq_dep_list = {
      def sortIndex = params.sidx ?: 'departureDate'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def result = EventRegistrationGroup.createCriteria().list(max:maxRows, offset:rowOffset) {

		    mainEventRegistration{eq('dropRequired',true)}

	     	    if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION'))
	     	    	mainEventRegistration{eq('isVipDevotee',true)}
	     	    else
	     	    	mainEventRegistration{eq('isVipDevotee',false)}
		    

		    if (params.departurePoint)
			mainEventRegistration{ilike('departurePoint','%'+params.departurePoint + '%')}

		    if (params.departureDate)
		    {
			def dt=Date.parse('dd-MM-yyyy', params.departureDate)
			mainEventRegistration{
				and{
				    ge('departureDate',dt )
				    le('departureDate',dt+1 )
				}
			}
		    }

		    if (params.name)
			mainEventRegistration{ilike('name','%'+params.name + '%')}

		    if (params.contactNumber)
			mainEventRegistration{ilike('contactNumber','%'+params.contactNumber + '%')}

		    if (params.regCode)
			mainEventRegistration{eq('regCode',params.regCode)}

		    if (params.departureTransportMode)
			mainEventRegistration{ilike('departureTransportMode','%'+params.departureTransportMode + '%')}

		    if (params.departureNumber)
			mainEventRegistration{ilike('departureNumber','%'+params.departureNumber + '%')}

		    if (params.departureName)
			mainEventRegistration{ilike('departureName','%'+params.departureName + '%')}

		    if (params.departureTravelingDetails)
			mainEventRegistration{ilike('departureTravelingDetails','%'+params.departureTravelingDetails + '%')}

            mainEventRegistration{order(sortIndex, sortOrder)}
      }
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
                    it.mainEventRegistration.departureDate.format('dd-MM HH:mm'),
            	    it.mainEventRegistration.departurePoint,
                    it.mainEventRegistration.name,
                    it.mainEventRegistration.contactNumber,
                    it.mainEventRegistration.regCode,
                    it.mainEventRegistration.departureTransportMode?.toString(),
                    it.mainEventRegistration.departureNumber,
                    it.mainEventRegistration.departureName,
                    it.mainEventRegistration.departureTravelingDetails,
                    it.total+" (B"+it.numBrahmachari+" P"+it.numPrji+" M"+it.numMataji+" C"+it.numChildren+")",
                ], id: it.mainEventRegistration.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_trip = {
	      log.debug('In jq_trip_edit:'+params)
	      def trip = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add trip sent
		  //format the dates
		  if(params.departureTime)
			  params.departureTime = Date.parse('dd-MM-yyyy HH:mm',params.departureTime)
		  if(params.arrivalTime)
		  	params.arrivalTime = Date.parse('dd-MM-yyyy HH:mm',params.arrivalTime)
		  
		  if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION') && !params.departureTime)
		  	params.departureTime = new Date()
		  trip = new Trip(params)
		  def vehicle = Vehicle.get(params.'vehicle.id')
		  if(!params.driverName)
		  	trip.driverName = vehicle?.driverName
		  if(!params.driverNumber)
		  	trip.driverNumber = vehicle?.driverNumber
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
			  //format the dates
			  if(params.departureTime)
				  params.departureTime = Date.parse('dd-MM-yyyy HH:mm',params.departureTime)
			  if(params.arrivalTime)
				params.arrivalTime = Date.parse('dd-MM-yyyy HH:mm',params.arrivalTime)

		    // set the properties according to passed in parameters
		    trip.properties = params
			  trip.updator = springSecurityService.principal.username
		    if (! trip.hasErrors() && trip.save()) {
		      message = "Trip Updated"
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

    def jq_trip_allotted_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def trip = null
      if(params.tripid)
      	trip = Trip.get(params.tripid)
      
      def result = TripAllotment.createCriteria().list(max:maxRows, offset:rowOffset) {
            	eq('trip',trip)

		if (params.name)
			eventRegistration{ilike('name','%'+params.name + '%')}

		if (params.regCode)
			eventRegistration{ilike('regCode','%'+params.regCode + '%')}

		if (params.connectedIskconCenter)
			eventRegistration{ilike('connectedIskconCenter','%'+params.connectedIskconCenter + '%')}

		if (params.contactNumber)
			eventRegistration{ilike('contactNumber','%'+params.contactNumber + '%')}
				
            order(sortIndex, sortOrder)
      }
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.eventRegistration.name,
                    it.eventRegistration.regCode,
                    it.eventRegistration.connectedIskconCenter,
                    it.eventRegistration.contactNumber,
                    it.eventRegistration.arrivalDate?.format('dd-MM-yy HH:mm'),
                    it.eventRegistration.departureDate?.format('dd-MM-yy HH:mm'),
                    it.eventRegistration.numberofPrabhujis,
                    it.eventRegistration.numberofMatajis,
                    it.eventRegistration.numberofChildren,
                    it.eventRegistration.numberofBrahmacharis,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def allotTrip() {
      def message = ""
      def state = "FAIL"
      int count = 0
      def trip = null
      if(params.tripid)
      	trip = Trip.get(params.tripid)
      if(trip)
      	{
      	params.idlist?.tokenize(',').each {
      		def tripAllotment = new TripAllotment()
      		tripAllotment.trip = trip
      		tripAllotment.eventRegistration = EventRegistration.get(it)
      		tripAllotment.updator = tripAllotment.creator = springSecurityService.principal.username
      		if(!tripAllotment.save())
			    tripAllotment.errors.allErrors.each {
				log.debug("allotTrip:Error in saving tripAllotment: "+ it)
				}
		else
			count++
      		}
      	}
      if(count>0)
      	state = "OK"
      def response = [message:count+" allotted!",state:state]
      render response as JSON
    }

    def unallotTrip() {
      def message = ""
      def state = "FAIL"
      int count = 0
      	params.idlist?.tokenize(',').each {
      		def tripAllotment = TripAllotment.get(it)
      		if(!tripAllotment.delete())
			    tripAllotment.errors.allErrors.each {
				log.debug("unallotTrip: Error in deleting tripAllotment: "+ it)
				}
		else
			{
			count++
			}
      		}
      if(count>0)
      	state = "OK"
      def response = [message:count+" unallotted!",state:state]
      render response as JSON
    }


}
