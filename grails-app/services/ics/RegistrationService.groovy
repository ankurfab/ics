package ics
import com.krishna.*
import grails.util.Environment

class RegistrationService {

    def springSecurityService
    def housekeepingService
    def helperService
    def assessmentService

    def serviceMethod() {

    }

    def verify(String regCode) {
    	def ep = EventParticipant.findByRegCode(regCode)
    	if(ep)
    		{
    		println "Verified regcode for ep: "+ep
    		return ep
    		}
    	else
    		return null
    }
    
    def genRegCode() {
    	def regCode
    	def flag = true
    	while(flag)
    		{
    		regCode = org.apache.commons.lang.RandomStringUtils.randomAlphanumeric(6)
    		//check if its unique
    		def er = EventRegistration.findByRegCode(regCode)
    		if(!er)
    			flag=false
    		}
    	return regCode
    }


    def saveForEvent(Map params) {
	log.debug("save: "+params)
	
	//male/female issue
	switch(params.gender) {
		case 'female':
			params.isMale=false
			break
		default:
			params.isMale=true
			break
	}
	
	//first check for duplicates
	def existingERs = EventRegistration.findAllWhere(name:params.name,contactNumber:params.contactNumber,email:params.email)
	if(existingERs?.size()>0)
		{
		log.debug(existingERs+" already exists!")
		return null
		}
	
	if(params.dob)
		params.dob = Date.parse('dd-MM-yyyy', params.dob)
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else {
		params.creator="anonymous"
	}
	params.updator=params.creator
	
	if(!params.'assessment.id')	
		{
		params.'assessment.id'=14	//@TODO: hardocoded
		log.debug("Error saveentry: no assessmentid")
		}
	def eventRegistrationInstance = new EventRegistration(params)
	//eventRegistrationInstance.event = Event.get(params.eid)
	eventRegistrationInstance.arrivalDate=eventRegistrationInstance.departureDate=new Date()
	eventRegistrationInstance.verificationStatus = VerificationStatus.UNVERIFIED
	// Generate and assign registration code 
	eventRegistrationInstance.regCode = genRegCode()

	if (!eventRegistrationInstance.save()) {
            eventRegistrationInstance.errors.allErrors.each {
			log.debug("Error in saveForEvent eventRegistrationInstance:"+  it)
		    }
        }
        else
        	{
        	//now setup  the candidate
	        	assessmentService.setupUV(eventRegistrationInstance,params.packetcode)
        	}
        return eventRegistrationInstance
    }
    
