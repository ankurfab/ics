package ics

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.dao.DataIntegrityViolationException
import groovy.sql.Sql;
import grails.converters.JSON
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import groovy.time.TimeCategory
import grails.util.Environment
import com.krishna.IcsRole;
import com.krishna.IcsUser;
import com.krishna.IcsUserIcsRole;

import org.apache.commons.codec.binary.Hex

import org.apache.commons.codec.digest.DigestUtils
import java.security.SecureRandom

import java.text.ParseException
import java.text.SimpleDateFormat

class EventRegistrationController {

    def helperService
    def housekeepingService
    def springSecurityService
    def registrationService
    def simpleCaptchaService 
    def accommodationService
    
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
	def currentDate = new Date()

	def event
	if(params.eid)
		{
		try
			{
			event = Event.get(params.eid)
			}
		catch(Exception e)
			{
			log.debug(e)
			}
		
		if(!event || (currentDate<event.regstartDate) || (currentDate>event.regendDate))
			{
			flash.message = "Online registrations not available! Please contact admin."
			render(view: "message")
			return
			}
		else if(event.department?.name=='GPL')
			{
			    //@TODO: hardcoded, show corresponding form as per category/course
			    render(view: "assessmentRegistrationForm", model: [event: event])
			    return
			}
			
		}
	
