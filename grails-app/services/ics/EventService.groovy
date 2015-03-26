package ics

class EventService {

    def springSecurityService
    def housekeepingService
    def helperService
    def commsService    
    
    def bulkUploadParticipants(Map params) {
    	log.debug("bulkUploadParticipants :"+params)
    	def user
    	try{
    		user = springSecurityService.principal.username
    	}
    	catch(Exception e){user='system'}
    	def ind,ep
    	def event = Event.get(params.eventId)
    	if(!event)
    		return ['success':'fail']
	def idList = params.icsidlist.tokenize(',')
	idList.each
	{
		try{
		ind = Individual.findByIcsid(it)
		if(ind)
			{
			createEventParticipant(event,ind,user)
			}
		}
		catch(Exception e){log.debug(e)}
	}    	
    	return ['success':'ok']
    }
    
    def createEventParticipant(Event event, Individual ind, String user) {
	def ep = new EventParticipant()
	ep.event = event
	ep.individual = ind
	    ep.attended = false
	    ep.invited = false
	    ep.confirmed = false
	    ep.comments = ''

	ep.updator = ep.creator = user
	if(!ep.save())
	    ep.errors.allErrors.each {
		log.debug(it)
		}    	
    }
    
    def setupParticipants(Map params) {
	if(params.eplist) {
		//only for the specified participants
		params.eplist.tokenize(',').each{
			setupParticipant(EventParticipant.get(it))
		}
	}
	else
		{
		//for all uninvited participants in the event
		def event = Event.get(params.eid)
		EventParticipant.findAllByEvent(event).each{
			setupParticipant(it)
			}
		}
	return "OK"	
    }
    
    def setupParticipant(EventParticipant ep) {
    	if(!ep || ep.invited)
    		return false
   	
   	def loginid = housekeepingService.createLogin(ep.individual, com.krishna.IcsRole.findByAuthority('ROLE_EVENTPARTICIPANT'))
   	if(loginid) {
   		//mark as invited and send mail/sms to the participants
   		ep.invited = true
   		ep.save()
   		
		//send the email to participant with userid
		def depcp = DepartmentCP.createCriteria().get{
				eq('department',ep.event.department)
				cp{eq('type','Mandrill')}
				}
		if(depcp)
			{
			def template = Template.findByCodeAndCategory("EPSETUP","EMAIL")
			def body = commsService.fillTemplate(template,[ep.individual.toString(),loginid])
			commsService.sendMandrill([key:depcp?.cp?.apikey,sender:depcp.sender,toName:ep.individual.toString(),toEmail:EmailContact.findByCategoryAndIndividual('Personal',ep.individual)?.emailAddress,emailsub:template.name,emailbody:body,type:template.type])
			}
		
		//send sms
		def depcp_sms = DepartmentCP.createCriteria().get{
				eq('department',ep.event.department)
				cp{eq('type','SMS')}
				}
		if(depcp_sms)
			{
			def template = Template.findByCodeAndCategory("EPSETUP","SMS")
			def body = commsService.fillTemplate(template,[ep.individual.toString(),loginid])
			commsService.sendSms(depcp_sms.cp,VoiceContact.findByCategoryAndIndividual('CellPhone',ep.individual)?.number,body)
			}
   	}
    }
    
    def inviteByRole(Map params) {
    	def user
    	try{
    		user = springSecurityService.principal.username
    	}
    	catch(Exception e){user='system'}

    	if(params.eventIdForRole) {
    		def event = Event.get(params.eventIdForRole)
    		if(params.roles) {
			params.list('roles')?.each{
				IndividualRole.findAllByRoleAndStatus(Role.get(it),'VALID')?.each{
					createEventParticipant(event,it.individual,user)
				}
			}
    		}
    		if(params.inviteAllClees) {
    			Relationship.findAllByIndividual2AndStatus(event.contactPerson,'ACTIVE')?.each{
					createEventParticipant(event,it.individual1,user)
				}
    		}
    	}
    	return ['success':'ok']
    }
    
    //utility method to setup master data for yatra like events
    //event/setupMasterData?eid=3&category=EVENT&type=3&numDays=4&prasadCostPerDay=325&travelCostPerDay=425&venueCostPerDay=325&numPlaces=2&place1=Dwarka&place1_numDays=2&place1_nonacRoomRentPerDay=500&place1_acRoomRentPerDay=1000&place1_nonacRoomNumBeds=2&place1_nonacRoomNumExtraBeds=1&place1_nonacRoomExtraBedRentPerDay=50&place1_acRoomNumBeds=2&place1_acRoomNumExtraBeds=1&place1_acRoomExtraBedRentPerDay=100&place1_numNonACRooms=100&place1_numACRooms=100&place2=Somnath&place2_numDays=1&place2_nonacRoomRentPerDay=700&place2_acRoomRentPerDay=1000&place2_nonacRoomNumBeds=2&place2_nonacRoomNumExtraBeds=1&place2_nonacRoomExtraBedRentPerDay=50&place2_acRoomNumBeds=2&place2_acRoomNumExtraBeds=1&place2_acRoomExtraBedRentPerDay=100&place2_numNonACRooms=100&place2_numACRooms=100
    //[numPersons:2,numDays:4,accomodations:[[place:'Place1',acRoomRentPerDay:1000,standardRoomRentPerDay:500,numDays:2],[place:'Place2',acRoomRentPerDay:800,standardRoomRentPerDay:400,numDays:1]],prasadCostPerDay:350,travelCostPerDay:600,venueCostPerDay:200]
    def setupMasterData(Map params) {
	helperService.storeAV(params)
	return ['success':'ok']
    }

    def uploadSheet(Map params) {
    	log.debug("uploadSheet :"+params)
    		
    	def eps = EventParticipant.createCriteria().list(){
    			event{eq('id',new Long(params.sheeteventId))}
    			individual{'in'('icsid',params.icsidlist.tokenize(',').collect{new Integer(it)})}    			
    			}
	eps.each
	{
		it.attended = true
		if(!it.save())
			it.errors.allErrors.each {log.debug("Exception in uploadSheet:"+e)}
	}    	
    	return ['success':'ok']
    }
    
    def stats(Map params) {
    	log.debug("inside stats with params:"+params)
    	def eps = EventParticipant.findAllByEvent(Event.get(params.eventid))
    	def present = [], absent = []
    	return eps
    }
    
    def getIndividuals(Event event,String attendance,String language) {
    	boolean attended = (attendance=='PRESENT')?true:false
    	def eps = EventParticipant.createCriteria().list(){
    			eq('event',event)
    			eq('attended',attended)
    			individual{eq('languagePreference',language)}    			
    		}
    	return eps.collect{it.individual.id}.join(',')
    }
    
    

}