    def save(Map params) {
	log.debug("save: "+params)
	def success = true
	def arrival,departure
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
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else {
		params.creator="anonymous"
	}
	params.updator=params.creator

	
	def eventRegistrationInstance = new EventRegistration(params)

	if(params.eid)
		eventRegistrationInstance.event = Event.get(params.eid)
	def individual
	if(params.indid)
		{
		individual = Individual.get(params.indid)
		eventRegistrationInstance.name = individual?.toString()
		eventRegistrationInstance.contactNumber = VoiceContact.findByCategoryAndIndividual('CellPhone',individual)?.number
		eventRegistrationInstance.individual = individual
		if(!eventRegistrationInstance.regCode)
			eventRegistrationInstance.regCode = genRegCode()
		}

	eventRegistrationInstance.arrivalDate = arrival
	eventRegistrationInstance.departureDate = departure

	if(params.vipConnectedIskconCenter) {
		eventRegistrationInstance.connectedIskconCenter = params.vipConnectedIskconCenter
	}

	if(params.vipContactNumber) {
		eventRegistrationInstance.contactNumber = params.vipContactNumber
	}

	if (!eventRegistrationInstance.pickUpRequired){
		 eventRegistrationInstance.arrivalTrainNumber = null
		 eventRegistrationInstance.arrivalTrainName = null
		 eventRegistrationInstance.arrivalBusNumber = null
		 eventRegistrationInstance.arrivalBusStation = null
		 eventRegistrationInstance.arrivalFlightNumber = null
		 eventRegistrationInstance.arrivalFlightCarrier = null
		 eventRegistrationInstance.arrivalTransportMode = null
	} else if (!eventRegistrationInstance.arrivalTransportMode){
		eventRegistrationInstance.arrivalTransportMode = TransportMode.BUS
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
	} else if (!eventRegistrationInstance.departureTransportMode){
		eventRegistrationInstance.departureTransportMode = TransportMode.BUS
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

	if (!eventRegistrationInstance?.isVolunteersAvailable){
		 eventRegistrationInstance.numBrahmacharisVolunteer = 0 
		 eventRegistrationInstance.numPrjiVolunteer = 0
		 eventRegistrationInstance.numMatajiVolunteer = 0
	}
	
	if(eventRegistrationInstance?.pickUpRequired)
		{
		eventRegistrationInstance.arrivalPoint = (eventRegistrationInstance.arrivalBusStation?:"")+(eventRegistrationInstance.arrivalTrainPickUpPoint?.displayName?:"")+(eventRegistrationInstance.arrivalFlightPickUpPoint?.displayName?:"")
		eventRegistrationInstance.arrivalNumber = (eventRegistrationInstance.arrivalBusNumber?:"")+(eventRegistrationInstance.arrivalTrainNumber?:"")+(eventRegistrationInstance.arrivalFlightNumber?:"")
		eventRegistrationInstance.arrivalName = (eventRegistrationInstance.arrivalTrainName?:"")+(eventRegistrationInstance.arrivalFlightCarrier?:"")
		}
	
	if(eventRegistrationInstance?.dropRequired)
		{
		eventRegistrationInstance.departurePoint = (eventRegistrationInstance.departureBusStation?:"")+(eventRegistrationInstance.departureTrainDropPoint?.displayName?:"")+(eventRegistrationInstance.departureFlightDropPoint?.displayName?:"")
		eventRegistrationInstance.departureNumber = (eventRegistrationInstance.departureBusNumber?:"")+(eventRegistrationInstance.departureTrainNumber?:"")+(eventRegistrationInstance.departureFlightNumber?:"")
		eventRegistrationInstance.departureName = (eventRegistrationInstance.departureTrainName?:"")+(eventRegistrationInstance.departureFlightCarrier?:"")
		}
	
	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION'))
		eventRegistrationInstance.isVipDevotee = true
	else 
		eventRegistrationInstance.isVipDevotee = false
	

	if(!params.indid)
		eventRegistrationInstance.verificationStatus = VerificationStatus.UNVERIFIED
	else
		eventRegistrationInstance.verificationStatus = VerificationStatus.VERIFIED

	if(eventRegistrationInstance.isAccommodationRequired)
		eventRegistrationInstance.accommodationAllotmentStatus = AccommodationAllotmentStatus.NOT_ALLOTED
	
	if (!eventRegistrationInstance.save()) {
            eventRegistrationInstance.errors.allErrors.each {
			log.debug("Error in saving eventRegistrationInstance:"+  it)
		    }
	    success = false
        }
	    if(success && !params.indid)
	    	{
		try {
			sendRegComms(eventRegistrationInstance)
		}
		catch(Exception e)
			{
			log.debug("Some exception in sendRegComms "+e)
			}
		}

            return eventRegistrationInstance
    }
    
    def sendRegComms(EventRegistration eventRegistrationInstance) {
	if(!eventRegistrationInstance.isVipDevotee && eventRegistrationInstance.email)
		housekeepingService.sendEventRegistrationEmail(eventRegistrationInstance.email, 
						       "Your registration for NVCC,Pune Opening Ceremony is successful", 
						       eventRegistrationInstance);

	if(!eventRegistrationInstance.isVipDevotee && eventRegistrationInstance.contactNumber)
		housekeepingService.sendSMS(eventRegistrationInstance.contactNumber,
			//"Hare Krishna! Your registration for "+eventRegistrationInstance.event+" event is successful. We will get to back to you soon. ISKCON NVCC.")
			"Hare Krishna! Your registration for NVCC Inauguration Festival event is successful. We will get to back to you soon. ISKCON NVCC.")

	
	def icsRole1 = IcsRole.findByAuthority("ROLE_EVENTADMIN");
	def icsRole3 = IcsRole.findByAuthority("ROLE_REGISTRATION_COORDINATOR"); 
	def icsRoleVIPA = IcsRole.findByAuthority("ROLE_VIP_ACCOMMODATION"); 
	def icsRoleVIPP = IcsRole.findByAuthority("ROLE_VIP_PRASADAM"); 
	def icsRoleVIPT = IcsRole.findByAuthority("ROLE_VIP_TRANSPORTATION"); 

	def roles
	if(eventRegistrationInstance.isVipDevotee)
		roles = [icsRole1, icsRoleVIPA, icsRoleVIPP, icsRoleVIPT]
	else
		roles = [icsRole1, icsRole3]

	log.debug(roles)
	
	roles.each { role -> 
		log.debug("sendComms for Role:"+role)
		def icsUserIcsRoles = []
		if(role)
			icsUserIcsRoles = IcsUserIcsRole.findAllByIcsRole(role);
		icsUserIcsRoles.each {iuir ->
			def individual = Individual.findByLoginidAndCommunicationsPreferenceIsNull(iuir.icsUser.username)
			if (individual?.emailContact?.size()>0){
				def adrList = []
				individual.emailContact.each{
					if(it.emailAddress?.size()>0)
						adrList.add(it.emailAddress)
				}
				//log.debug("adrList:"+adrList)
				def adrSet = adrList as Set
				//log.debug("adrSet:"+adrSet)
				//todo ..the set is not proper
				housekeepingService.sendEventRegistrationNotificationEmail(adrSet?.toList()?:[], 
									                   "New registration notification", 
											   eventRegistrationInstance)
			}
			//disabling for now because of higher SMS cost
			/*if (individual?.voiceContact?.size()>0){
				def nos = ''
				individual.voiceContact.each{
					nos+=it.number+","
				}
				housekeepingService.sendSMS(nos, 
							    "PAMHO! A group of devotees has registered on NVCC website. Please verify. Thank you! YS, NVCC Web Team.")				
			}*/
		}
	}
    }


    def verified(Map params) {
	log.debug("verified: "+params)

        def eventRegistrationInstance = EventRegistration.get(params.id)

	def msg =""
	String password = ""
	String loginId = ""
	String rc = ""

	if (!eventRegistrationInstance) {
            return null
        }

	if (params.version) {
            def version = params.version.toLong()
            if (eventRegistrationInstance.version > version) {
                eventRegistrationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          ['EventRegistration'] as Object[],
                          "Another user has updated this EventRegistration while you were editing")
                return eventRegistrationInstance
            }
        }

	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else {
		params.updator=""
	}
	
	// Set Status to verified 
	//first check if already verified
	if(eventRegistrationInstance.verificationStatus==VerificationStatus.VERIFIED)
		return eventRegistrationInstance
		
	eventRegistrationInstance.verificationStatus = VerificationStatus.VERIFIED
	eventRegistrationInstance.updator = params.updator

	// Generate and assign registration code 
	rc = eventRegistrationInstance.regCode = genRegCode()
	
	if(eventRegistrationInstance.isVipDevotee && eventRegistrationInstance.email)
		{
		housekeepingService.sendVIPEventRegistrationConfirmationEmail(eventRegistrationInstance.email, 
										   "You are Registered on our database for New Temple Opening Ceremony at Pune.");
		return eventRegistrationInstance
		}

	// create event participant 
	def ep = new EventParticipant()
	ep.event = eventRegistrationInstance.event
	ep.regCode = eventRegistrationInstance.regCode
	ep.invited = true
	ep.attended = false 
	ep.confirmed = true
	ep.flgAddressPrinted = false 
	ep.role = "EVENT_PARTICIPANT"
	ep.comments = ""
	ep.creator = params.updator
	ep.updator = params.updator

	// create individual 
	def individualInstance = new Individual()
	individualInstance.legalName = eventRegistrationInstance.name
	individualInstance.category = "RVTOGuest"
	individualInstance.loginid = housekeepingService.genloginFromName(eventRegistrationInstance.name)
	individualInstance.status = null
	individualInstance.creator = params.updator
	individualInstance.updator = params.updator

	def cellPhoneContact = new VoiceContact()
	cellPhoneContact.number = eventRegistrationInstance.contactNumber
	cellPhoneContact.category = "CellPhone"

	cellPhoneContact.creator = springSecurityService.principal.username
	cellPhoneContact.updator = springSecurityService.principal.username
	


	if (individualInstance.save()) {

		cellPhoneContact.individual = individualInstance
		ep.individual = individualInstance
		eventRegistrationInstance.individual = individualInstance
		//TODO: save voicecontact and other contacts only if the data was supplied
		if (!cellPhoneContact.save()) {
		     cellPhoneContact.errors.allErrors.each {
			 println it
		     }
		     throw new Exception("Contact is not Valid") 
		}
		
			
		if (!ep.save()) {
		    ep.errors.allErrors.each {
			println it
		    }
		     throw new Exception("EventParticipant is not Valid") 		
		}
		
	} else {
	    individualInstance.errors.allErrors.each {
		println it
	    }
		     throw new Exception("Individual is not Valid") 		
        }

	

	password = org.apache.commons.lang.RandomStringUtils.randomAlphabetic(4)
	password = password.toUpperCase()
	loginId = individualInstance.loginid
	
	// create iscUser with email as loginID
	def icsUser = new IcsUser()
	icsUser.username = loginId
	icsUser.password = password
	icsUser.enabled = true
	icsUser.accountExpired = false
	icsUser.accountLocked = false
	icsUser.passwordExpired = false


	if (!icsUser.save()) {
	    icsUser.errors.allErrors.each {
		println it
	    }
		     throw new Exception("IcsUser is not Valid") 		
        }
	
	//Assign Event Participant Role to user
	def role = IcsRole.findByAuthority('ROLE_EVENTPARTICIPANT')
	if(!IcsUserIcsRole.create(icsUser, role))
		throw new Exception("Cant assign role") 

	eventRegistrationInstance.properties = params

        if (!eventRegistrationInstance.save()) {
            eventRegistrationInstance.errors.allErrors.each {
			log.debug("In verified: Error in saving eventRegistrationInstance:"+  it)
		    }
		throw new Exception("Cant update EventRegistration") 
        }

        //Send Email to user 
	
	if(eventRegistrationInstance.email)
		housekeepingService.sendEventRegistrationConfirmationEmail(eventRegistrationInstance.email, 
								   "Your registration for #${eventRegistrationInstance.event} event is confirmed", 
								   loginId,password,rc);

	if(eventRegistrationInstance.contactNumber)
		housekeepingService.sendSMS(eventRegistrationInstance.contactNumber, 
				    //"Hare Krishna! Your registration for #${eventRegistrationInstance.event} event is confirmed. Your login credentials are forwarded to email you mentioned at the time of registration. Thank you! ! NVCC Web Team.")				 
				    "Dear Guest, Your registration is confirmed. Reg code:"+eventRegistrationInstance.regCode+"; LoginId:"+loginId+"; PWD:"+password+". ISKCON NVCC.")

	return eventRegistrationInstance


    }

