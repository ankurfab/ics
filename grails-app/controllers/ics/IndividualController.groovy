package ics

import com.krishna.*
import groovy.sql.Sql;
import grails.converters.JSON
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import java.util.zip.ZipOutputStream  
import java.util.zip.ZipEntry  
import org.grails.plugins.csv.CSVWriter
import org.apache.commons.lang.StringEscapeUtils.*

class IndividualController {
def dataSource ; 
def housekeepingService
def helperService
def springSecurityService
def exportService
def reportService
def followupService
def individualService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def search() {
	withMobileDevice { device ->
	      render(view: 'mSearch', model: [])
	      return
	   }
    }
    
    def index = {
    	if(params.recreateindex)
    		Individual.reindex()
    		
	def sql = new Sql(dataSource)
	def maxDonationQry = "select max(amount) from donation"
	
	def maxDonationResult = sql.firstRow(maxDonationQry)


	println "---maxDonationResult:"+ maxDonationResult
	sql.close()		
	[maxDonationResult:maxDonationResult]
    }

	//export the data
	def export()
	{
		response.contentType = ConfigurationHolder.config.grails.mime.types['excel']
		response.setHeader("Content-disposition", "attachment; filename=data.xls")
		exportService.export('excel', response.outputStream,Role.list(params), [:], [:]) 
	}

	def devoteelist(){
	}
	
	def list(){
	}

	def voiceList(){
	}

	def oldlist = {
	
		params.max = Math.min(params.max ? params.int('max') : 25, 100)
		if(!params.sort)
			params.sort = "id"
		if(!params.order)
			params.order = "desc"

		def retList = []

		def flag=false
		def full=false

		if(params.type)
		{
			def loggedIndividual = Individual.findByLoginid(springSecurityService.principal.username)
			def crel = Relation.findByName("Councellee of")
			def mrel = Relation.findByName("Mentee of")
			def wrel = Relation.findByName("Cultivated by")
			def rg = RelationshipGroup.findByGroupName("dummy")
			def rships

			if(!params.type && org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAllGranted('ROLE_COUNSELLOR'))
				params.type='Counsellee'	//hard coding


			switch(params.type)
			{
				case 'Counsellee':
					rships = Relationship.findAllByIndividual2AndRelation(loggedIndividual,crel)
					break
				case 'Mentee':
					rships = Relationship.findAllByIndividual2AndRelation(loggedIndividual,mrel)
					break
				case 'Wellwisher':
					rships = Relationship.findAllByIndividual2AndRelation(loggedIndividual,wrel)
					break
				default:
					flag=true
					retList = Individual.list(params)
			}

			rships.each {rs->
				if(rs.status=="ACTIVE")
					retList.add(rs.individual1)
				}

		}
		else if(params.status)
			{
				println "Individual list for status: "+ params.status
				def flagsList = []
				if(params.updator)
					flagsList = Flags.findAllByFormstatusAndUpdator(params.status,params.updator)
				else
					flagsList = Flags.findAllByFormstatus(params.status)
				def ilist = []
				flagsList.each{f->ilist.add(f.individualid)}
				println params.status+" : List of Indivuals : "+ ilist
				retList = Individual.getAll(ilist)
			}
			else
			{
				retList = Individual.list(params)
				flag = true
			}

		[individualInstanceList: retList, individualInstanceTotal: Individual.count(), type: params.type, flag: flag]


    }

    def donorsList = {
	def login = springSecurityService.principal.username
	println "Loggedin user: "+login
	def individual = Individual.findByLoginid(login)
	println "setSessionParams for: "+individual

	def IndRole = []//, pcRole = []
	IndRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID")
	println 'IndRole='+IndRole

	//for(int i=0; i<IndRole.size(); i++)
	//	pcRole.add(IndRole[i].role)
	//def pcRole = IndividualRole.findAllByIndividualAndStatus(Individual.findByLoginid(login),"VALID").role
	//println 'pcRole='+pcRole

	def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
	println 'pcRole='+pcRole
	def patronCareHead, patronCareSevaks = [], loggedInUserRole
	def individualInstanceList = [], individualRels = []
	def cultivatedByRelation = Relation.findByName("Cultivated by")

	for(int i=0; i<pcRole.size(); i++)
	{
		if(pcRole[i].toString() == "PatronCare")
		{
			loggedInUserRole = "PatronCare"
			individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
			
			println 'individualRels.size()='+individualRels.size()
			for(int j=0; j<individualRels.size(); j++)
			{
				if(individualRels[j].individual1?.isDonor==true)
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
					if(individualRels[j].individual1?.isDonor==true)
						individualInstanceList.add(individualRels[k].individual1)
				}
			}
		}
		if(pcRole[i].toString() == "PatronCareSevak")
		{
			loggedInUserRole = "PatronCareSevak"
			individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
			for(int j=0; j<individualRels.size(); j++)
			{
				if(individualRels[j].individual1?.isDonor==true)
					individualInstanceList[j] = individualRels[j].individual1
			}
		}			
	}
	println 'loggedInUserRole='+loggedInUserRole
	individualInstanceList = individualInstanceList.unique()
	
