package ics

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import org.grails.mandrill.*

class PersonController {

    def housekeepingService
    def springSecurityService
    def mandrillService
    def commsService
    
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
	
    }

    def create() {
        [personInstance: new Person(params)]
    }

    def save() {
	println("Params in save person:"+params);
	//trim the params
	params.each{it.value = it.value?.trim()}
    	
	if(params.dob)
		params.dob = Date.parse('dd-MM-yyyy', params.dob)
	if(params.dom)
		params.dom = Date.parse('dd-MM-yyyy', params.dom)
	println("params.dob:"+params.dob);
	
	def personInstance = new Person(params)
	personInstance.category = session.individualid
        personInstance.creator = springSecurityService.principal.username
        personInstance.updator = personInstance.creator
        
	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
	{
		println "redirecting..."
		forward action: "matchPerson", personInstance:personInstance
	}        
        else
        {
		if (!personInstance.save(flush: true)) {
		    render(view: "create", model: [personInstance: personInstance])
		    return
		}

		flash.message = message(code: 'default.created.message', args: [message(code: 'person.label', default: 'Person'), personInstance.id])
		redirect(action: "match", id: personInstance.id)
        }
        
        //forward action: "match", id: personInstance.id
    }
    
    def savePerson() {
    	println("Params in savePerson person:"+params);
    	println("personInstance.phone:"+(params.phone));
    	def personInstance = new Person(params)
    	personInstance.creator = springSecurityService.principal.username
        personInstance.updator = personInstance.creator
	if (!personInstance.save(flush: true)) {
	    render(view: "create", model: [personInstance: personInstance])
	    return
	}

	flash.message = message(code: 'default.created.message', args: [message(code: 'person.label', default: 'Person'), personInstance.id])
	redirect(action: "list")
    	
    }

    def show() {
        def personInstance = Person.get(params.id)
        if (!personInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])
            redirect(action: "list")
            return
        }

        [personInstance: personInstance]
    }

    def edit() {
        def personInstance = Person.get(params.id)
        if (!personInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])
            redirect(action: "list")
            return
        }

        [personInstance: personInstance]
    }

    def update() {
        def personInstance = Person.get(params.id)
        if (!personInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (personInstance.version > version) {
                personInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'person.label', default: 'Person')] as Object[],
                          "Another user has updated this Person while you were editing")
                render(view: "edit", model: [personInstance: personInstance])
                return
            }
        }

	//trim the params
	params.each{it.value = it.value?.trim()}

        personInstance.properties = params

        if (!personInstance.save(flush: true)) {
            render(view: "edit", model: [personInstance: personInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'person.label', default: 'Person'), personInstance.id])
        redirect(action: "show", id: personInstance.id)
    }

    def delete() {
        def personInstance = Person.get(params.id)
        if (!personInstance) {
		flash.message = message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])
            redirect(action: "list")
            return
        }

        try {
            personInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'person.label', default: 'Person'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'person.label', default: 'Person'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
    
    def match() {
        println "Params in match:"+params
        def personInstance = Person.get(params.id)
        if (!personInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])
            redirect(action: "list")
            return
        }
        
        if(personInstance.matchedIndividual) {
        	redirect(controller:"individual",action:"show",id:personInstance.matchedIndividual?.id)
        	return
        }
        
        
        def mnameInds,snameInds
	def mfatherInds, sfatherInds
	def mspouseInds, sspouseInds
	def maddrInds=[], saddrInds
	def memailInds=[] , semailInds
	def mphoneInds=[]
	def mpanInds
	def mlmnoInds
	boolean keyFlag = false

        
        mnameInds = housekeepingService.searchIndividualName(personInstance?.name)
	mnameInds = mnameInds?.sort{it.legalName}
	
	//exact search on name
	String srchName="%"
	def nameToken = personInstance?.name?.split()
	nameToken?.each{
		srchName += it +"%"
	}
	log.debug("Searching for name:"+srchName)
	def namedInd = Individual.findByLegalNameIlike(srchName)
	if(namedInd)
		keyFlag = true
        
        if(personInstance?.father)
        	{
        	mfatherInds = housekeepingService.searchIndividualName(personInstance?.father)
        	mfatherInds = mfatherInds?.sort{it.legalName}
        	}
        if(personInstance?.spouse)
        	{
        	mspouseInds = housekeepingService.searchIndividualName(personInstance?.spouse)
        	mspouseInds = mspouseInds?.sort{it.legalName}
        	}

        if(personInstance?.address)
        	{
        	maddrInds = housekeepingService.searchAddress(personInstance?.address)
        	maddrInds = maddrInds?.sort{it?.legalName}
        	}
        else	//try with office address
        	{
		if(personInstance?.officeAddress)
			{
			maddrInds = housekeepingService.searchAddress(personInstance?.officeAddress)
			maddrInds = maddrInds?.sort{it.legalName}
			}
        	}
	
        if(personInstance?.email)
        	{
        	/*semailInds = EmailContact.search(personInstance?.email)
        	if(semailInds.total>0)
		       	{
		       	keyFlag = true
		       	semailInds.results.each{
		       		memailInds.add(EmailContact.get(it.id)?.individual)
		       		}
		       	memailInds = memailInds?.sort{it.legalName}
        		}*/
        	semailInds = EmailContact.findAllByEmailAddress(personInstance?.email)
        	if(semailInds?.size()>0)
		       	{
		       	keyFlag = true
		       	semailInds.each{
		       		if(!it.individual.status || (it.individual.status!='DELETED' && it.individual.status!='MERGED'))
		       			memailInds.add(it.individual)
		       		}
		       	memailInds = memailInds?.sort{it.legalName}
        		}
        	}

        if(personInstance?.phone)
        	{
        	def vcList = VoiceContact.findAllByNumber(personInstance?.phone)
        	if(vcList?.size()>0)
        		{
        		keyFlag = true
        		vcList.each{
		       		if(!it.individual.status || (it.individual.status!='DELETED' && it.individual.status!='MERGED'))
        				mphoneInds.add(it.individual)
        			}
        		mphoneInds = mphoneInds?.sort{it.legalName}
        		}
        	}
        if(personInstance?.panno)
        	{
        	mpanInds = Individual.findAllByPanNoLikeAndIsNullStatus("%"+personInstance?.panno+"%")
        	mpanInds = mpanInds?.sort{it.legalName}
        	}
        if(personInstance?.lmno)
        	{
        	mlmnoInds = Individual.findAllByMembershipNoLikeAndIsNullStatus("%"+personInstance?.lmno+"%")
        	mlmnoInds = mlmnoInds?.sort{it.legalName}
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
	if(mlmnoInds)
		mlist.add(mlmnoInds)

	println "mlist before flatten"+mlist

	mlist = mlist.flatten()
	
	println "mlist after flatten"+mlist
	
	def uniques= [] as Set, dups= [] as Set
	mlist.each{ uniques.add(it?.id) || dups.add(it?.id) }
	uniques.removeAll(dups)
	
	println "Uniques : "+ uniques
	println "Duplicates : "+ dups
	
	def uniqInds = []
	def dupInds = []
	
	uniques.each{ uniqInds.add(Individual.get(it)) }
	uniqInds = uniqInds?.sort{it?.legalName}
	
	dups.each{dupInds.add(Individual.get(it))}
	dupInds = dupInds?.sort{it.legalName}
	
	//Automatching is error prone
	/*
	if(dups.size()==1)
		{
		// found exact match
		dups.each{
			personInstance.matchedIndividual = Individual.get(it)
			}
		personInstance.status = "AUTOMATCHED"
		personInstance.save(flush:true)
		}
	else
		if(dups.size()==0 && uniques.size()==1)
			{
			// found exact match
			uniques.each{
				personInstance.matchedIndividual = Individual.get(it)
				}
			personInstance.status = "AUTOMATCHED"
			personInstance.save(flush:true)
			}
		else
			{
			personInstance.status = "NOAUTOMATCHED"
			personInstance.save(flush:true)
			}
	*/
	return	[personInstance:personInstance, mphoneInds: mphoneInds, maddrInds:maddrInds, memailInds:memailInds, mpanInds:mpanInds, mlmnoInds:mlmnoInds, mnameInds:mnameInds, uniques: uniques, dups: dups, uniqInds: uniqInds, dupInds: dupInds, category: params.category?:session.individualid, keyFlag: keyFlag]    	
    }

    def matchPerson() {
        println "Params in matchPerson:"+params
        /*def personInstance = Person.get(params.id)
        if (!personInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])
            redirect(action: "list")
            return
        }
        */
        def personInstance = new Person(params)
        
        def mnameInds,snameInds
	def mfatherInds, sfatherInds
	def mspouseInds, sspouseInds
	def maddrInds=[], saddrInds
	def memailInds=[] , semailInds
	def mphoneInds=[]
	def mpanInds
	def mlmnoInds

        println "params.name="+params.name
        
        mnameInds = housekeepingService.searchPersonName(params.name)
        
        mnameInds = mnameInds?.sort{params.name}
        
        /*if(personInstance?.father)
        	{
        	mfatherInds = housekeepingService.searchIndividualName(personInstance?.father)
        	mfatherInds = mfatherInds?.sort{it.legalName}
        	}
        if(personInstance?.spouse)
        	{
        	mspouseInds = housekeepingService.searchIndividualName(personInstance?.spouse)
        	mspouseInds = mspouseInds?.sort{it.legalName}
        	}*/

        /*if(personInstance?.address)
        	{
        	maddrInds = housekeepingService.searchAddress(personInstance?.address)
        	maddrInds = maddrInds?.sort{it.legalName}
        	}
        else	//try with office address
        	{
		if(personInstance?.officeAddress)
			{
			maddrInds = housekeepingService.searchAddress(personInstance?.officeAddress)
			maddrInds = maddrInds?.sort{it.legalName}
			}
        	}
	*/
        if(personInstance?.email)
        	{
        	memailInds = Person.findAllByEmailLike("%"+params.email+"%")
        	memailInds = memailInds?.sort{it.name}
        	
        	/*semailInds = EmailContact.search(personInstance?.email)
        	if(semailInds.total>0)
		       	{
		       	semailInds.results.each{
		       		memailInds.add(EmailContact.get(it.id)?.individual)
		       		}
		       	memailInds = memailInds?.sort{it.legalName}
        		}
        	*/
        	
        	}

        if(personInstance?.phone)
        	{
        	def vcList = Person.findAllByPhoneLike("%"+params.phone+"%")
        	if(vcList?.size()>0)
        		{
        		vcList.each{
        			mphoneInds.add(it)
        			}
        		mphoneInds = mphoneInds?.sort{it.name}
        		}
        	}
        if(personInstance?.panno)
        	{
        	mpanInds = Person.findAllByPannoLike("%"+params.panno+"%")
        	mpanInds = mpanInds?.sort{it.name}
        	}
        if(personInstance?.lmno)
        	{
        	mlmnoInds = Person.findAllByLmnoLike("%"+params.lmno+"%")
        	mlmnoInds = mlmnoInds?.sort{it.name}
        	}
	
	//now get unique inds and duplicate inds
	def mlist=[]
	if(mnameInds)
		mlist.add(mnameInds)
	//if(maddrInds)
	//	mlist.add(maddrInds)
	if(memailInds)
		mlist.add(memailInds)
	if(mphoneInds)
		mlist.add(mphoneInds)
	if(mpanInds)
		mlist.add(mpanInds)
	if(mlmnoInds)
		mlist.add(mlmnoInds)

	println "mlist before flatten"+mlist

	mlist = mlist.flatten()
	
	println "mlist after flatten"+mlist
	
	/*def uniques= [] as Set, dups= [] as Set
	mlist.each{ uniques.add(it.id) || dups.add(it.id) }
	uniques.removeAll(dups)
	
	println "Uniques : "+ uniques
	println "Duplicates : "+ dups
	
	def uniqInds = []
	def dupInds = []
	
	uniques.each{ uniqInds.add(Person.get(it)) }
	uniqInds = uniqInds?.sort{it.legalName}
	
	dups.each{dupInds.add(Individual.get(it))}
	dupInds = dupInds?.sort{it.legalName}
	
	if(dups.size()==1)
		{
		// found exact match
		dups.each{
			personInstance.matchedIndividual = Individual.get(it)
			}
		personInstance.status = "AUTOMATCHED"
		personInstance.save(flush:true)
		}
	else
		if(dups.size()==0 && uniques.size()==1)
			{
			// found exact match
			uniques.each{
				personInstance.matchedIndividual = Individual.get(it)
				}
			personInstance.status = "AUTOMATCHED"
			personInstance.save(flush:true)
			}
		else
			{
			personInstance.status = "NOAUTOMATCHED"
			personInstance.save(flush:true)
			}
	*/
	return	[personInstance:personInstance, mphoneInds: mphoneInds, maddrInds:maddrInds, memailInds:memailInds, mpanInds:mpanInds, mlmnoInds:mlmnoInds, mnameInds:mnameInds, category: params.category?:session.individualid]    	
    }

    def map() {
        println "In map with params : "+params
        def personInstance = Person.get(params.id)
        def ind = Individual.get(params.mid)
	if(ind)
		{
		personInstance.matchedIndividual = ind
		personInstance.status = "MATCHED"
		personInstance.updator = springSecurityService.principal.username
		personInstance.save(flush:true)
		}
	flash.message = personInstance.toString() + " ("+params.id+") matched to ("+params.mid+") " + ind.toString()
        if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
        {
		
		// first find if cultivator is present for the individual, else assign the logged in person as cultivator
		def cultivatorOfInd = Relationship.findByIndividual1AndRelation(Individual.get(params.mid),Relation.findByName('Cultivated by'))?.individual2
		println "cultivatorOfInd=" + cultivatorOfInd

		if(cultivatorOfInd == '' || cultivatorOfInd == null)
		{
			println "Assigning cultivator: " + params
			params."relation.id" = Relation.findByName('Cultivated by')?.id
			params."individual1.id" = params.mid
			params."individual2.id" = session.individualid //Individual.findByLoginid(login).id

			if (springSecurityService.isLoggedIn()) {
				params.creator=springSecurityService.principal.username
			}
			else
				params.creator=""
			params.updator=params.creator
			def errArr = []
			def hasErrors = false

			def relationshipInstance = new Relationship(params)
			relationshipInstance.status = "ACTIVE"
			relationshipInstance.relationshipGroup = RelationshipGroup.get(1)
			println "Saving relationship with params: " + params
			println "personInstance.matchedIndividual?.id: " + personInstance.matchedIndividual?.id
			if (relationshipInstance.save(flush: true)) 
			{
				println "Relationship saved"
				flash.message = "${message(code: 'default.created.message', args: [message(code: 'relationship.label', default: 'Relationship'), relationshipInstance.id])}"
				redirect(controller: "individual", action: "show", id: personInstance.matchedIndividual?.id)
			}
			else 
			{
				println "Relationship not saved"
				hasErrors = true

				relationshipInstance.errors.allErrors.each {
					println "Error in saving Relationship Instance :"+it
				}

			    	render(view: "create", model: [relationshipInstance: relationshipInstance])
			}
		}
		else
		{
			println 'code to notify nvccadmin about the cultivator conflict'
			personInstance.status = "CONFLICT"
			personInstance.save(flush:true)
			flash.message = "Cultivator conflict for "+ind+". Existing cultivator: "+cultivatorOfInd+", Mapping cultivator: "+Individual.get(session.individualid)+"."
			redirect(action:"list")
		}
	}
	else
		redirect (action: "next",params: [category:params.category])
    }
    
    def skip() {
        def personInstance = Person.get(params.id)
	if(personInstance)
		{
		personInstance.status = "SKIPPED"
		personInstance.updator = springSecurityService.principal.username
		personInstance.save(flush:true)
		}
		//redirect (action: "next",params: [category:params.category])
		redirect (action: "list")
    }
    
    def cultivate() {
        //todo verify this especially changes to Person
        def personInstance = Person.get(params.id)
	if(personInstance)
		{
		personInstance.updator = springSecurityService.principal.username
		}
        if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
        {
        	//create Individual from Person and set cultivator
        	def ind = new Individual()
        	ind.legalName = personInstance.name
        	ind.panNo = personInstance.panno
        	ind.membershipNo = personInstance.lmno
        	ind.remarks = personInstance.comments
        	if(personInstance.dob)
	        {
	        	//todo why h:m is required?
	        	//personInstance.dob = Date.parse('dd-MM-yyyy', personInstance.dob)
	        	ind.dob = personInstance.dob
	        }
	        if(personInstance.dom)
        	{
        		//personInstance.dom = Date.parse('dd-MM-yyyy', personInstance.dom)
        		ind.marriageAnniversary = personInstance.dom
        	}
		ind.creator = springSecurityService.principal.username
		ind.updator = ind.creator
        	//to do..all other fields and set cultivator
        	if(ind.save(flush:true))
        	{
			//update icsid
			ind.icsid = 100000+ind.id
			ind.save()
			
			//update the Person record
			personInstance.status="MOVED"
			personInstance.matchedIndividual = ind
			personInstance.save()
			
			println "Assigning cultivator: " + params
			params."relation.id" = Relation.findByName('Cultivated by')?.id
			params."individual1.id" = ind?.id
			params."individual2.id" = session.individualid //Individual.findByLoginid(login).id

			if (springSecurityService.isLoggedIn()) {
				params.creator=springSecurityService.principal.username
			}
			else
				params.creator=""
			params.updator=params.creator
			def errArr = []
			def hasErrors = false

			def relationshipInstance = new Relationship(params)
			relationshipInstance.status = "ACTIVE"
			relationshipInstance.relationshipGroup = RelationshipGroup.get(1)
			println "Saving relationship with params: " + params
			println "personInstance.matchedIndividual?.id: " + personInstance.matchedIndividual?.id
			if (relationshipInstance.save(flush: true)) 
			{
				println "Relationship saved"
				//flash.message = "${message(code: 'default.created.message', args: [message(code: 'relationship.label', default: 'Relationship'), relationshipInstance.id])}"
				log.debug("Creating further details for the person:"+personInstance)
				//save address
				if(personInstance.address)
				{
					def address = new Address()
					address.individual = ind
					address.category = "Correspondence"
					address.addressLine1 = personInstance.address
					address.addressLine2 = personInstance.locality?:""
					//address.addressLine3 = params.addressLine3?:""
					address.city = City.findByName("Pune")
					address.state = State.findByName("Maharashtra")
					address.country = Country.findByName("India")
					//address.pincode = params.pincode?:""
					address.creator = springSecurityService.principal.username
					address.updator = springSecurityService.principal.username
					log.debug("Creating person address:"+address)
					if (!address.save(flush: true)) {
						println "Error in saving address: "+address
						if(address.hasErrors()) {
						    address.errors.each {
							  println it
						    }
						}
					}
				}
				if(personInstance.officeAddress)
				{
					def address = new Address()
					address.individual = ind
					address.category = "Company"
					address.addressLine1 = personInstance.officeAddress
					//address.addressLine3 = params.addressLine3?:""
					address.city = City.findByName("Pune")
					address.state = State.findByName("Maharashtra")
					address.country = Country.findByName("India")
					//address.pincode = params.pincode?:""
					address.creator = springSecurityService.principal.username
					address.updator = springSecurityService.principal.username
					log.debug("Creating person office address:"+address)
					if (!address.save(flush: true)) {
						println "Error in saving address: "+address
						if(address.hasErrors()) {
						    address.errors.each {
							  println it
						    }
						}
					}
				}
				if(personInstance.phone)
				{
					def cellPhoneContact = new VoiceContact()
					cellPhoneContact.individual = ind
					cellPhoneContact.number = personInstance.phone
					cellPhoneContact.category = "CellPhone"

					cellPhoneContact.creator = springSecurityService.principal.username
					cellPhoneContact.updator = springSecurityService.principal.username
					log.debug("Creating person cellphone:"+cellPhoneContact)
					if (!cellPhoneContact.save(flush: true)) {
						println "Error in saving cellPhoneContact: "+cellPhoneContact
						if(cellPhoneContact.hasErrors()) {
						    cellPhoneContact.errors.each {
							  println it
						    }
						}
					}
				}
			
				if(personInstance.email)
				{
					def personalEmailContact = new EmailContact()
					personalEmailContact.individual = ind
					personalEmailContact.emailAddress = personInstance.email
					personalEmailContact.category = "Personal"

					personalEmailContact.creator = springSecurityService.principal.username
					personalEmailContact.updator = springSecurityService.principal.username
					log.debug("Creating person cellphone:"+personalEmailContact)
					if (!personalEmailContact.save(flush: true)) {
						println "Error in saving personalEmailContact: "+personalEmailContact
						if(personalEmailContact.hasErrors()) {
						    personalEmailContact.errors.each {
							  println it
						    }
						}
					}
				}
				redirect(controller: "individual", action: "show", id: ind?.id)
				return
			}
			else 
			{
				println "Relationship not saved"
				hasErrors = true

				relationshipInstance.errors.allErrors.each {
					println "Error in saving Relationship Instance :"+it
				}

				render(view: "create", model: [relationshipInstance: relationshipInstance])
				return
			}

			redirect(controller: "individual", action: "show", id: ind?.id)
			return
		}
	}
	else
		redirect (action: "next",params: [category:params.category])
    }
    
    def next(String category) {
	def nextPerson
	if(category)
		nextPerson = Person.findByStatusIsNullAndCategory(category)
	else
		nextPerson = Person.findByStatusIsNull()
	if(nextPerson)
        	redirect(action: "match", params: [id:nextPerson.id, category: category])
        else
        	{
        		flash.message = "No un-inspected records found!!"
        		redirect(action: "list", params: params)
        	}
    }