    def initializeChart(String name) {
    	println "Inside initializeChart..."
    	def chart = Chart.findByName(name) //"RVTO_REG"
    	if(chart)
    		{
    		//reset the existing chart
    		if(!chart.delete(flush:true))
		     chart.errors.allErrors.each {
				 println chart.name+"chart error"+it
			    }
    		}
    	//now create chart
	println "creating chart.."
	chart = new Chart()
	chart.name = name
	chart.creator=chart.updator="system"
	if(!chart.save(flush:true))
	     chart.errors.allErrors.each {
			 println chart.name+"chart error"+it
		    }
    	println "Chart created: "+chart
    	
    	//now fill the chart(with 0 values)
    	def event = Event.findByTitle("RVTO") //TODO Hardcoding
    	insertChart(chart, false, event.startDate.clone(), event.endDate.clone(), 0, 0, 0, 0, 0)
    	
    	//now populate the chart(with registered guests)
    	populateChart(chart)
    	
    	return chart
    }
    
    def insertChart(Chart chart, boolean update, Date fromDate,Date toDate,int ia0,int ia1,int ia2,int ia3, int ia4)
    	{
    	println "Inside insertChart: "+fromDate+" : "+toDate
    	int fromHour = fromDate.getAt(Calendar.HOUR_OF_DAY)
    	int toHour = toDate.getAt(Calendar.HOUR_OF_DAY)
    	int toMin = toDate.getAt(Calendar.MINUTE)
    	def endDate
    	if(toHour==0 && toMin==0)
    		{
    		endDate = toDate-1 //booking till midnight of previous day
    		toHour = 23
    		toMin = 59
    		}
    	else
    		endDate = toDate
    	
    	fromDate.clearTime()
    	toDate.clearTime()
    	def flag=true
    	int i=0
    	int start = fromHour
    	int end = 24
    	if(endDate.compareTo(fromDate)==0)
    		end=(toHour+1)
    	def ci
    	def nextDay = fromDate 
    	println "dates in insertChart: "+fromHour+" "+toHour+" "+toMin+" "+endDate+" "+fromDate+" "+toDate+" "+nextDay
    	while(nextDay.compareTo(endDate)<=0) {
		for(i=start;i<end;i++)
			{
			if (i>24)
				{
				println "ERROR"
				break
				}
			if(update)
				ci = ChartItem.findWhere(chart: chart, date: nextDay, slot: i)
			else
				{
				ci = new ChartItem()
				ci.ia0 = 0
				ci.ia1 = 0
				ci.ia2 = 0
				ci.ia3 = 0
				ci.ia4 = 0
				}
				
			ci.chart = chart
			ci.date = nextDay
			ci.slot = i
			ci.ia0 += ia0
			ci.ia1 += ia1
			ci.ia2 += ia2
			ci.ia3 += ia3
			ci.ia4 += ia4
			ci.creator=ci.updator="system"
			if(!ci.save())
			     ci.errors.allErrors.each {
					 println it
				    }
			}
		nextDay = nextDay+1
		start=0
		if(endDate.compareTo(nextDay)==0)
			end=(toHour+1)
		else
			end=24
		
    	}
    	}
    	
