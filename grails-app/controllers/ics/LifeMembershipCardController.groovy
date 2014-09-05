package ics

import org.springframework.dao.DataIntegrityViolationException
import org.springframework.mail.MailException
import org.springframework.mail.MailSender
import org.springframework.mail.SimpleMailMessage


class LifeMembershipCardController {

    def housekeepingService
    def springSecurityService
    def mailService
    def sendMailService    

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 100, 100)
        if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
        {
		def login = springSecurityService.principal.username
		println "Loggedin user: "+login
		def individual = Individual.findByLoginid(login)
		println "setSessionParams for: "+individual

		def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
		println 'pcRole='+pcRole
		def patronCareHead, patronCareSevaks = []
		def individualInstanceList = [], individualRels = []
		def cultivatedByRelation = Relation.findByName("Cultivated by")
		
		def sevakOfRelation = Relation.findByName("Sevak of")
		def lifePatronList = [], lifePatronListPC = [], lifePatronListPCSevak = []

		for(int i=0; i<pcRole.size(); i++)
		{
			if(pcRole[i].toString() == "PatronCare")
			{
				patronCareSevaks = Relationship.findAllWhere(individual2:individual, relation:sevakOfRelation, status:"ACTIVE").individual1		
				println 'patronCareSevaks='+patronCareSevaks
				lifePatronListPC = LifeMembershipCard.findAllByOriginatingDeptCollector(Individual.get(session.individualid))
				for(int j=0; j<lifePatronListPC.size(); j++)
					lifePatronList.add(lifePatronListPC[j])
				for(int j=0; j<patronCareSevaks.size(); j++)
				{
					lifePatronListPCSevak = LifeMembershipCard.findAllByOriginatingDeptCollector(patronCareSevaks[j])
					for(int k=0; k<lifePatronListPCSevak.size(); k++)
						lifePatronList.add(lifePatronListPCSevak[k])
					//println 'lifePatronList='+lifePatronList
				}
			}
			if(pcRole[i].toString() == "PatronCareSevak")
				lifePatronList = LifeMembershipCard.findAllByOriginatingDeptCollector(Individual.get(session.individualid))		
		}
        	/////////////////////////
        	println 'patroncare'
        	println 'Welcome, '+Individual.get(session.individualid)
        	//lifePatronList = LifeMembershipCard.findAllByOriginatingDeptCollector(Individual.get(session.individualid))
        	//println 'lifePatronList='+lifePatronList
        	[lifeMembershipCardInstanceList: lifePatronList, lifeMembershipCardInstanceTotal: lifePatronList.size()]
        }
        else
        	[lifeMembershipCardInstanceList: LifeMembershipCard.list(params), lifeMembershipCardInstanceTotal: LifeMembershipCard.count()]
    }

    def create() {
    	println "create"
    	/*def maxSeq = housekeepingService.getNextSequence("LifeMembershipCard", "PUN")
    	println 'maxSeq='+maxSeq
    	def lifeMembershipCardNo = "PUN" + maxSeq
	println 'lifeMembershipCardNo='+lifeMembershipCardNo   */ 	
        //[lifeMembershipCardInstance: new LifeMembershipCard(params), lifeMembershipCardNo:lifeMembershipCardNo]
        [lifeMembershipCardInstance: new LifeMembershipCard(params)]
    }

    def save() {
    	println "params:"+params
    	
    	//params.lifeMembershipCardNumber = params.h_lifeMembershipCardNumber
    	if(params."acLifeMember_id")
    	{
	      	//params."lifeMember.id"= params."acLifeMember_id"
	      	params.lifeMember = Individual.get(params."acLifeMember_id")//params.acLifeMember
	}
	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
		params.originatingDeptCollector	= Individual.get(session.individualid)
	else
	{
		if(params."acOriginatingDeptCollector_id")
		{
			//params."originatingDeptCollector.id"= params."acOriginatingDeptCollector_id"
			params.originatingDeptCollector = Individual.get(params."acOriginatingDeptCollector_id")//params.acOriginatingDeptCollector
		}
	}
    	if(params."acForwardingDeptRepresentative_id")
    	{
	      	//params."forwardingDeptRepresentative.id"= params."acForwardingDeptRepresentative_id"
	      	params.forwardingDeptRepresentative = Individual.get(params."acForwardingDeptRepresentative_id")//params.acForwardingDeptRepresentative
	}
	      	
	if(params.dateFormSubmissionOriginatingDeptToForwardingDept)
		params.dateFormSubmissionOriginatingDeptToForwardingDept = Date.parse('dd-MM-yyyy', params.dateFormSubmissionOriginatingDeptToForwardingDept)
    	
    	
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator
	params.duplicate = false
	params.acceptedByOriginatingDept = false
	params.cardStatus = "Form Submitted by Patron Care Dept To NVCC"
        def lifeMembershipCardInstance = new LifeMembershipCard(params)
        if (!lifeMembershipCardInstance.save(flush: true)) {
            render(view: "create", model: [lifeMembershipCardInstance: lifeMembershipCardInstance])
            return
        }

	flash.message = message(code: 'default.created.message', args: [message(code: 'lifeMembershipCard.label', default: 'LifeMembershipCard'), lifeMembershipCardInstance.id])
        redirect(action: "show", id: lifeMembershipCardInstance.id)
    }

    def show() {
    	println "params="+params
        def lifeMembershipCardInstance = LifeMembershipCard.get(params.id)
        if (!lifeMembershipCardInstance) {
		flash.message = message(code: 'default.not.found.message', args: [message(code: 'lifeMembershipCard.label', default: 'LifeMembershipCard'), params.id])
            redirect(action: "list")
            return
        }

        [lifeMembershipCardInstance: lifeMembershipCardInstance]
    }

    def edit() {
        def lifeMembershipCardInstance = LifeMembershipCard.get(params.id)
        if (!lifeMembershipCardInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'lifeMembershipCard.label', default: 'LifeMembershipCard'), params.id])
            redirect(action: "list")
            return
        }

        [lifeMembershipCardInstance: lifeMembershipCardInstance]
    }

    def update() {
    	println "Params in update lifeMembershipCard: "+params
	println "params.cardStatus="+params.cardStatus
    	println "params.h_cardStatus="+params.h_cardStatus
    	
    	if(params.cardStatus == "Card Delivered" && params.h_cardStatus != "Card Delivered")
    	{
    		redirect(action: "cardsDelivery")
    		return
    	}
    	
        def lifeMembershipCardInstance = LifeMembershipCard.get(params.id)
        if (!lifeMembershipCardInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'lifeMembershipCard.label', default: 'LifeMembershipCard'), params.id])
            redirect(action: "list")
            return
        }

	if(params.dateFormSubmissionOriginatingDeptToForwardingDept)
		params.dateFormSubmissionOriginatingDeptToForwardingDept = Date.parse('dd-MM-yyyy', params.dateFormSubmissionOriginatingDeptToForwardingDept)
	if(params.dateFormSentToProcessingDept)
		params.dateFormSentToProcessingDept = Date.parse('dd-MM-yyyy', params.dateFormSentToProcessingDept)
	if(params.dateCardArrival)
		params.dateCardArrival = Date.parse('dd-MM-yyyy', params.dateCardArrival)
	if(params.dateCardDelivery)
		params.dateCardDelivery = Date.parse('dd-MM-yyyy', params.dateCardDelivery)
		
      	if (params.LifeMemberChkBox)
      	{
		if (params.LifeMemberChkBox.value.toString()=="on")
		{
			params."lifeMember.id"= params."h_lifeMember.id"
			params.lifeMember = Individual.get(params."h_lifeMember.id")
		}
		else
		{
			if(!params."acLifeMember_id")
			{
				flash.message = "Life Patron Name Not Entered!"
				render(view: "edit", model: [lifeMembershipCardInstance: lifeMembershipCardInstance])
				return [lifeMembershipCardInstance: lifeMembershipCardInstance]
			}
			else
				params.lifeMember = Individual.get(params."acLifeMember_id")
		}
	}
	else
	{
		//println 'NO CHECKBOX'
		if(!params."acLifeMember_id")
		{
			flash.message = "Life Patron Name Not Entered!"
			render(view: "edit", model: [lifeMembershipCardInstance: lifeMembershipCardInstance])
			return [lifeMembershipCardInstance: lifeMembershipCardInstance] 
		}
		else
			params.lifeMember = Individual.get(params."acLifeMember_id")
		
	}
      		
      	if (params.OriginatingDeptCollectorChkBox)
      	{
		if (params.OriginatingDeptCollectorChkBox.value.toString()=="on")
		{
			params."originatingDeptCollector.id"= params."h_originatingDeptCollector.id"
			params.originatingDeptCollector = Individual.get(params."h_originatingDeptCollector.id")
			
		}
		else
		{
			if(!params."acOriginatingDeptCollector_id")
			{
				flash.message = "Patron Care Collector Name Not Entered!"
				render(view: "edit", model: [lifeMembershipCardInstance: lifeMembershipCardInstance])
				return [lifeMembershipCardInstance: lifeMembershipCardInstance]
			}
			else
				params.originatingDeptCollector = Individual.get(params."acOriginatingDeptCollector_id")
		}
	}
	else
	{
		//println 'NO CHECKBOX'
		if(!params."acOriginatingDeptCollector_id")
		{
			flash.message = "Patron Care Collector Name Not Entered!"
			render(view: "edit", model: [lifeMembershipCardInstance: lifeMembershipCardInstance])
			return [lifeMembershipCardInstance: lifeMembershipCardInstance] 
		}
		else
			params.originatingDeptCollector = Individual.get(params."acOriginatingDeptCollector_id")
		
	}
	
      	if (params.ForwardingDeptRepresentativeChkBox)
      	{
		if (params.ForwardingDeptRepresentativeChkBox.value.toString()=="on")
		{
			params."forwardingDeptRepresentative.id"= params."h_forwardingDeptRepresentative.id"
			params.forwardingDeptRepresentative = Individual.get(params."h_forwardingDeptRepresentative.id")
			
		}
		else
		{
			if(!params."acForwardingDeptRepresentative_id")
			{
				flash.message = "NVCC Representative Name Not Entered!"
				render(view: "edit", model: [lifeMembershipCardInstance: lifeMembershipCardInstance])
				return [lifeMembershipCardInstance: lifeMembershipCardInstance]
			}
			else
				params.forwardingDeptRepresentative = Individual.get(params."acForwardingDeptRepresentative_id")
		}
	}
	else
	{
		//println 'NO CHECKBOX'
		if(!params."acForwardingDeptRepresentative_id")
		{
			flash.message = "NVCC Representative Name Not Entered!"
			render(view: "edit", model: [lifeMembershipCardInstance: lifeMembershipCardInstance])
			return [lifeMembershipCardInstance: lifeMembershipCardInstance]
		}
		else
			params.forwardingDeptRepresentative = Individual.get(params."acForwardingDeptRepresentative_id")
	}

	if (params.cardStatus == "Card Arrived" && params.h_cardStatus != "Card Arrived")
	{
		
		//sendMailService.sendEmailToPC()
		//def emailId = "saisudrik@yahoo.com"
		println "individual="+Individual.get(params."h_originatingDeptCollector.id")
		def emailIds = EmailContact.findAllByIndividual(Individual.get(params."h_originatingDeptCollector.id"))
		println "emailIds="+emailIds
		def mailIds = [], i
		if(emailIds)
		{
			for(i=0; i<emailIds.size(); i++)
				mailIds.add(emailIds[i].emailAddress)
		
		

			println "mailIds="+mailIds

			def mailBody = 'The card for Life Patron '+ params.lifeMember +' has arrived. Please collect it.' 
			sendMail {     
			  to mailIds
			  subject "Life Patron Card Arrival"     
			  body mailBody
			}   
		}
		
		def phoneNos = VoiceContact.findAllByIndividualAndCategory(Individual.get(params."h_originatingDeptCollector.id"), "CellPhone")
		println "phoneNos="+phoneNos
		def cellNos = ""
		
		if(phoneNos)
		{
			for(i=0; i<phoneNos.size(); i++)
			{
				cellNos = cellNos + "," + (phoneNos[i].number).toString()
				println "cellNos="+cellNos
				
			}
		}
		if(cellNos)
		{
			if (cellNos[0..0] == ",")
				cellNos = cellNos[1..-1]
		}
		def lifeMemberName = (params.lifeMember).toString().replace(" ","%20")
		//housekeepingService.sendSMS(cellNos,'The%20card%20for%20Life%20Patron%20'+ lifeMemberName +'%20has%20arrived.%20Please%20collect%20it.' )
		housekeepingService.sendSMS(cellNos,'The%20card%20for%20Life%20Member%20'+lifeMemberName+'%20has%20arrived.%20Please%20collect%20it%20within%2015%20days%20from%20Patron%20Care%20Dept.%20-ISKCON%20NVCC')
		
		
		/*mailService.sendMail {
		   to "saisudrik@yahoo.com","saisudrik@gmail.com"
		   from "john@g2one.com"
		   //cc "marge@g2one.com", "ed@g2one.com"
		   //bcc "joe@g2one.com"
		   subject "Card Arrival"
		   body 'The card has arrived. Please collect it.'
		}*/
		
		println "mail sent"
	}

        if (params.version) {
            def version = params.version.toLong()
            if (lifeMembershipCardInstance.version > version) {
                lifeMembershipCardInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'lifeMembershipCard.label', default: 'LifeMembershipCard')] as Object[],
                          "Another user has updated this LifeMembershipCard while you were editing")
                render(view: "edit", model: [lifeMembershipCardInstance: lifeMembershipCardInstance])
                return
            }
        }

        lifeMembershipCardInstance.properties = params

        if (!lifeMembershipCardInstance.save(flush: true)) {
            render(view: "edit", model: [lifeMembershipCardInstance: lifeMembershipCardInstance])
            return
        }

	flash.message = message(code: 'default.updated.message', args: [message(code: 'lifeMembershipCard.label', default: 'LifeMembershipCard'), lifeMembershipCardInstance.id])
        redirect(action: "show", id: lifeMembershipCardInstance.id)
    }

    def delete() {
        def lifeMembershipCardInstance = LifeMembershipCard.get(params.id)
        if (!lifeMembershipCardInstance) {
		flash.message = message(code: 'default.not.found.message', args: [message(code: 'lifeMembershipCard.label', default: 'LifeMembershipCard'), params.id])
            redirect(action: "list")
            return
        }

        try {
            lifeMembershipCardInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'lifeMembershipCard.label', default: 'LifeMembershipCard'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
		flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'lifeMembershipCard.label', default: 'LifeMembershipCard'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
    
    def formsSubmittedList() {
        if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
        {
		def login = springSecurityService.principal.username
		println "Loggedin user: "+login
		def individual = Individual.findByLoginid(login)
		println "setSessionParams for: "+individual

		def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
		println 'pcRole='+pcRole
		def patronCareHead, patronCareSevaks = []
		def individualInstanceList = [], individualRels = []
		def cultivatedByRelation = Relation.findByName("Cultivated by")
		
		def sevakOfRelation = Relation.findByName("Sevak of")
		def formsSubmittedList = [], lifePatronListPC = [], lifePatronListPCSevak = []

		for(int i=0; i<pcRole.size(); i++)
		{
			if(pcRole[i].toString() == "PatronCare")
			{
				patronCareSevaks = Relationship.findAllWhere(individual2:individual, relation:sevakOfRelation, status:"ACTIVE").individual1		
				lifePatronListPC = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(Individual.get(session.individualid),"Form Submitted by Patron Care Dept To NVCC")
				//println 'lifePatronListPC='+lifePatronListPC
				for(int j=0; j<lifePatronListPC.size(); j++)
					formsSubmittedList.add(lifePatronListPC[j])
				for(int j=0; j<patronCareSevaks.size(); j++)
				{
					lifePatronListPCSevak = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(patronCareSevaks[j],"Form Submitted by Patron Care Dept To NVCC")
					//println 'lifePatronListPCSevak='+lifePatronListPCSevak
					for(int k=0; k<lifePatronListPCSevak.size(); k++)
						formsSubmittedList.add(lifePatronListPCSevak[k])
					//println 'cardsDeliveredList='+cardsDeliveredList
				}
			}
			if(pcRole[i].toString() == "PatronCareSevak")
				formsSubmittedList = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(Individual.get(session.individualid),"Form Submitted by Patron Care Dept To NVCC")		
		}
        	/////////////////////////
        	println 'patroncare'
        	println 'Welcome, '+Individual.get(session.individualid)
		def formsSubmittedListTotal
		[formsSubmittedList: formsSubmittedList, formsSubmittedListTotal: formsSubmittedList.size()]
        	
        }
        else
        {
		def formsSubmittedList = LifeMembershipCard.findAllByCardStatus("Form Submitted by Patron Care Dept To NVCC")
		println 'formsSubmittedList='+formsSubmittedList
		def formsSubmittedListTotal
		[formsSubmittedList: formsSubmittedList, formsSubmittedListTotal: formsSubmittedList.size()]
    	}
    }
    
    def markAsSentToJuhu() {
    	println 'markAsSentToJuhu params:'+params
    	def lifePatronCardIdsList = [], cardIdsList = [], flgNotUpdated = 0
       	
        lifePatronCardIdsList = params.lifePatronCardIds.split(",")
        params.cardStatus = "Form Sent To Juhu"
        //def now = new Date()
        params.dateFormSentToProcessingDept = new Date()
    	for(int i=0; i<lifePatronCardIdsList.size(); i++)
    	{
    		if(lifePatronCardIdsList[i])
    		{
    		
			cardIdsList[i] = LifeMembershipCard.get(lifePatronCardIdsList[i])
			cardIdsList[i].properties = params

			if (!cardIdsList[i].save(flush: true)) {
			    //flash.message = message(code: 'default.not.found.message', args: [message(code: 'lifeMembershipCard.label', default: 'LifeMembershipCard'), lifePatronCardIdsList[i]])
			    flgNotUpdated = 1
			}
		}
        }
    	
    	if(flgNotUpdated == 1)
    	{
    		redirect(action: "list")
		return
    	}
    	else
    	{
		if(lifePatronCardIdsList.size()>0)
			flash.message = message(code: 'default.updated.message', args: [message(code: 'lifeMembershipCard.label', default: 'LifeMembershipCard'), lifePatronCardIdsList])
    	}

    	println 'cardIdsList='+cardIdsList
    	redirect(action: "list")
    }
    
    def formsSentToJuhuList() {
        if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
        {
		def login = springSecurityService.principal.username
		println "Loggedin user: "+login
		def individual = Individual.findByLoginid(login)
		println "setSessionParams for: "+individual

		def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
		println 'pcRole='+pcRole
		def patronCareHead, patronCareSevaks = []
		def individualInstanceList = [], individualRels = []
		def cultivatedByRelation = Relation.findByName("Cultivated by")
		
		def sevakOfRelation = Relation.findByName("Sevak of")
		def formsSentToJuhuList = [], lifePatronListPC = [], lifePatronListPCSevak = []

		for(int i=0; i<pcRole.size(); i++)
		{
			if(pcRole[i].toString() == "PatronCare")
			{
				patronCareSevaks = Relationship.findAllWhere(individual2:individual, relation:sevakOfRelation, status:"ACTIVE").individual1		
				lifePatronListPC = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(Individual.get(session.individualid),"Form Sent To Juhu")
				//println 'lifePatronListPC='+lifePatronListPC
				for(int j=0; j<lifePatronListPC.size(); j++)
					formsSentToJuhuList.add(lifePatronListPC[j])
				for(int j=0; j<patronCareSevaks.size(); j++)
				{
					lifePatronListPCSevak = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(patronCareSevaks[j],"Form Sent To Juhu")
					//println 'lifePatronListPCSevak='+lifePatronListPCSevak
					for(int k=0; k<lifePatronListPCSevak.size(); k++)
						formsSentToJuhuList.add(lifePatronListPCSevak[k])
					//println 'cardsDeliveredList='+cardsDeliveredList
				}
			}
			if(pcRole[i].toString() == "PatronCareSevak")
				formsSentToJuhuList = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(Individual.get(session.individualid),"Form Sent To Juhu")		
		}
        	/////////////////////////
        	println 'patroncare'
        	println 'Welcome, '+Individual.get(session.individualid)
		def formsSentToJuhuListTotal
		[formsSentToJuhuList: formsSentToJuhuList, formsSentToJuhuListTotal: formsSentToJuhuList.size()]
        	
        }
    
    	else
    	{
		def formsSentToJuhuList
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifNotGranted('ROLE_PATRONCARE'))
			formsSentToJuhuList = LifeMembershipCard.findAllByCardStatus("Form Sent To Juhu")
		else
			formsSentToJuhuList = LifeMembershipCard.findAllByCardStatusAndOriginatingDeptCollector("Form Sent To Juhu",Individual.get(session.individualid))
		println 'formsSentToJuhuList='+formsSentToJuhuList
		def formsSentToJuhuListTotal
		[formsSentToJuhuList: formsSentToJuhuList, formsSentToJuhuListTotal: formsSentToJuhuList.size()]
    	}
    }

    def markAsCardArrived() {
    	println 'markAsCardArrived params:'+params
    	def lifePatronCardIdsList = [], cardIdsList = [], flgNotUpdated = 0, patronCareCollectorsList = []
       	
        lifePatronCardIdsList = params.lifePatronCardIds.split(",")
        println 'lifePatronCardIdsList:'+lifePatronCardIdsList
        params.cardStatus = "Card Arrived"
        params.dateCardArrival = new Date()
    	for(int i=0; i<lifePatronCardIdsList.size(); i++)
    	{
    		if(lifePatronCardIdsList[i])
    		{
    	
			cardIdsList[i] = LifeMembershipCard.get(lifePatronCardIdsList[i])
			cardIdsList[i].properties = params

			if (!cardIdsList[i].save(flush: true)) {
			    //flash.message = message(code: 'default.not.found.message', args: [message(code: 'lifeMembershipCard.label', default: 'LifeMembershipCard'), lifePatronCardIdsList[i]])
			    flgNotUpdated = 1
			}
			else
			{
				patronCareCollectorsList[i] = cardIdsList[i].originatingDeptCollector
			}
		}
        }
    	
    	if(flgNotUpdated == 1)
    	{
    		redirect(action: "list")
		return
    	}
    	else
    	{
		if(lifePatronCardIdsList.size()>0)
			flash.message = message(code: 'default.updated.message', args: [message(code: 'lifeMembershipCard.label', default: 'LifeMembershipCard'), lifePatronCardIdsList])
		
		println 'patronCareCollectorsList='+patronCareCollectorsList
		patronCareCollectorsList = patronCareCollectorsList.unique()
		println 'patronCareCollectorsList='+patronCareCollectorsList
		def lifeMembers = []
		def try1=[]
		for(int i=0; i<patronCareCollectorsList.size(); i++)
		{

			lifeMembers = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(patronCareCollectorsList[i],"Card Arrived").lifeMember
			println 'lifeMembers='+lifeMembers
			
			def emailIds = EmailContact.findAllByIndividual(patronCareCollectorsList[i])
			println "emailIds="+emailIds
			def mailIds = [], j
			if(emailIds)
			{
				for(j=0; j<emailIds.size(); j++)
					mailIds.add(emailIds[j].emailAddress)

				println "mailIds="+mailIds

				def mailBody = 'The card(s) for Life Patron(s) '+ lifeMembers +' has(ve) arrived. Please collect.' 
				sendMail {     
				  to mailIds
				  subject "Life Patron Card(s) Arrival"     
				  body mailBody
				}   
			}

			def phoneNos = VoiceContact.findAllByIndividualAndCategory(patronCareCollectorsList[i], "CellPhone")
			println "phoneNos="+phoneNos
			def cellNos = ""

			if(phoneNos)
			{
				for(j=0; j<phoneNos.size(); j++)
				{
					cellNos = cellNos + "," + (phoneNos[j].number).toString()
					println "cellNos="+cellNos

				}
			}
			if (cellNos[0..0] == ",")
				cellNos = cellNos[1..-1]
			def lifeMemberName = lifeMembers.toString().replace(" ","%20")
			//housekeepingService.sendSMS(cellNos,'The%20card(s)%20for%20Life%20Patron(s)%20'+ lifeMemberName +'%20has(ve)%20arrived.%20Please%20collect.' )
			housekeepingService.sendSMS(cellNos,'The%20card%20for%20Life%20Member%20'+lifeMemberName+'%20has%20arrived.%20Please%20collect%20it%20within%2015%20days%20from%20Patron%20Care%20Dept.%20-ISKCON%20NVCC')
		}
    	}

    	println 'cardIdsList='+cardIdsList
    	redirect(action: "list")
    }
    
    def cardsDelivery() {
    	def patronCareList = IndividualRole.findAllByRole(Role.findByName("PatronCare")).individual
    	println 'patronCareList='+patronCareList
    	[patronCareList: patronCareList]
    }
    
    def cardsArrivedList() {
        if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
        {
		def login = springSecurityService.principal.username
		println "Loggedin user: "+login
		def individual = Individual.findByLoginid(login)
		println "setSessionParams for: "+individual

		def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
		println 'pcRole='+pcRole
		def patronCareHead, patronCareSevaks = []
		def individualInstanceList = [], individualRels = []
		def cultivatedByRelation = Relation.findByName("Cultivated by")
		
		def sevakOfRelation = Relation.findByName("Sevak of")
		def cardsArrivedList = [], lifePatronListPC = [], lifePatronListPCSevak = []

		for(int i=0; i<pcRole.size(); i++)
		{
			if(pcRole[i].toString() == "PatronCare")
			{
				patronCareSevaks = Relationship.findAllWhere(individual2:individual, relation:sevakOfRelation, status:"ACTIVE").individual1		
				lifePatronListPC = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(Individual.get(session.individualid),"Card Arrived")
				//println 'lifePatronListPC='+lifePatronListPC
				for(int j=0; j<lifePatronListPC.size(); j++)
					cardsArrivedList.add(lifePatronListPC[j])
				for(int j=0; j<patronCareSevaks.size(); j++)
				{
					lifePatronListPCSevak = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(patronCareSevaks[j],"Card Arrived")
					//println 'lifePatronListPCSevak='+lifePatronListPCSevak
					for(int k=0; k<lifePatronListPCSevak.size(); k++)
						cardsArrivedList.add(lifePatronListPCSevak[k])
					//println 'cardsDeliveredList='+cardsDeliveredList
				}
			}
			if(pcRole[i].toString() == "PatronCareSevak")
				cardsArrivedList = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(Individual.get(session.individualid),"Card Arrived")		
		}
        	/////////////////////////
        	println 'patroncare'
        	println 'Welcome, '+Individual.get(session.individualid)
        	//lifePatronList = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(Individual.get(session.individualid),"Card Arrived")
        	//println 'lifePatronList='+lifePatronList
        	//[lifeMembershipCardInstanceList: lifePatronList, lifeMembershipCardInstanceTotal: lifePatronList.size()]
		//println 'cardsArrivedListTotal='+cardsArrivedListTotal
		def cardsArrivedListTotal
		[cardsArrivedList: cardsArrivedList, cardsArrivedListTotal: cardsArrivedList.size()]
        	
        }
    
	else
	{
		println 'cardsArrivedList params:'+params
		def cardsArrivedList = LifeMembershipCard.findAllByCardStatus("Card Arrived")
		println 'cardsArrivedList='+cardsArrivedList
		def cardsArrivedListTotal
		[cardsArrivedList: cardsArrivedList, cardsArrivedListTotal: cardsArrivedList.size()]
    	}
    }

    def cardsDeliveredList() {
        if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
        {
		def login = springSecurityService.principal.username
		println "Loggedin user: "+login
		def individual = Individual.findByLoginid(login)
		println "setSessionParams for: "+individual

		def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
		println 'pcRole='+pcRole
		def patronCareHead, patronCareSevaks = []
		def individualInstanceList = [], individualRels = []
		def cultivatedByRelation = Relation.findByName("Cultivated by")
		
		def sevakOfRelation = Relation.findByName("Sevak of")
		def cardsDeliveredList = [], lifePatronListPC = [], lifePatronListPCSevak = []

		for(int i=0; i<pcRole.size(); i++)
		{
			if(pcRole[i].toString() == "PatronCare")
			{
				patronCareSevaks = Relationship.findAllWhere(individual2:individual, relation:sevakOfRelation, status:"ACTIVE").individual1		
				lifePatronListPC = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(Individual.get(session.individualid),"Card Delivered")
				//println 'lifePatronListPC='+lifePatronListPC
				for(int j=0; j<lifePatronListPC.size(); j++)
					cardsDeliveredList.add(lifePatronListPC[j])
				for(int j=0; j<patronCareSevaks.size(); j++)
				{
					lifePatronListPCSevak = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(patronCareSevaks[j],"Card Delivered")
					//println 'lifePatronListPCSevak='+lifePatronListPCSevak
					for(int k=0; k<lifePatronListPCSevak.size(); k++)
						cardsDeliveredList.add(lifePatronListPCSevak[k])
					//println 'cardsDeliveredList='+cardsDeliveredList
				}
			}
			if(pcRole[i].toString() == "PatronCareSevak")
				cardsDeliveredList = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(Individual.get(session.individualid),"Card Delivered")		
		}
        	/////////////////////////
        	println 'patroncare'
        	println 'Welcome, '+Individual.get(session.individualid)
        	//lifePatronList = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(Individual.get(session.individualid),"Card Delivered")
        	//println 'lifePatronList='+lifePatronList
        	//[lifeMembershipCardInstanceList: lifePatronList, lifeMembershipCardInstanceTotal: lifePatronList.size()]
		println 'cardsDeliveredList='+cardsDeliveredList
		def cardsDeliveredListTotal
		[cardsDeliveredList: cardsDeliveredList, cardsDeliveredListTotal: cardsDeliveredList.size()]
        	
        }
    	else
    	{
		println 'cardsDeliveredList params:'+params
		def cardsDeliveredList
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifNotGranted('ROLE_PATRONCARE'))
			cardsDeliveredList = LifeMembershipCard.findAllByCardStatus("Card Delivered")
		else
			cardsDeliveredList = LifeMembershipCard.findAllByCardStatusAndOriginatingDeptCollector("Card Delivered",Individual.get(session.individualid))
		println 'cardsDeliveredList='+cardsDeliveredList
		def cardsDeliveredListTotal
		[cardsDeliveredList: cardsDeliveredList, cardsDeliveredListTotal: cardsDeliveredList.size()]
    	}
    }
    
    def markAsCardsDelivered() {
    	println 'markAsCardsDelivered params:'+params
    	def lifePatronCardIdsList = [], cardIdsList = [], flgNotUpdated = 0
       	
        lifePatronCardIdsList = params.lifePatronCardIds.split(",")
        println 'lifePatronCardIdsList='+lifePatronCardIdsList
        params.cardStatus = "Card Delivered"
        //def now = new Date()
        params.dateCardDelivery = new Date()
    	for(int i=0; i<lifePatronCardIdsList.size(); i++)
    	{
    		if(lifePatronCardIdsList[i])
    		{
			cardIdsList[i] = LifeMembershipCard.get(lifePatronCardIdsList[i])
			cardIdsList[i].properties = params

			if (!cardIdsList[i].save(flush: true)) {
			    //flash.message = message(code: 'default.not.found.message', args: [message(code: 'lifeMembershipCard.label', default: 'LifeMembershipCard'), lifePatronCardIdsList[i]])
			    flgNotUpdated = 1
			}
		}
        }
    	
    	if(flgNotUpdated == 1)
    	{
    		redirect(action: "list")
		return
    	}
    	else
    	{
		if(lifePatronCardIdsList.size()>0)
			flash.message = message(code: 'default.updated.message', args: [message(code: 'lifeMembershipCard.label', default: 'LifeMembershipCard'), [lifePatronCardIdsList]])
		
		
		for(int i=0; i<lifePatronCardIdsList.size(); i++)
		{

			/*lifeMembers = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(patronCareCollectorsList[i],"Card Arrived").lifeMember
			println 'lifeMembers='+lifeMembers*/
			
			def emailIds = EmailContact.findAllByIndividual(LifeMembershipCard.get(lifePatronCardIdsList[i]).lifeMember)
			println "emailIds="+emailIds
			def mailIds = [], j
			if(emailIds)
			{
				for(j=0; j<emailIds.size(); j++)
					mailIds.add(emailIds[j].emailAddress)

				println "mailIds="+mailIds

				def mailBody = 'Dear '+LifeMembershipCard.get(lifePatronCardIdsList[i]).lifeMember+', \nHare Krishna! \n\nYour Life Patron Card has arrived. Please collect it. \n\n--ISKCON NVCC.' 
				sendMail {     
				  to mailIds
				  subject "Life Patron Card Arrival"     
				  body mailBody
				}   
			}

			def phoneNos = VoiceContact.findAllByIndividualAndCategory(LifeMembershipCard.get(lifePatronCardIdsList[i]).lifeMember, "CellPhone")
			println "phoneNos="+phoneNos
			def cellNos = ""

			if(phoneNos)
			{
				for(j=0; j<phoneNos.size(); j++)
				{
					cellNos = cellNos + "," + (phoneNos[j].number).toString()
					println "cellNos="+cellNos

				}
			}
			if (cellNos[0..0] == ",")
				cellNos = cellNos[1..-1]
			def lifeMemberName = (LifeMembershipCard.get(lifePatronCardIdsList[i]).lifeMember).toString().replace(" ","%20")
			housekeepingService.sendSMS(cellNos,'Dear%20'+lifeMemberName+',%20Hare%20Krishna!%20Your%20Life%20Patron%20Card%20has%20arrived.%20Please%20collect%20it.%20-ISKCON%20NVCC')
		}			
    	}

    	println 'cardIdsList='+cardIdsList
    	redirect(action: "list")
    }    
}