	[individualInstanceList: individualInstanceList, individualInstanceTotal: individualInstanceList.size(), loggedInUserRole: loggedInUserRole]

    }
    
    def nonDonorsList = {
	def login = springSecurityService.principal.username
	println "Loggedin user: "+login
	def individual = Individual.findByLoginid(login)
	println "setSessionParams for: "+individual

	def IndRole = []//, pcRole = []
	IndRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID")
	println 'IndRole='+IndRole

	//for(int i=0; i<IndRole.size(); i++)
	//	pcRole.add(IndRole[i].role)
	//def pcRole = IndividualRole.findAllByIndividualAndStatus(Individual.findByLoginid(login),"VALID").role
	//println 'pcRole='+pcRole

	def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
	println 'pcRole='+pcRole
	def patronCareHead, patronCareSevaks = [], loggedInUserRole
	def individualInstanceList = [], individualRels = []
	def cultivatedByRelation = Relation.findByName("Cultivated by")

	for(int i=0; i<pcRole.size(); i++)
	{
		if(pcRole[i].toString() == "PatronCare")
		{
			loggedInUserRole = "PatronCare"
			individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
			
			for(int j=0; j<individualRels.size(); j++)
			{
				if(individualRels[j].individual1?.isDonor==false)
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
					if(individualRels[j].individual1?.isDonor==false)
						individualInstanceList.add(individualRels[k].individual1)
				}
			}
		}
		if(pcRole[i].toString() == "PatronCareSevak")
		{
			loggedInUserRole = "PatronCareSevak"
			individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
			for(int j=0; j<individualRels.size(); j++)
			{
				if(individualRels[j].individual1?.isDonor==false)
					individualInstanceList[j] = individualRels[j].individual1
			}
		}			
	}
	println 'loggedInUserRole='+loggedInUserRole
	individualInstanceList = individualInstanceList.unique()
	[individualInstanceList: individualInstanceList, individualInstanceTotal: individualInstanceList.size(), loggedInUserRole: loggedInUserRole]

    }
    
    def create = {
        def individualInstance = new Individual()
        individualInstance.properties = params
        
        println "params in create:"+ params.type
        return [individualInstance: individualInstance, type: params.type]
    }

    def save = {	
	if(params.id)
		{
		def individualInstance = Individual.get(params.id)
		if(individualInstance)
			{
			if (org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAllGranted('ROLE_VOICE_SEC,ROLE_VOICE_ADMIN'))
				{
				render(view: "profile", model: [individualInstance: individualInstance,mode:'EDIT'])
				return
				}
			//check existing cultivator/counsellor
			else
				{
				switch(params.type)
					{
						case 'Counsellee':
							//get current counsellor
							def currClorList = Relationship.createCriteria().list{eq('status','ACTIVE') eq('individual1',individualInstance) relation{eq('name','Councellee of')}}
							if(currClorList.size()>0)
								{
								if(currClorList[0].individual2.id!=new Long(session.individualid))
									{
									flash.message = "Counsellor conflict for "+individualInstance.toString()+" !! Please contact current counsellor "+currClorList[0].individual2.toString()+" -> Phone: "+currClorList[0].individual2.voiceContact?.toString()+" -> Email: "+currClorList[0].individual2.emailContact?.toString()
									def motd = new Motd()
									motd.quote = flash.message
									motd.reference = "createprofile:Counsellee"
									motd.updator = motd.creator = springSecurityService.principal.username
									motd.save()
									redirect(action: "createprofile", id: individualInstance.id, params: [type: params.type])
									return
									}									
								}
							break
						case 'Wellwisher':
							def currCultList = Relationship.createCriteria().list{eq('status','ACTIVE') eq('individual1',individualInstance) relation{eq('name','Cultivated by')}}
							if(currCultList.size()>0)
								{
								if(currCultList[0].individual2.id!=new Long(session.individualid))
									{
									flash.message = "Cultivator conflict for "+individualInstance.toString()+" !! Please contact current cultivator "+currCultList[0].individual2.toString()+" -> Phone: "+currCultList[0].individual2.voiceContact?.toString()+" -> Email: "+currCultList[0].individual2.emailContact?.toString()
									def motd = new Motd()
									motd.quote = flash.message
									motd.reference = "createprofile:Wellwisher"
									motd.updator = motd.creator = springSecurityService.principal.username
									motd.save()
									redirect(action: "createprofile", id: individualInstance.id,  params: [type: params.type])
									return
									}									
								}
							break
						default:
							break

					}
				}

			}
		}
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


	println '----------------- Individual save----------------'
	println("Params in create individual:"+params);
	if(!params.initiatedName )
		{
		params.remove('firstInitiation')
		params.remove('firstInitiationPlace')
		params.remove('secondInitiation')
		params.remove('secondInitiationPlace')
		}
		
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def individualInstance = new Individual(params)

	//assign image
	  // Get the avatar file from the multi-part request
	  def f = request.getFile('avatar')
	  println "file.."+f
	  // List of OK mime-types
	  def okcontents = ['image/png', 'image/jpeg', 'image/gif']
	  if (f && okcontents.contains(f.getContentType())) {
		  // Save the image and mime type
		  println "saving image..."
		  individualInstance.avatar = f.getBytes()
		  individualInstance.avatarType = f.getContentType()
	  }

	if (org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAllGranted('ROLE_VOICE_SEC,ROLE_VOICE_ADMIN'))
		individualInstance.category='VOICE'	//@todo: hard coding


        if (individualInstance.save(flush: true)) {
        	//for icsid
        	individualInstance.icsid = 100000 + individualInstance.id
        	individualInstance.save()
        	
        	//Now save Address info if present
        	if(params.addressLine1)
		{
			def address = new Address()
			address.individual = individualInstance
			address.category = params.acategory
			address.addressLine1 = params.addressLine1
			address.addressLine2 = params.addressLine2?:""
			address.addressLine3 = params.addressLine3?:""
			address.city = City.get(params."city.id")
			address.state = State.get(params."state.id")
			address.country = Country.get(params."country.id")
			address.pincode = params.pincode?:""
			address.creator = springSecurityService.principal.username
			address.updator = springSecurityService.principal.username
			if (!address.save(flush: true)) {
				println "Error in saving address: "+address
				if(address.hasErrors()) {
				    address.errors.each {
					  println it
				    }
				}
			}
        	}

        	if(params.c_addressLine1)
		{
			def address = new Address()
			address.individual = individualInstance
			address.category = params.c_acategory
			address.addressLine1 = params.c_addressLine1
			address.addressLine2 = params.c_addressLine2?:""
			address.addressLine3 = params.c_addressLine3?:""
			address.city = City.get(params."c_city.id")
			address.state = State.get(params."c_state.id")
			address.country = Country.get(params."c_country.id")
			address.pincode = params.c_pincode?:""
			address.creator = springSecurityService.principal.username
			address.updator = springSecurityService.principal.username
			if (!address.save(flush: true)) {
				println "Error in saving address: "+address
				if(address.hasErrors()) {
				    address.errors.each {
					  println it
				    }
				}
			}
        	}
        	
        	//Now save Voice Contact info if present
        	if(params.homePhone)
		{
			def homePhoneContact = new VoiceContact()
			homePhoneContact.individual = individualInstance
			homePhoneContact.number = params.homePhone
			homePhoneContact.category = "HomePhone"

			homePhoneContact.creator = springSecurityService.principal.username
			homePhoneContact.updator = springSecurityService.principal.username
			if (!homePhoneContact.save(flush: true)) {
				println "Error in saving homePhoneContact: "+homePhoneContact
				if(homePhoneContact.hasErrors()) {
				    homePhoneContact.errors.each {
					  println it
				    }
				}
			}
		}

        	if(params.cellPhone)
		{
			def cellPhoneContact = new VoiceContact()
			cellPhoneContact.individual = individualInstance
			cellPhoneContact.number = params.cellPhone
			cellPhoneContact.category = "CellPhone"

			cellPhoneContact.creator = springSecurityService.principal.username
			cellPhoneContact.updator = springSecurityService.principal.username
			if (!cellPhoneContact.save(flush: true)) {
				println "Error in saving cellPhoneContact: "+cellPhoneContact
				if(cellPhoneContact.hasErrors()) {
				    cellPhoneContact.errors.each {
					  println it
				    }
				}
			}
		}

        	if(params.companyPhone)
		{
			def companyPhoneContact = new VoiceContact()
			companyPhoneContact.individual = individualInstance
			companyPhoneContact.number = params.companyPhone
			companyPhoneContact.category = "CompanyPhone"

			companyPhoneContact.creator = springSecurityService.principal.username
			companyPhoneContact.updator = springSecurityService.principal.username
			if (!companyPhoneContact.save(flush: true)) {
				println "Error in saving companyPhoneContact: "+companyPhoneContact
				if(companyPhoneContact.hasErrors()) {
				    companyPhoneContact.errors.each {
					  println it
				    }
				}
			}
		}

        	//Now save email info if present
        	if(params.personalEmail)
		{
			def personalEmailContact = new EmailContact()
			personalEmailContact.individual = individualInstance
			personalEmailContact.emailAddress = params.personalEmail
			personalEmailContact.category = "Personal"

			personalEmailContact.creator = springSecurityService.principal.username
			personalEmailContact.updator = springSecurityService.principal.username
			if (!personalEmailContact.save(flush: true)) {
				println "Error in saving personalEmailContact: "+personalEmailContact
				if(personalEmailContact.hasErrors()) {
				    personalEmailContact.errors.each {
					  println it
				    }
				}
			}
		}

        	if(params.officialEmail)
		{
			def officialEmailContact = new EmailContact()
			officialEmailContact.individual = individualInstance
			officialEmailContact.emailAddress = params.officialEmail
			officialEmailContact.category = "Official"

			officialEmailContact.creator = springSecurityService.principal.username
			officialEmailContact.updator = springSecurityService.principal.username
			if (!officialEmailContact.save(flush: true)) {
				println "Error in saving officialEmailContact: "+officialEmailContact
				if(officialEmailContact.hasErrors()) {
				    officialEmailContact.errors.each {
					  println it
				    }
				}
			}
		}

        	if(params.otherEmail)
		{
			def otherEmailContact = new EmailContact()
			otherEmailContact.individual = individualInstance
			otherEmailContact.emailAddress = params.otherEmail
			otherEmailContact.category = "Other"

			otherEmailContact.creator = springSecurityService.principal.username
			otherEmailContact.updator = springSecurityService.principal.username
			if (!otherEmailContact.save(flush: true)) {
				println "Error in saving otherEmailContact: "+otherEmailContact
				if(otherEmailContact.hasErrors()) {
				    otherEmailContact.errors.each {
					  println it
				    }
				}
			}
		}

        	//Now save Cultivator info if present
        	if(params.acCultivator_id)
		{
			def relnship = new Relationship()
			def relation = Relation.findByName("Cultivated by")
			def relationshipgroup = RelationshipGroup.findByGroupName("dummy")
			relnship.individual1 = individualInstance
			relnship.individual2 = Individual.get(params.acCultivator_id)
			relnship.relation = relation
			relnship.relationshipGroup = relationshipgroup
			relnship.status = "ACTIVE"
			relnship.creator = springSecurityService.principal.username
			relnship.updator = springSecurityService.principal.username
			if (!relnship.save(flush: true)) {
				println "Error in saving cultivator relationship: "+relnship
			}
		}
        	//Now save Guru info if present
        	if(params.acGuru_id)
		{
			def relnship = new Relationship()
			def relation = Relation.findByName("Disciple of")
			def relationshipgroup = RelationshipGroup.findByGroupName("dummy")
			relnship.individual1 = individualInstance
			relnship.individual2 = Individual.get(params.acGuru_id)
			relnship.relation = relation
			relnship.relationshipGroup = relationshipgroup
			relnship.status = "ACTIVE"
			relnship.creator = springSecurityService.principal.username
			relnship.updator = springSecurityService.principal.username
			if (!relnship.save(flush: true)) {
				println "Error in saving guru relationship: "+relnship
			}
		}
        	//Now save Councellor info if present
        	if(params.acCouncellor_id)
		{
			def relnship = new Relationship()
			def relation = Relation.findByName("Councellee of")
			def relationshipgroup = RelationshipGroup.findByGroupName("dummy")
			relnship.individual1 = individualInstance
			relnship.individual2 = Individual.get(params.acCouncellor_id)
			relnship.relation = relation
			relnship.relationshipGroup = relationshipgroup
			relnship.status = "ACTIVE"
			relnship.creator = springSecurityService.principal.username
			relnship.updator = springSecurityService.principal.username
			if (!relnship.save(flush: true)) {
				println "Error in saving councellor relationship: "+relnship
			}
		}
        			

		params.dob = null
		params.raashi = null
		params.gotra = null
		params.nakshatra = null
		params.isWellWisher = false
		//params.isMale = null
		params.category = null
		params.status = null
		params.remarks = null
		params.ashram = null
		params.varna = null
		params.profession = null
		params.designation = null
		params.businessRemarks = null
		params.mt = null
		params.literatureLanguagePreference = null
		params.communicationsPreference = null
		params.languagePreference = null
		params.picFileURL = null
		params.isLifeMember = false
		params.isDonor = false
		params.membershipNo = null
		params.membershipPlace = null
		params.marriageAnniversary = null
		params.panNo = null
		params.firstInitiation = null
		params.firstInitiationPlace = null
		params.secondInitiation = null
		params.secondInitiationPlace = null
		params.nvccDonarCode = null
		params.nvccId = null
		params.nvccName = null
		params.nvccIskconRef = null
		params.nvccRelation = null
		params.avatar = null
		params.avatarType = null
					
        			
		if(params.legalName0)
		{
			params.legalName = params.legalName0
			if(params.initiatedName0 != '')
				params.initiatedName = params.initiatedName0
			if(params.isMale0!=null)
			{
				if(params.isMale0=="on")
					params.isMale = true
				else
					params.isMale = false
			}
			else
				params.isMale = false

			//params.title.id = (params.title0.id).toLong()

			def individualInstance0 = new Individual(params)
			individualInstance0.title = Title.findById(params.title0?.id)
			individualInstance0.nvccRelation = params.acRelation0
			if (individualInstance0.save(flush: true)) {

				def relnship0 = new Relationship()
				def relation0 = Relation.findById(params."acRelation0_id")

				relnship0.individual1 = individualInstance0
				relnship0.individual2 = individualInstance
				relnship0.relation = relation0
				relnship0.status = "ACTIVE"

				relnship0.creator = springSecurityService.principal.username
				relnship0.updator = springSecurityService.principal.username
				def relationshipgroup0 = new RelationshipGroup()
				relationshipgroup0.groupName = "Family of "+ (individualInstance)
				relationshipgroup0.category='FAMILY'

				relationshipgroup0.refid = individualInstance.id.toInteger()
				relationshipgroup0.creator = springSecurityService.principal.username
				relationshipgroup0.updator = springSecurityService.principal.username
				if (!relationshipgroup0.save(flush: true)) 
					{
						println "Some error occurred in saving family relationship group : "+relationshipgroup0
					}
				relnship0.relationshipGroup = relationshipgroup0

				if (!relnship0.save(flush: true)) {
					println "Error in saving relationship: "+relnship0
				}
			}
			else {
				println '---individualInstance0 not saved!'
			}
		}

		if(params.legalName1)
		{
			params.legalName = params.legalName1
			if(params.title1?.id!=null)
				params.title.id = params.title1.id
			println 'params.title.id='+params.title?.id
			if(params.initiatedName1 != '')
				params.initiatedName = params.initiatedName1
			if(params.isMale1!=null)
			{
				if(params.isMale1=="on")
					params.isMale = true
				else
					params.isMale = false
			}
			else
				params.isMale = false

			def individualInstance1 = new Individual(params)
			individualInstance1.title = Title.findById(params.title1?.id)
			individualInstance1.nvccRelation = params.acRelation1
			if (individualInstance1.save(flush: true)) {
				def relnship1 = new Relationship()
				def relation1 = Relation.findById(params."acRelation1_id")

				relnship1.individual1 = individualInstance1
				relnship1.individual2 = individualInstance
				relnship1.relation = relation1
				relnship1.status = "ACTIVE"

				relnship1.creator = springSecurityService.principal.username
				relnship1.updator = springSecurityService.principal.username
				def relationshipgroup1 = new RelationshipGroup()
				relationshipgroup1.groupName = "Family of "+ (individualInstance)
				relationshipgroup1.category='FAMILY'
				relationshipgroup1.refid = individualInstance.id.toInteger()
				relationshipgroup1.creator = springSecurityService.principal.username
				relationshipgroup1.updator = springSecurityService.principal.username
				if (!relationshipgroup1.save(flush: true)) 
					{
						println "Some error occurred in saving family relationship group : "+relationshipgroup1
					}

				relnship1.relationshipGroup = relationshipgroup1

				if (!relnship1.save(flush: true)) {

					println "Error in saving relationship: "+relnship1
				}
			}
			else {
				println '---individualInstance1 not saved!'
			}
		}

		if(params.legalName2)
		{
			params.legalName = params.legalName2
			if(params.title2.id!=null)
				params.title.id = params.title2.id
			if(params.initiatedName2 != '')
				params.initiatedName = params.initiatedName2
			if(params.isMale2!=null)
			{
				if(params.isMale2=="on")
					params.isMale = true
				else
					params.isMale = false
			}
			else
				params.isMale = false

			def individualInstance2 = new Individual(params)
			individualInstance2.title = Title.findById(params.title2.id)
			individualInstance2.nvccRelation = params.acRelation2
			if (individualInstance2.save(flush: true)) {

				def relnship2 = new Relationship()
				def relation2 = Relation.findById(params."acRelation2_id")

				relnship2.individual1 = individualInstance2
				relnship2.individual2 = individualInstance
				relnship2.relation = relation2
				relnship2.status = "ACTIVE"

				relnship2.creator = springSecurityService.principal.username
				relnship2.updator = springSecurityService.principal.username
				def relationshipgroup2 = new RelationshipGroup()
				relationshipgroup2.groupName = "Family of "+ (individualInstance)
				relationshipgroup2.category='FAMILY'

				relationshipgroup2.refid = individualInstance.id.toInteger()
				relationshipgroup2.creator = springSecurityService.principal.username
				relationshipgroup2.updator = springSecurityService.principal.username
				if (!relationshipgroup2.save(flush: true)) 
					{
						println "Some error occurred in saving family relationship group : "+relationshipgroup2
					}
				relnship2.relationshipGroup = relationshipgroup2

				if (!relnship2.save(flush: true)) {
					println "Error in saving relationship: "+relnship2
				}
			}
			else {
				println '---individualInstance2 not saved!'
			}
		}				

		if(params.legalName3)
		{
			params.legalName = params.legalName3
			if(params.title3.id!=null)
				params.title.id = params.title3.id
			if(params.initiatedName3 != '')
				params.initiatedName = params.initiatedName3
			if(params.isMale3!=null)
			{
				if(params.isMale3=="on")
					params.isMale = true
				else
					params.isMale = false
			}
			else
				params.isMale = false

			def individualInstance3 = new Individual(params)
			individualInstance3.title = Title.findById(params.title3.id)
			individualInstance3.nvccRelation = params.acRelation3
			if (individualInstance3.save(flush: true)) {

				def relnship3 = new Relationship()
				def relation3 = Relation.findById(params."acRelation3_id")

				relnship3.individual1 = individualInstance3
				relnship3.individual2 = individualInstance
				relnship3.relation = relation3
				relnship3.status = "ACTIVE"

				relnship3.creator = springSecurityService.principal.username
				relnship3.updator = springSecurityService.principal.username
				def relationshipgroup3 = new RelationshipGroup()
				relationshipgroup3.groupName = "Family of "+ (individualInstance)
				relationshipgroup3.category='FAMILY'

				relationshipgroup3.refid = individualInstance.id.toInteger()
				relationshipgroup3.creator = springSecurityService.principal.username
				relationshipgroup3.updator = springSecurityService.principal.username
				if (!relationshipgroup3.save(flush: true)) 
					{
						println "Some error occurred in saving family relationship group : "+relationshipgroup3
					}
				relnship3.relationshipGroup = relationshipgroup3

				if (!relnship3.save(flush: true)) {
					println "Error in saving relationship: "+relnship3
				}
			}
			else {
				println '---individualInstance3 not saved!'
			}
		}

		if(params.legalName4)
		{
			params.legalName = params.legalName4
			if(params.title4.id!=null)
				params.title.id = params.title4.id
			if(params.initiatedName4 != '')
				params.initiatedName = params.initiatedName4
			if(params.isMale4!=null)
			{
				if(params.isMale4=="on")
					params.isMale = true
				else
					params.isMale = false
			}
			else
				params.isMale = false

			def individualInstance4 = new Individual(params)
			individualInstance4.title = Title.findById(params.title4.id)
			individualInstance4.nvccRelation = params.acRelation4
			if (individualInstance4.save(flush: true)) {

				def relnship4 = new Relationship()
				def relation4 = Relation.findById(params."acRelation4_id")

				relnship4.individual1 = individualInstance4
				relnship4.individual2 = individualInstance
				relnship4.relation = relation4
				relnship4.status = "ACTIVE"

				relnship4.creator = springSecurityService.principal.username
				relnship4.updator = springSecurityService.principal.username
				def relationshipgroup4 = new RelationshipGroup()
				relationshipgroup4.groupName = "Family of "+ (individualInstance)
				relationshipgroup4.category='FAMILY'

				relationshipgroup4.refid = individualInstance.id.toInteger()
				relationshipgroup4.creator = springSecurityService.principal.username
				relationshipgroup4.updator = springSecurityService.principal.username
				if (!relationshipgroup4.save(flush: true)) 
					{
						println "Some error occurred in saving family relationship group : "+relationshipgroup4
					}
				relnship4.relationshipGroup = relationshipgroup4

				if (!relnship4.save(flush: true)) {
					println "Error in saving relationship: "+relnship4
				}
			}
			else {
				println '---individualInstance4 not saved!'
			}
		}

		if(params.legalName5)
		{
			params.legalName = params.legalName5
			if(params.title5.id!=null)
				params.title.id = params.title5.id
			if(params.initiatedName5 != '')
				params.initiatedName = params.initiatedName5
			if(params.isMale5!=null)
			{
				if(params.isMale5=="on")
					params.isMale = true
				else
					params.isMale = false
			}
			else
				params.isMale = false

			def individualInstance5 = new Individual(params)
			individualInstance5.title = Title.findById(params.title5.id)
			individualInstance5.nvccRelation = params.acRelation5
			if (individualInstance5.save(flush: true)) {

				def relnship5 = new Relationship()
				def relation5 = Relation.findById(params."acRelation5_id")

				relnship5.individual1 = individualInstance5
				relnship5.individual2 = individualInstance
				relnship5.relation = relation5
				relnship5.status = "ACTIVE"

				relnship5.creator = springSecurityService.principal.username
				relnship5.updator = springSecurityService.principal.username
				def relationshipgroup5 = new RelationshipGroup()
				relationshipgroup5.groupName = "Family of "+ (individualInstance)
				relationshipgroup5.category='FAMILY'

				relationshipgroup5.refid = individualInstance.id.toInteger()
				relationshipgroup5.creator = springSecurityService.principal.username
				relationshipgroup5.updator = springSecurityService.principal.username
				if (!relationshipgroup5.save(flush: true)) 
					{
						println "Some error occurred in saving family relationship group : "+relationshipgroup5
					}
				relnship5.relationshipGroup = relationshipgroup5

				if (!relnship5.save(flush: true)) {
					println "Error in saving relationship: "+relnship5
				}
			}
			else {
				println '---individualInstance5 not saved!'
			}
		}				

		if(params.legalName6)
		{
			params.legalName = params.legalName6
			if(params.title6.id!=null)
				params.title.id = params.title6.id
			if(params.initiatedName6 != '')
				params.initiatedName = params.initiatedName6
			if(params.isMale6!=null)
			{
				if(params.isMale6=="on")
					params.isMale = true
				else
					params.isMale = false
			}
			else
				params.isMale = false

			def individualInstance6 = new Individual(params)
			individualInstance6.title = Title.findById(params.title6.id)
			individualInstance6.nvccRelation = params.acRelation6
			if (individualInstance6.save(flush: true)) {

				def relnship6 = new Relationship()
				def relation6 = Relation.findById(params."acRelation6_id")

				relnship6.individual1 = individualInstance6
				relnship6.individual2 = individualInstance
				relnship6.relation = relation6
				relnship6.status = "ACTIVE"

				relnship6.creator = springSecurityService.principal.username
				relnship6.updator = springSecurityService.principal.username
				def relationshipgroup6 = new RelationshipGroup()
				relationshipgroup6.groupName = "Family of "+ (individualInstance)
				relationshipgroup6.category='FAMILY'

				relationshipgroup6.refid = individualInstance.id.toInteger()
				relationshipgroup6.creator = springSecurityService.principal.username
				relationshipgroup6.updator = springSecurityService.principal.username
				if (!relationshipgroup6.save(flush: true)) 
					{
						println "Some error occurred in saving family relationship group : "+relationshipgroup6
					}
				relnship6.relationshipGroup = relationshipgroup6

				if (!relnship6.save(flush: true)) {
					println "Error in saving relationship: "+relnship6
				}
			}
			else {
				println '---individualInstance6 not saved!'
			}
		}
				
		//check if a counselle|mentee|well-wisher was getting created
		if(params.type)
		{
			def crel = Relation.findByName("Councellee of")
			def mrel = Relation.findByName("Mentee of")
			def wrel = Relation.findByName("Cultivated by")
			def rg = RelationshipGroup.findByGroupName("dummy")

			def rship = new Relationship()
			rship.individual1 = individualInstance
			rship.individual2 = Individual.findByLoginid(springSecurityService.principal.username)
			rship.relationshipGroup = rg
			rship.status = 'ACTIVE'
			rship.creator = springSecurityService.principal.username
			rship.updator = springSecurityService.principal.username

			switch(params.type)
				{
					case 'Counsellee':
						rship.relation = crel
						break
					case 'Mentee':
						rship.relation = mrel
						break
					case 'Wellwisher':
						rship.relation = wrel
						break
					default:
						break

				}
			if(!rship.save(flush:true))
				{
					println "Some error occurred in councellee relationship : "+rship
				}						
		}
		
		//books
		def booklist = params.list("books")
		println "booklist: "+booklist
		if(booklist?.size()>0)
			{
			booklist.each{b->
				def bookRead = new BookRead()
				bookRead.book = Book.get(b)
				if(bookRead.book)
					{
					bookRead.individual = individualInstance
					bookRead.creator = springSecurityService.principal.username
					bookRead.updator = springSecurityService.principal.username
					if(!bookRead.save(flush:true))
						println "Some error occurred in saving bookRead: "+bookRead
					}
				}
			}

		//courses
		def courselist = params.list("courses")
		println "courselist: "+courselist
		if(courselist?.size()>0)
			{
			courselist.each{c->
				def individualCourse = new IndividualCourse()
				individualCourse.course = Course.get(c)
				if(individualCourse.course)
					{
					individualCourse.individual = individualInstance
					individualCourse.creator = springSecurityService.principal.username
					individualCourse.updator = springSecurityService.principal.username
					if(!individualCourse.save(flush:true))
						println "Some error occurred in saving individualCourse: "+individualCourse
					}
				}
			}
		
		//roles
		def rolelist = params.list("roles")
		println "rolelist: "+rolelist
		if(rolelist?.size()>0)
			{
			rolelist.each{r->
				def individualRole = new IndividualRole()
				individualRole.role = Role.get(r)
				if(individualRole.role)
					{
					individualRole.individual = individualInstance
					individualRole.status = "VALID"
					individualRole.creator = springSecurityService.principal.username
					individualRole.updator = springSecurityService.principal.username
					if(!individualRole.save(flush:true))
						println "Some error occurred in saving individualRole: "+individualRole
					}
				}
			}
		
		//services rendered
		def servicesrendered = params.list("servicesrendered")
		println "servicesrendered: "+servicesrendered
		if(servicesrendered?.size()>0)
			{
			servicesrendered.each{s->
				def individualSeva = new IndividualSeva()
				individualSeva.seva = Seva.get(s)
				if(individualSeva.seva)
					{
					individualSeva.individual = individualInstance
					individualSeva.status = "VALID"
					individualSeva.rendered = true
					individualSeva.creator = springSecurityService.principal.username
					individualSeva.updator = springSecurityService.principal.username
					if(!individualSeva.save(flush:true))
						println "Some error occurred in saving rendered individualSeva: "+individualSeva
					}
				}
			}
		
		//services interested
		def servicesinterested = params.list("servicesinterested")
		println "servicesinterested: "+servicesinterested
		if(servicesinterested?.size()>0)
			{
			servicesinterested.each{s->
				def individualSeva = new IndividualSeva()
				individualSeva.seva = Seva.get(s)
				if(individualSeva.seva)
					{
					individualSeva.individual = individualInstance
					individualSeva.status = "VALID"
					individualSeva.interested = true
					individualSeva.creator = springSecurityService.principal.username
					individualSeva.updator = springSecurityService.principal.username
					if(!individualSeva.save(flush:true))
						println "Some error occurred in saving interested individualSeva: "+individualSeva
					}
				}
			}
		
		//skills
		def skills = params.list("skills")
		println "skills: "+skills
		if(skills?.size()>0)
			{
			skills.each{sk->
				def individualSkill = new IndividualSkill()
				individualSkill.skill = Skill.get(sk)
				if(individualSkill.skill)
					{
					individualSkill.individual = individualInstance
					individualSkill.status = "VALID"
					individualSkill.creator = springSecurityService.principal.username
					individualSkill.updator = springSecurityService.principal.username
					if(!individualSkill.save(flush:true))
						println "Some error occurred in saving individualSkill: "+individualSkill
					}
				}
			}
			
		//centre
		if(params.currentCentre)
			{
			def individualCentre = new IndividualCentre()
			individualCentre.centre = Centre.get(params.currentCentre)
			if(individualCentre.centre)
				{
				individualCentre.individual = individualInstance
				individualCentre.status = "VALID"
				individualCentre.creator = springSecurityService.principal.username
				individualCentre.updator = springSecurityService.principal.username
				if(!individualCentre.save(flush:true))
					println "Some error occurred in saving individualCentre: "+individualCentre
				}
			
			}
		
		//languages
		if(params."language0.id")
			{
			def language = Language.get(params."language0.id")
			if(language)
				{
				def individualLanguage = new IndividualLanguage()
				individualLanguage.individual = individualInstance
				individualLanguage.language = language
				individualLanguage.readFluency = new Integer(params.hreadFluency0?:2)
				individualLanguage.writeFluency = new Integer(params.hwriteFluency0?:2)
				println "MT->"+params.mtge
				if(params.mtge=="mt0")
					{
					individualLanguage.motherTongue = true
					println "set..."+individualLanguage.motherTongue
					}
				individualLanguage.creator = springSecurityService.principal.username
				individualLanguage.updator = springSecurityService.principal.username
				if(!individualLanguage.save(flush:true))
					println "Some error occurred in saving individualLanguage: "+individualLanguage
				}
			}
		if(params."language1.id")
			{
			def language = Language.get(params."language1.id")
			if(language)
				{
				def individualLanguage = new IndividualLanguage()
				individualLanguage.individual = individualInstance
				individualLanguage.language = language
				individualLanguage.readFluency = new Integer(params.hreadFluency1?:2)
				individualLanguage.writeFluency = new Integer(params.hwriteFluency1?:2)
				if(params.mtge=="mt1")
					individualLanguage.motherTongue = true
				individualLanguage.creator = springSecurityService.principal.username
				individualLanguage.updator = springSecurityService.principal.username
				if(!individualLanguage.save(flush:true))
					println "Some error occurred in saving individualLanguage: "+individualLanguage
				}
			}
		if(params."language2.id")
			{
			def language = Language.get(params."language2.id")
			if(language)
				{
				def individualLanguage = new IndividualLanguage()
				individualLanguage.individual = individualInstance
				individualLanguage.language = language
				individualLanguage.readFluency = new Integer(params.hreadFluency2?:2)
				individualLanguage.writeFluency = new Integer(params.hwriteFluency2?:2)
				if(params.mtge=="mt2")
					individualLanguage.motherTongue = true
				individualLanguage.creator = springSecurityService.principal.username
				individualLanguage.updator = springSecurityService.principal.username
				if(!individualLanguage.save(flush:true))
					println "Some error occurred in saving individualLanguage: "+individualLanguage
				}
			}
		if(params."language3.id")
			{
			def language = Language.get(params."language3.id")
			if(language)
				{
				def individualLanguage = new IndividualLanguage()
				individualLanguage.individual = individualInstance
				individualLanguage.language = language
				individualLanguage.readFluency = new Integer(params.hreadFluency3?:2)
				individualLanguage.writeFluency = new Integer(params.hwriteFluency3?:2)
				if(params.mtge=="mt3")
					individualLanguage.motherTongue = true
				individualLanguage.creator = springSecurityService.principal.username
				individualLanguage.updator = springSecurityService.principal.username
				if(!individualLanguage.save(flush:true))
					println "Some error occurred in saving individualLanguage: "+individualLanguage
				}
			}
		if(params."language4.id")
			{
			def language = Language.get(params."language4.id")
			if(language)
				{
				def individualLanguage = new IndividualLanguage()
				individualLanguage.individual = individualInstance
				individualLanguage.language = language
				individualLanguage.readFluency = new Integer(params.hreadFluency4?:2)
				individualLanguage.writeFluency = new Integer(params.hwriteFluency4?:2)
				if(params.mtge=="mt4")
					individualLanguage.motherTongue = true
				individualLanguage.creator = springSecurityService.principal.username
				individualLanguage.updator = springSecurityService.principal.username
				if(!individualLanguage.save(flush:true))
					println "Some error occurred in saving individualLanguage: "+individualLanguage
				}
			}
				
            if(params.profile)
            	{
            	//create counsellor relationship
            	if(SpringSecurityUtils.ifAllGranted('ROLE_COUNSELLOR') && params.counsellee=="true")
            		{
            		def rship = new Relationship()
            		def reln = Relation.findByName("Councellee of")
            		def rg = RelationshipGroup.findByGroupName("dummy")
            		rship.individual1 = individualInstance
            		rship.individual2 = Individual.get(session.individualid)
            		rship.relation = reln
            		rship.relationshipGroup = rg
            		rship.status = 'ACTIVE'
            		rship.updator=rship.creator=springSecurityService.principal.username
			    if(!rship.save())
				{
				    rship.errors.allErrors.each {
					log.debug("In create profile: error in creating relationship:"+ it)
					}
				}

            		}
            	render(view: "profile", model: [individualInstance: individualInstance,mode:'EDIT'])
            	}
            else
            	{
            	flash.message = "${message(code: 'default.created.message', args: [message(code: 'individual.label', default: 'Individual'), individualInstance.id])}"
            	redirect(action: "show", id: individualInstance.id)
            	}
        }
        else {
            render(view: "create", model: [individualInstance: individualInstance])
        }
    }

    def show = {
	    if (request.xhr) {
		render(template: "gist", model: [individualInstance:Individual.get(params.id)?:Individual.get(params.icsid)])
		return
	    }

        if(!SpringSecurityUtils.ifAnyGranted('ROLE_NVCC_ADMIN,ROLE_PATRONCARE_HEAD,ROLE_KITCHEN_ADMIN'))
        {
        if(SpringSecurityUtils.ifAllGranted('ROLE_COUNSELLOR'))
        	{
        	if(!housekeepingService.isSuperior(params.id))
        		{
        		render "The record is not available for viewing!!"
        		return
        		}
        	}
        if(SpringSecurityUtils.ifAllGranted('ROLE_DONATION_COORDINATOR'))
        	{
        	if(!housekeepingService.isDonationCoordinator(params.id))
        		{
        		render "The record is not available for viewing!!"
        		return
        		}
        	}
        if(SpringSecurityUtils.ifAllGranted('ROLE_PATRONCARE_USER'))
        	{
        	if(!housekeepingService.isCultivator(params.id))
        		{
        		render "The record is not available for viewing!!"
        		return
        		}
        	}
        if(SpringSecurityUtils.ifAllGranted('ROLE_PATRONCARE'))
        	{
        	if(!housekeepingService.isCultivatorGroup(params.id))
        		{
        		render "The record is not available for viewing!!"
        		return
        		}
        	}
        }
        def individualInstance
        if(params.id)
        	individualInstance = Individual.get(params.id)
        else if(params.icsid)
        	individualInstance = Individual.findByIcsid(params.value)
        else
        	individualInstance = null
        if(SpringSecurityUtils.ifAllGranted('ROLE_KITCHEN_ADMIN'))
        	{
        	if(!individualInstance || !housekeepingService.isIndividualUnderKitchen(individualInstance))
        		{
        		render "The record is not available for viewing!!"
        		return
        		}
        	}
        if (!individualInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'individual.label', default: 'Individual'), params.id])}"
            redirect(action: "list")
        }
        else {
	    if(params.dashboard)
	    	{
	    		render(view: "dashboard", model: [individualInstance: individualInstance])
		    	return
	    	}

	    if(params.profile)
	    	{
	    	if(params.detailed) {
			if(params.editprofile)
				render(view: "detailedprofile", model: [individualInstance: individualInstance,mode:'EDIT'])
			else
				render(view: "detailedprofile", model: [individualInstance: individualInstance,mode:'READ'])
	    	}
	    	else
	    		render(view: "profile", model: [individualInstance: individualInstance,mode:'READ'])
	    	return
	    	}

	/*
        //println ics.Commitment.findByCommittedBy(individualInstance)
        	//sort the relatives
        	//println "Before sorting.. "+individualInstance.relative2
		def mc= [
		  compare: {a,b-> a?.relation?.name?.equals(b?.relation?.name)? 0: a?.relation?.name<b?.relation?.name? -1: 1 }
		] as Comparator
		individualInstance.relative2.sort(mc)     	
        	//println "after sorting... "+individualInstance.relative2
        	
        	
        	//see if any bounced cheques
        	
		//get all languages
		def individualLanguageList = IndividualLanguage.findAllByIndividual(individualInstance)
		//get all centre
		def individualCentreList = IndividualCentre.findAllByIndividual(individualInstance)

        	def booksRead
        	def courses
        	def servicesrendered
        	def servicesinterested
        	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_COUNSELLOR,ROLE_COUNSELLOR_GROUP'))
        	{
			//get all books read
			booksRead = BookRead.findAllByIndividual(individualInstance)
			//get all courses done
			courses = IndividualCourse.findAllByIndividual(individualInstance)
			//get all services rendered
			servicesrendered = IndividualSeva.findAllByIndividualAndRendered(individualInstance,true)
			//get all services interested in
			servicesinterested = IndividualSeva.findAllByIndividualAndInterested(individualInstance,true)
        	}
        	def crel = Relation.findByName('Cultivated by')
        	def cultivatorRel = Relationship.findByIndividual1AndRelation(individualInstance,crel)?.individual2
        	
        	def cultivatorLink
        	if (cultivatorRel.toString() == session.individualname)
        		cultivatorLink = "Remove Cultivator"
        	if (!cultivatorRel)
        		cultivatorLink = "Cultivated by me"
        //, booksRead: booksRead, courses: courses, individualLanguageList: individualLanguageList, individualCentreList: individualCentreList, servicesrendered: servicesrendered, servicesinterested: servicesinterested, cultivatorLink: cultivatorLink, cultivatorRel : cultivatorRel
        */
            [individualInstance: individualInstance]
        }
    }

    def edit = {
        if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAllGranted('ROLE_COUNSELLOR'))
        	{
        	if(!housekeepingService.isSuperior(params.id))
        		{
        		render "The record is not available for editing!!"
        		return
        		}
        	}
        def individualInstance = Individual.get(params.id)
        if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAllGranted('ROLE_KITCHEN_ADMIN'))
        	{
        	if(!individualInstance || !housekeepingService.isIndividualUnderKitchen(individualInstance))
        		{
        		render "The record is not available for editing!!"
        		return
        		}
        	}
        if (!individualInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'individual.label', default: 'Individual'), params.id])}"
            redirect(action: "list")
        }
        else {
        	def booksRead
        	def courses
        	def bookids = []
        	def courseids = []
        	def roles
        	def roleids = []
        	def sevar
        	def sevarids = []
        	def sevai
        	def sevaiids = []
        	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_COUNSELLOR,ROLE_COUNSELLOR_GROUP'))
        	{
			//first check whether eligible to edit?
			if(!housekeepingService.checkDependent(params.id,Individual.findByLoginid(springSecurityService.principal.username)?.id))
			{
			    flash.message = "You can not edit the record from some other group!"
			    redirect(action: "list")
			    return
			}
			//get all books read
			booksRead = BookRead.findAllByIndividual(individualInstance)
			booksRead.each{b->
				bookids.add(b.book.id)
			}
			//get all courses done
			courses = IndividualCourse.findAllByIndividual(individualInstance)
			courses.each{c->
				courseids.add(c.course.id)
			}
			//get all roles played
			roles = IndividualRole.findAllByIndividualAndStatus(individualInstance,'VALID')
			roles.each{r->
				roleids.add(r.role.id)
			}
			//get all seva done
			sevar = IndividualSeva.findAllByIndividualAndRendered(individualInstance,true)
			sevar.each{s->
				sevarids.add(s.seva.id)
			}
			//get all seva interested in
			sevai = IndividualSeva.findAllByIndividualAndInterested(individualInstance,true)
			sevai.each{sk->
				sevaiids.add(sk.seva.id)
			}
        	}
        	
            return [individualInstance: individualInstance, bookids: bookids, courseids: courseids, roleids: roleids, sevarids: sevarids, sevaiids: sevaiids]
        }
    }

    def editPatronCare = {
        def individualInstance = Individual.get(params.id)
        if (!individualInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'individual.label', default: 'Individual'), params.id])}"
            redirect(action: "index")
        }
        else 
        	
        	
            return [individualInstance: individualInstance]
        
    }

    def voiceupdate() {
    	def individualInstance = individualService.voiceUpdate(params)
    	render(view: "profile", model: [individualInstance: individualInstance])
    	
    }
    
    
    def update = {
        if(params.indid)
        	params.id = params.indid	//This is because the ids from the grids are also being sent without our control
        if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAllGranted('ROLE_COUNSELLOR'))
        	{
        	if(!housekeepingService.isSuperior(params.id))
        		{
        		render "The record is not available for updating!!"
        		return
        		}
        	}
        def gender = params.isMale
        switch(gender) {
        	case "MALE": 
        		params.isMale= true
        		break
        	case "FEMALE":
        		params.isMale= false
        		break
        	default:
        		break
        }
        
        def individualInstance = Individual.get(params.id)
        if (individualInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (individualInstance.version > version) {
                    
                    individualInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'individual.label', default: 'Individual')] as Object[], "Another user has updated this Individual while you were editing")
                    render(view: "edit", model: [individualInstance: individualInstance])
                    return
                }
            }
		//check for null dates
		/*if(params.dob_day=='' && params.dob_month=='' && params.dob_year=='')
			params.remove('dob')
		if(params.marriageAnniversary_day=='' && params.marriageAnniversary_month=='' && params.marriageAnniversary_year=='')
			params.remove('marriageAnniversary')
		if(params.firstInitiation_day=='' && params.firstInitiation_month=='' && params.firstInitiation_year=='')
			params.remove('firstInitiation')
		if(params.secondInitiation_day=='' && params.secondInitiation_month=='' && params.secondInitiation_year=='')
			params.remove('secondInitiation')*/
		
		
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

	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"
		
	println '----------- Individual update------------'
	println 'params='+params
            individualInstance.properties = params
	if (org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAllGranted('ROLE_VOICE_SEC,ROLE_VOICE_ADMIN'))
            	individualInstance.category='VOICE'
            if (!individualInstance.hasErrors() && individualInstance.save(flush: true)) {
		//guru change/add
		if(params.guruid)
			{
			def guruReln = Relation.findByName('Disciple of')
			def oldGuruRship = Relationship.findWhere(individual1:individualInstance,relation:guruReln,status:'ACTIVE')
			
			if(oldGuruRship && oldGuruRship.individual2.id!=params.guruid)
				{
				//remove the old relationship
				oldGuruRship.status='INACTIVE'
				oldGuruRship.updator=springSecurityService.principal.username
				if(!oldGuruRship.save())
					oldGuruRship.errors.allErrors.each {println it}	
				else
					log.debug("Removed old guru reln:"+oldGuruRship)
				}
			if(!oldGuruRship || oldGuruRship.individual2.id!=params.guruid)
			{
				//now add the new relationship
				def newRship = new Relationship()
				newRship.individual1 = individualInstance
				newRship.individual2 = Individual.get(params.guruid)	//TODO: there should be an effecient way
				newRship.relation = guruReln
				newRship.relationshipGroup = RelationshipGroup.findByGroupName('dummy')
				newRship.status='ACTIVE'
				newRship.creator=newRship.updator=springSecurityService.principal.username
				if(!newRship.save())
					newRship.errors.allErrors.each {println it}
				else
					log.debug("Added new guru reln:"+oldGuruRship)
			}
			}
		//create addrs/contact/email
		if(params.addr)
			{
			//create address
			def ad = new Address ()
			ad.category = 'Correspondence'
			ad.addressLine1 = params.addr
			ad.city = City.findByName('.')?:City.get(1) //todo harcoded
			ad.state = City.findByName('.')?:State.get(1) //todo harcoded
			ad.country = City.findByName('.')?:Country.get(1) //todo harcoded
			ad.individual = individualInstance
			ad.creator=ad.updator=springSecurityService.principal.username
			if(!ad.save())
				{
				    ad.errors.allErrors.each {
					log.debug(it)
				    }
				}
			}
		if(params.phone)
			{
			//create phone
			def vc = new VoiceContact()
			vc.category = 'CellPhone'
			vc.number = params.phone
			vc.individual = individualInstance
			vc.creator=vc.updator=springSecurityService.principal.username
			if(!vc.save())
				{
				    vc.errors.allErrors.each {
					log.debug(it)
				    }
				}
			}
		if(params.eml)
			{
			//create email
			def em = new EmailContact()
			em.category = 'Personal'
			em.emailAddress = params.eml
			em.individual = individualInstance
			em.creator=em.updator=springSecurityService.principal.username
			if(!em.save())
				{
				    em.errors.allErrors.each {
					log.debug(it)
				    }
				}
			}

		//centre
		if(params.currentCentre)
			{
			//get the old centre
			def ic = IndividualCentre.findByIndividualAndStatus(individualInstance,'VALID')
 			def centre = Centre.get(params.currentCentre)
 			if(!(ic&&ic.centre.id==centre?.id))
				{
				//first mark the old one as 'INVALID'
				if(ic)
				{
					ic.status = 'INVALID'
					if(!ic.save(flush:true))
						println "Some error occurred in updating old individualCentre: "+individualCentre
				}
				
				def individualCentre = new IndividualCentre()
				individualCentre.centre = centre
				individualCentre.individual = individualInstance
				individualCentre.status = "VALID"
				individualCentre.creator = springSecurityService.principal.username
				individualCentre.updator = springSecurityService.principal.username
				if(!individualCentre.save(flush:true))
					println "Some error occurred in saving individualCentre: "+individualCentre
				}
			
			}

		//books
		//now recreate with fresh ids
		def booklist = params.list("books")
		if(booklist?.size()>0)
		{
		println "booklist: "+booklist
		//first clean all books read
		def brl = BookRead.findAllByIndividual(individualInstance)
		brl.each{br->
			br.delete(flush:true)
		}
		booklist.each{b->
			def bookRead = new BookRead()
			bookRead.book = Book.get(b)
			if(bookRead.book)
				{
				bookRead.individual = individualInstance
				bookRead.creator = springSecurityService.principal.username
				bookRead.updator = springSecurityService.principal.username
				if(!bookRead.save(flush:true))
					println "Some error occurred in saving bookRead: "+bookRead
				}
			}
		}

		//courses
		//now recreate with fresh ids
		def courselist = params.list("courses")
		if(courselist?.size()>0)
		{
		println "courselist: "+courselist
		//first clean all courses
		def cl = IndividualCourse.findAllByIndividual(individualInstance)
		cl.each{ic->
			ic.delete(flush:true)
		}
		courselist.each{c->
			def individualCourse = new IndividualCourse()
			individualCourse.course = Course.get(c)
			if(individualCourse.course)
				{
				individualCourse.individual = individualInstance
				individualCourse.creator = springSecurityService.principal.username
				individualCourse.updator = springSecurityService.principal.username
				if(!individualCourse.save(flush:true))
					println "Some error occurred in saving individualCourse: "+individualCourse
				}
			}
		}

		/*@TODO: BUGGY; HANDLE ROLE CHANGE SEPARATELY
		//roles
		//now recreate with fresh list
		def rolelist = params.list("roles")
		if(rolelist?.size()>0)
		{
		println "rolelist: "+rolelist
		//first remove all roles
		def rl = IndividualRole.findAllByIndividualAndStatus(individualInstance,'VALID')
		rl.each{ir->
			ir.delete(flush:true)
		}
		rolelist.each{r->
			def individualRole = new IndividualRole()
			individualRole.role = Role.get(r)
			if(individualRole.role)
				{
				individualRole.individual = individualInstance
				individualRole.status = 'VALID'
				individualRole.creator = springSecurityService.principal.username
				individualRole.updator = springSecurityService.principal.username
				if(!individualRole.save(flush:true))
					println "Some error occurred in saving individualRole: "+individualRole
				}
			}
		}*/


		//services
		//now recreate with fresh ids
		//for rendered
		def sevarlist = params.list("servicesrendered")
		if(sevarlist?.size()>0)
		{
		println "sevarlist: "+sevarlist
		//first clean all rendered services
		def sl = IndividualSeva.findAllWhere(individual:individualInstance,status:'Active',rendered:true)
		sl.each{is->
			is.delete(flush:true)
		}
		sevarlist.each{s->
			def individualSeva = new IndividualSeva()
			individualSeva.seva = Seva.get(s)
			if(individualSeva.seva)
				{
				individualSeva.individual = individualInstance
				individualSeva.status = 'Active'
				individualSeva.rendered = true
				individualSeva.creator = springSecurityService.principal.username
				individualSeva.updator = springSecurityService.principal.username
				if(!individualSeva.save(flush:true))
					println "Some error occurred in saving individualSeva: "+individualSeva
				}
			}
		}
		//for interested
		def sevailist = params.list("servicesinterested")
		println "sevailist: "+sevailist
		if(sevailist?.size()>0)
		{
		//first clean all interested services
		def sl = IndividualSeva.findAllWhere(individual:individualInstance,status:'Active',interested:true)
		sl.each{is->
			is.delete(flush:true)
		}
		sevailist.each{si->
			def individualSeva = new IndividualSeva()
			individualSeva.seva = Seva.get(si)
			if(individualSeva.seva)
				{
				individualSeva.individual = individualInstance
				individualSeva.status = 'Active'
				individualSeva.interested = true
				individualSeva.creator = springSecurityService.principal.username
				individualSeva.updator = springSecurityService.principal.username
				if(!individualSeva.save(flush:true))
					println "Some error occurred in saving individualSeva: "+individualSeva
				}
			}
		}

		/* for future
		//skills
		//first clean all skills
		def skl = IndividualSkill.findAllByIndividualAndStatus(individualInstance,'Active')
		skl.each{isk->
			isk.delete(flush:true)
		}
		//now recreate with fresh ids
		def skilllist = params.list("skills")
		println "skilllist: "+skilllist
		if(skilllist?.size()>0)
		{
		skilllist.each{sk->
			def individualSkill = new IndividualSkill()
			individualSkill.skill = Skill.get(sk)
			if(individualSkill.skill)
				{
				individualSkill.individual = individualInstance
				individualSkill.status = 'Active'
				individualSkill.creator = springSecurityService.principal.username
				individualSkill.updator = springSecurityService.principal.username
				if(!individualSkill.save(flush:true))
					println "Some error occurred in saving individualSkill: "+individualSkill
				}
			}
		}
		*/
		//commitment
		//if(params.committedAmount)
		//{
			def flgUpdate = 0
			def commitmentInstance = Commitment.findByCommittedBy(individualInstance)
			println "commitmentInstance: "+commitmentInstance
			if(commitmentInstance)
			{
				if(params.committedAmount == null || params.committedAmount == '')
					params.committedAmount = 0
					if(commitmentInstance.committedAmount != params.committedAmount) 
					{
						commitmentInstance.committedAmount = params.committedAmount.toBigDecimal()
						flgUpdate = 1
					}
				
				if(params.commitmentOn)
				{
					params.commitmentOn = Date.parse('dd-MM-yyyy', params.commitmentOn)
					if(commitmentInstance?.commitmentOn.format('dd-MM-yyyy') != params.commitmentOn) 
					{
						commitmentInstance.commitmentOn = params.commitmentOn
						flgUpdate = 1
					}
				}
				
				if(params.commitmentTill)
				{
					params.commitmentTill = Date.parse('dd-MM-yyyy', params.commitmentTill)
					if(commitmentInstance?.commitmentTill.format('dd-MM-yyyy') != params.commitmentTill) 
					{
						commitmentInstance.commitmentTill = params.commitmentTill
						flgUpdate = 1
					}
				}
				if(flgUpdate == 1)
				{
					commitmentInstance.updator = springSecurityService.principal.username
				
					if(!commitmentInstance.save(flush:true))
						println "Error in saving commitmentInstance"
				}				
			}
			else if (params.committedAmount)
			{
				commitmentInstance = new Commitment()
				commitmentInstance.committedBy = individualInstance
				commitmentInstance.committedAmount = params.committedAmount.toBigDecimal()
				if(params.commitmentOn)
				{
					params.commitmentOn = Date.parse('dd-MM-yyyy', params.commitmentOn)
					commitmentInstance.commitmentOn = params.commitmentOn
				}
				if(params.commitmentTill)
				{
					params.commitmentTill = Date.parse('dd-MM-yyyy', params.commitmentTill)
					commitmentInstance.commitmentTill = params.commitmentTill
				}
				commitmentInstance.creator = springSecurityService.principal.username
				commitmentInstance.updator = springSecurityService.principal.username
				println "commitmentInstance: "+commitmentInstance
				if(!commitmentInstance.save(flush:true))
					println "Error in saving commitmentInstance"
			}
		//}
                if(params.profile)
                	{
                	render(view: "profile", model: [individualInstance: individualInstance,mode:'READ'])
                	return
                	}
                else
                	{
			flash.message = "${message(code: 'default.updated.message', args: [message(code: 'individual.label', default: 'Individual'), individualInstance.id])}"
			redirect(action: "show", id: individualInstance.id)
                	}
            }
            else {
		    individualInstance.errors.allErrors.each {
			log.debug("Error in updating individual:"+ it)
			}
                if(params.profile)
                	{
                	render(view: "profile", model: [individualInstance: individualInstance,mode:'EDIT'])
                	return
                	}
                else
                	{
			if(params.patroncare)
				render(view: "editPatronCare", model: [individualInstance: individualInstance])
			else
				render(view: "edit", model: [individualInstance: individualInstance])
                	}
                
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'individual.label', default: 'Individual'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def individualInstance = Individual.get(params.id)
        if (individualInstance) {
        
	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAllGranted('ROLE_COUNSELLOR'))
	{
		//first check whether eligible to edit?
		if(!housekeepingService.checkDependent(params.id,Individual.findByLoginid(springSecurityService.principal.username)?.id))
		{
		    flash.message = "You can not delete the record from some other group!"
		    redirect(action: "show", id: params.id)
		    return
		}
		else
		{
		}
	}
	else
	{
	//check if donations exist
	def donations = Donation.findAllByDonatedBy(individualInstance)
	if(donations && donations.size()>0)
		{
		//donations exist..record can not be deleted for audit purposes
		flash.message = "There are valid donations against this person. Hence for audit reasons, the entry can not be deleted!!"
		redirect(action: "show", id: params.id)
		return
		}
	}
	

            try {
                individualInstance.status='DELETED'	//@TODO: soft delete only, need to take care of the heirarchy
                individualInstance.save()
                //individualInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'individual.label', default: 'Individual'), params.id])}"
                if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAllGranted('ROLE_COUNSELLOR') || org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAllGranted('ROLE_VOICE_ADMIN'))
                	redirect(action: "list",params: [type: "Counsellee"])
                else
                	redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'individual.label', default: 'Individual'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'individual.label', default: 'Individual'), params.id])}"
            redirect(action: "list")
        }
    }

    def assign = {
    	def icsRoleList = IcsRole.list(sort:'authority')
    	def roleList = Role.list(sort:'name')
        return [icsRoleList: icsRoleList,roleList: roleList]
    }

    def assignsave = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

    	def individual = Individual.get(params.individual)
    	def icsUser = IcsUser.get(params.icsuser)
    	individual.loginid = icsUser.username
    	if(individual.save(flush:true))
        	redirect(action: "list")
        else
        {
	   def sql = new Sql(dataSource);
	   sql.executeUpdate("update individual set loginid = ? where id=?", [icsUser?.username,individual?.id])
                redirect(action: "show", id: individual?.id)
        	}
    }
    
    def genericsearch = {
    println 'params='+params
    /*if (params.SearchDonors)
    {
    	if(params.SearchDonors=="on")
    	{
    		def individualDonors = []
    		def DonorCriteria = Individual.createCriteria()
    		individualDonors = DonorCriteria.list
    		{
    			eq("isDonor", true)
    		}
    		render(view: "list", model: [individualInstanceList: individualDonors, individualInstanceTotal: individualDonors.size, search: true])
    	}
    }
    else
    {*/
    def query = params.query
    if(!query)
    	{
        redirect(action: "list")
    	return
    	}
    def individuals = []
    def crit
    switch(params.searchon)
    	{
    		case "1":
    			//name
    			crit = Individual.createCriteria()
				individuals = crit.list
				{
				or{
					isNull('status')
					and{
					ne('status','MERGED')
					ne('status','DELETED')
					}
				}	    		
    				
    				if (params.SearchDonors)
    				{
    					if(params.SearchDonors=="on")
    					{
    						and{
    							//eq("isWellWisher", false)
    							//modified after adding the isDonor flag
    							eq("isDonor", true)
								or {
									if(params.ExactSearch=="Exact")						
									{
										eq("legalName", query)
										eq("initiatedName", query)
									}
									else
									{
										if(params.ExactSearch=="Like")
										{
											like("legalName", "%"+query+"%")
											like("initiatedName", "%"+query+"%")
										}
									}
								  }    			
    							}
							}
							else
							{
							or {
								if(params.ExactSearch=="Exact")						
								{
									eq("legalName", query)
									eq("initiatedName", query)
								}
								else
								{
									if(params.ExactSearch=="Like")
									{
										like("legalName", "%"+query+"%")
										like("initiatedName", "%"+query+"%")
									}
								}
                            }
						}
    				}
    				else
    				{
					or {
						if(params.ExactSearch=="Exact")						
						{
							eq("legalName", query)
							eq("initiatedName", query)
						}
						else
						{
							if(params.ExactSearch=="Like")
							{
								like("legalName", "%"+query+"%")
								like("initiatedName", "%"+query+"%")
							}
						}
					  }
    				}
				  order("legalName", "asc")
				  order("initiatedName", "asc")
				}
    			break
    		case "2":
    			//address
    			def addresses 
    			crit = Address.createCriteria()
    			addresses = crit.list
    			{
    				
					or {
							if(params.ExactSearch=="Exact")						
							{
								eq("addressLine1", query)
								eq("addressLine2", query)
								eq("addressLine3", query)
								eq("pincode", query)
							}
							else
							{
								if(params.ExactSearch=="Like")						
								{
									like("addressLine1", "%"+query+"%")
									like("addressLine2", "%"+query+"%")
									like("addressLine3", "%"+query+"%")
									like("pincode", "%"+query+"%")
								}
							}
						}
		    		}
		    	
    			addresses?.each{individuals.push(it?.individual)}
    			break
    		case "3":
    			//email
    			def emails 
				if(params.ExactSearch=="Exact")						
				{
    				emails = EmailContact.findAllByEmailAddress(query)				
				}
				else
				{
					if(params.ExactSearch=="Like")						
					{
    					emails = EmailContact.findAllByEmailAddressLike("%"+query+"%")				
    				}
				}

    			emails?.each{individuals.push(it?.individual)}
    			break
    		case "4":
    			//phone
    			def phones 
				if(params.ExactSearch=="Exact")						
				{
    			phones = VoiceContact.findAllByNumber(query)
				}
				else
				{
				if(params.ExactSearch=="Like")						
				{
    			phones = VoiceContact.findAllByNumberLike("%"+query+"%")				
				}
				}

    			phones?.each{individuals.push(it?.individual)}
    			break
    		case "5":
    			//code
    			crit = Individual.createCriteria()
			individuals = crit.list
				{
				or {
					if(params.ExactSearch=="Exact")						
					{
					eq("nvccDonarCode", query)
					}
					else
					{
					if(params.ExactSearch=="Like")
						{
	
					like("nvccDonarCode", "%"+query+"%")
				}
					}
					////println " Rani Test1"+params."ExactSearch"
				}
				}
    			break
    	
    	}
    	
                render(view: "searchresult", model: [individualInstanceList: individuals, individualInstanceTotal: individuals.size, search: true])
	//}
    }

    def linkdonation = {
    
    	println 'linkdonation params:'+params
    	return [id: params.id]
    }

    def linkdonationupdate = {
    	println 'linkdonationupdate params:'+params
    	
    	def Don = Donation.findByNvccReceiptBookNoAndNvccReceiptNo(params.receiptBook, params.receipt)
    	
    	if(Don)
    	{
		if((Don.donatedBy).toString() != 'Dummy Donor for daily transactions')
		{
			flash.message = "Donation "+Don+" donated by " + Don.donatedBy +". Cannot be linked to "+ Individual.get(params.individualId)+"."
			redirect(action: "show", id: params.individualId)
		}
		else
		{
			Don.donatedBy = Individual.get(params.individualId)
			if (!Don.hasErrors() && Don.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'donation.label', default: 'Donation'), Don.id])}"
				redirect(action: "show", id: params.individualId)
			}
			else {
				render(view: "linkdonation")
			}
		}
    	}
    	else
    	{
		flash.message = "Donation with ReceiptBook "+params.receiptBook+" and Receipt " + params.receipt +" not found. Please enter valid data."
		render(view: "linkdonation")
	}
    }
    
    def allCultivatorsAsJSON = {
    		def query = params.query
  		//println 'query='+query
  		def roles =[]
        	roles.add(Role.findByName("Cultivator"))
        	roles.add(Role.findAllByNameIlike("Patron%"))
        	roles = roles.flatten()
        	println 'roles='+roles
        	def c = Individual.createCriteria()
        	def collectors = c.list
        	{
		    	or {
				like("legalName", "%"+query+"%")
				like("initiatedName", "%"+query+"%")
		    	}
        		individualRoles
			{
				and
				{
					'in'("role",roles)
					eq("status", "VALID")
				}
			}
			order("initiatedName", "asc")
			order("legalName", "asc")
        	}
        	collectors = collectors.unique()
        response.setHeader("Cache-Control", "no-store")

        def results = collectors.collect {
            [  id: it.id,
               name: it.toString() ]
        }
	//println 'results='+results
        def data = [ result: results ]
        render data as JSON
    }

    def allGurusAsJSON = {
	def query = params.query
	def role = Role.findByName("Guru")
	def c = Individual.createCriteria()
	def collectors = c.list
		{
		or {
			like("legalName", "%"+query+"%")
			like("initiatedName", "%"+query+"%")
			like("sanyasName", "%"+query+"%")
		}
		individualRoles
			{
				and
				{
					eq("role",role)
					eq("status", "VALID")
				}
			}
			order("sanyasName", "asc")
			order("initiatedName", "asc")
			order("legalName", "asc")
		}
        response.setHeader("Cache-Control", "no-store")

        def results = collectors.collect {
            [  id: it.id,
               name: it.toString() ]
        }

        def data = [ result: results ]
        render data as JSON
    }

    def allCouncellorsAsJSON = {
	def query = params.query
	def role = Role.findByName("Councellor")
	def c = Individual.createCriteria()
	def collectors = c.list
		{
		or {
			like("legalName", "%"+query+"%")
			like("initiatedName", "%"+query+"%")
		}
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
        response.setHeader("Cache-Control", "no-store")

        def results = collectors.collect {
            [  id: it.id,
               name: it.toString() ]
        }

        def data = [ result: results ]
        render data as JSON
    }

    def findDepCollectorsAsJSON = {
 	response.setHeader("Cache-Control", "no-store")
   
    		def results
    		if (params.receiptid!=null)
    			{
    			def rcpt = Receipt.get(params.receiptid)
    			def rbi = ReceiptBookIssued.findByReceiptBook(rcpt.receiptBook,[sort:"issueDate",order:"desc"])
    			if (rbi!=null)
    				{
			results = 
			    [  id: rbi.issuedTo.id,
			       name: rbi.issuedTo.toString() ]
			               def data = [ result: results ]
			               render data as JSON
			               }
			               }

				def query = params.query
				def role = Role.findByName("Collector")
				def c = Individual.createCriteria()
				def collectors = c.list
					{
					or {
						like("legalName", "%"+query+"%")
						like("initiatedName", "%"+query+"%")
					}
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

			results = collectors.collect {
			    [  id: it.id,
			       name: it.toString() ]}
		

        def data = [ result: results ]
        render data as JSON
    }


    def allIndividualsAsJSON = {
	def query = params.query
	def c = Individual.createCriteria()
	def individuals = c.list(max:10)
		{
				or{
					isNull('status')
					and{
					ne('status','MERGED')
					ne('status','DELETED')
					}
				}	    		
		or {
			like("legalName", "%"+query+"%")
			like("initiatedName", "%"+query+"%")
		}
			order("initiatedName", "asc")
			order("legalName", "asc")
		}
        response.setHeader("Cache-Control", "no-store")

        def results = individuals.collect {
            [  id: it.id,
               name: it.toString() ]
        }

        def data = [ result: results ]
        render data as JSON
    }
    
    def allIndividualsExceptDummyDonorAsJSON = {
	def query = params.query
	//println 'query='+query
	def c = Individual.createCriteria()
	def individuals = c.list(max:10)
		{
		or{
			isNull('status')
			and{
			ne('status','MERGED')
			ne('status','DELETED')
			}
		}	    		
		or {
			like("legalName", "%"+query+"%")
			like("initiatedName", "%"+query+"%")
		}
		not{
			eq("legalName", "Dummy Donor for daily transactions")

		}

			order("initiatedName", "asc")
			order("legalName", "asc")
		}
        response.setHeader("Cache-Control", "no-store")

        def results = individuals.collect {
            [  id: it.id,
               name: it.toString() ]
        }
	//println 'results='+results
        def data = [ result: results ]
        render data as JSON
    }
    
    
    def ascollector = {
    def receipt = Receipt.get(params?.id)
    def receiptBookIssued = ReceiptBookIssued.findByReceiptBook(receipt?.receiptBook)
    def collector = receiptBookIssued?.issuedTo
    redirect(action: "show", id: collector?.id)
}

    def findIssuersAsJSON = {
	def query = params.query
	def collrole = Role.findByName("Collector")
	def culrole = Role.findByName("Cultivator")
	def c = Individual.createCriteria()
	def issuers = c.list
		{
		or {
			like("legalName", "%"+query+"%")
			like("initiatedName", "%"+query+"%")
		}
		individualRoles
			{
					or{
						and
						{
							eq("role",collrole)
							eq("status", "VALID")
						}
						and
						{
							eq("role",culrole)
							eq("status", "VALID")
						}
					}
			}
			order("initiatedName", "asc")
			order("legalName", "asc")
		}
        response.setHeader("Cache-Control", "no-store")

        def results = issuers.collect {
            [  id: it.id,
               name: it.toString() ]
        }

        def data = [ result: results ]
        render data as JSON
}

    def findCollectorsAsJSON = {
	def query = params.query
	def collrole = Role.findByName("Collector")
	def c = Individual.createCriteria()
	def issuers = c.list(max:10)
		{

				or {
					like("legalName", "%"+query+"%")
					like("initiatedName", "%"+query+"%")
				}


		individualRoles
			{
					and
					{
						eq("role",collrole)
						eq("status", "VALID")
					}
			}
			order("initiatedName", "asc")
			order("legalName", "asc")
		}
        response.setHeader("Cache-Control", "no-store")

        def results = issuers.collect {
            [  id: it.id,
               name: it.toString() ]
        }

        def data = [ result: results ]
       
        render data as JSON
}

    def findReceiversAsJSON = {
	def query = params.query
	def collrole = Role.findByName("Receiver")
	def c = Individual.createCriteria()
	def issuers = c.list
	{
	or {
		like("legalName", "%"+query+"%")
		like("initiatedName", "%"+query+"%")
	}
	individualRoles
		{
			and
			{
				eq("role",collrole)
				eq("status", "VALID")
			}
		}
		order("initiatedName", "asc")
		order("legalName", "asc")
	}
        response.setHeader("Cache-Control", "no-store")

        def results = issuers.collect {
            [  id: it.id,
               name: it.toString() ]
        }

        def data = [ result: results ]
        render data as JSON
}

    def findPatronCareAsJSON = {
	def query = params.query
	def collrole = Role.findByName("PatronCare")
	def pcSevakRole = Role.findByName("PatronCareSevak")
	def c = Individual.createCriteria()
	def issuers = c.list
	{
	or {
		like("legalName", "%"+query+"%")
		like("initiatedName", "%"+query+"%")
	}
	individualRoles
		{
		or
		{
			and
			{
				eq("role",collrole)
				eq("status", "VALID")
			}
			and
			{
				eq("role",pcSevakRole)
				eq("status", "VALID")
			}
			
		}
		}
		order("initiatedName", "asc")
		order("legalName", "asc")
	}
        response.setHeader("Cache-Control", "no-store")

        def results = issuers.collect {
            [  id: it.id,
               name: it.toString() ]
        }
	println 'results='+results
        def data = [ result: results ]
        render data as JSON
}

    def findWellwishersAsJSON = {
    		def query = params.query
        	def individuals = Individual.findAllByIsWellWisher(true,[sort:'legalName'])
        	
        response.setHeader("Cache-Control", "no-store")

        def results = individuals.collect {
            [  id: it.id,
               name: it.toString() ]
        }

        def data = [ result: results ]
        render data as JSON
    }
    
    def allIndividualsWithNoLoginIdAsJSON = {
		def query = params.query
		def c = Individual.createCriteria()
		def individuals = c.list
			{
			and{
				or {
					like("legalName", "%"+query+"%")
					like("initiatedName", "%"+query+"%")
				}
				isNull("loginid")
				not{
					eq("legalName", "Dummy Donor for daily transactions")
		    	}
			}
			order("initiatedName", "asc")
			order("legalName", "asc")
		}
        response.setHeader("Cache-Control", "no-store")

        def results = individuals.collect {
            [  id: it.id,
               name: it.toString() ]
        }

        def data = [ result: results ]
        render data as JSON
    }
    
    def allIndividualsWithNoLoginIdAsJSON_JQ = {
		def query = params.term
		def c = Individual.createCriteria()
		def individuals = c.list(max:10)
			{
			or {
				like("legalName", "%"+query+"%")
				like("initiatedName", "%"+query+"%")
			}
			isNull("loginid")
			or{
				isNull('status')
				and{
				ne('status','MERGED')
				ne('status','DELETED')
				}
			}	    		
			not{
				eq("legalName", "Dummy Donor for daily transactions")
			}
			order("initiatedName", "asc")
			order("legalName", "asc")
		}
        response.setHeader("Cache-Control", "no-store")

        def results = individuals.collect {
            [  
               id: it.id,
               value: it.toString()+"("+it.status+")",
               label: it.toString()+"("+it.status+")" ]
        }

        render results as JSON
    }
  
    def allGurusAsJSON_JQ = {
		def query = params.term
		def c = IndividualRole.createCriteria()
		def result = c.list(max:10)
			{
				eq('status','VALID')
				role{eq('name','Guru')}
				individual{
				or {
					ilike("legalName", "%"+query+"%")
					ilike("initiatedName", "%"+query+"%")
					ilike("sanyasName", "%"+query+"%")
				    }
				order("legalName", "asc")
				}
			}
        response.setHeader("Cache-Control", "no-store")

        def results = result.collect {
            [  
               id: it.individual.id,
               value: it.individual.toString(),
               label: it.individual.toString() ]
        }

        render results as JSON
    }

    def allIndividualsFuzzyAsJSON_JQ = {
	def individuals
	if(params.term)
		individuals = housekeepingService.searchIndividualName(params.term)
	
        response.setHeader("Cache-Control", "no-store")

        def results = individuals?.collect {
            [  
               id: it.id,
               value: it.toString(),
               label: it.toString() +" (ICSid "+(100000+it.id)+")" ]
        }

        render results as JSON
    }
  
    def allIndividualsAsJSON_JQ = {
		def query = params.term
		//many times there is a middle name so handle it automatically
		query = query.replaceAll(' ','%')
		def c = Individual.createCriteria()
		def individuals = c.list(max:10)
			{
			and{
				or {
					like("legalName", query+"%")
					like("initiatedName", query+"%")
				}
				not{
					eq("legalName", "Dummy Donor for daily transactions")
		    		}
				or{
					isNull('status')
					and{
					ne('status','MERGED')
					ne('status','DELETED')
					}
				}	    		
			}
			order("initiatedName", "asc")
			order("legalName", "asc")
		}
        response.setHeader("Cache-Control", "no-store")

        def results = individuals.collect {
            [  
               id: it.id,
               value: it.toString(),
               label: it.toString()+" (ICSid "+it.icsid+")" ]
        }

        render results as JSON
    }

    def doubleshow = {
    	def id1=params.id
    	def id2=params.id2
        def individualInstance = Individual.get(id1)
        def individualInstance2 = Individual.get(id2)
        if (!individualInstance||!individualInstance2) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'individual.label', default: 'Individual'), params.id])}"
            redirect(action: "list")
        }
        else {
            [individualInstance: individualInstance,individualInstance2: individualInstance2]
        }
    }