    def populateChart(Chart chart) {
    	def event = Event.findByTitle("RVTO") //TODO Hardcoding
    	def regList = EventRegistration.findAllByVerificationStatusAndIsVipDevotee(VerificationStatus.VERIFIED,false)
    	def sd,ed
    	
    	regList.each{reg->
    		sd = reg?.arrivalDate?.clone()
    		if(sd<event.startDate)
    			sd = event.startDate.clone()
    		ed = reg?.departureDate?.clone()
    		if(ed>event.endDate)
    			ed = event.endDate?.clone()
    		insertChart(chart,true,sd,ed,(reg?.numberofPrabhujis+reg?.numberofMatajis+reg?.numberofChildren+reg?.numberofBrahmacharis),reg?.numberofPrabhujis,reg?.numberofMatajis,reg?.numberofChildren,reg?.numberofBrahmacharis)
    		}
    	}

    def localRegister(String name,String category,String contact,String counselorid,String sevaid) {
    	log.debug("Inside localRegister...")
    	if(!counselorid)
    		{
    		log.debug("In localRegister: Null counselorid received")
    		return false
    		}
    	def person = new Person()
    	person.name = name
    	person.category = category
    	person.status = "RVTO_LOCAL_REG"
    	person.phone = contact
    	try{
    		person.relation = Individual.get(new Long(counselorid))?.legalName
    	}
    	catch(Exception e){log.debug(e)}
    	try{
    		person.reference = Seva.get(new Long(sevaid))?.name
    	}
    	catch(Exception e){log.debug(e)}
    	person.updator=person.creator=springSecurityService.principal.username
    	if(!person.save(flush:true))
    		{
    		person.errors.allErrors.each{log.debug(it)}
    		return false
    		}
    	return true
    }
    
