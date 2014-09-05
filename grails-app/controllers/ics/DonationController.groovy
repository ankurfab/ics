package ics
import groovy.sql.Sql;
import grails.converters.JSON

class DonationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def individualService
    def donationService
    def housekeepingService
    def springSecurityService
    def receiptSequenceService
    def dataSource ; 

def testDatePicker = {
    }
    
    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 15, 100)
	if(!params.sort)
		params.sort = "id" //"donationDate"
	if(!params.order)
		params.order = "desc"
			
        if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
        {
		/*def pcRole = IndividualRole.findAllByIndividualAndStatus(Individual.get(session.individualid),"VALID").role
		println 'pcRole='+pcRole
		def patronCareHead
		
		for(int i=0; i<pcRole.size(); i++)
		{
			if(pcRole[i].toString() == "PatronCare")
			{
				def login = springSecurityService.principal.username
				println "Loggedin user: "+login
				def individual = Individual.findByLoginid(login)
				println "setSessionParams for: "+individual

				//patronCareHead = Individual.get(session.individualid)
				patronCareHead = individual
				break
			}
			if(pcRole[i].toString() == "PatronCareSevak")
			{
				def sevakOfRelation = Relation.findByName("Sevak of")
				patronCareHead = Relationship.findWhere(individual1:Individual.get(session.individualid), relation:sevakOfRelation, status:"ACTIVE").individual2		
				break
			}			
		}
		println 'patronCareHead='+patronCareHead
		def individualInstanceList = [], individualRels = []
		def cultivatedByRelation = Relation.findByName("Cultivated by")
		individualRels = Relationship.findAllWhere(individual2:patronCareHead, relation:cultivatedByRelation, status:"ACTIVE")
		for(int i=0; i<individualRels.size(); i++)
		{
			individualInstanceList[i] = individualRels[i].individual1
		}
		//println 'individualRels='+individualRels
		//println 'individualInstanceList='+individualInstanceList
        	*/
		def login = springSecurityService.principal.username
		println "Loggedin user: "+login
		def individual = Individual.findByLoginid(login)
		println "setSessionParams for: "+individual
	
		def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
		println 'pcRole='+pcRole
		def patronCareHead, patronCareSevaks = []
		def individualInstanceList = [], individualRels = []
		def cultivatedByRelation = Relation.findByName("Cultivated by")
		
		for(int i=0; i<pcRole.size(); i++)
		{
			if(pcRole[i].toString() == "PatronCare")
			{
				individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
				for(int j=0; j<individualRels.size(); j++)
				{
					individualInstanceList[j] = individualRels[j].individual1
				}

				def sevakOfRelation = Relation.findByName("Sevak of")
				patronCareSevaks = Relationship.findAllWhere(individual2:individual, relation:sevakOfRelation, status:"ACTIVE").individual1		
				for(int j=0; j<patronCareSevaks.size(); j++)
				{
					individualRels = Relationship.findAllWhere(individual2:patronCareSevaks[j], relation:cultivatedByRelation, status:"ACTIVE")
					for(int k=0; k<individualRels.size(); k++)
					{
						println 'k='+k
						println 'individualRels[k]='+individualRels[k]
						println 'individualRels[k].individual1='+individualRels[k].individual1
						individualInstanceList.add(individualRels[k].individual1)
					}
				}
			}
			if(pcRole[i].toString() == "PatronCareSevak")
			{
				individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
				for(int j=0; j<individualRels.size(); j++)
				{
					individualInstanceList[j] = individualRels[j].individual1
				}
			}			
		}
		
		individualInstanceList = individualInstanceList.unique()
        	
        	def donationsList = [], donationInstanceList = []
        	
        	for(int i=0; i<individualInstanceList.size(); i++)
        	{
        		donationsList[i] = Donation.findAllByDonatedBy(individualInstanceList[i])
        		for(int j=0; j<donationsList[i].size(); j++)
        			donationInstanceList.add(donationsList[i][j])

        	}
        	donationInstanceList = donationInstanceList.sort{ it.fundReceiptDate }
        	//def donationInstanceList = Donation.findAllByDonatedBy(individualInstanceList)
        	[donationInstanceList: donationInstanceList, donationInstanceTotal: donationInstanceList.size()]
        }
        else
        {

		[donationInstanceList: Donation.list(params), donationInstanceTotal: Donation.count()]
        }
    }

    def create = {
        def donationInstance = new Donation()
        donationInstance.properties = params
        return [donationInstance: donationInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def donationInstance = new Donation(params)
        if (donationInstance.save(flush: true)) {
            //mark the receipt and the receipt book as not blank---TODO later
            //housekeepingService.markNotBlank(donationInstance.id)
            //send SMS
            def phonenos = housekeepingService.getphonenos(donationInstance.donatedBy)
            println "Phones nos of the donor are: " + phonenos
            if(phonenos)
		    housekeepingService.sendSMS(phonenos,"Thank you for donating for the glorious NVCC project! Hare Krishna!!")

	    //TODO: send email to the cost center owner
	    
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'donation.label', default: 'Donation'), donationInstance.id])}"
            redirect(action: "show", id: donationInstance.id)
        }
        else {
            render(view: "create", model: [donationInstance: donationInstance])
        }
    }

    def show = {
        def donationInstance = Donation.get(params.id)
        if (!donationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'donation.label', default: 'Donation'), params.id])}"
            redirect(action: "list")
        }
        else {
            [donationInstance: donationInstance]
        }
    }

    def edit = {
        def donationInstance = Donation.get(params.id)
        
        	def role = Role.findByName("Receiver")
        	def c = Individual.createCriteria()
		//show all recepients
		def receivers = c.list
		{
		individualRoles
			{
				and
				{
					eq("role",role)
					eq("status", "VALID")
				}
			}
			order("initiatedName", "asc")
			order("legalName", "asc")
		}


	//get the  list of collectors, TODO should be automatically driven from receipt book
        	def crole = Role.findByName("Collector")
        	def cr = Individual.createCriteria()
        	def collectors = cr.list
		{
		individualRoles
			{
				and
				{
					eq("role",crole)
					eq("status", "VALID")
				}
			}
			order("initiatedName", "asc")
			order("legalName", "asc")
		}
        if (!donationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'donation.label', default: 'Donation'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [donationInstance: donationInstance, receivers:receivers, collectors:collectors]
        }
    }

    def update = {
    	println "Params in update donation: "+params
	println 'params.chequeNo='+params.chequeNo    	
        def donationInstance = Donation.get(params.id)
        if (donationInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (donationInstance.version > version) {
                    
                    donationInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'donation.label', default: 'Donation')] as Object[], "Another user has updated this Donation while you were editing")
                    render(view: "edit", model: [donationInstance: donationInstance])
                    return
                }
            }

	/*if(params.acDonatedBy_id)
	{
            def donor = Individual.get(params.acDonatedBy_id)
            donationInstance.donatedBy = donor
        }    */
        
	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAllGranted('ROLE_NVCC_ADMIN'))
	{
		if (params.DonorChkBox)
		{
			if (params.DonorChkBox.value.toString()=="on")
			{
				params."donatedBy.id"= params."h_donatedBy.id"
				params.donatedBy = Individual.get(params."h_donatedBy.id")
			}
			else
			{
				if(!params."acDonatedBy_id")
				{
					flash.message = "Donor Name Not Entered!"
					render(view: "edit", model: [donationInstance: donationInstance])
					return [donationInstance: donationInstance]
				}
				else
					params.donatedBy = Individual.get(params."acDonatedBy_id")
			}
		}
		else
		{
			//println 'NO CHECKBOX'
			if(!params."acDonatedBy_id")
			{
				flash.message = "Donor Name Not Entered!"
				render(view: "edit", model: [donationInstance: donationInstance])
				return [donationInstance: donationInstance] 
			}
			else
				params.donatedBy = Individual.get(params."acDonatedBy_id")

		}
	}
          
      	if(params."acCollector_id")
      		params."collectedBy.id"= params."acCollector_id"
      	else
      	{
        	def role = Role.findByName("Receiver")
        	def c = Individual.createCriteria()
		//show all recepients
		def receivers = c.list
		{
		individualRoles
			{
				and
				{
					eq("role",role)
					eq("status", "VALID")
				}
			}
			order("initiatedName", "asc")
			order("legalName", "asc")
		}

		if (params.CollectorChkBox)
		{
			if (params.CollectorChkBox.value.toString()=="on")
      				params."collectedBy.id"= params.h_collectedBy.id
      			else
      			{
      				flash.message = "Collector Name Not Entered!"
      				render(view: "edit", model: [donationInstance: donationInstance, receivers: receivers])
      				return [donationInstance: donationInstance, receivers: receivers]
      			}
      		}
      		else
      		{
      			//println 'NO CHECKBOX'
      			flash.message = "Collector Name Not Entered!"
      			render(view: "edit", model: [donationInstance: donationInstance, receivers: receivers])
      			return [donationInstance: donationInstance, receivers: receivers] 
      		}
      	}	
        
        println 'COLLECTOR: '+params."collectedBy.id"
        
	/*if(params.accountsReceiptNo)
		params.chequeNo =  params.accountsReceiptNo
        */
        println 'mode='+PaymentMode.get(params."mode.id")
        if(PaymentMode.get(params."mode.id").toString()=="Cheque")
        {
		if(params.chequeDate)
			params.chequeDate = Date.parse('dd-MM-yyyy', params.chequeDate)
		if(params.chequeNo)
			params.chequeNo =  params.chequeNo
		println 'mode params.chequeNo='+params.chequeNo
	}
	if(params.chequeDepositDate)
		params.chequeDepositDate = Date.parse('dd-MM-yyyy', params.chequeDepositDate)
	if(params.donationDate)
		params.donationDate = Date.parse('dd-MM-yyyy', params.donationDate)
	if(params.fundReceiptDate)
		params.fundReceiptDate = Date.parse('dd-MM-yyyy', params.fundReceiptDate)
        if(PaymentMode.get(params."mode.id").toString()=="DemandDraft")
        {
		if(params.demandDraftDate)
			params.chequeDate = Date.parse('dd-MM-yyyy', params.demandDraftDate)
		if(params.demandDraftNo)
			params.chequeNo =  params.demandDraftNo
	}
        if(PaymentMode.get(params."mode.id").toString()=="Bank-NetBanking" || PaymentMode.get(params."mode.id").toString()=="Web-NetBanking")
        {
		if(params.transferDate)
			params.chequeDate = Date.parse('dd-MM-yyyy', params.transferDate)		
	}
        println 'params.chequeDate='+params.chequeDate    
            
	println 'params.chequeNo='+params.chequeNo
	if(params.demandDraftBankName)
		params.bankName =  params.demandDraftBankName
	if(params.netbankingBankName)
	{
		params.bankName =  params.netbankingBankName
		if(params.netbankingBankName == "SBI")
			params.bankBranch = "ISKCON - NVCC" 
		if(params.netbankingBankName == "ICICI")
			params.bankBranch = "ISKCON - PUNE"
	}
	if(params.demandDraftBankBranch)
		params.bankBranch =  params.demandDraftBankBranch
	
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"
            donationInstance.properties = params

	if(params.resetStatus)
		donationInstance.status = null
	if(params.bankDetailsFlag=="false")
	{
		//reset
		donationInstance.bank = null
		donationInstance.chequeDate = null
		donationInstance.chequeNo = null
	}

	println 'donationInstance='+donationInstance
	println 'donationInstance.chequeNo='+donationInstance.chequeNo
	
	//update donationReceipt
	if(donationInstance.nvccReceiptBookNo && donationInstance.nvccReceiptNo)
		{
		def rcpt = Receipt.findByReceiptNumber(donationInstance.nvccReceiptNo)
		if(rcpt && donationInstance.donationReceipt != rcpt)
			{
			log.debug("Updating donation receipt! old: "+donationInstance.donationReceipt+" new: "+rcpt)
			donationInstance.donationReceipt = rcpt
			}
		}
	
            if (!donationInstance.hasErrors() && donationInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'donation.label', default: 'Donation'), donationInstance.id])}"
                redirect(action: "show", id: donationInstance.id)
            }
            else {
                render(view: "edit", model: [donationInstance: donationInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'donation.label', default: 'Donation'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def donationInstance = Donation.get(params.id)
        if (donationInstance) {
            try {
                donationInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'donation.label', default: 'Donation'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'donation.label', default: 'Donation'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'donation.label', default: 'Donation'), params.id])}"
            redirect(action: "list")
        }
    }
    
    def searchByChequeNo = {
    def donationInstance  = Donation.findByChequeNo(params.name)
        if (donationInstance)
            redirect(action: "show", id:donationInstance?.id)
        else
        {
		flash.message = "Cheque no. "+params.name+" not found!!"
		redirect(uri:"/searchCheque.gsp")
	}
        
    }
    
    def showChequesDue = {
	def now = new Date()
	now.clearTime()
	
	def sql = new Sql(dataSource);
	def query = 'select max(ack_date) ad from denomination where ack_ref is not null'
	def result = sql.firstRow(query)
	
	println "Result: "+ result
	
	def last = new Date()
	if(result?.ad)
		last = result?.ad
	else
		last = last -30
		
	last.clearTime()
	
	println last 
	println now
	
    	def donationDueNowList = Donation.findAllByChequeDateBetweenAndChequeDepositDateIsNull(last,now,[sort:"amount",order:"desc"])
    	def donationDueNowRevisedList = Donation.findAllByChequeDepositDateBetween(last,now,[sort:"amount",order:"desc"])
    	def pdcList = Pdc.findAllByChequeDateBetweenAndStatusNotEqual(last,now,'SUBMITTED',[sort:"amount",order:"desc"])
        [now: now, last: last, donationDueNowList: donationDueNowList, donationDueNowRevisedList : donationDueNowRevisedList, pdcList:pdcList ]
    }
    
    def dummydonation = {
	/*def catc = ReceiptBook.createCriteria()
	def category = catc.list { projections { 
		//distinct("category") 
		 distinct 'category', 'cat'}
		 order 'cat'
		 }*/
	//first time only
	if(session.isReceiver==null)
	{
		//set whether receiver
		def individual = Individual.get(session.individualid)
		def flag=false
		individual?.individualRoles?.each{if (it.role.name == "Receiver") flag=true}
		if(flag)
			session.isReceiver = true
		else
			session.isReceiver = false

		println "isReceiver: "+session.isReceiver
	}		


	/*if(!session.isReceiver)
	{

	    flash.message = (session.individualname?:"You")+" not a Receiver. Please contact Admin to get the role.!!"
	    redirect(action: "list")
	}*/

	def role = Role.findByName("Receiver")
	def c = Individual.createCriteria()
	//show all recepients
	def recepients = c.list
	{
	individualRoles
		{
			and
			{
				eq("role",role)
				eq("status", "VALID")
			}
		}
		order("initiatedName", "asc")
		order("legalName", "asc")
	}

//get the  list of collectors, TODO should be automatically driven from receipt book
        	def crole = Role.findByName("Collector")
        	def cr = Individual.createCriteria()
        	def collectors = cr.list
		{
			individualRoles
			{
				and
				{
					eq("role",crole)
					eq("status", "VALID")
				}
			}
			//order("initiatedName", "asc")
			order("legalName", "asc")
		}

        def donationInstance = new Donation()
        donationInstance.properties = params
        return [donationInstance: donationInstance, recepients: recepients, collectors: collectors]
}

    def savedummydonation = {
    	println '------------savedummydonation------------'
    	println "Inside savedummydonation!! Params:\n"
    	println params
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

      	/* using dummy receipt for the time being
      	params."donationReceipt.id"= params."acDonationReceipt_id"*/
      	params."donationReceipt.id"= 1
    	//params."scheme.id"= params."acScheme_id"
      	/* using dummy collector for the time being*/
      	
      	//def donationInstance1 = new Donation(params)
    			
    	def i
	def role = Role.findByName("Receiver")
	def c = Individual.createCriteria()
	//show all recepients
	def recepients = c.list
	{
		individualRoles
		{
			and
			{
				eq("role",role)
				eq("status", "VALID")
			}
		}
		order("initiatedName", "asc")
		order("legalName", "asc")
	}

    	role = Role.findByName("Collector")
    	c = Individual.createCriteria()
    	def collectors = c.list
    	{
    		individualRoles
    		{
			and
			{
				eq("role",role)
				eq("status", "VALID")
			}
    		}
		order("initiatedName", "asc")
    		order("legalName", "asc")
    	}
    	
      	if(params."acCollector_id")
      	{
      		//println 'acCollector_id='+params."acCollector_id"
      		params."collectedBy.id"= params."acCollector_id"
      	}
      	else
      	{
      		if (params.CollectorChkBox)
      		{
      			
			if (params.CollectorChkBox.value.toString()=="on")
			
      				params."collectedBy.id"= params.h_collectedBy.id
      			
      			else
      			{
      				flash.message = "Collector Name Not Entered!"
      				render(view: "dummydonation", model: [donationInstance: donationInstance, recepients: recepients])
      				return
      			}
      			
      		}
      		else
      		{
      			println 'NO CHECKBOX'
      			flash.message = "Collector Name Not Entered!"
      			render(view: "dummydonation", model: [donationInstance: donationInstance, recepients: recepients])
      			return 
      		}
      	}	
    
	//set collector
    	//params."collectedBy.id"= params."acCollector_id"

    	//set receiver
    	if(params.receiverid)
    		params."receivedBy.id"= params.receiverid
    	else
    		if(session.isReceiver)
    		    		params."receivedBy.id"= session.individualid

	
	//get payment mode
	/*def m = ''
	if (params.channel == 'Complementary' || params.channel == 'Kind')
		m= params.channel
	else
		m=params.channel+'-'+params.type
		
	println "Payment mode:"+m
	
	def fm = PaymentMode.findByName(m)
	
	params."mode.id" = fm?.id*/
	
	//handle cmpl receipts
	//if (params.channel == 'Complementary')
	if (PaymentMode.get(params."mode.id")?.name == 'Complementary')
	{
		params.nvccReceiptBookNo = 'CMPL'
		params.nvccReceiptNo = "CMPL-"+housekeepingService.getNextCMPLRcptNo()
		println "generated cmpl id:"+params.nvccReceiptBookNo
	}
	
	def donorContactForSMS, donorEmailForEmail
	
	//create actual donor
	if(params.dummy=="Actual")
	{
	///////////////////////////////////////////////////////////////verify why individual is getting created even when selected from ajax
		params."donatedBy.id"= params."acIndividual_id"
		println "params.'acIndividual_id'="+params."acIndividual_id"
		params.donorName = params.acIndividual
		def ind = Individual.get(params."donatedBy.id")
		println "ind="+ind
		donorContactForSMS = VoiceContact.findAllByIndividualAndCategory(Individual.get(params."donatedBy.id"), "CellPhone")
		donorEmailForEmail = EmailContact.findAllByIndividual(Individual.get(params."donatedBy.id"))
		println "donorContactForSMS="+donorContactForSMS
		println "donorEmailForEmail="+donorEmailForEmail
		
		if (!ind)
		{
			//create new ind
			//def newind = new Individual(legalName:params.acIndividual,isWellWisher:false,remarks:"Added from donation!",creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
			//modified after adding the isDonor flag
			def newind = new Individual(legalName:params.acIndividual,isDonor:true,remarks:"Added from donation!",creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
			newind.save(flush:true)
			params."donatedBy.id"= newind.id
			
			def city = City.findByName('Other')
			def state = State.findByName('Other')
			def country = Country.findByName('Other')
			def address = new Address(addressLine1:params.acAddress,individual:newind,city:city,state:state,country:country,category:'auto created',pincode:'',creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
			def flag = address.save(flush:true)
			
			def i1 = Individual.get(newind.id)
			println "saved individual" + i1
		}
		
		/*def schmMem = SchemeMember.findBySchemeAndMember(Scheme.get(params."scheme.id"),ind)
		println 'schmMem='+schmMem
		if(!schmMem)
		{
			println 'not sm'
			params.scheme = Scheme.get(params."scheme.id")
			params.member = ind
			
			if (params.installment)
			{
				if (params.installment.value.toString()=="on")
					params.installment= true
				else
					params.installment= false
			}
			
			else
				params.installment= true
			
			def schemeMemberInstance = new SchemeMember(params)
			schemeMemberInstance.save(flush: true)			
		}*/
	}
	else if(params.donorid)
	params."donatedBy.id"= params.donorid
	else
	{
		def donor = null
		//try to find the donor, if not found then create new donor
		//donor = housekeepingService.findOrCreateIndividual(params.donorName,params.donorPAN,params.donorContact,params.donorEmail,params.donorAddress)
		if(!donor)
		{
			//dummy donor
			donor = Individual.findByLegalName('Dummy Donor for daily transactions')
		}
		params."donatedBy.id" = donor.id
	}
	println 'transferDate: '+params.transferDate
	if(params.chequeDate)
		params.chequeDate = Date.parse('dd-MM-yyyy', params.chequeDate)
	if(params.demandDraftDate)
		params.chequeDate = Date.parse('dd-MM-yyyy', params.demandDraftDate)
	if(params.transferDate)
		params.chequeDate = Date.parse('dd-MM-yyyy', params.transferDate)		
	if(params.chequeDepositDate)
		params.chequeDepositDate = Date.parse('dd-MM-yyyy', params.chequeDepositDate)
	if(params.fundReceiptDate)
		params.fundReceiptDate = Date.parse('dd-MM-yyyy', params.fundReceiptDate)
	if(params.donationDate)
		params.donationDate = Date.parse('dd-MM-yyyy', params.donationDate)
	else
		params.donationDate = params.fundReceiptDate?:new Date()
		
		println 'fundReceiptDate: '+params.fundReceiptDate
		
	println 'chequeDate: '+params.chequeDate
	
	println 'netbankingBankName: '+params.netbankingBankName
	
	if(params.demandDraftNo)
		params.chequeNo =  params.demandDraftNo
	if(params.accountsReceiptNo)
		params.chequeNo =  params.accountsReceiptNo
	if(params.demandDraftBankName)
		params.bankName =  params.demandDraftBankName
	if(params.netbankingBankName)
	{
		params.bankName =  params.netbankingBankName
		if(params.netbankingBankName == "SBI")
			params.bankBranch = "ISKCON - NVCC" 
		if(params.netbankingBankName == "ICICI")
			params.bankBranch = "ISKCON - PUNE"
	}
	if(params.demandDraftBankBranch)
		params.bankBranch =  params.demandDraftBankBranch
	
	println 'params.bankName: '+params.bankName
	println 'params.bankDetailsFlag: '+params.bankDetailsFlag
	if(params.bankDetailsFlag=="false")
	{
		//reset params
		//params."bank.id"=""
		params."bankName"=""
		params."c_bankName"=""
		params."chequeDate_day"=""
		params."chequeDate_month"=""
		params."chequeDate_year"=""
		params."chequeDate"=""
		params."chequeNo"=""
	}
    	println "created individual"+params."donatedBy.id"

        //upper of rb/rno
        params.nvccReceiptBookNo = params.nvccReceiptBookNo?.toUpperCase()
        params.nvccReceiptNo = params.nvccReceiptNo?.toUpperCase()
		println 'params='+params

		
        def donationInstance = new Donation(params)
        println "donation instance"+donationInstance
        
        //check for validness of rb/rno
        String rb = params.nvccReceiptBookNo
        String rno = params.nvccReceiptNo
        def dupFlag = housekeepingService.checkUniqueRcptNo(rb,rno)
        println "Is Unique?"+dupFlag
	
	if(!dupFlag)
	{
		
		flash.message = "Duplicate Receipt Book/Receipt No entered:"+rb+"/"+rno
		render(view: "dummydonation", model: [donationInstance: donationInstance, recepients:recepients, collectors:collectors, donormobile:params.donormobile])
		return
	}
	
        /*def validFlag = housekeepingService.checkValidRcptNo(rb,rno)
        println "Is Valid?"+validFlag
	if(!validFlag)
	{	
		flash.message = "Invalid Receipt Book/Receipt No entered:"+rb+"/"+rno
		render(view: "dummydonation", model: [donationInstance: donationInstance, recepients:recepients, collectors:collectors, donormobile:params.donormobile])
		return
	}*/
		
			
	def recpt = Receipt.findByReceiptNumber( params.nvccReceiptNo?.toUpperCase())

	donationInstance.donationReceipt = recpt
	if(params.donormobile)
		donationInstance.donorContact = params.donormobile
		
        if (donationInstance.save(flush: true)) {
            // disable for now
            //mark the receipt and the receipt book as not blank
            //housekeepingService.markNotBlank(donationInstance.id)
            def cellNos1
            
		if(params.donorContact)
			donorContactForSMS = params.donorContact
		
		println "donorContactForSMS="+donorContactForSMS
		
		if(donorContactForSMS)
		{
			def phoneNos = donorContactForSMS
			println "phoneNos="+phoneNos
			def cellNos = ""

			if(phoneNos)
			{
			
				if(params.donorContact)
				{
					cellNos1 = phoneNos.split(",")
				}
				else
				{
				
					for(i=0; i<phoneNos.size(); i++)
					{
						cellNos = cellNos + "," + (phoneNos[i].number).toString()
						println "cellNos="+cellNos

					}

					cellNos1 = cellNos.split(",")
				}
				
				for(i=0; i<cellNos1.size(); i++)
				{
					cellNos = cellNos + "," + (cellNos1[i]).toString()
					println "cellNos="+cellNos

				}
			}
			
			if (cellNos[0..0] == ",")
				cellNos = cellNos[1..-1]

				
			def donorNameForSMS = (params.donorName).toString().replace(" ","%20")
			housekeepingService.sendSMS(cellNos,'Dear%20'+donorNameForSMS+',%20Hare%20Krishna!%20Thank%20you%20for%20the%20donation%20of%20Rs'+params.amount+'.%20May%20Lord%20Krishna%20shower%20His%20choicest%20blessings%20upon%20you.%20ISKCON%20Pune')
			//housekeepingService.sendSMS(cellNos,'Thanks%Afor%20donation')
		}

		if(params.donorEmail)
			donorEmailForEmail = params.donorEmail
		
		println "donorEmailForEmail="+donorEmailForEmail
		if(donorEmailForEmail)
		{
			def emailIds = donorEmailForEmail
			println "emailIds="+emailIds

			def mailIds = []

			if(emailIds)
			{

				if(params.donorEmail)
					mailIds = emailIds.split(",")
				else
				{
					for(i=0; i<emailIds.size(); i++)
						mailIds.add(emailIds[i].emailAddress)
				}

				println "mailIds="+mailIds

				def mailBody = 'Dear '+params.donorName+', \nHare Krishna! \n\nThank you for the donation of Rs. '+params.amount+'. May the Lord shower His choicest blessings upon you. \n\n--ISKCON NVCC.' 
				try{
					sendMail {     
					  to mailIds
					  subject "Thank you for the Donation."     
					  body mailBody
				}   
				}catch(e){log.debug("Error in sending email while saving dummy donation: "+e)}
			}		
		}
		
            /*if(params.donormobile)
            	{
		    //store the mobile no supplied as 'OtherContact'
		    def oc = new OtherContact()
		    oc.individual = donationInstance.donatedBy
		    oc.category = donationInstance.id
		    oc.contactType = "MobileNo"
		    oc.contactValue = params.donormobile
		    oc.creator = springSecurityService.principal.username
		    oc.updator = springSecurityService.principal.username
		    
        
	            //send SMS

		    //housekeepingService.sendSMS(params.donormobile,"Thank you for donating for the glorious NVCC project! Hare Krishna!!")
		}*/

            flash.message = "${message(code: 'default.created.message', args: [message(code: 'donation.label', default: 'Donation'), donationInstance.id])}"
            //redirect(action: "show", id: donationInstance.id)
            def newDI = new Donation()
            newDI.nvccReceiptBookNo = donationInstance.nvccReceiptBookNo
            newDI.nvccReceiptNo = donationInstance.nvccReceiptNo
            /*TODO: shoule be autopopulated from rb/rno
            newDI.collectedBy = donationInstance.collectedBy*/
		newDI.id = donationInstance.id
		newDI.receivedBy = donationInstance.receivedBy
		newDI.collectedBy = donationInstance.collectedBy
		newDI.donationDate = donationInstance.donationDate
		newDI.fundReceiptDate = donationInstance.fundReceiptDate
            //render(view: "dummydonation", model: [donationInstance: newDI, recepients:recepients, collectors:collectors])
            redirect(action: "matchdummydonor", id:donationInstance?.id) 
        }
        else {
            render(view: "dummydonation", model: [donationInstance: donationInstance, recepients:recepients, collectors:collectors, donormobile:params.donormobile])
        }
    }

	def bulkdonation0 = {
		
    	println '------------bulkdonation0------------'
	if(session.isReceiver==null)
	{
		//set whether receiver
		def individual = Individual.get(session.individualid)
		def flag=false
		individual?.individualRoles?.each{if (it.role.name == "Receiver") flag=true} //todo: should check for status
		if(flag)
			session.isReceiver = true
		else
			session.isReceiver = false

		//println "isReceiver: "+session.isReceiver
	}		

    	//println 'params='+params
		//def receiptBookList = ReceiptBook.findAllByStatus("Issued",[sort:"bookSerialNumber",order:"asc"])
		//def receiptBookList = ReceiptBook.getAll()
		//println 'receiptBookList='+receiptBookList
		//return [receiptBookList: receiptBookList]
	}
	
	def bulkdonation1 = {
		
    	println '------------bulkdonation1------------'
    	println 'params='+params
    	
    	//def receiptBook = ReceiptBook.get(params."receiptBook.id")
    	if(!params.rbno)
    	{
    		flash.message = "Please specify the receipt book no for e.g. A1234"
    		redirect(action:"bulkdonation0")
    	}
    	def rbseries = params.rbno.substring(0,1)
    	def rbno = params.rbno.substring(1,params.rbno.size())
    	println rbseries + " : " + rbno
    	def receiptBook = ReceiptBook.findByBookSeriesAndBookSerialNumber(rbseries,rbno)
    	if(!receiptBook)
    	{
    		flash.message = "Please specify a valid receipt book no for e.g. A1234"
    		redirect(action:"bulkdonation0")
    	}
    		
    	println "Found RB : "+ receiptBook
    	//todo: what is the status of a issued rb?
    	//def rbIssued = ReceiptBookIssued.findByReceiptBookAndStatus(receiptBook,'Issued')
    	def rbIssued = ReceiptBookIssued.findByReceiptBook(receiptBook)
   	
    	
    	def donations = new Object[receiptBook.numPages]
    	def collector = []
    	def isBlank = true
		def rcpts = receiptBook.receipts.sort{ it.id }
		rcpts.eachWithIndex{ item, pos ->
 		println 'item='+item
 		def r = item
 		def donation = Donation.findWhere(donationReceipt:r)
 		println 'donation='+donation
 		if (donation)
 			{
 			
 			donations[pos]=donation
 			isBlank = false
 			collector[pos] = donation.collectedBy
 			println "collector["+pos+"]="+collector[pos]
 			}
		}
	println 'donations='+donations
	
	
	/*def crole = Role.findByName("Collector")
	def cr = Individual.createCriteria()
	def collectors = cr.list
	{
		individualRoles
		{
			and
			{
				eq("role",crole)
				eq("status", "VALID")
			}
		}
		order("initiatedName", "asc")
		order("legalName", "asc")
	}
	//println 'collectors='+collectors.legalName
	def collectors_legalName=[], collectors_initiatedName=[]
	for(int i=0; i<collectors.size(); i++)
	{
		collectors_legalName[i] = collectors.legalName[i] + " (" + collectors.initiatedName[i] +")"
		collectors_initiatedName[i] = collectors.initiatedName[i] + " (" + collectors.legalName[i] +")"
		println 'collectors_legalName='+collectors_legalName[i]
		println 'collectors_initiatedName='+collectors_initiatedName[i]
	}*/
	
	println "rbIssued?.issuedTo="+rbIssued?.issuedTo
	return [receiptBook: receiptBook, rbIssued: rbIssued, donations: donations, isBlank : isBlank, collector: collector]
	}
	
	def savebulkdonation = {
		println '------------savebulkdonation------------'
		println 'params='+params
		def receiptBook = ReceiptBook.get(params.rbid)
		println 'receiptBook='+receiptBook
    	
    		def rcpts = receiptBook.receipts.sort{ it.id }
		println "rcpts="+rcpts
		//common parameters
		def donor = null
		def dummydonor = Individual.findByLegalName('Dummy Donor for daily transactions')
		params."donatedBy.id" =  dummydonor.id
		//params."collectedBy.id" = collector.id
    	
		def login = springSecurityService.principal.username
		println "Loggedin user: "+login
		def individual = Individual.findByLoginid(login)
		println "setSessionParams for: "+individual
		
		params."receivedBy.id" = individual.id //session.individualid
		//params.fundReceiptDate = new Date()
		def modeCash = PaymentMode.findByName("Cash")
		def modeCheque = PaymentMode.findByName("Cheque")

		def donorNameForSMS, emailIds, mailBody, phoneNos, donorContactForSMS, i	
		def mailIds = []
		def cellNos = "", cellNos1
		
		def errArr = []
		def hasErrors = false
		rcpts.eachWithIndex{ receipt, j ->
		println "---------receipt="+receipt
			println "---------j="+j
			if(params.("amount"+j))
			{
				params."donationReceipt.id" = receipt?.id
				//params."collectedBy.id" = collector.id
				println "params.('acCollector'+j+'_id')="+params.("acCollector"+j+"_id")
				println "params.(acCollector"+j+")="+params.("acCollector"+j)
				
				if (params.("CollectorChkBox"+j))
				{
					if ((params.("CollectorChkBox"+j)).value.toString()=="on")
					{
						//params."collectedBy.id"= rbIssued?.issuedTo //params.("acCollector"+j+"_id")
						//params."collectedBy_id"= params.("acCollector"+j+"_id")
						//params.collectedBy = Individual.get(params.("acCollector"+j+"_id"))
						params."collectedBy.id" = params.("h_issuedTo"+j)
						println "params.collectedBy="+params.collectedBy

					}
					else
					{
						if(!params.("acCollector"+j+"_id"))
						{
							flash.message = "Collector Name Not Entered!"
							//render(view: "bulkdonation1")
							//return [receiptBookIssuedInstance: receiptBookIssuedInstance]
						}
						else
						{
							params."collectedBy.id"= params.("acCollector"+j+"_id")
							//params."collectedBy_id"= params.("acCollector"+j+"_id")
							params.collectedBy = Individual.get(params.("acCollector"+j+"_id"))
						}
					}
				}
				else
				{
					//println 'NO CHECKBOX'
					if(!params.("acCollector"+j+"_id"))
					{
						flash.message = "Collector Name Not Entered!"
						//render(view: "bulkdonation1")
						//return [receiptBookIssuedInstance: receiptBookIssuedInstance]
					}
					else
					{
						params."collectedBy.id"= params.("acCollector"+j+"_id")
						//params."collectedBy_id"= params.("acCollector"+j+"_id")
						params.collectedBy = Individual.get(params.("acCollector"+j+"_id"))
					}
				}
				
				params.donorName = params.("donorName"+j)
				params.donorAddress = params.("donorAddress"+j)
				params.donorContact = params.("donorContact"+j)
				params.donorEmail = params.("donorEmail"+j)
				params.donorPAN = params.("donorPAN"+j)
				
				//try to find the donor, if not found then create new donor
				donor = housekeepingService.findOrCreateIndividual(params.donorName,params.donorPAN,params.donorContact,params.donorEmail,params.donorAddress)
				if(!donor)
				{
					//dummy donor
					donor = dummydonor
				}
				params."donatedBy.id" = donor.id
				
				params.amount = params.("amount"+j)
				params.currency = "INR"
				params.scheme = Scheme.get(params.("scheme.id"+j).toInteger())
				if(params.("donationDate"+j))
					params.donationDate = Date.parse('dd-MM-yyyy', params.("donationDate"+j))
				if(params.("fundReceiptDate"+j))
					params.fundReceiptDate = Date.parse('dd-MM-yyyy', params.("fundReceiptDate"+j))
					
				if(params.("comments"+j))	
					params.comments = params.("comments"+j)
			
				params.nvccReceiptBookNo = receiptBook.toString()
				params.nvccReceiptNo = receipt.receiptNumber
				println 'receiptBook=nvccReceiptBookNo='+receiptBook
				println 'receiptBook.receiptNumber=nvccReceiptNo='+receipt.receiptNumber
				println 'params.nvccReceiptBookNo='+params.nvccReceiptBookNo
				def donationInstance = new Donation(params)
				
				//println j+" : Cash or cheque ? " + params.("cash"+j)
				
				println "Payment mode:"+params."mode.id"+j

				def fm = PaymentMode.get(params.("mode.id"+j))
				donationInstance.mode = fm
				println "Payment mode:"+fm

				//params."mode.id" = fm?.id

				//if(!params.("cash"+j))
				if(fm.toString().contains("Cheque") || fm.toString().contains("DemandDraft"))
				{
					//donationInstance.mode =  modeCheque
					if(params.("chequeDate"+j))
						donationInstance.chequeDate = Date.parse('dd-MM-yyyy', params.("chequeDate"+j))
					if(params.("chequeNo"+j))	
						donationInstance.chequeNo = params.("chequeNo"+j)
					if(params.("bankName"+j))	
						donationInstance.bankName = params.("bankName"+j)//Bank.get(params.("bankName"+j))
					if(params.("c_bankName"+j))	
						donationInstance.bankName = params.("c_bankName"+j)
						
					if(params.("bankBranch"+j))	
						donationInstance.bankBranch = params.("bankBranch"+j)
						
				}
				if(fm.toString().contains("Cash"))
				{
					//donationInstance.mode = modeCash
					donationInstance.chequeDate = null
					donationInstance.chequeNo = ''
					donationInstance.bankName = ''
					//donationInstance.c_bankName = ''
					donationInstance.bankBranch = ''
				}
				if(fm.toString().contains("Card"))
				{
					donationInstance.bankBranch = params.("bankBranch"+j)
					donationInstance.chequeDate = null
					donationInstance.chequeNo = ''
					donationInstance.bankName = ''
					//donationInstance.c_bankName = ''
				}
				
				donationInstance.donationReceipt = receipt
				println "donationInstance.donationReceipt="+donationInstance.donationReceipt
				donationInstance.creator = springSecurityService.principal.username
				donationInstance.updator = springSecurityService.principal.username
				
				println 'params='+params
				println '("donationInstance"+j)='+(donationInstance)
				
				if (!donationInstance.save(flush: true, validate:false)) 
				{
					hasErrors = true
					errArr[j] = "Error in saving Donation for Receipt : "+j
					donationInstance.errors.allErrors.each {
					        println "Error in saving Donation Instance :"+it
					        errArr[j] += it
					}
				}
			}
		}
		def errString = ""
		errArr.each{l->
			errString += l +"\n\r"
			}
		
		errString += "Please use the browser 'back' button to return back and correct the errors!"
		if(hasErrors)
		{
			flash.message =  errString
			redirect(action: "bulkdonationerr")
		}
		else
		{
			//mark receipt book as entered
			def rbIssued = ReceiptBookIssued.findByReceiptBookAndStatus(receiptBook,'Submitted')
			log.debug("updating  status of rbi "+rbIssued)
			if(rbIssued)
				{
				rbIssued.status='DataEntered'
				if(!rbIssued.save(flush:true))
					rbIssued.errors.allErrors.each {println it}
				log.debug(rbIssued.status)
				}
			
			if(params.donorContact)
				donorContactForSMS = params.donorContact

			println "donorContactForSMS="+donorContactForSMS

			if(donorContactForSMS)
			{
				phoneNos = donorContactForSMS
				println "phoneNos="+phoneNos


				if(phoneNos)
				{
					cellNos1 = phoneNos.split(",")

					for(i=0; i<cellNos1.size(); i++)
					{
						cellNos = cellNos + "," + (cellNos1[i]).toString()
						println "cellNos="+cellNos

					}
				}

				if (cellNos[0..0] == ",")
					cellNos = cellNos[1..-1]


				donorNameForSMS = (params.donorName).toString().replace(" ","%20")
				housekeepingService.sendSMS(cellNos,'Dear%20'+donorNameForSMS+',%20Hare%20Krishna!%20Thank%20you%20for%20the%20donation%20of%20Rs'+params.amount+'.%20May%20Lord%20Krishna%20shower%20His%20choicest%20blessings%20upon%20you.%20ISKCON%20Pune')
				//housekeepingService.sendSMS(cellNos,'Thanks%Afor%20donation')
			}

			def donorEmailForEmail
			if(params.donorEmail)
				donorEmailForEmail = params.donorEmail

			println "donorEmailForEmail="+donorEmailForEmail
			if(donorEmailForEmail)
			{
				emailIds = donorEmailForEmail
				println "emailIds="+emailIds

				if(emailIds)
				{

					mailIds = emailIds.split(",")

					println "mailIds="+mailIds

					mailBody = 'Dear '+params.donorName+', \nHare Krishna! \n\nThank you for the donation of Rs. '+params.amount+'. May the Lord shower His choicest blessings upon you. \n\n--ISKCON NVCC.' 
					try{
						sendMail {     
						  to mailIds
						  subject "Thank you for the Donation."     
						  body mailBody
						}  
					}
					catch(Exception e)
					{
						println e
					}
					
				}		
			}		
			redirect(action: "list")
		}			
	}
	
	def bulkdonationerr = {
	}
	
	def getReceiptBook ={
    	println '------------getReceiptBook------------.'
    	println 'params='+params
	
		def receiptBook = ReceiptBook.get(params.id) //ReceiptBook.findAllById(params."receiptBook.id")
		
		/*println 'numPages='+receiptBook.numPages
		println 'startingReceiptNumber='+receiptBook.startingReceiptNumber
		println 'receipts='+receiptBook.receipts*/
		println 'receiptBook='+receiptBook
		
		return [receiptBook: receiptBook]
	}
	
    def linkdonor = {
    	println '------------linkdonor------------'
    	println 'params='+params
        def donationInstance = Donation.get(params.id)
        if (!donationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'donation.label', default: 'Donation'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [donationInstance: donationInstance]
        }
    }
    
    def link() {
    	log.debug("Linking dummy donation.."+params)
    	def donationInstance = Donation.get(params.id)
    	def linkedDonor = Individual.get(params.uniqIndRadio)
    	if(linkedDonor)
    		{
    		donationInstance.donatedBy = linkedDonor
    		donationInstance.updator =  springSecurityService.principal.username
    		if(!donationInstance.save())
    			{
			    donationInstance.errors.allErrors.each {
				log.debug(it)
				}
			flash.message="Some error occurred. Pls contact Admin!!"
    			}
    		else
    			flash.message="Successfully linked!!"
    		}
    	else
    		flash.message="Individual not selected!!"
    	redirect(action: "show",id:donationInstance?.id)
    	
    }

    def createAndLink() {
    	log.debug("createAndLink dummy donation.."+params)
    	def donationInstance = Donation.get(params.id)
    	def linkedDonor = new Individual()
    	linkedDonor.legalName = donationInstance.donorName
    	linkedDonor.category = 'NVCC' //todo: hardcoding
    	if(donationInstance.donorPAN)
    		linkedDonor.panNo = donationInstance.donorPAN
    	linkedDonor.creator = linkedDonor.updator = springSecurityService.principal.username
	if(!linkedDonor.save(flush:true))
		{
		    linkedDonor.errors.allErrors.each {
			log.debug(it)
			}
		  flash.message="Individual not created. Please contact admin!!"
		}
	else
		{
		log.debug("New donor created.."+linkedDonor)
		//update its icsid
		linkedDonor.icsid = 100000+linkedDonor.id
		linkedDonor.save()
		//now save the address, phone and email
		if(donationInstance.donorContact)
			{
			def vc = new VoiceContact()
			vc.category = "CellPhone"
			vc.number = donationInstance.donorContact
			vc.individual = linkedDonor
			vc.creator = vc.updator = springSecurityService.principal.username
			if(!vc.save())
				{
				    vc.errors.allErrors.each {
					log.debug(it)
					}
				}
			}
		if(donationInstance.donorEmail)
			{
			def vc = new EmailContact()
			vc.category = "PERSONAL"
			vc.emailAddress = donationInstance.donorEmail
			vc.individual = linkedDonor
			vc.creator = vc.updator = springSecurityService.principal.username
			if(!vc.save())
				{
				    vc.errors.allErrors.each {
					log.debug(it)
					}
				}
			}
		if(donationInstance.donorAddress)
			{
			def vc = new Address()
			vc.category = "CORRESPONDENCE"
			vc.addressLine1 = donationInstance.donorAddress
			vc.city = City.get(1) //hardcoding
			vc.state = State.get(1) //hardcoding
			vc.country = Country.get(1) //hardcoding
			vc.individual = linkedDonor
			vc.creator = vc.updator = springSecurityService.principal.username
			if(!vc.save())
				{
				    vc.errors.allErrors.each {
					log.debug(it)
					}
				}
			}
		//now update the donation
    		donationInstance.donatedBy = linkedDonor
    		donationInstance.updator =  springSecurityService.principal.username
    		if(!donationInstance.save())
    			{
			    donationInstance.errors.allErrors.each {
				log.debug(it)
				}
			flash.message="Some error occurred. Pls contact Admin!!"
    			}
    		else
    			flash.message="Successfully linked!!"		
		}
    		
    	redirect(action: "show",id:donationInstance?.id)
    	
    }

    def matchdummydonor() {
    	log.debug("Inside matchdummydonor.."+params.id)
    	def donationInstance = Donation.get(params.id)
    	log.debug("Starting matching for donation: "+donationInstance)
        if (!donationInstance) {
            flash.message = "Donation not found!!"
            redirect(action: "list")
            return
        }
        
        def mnameInds,snameInds
	def maddrInds=[], saddrInds
	def memailInds=[] , semailInds
	def mphoneInds=[]
	def mpanInds
	def mlmnoInds
	boolean keyFlag = false

        
        mnameInds = housekeepingService.searchIndividualName(donationInstance?.donorName)
	mnameInds = mnameInds?.sort{it.legalName}
	
	//exact search on name
	String srchName=""
	def nameToken = donationInstance?.donorName?.split()
	nameToken?.each{
		srchName += it +"%"
	}
	log.debug("matchdummydonor:Searching for name:"+srchName)
	def namedInd = Individual.findByLegalNameIlike(srchName)
	if(namedInd)
		keyFlag = true
        
        if(donationInstance?.donorAddress)
        	{
        	maddrInds = housekeepingService.searchAddress(donationInstance?.donorAddress)
        	maddrInds = maddrInds?.sort{it.legalName}
        	}
	
        if(donationInstance?.donorEmail)
        	{
        	semailInds = EmailContact.findAllByEmailAddressLike("%"+donationInstance?.donorEmail+"%")
        	if(semailInds?.size()>0)
		       	{
		       	keyFlag = true
		       	semailInds.each{
		       		memailInds.add(it.individual)
		       		}
		       	memailInds = memailInds?.sort{it.legalName}
        		}
        	}

        if(donationInstance?.donorContact)
        	{
        	def vcList = VoiceContact.findAllByNumberLike('%'+donationInstance?.donorContact+'%')
        	if(vcList?.size()>0)
        		{
        		keyFlag = true
        		vcList.each{
        			mphoneInds.add(it.individual)
        			}
        		mphoneInds = mphoneInds?.sort{it.legalName}
        		}
        	}
        if(donationInstance?.donorPAN)
        	{
        	mpanInds = Individual.findAllByPanNoLike("%"+donationInstance?.donorPAN+"%")
        	mpanInds = mpanInds?.sort{it.legalName}
        	}
	
	//now get unique inds and duplicate inds
	def mlist=[]
	if(mnameInds)
		mlist.add(mnameInds)
	if(maddrInds)
		mlist.add(maddrInds)
	if(memailInds)
		mlist.add(memailInds)
	if(mphoneInds)
		mlist.add(mphoneInds)
	if(mpanInds)
		mlist.add(mpanInds)

	println "mlist before flatten"+mlist

	mlist = mlist.flatten()
	
	println "mlist after flatten"+mlist
	
	def uniques= [] as Set, dups= [] as Set
	mlist.each{ uniques.add(it.id) || dups.add(it.id) }
	uniques.removeAll(dups)
	
	println "Uniques : "+ uniques
	println "Duplicates : "+ dups
	
	def uniqInds = []
	def dupInds = []
	
	uniques.each{ uniqInds.add(Individual.get(it)) }
	uniqInds = uniqInds?.sort{it.legalName}
	
	dups.each{dupInds.add(Individual.get(it))}
	dupInds = dupInds?.sort{it.legalName}
	
	return	[donationInstance:donationInstance, mphoneInds: mphoneInds, maddrInds:maddrInds, memailInds:memailInds, mpanInds:mpanInds, mnameInds:mnameInds, uniques: uniques, dups: dups, uniqInds: uniqInds, dupInds: dupInds, keyFlag: keyFlag]    	
    	
    }
    def linkdonorupdate = {
    	println '------------linkdonorupdate------------'
    	println 'params='+params    
        def donationInstance = Donation.get(params.id)
        if (donationInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (donationInstance.version > version) {
                    
                    donationInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'donation.label', default: 'Donation')] as Object[], "Another user has updated this Donation while you were editing")
                    render(view: "edit", model: [donationInstance: donationInstance])
                    return
                }
            }
            
            def oldDonorId = donationInstance.donatedBy.id
            def donor = Individual.get(params.acDonatedBy_id)
            donationInstance.donatedBy = donor
            donationInstance.comments = params.comments
            if(donor=='')
            {
            	flash.message = "Donor Name required!"
            }
            if (!donationInstance.hasErrors() && donationInstance.save(flush: true)) {
            
            	//change the well wisher status for the donor
            	//donor?.isWellWisher = false
            	//modified after adding the isDonor flag
            	donor?.isDonor = true
            	donor.save(flush:true)

            	//change for gifts issued
		   def sql = new Sql(dataSource);
		   println "Variables for gift upd:"+[params.acDonatedBy_id,oldDonorId,params.id]
		   def result = sql.executeUpdate("update gift_issued set issued_to_id = ? where issued_to_id=? and donation_id=?", [params.acDonatedBy_id,oldDonorId,params.id])
		   println "Result of gi upd query:"+result
            	
            	//update schememember table
		/*def schmMem = SchemeMember.findBySchemeAndMember(Scheme.get(donationInstance."scheme.id"),donor)
		println 'schmMem='+schmMem
		if(!schmMem)
		{
			println 'not sm'
			params.scheme = Scheme.get(donationInstance."scheme.id")
			params.member = donor
			
			if (params.installment)
			{
				if (params.installment.value.toString()=="on")
					params.installment= true
				else
					params.installment= false
			}
			
			else
				params.installment= true
			
			def schemeMemberInstance = new SchemeMember(params)
			schemeMemberInstance.save(flush: true)			
		}*/
            	
                flash.message = "Donor linked for donation id:"+ donationInstance.id
                redirect(action: "show", id: donationInstance.id)
                //render(view: "edit", model: [donationInstance: donationInstance])
            }
            else {
                flash.message = "Some error occured while linking donor for donation id:"+ donationInstance.id
                redirect(action: "show", id: donationInstance.id)
                //render(view: "edit", model: [donationInstance: donationInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'donation.label', default: 'Donation'), params.id])}"
            redirect(action: "list")
        }
    }
    
    def bounced = {
    	def donation = Donation.get(params.id)
    	
    	if(donation.status == 'BOUNCED')
    		{
                flash.message = "The donation " + donation.id + "  is already marked as BOUNCED!!"
                redirect(controller: "bouncedCheque", action: "list")
                return
    		}
    	
    	//create an entry in the bounced cheque
    	def bc = new BouncedCheque()
    	    if(params."acIssuedBy_id")
    	    {
	    	params."donatedBy.id"= params."acIssuedBy_id"
	    	println 'donatedBy.id='+params."donatedBy.id"
      	    }
    	    bc.donation = donation
	    bc.chequeNo = donation.chequeNo
	    bc.chequeDate = donation.chequeDate
	    bc.bankName = donation.bankName
	    bc.branchName = donation.bankBranch
	    bc.issuedBy = donation.donatedBy?.legalName
	    println 'bc.issuedBy='+bc.issuedBy
	    
		if (springSecurityService.isLoggedIn()) {
			bc.creator=springSecurityService.principal.username
		}
		else
			bc.creator=""
		bc.updator=bc.creator
	bc.save()
	if(!bc.save(flush:true))

        {
            println "Some problem in saving bounced cheque "+bc
            if(bc.hasErrors()) {
                bc.errors.each {
                  println it
                }
            }
        }
	
	println 'bc='+bc
	println 'bc.id='+bc.id
	/*
	//create a followup
	def f = new Followup()
	    f.followupWith  = donation.donatedBy
	    f.followupBy = donation.collectedBy
	    f.startDate = new Date()
	    f.category = "Bounced Cheque"
	    f.comments = "Auto created"
	    f.status = "Open"
	    f.description = bc.toString()
		if (springSecurityService.isLoggedIn()) {
			f.creator=springSecurityService.principal.username
		}
		else
			f.creator=""
		f.updator=f.creator
	f.save()
       */
	
	donation.status = "BOUNCED"
	donation.save()
	
       //redirect(controller: "followup", action: "edit", id: f.id)
       redirect(controller: "bouncedCheque", action: "edit", id: bc.id)
    }
    def search = {
	if(params.sReceiptDate)
		params.sReceiptDate = Date.parse('dd-MM-yyyy', params.sReceiptDate)
	if(params.sSubmissionDate)
		params.sSubmissionDate = Date.parse('dd-MM-yyyy', params.sSubmissionDate)
	if(params.sReceiptDate1)
		params.sReceiptDate1 = Date.parse('dd-MM-yyyy', params.sReceiptDate1)
	if(params.sSubmissionDate1)
		params.sSubmissionDate1 = Date.parse('dd-MM-yyyy', params.sSubmissionDate1)


    def criteria = Donation.createCriteria()
    def bookno
    def donationList = criteria {
			and {
				if (params.sComments!=null && params.sComments.trim().length()>0)
			    		like("comments", "%"+params.sComments+"%")
				if (params.sBookNumber!=null && params.sBookNumber.trim().length()>0)
					{
					try{
						bookno = new Integer(params.sBookNumber[1..(params.sBookNumber.size()-1)])
					}
					catch(Exception e){
						bookno = null
					}
			    		or{
			    			like("nvccReceiptBookNo", "%"+params.sBookNumber+"%")
			    			donationReceipt{receiptBook{eq('bookSeries',params.sBookNumber[0]) eq('bookSerialNumber',bookno)}}
			    		  }
			    		}
				if (params.sReceiptNumber!=null && params.sReceiptNumber.trim().length()>0)
					{
			    		or{
			    			like("nvccReceiptNo", "%"+params.sReceiptNumber+"%")
			    			donationReceipt{eq('receiptNumber',params.sReceiptNumber)}
			    		  }
			    		}
			    if(params.ExactCHK=="ExactCHK")
				{

				if (params.sChqNo!=null && params.sChqNo.trim().length()>0)
			    		eq("chequeNo", params.sChqNo)
			    	}
			    else
			    {
			    if(params.ExactCHK=="LikeCHK")
				{
				if (params.sChqNo!=null && params.sChqNo.trim().length()>0)
			    		like("chequeNo", "%"+params.sChqNo+"%")
			    	}			    			   			    
			    }
				if (params.sPaymentComments!=null && params.sPaymentComments.trim().length()>0)
			    		like("paymentComments", "%"+params.sPaymentComments+"%")
			if(params.Range=="Range")
				{
				if (params.sAmount!=null && params.sAmount.trim().length()>0)
			    		ge("amount", new BigDecimal(params.sAmount))
				if (params.sAmount1!=null && params.sAmount1.trim().length()>0)
			    		le("amount", new BigDecimal(params.sAmount1))

			    	}
			else{
			if(params.Range=="NoRange")
				{	
				if (params.sAmount!=null && params.sAmount.trim().length()>0)
			    		eq("amount", new BigDecimal(params.sAmount))			    		
			    	}
			    }
				if (params.sDonationTypeSchemeId)
					{
					scheme {
					        eq("id", new Long(params.sDonationTypeSchemeId))
					    }
					}

			if(params.Rangerd=="NoRange")
				{
				
				if (params.sReceiptDate)
			    		eq("donationDate", params.sReceiptDate)
			    	}
			else{
			
			if(params.Rangerd=="Range")
				{
				if (params.sReceiptDate)
			    		ge("donationDate", params.sReceiptDate)
				if (params.sReceiptDate1)
			    		le("donationDate", params.sReceiptDate1)			    									
				}			
			}			    	

			if(params.Rangesd=="NoRange")
				{
				if (params.sSubmissionDate)
			    		eq("fundReceiptDate", params.sSubmissionDate)
				}
			else
			{
			if(params.Rangesd=="Range")
				{
				if (params.sSubmissionDate)
			    		ge("fundReceiptDate", params.sSubmissionDate)
				if (params.sSubmissionDate1)
			    		le("fundReceiptDate", params.sSubmissionDate1)

				}						
			}

			    //println " Rani TestDLN"+params."ExactDLN"
			    //println " Rani TestCLN"+params."ExactCLN"
			    //println " Rani TestCHK"+params."ExactCHK"			    
			    //println " Rani TestRg"+params."Range"			    			    
			    //println " Rani TestRgrd"+params."Rangerd"			    			    
			    //println " Rani TestRgsd"+params."Rangesd"			    			    			    
			    if(params.ExactDLN=="ExactDLN")
				{
				if (params.sDonorLegalName)
					{
					donatedBy {eq("legalName", params.sDonorLegalName)}
					}
				}
			else{
			if(params.ExactDLN=="LikeDLN")
							{
				
							if (params.sDonorLegalName)
								{
					donatedBy {
					        like("legalName", "%"+params.sDonorLegalName+"%")
					    		}																        								
					    }
					}
			
			}
			
			    if(params.ExactDIN=="ExactDIN")
				{
	
				if (params.sDonorInitName)
					{
					donatedBy {eq("initiatedName", params.sDonorInitName)}
					}
				}
			else{
			if(params.ExactDIN=="LikeDIN")
				{
			
			if (params.sDonorInitName)
					{
					donatedBy {
					        like("initiatedName", "%"+params.sDonorInitName+"%")
					    }
					}
				}
			     }


////////////
			    if(params.ExactDIN=="ExactDIN")
				{
	
				if (params.sDonorName)
					{
					eq("donorName", params.sDonorName)}
					
				}
			else{
			if(params.ExactDIN=="LikeDIN")
				{
			
			if (params.sDonorName)
					{
					
					        like("donorName", "%"+params.sDonorName+"%")
					    
					}
				}
			     }

////////////


				 if(params.ExactCLN=="ExactCLN")
					{
				if (params.sCollectorLegalName)
					{
					       collectedBy { eq("legalName", params.sCollectorLegalName)}
					}
								
					}
				else
				{  if(params.ExactCLN=="LikeCLN")
					{
	
				if (params.sCollectorLegalName)
					{
					collectedBy {
					        like("legalName", "%"+params.sCollectorLegalName+"%")
					    }
					}
					}
				}

				 if(params.ExactCIN=="ExactCIN")
					{
				if (params.sCollectorInitName)
					{
					       collectedBy { eq("initiatedName", params.sCollectorInitName)}
					}
								
					}
				else
				{  if(params.ExactCIN=="LikeCIN")
					{

				if (params.sCollectorInitName)
					{
					collectedBy {
					        like("initiatedName", "%"+params.sCollectorInitName+"%")
					    }
					}
					}				
				}
				 if(params.ExactRLN=="ExactRLN")
					{

				if (params.sReceiverLegalName)
					{
					receivedBy {
					        eq("legalName", params.sReceiverLegalName)
					    }
					}
					}
				else
					{
				if(params.ExactRLN=="LikeRLN")
					{

				if (params.sReceiverLegalName)
					{
					receivedBy {
					        like("legalName", "%"+params.sReceiverLegalName+"%")
					    }
					}
					}				
				
				}

				if(params.ExactRIN=="ExactRIN")
					{
					
				if (params.sReceiverInitName)
					{
					receivedBy {
					        eq("initiatedName", params.sReceiverInitName)
					    }
					}
					}
				else
				{
				if(params.ExactRIN=="LikeRIN")
					{
					
				if (params.sReceiverInitName)
					{
					receivedBy {
					        like("initiatedName", "%"+params.sReceiverInitName+"%")
					    }
					}
					}
				
				
				}
				}
       		 	}

                render(view: "list", model: [donationInstanceList: donationList, search: true])

    }

    //to verify whether the sum of all cash donations received since last tallied (or beginning of the day) matches with the denomination, for a particular receiver
    def tally = {
    	def denomination = Denomination.get(params?.id)
    	if(!denomination)
    		{
		    flash.message = "Invalid id ("+params.id+") specified for tallying denomination!"
		    redirect(controller:"denomination", action: "show", id: denomination.id)
		    return
    		}
    	if(denomination.collectedBy?.id != session.individualid)
    		{
		    flash.message = "Only the receiver ("+denomination.collectedBy+") can tally the denomination!!"
		    redirect(controller:"denomination", action: "show", id: denomination.id)
		    return
    		}

    	def tallyFromTS = new Date()
    	tallyFromTS.clearTime()
    	println "tallyFromTS: " + tallyFromTS
    	if(denomination.tallyDate)
    		tallyFromTS = denomination.tallyDate
    	println "tallyFromTS: " + tallyFromTS
    	println "Denomination collectedBy: " + denomination.collectedBy
    	def donations = Donation.findAllByReceivedByAndDateCreatedGreaterThanEquals(denomination.collectedBy,tallyFromTS)
    	//now get the total of cash donations in this period
    	def cashTotal = 0
    	donations.each{ i->
    		if(i.mode?.name=='Cash')
    			cashTotal += i.amount
    	}
    	//now verify if this matches with denomination
    	def total = denomination.fiftyPaiseCoinQty * 0.5 + denomination.oneRupeeCoinQty * 1 + denomination.twoRupeeCoinQty * 2 + denomination.fiveRupeeCoinQty * 5 + denomination.tenRupeeCoinQty * 10 + denomination.oneRupeeNoteQty * 1 + denomination.twoRupeeNoteQty * 2 + denomination.fiveRupeeNoteQty * 5 + denomination.tenRupeeNoteQty * 10 + denomination.twentyRupeeNoteQty * 20 + denomination.fiftyRupeeNoteQty * 50 + denomination.hundredRupeeNoteQty * 100 + denomination.fiveHundredRupeeNoteQty * 500 + denomination.oneThousandRupeeNoteQty * 1000
    	def newTallyTotal = denomination.tallyTotal+cashTotal
    	println "Denomination : tallyTotal="+denomination.tallyTotal +"; cashTotal="+cashTotal+";total="+total
    	if (newTallyTotal == total)
    		{
    			//match so update the tallyTotal
    			denomination.tallyDate = new Date()
    			denomination.tallyTotal = newTallyTotal
    			denomination.save(flush:true)
    			flash.message = "Denominations entered tallies with all the donations entered since last tallying!!"
    			redirect(controller:"denomination", action: "show", id: denomination.id)
    		}
    	else
    		{
    			flash.message = "Please verify the entries shown below! Denominations entered ("+ total +") does not tally with all the donations entered ("+cashTotal+") since last tallying ("+denomination.tallyTotal+")!!"
    			render(view: "list", model: [donationInstanceList: donations, donationInstanceTotal: donations.size()])
    		}
    }

  