// return JSON list of customers
    def jq_person_list = {
    println 'PERSON LIST Params:'+params
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
      
      //def sql = new Sql(dataSource);
      String query = ""

	
      def persons = Person.createCriteria().list(max:maxRows, offset:rowOffset) {
      println 'params.creator:'+params.creator
            // filter by logged in person's contacts only
            if (session.individualid)
                eq('category',""+session.individualid)
                
            //filter records on status
            switch(params.code) {
            	case "MATCHED":
				or{
				eq('status',"AUTOMATCHED")
				eq('status',"MATCHED")
				}
				break
            	case "UNMATCHED":
			or{
				isNull('status')
				and{
					ne('status',"AUTOMATCHED")
					ne('status',"MATCHED")
					ne('status',"MOVED")
					}
			}
				break
            }
            
            // name case insensitive where the field contains with the search term
            if (params.name)
                ilike('name',params.name + '%')

            // address case insensitive where the field contains with the search term
            if (params.address)
                ilike('address','%'+params.address + '%')

            // phone case insensitive where the field contains with the search term
            if (params.phone)
                ilike('phone',params.phone + '%')

            // email case insensitive where the field contains with the search term
            if (params.email)
                ilike('email',params.email + '%')

            // dob search
            if (params.dob)
                eq('dob',Date.parse('dd-MM-yyyy', params.dob))

            // dom search
            if (params.dom)
                eq('dom',Date.parse('dd-MM-yyyy', params.dob))

            // category case insensitive where the field contains with the search term
            
            if (params.category)
            {
            	println "params.category="+params.category
			category{
				or{
				ilike('legalName',params.category + '%')
				ilike('initiatedName',params.category + '%')
				}
			}
            }
                //ilike('category','%'+params.category + '%')

            // creator case insensitive where the field contains with the search term
            if (params.creator)
                ilike('creator',params.creator + '%')

            order(sortIndex, sortOrder)
      }
      def totalRows = persons.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = persons.collect {
            [cell: [it.name,
                    it.address,
                    it.phone,
                    it.email,
                    it.dob?.format('dd-MM-yyyy'),
                    it.dom?.format('dd-MM-yyyy'),
                    (Individual.get(it.category?:0))?.toString(),
                    it.creator
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }
    
	def jq_edit_person = {
	      def person = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add instruction sent
		  //trim the params
		  params.each{it.value = it.value?.trim()}
		  if(params.dob)
		  	params.dob = Date.parse('dd-MM-yyyy', params.dob)
		  if(params.dom)
		  	params.dom = Date.parse('dd-MM-yyyy', params.dom)
		  person = new Person(params)
		  person.creator = springSecurityService.principal.username
		  person.updator = person.creator
		  person.category = session.individualid
		  if (! person.hasErrors() && person.save()) {
		    message = "Person ${person.name} Added"
		    id = person.id
		    state = "OK"
		    //send welcome mail if added by Atithi admin
		    	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_ATITHI_ADMIN') && person.email) {
		    	try{
				def template = Template.findByName("GuestReception Welcome Email")
				def body = commsService.fillTemplate(template,[person.name])
				def depcp = DepartmentCP.findByDepartment(Department.findByName("Guest Reception Department"))//@TODO: hardcoding
				commsService.sendMandrill([key:depcp?.cp?.apikey,sender:depcp.sender,toName:person.name,toEmail:person.email,emailsub:template.name,emailbody:body,type:template.type])		    	
		    		}
		    	catch(Exception e){log.debug("Exception in sending welcome email"+e)}
		    	}
		    		
				
		  } else {
		    person.errors.allErrors.each {
			println it
			}
		    message = "Could Not Save Person"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check person exists
			  person = Person.get(it)
			  if (person) {
			    // delete person
			    person.delete()
			    message = "Person  ${person.name} Deleted"
			    state = "OK"
			  }
		  	}
		  break;
		 default :
		  // edit action
		  // first retrieve the person by its ID
		  person = Person.get(params.id)
		  if (person) {
		  	  //trim the params
		 	  params.each{it.value = it.value?.trim()}
			  if(params.dob)
				params.dob = Date.parse('dd-MM-yyyy', params.dob)
			  if(params.dom)
				params.dom = Date.parse('dd-MM-yyyy', params.dom)

		    // set the properties according to passed in parameters
		    person.properties = params
			  person.updator = springSecurityService.principal.username
		    if (! person.hasErrors() && person.save()) {
		      message = "Person  ${person.name} Updated"
		      id = person.id
		      state = "OK"
		    } else {
			    person.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Person"
		    }
		  }
		  break;
 	 }

      def response = [message:message,state:state,id:id]

      render response as JSON
    }
    
    def upload() {
	    def f = request.getFile('myFile')
	    if (f.empty) {
		flash.message = 'file cannot be empty'
		render(view: 'uploadForm')
		return
	    }

	def template = Template.findByName("GuestReception Welcome Email")
	def depcp = DepartmentCP.findByDepartment(Department.findByName("Guest Reception Department"))//@TODO: hardcoding

	    def person
	    f.inputStream.toCsvReader(['skipLines':'1']).eachLine{ tokens ->
	    	if(tokens[0]?.trim()) {	    		
			person = new Person()
			person.name = tokens[0]
			person.address = tokens[1]
			person.phone = tokens[2]
			person.email = tokens[3]
			if(tokens.size()>4)
				try
					{
					person.dob = tokens[4]?Date.parse('dd-MM-yyyy', tokens[4]):null
					}
				catch(Exception e)
					{
					person.dob = null
					log.debug("In upload: Error formatting dob: "+tokens[4])
					}
			if(tokens.size()>5)
				try
					{
					person.dom = tokens[5]?Date.parse('dd-MM-yyyy', tokens[5]):null
					}
				catch(Exception e)
					{
					person.dom = null
					log.debug("In upload: Error formatting dom: "+tokens[5])
					}
			person.category = session.individualid
			person.updator = person.creator = springSecurityService.principal.username
			if(!person.save())
					person.errors.allErrors.each {
						println "Error in bulk saving person :"+it
					}
			else
				{
				log.debug(person.toString()+" saved!")
				//if added by guest reception the send the welcome email
				if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_ATITHI_ADMIN'))
					if(person.email)
						try{
							def body = commsService.fillTemplate(template,[person.name])
							commsService.sendMandrill([key:depcp?.cp?.apikey,sender:depcp.sender,toName:person.name,toEmail:person.email,emailsub:template.name,emailbody:body,type:template.type])		    	
							}
						catch(Exception e){log.debug("Exception in sending welcome email"+e)}
				}
		    }
	    }
	    
	    redirect (action: "list")
    }
    
    def dashboard() {
    	render "Coming soon.."
    }

    def mail() {
    	def key = DepartmentCP.get(1)?.cp?.apikey
    	log.debug("Ping: "+mandrillService.ping(key))
    	log.debug("Info: "+mandrillService.info(key))
	def recpts = []
	recpts.add(new MandrillRecipient(name:"foo", email:"kaushal.prashant@gmail.com"))
	recpts.add(new MandrillRecipient(name:"bar", email:"prashant_kaushal2003@yahoo.com"))
	def message = new MandrillMessage(
					  text:"this is a text message",
					  subject:"this is a subject",
					  from_email:"guest.reception.nvcc@gmail.com",
					  to:recpts)
	message.tags.add("test")
	log.debug("Send: "+mandrillService.send(key,message))

      def response = [message:"OK",state:"GOOD"]

      render response as JSON
    }

}