    def cleanRejected() {
    	log.debug("In cleanRejected")
    	boolean vipFlag = false
    	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION'))
    		vipFlag = true
    	
    	def erList = EventRegistration.findAllWhere(verificationStatus: VerificationStatus.REJECTED, status: null, isVipDevotee:vipFlag)
    	
    	erList.each{
    		it.status = "DELETED"
    		it.updator = springSecurityService.principal.username
    		if(!it.save())
    			it.errors.allErrors.each{log.debug(it)}
    	}
    }
    
    def verifyGuestCount(EventRegistration eventRegistrationInstance,Map params) {
    	def retVal = true
    	if(eventRegistrationInstance.verificationStatus==VerificationStatus.VERIFIED)
    		{
		log.debug("verifyGuestCount inside if..")
		if(params.numberofPrabhujis && (params.int('numberofPrabhujis')>eventRegistrationInstance.numberofPrabhujis))
			{
			//eventRegistrationInstance.errors.rejectValue("numberofPrabhujis","numberofPrabhujis.exceeded", "Number of Prabhujis can not be increased after verification is completed.!!")
			retVal = false
			}
		if(params.numberofMatajis && (params.int('numberofMatajis')>eventRegistrationInstance.numberofMatajis))
			{
			//eventRegistrationInstance.errors.rejectValue("numberofMatajis","numberofMatajis.exceeded", "Number of Matajis can not be increased after verification is completed.!!")
			retVal = false
			}
		if(params.numberofChildren && (params.int('numberofChildren')>eventRegistrationInstance.numberofChildren))
			{
			//eventRegistrationInstance.errors.rejectValue("numberofChildren","numberofChildren.exceeded", "Number of Children can not be increased after verification is completed.!!")
			retVal = false
			}
		if(params.numberofBrahmacharis && (params.int('numberofBrahmacharis')>eventRegistrationInstance.numberofBrahmacharis))
			{
			//eventRegistrationInstance.errors.rejectValue("numberofBrahmacharis","numberofBrahmacharis.exceeded", "Number of Brahmacharis can not be increased after verification is completed.!!")
			retVal = false
			}
    		}
    	log.debug("In verifyGuestCount:"+retVal)
    	return retVal    		
    }
    
    def runtimeAdd(Map params) {
	  log.debug("In runtimeAdd:"+params)
	      def erg = EventRegistrationGroup.get(params.ergid)
	      def event = Event.findByTitle('RVTO')
	      def eventRegistration = null
		  
		    //verify the counts before adding (only if acco was required)
		if(params.override!='true' && erg.mainEventRegistration.isAccommodationRequired)
			{
			if((erg.numPrji+params.int('numberofPrabhujis'))>erg.mainEventRegistration.numberofPrabhujis)
				return -1
			if((erg.numMataji+params.int('numberofMatajis'))>erg.mainEventRegistration.numberofMatajis)
				return -1
			if((erg.numChildren+params.int('numberofChildren'))>erg.mainEventRegistration.numberofChildren)
				return -1
			if((erg.numBrahmachari+params.int('numberofBrahmacharis'))>erg.mainEventRegistration.numberofBrahmacharis)
				return -1
			}

		  eventRegistration = new EventRegistration()
		  eventRegistration.name = params.subglname
		  eventRegistration.contactNumber = params.phone
		  eventRegistration.numberofPrabhujis = params.int('numberofPrabhujis')
		  eventRegistration.numberofMatajis = params.int('numberofMatajis')
		  eventRegistration.numberofChildren = params.int('numberofChildren')
		  eventRegistration.numberofBrahmacharis = params.int('numberofBrahmacharis')
		  eventRegistration.status='RUNTIME'
		  eventRegistration.event = event
		  eventRegistration.arrivalDate = new Date()
		  eventRegistration.departureDate = new Date()
		  eventRegistration.verificationStatus = VerificationStatus.VERIFIED
		  eventRegistration.updator=eventRegistration.creator=springSecurityService.principal.username

		    
		  log.debug("saving runtime subgroup..."+eventRegistration)
		  if (! eventRegistration.hasErrors() && eventRegistration.save()) {
			    if(!erg.subEventRegistrations)
			    	erg.subEventRegistrations=[]
			    erg.subEventRegistrations.add(eventRegistration)
			    erg.numGroups++
			    def total = eventRegistration.numberofPrabhujis+eventRegistration.numberofMatajis+eventRegistration.numberofChildren+eventRegistration.numberofBrahmacharis
			    erg.total+=total
			    erg.numPrji += eventRegistration.numberofPrabhujis
			    erg.numMataji += eventRegistration.numberofMatajis
			    erg.numChildren += eventRegistration.numberofChildren
			    erg.numBrahmachari += eventRegistration.numberofBrahmacharis
			    erg.updator=springSecurityService.principal.username
			    if(!erg.save())
			    	{
				    erg.errors.allErrors.each {
					log.debug("In jq_runtime_eventRegistration_edit: error in updating erg (while adding new group):"+ erg)
					}
					return 0
			    	}
			    return eventRegistration.id
		  } else {
		    eventRegistration.errors.allErrors.each {
			log.debug(it)
			}
		    return 0
		  }
    }
    