def merge = {
    	def id1=params.id
    	def id2=params.id2
        def individual1 = Individual.get(id1)
        def individual2 = Individual.get(id2)
        def mergedIndividual = new Individual()
        def verror = false
        flash.message = ""
        
	//merge primitive attrs
	mergedIndividual.isMale	=individual1.isMale	|| individual2.isMale
	mergedIndividual.isDonor	=individual1.isDonor || individual2.isDonor
	//mergedIndividual.isWellWisher	=individual1.isWellWisher || individual2.isWellWisher
	mergedIndividual.isLifeMember	=individual1.isLifeMember || individual2.isLifeMember

	mergedIndividual.legalName	 = housekeepingService.createUniqueString(individual1.legalName , individual2.legalName)
	mergedIndividual.initiatedName	 = housekeepingService.createUniqueString(individual1.initiatedName , individual2.initiatedName)
	mergedIndividual.sanyasName	 = housekeepingService.createUniqueString(individual1.sanyasName , individual2.sanyasName)
	mergedIndividual.category	 = housekeepingService.createUniqueString(individual1.category , individual2.category)
	mergedIndividual.status	 = housekeepingService.createUniqueString(individual1.status , individual2.status)
	mergedIndividual.ashram	 = housekeepingService.createUniqueString(individual1.ashram , individual2.ashram)
	mergedIndividual.varna	 = housekeepingService.createUniqueString(individual1.varna , individual2.varna)
	mergedIndividual.profession	 = housekeepingService.createUniqueString(individual1.profession , individual2.profession)
	mergedIndividual.nvccDonarCode	 = housekeepingService.createUniqueString(individual1.nvccDonarCode , individual2.nvccDonarCode)
	mergedIndividual.nvccId	 = housekeepingService.createUniqueString(individual1.nvccId , individual2.nvccId)
	mergedIndividual.nvccName	 = housekeepingService.createUniqueString(individual1.nvccName , individual2.nvccName)
	mergedIndividual.nvccIskconRef	 = housekeepingService.createUniqueString(individual1.nvccIskconRef , individual2.nvccIskconRef)
	mergedIndividual.nvccFamilyId	 = housekeepingService.createUniqueString(individual1.nvccFamilyId , individual2.nvccFamilyId)
	mergedIndividual.nvccRelation	 = housekeepingService.createUniqueString(individual1.nvccRelation , individual2.nvccRelation)
	mergedIndividual.designation	 = housekeepingService.createUniqueString(individual1.designation , individual2.designation)
	mergedIndividual.motherTongue	 = housekeepingService.createUniqueString(individual1.motherTongue , individual2.motherTongue)
	mergedIndividual.raashi	 = housekeepingService.createUniqueString(individual1.raashi , individual2.raashi)
	mergedIndividual.gotra	 = housekeepingService.createUniqueString(individual1.gotra , individual2.gotra)
	mergedIndividual.nakshatra	 = housekeepingService.createUniqueString(individual1.nakshatra , individual2.nakshatra)
	mergedIndividual.literatureLanguagePreference	 = housekeepingService.createUniqueString(individual1.literatureLanguagePreference , individual2.literatureLanguagePreference)
	mergedIndividual.communicationsPreference	 = housekeepingService.createUniqueString(individual1.communicationsPreference , individual2.communicationsPreference)
	mergedIndividual.languagePreference	 = housekeepingService.createUniqueString(individual1.languagePreference , individual2.languagePreference)
	mergedIndividual.picFileURL	 = housekeepingService.createUniqueString(individual1.picFileURL , individual2.picFileURL)
	mergedIndividual.membershipNo	 = housekeepingService.createUniqueString(individual1.membershipNo , individual2.membershipNo)
	mergedIndividual.membershipPlace	 = housekeepingService.createUniqueString(individual1.membershipPlace , individual2.membershipPlace)
	mergedIndividual.businessRemarks	 = housekeepingService.createUniqueString(individual1.businessRemarks , individual2.businessRemarks)
	mergedIndividual.remarks	 = housekeepingService.createUniqueString(individual1.remarks , individual2.remarks)
	mergedIndividual.panNo	 = housekeepingService.createUniqueString(individual1.panNo , individual2.panNo)
	mergedIndividual.firstInitiationPlace	 = housekeepingService.createUniqueString(individual1.firstInitiationPlace , individual2.firstInitiationPlace)
	mergedIndividual.secondInitiationPlace	 = housekeepingService.createUniqueString(individual1.secondInitiationPlace , individual2.secondInitiationPlace)
	mergedIndividual.loginid	 = housekeepingService.createUniqueString(individual1.loginid , individual2.loginid)

	if (individual1.dob!=null && individual2.dob!=null)
		if (individual1.dob==individual2.dob)
			mergedIndividual.dob	=individual1.dob
		else
			{
			verror=true
			flash.message += "DoB different!"
			}
	else
		mergedIndividual.dob = (individual1.dob==null)?individual2.dob:individual1.dob

	if (individual1.marriageAnniversary!=null && individual2.marriageAnniversary!=null)
		if (individual1.marriageAnniversary==individual2.marriageAnniversary)
			mergedIndividual.marriageAnniversary	=individual1.marriageAnniversary
		else
			{
			verror=true
			flash.message += "marriageAnniversary different!"
			}
	else
		mergedIndividual.marriageAnniversary = (individual1.marriageAnniversary==null)?individual2.marriageAnniversary:individual1.marriageAnniversary

	if (individual1.firstInitiation!=null && individual2.firstInitiation!=null)
		if (individual1.firstInitiation==individual2.firstInitiation)
			mergedIndividual.firstInitiation	=individual1.firstInitiation
		else
			{
			verror=true
			flash.message += "firstInitiation different!"
			}
	else
		mergedIndividual.firstInitiation = (individual1.firstInitiation==null)?individual2.firstInitiation:individual1.firstInitiation

	if (individual1.secondInitiation!=null && individual2.secondInitiation!=null)
		if (individual1.secondInitiation==individual2.secondInitiation)
			mergedIndividual.secondInitiation	=individual1.secondInitiation
		else
			{
			verror=true
			flash.message += "secondInitiation different!"
			}
	else
		mergedIndividual.secondInitiation = (individual1.secondInitiation==null)?individual2.secondInitiation:individual1.secondInitiation


	if (individual1.title!=null && individual2.title!=null)
		if (individual1.title.id==individual2.title.id)
			mergedIndividual.title	=individual1.title
		else
			{
			verror=true
			flash.message += "title different!"
			}
	else
		mergedIndividual.title = (individual1.title==null)?individual2.title:individual1.title
		mergedIndividual.title = individual2.title


	//primary attributes have been set, now try to save this
	def saveFlag
	if(verror)
			redirect(action: "doubleshow", id: id1, id2: id2)
		else
			//save merged individual
			if (springSecurityService.isLoggedIn()) {
				mergedIndividual.updator=springSecurityService.principal.username
			}
			else
				mergedIndividual.updator=springSecurityService.principal.username
			saveFlag = mergedIndividual.save(flush: true)

	if(saveFlag)
	{
	   def sql = new Sql(dataSource);
	   
	   def cid
	   
	   //change mappings for ind1
	   if (individual1.address!=null)
	   	{
	   	cid = individual1.id
	   	sql.executeUpdate("update address set individual_id = ? where individual_id=?", [mergedIndividual.id, cid])
		}
	   if (individual1.emailContact!=null)
	   	{
	   	cid = individual1.id
	   	sql.executeUpdate("update email_contact set individual_id = ? where individual_id=?", [mergedIndividual.id, cid])
		}
	   if (individual1.voiceContact!=null)
	   	{
	   	cid = individual1.id
	   	sql.executeUpdate("update voice_contact set individual_id = ? where individual_id=?", [mergedIndividual.id, cid])
		}
	   if (individual1.otheContact!=null)
	   	{
	   	cid = individual1.id
	   	sql.executeUpdate("update other_contact set individual_id = ? where individual_id=?", [mergedIndividual.id, cid])
		}
	   if (individual1.events!=null)
	   	{
	   	cid = individual1.id
	   	sql.executeUpdate("update event_participant set individual_id = ? where individual_id=?", [mergedIndividual.id, cid])
		}
 	   if (individual1.individualRoles!=null)
 	   	{
 	   	cid = individual1.id
 	   	sql.executeUpdate("update individual_role set individual_id = ? where individual_id=?", [mergedIndividual.id, cid])
 		}
	   if (individual1.donations!=null)
	   	{
	   	cid = individual1.id
	   	sql.executeUpdate("update donation set donated_by_id = ? where donated_by_id=?", [mergedIndividual.id, cid])
		}
	   if (individual1.fundCollections!=null)
	   	{
	   	cid = individual1.id
	   	sql.executeUpdate("update donation set collected_by_id = ? where collected_by_id=?", [mergedIndividual.id, cid])
		}
	   if (individual1.fundsReceived!=null)
	   	{
	   	cid = individual1.id
	   	sql.executeUpdate("update donation set received_by_id = ? where received_by_id=?", [mergedIndividual.id, cid])
		}
	   if (individual1.followupsWith!=null)
	   	{
	   	cid = individual1.id
	   	sql.executeUpdate("update followup set ind_with_id = ? where ind_with_id=?", [mergedIndividual.id, cid])
		}
	   if (individual1.followupsBy!=null)
	   	{
	   	cid = individual1.id
	   	sql.executeUpdate("update followup set ind_by_id = ? where ind_by_id=?", [mergedIndividual.id, cid])
		}
	   if (individual1.giftIssuedBy!=null)
	   	{
	   	cid = individual1.id
	   	sql.executeUpdate("update gift_issued set issued_by_id = ? where issued_by_id=?", [mergedIndividual.id, cid])
		}
	   if (individual1.giftIssuedTo!=null)
	   	{
	   	cid = individual1.id
	   	sql.executeUpdate("update gift_issued set issued_to_id = ? where issued_to_id=?", [mergedIndividual.id, cid])
		}
	   if (individual1.relative1!=null)
	   	{
	   	cid = individual1.id
	   	sql.executeUpdate("update relationship set individual1_id = ? where individual1_id=?", [mergedIndividual.id, cid])
		}
	   if (individual1.relative2!=null)
	   	{
	   	cid = individual1.id
	   	sql.executeUpdate("update relationship set individual2_id = ? where individual2_id=?", [mergedIndividual.id, cid])
		}
	   if (individual1.objectives!=null)
	   	{
	   	cid = individual1.id
	   	sql.executeUpdate("update objective set individual_id = ? where individual_id=?", [mergedIndividual.id, cid])
		}
		
	//do the same for ind2
	   if (individual2.address!=null)
	   	{
	   	cid = individual2.id
	   	sql.executeUpdate("update address set individual_id = ? where individual_id=?", [mergedIndividual.id, cid])
		}
	   if (individual2.emailContact!=null)
	   	{
	   	cid = individual2.id
	   	sql.executeUpdate("update email_contact set individual_id = ? where individual_id=?", [mergedIndividual.id, cid])
		}
	   if (individual2.voiceContact!=null)
	   	{
	   	cid = individual2.id
	   	sql.executeUpdate("update voice_contact set individual_id = ? where individual_id=?", [mergedIndividual.id, cid])
		}
	   if (individual2.otheContact!=null)
	   	{
	   	cid = individual2.id
	   	sql.executeUpdate("update other_contact set individual_id = ? where individual_id=?", [mergedIndividual.id, cid])
		}
	   if (individual2.events!=null)
	   	{
	   	cid = individual2.id
	   	sql.executeUpdate("update event_participant set individual_id = ? where individual_id=?", [mergedIndividual.id, cid])
		}
 	   if (individual2.individualRoles!=null)
 	   	{
 	   	cid = individual2.id
 	   	sql.executeUpdate("update individual_role set individual_id = ? where individual_id=?", [mergedIndividual.id, cid])
 		}
	   if (individual2.donations!=null)
	   	{
	   	cid = individual2.id
	   	sql.executeUpdate("update donation set donated_by_id = ? where donated_by_id=?", [mergedIndividual.id, cid])
		}
	   if (individual2.fundCollections!=null)
	   	{
	   	cid = individual2.id
	   	sql.executeUpdate("update donation set collected_by_id = ? where collected_by_id=?", [mergedIndividual.id, cid])
		}
	   if (individual2.fundsReceived!=null)
	   	{
	   	cid = individual2.id
	   	sql.executeUpdate("update donation set received_by_id = ? where received_by_id=?", [mergedIndividual.id, cid])
		}
	   if (individual2.followupsWith!=null)
	   	{
	   	cid = individual2.id
	   	sql.executeUpdate("update followup set ind_with_id = ? where ind_with_id=?", [mergedIndividual.id, cid])
		}
	   if (individual2.followupsBy!=null)
	   	{
	   	cid = individual2.id
	   	sql.executeUpdate("update followup set ind_by_id = ? where ind_by_id=?", [mergedIndividual.id, cid])
		}
	   if (individual2.giftIssuedBy!=null)
	   	{
	   	cid = individual2.id
	   	sql.executeUpdate("update gift_issued set issued_by_id = ? where issued_by_id=?", [mergedIndividual.id, cid])
		}
	   if (individual2.giftIssuedTo!=null)
	   	{
	   	cid = individual2.id
	   	sql.executeUpdate("update gift_issued set issued_to_id = ? where issued_to_id=?", [mergedIndividual.id, cid])
		}
	   if (individual2.relative1!=null)
	   	{
	   	cid = individual2.id
	   	sql.executeUpdate("update relationship set individual1_id = ? where individual1_id=?", [mergedIndividual.id, cid])
		}
	   if (individual2.relative2!=null)
	   	{
	   	cid = individual2.id
	   	sql.executeUpdate("update relationship set individual2_id = ? where individual2_id=?", [mergedIndividual.id, cid])
		}
	   if (individual2.objectives!=null)
	   	{
	   	cid = individual2.id
	   	sql.executeUpdate("update objective set individual_id = ? where individual_id=?", [mergedIndividual.id, cid])
		}
	
	}


	if(saveFlag)
		{
			//delete the old entries
			individual1.delete()
			individual2.delete()
		    flash.message = "${message(code: 'default.created.message', args: [message(code: 'individual.label', default: 'Individual'), mergedIndividual.id])}"
		    redirect(action: "show", id: mergedIndividual.id)
		}
		else {
		    render(view: "create", model: [individualInstance: mergedIndividual])
		}

}
  
  def toGuess = "25"
 
  def guessFlow = {
 
    start {
      action {
        [guessLeft: 5]
      }
      on("success").to("ask")
    }
 
    ask {
      on("evaluate").to("evaluate")
    }
 
    done()
 
    fail()
 
    evaluate {
      action {
        if (params.number == toGuess)
        {
          return yes()
        }
        flow.guessLeft = flow.guessLeft - 1
        if (flow.guessLeft == 0)
        {
          return loose()
        }
        else
        {
          return no()
        }
      }
      on("yes").to("done")
      on("no").to("ask")
      on("loose").to("fail")
    }
  }


    def folkMemberReport = {
	switch(params.searchon)
		{
			case "dob":
				redirect(action: "folkMemberBirthMonthReport", params: [month:params.month])
				break
			case "ma":
				redirect(action: "folkMemberMAMonthReport", params: [month:params.month])
				break
			default:
				def flagsInstanceList = Flags.findAllByFolk(true)
				def individualInstanceList = []
				def individual
				for(flag in flagsInstanceList)
					{
					individual = Individual.get(flag.individualid)
					individualInstanceList.add(individual)
					}
				individualInstanceList.sort{it.legalName}
			    	render(view: "list", model: [individualInstanceList: individualInstanceList, individualInstanceTotal: individualInstanceList.size(), search: true])
				
		}

    		
	}

    def folkMemberBirthMonthReport = {
    		def flagsInstanceList = Flags.findAllByFolk(true)
    		def individualInstanceList = []
    		def individual

    		def currMonth
    		if(params.month)
    			currMonth = params.month
    		else
    			{
			def today = new Date()
			currMonth = today.format('M')
    			}

    		for(flag in flagsInstanceList)
    			{
    			individual = Individual.get(flag.individualid)
    			//println "currMonth:"+currMonth+":mob:"+individual?.dob?.format('M')+":mom:"+individual?.marriageAnniversary?.format('M')

    			//check for dob or dom
    			if(individual?.dob?.format('M') == currMonth)
	    			individualInstanceList.add(individual)
	    		//check for any of the relatives
	    		for(relative in individual?.relative2)
	    			{
	    			if(relative?.relation?.name!='Disciple of' && relative?.relation?.name!='Councellee of' && relative?.relation?.name!='Cultivated by')
	    				{
	    				println "("+relative?.relation +")"+relative?.individual1
	    				//check for dob or dom
					   if(relative?.individual1?.dob?.format('M') == currMonth)
	    					individualInstanceList.add(relative?.individual1)
	    				}
	    			}
    			}
    		individualInstanceList.sort{it.dob?.format('dd')}
            render(view: "list", model: [individualInstanceList: individualInstanceList, individualInstanceTotal: individualInstanceList.size(), search: true])
	}

    def folkMemberMAMonthReport = {
    		def flagsInstanceList = Flags.findAllByFolk(true)
    		def individualInstanceList = []
    		def individual

    		def currMonth
    		if(params.month)
    			currMonth = params.month
    		else
    			{
			def today = new Date()
			currMonth = today.format('M')
    			}

    		for(flag in flagsInstanceList)
    			{
    			individual = Individual.get(flag.individualid)
    			//println "currMonth:"+currMonth+":mob:"+individual?.dob?.format('M')+":mom:"+individual?.marriageAnniversary?.format('M')

    			//check for dob or dom
    			if(individual?.marriageAnniversary?.format('M') == currMonth)
	    			individualInstanceList.add(individual)
	    		//check for any of the relatives
	    		/*for(relative in individual?.relative2)
	    			{
	    			if(relative?.relation?.name!='Disciple of' && relative?.relation?.name!='Councellee of' && relative?.relation?.name!='Cultivated by')
	    				{
	    				println "("+relative?.relation +")"+relative?.individual1
	    				//check for dob or dom
					   if(relative?.individual1?.marriageAnniversary?.format('M') == currMonth)
	    					individualInstanceList.add(relative?.individual1)
	    				}
	    			}*/
    			}
    		individualInstanceList.sort{it.marriageAnniversary?.format('dd')}
            render(view: "list", model: [individualInstanceList: individualInstanceList, individualInstanceTotal: individualInstanceList.size(), search: true])
	}

    def patronMemberReport = {
	switch(params.searchon)
		{
			case "dob":
				redirect(action: "patronMemberBirthMonthReport", params: [month:params.month])
				break
			case "ma":
				redirect(action: "patronMemberMAMonthReport", params: [month:params.month])
				break
			default:
				def rships = Relationship.findAllWhere(status:'ACTIVE',individual2:Individual.findByLoginid(springSecurityService.principal.username),relation:Relation.findByName('Cultivated by'))
				def individualInstanceList = []
				rships.each
					{r->
					individualInstanceList.add(r.individual1)
					}
			    	render(view: "list", model: [individualInstanceList: individualInstanceList, individualInstanceTotal: individualInstanceList.size(), search: true])
				
		}

    		
	}

    def patronMemberBirthMonthReport = {
		def rships = Relationship.findAllWhere(status:'ACTIVE',individual2:Individual.findByLoginid(springSecurityService.principal.username),relation:Relation.findByName('Cultivated by'))
		def rindividualInstanceList = []
		def individualInstanceList = []
		rships.each
			{r->
			rindividualInstanceList.add(r.individual1)
			}
    		println rindividualInstanceList

    		def currMonth
    		if(params.month)
    			currMonth = params.month
    		else
    			{
			def today = new Date()
			currMonth = today.format('M')
    			}

    		def individual
    		rindividualInstanceList.each
    			{i->
    			println i
    			individual = i
    			//println "currMonth:"+currMonth+":mob:"+individual?.dob?.format('M')+":mom:"+individual?.marriageAnniversary?.format('M')

    			//check for dob or dom
    			if(individual?.dob?.format('M') == currMonth)
	    			individualInstanceList.add(individual)
	    		//check for any of the relatives
	    		for(relative in individual?.relative2)
	    			{
	    			if(relative?.relation?.name!='Disciple of' && relative?.relation?.name!='Councellee of' && relative?.relation?.name!='Cultivated by')
	    				{
	    				println "("+relative?.relation +")"+relative?.individual1
	    				//check for dob or dom
					   if(relative?.individual1?.dob?.format('M') == currMonth)
	    					individualInstanceList.add(relative?.individual1)
	    				}
	    			}
    			}
    		individualInstanceList.sort{it.dob?.format('dd')}
            render(view: "list", model: [individualInstanceList: individualInstanceList, individualInstanceTotal: individualInstanceList.size(), search: true])
	}

    def patronMemberMAMonthReport = {
	def rships = Relationship.findAllWhere(status:'ACTIVE',individual2:Individual.findByLoginid(springSecurityService.principal.username),relation:Relation.findByName('Cultivated by'))
	def rindividualInstanceList = []
	def individualInstanceList = []
	rships.each
		{r->
		rindividualInstanceList.add(r.individual1)
		}

	def currMonth
	if(params.month)
		currMonth = params.month
	else
		{
		def today = new Date()
		currMonth = today.format('M')
		}

	def individual
	rindividualInstanceList.each
		{
		i->
		individual = i
		//println "currMonth:"+currMonth+":mob:"+individual?.dob?.format('M')+":mom:"+individual?.marriageAnniversary?.format('M')

		//check for dob or dom
		if(individual?.marriageAnniversary?.format('M') == currMonth)
			individualInstanceList.add(individual)
		//check for any of the relatives
		/*for(relative in individual?.relative2)
			{
			if(relative?.relation?.name!='Disciple of' && relative?.relation?.name!='Councellee of' && relative?.relation?.name!='Cultivated by')
				{
				println "("+relative?.relation +")"+relative?.individual1
				//check for dob or dom
				   if(relative?.individual1?.marriageAnniversary?.format('M') == currMonth)
					individualInstanceList.add(relative?.individual1)
				}
			}*/
		}
    		individualInstanceList.sort{it.marriageAnniversary?.format('dd')}
            render(view: "list", model: [individualInstanceList: individualInstanceList, individualInstanceTotal: individualInstanceList.size(), search: true])
	}
	
