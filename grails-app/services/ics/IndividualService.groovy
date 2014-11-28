package ics
import org.codehaus.groovy.grails.plugins.springsecurity.*

class IndividualService {
    def springSecurityService
    def housekeepingService

    def serviceMethod() {
    }

    
    def createIndividual(Map params) {
	log.debug("creTEW ind"+params)
    def donor = new Individual(params)
	donor.updator = donor.creator = springSecurityService.principal.username
	donor.legalName = params.donorName
	donor.initiatedName = params.initiatedName?.trim()
	donor.panNo = params.donorPAN
	log.debug("IndService:Creating new donor: "+donor)
	if(!donor.save())
		donor.errors.allErrors.each {println it}
	else
		{
		def city 
		if(params.cityid)
			city = City.get(params.cityid)
		else
			city = City.findByName(params.donorCity)
		if(params.donorCity && !city)
			{
			city = new City(name:params.donorCity,creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
			city.save()
			}
		def state 
		if(params.stateid)
			state = State.get(params.stateid)
		else
			state = State.findByName(params.donorState)
		if(params.donorState && !state)
			{
			state = new State(name:params.donorState,creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
			state.save()
			}
		def country 
		if(params.countryid)
			country = Country.get(params.countryid)
		else
			country = Country.findByName(params.donorCountry)
		if(params.donorCountry && !country)
			{
			country = new Country(name:params.donorCountry,creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
			country.save()
			}

		def addr = null
		if(params.donorAddress)
			{
			addr = new Address(individual:donor,addressLine1:params.donorAddress,city:city,state:state,country:country,pincode:params.donorPin,category:'Correspondence',creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
			if(!addr.save())
				addr.errors.allErrors.each {println it}
			else
				{
				donor.address = []
				donor.address.add(addr)
				}
			}
		def vc = null
		if(params.donorContact)
			{
			vc = new VoiceContact(category:"CellPhone",number:params.donorContact,individual:donor,creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
			if(!vc.save())
				vc.errors.allErrors.each {println it}				
			else
				{
				donor.voiceContact = []
				donor.voiceContact.add(vc)
				}
			}
		def ec = null
		if(params.donorEmail)
			{
			ec = new EmailContact(category:"Personal",emailAddress:params.donorEmail,individual:donor,creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
			if(!ec.save())
				ec.errors.allErrors.each {println it}				
			else
				{
				donor.emailContact = []
				donor.emailContact.add(ec)
				}
			}
		//update icsid
		donor.icsid = 100000+donor.id
		if(!donor.save(flush:true))
			donor.errors.allErrors.each {println it}
		//if the logged in user is connected to a particular centre, 
		//mark this individual also to belong to the same centre
		def loggedInd = Individual.findByLoginid(springSecurityService.principal.username)
		def indcentre = IndividualCentre.findByIndividualAndStatus(loggedInd,'VALID')
		if(indcentre)
			{
			def ic = new IndividualCentre()
			ic.individual = donor
			ic.centre = indcentre.centre
			ic.status = 'VALID'
			ic.updator = ic.creator = springSecurityService.principal.username
			if(!ic.save())
				ic.errors.allErrors.each {println it}
			}
		//if the logged in user belongs to PC then make him the cultivator
          	if (SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE_HEAD,ROLE_PATRONCARE,ROLE_PATRONCARE_USER')){
			def cultReln = new Relationship()
			cultReln.relation = Relation.findByName('Cultivated by')
			cultReln.individual1 = donor
			cultReln.individual2 = loggedInd
			cultReln.status = 'ACTIVE'
			cultReln.relationshipGroup = RelationshipGroup.findByGroupName('dummy')
			cultReln.updator = cultReln.creator = springSecurityService.principal.username
			if(!cultReln.save())
				cultReln.errors.allErrors.each {println it}
			}
			
		}
	return donor
    }
    
    def setCultivator(Map params) {
    	def count = 0
    	def individual,rship
    	def cultivator = Individual.get(params.indid)
    	if(!cultivator)
    		return 0
	def reln = Relation.findByName('Cultivated by')
	def rg = RelationshipGroup.findByGroupName('dummy')
	def idList = params.idList.tokenize(',')
	idList.each{id->
		individual = Individual.get(id)
		//first inactive any existing reln
		rship = Relationship.findWhere(individual1:individual,relation:reln,status:'ACTIVE')
		if(rship)
			{
			rship.status='INACTIVE'
			rship.updator = springSecurityService.principal.username
			if(!rship.save())
				rship.errors.allErrors.each {println it}
			
			}
		//now create new rship
		rship = new Relationship()
		rship.individual1 = individual
		rship.individual2 = cultivator
		rship.relation = reln
		rship.relationshipGroup = rg
		rship.status = 'ACTIVE'
		rship.updator = rship.creator = springSecurityService.principal.username
		if(!rship.save())
			rship.errors.allErrors.each {println it}
		count++
	}
	return count    	
    }
    
    def createBasicIndividual(Map params) {
    	//first check for exact duplicate (on legalName or initiatedName)
    	if(!params.name)
    		return null
    	def individuals = Individual.findAllByLegalNameOrInitiatedName(params.name,params.name)
    	if(individuals.size()>0)
    		return individuals[0]
    	else
    		{
    		//create basic individual
    		def individual = new Individual(params)
    		individual.legalName = params.name
    		individual.updator = individual.creator = springSecurityService.principal.username
		if(!individual.save())
			{
			individual.errors.allErrors.each {println it}
			return null
			}
		//update icsid
		individual.icsid = 100000 + individual.id
    		individual.save()
    		return individual
    		}
    }
    
    def profileSummary(String indId) {
    	def ind = Individual.get(indId)
    	def counsellor,cultivator,collectors,recentCollector
    	if(ind) {
    		def counsellorReln = Relation.findByName('Councellee of')
    		def cultivatorReln = Relation.findByName('Cultivated by')
    		def clorRship = Relationship.findWhere(individual1:ind,relation:counsellorReln,status:'ACTIVE')
    		counsellor = clorRship?.individual2?.toString()
    		def cultRship = Relationship.findWhere(individual1:ind,relation:cultivatorReln,status:'ACTIVE')
    		cultivator = cultRship?.individual2?.toString()
    		def donations = Donation.findAllByDonatedBy(ind,[sort:'donationDate',order:'desc'])
    		recentCollector = donations[0]?.collectedBy?.toString()
    		def uniqueCollectors = donations?.collect{it.donatedBy}?.flatten()?.unique()
    		collectors = uniqueCollectors?.collect{it.toString()+" , "}
    	}
    	return [counsellor: counsellor?:'', cultivator: cultivator?:'', collectors: collectors?:'', recentCollector: recentCollector?:'']
    }
    
    def voiceUpdate(Map params) {
        //log.debug("Inside voiceUpdate with params.."+params)
        def individualInstance = Individual.get(params.id)
        if (individualInstance) {
		//@TODO: category hardcoding
		individualInstance.category='VOICE'
		
		//date formatting
		if(params.dob)
			params.dob = Date.parse('dd-MM-yyyy', params.dob)
		if(params.marriageAnniversary)
			params.marriageAnniversary = Date.parse('dd-MM-yyyy', params.marriageAnniversary)
		if(params.firstInitiation)
			params.firstInitiation = Date.parse('dd-MM-yyyy', params.firstInitiation)
		if(params.secondInitiation)
			params.secondInitiation = Date.parse('dd-MM-yyyy', params.secondInitiation)			
		if(params.introductionDate)
			params.introductionDate = Date.parse('dd-MM-yyyy', params.introductionDate)
		if(params.sixteenRoundsDate)
			params.sixteenRoundsDate = Date.parse('dd-MM-yyyy', params.sixteenRoundsDate)
		if(params.voiceDate)
			params.voiceDate = Date.parse('dd-MM-yyyy', params.voiceDate)
		if(params.joinAshram)
			params.joinAshram = Date.parse('dd-MM-yyyy', params.joinAshram)
			
		//set the primitive fields
		individualInstance.properties = params
		//motherTongue
		if(params.motherTongue)
			{
			individualInstance.motherTongue = Language.get(params.motherTongue)?.name
			}
		
		
		//set or reset complex fields
		//Mobile
		def mobile = VoiceContact.findByIndividualAndCategory(individualInstance,'CellPhone')
		if(mobile)
			{
			//update existing
			mobile.number = params.mobile
			mobile.updator = springSecurityService.principal.username
			}
		else
			{
			//create new
			if(params.mobile)
				{
				mobile = new VoiceContact()
				mobile.individual = individualInstance
				mobile.category = 'CellPhone'
				mobile.number = params.mobile
				mobile.creator = mobile.updator = springSecurityService.principal.username
				}
			}
		if(mobile && !mobile.save())
			mobile.errors.allErrors.each {println it}

		//HomePhone
		def homephone = VoiceContact.findByIndividualAndCategory(individualInstance,'HomePhone')
		if(homephone)
			{
			//update existing
			homephone.number = params.home
			homephone.updator = springSecurityService.principal.username
			}
		else
			{
			//create new
			if(params.home)
				{
				homephone = new VoiceContact()
				homephone.individual = individualInstance
				homephone.category = 'HomePhone'
				homephone.number = params.home
				homephone.creator = homephone.updator = springSecurityService.principal.username
				}
			}
		if(homephone && !homephone.save())
			homephone.errors.allErrors.each {println it}

		//Email
		def ec = EmailContact.findByIndividualAndCategory(individualInstance,'Personal')
		if(ec)
			{
			//update existing
			ec.emailAddress = params.emailPersonal
			ec.updator = springSecurityService.principal.username
			}
		else
			{
			//create new
			if(params.emailPersonal)
				{
				ec = new EmailContact()
				ec.individual = individualInstance
				ec.category = 'Personal'
				ec.emailAddress = params.emailPersonal
				ec.creator = ec.updator = springSecurityService.principal.username
				}
			}
		if(ec && !ec.save())
			ec.errors.allErrors.each {println it}

		//Present address
		def addr = Address.findByIndividualAndCategory(individualInstance,'Correspondence')
		if(addr)
			{
			//update existing
			addr.addressLine1 = params.presentAddress
			addr.updator = springSecurityService.principal.username
			}
		else
			{
			//create new
			if(params.presentAddress)
			{
				addr = new Address()
				addr.individual = individualInstance
				addr.category = 'Correspondence'
				addr.addressLine1 = params.presentAddress
				addr.creator = addr.updator = springSecurityService.principal.username
			}
			}
		if(addr&&!addr.save())
			addr.errors.allErrors.each {println it}

		//Permanent address
		addr = Address.findByIndividualAndCategory(individualInstance,'Permanent')
		if(addr)
			{
			//update existing
			addr.addressLine1 = params.permanentAddress
			addr.updator = springSecurityService.principal.username
			}
		else
			{
			//create new
			if(params.permanentAddress)
			{
			addr = new Address()
			addr.individual = individualInstance
			addr.category = 'Permanent'
			addr.addressLine1 = params.permanentAddress
			addr.creator = addr.updator = springSecurityService.principal.username
			}
			}
		if(addr&&!addr.save())
			addr.errors.allErrors.each {println it}

		//Office address
		addr = Address.findByIndividualAndCategory(individualInstance,'Company')
		if(addr)
			{
			//update existing
			addr.addressLine1 = params.officeAddress
			addr.updator = springSecurityService.principal.username
			}
		else
			{
			//create new
			if(params.officeAddress)
			{
			addr = new Address()
			addr.individual = individualInstance
			addr.category = 'Company'
			addr.addressLine1 = params.officeAddress
			addr.creator = addr.updator = springSecurityService.principal.username
			}
			}
		if(addr && !addr.save())
			addr.errors.allErrors.each {println it}

		//single value fields
		//Father's name
		def fInd = Relationship.createCriteria().list{eq('status','ACTIVE') eq('individual2',individualInstance) relation{eq('name','Father')} }[0]?.individual1
		if(fInd)
			{
			//update
			fInd.legalName = params.fatherName
			fInd.updator = springSecurityService.principal.username			
			if(!fInd.save())
				fInd.errors.allErrors.each {println it}
			}
		else
			{
			//create
			if(params.fatherName)
				{
				fInd = new Individual()
				fInd.legalName = params.fatherName
				fInd.creator = fInd.updator = springSecurityService.principal.username
				if(!fInd.save())
					fInd.errors.allErrors.each {println it}
				else
					{
					fInd.icsid = 100000+fInd.id
					fInd.save()
					//now create relationship group
					def rg = new RelationshipGroup()
					rg.groupName = "Family of "+individualInstance.toString()
					rg.refid = individualInstance.id
					rg.creator = rg.updator = springSecurityService.principal.username
					if(!rg.save())
						rg.errors.allErrors.each {println it}
					else
						{				
						//now create relationship 
						def fRship = new Relationship()
						fRship.individual1 = fInd
						fRship.individual2 = individualInstance
						fRship.relation = Relation.findByName('Father')
						fRship.relationshipGroup = rg
						fRship.status = 'ACTIVE'
						fRship.creator = fRship.updator = springSecurityService.principal.username
						if(!fRship.save())
							fRship.errors.allErrors.each {println it}					
						}
					}	
				}
			}

		//Mother's name
		def mInd = Relationship.createCriteria().list{eq('status','ACTIVE') eq('individual2',individualInstance) relation{eq('name','Mother')} }[0]?.individual1
		if(mInd)
			{
			//update
			mInd.legalName = params.motherName
			mInd.updator = springSecurityService.principal.username			
			if(!mInd.save())
				mInd.errors.allErrors.each {println it}
			}
		else
			{
			//create
			if(params.motherName)
				{
				mInd = new Individual()
				mInd.legalName = params.motherName
				mInd.creator = mInd.updator = springSecurityService.principal.username
				if(!mInd.save())
					mInd.errors.allErrors.each {println it}
				else
					{
					mInd.icsid = 100000+mInd.id
					mInd.save()
					//now create relationship group
					def mrg = RelationshipGroup.findByRefid(individualInstance.id)
					if(!mrg)
						{
						mrg = new RelationshipGroup()
						mrg.groupName = "Family of "+individualInstance.toString()
						mrg.refid = individualInstance.id
						mrg.creator = mrg.updator = springSecurityService.principal.username
						if(!mrg.save())
							mrg.errors.allErrors.each {println it}
						}
					if(mrg)
						{				
						//now create relationship 
						def mRship = new Relationship()
						mRship.individual1 = mInd
						mRship.individual2 = individualInstance
						mRship.relation = Relation.findByName('Mother')
						mRship.relationshipGroup = mrg
						mRship.status = 'ACTIVE'
						mRship.creator = mRship.updator = springSecurityService.principal.username
						if(!mRship.save())
							mRship.errors.allErrors.each {println it}					
						}
					}
				}
			}

		//guru
		if(params.'guruid')
		{
		def oldRship = Relationship.createCriteria().list{eq('status','ACTIVE') eq('individual1',individualInstance) relation{eq('name','Disciple of')}}[0]
		if(oldRship)
			{
			//inactive old clor if not the same
			if(oldRship.individual2.id != new Integer(params.'guruid'))
				{
				oldRship.status = 'INACTIVE'
				oldRship.updator = springSecurityService.principal.username			
				if(!oldRship.save())
					oldRship.errors.allErrors.each {println it}
				}
			}
		//now create new rship
		def newRship = new Relationship()
		newRship.individual1 = individualInstance
		newRship.individual2 = Individual.get(params.'guruid')
		newRship.relation = Relation.findByName('Disciple of')
		newRship.relationshipGroup = RelationshipGroup.findByGroupName('dummy')
		newRship.status = 'ACTIVE'
		newRship.creator = newRship.updator = springSecurityService.principal.username
		if(!newRship.save())
			newRship.errors.allErrors.each {println it}					
		}

		//Current counsellor
		if(params.'currentClorid')
		{
		def oldRship = Relationship.createCriteria().list{eq('status','ACTIVE') eq('individual1',individualInstance) relation{eq('name','Councellee of')}}[0]
		if(oldRship)
			{
			//inactive old clor if not the same
			if(oldRship.individual2.id != new Integer(params.'currentClorid'))
				{
				oldRship.status = 'INACTIVE'
				oldRship.updator = springSecurityService.principal.username			
				if(!oldRship.save())
					oldRship.errors.allErrors.each {println it}
				}
			}
		//now create new rship
		def newRship = new Relationship()
		newRship.individual1 = individualInstance
		newRship.individual2 = Individual.get(params.'currentClorid')
		newRship.relation = Relation.findByName('Councellee of')
		newRship.relationshipGroup = RelationshipGroup.findByGroupName('dummy')
		newRship.status = 'ACTIVE'
		newRship.creator = newRship.updator = springSecurityService.principal.username
		if(!newRship.save())
			newRship.errors.allErrors.each {println it}					
		}

		//Current centre
		if(params.'currentCentreid')
		{
		def oldIndCentre = IndividualCentre.createCriteria().list{eq('status','ACTIVE') eq('individual',individualInstance)}[0]
		if(oldIndCentre)
			{
			//inactive old centre if not the same
			if(oldIndCentre.centre.id != new Integer(params.'currentCentreid'))
				{
				oldIndCentre.status = 'INACTIVE'
				oldIndCentre.updator = springSecurityService.principal.username			
				if(!oldIndCentre.save())
					oldIndCentre.errors.allErrors.each {println it}
				}
			}
		//now create new ind centre
		def newIndCentre = new IndividualCentre()
		newIndCentre.individual = individualInstance
		newIndCentre.centre = Centre.get(params.'currentCentreid')
		newIndCentre.status = 'ACTIVE'
		newIndCentre.creator = newIndCentre.updator = springSecurityService.principal.username
		if(!newIndCentre.save())
			newIndCentre.errors.allErrors.each {println it}					
		}

		//First counsellor
		if(params.'firstClorid')
		{
		def oldRship = Relationship.createCriteria().list{eq('status','FIRST') eq('individual1',individualInstance) relation{eq('name','Councellee of')}}[0]
		if(oldRship)
			{
			oldRship.delete()
			}
		//now create new rship
		def newRship = new Relationship()
		newRship.individual1 = individualInstance
		newRship.individual2 = Individual.get(params.'firstClorid')
		newRship.relation = Relation.findByName('Councellee of')
		newRship.relationshipGroup = RelationshipGroup.findByGroupName('dummy')
		newRship.status = 'FIRST'
		newRship.creator = newRship.updator = springSecurityService.principal.username
		if(!newRship.save())
			newRship.errors.allErrors.each {println it}					
		}

		//First centre
		if(params.'firstCentreid')
		{
		def oldIndCentre = IndividualCentre.createCriteria().list{eq('status','FIRST') eq('individual',individualInstance)}[0]
		if(oldIndCentre)
			{
				oldIndCentre.delete()
			}
		//now create new ind centre
		def newIndCentre = new IndividualCentre()
		newIndCentre.individual = individualInstance
		newIndCentre.centre = Centre.get(params.'firstCentreid')
		newIndCentre.status = 'FIRST'
		newIndCentre.creator = newIndCentre.updator = springSecurityService.principal.username
		if(!newIndCentre.save())
			newIndCentre.errors.allErrors.each {println it}					
		}
		
		//Easy commitment
		def oldCommitment = Commitment.createCriteria().list{eq('committedBy',individualInstance) scheme{eq('name','EASY')}}[0]
		if(oldCommitment)
			{
			//update
					
			oldCommitment.committedAmount = new BigDecimal(params.easyCommitment).intValue()
			oldCommitment.updator = springSecurityService.principal.username
			
			if(!oldCommitment.save())
				oldCommitment.errors.allErrors.each {println it}
			}
			
		else
			{
			//create new
			if(params.easyCommitment)
			{
			def newCommitment = new Commitment()
			newCommitment.committedAmount = new BigDecimal(params.easyCommitment).intValue()
			newCommitment.committedBy = individualInstance
			newCommitment.scheme = Scheme.findByName('EASY')
			newCommitment.status = 'ACTIVE'
			newCommitment.commitmentOn = new Date()
			newCommitment.creator = newCommitment.updator = springSecurityService.principal.username
			if(newCommitment&&!newCommitment.save())
				newCommitment.errors.allErrors.each {println it}
			}
			}
			

		//NityaSeva Commitment
		def oldNSCommitment = Commitment.createCriteria().list{eq('committedBy',individualInstance) scheme{eq('name','Nitya Seva')}}[0]
		if(oldNSCommitment)
			{
			//update
			oldNSCommitment.committedAmount = new BigDecimal(params.nsCommitment).intValue()
			oldNSCommitment.updator = springSecurityService.principal.username			
			if(!oldNSCommitment.save())
				oldNSCommitment.errors.allErrors.each {println it}
			}
		else
			{
			//create new
			if(params.nsCommitment)
			{
			def newNSCommitment = new Commitment()
			newNSCommitment.committedAmount = new Integer(params.nsCommitment)
			newNSCommitment.committedBy = individualInstance
			newNSCommitment.scheme = Scheme.findByName('Nitya Seva')
			newNSCommitment.status = 'ACTIVE'
			newNSCommitment.commitmentOn = new Date()
			newNSCommitment.creator = newNSCommitment.updator = springSecurityService.principal.username
			if(newNSCommitment&&!newNSCommitment.save())
				newNSCommitment.errors.allErrors.each {println it}
			}
			}

		//multiple value fields
		//courses/camps/workshops
		//first clean all courses/camps
		def cl = IndividualCourse.createCriteria().list{eq('individual',individualInstance) course{eq('category','Voice') or{eq('type','EBG Course') eq('type','Other Courses') eq('type','Camp') eq('type','Workshop')}}}
		cl.each{ic->
			ic.delete()
		}
		
		//EBG Courses
		def courselist = params.list("ebgcourses")
		//Other courses
		courselist += params.list("otherCourses")
		//Camps
		courselist += params.list("campsAttended")
		//Workshops
		courselist += params.list("workshopsAttended")
		courselist = courselist.flatten()
		//now create
		courselist.each{c->
			def individualCourse = new IndividualCourse()
			individualCourse.course = Course.get(c)
			if(individualCourse.course)
				{
				individualCourse.individual = individualInstance
				individualCourse.creator = springSecurityService.principal.username
				individualCourse.updator = springSecurityService.principal.username
				if(!individualCourse.save())
					individualCourse.errors.allErrors.each {println it}
				}
			}

		//Books read
		def booklist = params.list("srilPrabhupadaBooksRead")
		//first clean all books read
		def brl = BookRead.createCriteria().list{eq('individual',individualInstance) book{eq('author','Srila Prabhupada')}}
		brl.each{br->
			br.delete()
		}
		booklist.each{b->
			def bookRead = new BookRead()
			bookRead.book = Book.get(b)
			if(bookRead.book)
				{
				bookRead.individual = individualInstance
				bookRead.creator = springSecurityService.principal.username
				bookRead.updator = springSecurityService.principal.username
				if(!bookRead.save())
					bookRead.errors.allErrors.each {println it}
				}
			}

		//LanguagesKnown
		 def languageslist = params.list("languagesKnown")
		//first clean all languages known
		def currentLanguages = IndividualLanguage.createCriteria().list{eq('individual',individualInstance)}
		currentLanguages.each{lk->
			lk.delete()
		}
		languageslist.each{c->
			def individualLanguage = new IndividualLanguage()
			individualLanguage.language = Language.get(c)
			if(individualLanguage.language)
				{
				individualLanguage.individual = individualInstance
				individualLanguage.creator = springSecurityService.principal.username
				individualLanguage.updator = springSecurityService.principal.username
				if(!individualLanguage.save())
					individualLanguage.errors.allErrors.each {println it}
				}								
			}

		//roles
		 def rolelist = params.list("roles")
		//first clean 
		def currentRoles = IndividualRole.createCriteria().list{eq('individual',individualInstance)  role{eq('category','VOICE')}}
		currentRoles.each{it->
			it.delete()
		}
		rolelist.each{c->
			def individualRole = new IndividualRole()
			individualRole.role = Role.get(c)
			if(individualRole.role)
				{
				individualRole.individual = individualInstance
				individualRole.status = 'VALID'
				individualRole.creator = springSecurityService.principal.username
				individualRole.updator = springSecurityService.principal.username
				if(!individualRole.save())
					individualRole.errors.allErrors.each {println it}
				}								
			}

		//Services rendered
		 def listofServices = params.list("listofServices")
		//first clean existing data
		def currentSvc = IndividualSeva.createCriteria().list{eq('individual',individualInstance)}
		currentSvc.each{it->
			it.delete()
		}
		listofServices.each{it->
			def individualSeva = new IndividualSeva()
			individualSeva.seva = Seva.get(it)
			if(individualSeva.seva)
				{
				individualSeva.individual = individualInstance
				individualSeva.status = 'ACTIVE'
				individualSeva.creator = springSecurityService.principal.username
				individualSeva.updator = springSecurityService.principal.username
				if(!individualSeva.save())
					individualSeva.errors.allErrors.each {println it}
				}								
			}
		//Skills
		 def indSkills = params.list("indSkills")
		//first clean existing data
		def currentSkills = IndividualSkill.createCriteria().list{eq('individual',individualInstance)}
		currentSkills.each{it->
			it.delete()
		}
		indSkills.each{it->
			def individualSkill = new IndividualSkill()
			individualSkill.skill = Skill.get(it)
			if(individualSkill.skill)
				{
				individualSkill.individual = individualInstance
				individualSkill.status = 'ACTIVE'
				individualSkill.creator = springSecurityService.principal.username
				individualSkill.updator = springSecurityService.principal.username
				if(!individualSkill.save())
					individualSkill.errors.allErrors.each {println it}
				}								
			}

        return individualInstance
        }
       
    }

    def createIndividualFromER(EventRegistration er) {
	def individual = new Individual()
	individual.updator = individual.creator = springSecurityService.principal.username
	individual.legalName = er.name?.trim()
	individual.dob = er.dob
	individual.isMale = er.isMale
	individual.companyName = er.connectedIskconCenter
	individual.category = 'GPL'
	if(!individual.save())
		individual.errors.allErrors.each {println it}
	else
		{
		def city 
		if(!city)
			city = City.findByName("Other")
		def state 
		if(!state)
			state = State.findByName("Other")
		def country 
		if(!country)
			country = Country.findByName("Other")

		def addr = null
		if(er.address)
			{
			addr = new Address(individual:individual,addressLine1:er.address,city:city,state:state,country:country,pincode:er.addressPincode,category:'Correspondence',creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
			if(!addr.save())
				addr.errors.allErrors.each {println it}
			else
				{
				individual.address = []
				individual.address.add(addr)
				}
			}
		def vc = null
		if(er.contactNumber)
			{
			vc = new VoiceContact(category:"CellPhone",number:er.contactNumber,individual:individual,creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
			if(!vc.save())
				vc.errors.allErrors.each {println it}				
			else
				{
				individual.voiceContact = []
				individual.voiceContact.add(vc)
				}
			}
		def ec = null
		if(er.email)
			{
			ec = new EmailContact(category:"Personal",emailAddress:er.email,individual:individual,creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
			if(!ec.save())
				ec.errors.allErrors.each {println it}				
			else
				{
				individual.emailContact = []
				individual.emailContact.add(ec)
				}
			}
		//generate loginid
		individual.loginid = housekeepingService.createLogin(individual, com.krishna.IcsRole.findByAuthority('ROLE_ASMT_USER'))

		//update icsid
		individual.icsid = 100000+individual.id

		if(!individual.save(flush:true))
			individual.errors.allErrors.each {println it}
			
		}
	return individual
    }

    
 }
  