    def runtimeEdit(Map params) {
	  log.debug("In runtimeEdit:"+params)
	      def erg = EventRegistrationGroup.get(params.ergid)
	  def eventRegistration
	  // first retrieve the eventRegistration by its ID
	  eventRegistration = EventRegistration.get(params.id)
	  if (eventRegistration) {
	    //check the increase (-ve would mean decrease)
		  int incPrabhujis = params.int('numberofPrabhujis')-eventRegistration.numberofPrabhujis
		  int incMatajis = params.int('numberofMatajis')-eventRegistration.numberofMatajis
		  int incChildren = params.int('numberofChildren')-eventRegistration.numberofChildren
		  int incBrahmacharis = params.int('numberofBrahmacharis')-eventRegistration.numberofBrahmacharis
		    
		    //verify the counts before adding (only if acco was required)
		if(params.override!='true' && erg.mainEventRegistration.isAccommodationRequired)
			{
			if((erg.numPrji+incPrabhujis)>erg.mainEventRegistration.numberofPrabhujis)
				return -1
			if((erg.numMataji+incMatajis)>erg.mainEventRegistration.numberofMatajis)
				return -1
			if((erg.numChildren+incChildren)>erg.mainEventRegistration.numberofChildren)
				return -1
			if((erg.numBrahmachari+incBrahmacharis)>erg.mainEventRegistration.numberofBrahmacharis)
				return -1
			}

	    // set the properties according to passed in parameters
	    eventRegistration.properties = params
	    eventRegistration.updator = springSecurityService.principal.username
	    if (! eventRegistration.hasErrors() && eventRegistration.save()) {
			    erg.total+=(incPrabhujis+incMatajis+incChildren+incBrahmacharis)
			    erg.numPrji += incPrabhujis
			    erg.numMataji += incMatajis
			    erg.numChildren += incChildren
			    erg.numBrahmachari += incBrahmacharis
			    erg.updator=springSecurityService.principal.username
			    if(!erg.save())
			    	{
				    erg.errors.allErrors.each {
					log.debug("In jq_runtime_eventRegistration_edit: error in updating erg (while adding new group):"+ erg)
					}
					return 0
			    	}
	      
	      return eventRegistration.id
	    } else {
		    eventRegistration.errors.allErrors.each {
			println it
			}
	      return 0
	    }
	  }
    }
    
