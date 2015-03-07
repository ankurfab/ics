package ics

import grails.converters.JSON

class EventParticipantController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if(!params.sort)
        	params.sort = "lastUpdated" 
        if(!params.order)
        	params.order = "desc"
        
        [eventParticipantInstanceList: EventParticipant.list(params), eventParticipantInstanceTotal: EventParticipant.count()]
    }

    def create = {
        def eventParticipantInstance = new EventParticipant()
        eventParticipantInstance.properties = params
        println 'params='+params
        println 'eventParticipantInstance='+eventParticipantInstance
        return [eventParticipantInstance: eventParticipantInstance]
    }
    
    def invite = {
    
        def eventParticipantInstance = new EventParticipant()
        eventParticipantInstance.properties = params
        
        def donationIdList = []
        def InviteeList = []
       
        def j=0
        donationIdList = params.donationIds.split(",")
	def donationList = []
	for(int i=0; i<donationIdList.size(); i++)
	{
		if ((donationIdList[i])!='')
		{
			donationList.add(Donation.findById(donationIdList[i]))
			InviteeList[j] = (Donation.findById(donationIdList[i])).donatedBy

			j++;
		}
			/*if (params.donationIds[i])
			{
				if(Individual.findById(donationIdList[i]))
				{
					InviteeList[j] = Individual.findById(donationIdList[i])
					j++;
				}
        	}*/
        }
        println '---------------invite---------------'
        params.InviteeList=InviteeList
        println 'params='+params
        println 'donationIdList='+donationIdList
        
        //-----------to be rectified later-----------
        def donationIdList1 = donationIdList
        println 'donationIdList1='+donationIdList1
        donationIdList = ''
        donationIdList =  donationIdList1[0].toString()
        for(int i=1; i<donationIdList1.size(); i++)
        {
        	donationIdList = donationIdList + "," + donationIdList1[i]
        	
        }
        println 'donationIdList='+donationIdList
        //-------------------------------------------
        
        return [eventParticipantInstance: eventParticipantInstance, InviteeList: InviteeList, donationIdList: donationIdList, donationList: donationList]
    }
    
	def printaddresslabels = {
		println '-----------------printaddresslabels----------------'
		def eventParticipantInstance = new EventParticipant()
    	def InviteeList = []
    	println 'params='+params
    	println 'params.InviteeListSize='+params.InviteeListSize
    	if ((params.InviteeListSize).toInteger() == 1)
    	{
    		println 'inside if'
    		InviteeList[0] = params.InviteeList
    	}
    	else
    		InviteeList = params.InviteeList
    	println 'InviteeList[0]='+InviteeList[0]

		//def InviteeList = params.InviteeList
		def donationIds = []
		donationIds = params.donationIdList.split(",")
		def InviteeIdList = []
		def InviteeAddressList = []
		def j=0;
		
		println 'donationIds='+donationIds
		for (int i=0; i<donationIds.size(); i++)
		{
			println 'donationIds[i]='+donationIds[i]
			    if(donationIds[i]!='')
			    {
				def donationInstance = Donation.findById((donationIds[i]).toInteger())
				println 'donationInstance='+donationInstance
				InviteeIdList[j] = (Donation.findById(donationIds[i])).donatedById
				InviteeAddressList[j] = Address.findByIndividualAndCategory(Individual.findById(InviteeIdList[j]),"Correspondence")
				j++
			    }
        	}
        
		return [eventParticipantInstance: eventParticipantInstance, InviteeList: InviteeList, InviteeAddressList: InviteeAddressList]
	}

    def savefrominvite = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
		
		params.updator=params.creator
		
		params.invited = true
		params.confirmed = false
		params.attended = false
		params.flgAddressPrinted = false
		println '---------------savefrominvite---------------'
		println 'params='+params
		def eventParticipantInstance = new EventParticipant(params)
		def InviteeList = []
		def donations = []
		donations = params.donationIds.split(",")
		def InviteeIdList = []
		def InviteeAddressList = []
		
		def epList = []
		def j=0
		for(int i=0; i<donations.size(); i++)
		{
			if (donations[i]!='')
			{
				println 'donations[i]='+donations[i]
				InviteeList[j] = (Donation.get(donations[i])).donatedBy
				InviteeIdList[j] = (Donation.get(donations[i])).donatedBy.id
				InviteeAddressList[j] = Address.findByIndividualAndCategory(Individual.findById(InviteeIdList[j]),"Correspondence")
				params."individual.id"= InviteeIdList[j].toInteger()
				j++
				eventParticipantInstance = new EventParticipant(params)
				//generate registration code
				//todo verify if already exists
				eventParticipantInstance?.regCode = org.apache.commons.lang.RandomStringUtils.randomAlphanumeric(5)
				
			
				if (eventParticipantInstance.save(flush: true)){

					epList.add(eventParticipantInstance.id)
				}
				else

					render(view: "create", model: [eventParticipantInstance: eventParticipantInstance])
			}

		}
		println 'params='+params
		println 'InviteeList='+InviteeList
		def InviteeListSize = InviteeList.size()
		println 'InviteeListSize='+InviteeListSize
		
		if(epList.size() > 0)
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'eventParticipant.label', default: 'EventParticipant'), epList])}"
		else
			render(view: "create", model: [eventParticipantInstance: eventParticipantInstance])
        //redirect(action: "epsaved", id: eventParticipantInstance.id)
        redirect(action: "epsaved", params:[InviteeList:InviteeList, InviteeListSize:InviteeListSize, InviteeIdList:InviteeIdList, InviteeAddressList:InviteeAddressList, donationIdList: params.donationIds, epList: epList])
        
        /*def eventParticipantInstance = new EventParticipant(params)
        
        if (eventParticipantInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'eventParticipant.label', default: 'EventParticipant'), eventParticipantInstance.id])}"
            redirect(action: "show", id: eventParticipantInstance.id)
        }
        else {
            render(view: "create", model: [eventParticipantInstance: eventParticipantInstance])
        }*/
    }
	
    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
		params.updator=params.creator
		
		if(params."acDonatedBy_id"!='' && params."acDonatedBy_id"!=null)
			params."individual.id"= params."acDonatedBy_id"
		//else
		params.invited = true
		params.confirmed = false
		params.attended = false
		params.flgAddressPrinted = false	
		println 'params='+params
		
        def eventParticipantInstance = new EventParticipant(params)
	//generate registration code
	//todo verify if already exists
	eventParticipantInstance?.regCode = org.apache.commons.lang.RandomStringUtils.randomAlphanumeric(5)

        println 'eventParticipantInstance='+eventParticipantInstance
        if (eventParticipantInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'eventParticipant.label', default: 'EventParticipant'), eventParticipantInstance.id])}"
            redirect(action: "show", id: eventParticipantInstance.id)
        }
        else {
            render(view: "create", model: [eventParticipantInstance: eventParticipantInstance])
        }
    }
    
    def epsaved = {
    	println '---------------epsaved---------------'
    	println 'params='+params
    	println 'params.donationIdList='+params.donationIdList
    	def InviteeList = []
    	def InviteeListSize = params.InviteeListSize
    	println 'InviteeListSize='+InviteeListSize
    	
    	if (InviteeListSize.toInteger() == 1)
    	{
    		println 'inside if'
    		InviteeList[0] = params.InviteeList
    	}
    	else
    		InviteeList = params.InviteeList
    	println 'InviteeList[0]='+InviteeList[0]
    	def InviteeIdList = []
    	InviteeIdList = params.InviteeIdList
    	def InviteeAddressList = []
    	InviteeAddressList = params.InviteeAddressList
    	def epList = []
    	epList = params.epList
    	def donationIdList = []
    	donationIdList = params.donationIdList.split(",")
    	println 'InviteeList='+InviteeList
    	println 'InviteeIdList='+InviteeIdList
    	println 'InviteeAddressList='+InviteeAddressList
    	def donations = donationIdList[0]
    	for (int i=1; i<donationIdList.size(); i++)
    	{
    		if (donationIdList[i]!='')
    			donations = donations + "," + donationIdList[i]
    	}
    	println 'params='+params
    	return [InviteeList:InviteeList, InviteeListSize:InviteeListSize, InviteeIdList: InviteeIdList, InviteeAddressList: InviteeAddressList, donationIdList: donations, epList: epList]
    }

	def markasprinted = {
		
		println '---------------markasprinted---------------'
		println 'params='+params
		def epList = []
    	epList = params.epList
		println 'epList='+epList
		println 'params='+params
		for(int i=0; i<epList.size(); i++)
			def ret=EventParticipant.executeUpdate("Update EventParticipant set flg_address_printed = true where id ='"+epList[i]+"'")

		redirect(action: "list")
	}
	
    def show = {
        def eventParticipantInstance = EventParticipant.get(params.id)
        if (!eventParticipantInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'eventParticipant.label', default: 'EventParticipant'), params.id])}"
            redirect(action: "list")
        }
        else {
            [eventParticipantInstance: eventParticipantInstance]
        }
    }

    def edit = {
        def eventParticipantInstance = EventParticipant.get(params.id)
        if (!eventParticipantInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'eventParticipant.label', default: 'EventParticipant'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [eventParticipantInstance: eventParticipantInstance]
        }
    }

    def update = {
        def eventParticipantInstance = EventParticipant.get(params.id)
        if (eventParticipantInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (eventParticipantInstance.version > version) {
                    
                    eventParticipantInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'eventParticipant.label', default: 'EventParticipant')] as Object[], "Another user has updated this EventParticipant while you were editing")
                    render(view: "edit", model: [eventParticipantInstance: eventParticipantInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

		if(params."acIndividual_id")
			params."individual.id" = params."acIndividual_id"
		else
		{
			if (params.individualChkBox)
			{
				println 'CHK='+params.individualChkBox.value.toString()
				if (params.individualChkBox.value.toString()=="on")
						params."individual.id"= params.h_individual.id
				else
				{
					flash.message = "Individual Not Entered!"
					render(view: "edit", model: [eventParticipantInstance: eventParticipantInstance])
					return [eventParticipantInstance: eventParticipantInstance]
				}
			}
			else
			{
				//println 'NO CHECKBOX'
				flash.message = "Individual Not Entered!"
				render(view: "edit", model: [eventParticipantInstance: eventParticipantInstance])
				return [eventParticipantInstance: eventParticipantInstance] 
			}
		}	

            eventParticipantInstance.properties = params
            if (!eventParticipantInstance.hasErrors() && eventParticipantInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'eventParticipant.label', default: 'EventParticipant'), eventParticipantInstance.id])}"
                redirect(action: "show", id: eventParticipantInstance.id)
            }
            else {
                render(view: "edit", model: [eventParticipantInstance: eventParticipantInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'eventParticipant.label', default: 'EventParticipant'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def eventParticipantInstance = EventParticipant.get(params.id)
        if (eventParticipantInstance) {
            try {
                eventParticipantInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'eventParticipant.label', default: 'EventParticipant'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'eventParticipant.label', default: 'EventParticipant'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'eventParticipant.label', default: 'EventParticipant'), params.id])}"
            redirect(action: "list")
        }
    }
    
    def inviteForEvent() {
    	if(!params."event.id")
    		{
                flash.message = "Event not specified"
                redirect(controller: "Event", action: "list")
    		}
    	def event = Event.findByTitle('RVTO')
    	def ep
    	def idList = params.ids.tokenize(',')
    	idList.each{
    		ep = new EventParticipant()
    		ep.event = event
    		ep.individual = Individual.get(new Long(it))
    		ep.invited = true //todo set it only when the actual invitation is sent out
		ep.regCode = org.apache.commons.lang.RandomStringUtils.randomAlphanumeric(5)
		ep.role = "GUEST" //drive from input
		ep.comments = ""
		ep.creator = springSecurityService.principal.username
		ep.updator = ep.creator
		if(!ep.save(flush:true))
			ep.errors.each{println it}
    	}
    	redirect(action: "list")
    }

    def markConfirmed() {
    	params.idlist?.tokenize(',')?.each{
    		def ep = EventParticipant.get(it)
    		ep.confirmed = true 
		if(!ep.save())
			ep.errors.each{println it}
    	}
      def response = [message:"OK"]
      render response as JSON    	
    }

    def markInvited() {
    	params.idlist?.tokenize(',')?.each{
    		def ep = EventParticipant.get(it)
    		ep.invited = true 
		if(!ep.save())
			ep.errors.each{println it}
    	}
      def response = [message:"OK"]
      render response as JSON    	
    }

    
    def markAttended() {
    	params.idlist?.tokenize(',')?.each{
    		def ep = EventParticipant.get(it)
    		ep.attended = true 
		if(!ep.save())
			ep.errors.each{println it}
    	}
      def response = [message:"OK"]
      render response as JSON    	
    }

    def updateComments() {
    	if(params.comments) {
		params.epids?.tokenize(',')?.each{
			def ep = EventParticipant.get(it)
			ep.comments += params.comments 
			if(!ep.save())
				ep.errors.each{println it}
		}
    	}
      def response = [message:"OK"]
      render response as JSON    	
    }


}