def upload_receiptImage = {
  def donation = Donation.get(params.id)
  // Get the receiptImage file from the multi-part request
  def f = request.getFile('receiptImage')
  // List of OK mime-types
  def okcontents = ['image/png', 'image/jpeg', 'image/gif']
  if (! okcontents.contains(f.getContentType())) {
    flash.message = "Image must be one of: ${okcontents}"
    render(view:'edit', model:[donationInstance:donation])
    return;
  }
  // Save the image and mime type
  donation.receiptImage = f.getBytes()
  donation.receiptImageType = f.getContentType()
  // Validation works, will check if the image is too big
  if (!donation.save()) {
    render(view:'edit', model:[donationInstance:donation])
    return;
  }
  flash.message = "Image (${donation.receiptImageType}, ${donation.receiptImage.size()} bytes) uploaded."
  redirect(action:'show', id: donation.id)
}

def receiptImage_image = {
  def donation = Donation.get(params.id)
  if (!donation || !donation.receiptImage || !donation.receiptImageType) {
    response.sendError(404)
    return;
  }
  response.setContentType(donation.receiptImageType)
  response.setContentLength(donation.receiptImage.size())
  OutputStream out = response.getOutputStream();
  out.write(donation.receiptImage);
  out.close();
}    
def jq_donation_list = {
                   def sortIndex = params.sidx ?: 'nvccDonationType'
                   def sortOrder  = params.sord ?: 'asc'
             
                   def maxRows = Integer.valueOf(params.rows)
                   def currentPage = Integer.valueOf(params.page) ?: 1
             
                   def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
             
             	def result = Donation.createCriteria().list(max:maxRows, offset:rowOffset) {
             		
             		if (params.'individual.id')
         		    			individual{
         		    			eq('id',new Long(params.'individual.id'))
         		    			}
         
             		
             		if (params.nvccDonationType)
             			ilike('nvccDonationType','%'+params.nvccDonationType + '%')
             
             		if (params.collectedBy)
             				ilike('collectedBy','%'+params.collectedBy + '%')
             
                        if (params.nvccReceiptBookNo)
             				ilike('nvccReceiptBookNo','%'+params.nvccReceiptBookNo + '%')
             
                        if (params.nvccReceiptNo)
	                  		ilike('nvccReceiptNo','%'+params.nvccReceiptNo + '%')
             
                         if (params.mode)
			              	ilike('mode','%'+params.mode + '%')

                         if (params.amount)
			              	ilike('amount','%'+params.amount + '%')
             
                         if (params.donationDate)
			              	ilike('donationDate','%'+params.donationDate + '%')
                          if (params.fundReceiptDate)
			               	ilike('fundReceiptDate','%'+params.fundReceiptDate + '%')
                          if (params.receivedBy)
			               	ilike('receivedBy','%'+params.receivedBy + '%')
             
             		order(sortIndex, sortOrder)
             
             	}
                   
                   def totalRows = result.totalCount
                   def numberOfPages = Math.ceil(totalRows / maxRows)
             
                   def jsonCells = result.collect {
                         [cell: [
                                    
                         	    it.nvccDonationType,
                         	    it.collectedBy,
                         	    it.nvccReceiptBookNo,
                         	    it.nvccReceiptNo,
                         	    it.mode,
                         	    it.amount,
                         	    it.donationDate,
                         	    it.fundReceiptDate,
                         	    it.receivedBy
                         	    
                             ], id: it.id]
                     }
                     def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
                     render jsonData as JSON
                     }
             
             	def jq_donation_email = {
             	      log.debug('In jq_donation_edit:'+params)
             	      def email = null
             	      def message = ""
             	      def state = "FAIL"
             	      def id
             	      def donation
             
             	      // determine our action
             	      switch (params.oper) {
             		case 'add':
             		
             		 		
             		  donation = new Donation(params)
             		
             		donation.creator=springSecurityService.principal.username
             		donation.updator = donation.creator
             		
             		  if (! donation.hasErrors() && donation.save()) {
             		    message = "Donation Saved.."
             		    id = donation.id
             		    state = "OK"
             		  } else {
             		    donation.errors.allErrors.each {
             			log.debug(it)
             			}
             		    message = "Could Not Save Donation"
             		  }
             		  break;
             		case 'del':
             		  	def idList = params.id.tokenize(',')
             		  	idList.each
             		  	{
             			  // check vehicle exists
             			  donation  = Donation.get(it)
             			  if (donation) {
             			    // delete vehicle
             			    if(!donation.delete())
             			    	{
             				    donation.errors.allErrors.each {
             					log.debug("In jq_donation_edit: error in deleting donation:"+ it)
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
             		  donation = Donation.get(params.id)
             		  if (donation) {
             		    // set the properties according to passed in parameters
             		    donation.properties = params
             			  
             		    if (! donation.hasErrors() && donation.save()) {
             		      message = "Donation  ${donation.nvccDonationType} Updated"
             		      id = donation.id
             		      state = "OK"
             		    } else {
             			    donation.errors.allErrors.each {
             				println it
             				}
             		      message = "Could Not Update email"
             		    }
             		  }
             		  break;
              	 }
             
             	      def response = [message:message,state:state,id:id]
             
             	      render response as JSON
             	    }

	def entry() {[id:params.id]}
	
	def saveEntry() {
		//todo: move login in service layer and also introduce transactions
		log.debug("Inside saveEntry: "+params)

		if (springSecurityService.isLoggedIn()) {
			params.creator=springSecurityService.principal.username
		}
		else
			params.creator=""
		params.updator=params.creator
		
		params.currency = "INR" //todo: remove hardcoding
		
		if(params.chequeDate)
			params.chequeDate = Date.parse('dd-MM-yyyy', params.chequeDate)

		if(params."acCollector_id")
		{
			params."collectedBy.id"= params."acCollector_id"
		}
		
		params."receivedBy.id" = (session.individualid)?:13918	//todo: hardcoding

		def donor
		def newDonor = false
		if(params.icsid)
			donor = Individual.findByIcsid(params.icsid)
		if(!donor)
			{
			//create new donor entry
			newDonor = true
			donor = individualService.createIndividual(params)
			}
		log.debug("Donor : "+donor)
		params."donatedBy.id" = donor?.id
		if(!newDonor && params.modifyContact)
			{
			//update PAN
			donor.panNo = params.donorPAN
			donor.save()
			
			//update the contacts
			def email = EmailContact.get(params.emailid)
			if(email)
				{
				if(!params.donorEmail)
					email.delete()
				else
					{
					email.emailAddress = params.donorEmail
					email.updator = springSecurityService.principal.username
					email.save()
					}
				}
			else if (params.donorEmail)
				{
				def ec = new EmailContact(category:"Personal",emailAddress:params.donorEmail,individual:donor,creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
				if(!ec.save())
					ec.errors.allErrors.each {println it}				
				}
			def vc = VoiceContact.get(params.contactid)
			if(vc)
				{
				if(!params.donorContact)
					vc.delete()
				else
					{
					vc.number = params.donorContact
					vc.updator = springSecurityService.principal.username
					vc.save()
					}
				}
			else if (params.donorContact)
				{
				vc = new VoiceContact(category:"CellPhone",number:params.donorContact,individual:donor,creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
				if(!vc.save())
					vc.errors.allErrors.each {println it}				
				}
			//get the correct or new city/state/country
			def city 
			if(params.cityid)
				city = City.get(params.cityid)
			else
				city = City.findByName(params.donorCity)
			if(!city)
				{
				city = new City(name:params.donorCity,creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
				city.save()
				}
			def state 
			if(params.stateid)
				state = State.get(params.stateid)
			else
				state = State.findByName(params.donorState)
			if(!state)
				{
				state = new State(name:params.donorState,creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
				state.save()
				}
			def country 
			if(params.countryid)
				country = Country.get(params.countryid)
			else
				country = Country.findByName(params.donorCountry)
			if(!country)
				{
				country = new Country(name:params.donorCountry,creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
				country.save()
				}
			def addr = Address.get(params.addrid)
			if(addr)
				{
				if(!params.donorAddress)
					addr.delete()
				else
					{
					addr.addressLine1 = params.donorAddress
					addr.city = city
					addr.state = state
					addr.country = country
					addr.pincode = params.donorPin
					addr.category='Correspondence'
					addr.updator = springSecurityService.principal.username
					addr.save()
					}
				}
			else if (params.donorAddress)
				{
				addr = new Address(individual:donor,addressLine1:params.donorAddress,city:city,state:state,country:country,pincode:params.donorPin,category:'Correspondence',creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
				if(!addr.save())
					addr.errors.allErrors.each {println it}
				}
			}
		 

		if(!params."acCollector_id")
			{
			log.debug("inside coll logic")
			//get the collector from the donor's data
			//if the donor has a counsellor then the donor is the collector
			//else if the donor has a cultivator then the cultivator is the collector
			//else New Temple Office is the collector
			def rel = Relationship.findWhere(status:'ACTIVE',individual1:donor,relation:Relation.findByName('Councellee of'))
			if(rel)
				params."collectedBy.id" = donor?.id
			else
				{
				rel = Relationship.findWhere(status:'ACTIVE',individual1:donor,relation:Relation.findByName('Cultivated by'))
				if(rel)
					params."collectedBy.id" = rel.individual2?.id
				else
					params."collectedBy.id" = Individual.findByLegalName("New Temple Office")?.id //todo: remove hardcoding
				}
			}
		log.debug("params before saving donation :"+params)
		def donationInstance = new Donation(params)
		
		donationInstance.donationReceipt = Receipt.get(1) //todo: hardcoding for dummy receipt
		donationInstance.donationDate = donationInstance.fundReceiptDate = new Date() //todo: server time issue
		
		log.debug("Saving donation : "+donationInstance)
		if(!donationService.saveDonationWithAutoReceiptNo(donationInstance))
			{
			//donationInstance.errors.allErrors.each {println it}
			flash.message = "Some error occurred!!"
			render(view: "entry", model: [donationInstance: donationInstance])
			}
		else
			{
			//donation saved successfully; sent async sms and email print receipt
			try{
				//sms
				if(params.donorContact)
					{
					def donorNameForSMS = (params.donorName).toString().replace(" ","%20")
					housekeepingService.sendSMS(params.donorContact,'Dear%20'+donorNameForSMS+',%20Hare%20Krishna!%20Thank%20you%20for%20the%20donation%20of%20Rs'+params.amount+'.%20May%20Lord%20Krishna%20shower%20His%20choicest%20blessings%20upon%20you.%20ISKCON%20Pune')
					}

				//email
				if(params.donorEmail)
				{
					//replace ; in email by ,
					def emailStr = params.donorEmail.replaceAll(';',',')
					def mailIds = []
					mailIds = emailStr.split(",")
					//log.debug("mailids in donation:"+mailIds)
					def aList = []
					mailIds?.collect{aList.add(it)}
					def mailBody = 'Dear '+params.donorName+', \nHare Krishna! \n\nThank you for the donation of Rs. '+params.amount+'. May the Lord shower His choicest blessings upon you. \n\n--ISKCON NVCC.' 
					housekeepingService.sendEmail(aList,"Thank you for the Donation.",mailBody)
				}
			}
			catch(Exception e){log.debug(e)}

		   	flash.message = donationInstance?.toString()+" saved with id:"+donationInstance.id
		   	redirect(action: "entry", id: donationInstance.id)
			
			//render(template: "receipt", model: [donationInstance:donationInstance,firstTime])
			}
	}
	
	def printEntry() {
		def donationInstance = Donation.get(params.id)
		if(donationInstance && params.taxBenefit)
			donationInstance.taxBenefit = true
		def firstTime = false
		if(!donationInstance.receiptPrintedOn)
			{
			donationInstance.receiptPrintedOn = new Date()
			donationInstance.receiptPrintedBy = springSecurityService.principal.username
			firstTime = true
			}
		donationInstance.save()
		render(template: "receipt", model: [donationInstance:donationInstance, firstTime:firstTime])
	}
	
	def createFromRecord() {
		log.debug("Inside createFromRecord with params:"+params)
		def num = 0
		num = donationService.createFromRecord(params.idList)
		render([message:num+" donation entries created!!"] as JSON)
	}
	


             


}