    def runtimeDelete(Map params) {
	  log.debug("In runtimeDel:"+params)
	      def erg = EventRegistrationGroup.get(params.ergid)
	      def event = Event.findByTitle('RVTO')
	      def eventRegistration = null
	      int flag = 1

		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check person exists
			  eventRegistration  = EventRegistration.get(it)
			  if (eventRegistration) {
			    // reduce the counts and then delete
			    def total = eventRegistration.numberofPrabhujis+eventRegistration.numberofMatajis+eventRegistration.numberofChildren+eventRegistration.numberofBrahmacharis
			    erg.total-=total
			    erg.numGroups--
			    erg.numPrji -= eventRegistration.numberofPrabhujis
			    erg.numMataji -= eventRegistration.numberofMatajis
			    erg.numChildren -= eventRegistration.numberofChildren
			    erg.numBrahmachari -= eventRegistration.numberofBrahmacharis
			    erg.updator=springSecurityService.principal.username
			    erg.subEventRegistrations.remove(eventRegistration)
			    if(!erg.save())
			    	{
				    erg.errors.allErrors.each {
					log.debug("In jq_runtime_eventRegistration_edit: error in updating erg:"+ erg)
					}
				    flag= 0
			    	}
			    
			    if(!eventRegistration.delete())
			    	{
				    eventRegistration.errors.allErrors.each {
					log.debug("In jq_runtime_eventRegistration_edit: error in deleting eventRegistration:"+ eventRegistration)
					}
					flag= 0
			    	}
			    else {
				    message = "Deleted!!"
				    state = "OK"
			    }
			  }
		  	}
		  	return flag
    }
    
    def IsGroupCountValid(EventRegistrationGroup erg) {
    	log.debug("In IsGroupCountValid:"+erg)
    	if(erg.numPrji>erg.mainEventRegistration.numberofPrabhujis)
    		return false
    	if(erg.numMataji>erg.mainEventRegistration.numberofMatajis)
    		return false
    	if(erg.numChildren>erg.mainEventRegistration.numberofChildren)
    		return false
    	if(erg.numBrahmachari>erg.mainEventRegistration.numberofBrahmacharis)
    		return false
    	return true
    }
    
    def createEventRegistrationGroup(EventRegistration mainer, String creator) {
    	if(mainer)
    		{
		def erGroup = EventRegistrationGroup.findByMainEventRegistration(mainer)
		if(!erGroup)
			{
			//create just in time
			erGroup = new EventRegistrationGroup()
			erGroup.mainEventRegistration = mainer
			erGroup.subEventRegistrations = []
			erGroup.updator = erGroup.creator = creator
			    if (!erGroup.save()) {
				    erGroup.errors.allErrors.each {
					println it
					}
			    }
			log.debug("Created just in time..: "+erGroup)
			}
		return erGroup
    		}
    	return null
    }
    
    def pgUrl(Map params) {
		def returnURL
		if (Environment.current == Environment.DEVELOPMENT) {
		    returnURL = "http://localhost:8080/ics/eventRegistration/paid"
		} else 
		if (Environment.current == Environment.TEST) {
		    returnURL = "http://localhost:8080/ics/eventRegistration/paid"
		} else 
		if (Environment.current == Environment.PRODUCTION) {
		    returnURL = "https://server.konsoftech.in/ics/eventRegistration/paid"
		}
		def orderid="ICS"+new Date().format('ssmmkkDDDyyyy')+(params.orderid?:'')
		def amount = params.amount?:1
		def str = "M_nvccpune_12868|" + orderid + "|" + amount + "|"+returnURL+"|1hhdrt38f6i1yi4k14"
		def chksum = helperService.createChecksum(str)

		def pgurl = "https://www.ccavenue.com/shopzone/cc_details.jsp?"
		pgurl += "Order_Id=" + orderid + "&"
		pgurl += "Amount="+amount + "&"
		pgurl += "Merchant_Id=M_nvccpune_12868" + "&"
		pgurl += "Redirect_Url=" +returnURL+ "&"
		pgurl += "Checksum="+chksum + "&"
		pgurl += "billing_cust_name="+(params.name?:'')+ "&"
		pgurl += "billing_cust_address="+(params.address?:'')+"&"
		pgurl += "billing_cust_country=India&"
		pgurl += "billing_cust_tel="+(params.contactNumber?:'')+ "&"
		pgurl += "billing_cust_email="+(params.email?:'') + "&"
		pgurl += "delivery_cust_name="+'' + "&"
		pgurl += "delivery_cust_address=&"
		pgurl += "delivery_cust_tel="+'' + "&"
		pgurl += "billing_cust_notes=&"
		pgurl += "Merchant_Param="
		
		return pgurl
    }
    
    def updatePayment(EventRegistration er,String paymode,String amount,String ref) {
    	def mode
    	switch(paymode) {
    		case "ONLINE" :
    				mode = PaymentMode.findByName("ONLINE")
    				break
    		case "CASH" :
    				mode = PaymentMode.findByNameAndInperson("Cash",true)
    				break
    		default:
    				break
    		
    	}
    	def payref = new PaymentReference()
    	payref.mode = mode
    	payref.amount = new BigDecimal(amount)
    	payref.paymentDate = new Date()
    	payref.details = ref
    	payref.updator=payref.creator="system"
	if (!payref.save()) {
            payref.errors.allErrors.each {
			log.debug("Error in updatePayment saving payref:"+  it)
		    }
        }
        else {
		er.paymentReference = payref
		if (!er.save()) {
		    er.errors.allErrors.each {
				log.debug("Error in updatePayment :"+  it)
			    }
		}
        }
    }
    
    //@TODO: hardcoded charges for now
    def calculateCharges(EventRegistration eventRegistrationInstance) {
    	def fees = eventRegistrationInstance.assessment.fees
    	def charge = 0
    	def courier
    	if(eventRegistrationInstance.assessment.name.contains('courier'))
    		courier=true
	if(courier) {
		def option
		if(eventRegistrationInstance.assessment.name.contains('With Gita'))
			option='Option 1'
		else if(eventRegistrationInstance.assessment.name.contains('Without Gita'))
			option='Option 2'


		//check pincode
		def pin=eventRegistrationInstance.addressPincode
		def area
		if(pin.startsWith('411'))
			area='PUNE'
		else if(pin.startsWith('40') || pin.startsWith('41') ||pin.startsWith('42') ||pin.startsWith('43') ||pin.startsWith('44'))
			area='MAHARASHTRA'
		else
			area='INDIA'

		def ca =Assessment.findByStatusAndName('CANCELLED',option+' charge for '+area)
		if(ca)
			charge = ca.fees
		else
		{
			//calculate default charges
			switch(option) {
				case 'Option 1':
					switch(area) {
						case 'PUNE':
							charge = 35
							break
						case 'MAHARASHTRA':
							charge = 50
							break
						case 'INDIA':
							charge = 110
							break
						default:
							charge = 0
							break
					}
					break
				case 'Option 2':
					switch(area) {
						case 'PUNE':
							charge = 15
							break
						case 'MAHARASHTRA':
							charge = 25
							break
						case 'INDIA':
							charge = 55
							break
						default:
							charge = 0
							break
					}
					break
				default:
					charge=0
					break
			}
		}
   	}
   	return fees+charge    	
    }
    
    def calcuateRegistrationCharge(EventRegistration er) {
    	def charge = 0
    	try {
		def numAdults = er.numberofBrahmacharis+er.numberofPrabhujis+er.numberofMatajis
		def numChildren = er.numberofChildren
		charge = (numAdults*(er.event.maxAttendees))+(numChildren*(er.event.minAttendees))
    	}
    	catch(Exception e){
    		log.debug("Exception in calcuateRegistrationCharge "+e)
    	}
    	log.debug("Calculated charge for er:"+er+":"+charge)
    	return charge
    }
    
    //need to get numPersons,erid among other things
    def registrationDetailsSave(Map params) {
    	def numPerson = new Integer(params.numPersons)
    	def person
    	def er = EventRegistration.get(params.erid)

    	def user="unknown"
    	try {
    		user=springSecurityService.principal.username
    	}
    	catch(Exception e){}
    	
        for(int i=0;i<numPerson;i++) {
                try{
                        if(params.firstTime && params.firstTime=='true')
                            person = new Person()
                        else
                            person = Person.get(params.('personid_'+i))
                        person.name = params.('personname_'+i)
                        person.email = params.('email_'+i)
                        person.phone = params.('phone_'+i)
                        switch(params.('gender_'+i)) {
                                case 'FEMALE':
                                        person.isDonor = false	//@TODO: FEMALE:fix the Person domain class, no gender
                                        break
                                case 'female':
                                        person.isDonor = false	//@TODO: FEMALE:fix the Person domain class, no gender
                                        break
                                case 'MALE':
                                        person.isDonor = true	//@TODO: MALE:fix the Person domain class, no gender
                                        break
                                case 'male':
                                        person.isDonor = true	//@TODO: MALE:fix the Person domain class, no gender
                                        break
                                default:
                                        person.isDonor = true	//@TODO: MALE:fix the Person domain class, no gender
                                        break    				
                        }
                        person.dob = Date.parse('dd/MM/yyyy',params.('birthdate_'+i))
                        person.category=params.erid
                        person.reference='EventRegistration'
                        person.updator=person.creator=user
                        if(!person.save())
                                        person.errors.allErrors.each {
                                                log.debug "Error in registrationDetailsSave saving person :"+it
                                        }
                        else
                                {
                                }
                }
                catch(Exception e){
                        log.debug("registrationDetailsSave:Exception in saving person:"+e)
                        }
        }
                        
    	def amt = new BigDecimal(params.paymentDue)
    	//check payment status
    	if(params.pay && amt>0) {
    		//check if already some offline payment was made?
    		def pref = PaymentReference.findByRef('EventRegistration_'+params.erid)
    		if(!pref)
    			pref = new PaymentReference()
    		
    		pref.ref = 'EventRegistration_'+params.erid
    		pref.paymentBy = er.individual
    		pref.amount = (pref.amount?:0) + amt
    		pref.paymentDate = new Date()
    		pref.mode = PaymentMode.findByName('Cash')
    		pref.details = params.accodetails?:''
    		pref.updator=pref.creator=user
		if(!pref.save())
				pref.errors.allErrors.each {
					log.debug "Error in registrationDetailsSave payment :"+it
				}
		else {
			//update status of er only when paid full amount
			if(params.markComplete) {
				er.status='PAID'
				if(!er.save())
					er.errors.allErrors.each {
						log.debug "Error in registrationDetailsSave updating payment status:"+it
					}
			}
		}
			
    		
    	}
    	
    	[status:'OK']
    }
    
    //bulk register the specified category of individuals to the specified event and assessment
    def bulkRegistration(Map params) {
    	def er,event,addr,assmnt,user,login,icsRole
    	
    	event = Event.get(params.eid)
    	assmnt = Assessment.get(params.aid)
    	icsRole = IcsRole.findByAuthority('ROLE_ASMT_USER')
    	
    	try{
    		user = springSecurityService.principal.username
    	}
    	catch(Exception e) {
    		user="system"
    	}

    	Individual.findAllByCategory(params.category).each{ind->
    		er = EventRegistration.findByIndividual(ind)
    		if(!er) {
    			er = new EventRegistration()
    			er.regCode = genRegCode()
    			er.name = ind.legalName
    			addr = Address.findByCategoryAndIndividual('Correspondence',ind)
    			er.connectedIskconCenter = addr?.addressLine3
    			er.year = addr?.addressLine1
    			er.contactNumber = VoiceContact.findByCategoryAndIndividual('CellPhone',ind)?.number
    			er.email = EmailContact.findByCategoryAndIndividual('Personal',ind)?.emailAddress
    			er.event = event
    			er.assessment = assmnt
    			er.otherGuestType = params.language?:'ENGLISH'
    			er.arrivalDate = er.departureDate = new Date()	//registration date
    			er.individual = ind
    			er.verificationStatus = 'VERIFIED'
    			er.creator = er.updator = user
    			if(!er.save())
    				er.errors.allErrors.each {log.debug("error in bulkRegistration:"+it)}
    			else {
    				//now generate the loginid for the user
    				login = housekeepingService.createLogin(ind,icsRole)
    				
    				//create the IA for taking the tests
				def ia = new IndividualAssessment()
				ia.individual = ind
				ia.assessment = assmnt
				ia.language = er.otherGuestType?.toUpperCase()
				ia.eventRegistration = er
				ia.status = 'READY'
				ia.creator = ia.updator = user

				if(!ia.save())
					ia.errors.allErrors.each {log.debug("error saving ia in bulkRegistration:"+it)}
				else
    					log.debug("bulkRegistration:created er:"+er+":login:"+login)
    			}
    			
    		}
    	}
    }

}