def upload_avatar = {
  def individual = Individual.get(params.id)
  // Get the avatar file from the multi-part request
  def f = request.getFile('avatar')
  // List of OK mime-types
  def okcontents = ['image/png', 'image/jpeg', 'image/gif']
  if (! okcontents.contains(f.getContentType())) {
    flash.message = "Image must be one of: ${okcontents}"
    render(view:'edit', model:[individualInstance:individual])
    return;
  }
  // Save the image and mime type
  individual.avatar = f.getBytes()
  individual.avatarType = f.getContentType()
  //log.info("File uploaded: " + individual.avatarType)
  // Validation works, will check if the image is too big
  if (!individual.save()) {
    render(view:'edit', model:[individualInstance:individual])
    return;
  }
  flash.message = "Image (${individual.avatarType}, ${individual.avatar.size()} bytes) uploaded."
  if(params.profile=="true")
  	redirect(action:'show', id: individual.id,params:[profile:"true"])
  else if (request.xhr)
  	{
	  /*response.setContentType(individual.avatarType)
	  response.setContentLength(individual.avatar.size())
	  OutputStream out = response.getOutputStream();
	  out.write(individual.avatar);
	  out.close();*/
	  render "done"
	}
  else
	redirect(action:'show', id: individual.id)
  
}