	//@TODO: Registration close can be derived from the Event (new field needed)
	//def regCloseDate = Date.parse('dd-MM-yyyy HH:mm', '04-02-2013 16:30')
	def regCloseDate = event?.regendDate
	if (!regCloseDate || currentDate<regCloseDate)
		{
		def er = new EventRegistration()
		if(event)
			er.event = event
		return [eventRegistrationInstance: er]
		}
	else
		{
		flash.message = "Registrations are now closed!"
		render(view: "message")
		}
    }

    def list() {
    }

    def listlocal() {
    }

    def createlocal() {
    }

    def create() {
	if(params.'event.id'=='2')	//@TODO: hardcoded
		{
		redirect(action: "index", params: [eid: "2"])
		return
		}
	//def regCloseDate = Date.parse('dd-MM-yyyy HH:mm', '04-02-2013 16:30')
	def regCloseDate = Date.parse('dd-MM-yyyy HH:mm', '04-02-2023 16:30')//@TODO: remove hardcoding
	def currentDate = new Date()
	if (!SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_REGISTRATION_COORDINATOR,ROLE_EVENTADMIN') && currentDate>regCloseDate)
		{
		flash.message = "Registrations are now closed!"
		render(view: "message")
		}

	boolean captchaValid

	if(params.captcha) {
		captchaValid = simpleCaptchaService.validateCaptcha(params.captcha)
	} else 	if(!SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_REGISTRATION_COORDINATOR,ROLE_EVENTADMIN'))
		{
		flash.message = "Please enter image text!!"
		redirect(action: "index")
    		return
	}
	
	captchaValid = true

    	if(!SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_REGISTRATION_COORDINATOR,ROLE_EVENTADMIN') && !captchaValid) {
	        flash.message = "Invalid Captcha!!"
    		redirect(action: "index")
    		return
    	}
    		
    	if (params.regCode)
    		{
		def ep = registrationService.verify(params.regCode)
		if(ep)
			{
			def er = new EventRegistration()
			er.event = ep.event
			er.individual = ep.individual
			return [eventRegistrationInstance: er]
			return
			}
		else
			{
			flash.message = "Invalid Registration Code!!"
			redirect(action: "index")
			return
			}
		}

		def er = new EventRegistration()
		er.name = params.name
		er.event = Event.findByTitle(params.eventName?:'RVTO')
		er.arrivalTransportMode = TransportMode.BUS
		er.arrivalBusStation = 'Shivaji Nagar'
		er.departureTransportMode = TransportMode.BUS
		er.departureBusStation = 'Shivaji Nagar'
		er.country = Country.findByName('India')
		
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy")

		//If we will not set default for VIP then if user will not change dates from drop down/ datepicker then default will be today's date and same will get saved

		//if(!SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION')) {
			Date arrivalDate = formatter.parse("22-02-2013")
			arrivalDate.set(minute: new Integer(0), hourOfDay: new Integer(0))
			Date departureDate = formatter.parse("24-02-2013")
			departureDate.set(minute: new Integer(0), hourOfDay: new Integer(0))
			er.arrivalDate = arrivalDate
			er.departureDate = departureDate
		//}
		return [eventRegistrationInstance: er]

    	/*if (SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION') || params.name)
    		{
		//create the event registration
		def er = new EventRegistration()
		er.name = params.name
		er.event = Event.findByTitle(params.eventName?:'RVTO')
		er.arrivalTransportMode = TransportMode.BUS
		er.arrivalBusStation = 'Shivaji Nagar'
		er.departureTransportMode = TransportMode.BUS
		er.departureBusStation = 'Shivaji Nagar'
		er.country = Country.findByName('India')
		return [eventRegistrationInstance: er]
		}
	else
		{
		flash.message = "Please sepecify name!!"
		redirect(action: "index")
		return
		}*/
    }

    def save() {
    	def eventRegistrationInstance
    	
    	if(params.'event.id')
    		{
    		eventRegistrationInstance = registrationService.saveForEvent(params)
    		//go for payment, if opted
    		if(params.onlinePayment && !eventRegistrationInstance?.hasErrors()) {
			params.orderid=eventRegistrationInstance.id
			try{
				params.amount = Assessment.get(params.'assessment.id')?.fees
			}
			catch(Exception e)
				{
				log.debug("Amount not found!!"+params)
				}
			if(params.amount>0)
				{
				def pgurl = registrationService.pgUrl(params)
				redirect(url:pgurl)
				}
    			}
    		}
    			
    	else
    		{
    		eventRegistrationInstance = registrationService.save(params)
		if (eventRegistrationInstance.hasErrors()) {
		    render(view: "create", model: [eventRegistrationInstance: eventRegistrationInstance])
		    return
		}
		}
	if (springSecurityService.isLoggedIn())
		redirect(action: "show", id: eventRegistrationInstance.id)
	else
		{
		flash.message = "Thank you for registering with us. We will get back to you shortly. Please quote registration code "+eventRegistrationInstance?.regCode+" (casesensitive) in all communications!"
		render(view: "message")
		}
    }

    def savelocal() {
	log.debug("Inside savelocal with params: "+params)
	String counselorid=""
	if(SpringSecurityUtils.ifAnyGranted('ROLE_RVTO_COUNSELOR'))
		{
		if(session.individualid)
			counselorid=""+session.individualid
		else
			counselorid=""+Individual.findByLoginid(springSecurityService.principal.username)?.id
		}
	log.debug("In savelocal: counselorid from login:"+counselorid)
	for(int i=1;i<11;i++) {
		if(params.("name"+i))
			registrationService.localRegister(params.("name"+i),params.("category"+i),params.("contact"+i),counselorid?:params.("counselorid"+i),params.("sevaid"+i))
	}
	flash.message = "Thank you for the registration."
	redirect(action: "listlocal")
    }

    def show() {
	def eventRegistrationInstance

	if(SpringSecurityUtils.ifAnyGranted('ROLE_EVENTPARTICIPANT'))
	{
		def loggedIndividual = Individual.findByLoginid(springSecurityService.principal.username)
		eventRegistrationInstance = EventRegistration.findByIndividual(loggedIndividual) 
	}	
	else if (params.id && SpringSecurityUtils.ifAnyGranted('ROLE_EVENTADMIN,ROLE_REGISTRATION_COORDINATOR,ROLE_ACCOMMODATION_COORDINATOR,ROLE_TRANSPORTATION_COORDINATOR,ROLE_PRASADAM_COORDINATOR,ROLE_VIP_COORDINATOR,ROLE_VOLUNTEER_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION,ROLE_VIP_TRANSPORTATION,ROLE_VIP_PRASADAM')){
		eventRegistrationInstance = EventRegistration.get(params.id)
	} else {
		eventRegistrationInstance = null
	}

	if (!eventRegistrationInstance) {
	    flash.message = "Registration not found!"
            render(view: "message")
	    return
        }

        [eventRegistrationInstance: eventRegistrationInstance]
    }


    def showFromGroup() {
    	def erg = EventRegistrationGroup.get(params.id)
    	if(erg?.mainEventRegistration)
    		redirect(action: "show",id:erg?.mainEventRegistration?.id)
    	else
    		redirect(action: "register")    		
    }

    def edit() {
        def eventRegistrationInstance = EventRegistration.get(params.id)
        if (!eventRegistrationInstance) {
            flash.message = "Registration not found"
            redirect(action: "list")
            return
        }

        [eventRegistrationInstance: eventRegistrationInstance]
    }

    def update() {
        log.debug("Inside er update: "+params)
        def eventRegistrationInstance = EventRegistration.get(params.id)
	int arrivalhr = Integer.parseInt(params.arrivalHr)
	int departurehr = Integer.parseInt(params.departureHr)
	if (params.arrivalAP == 'PM'){
		if(arrivalhr<12)
			arrivalhr = arrivalhr + 12
	} 
	if (params.arrivalAP == 'AM' && arrivalhr==12){
		arrivalhr = 0
	} 

	if (params.departureAP == 'PM'){
		if(departurehr<12)
			departurehr = departurehr + 12
	} 
	if (params.departureAP == 'AM' && departurehr==12){
		departurehr = 0
	} 



        if (!eventRegistrationInstance) {
            flash.message = "Registration not found"
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (eventRegistrationInstance.version > version) {
                eventRegistrationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'eventRegistration.label', default: 'EventRegistration')] as Object[],
                          "Another user has updated this EventRegistration while you were editing")
                render(view: "edit", model: [eventRegistrationInstance: eventRegistrationInstance])
                return
            }
        }
        
	def arrival,departure
	if (params.browser=="IE9"){
		println("Ok");
		arrival = params.arrivalDate
		arrival.set(minute: new Integer(params.arrivalMi), hourOfDay: arrivalhr)
		departure = params.departureDate
		departure.set(minute: new Integer(params.departureMi), hourOfDay: departurehr)
	}
	if(params.vipArrivalDate && params.browser=="NOTIE9") {
		params.arrivalDate = params.vipArrivalDate
	}
	if(params.vipDepartureDate && params.browser=="NOTIE9") {
		params.departureDate = params.vipDepartureDate
	}
	if(params.arrivalDate && params.browser=="NOTIE9") {
	        arrival = Date.parse('dd-MM-yyyy', params.arrivalDate)
	        arrival.set(minute: new Integer(params.arrivalMi), hourOfDay: arrivalhr)
	        params.arrivalDate = arrival
	}
	if(params.departureDate && params.browser=="NOTIE9") {
		departure = Date.parse('dd-MM-yyyy', params.departureDate)
		departure.set(minute: new Integer(params.departureMi), hourOfDay: departurehr)
		params.departureDate = departure
	}
	if(params.vipConnectedIskconCenter) {
		params.connectedIskconCenter = params.vipConnectedIskconCenter
	}

	if(params.vipContactNumber) {
		params.contactNumber = params.vipContactNumber
	}

	boolean oldAccoRequiredFlag = eventRegistrationInstance.isAccommodationRequired
	//guests can not increase the counts post verification
	if(SpringSecurityUtils.ifAnyGranted('ROLE_EVENTPARTICIPANT')) {
		if(!registrationService.verifyGuestCount(eventRegistrationInstance,params))
			{
				flash.message = "The guest count can not increase post verification!!"
				redirect(action: "show", id: eventRegistrationInstance.id)
				return
			}
        }

        eventRegistrationInstance.properties = params
	
	//guests cant change acco required flag
	if(SpringSecurityUtils.ifAnyGranted('ROLE_EVENTPARTICIPANT')) {
		eventRegistrationInstance.isAccommodationRequired = oldAccoRequiredFlag
	}

	if (!eventRegistrationInstance.pickUpRequired){
		 eventRegistrationInstance.arrivalTrainNumber = null
		 eventRegistrationInstance.arrivalTrainName = null
		 eventRegistrationInstance.arrivalBusNumber = null
		 eventRegistrationInstance.arrivalBusStation = null
		 eventRegistrationInstance.arrivalFlightNumber = null
		 eventRegistrationInstance.arrivalFlightCarrier = null
		 eventRegistrationInstance.arrivalTransportMode = null
	}

	if (eventRegistrationInstance.arrivalTransportMode == TransportMode.BUS){
		 eventRegistrationInstance.arrivalTrainNumber = null
		 eventRegistrationInstance.arrivalTrainName = null
		 eventRegistrationInstance.arrivalFlightNumber = null
		 eventRegistrationInstance.arrivalFlightCarrier = null
	}

	if (eventRegistrationInstance.arrivalTransportMode == TransportMode.TRAIN){
		 eventRegistrationInstance.arrivalBusNumber = null
		 eventRegistrationInstance.arrivalBusStation = null
		 eventRegistrationInstance.arrivalFlightNumber = null
		 eventRegistrationInstance.arrivalFlightCarrier = null
		 if (!eventRegistrationInstance.arrivalTrainPickUpPoint){
			eventRegistrationInstance.arrivalTrainPickUpPoint = RailwayStations.PUNE_STATION
		 }
	}

	if (eventRegistrationInstance.arrivalTransportMode == TransportMode.FLIGHT){
		 eventRegistrationInstance.arrivalBusNumber = null
		 eventRegistrationInstance.arrivalBusStation = null
		 eventRegistrationInstance.arrivalTrainNumber = null
		 eventRegistrationInstance.arrivalTrainName = null
		 if (!eventRegistrationInstance.arrivalFlightPickUpPoint){
			eventRegistrationInstance.arrivalFlightPickUpPoint = Airports.PUNE_AIRPORT
		 }
	}

	if (!eventRegistrationInstance.dropRequired){
		 eventRegistrationInstance.departureTrainNumber = null
		 eventRegistrationInstance.departureTrainName = null
		 eventRegistrationInstance.departureBusNumber = null
		 eventRegistrationInstance.departureBusStation = null
		 eventRegistrationInstance.departureFlightNumber = null
		 eventRegistrationInstance.departureFlightCarrier = null
		 eventRegistrationInstance.departureTransportMode = null
	}

	if (eventRegistrationInstance.departureTransportMode == TransportMode.BUS){
		 eventRegistrationInstance.departureTrainNumber = null
		 eventRegistrationInstance.departureTrainName = null
		 eventRegistrationInstance.departureFlightNumber = null
		 eventRegistrationInstance.departureFlightCarrier = null
	}

	if (eventRegistrationInstance.departureTransportMode == TransportMode.TRAIN){
		 eventRegistrationInstance.departureBusNumber = null
		 eventRegistrationInstance.departureBusStation = null
		 eventRegistrationInstance.departureFlightNumber = null
		 eventRegistrationInstance.departureFlightCarrier = null
		 if (!eventRegistrationInstance.departureTrainDropPoint){
			eventRegistrationInstance.departureTrainDropPoint = RailwayStations.PUNE_STATION
		 }
	}

	if (eventRegistrationInstance.departureTransportMode == TransportMode.FLIGHT){
		 eventRegistrationInstance.departureBusNumber = null
		 eventRegistrationInstance.departureBusStation = null
		 eventRegistrationInstance.departureTrainNumber = null
		 eventRegistrationInstance.departureTrainName = null
		 if (!eventRegistrationInstance.departureFlightDropPoint){
			eventRegistrationInstance.departureFlightDropPoint = Airports.PUNE_AIRPORT
		 }
	}

	if(eventRegistrationInstance.pickUpRequired)
		{
		eventRegistrationInstance.arrivalPoint = (eventRegistrationInstance.arrivalBusStation?:"")+(eventRegistrationInstance.arrivalTrainPickUpPoint?.displayName?:"")+(eventRegistrationInstance.arrivalFlightPickUpPoint?.displayName?:"")
		eventRegistrationInstance.arrivalNumber = (eventRegistrationInstance.arrivalBusNumber?:"")+(eventRegistrationInstance.arrivalTrainNumber?:"")+(eventRegistrationInstance.arrivalFlightNumber?:"")
		eventRegistrationInstance.arrivalName = (eventRegistrationInstance.arrivalTrainName?:"")+(eventRegistrationInstance.arrivalFlightCarrier?:"")
		}
	
	if(eventRegistrationInstance.dropRequired)
		{
		eventRegistrationInstance.departurePoint = (eventRegistrationInstance.departureBusStation?:"")+(eventRegistrationInstance.departureTrainDropPoint?.displayName?:"")+(eventRegistrationInstance.departureFlightDropPoint?.displayName?:"")
		eventRegistrationInstance.departureNumber = (eventRegistrationInstance.departureBusNumber?:"")+(eventRegistrationInstance.departureTrainNumber?:"")+(eventRegistrationInstance.departureFlightNumber?:"")
		eventRegistrationInstance.departureName = (eventRegistrationInstance.departureTrainName?:"")+(eventRegistrationInstance.departureFlightCarrier?:"")
		}

	
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else {
		params.updator=""
	}

	if(eventRegistrationInstance.isAccommodationRequired && eventRegistrationInstance.accommodationAllotmentStatus == null)
		eventRegistrationInstance.accommodationAllotmentStatus = AccommodationAllotmentStatus.NOT_ALLOTED

        if (!eventRegistrationInstance.save(flush: true)) {
            render(view: "edit", model: [eventRegistrationInstance: eventRegistrationInstance])
            return
        }

		flash.message = "Registration updated Successfully"
        redirect(action: "show", id: eventRegistrationInstance.id)
    }

    def delete() {
        def eventRegistrationInstance = EventRegistration.get(params.id)
        if (!eventRegistrationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'eventRegistration.label', default: 'EventRegistration'), params.id])
            redirect(action: "list")
            return
        }

        try {
            eventRegistrationInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'eventRegistration.label', default: 'EventRegistration'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'eventRegistration.label', default: 'EventRegistration'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def rejected() {
        def eventRegistrationInstance = EventRegistration.get(params.id)

	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else {
		params.updator=""
	}

        if (!eventRegistrationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'eventRegistration.label', default: 'EventRegistration'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (eventRegistrationInstance.version > version) {
                eventRegistrationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'eventRegistration.label', default: 'EventRegistration')] as Object[],
                          "Another user has updated this EventRegistration while you were editing")
                render(view: "show", model: [eventRegistrationInstance: eventRegistrationInstance])
                return
            }
        }

        eventRegistrationInstance.properties = params
	eventRegistrationInstance.verificationStatus = VerificationStatus.REJECTED
	eventRegistrationInstance.status = "DELETED"

        if (!eventRegistrationInstance.save(flush: true)) {
            render(view: "show", model: [eventRegistrationInstance: eventRegistrationInstance])
            return
        }

	flash.message = message(code: 'default.updated.message', args: [message(code: 'eventRegistration.label', default: 'EventRegistration'), eventRegistrationInstance.id])

        redirect(action: "show", id: eventRegistrationInstance.id)
    }

    def underVerification() {
        def eventRegistrationInstance = EventRegistration.get(params.id)

	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else {
		params.updator=""
	}

        if (!eventRegistrationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'eventRegistration.label', default: 'EventRegistration'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (eventRegistrationInstance.version > version) {
                eventRegistrationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'eventRegistration.label', default: 'EventRegistration')] as Object[],
                          "Another user has updated this EventRegistration while you were editing")
                render(view: "show", model: [eventRegistrationInstance: eventRegistrationInstance])
                return
            }
        }

        eventRegistrationInstance.properties = params
	eventRegistrationInstance.verificationStatus = VerificationStatus.UNDER_VERIFICATION
	

        if (!eventRegistrationInstance.save(flush: true)) {
            render(view: "show", model: [eventRegistrationInstance: eventRegistrationInstance])
            return
        }

	flash.message = message(code: 'default.updated.message', args: [message(code: 'eventRegistration.label', default: 'EventRegistration'), eventRegistrationInstance.id])

        redirect(action: "show", id: eventRegistrationInstance.id)
    }

    def rejectAcco() {
        def eventRegistrationInstance = EventRegistration.get(params.id)

	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else {
		params.updator=""
	}

        if (!eventRegistrationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'eventRegistration.label', default: 'EventRegistration'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (eventRegistrationInstance.version > version) {
                eventRegistrationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'eventRegistration.label', default: 'EventRegistration')] as Object[],
                          "Another user has updated this EventRegistration while you were editing")
                render(view: "show", model: [eventRegistrationInstance: eventRegistrationInstance])
                return
            }
        }

        eventRegistrationInstance.properties = params
	if(params.'_action_rejectAcco'=='AccommodationReset')
		eventRegistrationInstance.accommodationAllotmentStatus = AccommodationAllotmentStatus.NOT_ALLOTED
	else
		eventRegistrationInstance.accommodationAllotmentStatus = AccommodationAllotmentStatus.ALLOTEMENT_REJECTED
	

        if (!eventRegistrationInstance.save(flush: true)) {
            render(view: "show", model: [eventRegistrationInstance: eventRegistrationInstance])
            return
        }

	flash.message = message(code: 'default.updated.message', args: [message(code: 'eventRegistration.label', default: 'EventRegistration'), eventRegistrationInstance.id])

        redirect(action: "show", id: eventRegistrationInstance.id)
    }

    def verified() {

        def eventRegistrationInstance = registrationService.verified(params)
	if (!eventRegistrationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'eventRegistration.label', default: 'EventRegistration'), params.id])
            render(view: "list")
            return
        }
        if(eventRegistrationInstance.hasErrors()) {
            flash.message = "Errors!!"
            render(view: "show", model: [eventRegistrationInstance: eventRegistrationInstance])
            return
        }
        redirect(action: "show", id: eventRegistrationInstance.id)
    }

    def allotAccommodation() {
        
	print(params)
	
	def eventRegistrationInstance = EventRegistration.get(params.id)

	eventRegistrationInstance.accommodationAllotmentStatus = AccommodationAllotmentStatus.ALLOTEMENT_IN_PROGRESS
	
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else {
		params.updator=""
	}

        if (!eventRegistrationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'eventRegistration.label', default: 'EventRegistration'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (eventRegistrationInstance.version > version) {
                eventRegistrationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'eventRegistration.label', default: 'EventRegistration')] as Object[],
                          "Another user has updated this EventRegistration while you were editing")
                render(view: "show", model: [eventRegistrationInstance: eventRegistrationInstance])
                return
            }
        }

        eventRegistrationInstance.properties = params

        if (!eventRegistrationInstance.save(flush: true)) {
            render(view: "show", model: [eventRegistrationInstance: eventRegistrationInstance])
            return
        }
	print("Process render")
	redirect(controller: "AccommodationAllotment", action: "accommodationAllotment", params: [regId: eventRegistrationInstance.id])
    }

    
    // return JSON list of Registration

    def jq_eventRegistration_list() {
                //log.debug('start of jq_eventRegistration_list:'+params)

		def vipFlag = false
		if(SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION,ROLE_VIP_TRANSPORTATION,ROLE_VIP_PRASADAM'))
			vipFlag = true
		else 
			vipFlag = false

		def arrival = null, fromArrival = null
		if(params.arrivalDate) {
	        	arrival = Date.parse('dd-MM-yyyy HH:mm', params.arrivalDate)
			use(TimeCategory) {
			    fromArrival = arrival - 4.hour
				}
	        	}

		def sortIndex = params.sidx ?: 'name'
		def sortOrder  = params.sord ?: 'asc'

		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1

		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def eventRegistrations = EventRegistration.createCriteria().list(max:maxRows, offset:rowOffset) {

			if (params.verificationStatus!= "REJECTED") {
				isNull('status')
			}
			
			if (params.name)
				ilike('name','%'+params.name + '%')

			if (params.country)
				country {
					ilike('name','%'+params.country + '%')
				}

			if (params.contactNumber)
				ilike('contactNumber','%'+params.contactNumber + '%')

			if (params.regCode)
				ilike('regCode','%'+params.regCode + '%')

			if (params.creator)
				ilike('creator','%'+params.creator + '%')

			if (params.updator)
				ilike('updator','%'+params.updator + '%')

			if (arrival)
				between('arrivalDate',fromArrival,arrival)

			if (params.connectedIskconCenter)
				ilike('connectedIskconCenter','%'+params.connectedIskconCenter + '%')

			if (params.verificationStatus) {
				eq('verificationStatus',params.verificationStatus as VerificationStatus)
			}

			if (params.accommodationAllotmentStatus) {
				eq('accommodationAllotmentStatus',params.accommodationAllotmentStatus as AccommodationAllotmentStatus)
			}
	
			if(SpringSecurityUtils.ifNotGranted('ROLE_EVENTADMIN'))
				eq('isVipDevotee',vipFlag)

			if (params.pickUpRequired) {
				eq('pickUpRequired',Boolean.parseBoolean(params.pickUpRequired))
			}

			if (params.accommodationRequired) {
				eq('isAccommodationRequired',Boolean.parseBoolean(params.accommodationRequired))
			}

			if (params.dropRequired)
				eq('dropRequired',Boolean.parseBoolean(params.dropRequired))

			order(sortIndex, sortOrder)

		}

		def totalRows = eventRegistrations.totalCount
		def numberOfPages = Math.ceil(totalRows / maxRows)
		
		def arrivalCount = "",checkedInCount=""
		def erg,aa,places
		def ac=0,tc=0,pc=0,mc=0,cc=0,bc=0,rc=0,ns=0,defArr=0,ta=0

		def now = new Date()
		def ad
		
		def jsonCells = eventRegistrations?.collect {
		    erg = EventRegistrationGroup.findByMainEventRegistration(it)
		    if(erg)
			    arrivalCount = erg.total + "(G"+erg.numGroups+" P"+erg.numPrji+" M"+erg.numMataji+" C"+erg.numChildren+" B"+erg.numBrahmachari+")"
		    else
		    	arrivalCount=""

		    ac=0
		    tc=0
		    pc=0
		    mc=0
		    cc=0
		    bc=0
		    ta=0
		    places=""

		    aa = AccommodationAllotment.findAllByEventRegistration(it)
		    aa.each{
		    	places += it.eventAccommodation?.toString() + " "+it.numberAllotted+"(P"+it.numberofPrabhujisAllotted+" M"+it.numberofMatajisAllotted+" C"+it.numberofChildrenAllotted+" B"+it.numberofBrahmacharisAllotted+"),"
		    	ta += it.numberAllotted
		    	tc+=it.numberCheckedin
		    	pc+=it.numberofPrabhujisCheckedin
		    	mc+=it.numberofMatajisCheckedin
		    	cc+=it.numberofChildrenCheckedin
		    	bc+=it.numberofBrahmacharisCheckedin
		    }
		    
		    rc=it.numberofPrabhujis+it.numberofMatajis+it.numberofChildren+it.numberofBrahmacharis
		    ac=(erg?.total)?:0
		    
		    if(ac==0 && it.arrivalDate.hours==0 && it.arrivalDate.minutes==0 && it.arrivalDate.seconds==0)
		    	defArr=1
		    else
		    	defArr=0
		    
		    ad = it.arrivalDate
		    use(TimeCategory) {
			    //not yet arrived and has given the arrival date but not arrived even after 3 hours
			    if(ac==0 && defArr==0 && (now>= (ad + 3.hour)))
			    	ns=1
			    else
			    	ns=0
			}

		    if(tc>0)
		    	checkedInCount = tc+"(P"+pc+" M"+mc+" C"+cc+" B"+bc+")"
		    else
		    	checkedInCount = ""
		    	
		    [cell: [it.name,
			    it.connectedIskconCenter,
			    it.country.name,
			    it.contactNumber,
			    it.regCode,
			    it.creator,
			    it.dateCreated?.format('dd-MM-yy hh:mm a'),
			    it.arrivalDate?.format('dd-MM-yy hh:mm a'),
			    it.departureDate?.format('dd-MM-yy hh:mm a'),
			    rc + "(P"+it.numberofPrabhujis+" M"+it.numberofMatajis+" C"+it.numberofChildren+" B"+it.numberofBrahmacharis+")",
			    arrivalCount,
			    checkedInCount,
			    places,
			    it.updator,
			    it.lastUpdated?.format('dd-MM-yy hh:mm a'),
			    defArr,
			    ns,
			    rc,
			    ac,
			    tc,
			    ta
			], id: it.id]
		}
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
	        render jsonData as JSON

   }
    
	def jq_edit_eventRegistration = {
	      def eventRegistration = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add instruction sent
		  eventRegistration = new EventRegistration(params)
		  eventRegistration.creator = springSecurityService.principal.username
		  eventRegistration.updator = eventRegistration.creator
		  if (! eventRegistration.hasErrors() && eventRegistration.save()) {
		    message = "Event Registration ${eventRegistration.name} Successfull"
		    id = eventRegistration.id
		    state = "OK"
		  } else {
		    eventRegistration.errors.allErrors.each {
			println it
			}
		    message = "Could Not Save Event Registration"
		  }
		  break;
		case 'del':
		  // check eventRegistration exists
		  eventRegistration = EventRegistration.get(params.id)
		  if (eventRegistration) {
		    // delete eventRegistration
		    eventRegistration.delete()
		    message = "Event Registration  ${eventRegistration.name} Deleted"
		    state = "OK"
		  }
		  break;
		 default :
		  // edit action
		  // first retrieve the eventRegistration by its ID
		  eventRegistration = EventRegistration.get(params.id)
		  if (eventRegistration) {
		    // set the properties according to passed in parameters
		    eventRegistration.properties = params
			  eventRegistration.updator = springSecurityService.principal.username
		    if (! eventRegistration.hasErrors() && eventRegistration.save()) {
		      message = "Event Registration  ${eventRegistration.name} Updated"
		      id = eventRegistration.id
		      state = "OK"
		    } else {
			    eventRegistration.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Event Registration"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    // return JSON list of Registration

    def jq_eventRegistration_list_local() {
		def sortIndex = params.sidx ?: 'name'
		def sortOrder  = params.sord ?: 'asc'

		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1

		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def result = Person.createCriteria().list(max:maxRows, offset:rowOffset) {

			eq('status','RVTO_LOCAL_REG')
			
			if (params.name)
				ilike('name','%'+params.name + '%')

			if (params.category)
					ilike('category','%'+params.category + '%')

			if (params.phone)
				ilike('phone','%'+params.phone + '%')

			if(SpringSecurityUtils.ifAnyGranted('ROLE_RVTO_COUNSELOR'))
				eq('relation',Individual.get(session.individualid)?.legalName)
			else
			{
			if (params.relation)//counselor
				ilike('relation','%'+params.relation + '%')
			}

			if (params.reference)//service
				ilike('reference','%'+params.reference + '%')

			order(sortIndex, sortOrder)

		}

		def totalRows = result.totalCount
		def numberOfPages = Math.ceil(totalRows / maxRows)
		
		def jsonCells = result.collect {
		    [cell: [it.name,
			    it.category,
			    it.phone,
			    it.relation,
			    it.reference
			], id: it.id]
		}
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
	        render jsonData as JSON

   }

	def jq_eventRegistration_edit_local = {
	      log.debug('In jq_eventRegistration_edit_local:'+params)
	      def eventRegistration = null
	      def person = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add person sent
		  person = new Person()
		  person.name = params.name
		  person.category = params.category
		  person.status = "RVTO_LOCAL_REG"
		  person.phone = params.phone
		  person.relation = params.relation
		  person.reference = params.reference
		  person.updator=person.creator=springSecurityService.principal.username
		  if (! person.hasErrors() && person.save()) {
		    message = "Person Saved.."
		    id = person.id
		    state = "OK"
		  } else {
		    person.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save Local Registration"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check person exists
			  person  = Person.get(it)
			  if (person) {
			    // delete person
			    if(!person.delete())
			    	{
				    person.errors.allErrors.each {
					log.debug("In jq_eventRegistration_edit_local: error in deleting person:"+ it)
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
		  // first retrieve the person by its ID
		  person = Person.get(params.id)
		  if (person) {
		    // set the properties according to passed in parameters
		    person.properties = params
			  person.updator = springSecurityService.principal.username
		    if (! person.hasErrors() && person.save()) {
		      message = "Event Registration  ${person.name} Updated"
		      id = person.id
		      state = "OK"
		    } else {
			    person.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Event Registration"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

	def regCleanup() {
		registrationService.cleanRejected()
		redirect(action: "list")
	}

    def register() {
    	log.debug("Inside register: "+params.id)
    	def erGroup = registrationService.createEventRegistrationGroup(EventRegistration.get(params.id),springSecurityService.principal.username)
	return [erGroup:erGroup]
    }

    def jq_runtime_eventRegistration_summary_list() {
		log.debug("In jq_runtime_eventRegistration_summary_list: params: "+params)

		if(params.regcode)
			{
			//find the corresponding eventRegistration
			def er = EventRegistration.findByRegCode(params.regcode)
			if(er)
				{
				//now create the group just in time (in case it doesn't exists)
				registrationService.createEventRegistrationGroup(er,springSecurityService.principal.username)
				}
			}
			

		def sortIndex = params.sidx ?: 'id'
		def sortOrder  = params.sord ?: 'asc'
		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		def result = EventRegistrationGroup.createCriteria().list(max:maxRows, offset:rowOffset) {
			if (params.ergid)
				eq('id',params.long('ergid'))

			if (SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION,ROLE_VIP_TRANSPORTATION,ROLE_PRASADAM'))
				mainEventRegistration{eq('isVipDevotee',true)}
			else
				mainEventRegistration{eq('isVipDevotee',false)}

			if (params.glname)
				mainEventRegistration{ilike('name','%'+params.glname + '%')}

			if (params.phone)
				mainEventRegistration{ilike('contactNumber','%'+params.phone + '%')}

			if (params.centre)
				mainEventRegistration{ilike('connectedIskconCenter','%'+params.centre + '%')}

			if (params.regcode)
				mainEventRegistration{ilike('regCode','%'+params.regcode + '%')}


			order(sortIndex, sortOrder)

		}

		def totalRows = result.totalCount

		def numberOfPages = Math.ceil(totalRows / maxRows)
		
		def acco=""
		def jsonCells = result.collect{ergroup->
			acco=accommodationService.getAllotedAccommodation(ergroup.mainEventRegistration)
			[cell: [
			ergroup.mainEventRegistration.name,
			ergroup.mainEventRegistration.contactNumber,
			ergroup.mainEventRegistration.connectedIskconCenter,
			ergroup.mainEventRegistration.regCode,
			acco,
			ergroup.numGroups,
			ergroup.numPrji+"/"+ergroup.mainEventRegistration.numberofPrabhujis,
			ergroup.numMataji+"/"+ergroup.mainEventRegistration.numberofMatajis,
			ergroup.numChildren+"/"+ergroup.mainEventRegistration.numberofChildren,
			ergroup.numBrahmachari+"/"+ergroup.mainEventRegistration.numberofBrahmacharis,
			ergroup.total+"/"+(ergroup.mainEventRegistration.numberofPrabhujis+ergroup.mainEventRegistration.numberofMatajis+ergroup.mainEventRegistration.numberofChildren+ergroup.mainEventRegistration.numberofBrahmacharis)
			], id: ergroup.id]
				}
		
		//get the overall summary
		def totalP='',totalM='',totalC='',totalB='',grandTotal=''
		def summary = EventRegistrationGroup.createCriteria().list {
						if(SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION'))
							mainEventRegistration{eq('isVipDevotee',true)}
						else if(SpringSecurityUtils.ifAnyGranted('ROLE_REGISTRATION_COORDINATOR,ROLE_ACCOMMODATION_COORDINATOR'))
							mainEventRegistration{eq('isVipDevotee',false)}
						projections {
							sum('numPrji')
							sum('numMataji')
							sum('numChildren')
							sum('numBrahmachari')
							sum('total')
						}
					}
		totalP=summary[0][0]?:0
		totalM=summary[0][1]?:0
		totalC=summary[0][2]?:0
		totalB=summary[0][3]?:0
		grandTotal=summary[0][4]?:0
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages,userdata:[numGroups:'GrandTotal',numPrji:totalP,numMataji:totalM,numChildren:totalC,numBrahmachari:totalB,total:grandTotal]]
	        render jsonData as JSON
   }

    def jq_runtime_eventRegistration_list() {
		def sortIndex = params.sidx ?: 'id'
		def sortOrder  = params.sord ?: 'asc'
		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1

		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def erg = EventRegistrationGroup.get(params.ergid)

		def totalRows = erg?.subEventRegistrations?.size()?:0
		def numberOfPages = Math.ceil(totalRows / maxRows)
		
		def acco=""
		def jsonCells = erg?.subEventRegistrations?.collect {
		    acco = accommodationService.getCheckedInAccommodation(it)
		    [cell: [it.name,
			    it.contactNumber,
			    '',
			    '',
			    acco,
			    '',
			    it.numberofPrabhujis,
			    it.numberofMatajis,
			    it.numberofChildren,
			    it.numberofBrahmacharis,
			    it.numberofPrabhujis+it.numberofMatajis+it.numberofChildren+it.numberofBrahmacharis
			], id: it.id]
		}
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
	        render jsonData as JSON

   }

	def jq_runtime_eventRegistration_edit = {
	      log.debug("In jq_runtime_eventRegistration_edit:"+params)
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  id=registrationService.runtimeAdd(params)
		  if(id<0) {
		      message = "Subgroup count exceeds registration count!!"
		      state = "FAIL"
		  }
		  else if(id>0) {
		      message = "Subgroup created with id:"+id
		      state = "OK"
		  }
		  else {
		      message = "Subgroup creation failed."
		      state = "FAIL"
		  }
		  break;
		case 'del':
		  // delete action
		  id=registrationService.runtimeDelete(params)
		  if(id>0) {
		      message = "Subgroup(s) deleted"
		      state = "OK"
		  }
		  else {
		      message = "Subgroup(s) deletion failed."
		      state = "FAIL"
		  }
 		  break;
		 default :
		  // edit action
		  id=registrationService.runtimeEdit(params)
		  if(id<0) {
		      message = "Subgroup count exceeds registration count!!"
		      state = "FAIL"
		  }		  
		  else if(id>0) {
		      message = "Subgroup updated with id:"+id
		      state = "OK"
		  }
		  else {
		      message = "Subgroup  ${eventRegistration.name} Updation failed."
		      state = "FAIL"
		  }
  		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }
	
	def paid() {
		log.debug("inside paid with params "+params)

		def oid = params.Order_Id?.substring(16,params.Order_Id?.size())
		def er = null
		try{
			er = EventRegistration.get(oid)
		}
		catch(Exception e){}
		def str = "M_nvccpune_12868|"+params.Order_Id+"|"+params.Amount+"|"+params.AuthDesc+"|1hhdrt38f6i1yi4k14"
		def isValid = helperService.verifyChecksum(str,params.Checksum)
		def message = "Thank you for registering with us. We will get back to you shortly. Please quote registration code "+er?.regCode+" (casesensitive) in all communications!"
		def txnMessage=""

			if(isValid && params.AuthDesc.equals("Y"))
			{
				//render "<div align='center' style='background-image:url(../images/back.jpg);'><a href='http://iskconpune.in'><img src='../images/iskconpune-header.jpg' alt='ISKCON PUNE' border='0' /></a><br>Thank you for the booking. Your card has been charged and your transaction is successful. <br>Transaction Number: "+params.Order_Id+"</b></div>"
				
				txnMessage = "Thank you for the payment. The transaction is successful. Transaction Number: "+params.Order_Id

				//Here you need to put in the routines for a successful 
				//transaction such as sending an email to customer,
				//setting database status, informing logistics etc etc
				
				//update ER with the payment reference
				registrationService.updatePayment(er,"ONLINE",params.Amount,params.Order_Id+"_"+(params.nb_order_no?:''))
			}
			else if(isValid && params.AuthDesc.equals("B"))
			{
				//render "<div align='center' style='background-image:url(../images/back.jpg);'><a href='http://iskconpune.in'><img src='../images/iskconpune-header.jpg' alt='ISKCON PUNE' border='0' /></a><br>Thank you for shopping with us.We will keep you posted regarding the status of your order through e-mail</div>"
				txnMessage = "Thank you for payment.We will keep you posted regarding the status of your order through e-mail"

				//Here you need to put in the routines/e-mail for a  "Batch Processing" order
				//This is only if payment for this transaction has been made by an American Express Card
				//since American Express authorisation status is available only after 5-6 hours by mail from ccavenue and at the "View Pending Orders"
			}
			else if(isValid && params.AuthDesc.equals("N"))
			{

				//render "<div align='center' style='background-image:url(../images/back.jpg);'><a href='http://iskconpune.in'><img src='../images/iskconpune-header.jpg' alt='ISKCON PUNE' border='0' /></a><br>Thank you for trying the booking.However,the transaction has been declined.Please try again!</div>"
				txnMessage = "Thank you for trying the payment.However,the transaction has been declined.Please try again!"

				//Here you need to put in the routines for a failed
				//transaction such as sending an email to customer
				//setting database status etc etc
			}
			else
			{
				//render "<div align='center' style='background-image:url(../images/back.jpg);'><a href='http://iskconpune.in'><img src='../images/iskconpune-header.jpg' alt='ISKCON PUNE' border='0' /></a><br>Security Error. Illegal access detected</div>"
				txnMessage = "Security Error. Illegal access detected"

				//Here you need to simply ignore this and dont need
				//to perform any operation in this condition
			}
		
		flash.message = message +" " + txnMessage
		render(view: "message")

		}

	def pay() {
		def pgurl = registrationService.pgUrl(params)

		redirect(url:pgurl)

	}

}