def avatar_image = {
  def avatarUser = Individual.get(params.id)
  if (!avatarUser || !avatarUser.avatar || !avatarUser.avatarType) {
    response.sendError(404)
    return;
  }
  response.setContentType(avatarUser.avatarType)
  response.setContentLength(avatarUser.avatar.size())
  OutputStream out = response.getOutputStream();
  out.write(avatarUser.avatar);
  out.close();
}

def findDepCouncellorAsJSON = {
println "inside findDepCouncellorAsJSON: "+params
response.setHeader("Cache-Control", "no-store")

	def results
	if (params.individualid!=null)
		{
		def ind = Individual.get(params.individualid)
		def rel = Relation.findByName("Councellee of")
		def reln = Relationship.findWhere(individual1:ind,relation:rel,status:"ACTIVE")

	results = reln.collect {
	    [  id: it.individual2.id,
	       name: it.individual2.toString() ]
	}

	def data = [ result: results ]
	println "result->"+data
	render data as JSON
	println "result->"+data
	}

}


def self() {
	if(Individual.findByLoginid(springSecurityService.principal.username)?.id)
		{
		//redirect(action: "show", id: Individual.findByLoginid(springSecurityService.principal.username)?.id)
		//forward(action: "show", id: session.individualid,params:[profile:"true"])
		//forward(action: "show", id: session.individualid,params:[profile:"true"])
		forward(action: "selfContact")
		}
	else
		render "This loginid is not associated with any person. Please contact admin!"
}

def selfContact() {
	def individual = Individual.get(session.individualid)
	def phone = VoiceContact.findAllByIndividualAndCategory(individual,'CellPhone').collect{it.number}.join(',')
	def email = EmailContact.findAllByIndividualAndCategory(individual,'Personal').collect{it.emailAddress}.join(',')
	[phone:phone,email:email]
}

def selfContactUpdate() {
	log.debug("selfContactUpdate:"+params) 
	def individual = Individual.get(session.individualid)
	individualService.contactUpdate(individual,params)
	flash.message = "Contacts updated..."
	forward(action: "selfContact")	
}


def updateCultivator = {
	println "Saving relationship with params: " + params
	println 'params.cultivatorLink='+params.cultivatorLink
	params."relation.id"= params.relationId
	params."individual1.id" = params.individual1Id
	params."individual2.id" = params.individual2Id

	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator
    
    	println "Saving relationship with params: " + params
    	
        def relationshipInstance = new Relationship(params)
        relationshipInstance.status = "ACTIVE"
        
        if (relationshipInstance.save(flush: true)) 
        	println "successful in saving cultivator"
        else
        	println "error in saving cultivator"
	
	redirect(action: "show", id: params."individual1Id")
}

// return JSON list of individual
    def jq_individual_list = {
    //println 'INDIVIDUAL LIST Params:'+params
      def now = new Date()
      def today = now.format('D')
      
      def sortIndex = params.sidx ?: 'legal_name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1
      
      if(params.address)
      	maxRows = 100000


      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
    	def result
      /*if (params.legal_name)
      {
    		result = Individual.createCriteria().list(max:maxRows, offset:rowOffset) {
	      // name case insensitive where the field contains with the search term
	      if (params.legal_name)
		ilike('legal_name','%'+params.legal_name + '%')
		}
		
      }
	else
	{*/

	if(params.oper=="excel" )
		{
			maxRows = 100000
			rowOffset = 0
		}

	
	def pcGroup, pcGroupStr	
      def sql = new Sql(dataSource);
      String query = ""
      def flgSearchByLegalName=0, flgSearchByInitiatedName=0
      
      if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
      {
      		pcGroup = housekeepingService.getPCGroup()
		pcGroupStr = pcGroup.toString().replace("[","")
		pcGroupStr = pcGroupStr.toString().replace("]","")
      		
	      //query = "select i.id,i.legal_name,i.initiated_name,date_format(i.dob,'%D %b') dob,date_format(i.marriage_anniversary,'%D %b') marriage_anniversary,sum(amount) donation_amount from individual i join relationship rship on rship.individual1_id=i.id join donation d on i.id=d.donated_by_id and rship.relation_id=(select id from relation where name='Cultivated by') and rship.status='ACTIVE' and rship.individual2_id="+session.individualid
	      //query = "select * from (select i.id,i.legal_name,i.initiated_name,date_format(i.dob,'%D %b') dob,date_format(i.marriage_anniversary,'%D %b')   marriage_anniversary from individual i join relationship rship on rship.individual1_id=i.id where rship.relation_id=(select id from relation where name='Cultivated by') and rship.status='ACTIVE' and rship.individual2_id="+session.individualid+") q left join individual_donation_view idv on idv.iid=q.id"
	      //query = "select id,legal_name,initiated_name,date_format(dob,'%D %b') dob,date_format(marriage_anniversary,'%D %b') marriage_anniversary, iid, donation_amount from (select i.id,i.legal_name,i.initiated_name,i.dob,i.marriage_anniversary from individual i join relationship rship on rship.individual1_id=i.id where rship.relation_id=(select id from relation where name='Cultivated by') and rship.status='ACTIVE' and rship.individual2_id="+session.individualid+") q left join individual_donation_view idv on idv.iid=q.id"
	      query = "select distinct q.id,legal_name,initiated_name,date_format(dob,'%D %b') dob,date_format(marriage_anniversary,'%D %b') marriage_anniversary, iid, donation_amount,icul.cultivator from (select i.id,i.legal_name,i.initiated_name,i.dob,i.marriage_anniversary from individual i join relationship rship on rship.individual1_id=i.id where rship.relation_id=(select id from relation where name='Cultivated by') and rship.status='ACTIVE' and rship.individual2_id in ("+pcGroupStr+")) q left join individual_donation_view idv on idv.iid=q.id left join individual_cultivator_view icul on q.id=icul.id"
	      //add conditions
	      if (params.legal_name)
	      {
	      	query += " where legal_name like '%"+params.legal_name+"%'"
	      	flgSearchByLegalName = 1
	      }
	      
	      if (params.initiated_name)
	      {
	      	if(flgSearchByLegalName == 1)
	      		query += " and initiated_name like '%"+params.initiated_name+"%'"
	      	else
	      		query += " where initiated_name like '%"+params.initiated_name+"%'"
	      	flgSearchByInitiatedName = 1
	      }
	      
	      if (params.cultivator)
	      {
	      	if(flgSearchByLegalName == 1 || flgSearchByInitiatedName == 1)
	      		query += " and cultivator like '%"+params.cultivator+"%'"
	      	else
	      		query += " where cultivator like '%"+params.cultivator+"%'"
	      }
	      
	      if(params.dobFlag)
	      	query += " where (day(dob) >= "+params.dayFrom+" AND month(dob) >= "+(((now.month).toInteger()+(1*1).toInteger())*1)+") and (day(dob) <= "+params.dayTo+" AND month(dob) <= "+(((now.month).toInteger()+(1*1).toInteger())*1) +")" 
		//query += " and dayofyear(dob)>="+today+" and dayofyear(dob)<="+(new Integer(today)+new Integer(params.dayRange?:0))
	      if(params.maFlag)
	      	query += " where (day(marriage_anniversary) >= "+params.dayFrom+" AND month(marriage_anniversary) >= "+(((now.month).toInteger()+(1*1).toInteger())*1)+") and (day(marriage_anniversary) <= "+params.dayTo+" AND month(marriage_anniversary) <= "+(((now.month).toInteger()+(1*1).toInteger())*1) +")" 
		//query += " and dayofyear(marriage_anniversary)>="+today+" and dayofyear(marriage_anniversary)<="+(new Integer(today)+new Integer(params.dayRange?:0))

	      //group by condition
	      //query += " group by i.id,i.legal_name,i.initiated_name,i.dob,i.marriage_anniversary"
	      //query += " group by id,legal_name,initiated_name,dob,marriage_anniversary"
	      //having conditions
	      if(params.donationFlag)
		query += " having donation_amount >="+params.minAmt+" and donation_amount<="+params.maxAmt
		println 'query='+query
      }
      else if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_EVENTADMIN,ROLE_EVENTMANAGER'))
      {
	      query = "select i.id,i.legal_name,i.initiated_name,date_format(i.dob,'%D %b') dob,date_format(i.marriage_anniversary,'%D %b') marriage_anniversary,sum(amount) donation_amount from individual i left join donation d on i.id=d.donated_by_id"
	      //group by condition
	      query += " group by i.id,i.legal_name,i.initiated_name,i.dob,i.marriage_anniversary"
	      //having conditions
	      if(params.donationFlag)
		query += " having donation_amount >="+params.minAmt?:0+" and donation_amount<="+params.maxAmt?:100000000
      }

      
      
      //add sorting,ordering
      query += " order by "+sortIndex+" "+sortOrder
      
      println query
      result = sql.rows(query,rowOffset,maxRows)

	//println 'result='+result
      String countQuery = "select count(1) cnt from ("+query+") q"
      println countQuery
      
      def totalRows = sql.firstRow(countQuery)?.cnt
      def numberOfPages = Math.ceil(totalRows / maxRows)
      
      sql.close()
      def ind,adrStr
      def jsonCells = []
      

	//code for excel export
	if(params.oper=="excel")
	 {
		response.contentType = 'application/zip'
		new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
			zipOutputStream.putNextEntry(new ZipEntry("CentralContacts.csv"))
			//header
			zipOutputStream << "IcsId,LegalName,InitiatedName,DoB,MarriageAnniversary,DonationAmount,Address,Phone,Email,Cultivator" 
			result.each{ row ->
            			ind = Individual.get(row.id)
				zipOutputStream << "\n"
				zipOutputStream <<   (ind.icsid?:'') +","+
					  row.legal_name +","+
					  (row.initiated_name?:'') +","+
					  (row.dob?:'')+ ","+
					  (row.marriage_anniversary?:'') +","+
					  (row.donation_amount?:'') +","+
					  Address.findAllByIndividual(ind)?.toString().tr('\n\r\t',' ').replaceAll(',',';') +","+
					  VoiceContact.findAllByIndividual(ind)?.toString().tr('\n\r\t',' ').replaceAll(',',';') +","+
					  EmailContact.findAllByIndividual(ind)?.toString().tr('\n\r\t',' ').replaceAll(',',';')
			}
		}    		
		return
	 }


      
      if(!params.address)
      	jsonCells = result.collect {
            ind = Individual.get(it.id)
            [cell: [it.legal_name,
                    it.initiated_name,
                    it.dob,
                    it.marriage_anniversary,
                    it.donation_amount,
                    //followupService.recentCultivation(ind)?.format('dd-MM-yyyy')?:'',
                    Address.findAllByIndividual(ind)?.toString(),
                    VoiceContact.findAllByIndividual(ind)?.toString(),
                    EmailContact.findAllByIndividual(ind)?.toString(),
                    it.cultivator
                ], id: it.id]
        }
      else
      	{
                    	//filter data as per locality
                    	result.each{itl->
                    		ind = Individual.get(itl.id)
				adrStr = Address.findAllByIndividual(ind)?.toString()
				if(adrStr.toLowerCase().contains(params.address.toLowerCase()))
					{
					jsonCells.add(
					    [cell: [itl.legal_name,
						    itl.initiated_name,
						    itl.dob,
						    itl.marriage_anniversary,
						    itl.donation_amount,
						    //followupService.recentCultivation(ind)?.format('dd-MM-yyyy')?:'',
						    adrStr,
						    VoiceContact.findAllByIndividual(ind)?.toString(),
						    EmailContact.findAllByIndividual(ind)?.toString(),
						    itl.cultivator
						], id: itl.id]
					)
					}
				}
      	}
        
        // logic is correct but it messes up the order
        //jsonCells = jsonCells.sort{a,b-> a['cell'][2].equals(b['cell'][2])? 0: Math.abs(a['cell'][2])<Math.abs(b['cell'][2])? -1: 1 }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }
    
	def jq_edit_individual = {
	      def individual = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add instruction sent
		  individual = new Individual(params)
		  individual.creator = springSecurityService.principal.username
		  individual.updator = individual.creator
		  individual.category = session.individualid
		  if (! individual.hasErrors() && individual.save()) {
		    message = "Individual ${individual.name} Added"
		    id = individual.id
		    state = "OK"
		  } else {
		    individual.errors.allErrors.each {
			println it
			}
		    message = "Could Not Save Individual"
		  }
		  break;
		case 'del':
		  // check individual exists
		  individual = Individual.get(params.id)
		  if (individual) {
		    // delete individual
		    individual.delete()
		    message = "Individual  ${individual.name} Deleted"
		    state = "OK"
		  }
		  break;
		 default :
		  // edit action
		  // first retrieve the individual by its ID
		  individual = Individual.get(params.id)
		  if (individual) {
		    // set the properties according to passed in parameters
		    individual.properties = params
			  individual.updator = springSecurityService.principal.username
		    if (! individual.hasErrors() && individual.save()) {
		      message = "Individual  ${individual.name} Updated"
		      id = individual.id
		      state = "OK"
		    } else {
			    individual.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Individual"
		    }
		  }
		  break;
 	 }

      def response = [message:message,state:state,id:id]

      render response as JSON
    }

// return JSON list of devotees
    def jq_devotee_list = {

      def now = new Date()

      def sortIndex = params.sidx ?: 'legalname'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
    	def result

      def sql = new Sql(dataSource);
      String query = ""

	      query = "select icv.id,icv.legalname,icv.initiatedname,icv.dob,icv.address,icv.number,icv.email,counsellor,guru from individual_contact_view icv left join individual_counsellor_view iclv on icv.id=iclv.id left join individual_guru_view igv on icv.id=igv.id"
	      //add conditions
	      
	      if(params.name || params.address || params.number || params.email || params.counsellor || params.guru || params.dobFlag)
	      	query += " where "
	      
	      def numCondns = 0
	      
	      if (params.legalname)
	      {
	      	query += " icv.legalname like '%"+params.legalname+"%'"
	      	numCondns++
	      }
	      
	      if (params.initiatedname)
	      {
	      	if(numCondns>0)
	      		query += " and icv.initiatedname like '%"+params.initiatedname+"%'"
	      	else
	      		query += " icv.initiatedname like '%"+params.initiatedname+"%'"
	      	numCondns++
	      }
	      
	      if (params.address)
	      {
	      	if(numCondns>0)
	      		query += " and icv.address like '%"+params.address+"%'"
	      	else
	      		query += " icv.address like '%"+params.address+"%'"
	      	numCondns++
	      }
	      
	      if (params.number)
	      {
	      	if(numCondns>0)
	      		query += " and icv.number like '%"+params.number+"%'"
	      	else
	      		query += " icv.number like '%"+params.number+"%'"
	      	numCondns++
	      }
	      
	      if (params.email)
	      {
	      	if(numCondns>0)
	      		query += " and icv.email like '%"+params.email+"%'"
	      	else
	      		query += " icv.email like '%"+params.email+"%'"
	      	numCondns++
	      }
	      
	      if (params.counsellor)
	      {
	      	if(numCondns>0)
	      		query += " and counsellor like '%"+params.counsellor+"%'"
	      	else
	      		query += " counsellor like '%"+params.counsellor+"%'"
	      	numCondns++
	      }
	      
	      if (params.guru)
	      {
	      	if(numCondns>0)
	      		query += " and guru like '%"+params.guru+"%'"
	      	else
	      		query += " guru like '%"+params.guru+"%'"
	      	numCondns++
	      }
	      
	      if(params.dobFlag)
	      {
	      	if(numCondns>0)
	      		query += " and (day(icv.dob) >= "+params.dayFrom+" AND month(icv.dob) >= "+(((now.month).toInteger()+(1*1).toInteger())*1)+") and (day(icv.dob) <= "+params.dayTo+" AND month(icv.dob) <= "+(((now.month).toInteger()+(1*1).toInteger())*1) +")" 
	      	else
	      		query += " (day(icv.dob) >= "+params.dayFrom+" AND month(icv.dob) >= "+(((now.month).toInteger()+(1*1).toInteger())*1)+") and (day(icv.dob) <= "+params.dayTo+" AND month(icv.dob) <= "+(((now.month).toInteger()+(1*1).toInteger())*1) +")" 
	      	numCondns++
		}


      //add sorting,ordering
      query += " order by "+sortIndex+" "+sortOrder
      
      println query
      result = sql.rows(query,rowOffset,maxRows)

	println 'result='+result
      String countQuery = "select count(1) cnt from ("+query+") q"
      println countQuery
      
      def totalRows = sql.firstRow(countQuery)?.cnt
      def numberOfPages = Math.ceil(totalRows / maxRows)
      
      sql.close()

      def jsonCells = result.collect {
            [cell: [
                    it.legalname,
                    it.initiatedname,
                    it.dob,
                    it.address,
                    it.number,
                    it.email,
                    it.counsellor,
                    it.guru
                ], id: it.id]
        }
        
        // logic is correct but it messes up the order
        //jsonCells = jsonCells.sort{a,b-> a['cell'][2].equals(b['cell'][2])? 0: Math.abs(a['cell'][2])<Math.abs(b['cell'][2])? -1: 1 }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }
    
    def ccList() {
    }

	def allCounsellorsAsJSON_JQ() {
		def query = params.term
		//def role = Role.findByName('Councellor')
		def c = IndividualRole.createCriteria()
		def result = c.list
			{
				eq("status", "VALID")
				role{
					eq("name",'Councellor')
				}
				individual{
					or {
					ilike("legalName", "%"+query+"%")
					ilike("initiatedName", "%"+query+"%")
					}
					or{
						isNull('status')
						and{
						ne('status','MERGED')
						ne('status','DELETED')
						}
					}	    		
					order("initiatedName", "asc")
					order("legalName", "asc")
				}
		}
		response.setHeader("Cache-Control", "no-store")
		
		def uniqueIndList = result.collect {it.individual}.unique()

		/*def results = result.collect {
			[
			   id: it.individual.id,
			   value: it.individual.toString(),
			   label: it.individual.toString() ]
		}*/

		def results = uniqueIndList.collect {
			[
			   id: it.id,
			   value: it.toString(),
			   label: it.toString() ]
		}

		render results as JSON
	}

	def jq_counsellor_list = {
		def sortIndex = params.sidx ?: 'initiatedName'
		def sortOrder  = params.sord ?: 'asc'
  
		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1
  
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
		def counsellorRole = Role.findByName('Councellor')
		def discipleRelation = Relation.findByName('Disciple of')
  
	  def result = IndividualRole.createCriteria().list(max:maxRows, offset:rowOffset) {  
				  eq('status','VALID')
				  eq('role',counsellorRole)
    
				  individual{
						  if (params.name) {
							  or{
								  ilike('legalName','%'+params.name + '%')
								  ilike('initiatedName','%'+params.name + '%')
								  
							  }
						  }
						/*//individualRoles		  
						if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAllGranted('ROLE_VOICE_ADMIN'))
							{
							log.debug("filteringby VOICE role")
							individualRoles{
								eq('status','VALID')
								role{eq('category','VOICE')}
							}
							}*/
					  order('initiatedName', sortOrder)
				  }
  
	  }
		
		def totalRows = result.totalCount
		def numberOfPages = Math.ceil(totalRows / maxRows)
  
		def jsonCells = result.collect {
			  [cell: [
					  it.individual.toString(),
					  Relationship.findWhere(relation:discipleRelation,individual1:it.individual,status:'ACTIVE')?.individual2?.sanyasName,
					  it.individual.voiceContact?.toString(),
					  it.individual.emailContact?.toString(),
					  it.individual.category
				  ], id: it.individual.id]
		  }
		  def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		  render jsonData as JSON
		  }
 
	def jq_counsellee_list = {
		def sortIndex = params.sidx ?: 'legalName'
		def sortOrder  = params.sord ?: 'asc'
  
		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1
  
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
  
	  def counsellor = null
	  if(params.counsellorid)
		  counsellor=Individual.get(params.counsellorid)
	  else if (org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAllGranted('ROLE_COUNSELLOR'))
	  	counsellor = Individual.get(session.individualid)
		  
	  def result = Relationship.createCriteria().list(max:maxRows, offset:rowOffset) {
		  eq('status','ACTIVE')
		  if(counsellor)
		  	eq('individual2',counsellor)
		  relation{
			switch(params.type)
			{
				case 'Counsellee':
					eq('name','Councellee of')
					break
				case 'Wellwisher':
					eq('name','Cultivated by')
					break
				default:
					or{
						eq('name','Councellee of')
						eq('name','Cultivated by')
					}
			}
		  }
		  individual1{
			or{
				isNull('status')
				eq('status','VALID')
				eq('status','ACTIVE')
			 }
			if (params.legalName)
				ilike('legalName',params.legalName+"%")
			if (params.initiatedName)
				ilike('initiatedName',params.initiatedName+"%")
			if (params.voiceContact){
				voiceContact{
					ilike('number',params.voiceContact)
				}
			}
			if (params.emailContact){
				emailContact{
					ilike('emailAddress',params.emailContact)
				}
			}
			if (params.address){
				address{
					ilike('addressLine1',"%"+params.address+"%")
				}
			}
			  order(sortIndex, sortOrder)
		  }
  
	  }
		
		def totalRows = result.totalCount
		def numberOfPages = Math.ceil(totalRows / maxRows)
  
		def jsonCells = result.collect {
			  [cell: [
					  it.individual1.legalName,
					  it.individual1.initiatedName,
					  it.individual1.dob?.format('dd-MM-yyyy'),
					  it.individual1.marriageAnniversary?.format('dd-MM-yyyy'),
					  it.individual1.voiceContact?.toString(),
					  it.individual1.emailContact?.toString(),
					  it.individual1.category,
					  it.individual1.address?.toString(),
					  it.relation.name
				  ], id: it.individual1.id]
		  }
		  def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		  render jsonData as JSON
		  }
  
  def mergeRecords() {
  	log.debug("Inside mergeRecords with params : "+params)
  	def retStr = housekeepingService.mergeRecords(params.idList)
  	render([message:retStr] as JSON) 
  }

  def changeRelation() {
  	log.debug("Inside changeRelation with params : "+params)
  	def retStr = housekeepingService.changeRelation(params)
  	render([message:retStr] as JSON) 
  }

	def jq_edit_cclist = {
	      log.debug('In jq_edit_cclist:'+params)
	      def individual = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add not supported
		  break;
		case 'del':
		  	def counsellor,rship
		  	if(SpringSecurityUtils.ifAllGranted('ROLE_COUNSELLOR'))
		  		counsellor = Individual.get(session.individualid)
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  individual  = Individual.get(it)
			  if(SpringSecurityUtils.ifAllGranted('ROLE_COUNSELLOR') && counsellor)
			  	{
			  		rship = Relationship.findWhere(individual1:individual,individual2:counsellor,status:'ACTIVE')
			  		if(rship)
			  			{
			  			rship.status='INVALID'
			  			rship.updator=springSecurityService.principal.username
			  			}
					    if(!rship.save())
						{
						    rship.errors.allErrors.each {
							log.debug("In jq_edit_cclist: error in soft deleting relationship:"+ it)
							}
						}

			  	}
			  else if (individual?.category!='NVCC') //todo:hard coding
			  {
			    // soft delete individual
			    individual.status='DELETED'
			    //TODO: remove the subtrees as well
			    if(!individual.save())
			    	{
				    individual.errors.allErrors.each {
					log.debug("In jq_edit_cclist: error in soft deleting individual:"+ it)
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
		 	break;
 	 	}

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

	def jq_full_list = {
		log.debug("Individual.jq_full_list : "+params);
		def sortIndex = params.sidx ?: 'legalName'
		def sortOrder  = params.sord ?: 'asc'
  
		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1
  
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
		def result,totalRows,numberOfPages,jsonCells,rows

		//@TODO: fuzzy search on multiple params to be supported
		if(params.fuzzy=="true")
			{
			if(params.legalName)
				result = Individual.search(params.legalName, [offset: rowOffset, max: maxRows,reload:true])
			else if(params.address)
				result = Address.search(params.address, [offset: rowOffset, max: maxRows,reload:true])
			else if(params.phone)
				result = VoiceContact.search(params.phone, [offset: rowOffset, max: maxRows,reload:true])
			else if(params.email)
				result = EmailContact.search(params.email, [offset: rowOffset, max: maxRows,reload:true])
				
			totalRows = (result?.total)?:0
			numberOfPages = Math.ceil(totalRows / maxRows)

			rows = result?.results
			}
		else
		{
	  		result = Individual.createCriteria().list(max:maxRows, offset:rowOffset) {  
				or{
					isNull('status')
					and{
					ne('status','MERGED')
					ne('status','DELETED')
					}
				}	    		
			if (params.icsid)
				eq('icsid',new Integer(params.icsid))
			if (params.legalName)
						or{
							ilike('legalName',params.legalName+'%')
							ilike('initiatedName',params.legalName+'%')
						}
			if (params.address)
				address{
					ilike('addressLine1',params.address + '%')
					}
			if (params.phone)
				voiceContact{
					ilike('number',params.phone + '%')
					}
			if (params.email)
				emailContact{
					ilike('emailAddress',params.email + '%')
					}
			if (params.relationship)
				{
				relative1{
					eq('status','ACTIVE')
					individual2{
						or{
							ilike('legalName',params.relationship + '%')
							ilike('initiatedName',params.relationship + '%')
						}
							
						}
					}
				}
			order(sortIndex, sortOrder)
				  }
		totalRows = result.totalCount
		numberOfPages = Math.ceil(totalRows / maxRows)
		rows = result
		}
		
		//we could try .findAll{it.status!='MERGED'}
		if(params.fuzzy=="true" && ((params.address || params.phone || params.email) && !params.legalName))
			{
			//for fuzzy search on addresses/phone/email
			jsonCells = rows.collect {
				  [cell: [
						  it.individual?.icsid,
						  it.individual?.legalName,
						  it.individual?.initiatedName,
						  it.individual?.dob?.format('dd-MM-yyyy'),
						  it.individual?.address?.toString(),
						  it.individual?.voiceContact?.toString(),
						  it.individual?.emailContact?.toString(),
						  it.individual?.relative1?.toString(),
						  it.individual?.status
					  ], id: it.individual.id]
			  }
			}
		else
			{
			jsonCells = rows.collect {
				  [cell: [
						  it?.icsid,
						  it?.legalName,
						  it?.initiatedName,
						  it?.dob?.format('dd-MM-yyyy'),
						  it?.address?.toString(),
						  it?.voiceContact?.toString(),
						  it?.emailContact?.toString(),
						  it?.relative1?.toString(),
						  it?.status
					  ], id: it?.id]
			  }
		  	}
		  def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		  render jsonData as JSON
		  }
 
	def jq_voicefull_list = {
		log.debug("Individual.jq_voicefull_list : "+params);
		def sortIndex = params.sidx ?: 'legalName'
		def sortOrder  = params.sord ?: 'asc'
  
		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1
  
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
		def result,totalRows,numberOfPages,jsonCells,rows

		result = Individual.createCriteria().listDistinct() {  
			or{
				isNull('status')
				and{
				ne('status','MERGED')
				ne('status','DELETED')
				}
			}	    		
			if (params.icsid)
				eq('icsid',new Integer(params.icsid))
			if (params.legalName)
						or{
							ilike('legalName',params.legalName+'%')
							ilike('initiatedName',params.legalName+'%')
						}
			if (params.address)
				address{
					ilike('addressLine1',params.address + '%')
					}
			if (params.phone)
				voiceContact{
					ilike('number',params.phone + '%')
					}
			if (params.email)
				emailContact{
					ilike('emailAddress',params.email + '%')
					}
			if (params.relationship)
				{
				relation{eq('name','Councellee of')}
				relative1{
					eq('status','ACTIVE')
					individual2{
						or{
							ilike('legalName',params.relationship + '%')
							ilike('initiatedName',params.relationship + '%')
						}

						}
					}
				}
			//individualRoles		  
			if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAllGranted('ROLE_VOICE_ADMIN'))
				{
				individualRoles{
					eq('status','VALID')
					role{eq('category','VOICE')}
				}
				}				
			order(sortIndex, sortOrder)
			  }
		totalRows = result.size()
		numberOfPages = Math.ceil(totalRows / maxRows)
		rows = result
		
		jsonCells = rows.collect {
			  [cell: [
					  it?.icsid,
					  it?.legalName,
					  it?.initiatedName,
					  it?.dob?.format('dd-MM-yyyy'),
					  it?.address?.toString(),
					  it?.voiceContact?.toString(),
					  it?.emailContact?.toString(),
					  it?.relative1?.toString(),
					  it?.individualRoles?.toString(),
					  it?.status
				  ], id: it?.id]
		  }
		  def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		  render jsonData as JSON
		  }

	def createprofile() {[type:params.type]}

    def contactDetails = {
	    if (request.xhr) {
		render(template: "contactDetails", model: [individualid:params.'individual.id'])
		//render "Hare Krishna!!"
		return
	    }
	   }
    def familyMembers = {
	    if (request.xhr) {
		render(template: "familyMembers", model: [individualid:params.'individual.id'])
		//render "Hare Krishna!!"
		return
	    }
	   }
    def kctDetails = {
    	    if (request.xhr) {
    		render(template: "kcTraining", model: [individualid:params.'individual.id'])
    		//render "Hare Krishna!!"
    		return
    	    }
    	   }

	
	def cleelist() {}
	
	def fuzzySearchResult() {
	
	}
    def jq_family_list = {
                            def sortIndex = params.sidx ?: 'id'
                            def sortOrder  = params.sord ?: 'asc'
                      
                            def maxRows = Integer.valueOf(params.rows)
                            def currentPage = Integer.valueOf(params.page) ?: 1
                      
                            def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
                      
	def result = Relationship.createCriteria().list(max:maxRows, offset:rowOffset) {
			eq('status','ACTIVE')
			relation{
				eq('category','FAMILY')
				}
			individual2{
				eq('id',new Long(params.'individual.id'))
				}
			if(sortIndex!='name')
				individual1{order(sortIndex, sortOrder)}
			if(sortIndex=='name')
				relation{order(sortIndex, sortOrder)}
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.individual1?.legalName,
            	    it.relation?.name
                ], id: it.individual1?.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
                              }
                      
                      	def jq_edit_family = {
                      	      log.debug('In jq_edit_family:'+params)
                      	      def ind = null
                      	      def message = ""
                      	      def state = "FAIL"
                      	      def id
                      	      def rship
                      
                      	      // determine our action
                      	      switch (params.oper) {
                      		case 'add':
                      		
                      		 //first create new ind
                      		 ind = new Individual()
                      		 ind.legalName = params.legalName
                      		 ind.initiatedName = params.initiatedName
                      		 ind.updator=ind.creator=springSecurityService.principal.username
                      		 if (ind.save())
                      		 {
                      		 	//now create family relationship
                      		 	params.'individual2.id'=params.'individual.id'
                      		 	rship = new Relationship(params)
                      		 	rship.individual1 = ind
                      		 	//rship.individual2 = Individual.get(session.individualid)
                      		 	rship.relationshipGroup = RelationshipGroup.findByGroupName('dummy')
                      		 	//rship.relation=Relation.get(params.'relation.id')
                      		 	rship.status='ACTIVE'
                      		 	rship.updator=rship.creator=springSecurityService.principal.username
                      		 	if (!rship.save())
                      		 		rship.errors.allErrors.each {log.debug(it)}
                      		 }
                      		 else
                      		 	{
                      		 	ind.errors.allErrors.each {log.debug(it)}
                      		   	 message = "Could Not Save Individual"
                      		  	}
                      		  break;
                      		case 'del':
                      		  	def idList = params.id.tokenize(',')
                      		  	idList.each
                      		  	{
                      			  
                      			  address  = Address.get(it)
                      			  if (address) {
                      			    
                      			    if(!address.delete())
                      			    	{
                      				    address.errors.allErrors.each {
                      					log.debug("In jq_address_edit: error in deleting address:"+ it)
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
                      		  
                      		  address = Address.get(params.id)
                      		  if (address) {
                      		    // set the properties according to passed in parameters
                      		    address.properties = params
                      			  
                      		    if (!address.hasErrors() && address.save()) {
                      		      message = "Address  ${address.category} Updated"
                      		      id = address.id
                      		      state = "OK"
                      		    } else {
                      			    address.errors.allErrors.each {
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

	def info() {
		def ind = Individual.findByIcsid(params.icsid)
		def addr,contact,email,counsellor,counsellorid,counsellorName
		if(ind)
			{
			addr = Address.findByCategoryAndIndividual('Correspondence',ind)
			contact = VoiceContact.findByCategoryAndIndividual('CellPhone',ind)
			email = EmailContact.findByCategoryAndIndividual('Personal',ind)
			//clor
			if(ind.category=='JivaDayaDistributor') {
				counsellorid = ind.nvccId
				counsellorName = ind.nvccIskconRef				
			}
			else {
				def counsellorReln = Relation.findByName('Councellee of')
				def clorRship = Relationship.findWhere(individual1:ind,relation:counsellorReln,status:'ACTIVE')
				counsellor = clorRship?.individual2
				counsellorid = counsellor?.id
				counsellorName = counsellor?.toString()
				}
			}
		render([valid:ind?"yes":"no",name:ind?.toString(),id:ind?.id,address:(addr?.addressLine1?:"")+" "+(addr?.addressLine2?:"")+" "+(addr?.addressLine3?:""),city: addr?.city?.toString(), state: addr?.state?.toString(), country: addr?.country?.toString(), pin: addr?.pincode, contact:contact?.number,email:email?.emailAddress,pan:ind?.panNo,addrid:addr?.id,contactid:contact?.id,emailid:email?.id,counsellorid:counsellorid,counsellorName:counsellorName] as JSON)
	}
	
	def donationSummary() {
		def summaryDonation = housekeepingService.donationSummary(params.id)
		render([name:Individual.get(params.id)?.toString(),summaryDonation: summaryDonation, schemewise: summaryDonation?.sList?.toString()] as JSON)
	}
	
	def profileSummary() {
		def profileSummary = individualService.profileSummary(params.id)
		render([name:Individual.get(params.id)?.toString(),profileSummary: profileSummary] as JSON)
	}
	
	def donorList() {
	}

	def jq_donor_list = {
		log.debug("Individual.jq_donor_list : "+params);
		if(params.dob_dd?.size()==1)
			params.dob_dd = "0"+params.dob_dd
		if(params.dob_mm?.size()==1)
			params.dob_mm = "0"+params.dob_mm
		if(params.dom_dd?.size()==1)
			params.dom_dd = "0"+params.dom_dd
		if(params.dom_mm?.size()==1)
			params.dom_mm = "0"+params.dom_mm

		def sortIndex = params.sidx ?: 'legalName'
		def sortOrder  = params.sord ?: 'asc'
  
		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1
  
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
		if(params.oper=="excel" )
			{
				maxRows = 100000
				rowOffset = 0
			}
		
		def result,totalRows,numberOfPages,jsonCells,rows
		
		//for dob, marriage anniversary filters
		def now = new Date()
		def today = now.format('dd')
		def currMonth = now.format('MM')
		def currWeek = now.format('w')
		def nextWeek = new Integer(currWeek) + 1
		def yesterday = (now-1).format('dd')
		def yesterMonth = (now-1).format('MM')
		def tomorrow = (now+1).format('dd')
		def tomMonth = (now+1).format('MM')
		def dobCon, domCon
		
		def summaryDonation
		def amtInd, amtFam, amtColExclOwn, amtGiftInd, amtGiftFam	
		
	  		result = Individual.createCriteria().list(max:maxRows, offset:rowOffset) {  
			or{
				isNull('status')
				and{
				ne('status','MERGED')
				ne('status','NODATE')
				ne('status','DELETED')
				}
			}
			if (params.icsid)
				eq('icsid',new Integer(params.icsid))
			if (params.legalName)
						or{
							ilike('legalName','%'+params.legalName+'%')
							ilike('initiatedName','%'+params.legalName+'%')
						}
			if (params.address)
				address{
					ilike('addressLine1','%'+params.address + '%')
					}
			if (params.phone)
				voiceContact{
					ilike('number','%'+params.phone + '%')
					}
			if (params.email)
				emailContact{
					ilike('emailAddress','%'+params.email + '%')
					}
			if (params.relationship)
				relative1{
					eq('status','ACTIVE')
					individual2{
						or{
							ilike('legalName','%'+params.relationship + '%')
							ilike('initiatedName','%'+params.relationship + '%')
						}
							
						}
					}
			if(params.dobRadioGroup)
				{
				switch(params.dobRadioGroup) {
					case '-1':
						dobCon = "date_format(dob,'%d-%m') = '"+yesterday+'-'+yesterMonth+"'"
						break
					case '0':
						dobCon = "date_format(dob,'%d-%m') = '"+today+'-'+currMonth+"'"
						break
					case '1':
						dobCon = "date_format(dob,'%d-%m') = '"+tomorrow+'-'+tomMonth+"'"
						break
					case '2':
						dobCon = "date_format(dob,'%u') = '"+currWeek+"'"
						break
					case '3':
						dobCon = "date_format(dob,'%u') = '"+nextWeek+"'"
						break
					case '4':
						dobCon = "date_format(dob,'%m') = '"+currMonth+"'"
						break
					case '99':
						dobCon = "date_format(dob,'%m') = '"+params.month+"'"
						break
					default:
						break
					}
				log.debug(dobCon)
				sqlRestriction dobCon
				}
			else if(params.dob_dd)
				{
				dobCon = "date_format(dob,'%d-%m') = '"+params.dob_dd+'-'+params.dob_mm+"'"
				log.debug(dobCon)
				sqlRestriction dobCon				
				}

			if(params.domRadioGroup)
				{
				switch(params.domRadioGroup) {
					case '-1':
						domCon = "date_format(marriage_anniversary,'%d-%m') = '"+yesterday+'-'+yesterMonth+"'"
						break
					case '0':
						domCon = "date_format(marriage_anniversary,'%d-%m') = '"+today+'-'+currMonth+"'"
						break
					case '1':
						domCon = "date_format(marriage_anniversary,'%d-%m') = '"+tomorrow+'-'+tomMonth+"'"
						break
					case '2':
						domCon = "date_format(marriage_anniversary,'%u') = '"+currWeek+"'"
						break
					case '3':
						domCon = "date_format(marriage_anniversary,'%u') = '"+nextWeek+"'"
						break
					case '4':
						domCon = "date_format(marriage_anniversary,'%m') = '"+currMonth+"'"
						break
					case '99':
						domCon = "date_format(marriage_anniversary,'%m') = '"+params.month+"'"
						break
					default:
						break
					}
				log.debug(domCon)
				sqlRestriction domCon
				}
			else if(params.dom_dd)
				{
				domCon = "date_format(marriage_anniversary,'%d-%m') = '"+params.dom_dd+'-'+params.dom_mm+"'"
				log.debug(domCon)
				sqlRestriction domCon				
				}

			order(sortIndex, sortOrder)
				  }
		def flags
		totalRows = result.totalCount
		numberOfPages = Math.ceil(totalRows / maxRows)
		rows = result
		def sAmt, tAmt
		def minAmt,maxAmt
		if(params.minAmount)
			minAmt = new Long(params.minAmount)
		else
			minAmt = 0
		if(params.maxAmount)
			maxAmt = new Long(params.maxAmount)
		else
			maxAmt = 999999999
		
		def corrAddr, cellPhone, personalEmail
		
		if(params.oper=="excel")
		 {
			response.contentType = 'application/zip'
			new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
				zipOutputStream.putNextEntry(new ZipEntry("DonorList.csv"))
				//header
				zipOutputStream << "icsid,legal_name,initiated_name,dob,dom,address,city,state,country,pin,phone,email,individualDonation,familyDonation,relations,isDevotee,dqstatus,phoneOK,emailOK,addressOK,status" 
				
				rows.each{ row ->
					//get the relevant field values only
					corrAddr = Address.findByIndividualAndCategory(row,'Correspondence')
					cellPhone = VoiceContact.findByIndividualAndCategory(row,'CellPhone')
					personalEmail = EmailContact.findByIndividualAndCategory(row,'Personal')
						
					flags = Flags.findByIndividualid(row.id)
					summaryDonation = housekeepingService.onlyDonationSummary(row.id)
					zipOutputStream << "\n"
					zipOutputStream <<   row.icsid +","+
						  row.legalName +","+
						  row.initiatedName +","+
						  row.dob?.format('dd-MM-yyyy') +","+
						  row.marriageAnniversary?.format('dd-MM-yyyy') +","+
						  (corrAddr?.addressLine1?:""+corrAddr?.addressLine2?:""+corrAddr?.addressLine3?:"")?.replaceAll(~'[,\n\t\r]','\t') +","+corrAddr?.city?.name?.replaceAll(~'[,\n\t\r]','\t') +","+corrAddr?.state?.name?.replaceAll(~'[,\n\t\r]','\t') +","+corrAddr?.country?.name?.replaceAll(~'[,\n\t\r]','\t') +","+corrAddr?.pincode?.replaceAll(~'[,\n\t\r]','\t') +","+
						  cellPhone?.number?.replaceAll(',',';') +","+
						  personalEmail?.emailAddress?.replaceAll(',',';') +","+
						  summaryDonation?.amtInd +","+
						  summaryDonation?.amtFam +","+
						  row.relative1?.toString()?.replaceAll(',',';') +","+
						  helperService.isDevotee(row.id) +","+
						  flags?.formstatus +","+
						  (flags?(flags?.mobileNo?'true':'false'):'') +","+
						  (flags?(flags?.email?'true':'false'):'') +","+
						  (flags?(flags?.address?'true':'false'):'') +","+						  
						  row.status
				}
			}    		
			return
		 }
		else
		{
			jsonCells = rows.collect {
				  //get the flags record if any
				  flags = Flags.findByIndividualid(it.id)
				  summaryDonation = housekeepingService.onlyDonationSummary(it.id)
						  [cell: [
								  it.icsid,
								  it.legalName,
								  it.initiatedName,
								  it.dob?.format('dd-MM-yyyy'),
								  it.marriageAnniversary?.format('dd-MM-yyyy'),
								  it.address?.toString(),
								  it.voiceContact?.toString(),
								  it.emailContact?.toString(),
								  summaryDonation?.amtInd,
								  summaryDonation?.amtFam,
								  it.relative1?.toString(),
								  helperService.isDevotee(it.id),
								  flags?.formstatus,
								  flags?(flags.mobileNo?'true':'false'):'',
								  flags?(flags.email?'true':'false'):'',
								  flags?(flags.address?'true':'false'):'',						  
								  it.status
							  ], id: it.id]
			  }
			  
			  def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
			  render jsonData as JSON
		  }
		  }
	
	def allCentresAsJSON_JQ() {
		def query = params.term
		def c = Centre.createCriteria()
		def result = c.list
			{
				ilike("name", query+"%")
				order("name", "asc")
			}
		response.setHeader("Cache-Control", "no-store")

		def results = result.collect {
			[
			   id: it.id,
			   value: it.name,
			   label: it.name ]
		}

		render results as JSON
	}

	def allvoiceCounsellorsAsJSON_JQ() {
		def query = params.term
		def c = Individual.createCriteria()
		def result = c.listDistinct
			{
				or {
				ilike("legalName", "%"+query+"%")
				ilike("initiatedName", "%"+query+"%")
				}
				or{
					isNull('status')
					and{
					ne('status','MERGED')
					ne('status','DELETED')
					}
				individualRoles{
					eq('status','VALID')
					role{eq('category','VOICE') ilike('name','%counsel%')}
				}
					order("initiatedName", "asc")
					order("legalName", "asc")
				}
		}
		response.setHeader("Cache-Control", "no-store")

		def results = result.collect {
			[
			   id: it.id,
			   value: it.toString(),
			   label: it.toString() ]
		}

		render results as JSON
	}
	
	def cleeReport() {
		def reportData = reportService.donationReport(session.individualid)
		[reportData:reportData]
	}
	
	def bulkCreateFromPerson() {
		def result = individualService.bulkCreateFromPerson(params)
		render result
		return
	}

   def family = {
 		render(template: "family", model: [individualInstance : Individual.get(params.id)])
 		return
    } 
    
    def professionalInfo = {
		render(template: "professionalInformation", model: [individualInstance : Individual.get(params.id)])
		return
    }  
    
    def languages = {
    		render(template: "languages", model: [individualInstance : Individual.get(params.id)])
    		return
    } 
    
    def communicationPreferences = {
        	render(template: "communicationPreferences", model: [individualInstance : Individual.get(params.id)])
        	return
    } 
    
    def spiritualInformation = {
            	render(template: "spiritualInformation", model: [individualInstance : Individual.get(params.id)])
            	return
    } 
   
   def lifeMember = {
            	render(template: "lifeMember", model: [individualInstance : Individual.get(params.id)])
            	return
    } 
    
   def  fundsCollected = {
            	render(template: "fundsCollected", model: [individualInstance : Individual.get(params.id)])
            	return
    } 
    
   def  fundsReceived = {
               	render(template: "fundsReceived", model: [individualInstance : Individual.get(params.id)])
               	return
    }
    
   def  nvccFields = {
                render(template: "nvccFields", model: [individualInstance : Individual.get(params.id)])
                return
    } 
    
    def  kcTraining = {
                render(template: "indkcTraining", model: [individualInstance : Individual.get(params.id)])
                return
    }
    
    def  kcRoles = {
                render(template: "kcRoles", model: [individualInstance : Individual.get(params.id)])
                return
    }
   
    def  services = {
                render(template: "services", model: [individualInstance : Individual.get(params.id)])
                return
    }

     def donationsList = {
             
         render(template: "donationsList", model: [individualInstance : Individual.get(params.id)])
         return
       }

    def  showDonationSummary = {
	//get summary donation
	def summaryDonation
	def summaryDonationRecord
	def individualInstance

	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_ADMIN,ROLE_DUMMY,ROLE_BACKOFFICE,ROLE_NVCC_ADMIN,ROLE_COUNSELLOR,ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
		{
		individualInstance = Individual.get(params.id)
		try {
			summaryDonation = housekeepingService.donationSummary(params.id)
			summaryDonationRecord = housekeepingService.donationRecordSummary(params.id)
			}
		catch(e)
			{log.debug("Exception is summarydonation for :"+params.id+e.printStackTrace())
			throw e}
		}
	render(template: "donationSummary", model: [individualInstance : individualInstance, amtInd:summaryDonation?.amtInd,amtIndDR:summaryDonationRecord?.amtIndDR, amtFam: summaryDonation?.amtFam, amtCol:summaryDonation?.amtCol, sList: summaryDonation?.sList, sListDR: summaryDonationRecord?.sListDR, amtColExclOwn: summaryDonation?.amtColExclOwn, amtGiftInd :summaryDonation?.amtGiftInd , amtGiftFam: summaryDonation?.amtGiftFam, amtBCInd: summaryDonation?.amtBCInd, amtBCFam: summaryDonation?.amtBCFam])
	return
    }
    
    def downloadCongregationData() {
    	response.contentType = 'application/zip'
    	def query = "select r.id rid,i2.id clorid,i2.initiated_name clor,i1.id cleeid,i1.legal_name cleeLegalName,ifnull(i1.initiated_name,'') cleeInitiatedName,rln.name relation from relationship r, individual i1, individual i2,relation rln where r.status='ACTIVE' and r.relation_id=rln.id and rln.name in ('Cultivated by','Councellee of') and r.individual1_id=i1.id and r.individual2_id=i2.id and r.individual2_id in (select distinct individual_id from individual_role where status='VALID' and role_id in (select id from role where name in ('PuneEnglishCouncellors','PuneHindiCouncellors')))"
    	def sql = new Sql(dataSource)
    	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		def fileName = "congregation_"+new Date().format('ddMMyyyyHHmmss')+".csv"
		zipOutputStream.putNextEntry(new ZipEntry(fileName))
		//header
		def headers = null;

		sql.rows(query).each{ row ->
			   if (headers == null) {
				headers = row.keySet()
				zipOutputStream << headers
			        zipOutputStream << "\n"
			   }
			//with escaping for excel
			zipOutputStream << row.values().collect{it.toString()}
			zipOutputStream << "\n"
		}
	}    	    	
    }


}