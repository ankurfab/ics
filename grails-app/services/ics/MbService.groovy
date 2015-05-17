package ics
import com.krishna.*
import groovy.sql.Sql;
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import java.text.SimpleDateFormat

class MbService {

    def individualService
    def housekeepingService
    def helperService
    def springSecurityService
    def commsService
    def dataSource
    
    def serviceMethod() {

    }
    
    def initiateProfile(Map params) {
    	//1. create the individual,assign same centre as logged in user
    	//2. create mb profile
    	//3. generate login-id
    	//4. send sms/email to candidate
    	
    	//step 1
    	//@TODO: need to prevent duplicates
    	params.category = "MB"
    	def candidate = individualService.createIndividual(params)
    	if(!candidate)
    		return -1	//cant create individual
    	
    	//step 2
    	def mbProfile = new MbProfile()
    	mbProfile.candidate = candidate
        mbProfile.candCounsellor=params.refClor
        mbProfile.referrer=params.refName
        mbProfile.referrerCenter=params.refCentre
        mbProfile.referrerContact=params.refContact
        mbProfile.referrerEmail=params.refEmail
        mbProfile.referrerRelation=params.refReln
    	mbProfile.initiatedBy = Individual.findByLoginid(springSecurityService.principal.username)
    	mbProfile.profileStatus = 'STARTED'
    	mbProfile.updator = mbProfile.creator = springSecurityService.principal.username
	if(!mbProfile.save())
		{
		mbProfile.errors.allErrors.each {println it}
		return -1	//cant create mb profile
		}
    	
    	//step 3
    	//first assign candidate role
    	def indRole = new IndividualRole()
    	indRole.individual = candidate
    	indRole.role = Role.findByCategoryAndName('MB','ROLE_MB_CANDIDATE')
    	indRole.updator = indRole.creator = springSecurityService.principal.username
    	indRole.status = 'VALID'
	if(!indRole.save())
		{
		indRole.errors.allErrors.each {println it}
		return -2	//cant create ind role
		}

	//now create loginid
	def ir = IcsRole.findByAuthority(indRole.role?.authority)
	def loginid = housekeepingService.createLogin(candidate,ir)
	
    	//step 4
		if(params.donorContact)
			housekeepingService.sendSMS(params.donorContact,"Hare Krishna! Your registration for MB Profile creation is successful. Please login with "+loginid+" and complete the profile. ISKCON(MB).")
		if(params.donorEmail)
		{
			//replace ; in email by ,
			def emailStr = params.donorEmail.replaceAll(';',',')
			List mailIds = []
			mailIds = emailStr.split(",")
			/*def aList = []
			mailIds?.collect{aList.add(it)}*/
			housekeepingService.sendEmail(mailIds,"Login created by ISKCON Marriage Board!","Hare Krishna! Your registration for MB Profile creation is successful. Please login with "+loginid+" and complete the profile. ISKCON(MB).")
		}
		
	//comms
	    def contentParams = [loginid]
	    commsService.sendComms('MarriageBoard', "PROFILE_STARTED", mbProfile.candidate?.toString(), params.donorContact, params.donorEmail, contentParams)
	

    	
    	return mbProfile?.id
    }

    def updateProfile(Map params) {
    	//first get the MbProfile
    	def mbProfile = MbProfile.get(params.id)
    	if(!mbProfile)
    		return -1	//MbProfile not found
    	//now update the fields step1
	try{         mbProfile.candidate.legalName=params.legalName } catch(Exception e){}
	try{         
		if(params.initiatedName && (params.initiatedName.size()<8))
			mbProfile.candidate.initiatedName=params.initiatedName
	} catch(Exception e){}
	try{         mbProfile.candidate.isMale=(params.isMale=='MALE') } catch(Exception e){}
	try{         mbProfile.candidate.dob = new Date().parse('d/M/yyyy H:m:s',params.dob+" "+params.tob) } catch(Exception e){}
	try{         mbProfile.candidate.pob=params.pob } catch(Exception e){}
	try{         mbProfile.candidate.iskconCentre=params.iskconCentre } catch(Exception e){}
	try{         mbProfile.candCounsellor=params.counselor } catch(Exception e){}
	try{         mbProfile.candCounsellorAshram=params.counselorAshram } catch(Exception e){}
	try{         mbProfile.candidate.nationality=params.nationality } catch(Exception e){}
	try{         mbProfile.candidate.origin=params.originState } catch(Exception e){}
    try{         mbProfile.culturalInfluence=params.culturalInfluence } catch(Exception e){}
	try{         mbProfile.candidate.varna=params.varna } catch(Exception e){}
	try{         mbProfile.scstCategory=params.scstCategory } catch(Exception e){}
	try{         mbProfile.candidate.caste=params.caste } catch(Exception e){}
	try{         mbProfile.candidate.subCaste=params.subCaste } catch(Exception e){}
	try{         mbProfile.candidate.height=(Integer.parseInt(params.heightInFt)*12) + Integer.parseInt(params.heightInInch) } catch(Exception e){}
    try{         mbProfile.weight=Integer.parseInt(params.weight) } catch(Exception e){}
    try{         mbProfile.candidate.motherTongue=params.motherTongue } catch(Exception e){}
    try{         mbProfile.languagesKnown=org.springframework.util.StringUtils.arrayToCommaDelimitedString(params.languagesKnown)} catch(Exception e){}
	try{         mbProfile.candidate.income=params.candidateIncome //change the type of the column in db
	} catch(Exception e){}
	try{         mbProfile.horoscopeToBeMatched=params.horoscopeToBeMatched } catch(Exception e){}
	try{         mbProfile.manglik=params.manglik } catch(Exception e){}
	try{
		if(params.addrline1) {
			def candAddr = Address.findByIndividualAndCategory(mbProfile.candidate,'PresentAddress')
			if(!candAddr) {
			    mbProfile.candidate.address.add(helperService.createAddress([individual: mbProfile.candidate, category: 'PresentAddress', addressLine1: params.addrline1, addressLine2: '', addressLine3: '', 'cityname': params.city, 'statename': params.state, pincode: params.pincode]))
			}
			else
			    helperService.updateAddress([id:candAddr?.id,individual:mbProfile.candidate,category:'PresentAddress',addressLine1:params.addrline1,addressLine2:'',addressLine3:'','cityname':params.city,'statename':params.state,pincode:params.pincode])
		}
         } catch(Exception e){}
        mbProfile.referrer=params.references
        def contactno = VoiceContact.findByIndividual(mbProfile.candidate)
        contactno?.number = params.contact
        contactno?.save()
        def emailadd= EmailContact.findByIndividual(mbProfile.candidate)
        emailadd?.emailAddress=params.email
        emailadd?.save()
    try{        mbProfile.maritalStatus = params.maritalStatus} catch(Exception e){}
    try{        mbProfile.personalInfo = params.personalInfo} catch(Exception e){}
    try{        mbProfile.residenceType = params.residenceType} catch(Exception e){}
        //step 2
        mbProfile.nativePlace=params.nativePlace
        mbProfile.nativeState=params.nativeState

	if(params.famaddrline1) {
		if(!mbProfile.familyAddress)
		    mbProfile.familyAddress = helperService.createAddress([individual:mbProfile.candidate,category:'FamilyAddress',addressLine1:params.famaddrline1,addressLine2:'',addressLine3:'','cityname':params.permcity,'statename':params.familystate,pincode:params.permpincode])
		else
		    helperService.updateAddress([id:mbProfile.familyAddress.id,individual:mbProfile.candidate,category:'FamilyAddress',addressLine1:params.famaddrline1,addressLine2:'',addressLine3:'','cityname':params.permcity,'statename':params.familystate,pincode:params.permpincode])
        }

	try{         mbProfile.houseIs = params.houseIs } catch(Exception e){}
	try{         mbProfile.houseArea = Integer.parseInt(params.houseArea) } catch(Exception e){}
	try{         mbProfile.otherProperty = params.otherProperty } catch(Exception e){}
	try{         mbProfile.fatherIncome = params.fatherIncome } catch(Exception e){}
	try{         mbProfile.otherIncome = params.otherIncome } catch(Exception e){}

                 processFamilyDetails(mbProfile.candidate,params)

    try{         mbProfile.noFamilyMembers = Integer.parseInt(params.noFamilyMembers) } catch(Exception e){}
    try{         mbProfile.otherFamilyMember = params.otherFamilyMember } catch(Exception e){}
	try{         mbProfile.parentsInfo = params.parentsInfo } catch(Exception e){}
	try{         mbProfile.parentsChanting = params.parentsChanting } catch(Exception e){}
	try{         mbProfile.parentsInitiation = params.parentsInitiation } catch(Exception e){}
	try{         mbProfile.parentsSpMaster = org.springframework.util.StringUtils.arrayToCommaDelimitedString(params.parentsSpMaster)} catch(Exception e){}
	try{         mbProfile.yourFamily = params.youFamily } catch(Exception e){}

        //step3
	try{         mbProfile.eduCat = params.eduCat } catch(Exception e){}
	try{         mbProfile.eduQual = params.eduQual } catch(Exception e){}
	try{         mbProfile.occupationStatus = params.occupationStatus } catch(Exception e){}
	try{         mbProfile.companyName = params.companyName } catch(Exception e){}
	try{         mbProfile.designation = params.designation } catch(Exception e){}

	if(params.compAddrLine1) {
		if(!mbProfile.companyAddress)
		    mbProfile.companyAddress = helperService.createAddress([individual:mbProfile.candidate,category:'CompanyAddress',addressLine1:params.compAddrLine1,addressLine2:'',addressLine3:'','cityname':params.compCity,'statename':params.compState,pincode:params.compPin])
		else
		    helperService.updateAddress([id:mbProfile.companyAddress.id,individual:mbProfile.candidate,category:'CompanyAddress',addressLine1:params.compAddrLine1,addressLine2:'',addressLine3:'','cityname':params.compCity,'statename':params.compState,pincode:params.compPin])
        }

        //step4
	try{         mbProfile.introductionYear = getYearFromDate(params.introductionYear) } catch(Exception e){}
	try{         mbProfile.introductionCentre = params.introductionCentre } catch(Exception e){}
	try{         mbProfile.currentlyVisiting = params.currentlyVisiting } catch(Exception e){}
	try{         mbProfile.regularSince = getYearFromDate(params.regularSince) } catch(Exception e){}
	try{         mbProfile.frequencyOfTempleVisits = params.frequencyOfTempleVisits } catch(Exception e){}
	try{         mbProfile.likesInKc = params.likesInKc } catch(Exception e){}
	try{         mbProfile.dislikesInKc = params.dislikesInKc } catch(Exception e){}
	try{         mbProfile.teacoffee = (params.teacoffee=='Yes') } catch(Exception e){}
	try{         mbProfile.oniongarlic = (params.oniongarlic=='Yes') } catch(Exception e){}
	try{         mbProfile.nonveg = (params.nonveg=='Yes') } catch(Exception e){}
	try{         mbProfile.intoxication = (params.intoxication=='Yes') } catch(Exception e){}
	try{         mbProfile.gambling = (params.gambling=='Yes') } catch(Exception e){}
	try{         mbProfile.regDetails = params.regDetails } catch(Exception e){}
	try{         mbProfile.regulated = (params.regulated=='Yes') } catch(Exception e){}
	try{         mbProfile.regulatedSince = getYearFromDate(params.regulatedSince) } catch(Exception e){}
	try{         mbProfile.chantingSince = getYearFromDate(params.chantingSince) } catch(Exception e){}
	try{         mbProfile.chantingSixteenSince = getYearFromDate(params.chantingSixteenSince) } catch(Exception e){}
	try{         mbProfile.numberOfRounds=Integer.parseInt(params.numberOfRounds) } catch(Exception e){}
	try{         mbProfile.spiritualMaster = params.spiritualMaster } catch(Exception e){}
	try{         mbProfile.firstInitiation = new Date().parse('d/M/yyyy',params.firstInitiation) } catch(Exception e){}
	try{         mbProfile.secondInitiation = new Date().parse('d/M/yyyy',params.secondInitiation) } catch(Exception e){}
	try{         mbProfile.services = params.services } catch(Exception e){}
	try{         mbProfile.interests = params.interests } catch(Exception e){}
	try{         mbProfile.remarks = params.remarks } catch(Exception e){}
        //step 5
	try{         mbProfile.devotionalCulture=params.devotionalCulture } catch(Exception e){}
	try{         mbProfile.flexibleChanting = Boolean.valueOf(params.flexibleChanting) } catch(Exception e){}
	try{         mbProfile.flexibleSpMaster = Boolean.valueOf(params.flexibleSpMaster) } catch(Exception e){}
	try{         mbProfile.flexibleCentre = Boolean.valueOf(params.flexibleCentre) } catch(Exception e){}
	try{         mbProfile.flexibleNationality = Boolean.valueOf(params.flexibleNationality) } catch(Exception e){}
	try{         mbProfile.flexibleCulturalInfluence = Boolean.valueOf(params.flexibleCulturalInfluence) } catch(Exception e){}
	try{         mbProfile.flexibleVarna = Boolean.valueOf(params.flexibleVarna) } catch(Exception e){}
	try{         mbProfile.flexibleCategory = Boolean.valueOf(params.flexibleCategory) } catch(Exception e){}
	try{         mbProfile.flexibleCaste = Boolean.valueOf(params.flexibleCaste) } catch(Exception e){}
	try{         mbProfile.flexibleSubcaste = Boolean.valueOf(params.flexibleSubcaste) } catch(Exception e){}
	try{         mbProfile.flexibleEducationCat = Boolean.valueOf(params.flexibleEducationCat) } catch(Exception e){}
	try{         mbProfile.flexibleQualifications = Boolean.valueOf(params.flexibleQualifications) } catch(Exception e){}
	try{         mbProfile.flexibleAgediff = Boolean.valueOf(params.flexibleAgediff) } catch(Exception e){}
	try{         mbProfile.flexibleHeight = Boolean.valueOf(params.flexibleHeight) } catch(Exception e){}
	try{         mbProfile.flexibleLooks = Boolean.valueOf(params.flexibleLooks) } catch(Exception e){}
	try{         mbProfile.flexibleCandidateIncome = Boolean.valueOf(params.flexibleCandidateIncome) } catch(Exception e){}
	try{         mbProfile.flexibleLangknown = Boolean.valueOf(params.flexibleLangknown) } catch(Exception e){}
	try{         mbProfile.flexibleManglik = Boolean.valueOf(params.flexibleManglik) } catch(Exception e){}
	try{         mbProfile.settleAbroadWorkingWife = params.settleAbroadWorkingWife } catch(Exception e){}
	try{         mbProfile.prefChanting=params.prefChanting } catch(Exception e){}
	try{         mbProfile.prefSpMaster=org.springframework.util.StringUtils.arrayToCommaDelimitedString(params.prefSpMaster)} catch(Exception e){}
	try{         mbProfile.prefCentre=params.prefCentre } catch(Exception e){}
	try{         mbProfile.prefNationality=params.prefNationality } catch(Exception e){}
	try{         mbProfile.prefCulturalInfluence=org.springframework.util.StringUtils.arrayToCommaDelimitedString(params.prefCulturalInfluence) } catch(Exception e){}
	try{         mbProfile.prefVarna=org.springframework.util.StringUtils.arrayToCommaDelimitedString(params.prefVarna) } catch(Exception e){}
	try{         mbProfile.prefCategory=org.springframework.util.StringUtils.arrayToCommaDelimitedString(params.prefCategory) } catch(Exception e){}
	try{         mbProfile.prefCaste=params.prefCaste } catch(Exception e){}
	try{         mbProfile.prefsubCaste=params.prefsubCaste } catch(Exception e){}
	try{         mbProfile.prefeducationCategory=params.prefeducationCategory } catch(Exception e){}
	try{         mbProfile.prefqualification=params.prefqualification } catch(Exception e){}
	try{         mbProfile.prefAgeDiff=params.prefAgeDiff } catch(Exception e){}
	try{         mbProfile.prefHeight=getHeight(params.prefHeight.split(" - ")[0]) + " - " + getHeight(params.prefHeight.split(" - ")[1])} catch(Exception e){}
	try{         mbProfile.prefLooks=params.prefLooks } catch(Exception e){}
	try{         mbProfile.prefCandIncome=params.prefCandIncome } catch(Exception e){}
	try{         mbProfile.prefLangKnown=org.springframework.util.StringUtils.arrayToCommaDelimitedString(params.prefLangKnown) } catch(Exception e){}
	try{         mbProfile.prefManglik=org.springframework.util.StringUtils.arrayToCommaDelimitedString(params.prefManglik) } catch(Exception e){}
    try{         mbProfile.otherExpectations=params.otherExpectations } catch(Exception e){}

        //step 6
	try{         mbProfile.keenDevProfile=params.keenDevprofile } catch(Exception e){}
	try{         mbProfile.primdepMB=params.primdepMB } catch(Exception e){}
	try{         mbProfile.regotherMB=params.regotherMB } catch(Exception e){}
	try{         mbProfile.parentsSearch=params.parentsSearch } catch(Exception e){}
	try{         mbProfile.profileoutsideISKCON=params.profileoutsideISKCON } catch(Exception e){}
	try{         mbProfile.financialDiff=params.financialDiff } catch(Exception e){}
	try{         mbProfile.physicalMental=params.physicalMental } catch(Exception e){}
	try{         mbProfile.depLifelong=params.depLifelong } catch(Exception e){}


        mbProfile.updator = springSecurityService.principal.username
        /*if(mbProfile.profileStatus!='COMPLETE' || mbProfile.profileStatus!='REJECTED' || mbProfile.profileStatus!='DUPLICATE')
        	mbProfile.profileStatus = "INCOMPLETE"*/
        if(!mbProfile.save())
            {
            mbProfile.errors.each {
                println it;
            }
            return -2	//cant update dob
            }

        // code for family members
        //assuming params has relative[d].name, relative[d].relation etc
        /*for(int i=0;i<numRelatives;i++)   //0 based
            {
            log.debug("Realive"+i+"name:"+params.('relative'+i).name)
            }


         */

        //check if the modifications happened after 'mark complete'
        if(mbProfile.profileStatus == 'COMPLETE') {
            //need to alert the secs
            def motd = new Motd()
            motd.quote = "Profile for " + mbProfile.candidate.toString() + " has been updated on " + new Date().format('dd-MM-yyyy HH:mm:ss')
            motd.reference = "MB:updateProfile:" + mbProfile.id
            motd.updator = motd.creator = springSecurityService.principal.username
            motd.save()
        }
        return 1
    }
    
    def updateProfileStatus(Map params) {
         def username=''
         try{
		 username = springSecurityService.principal.username
         }
         catch(Exception e){username='unknown'}

    	//first get the MbProfile
    	def mbProfile = MbProfile.get(params.id)
    	if(!mbProfile)
    		return "Profile not found!!"	//MbProfile not found
    		
    	//check for ownership of profile..i.e. who can modify the status
    	//admin can modify for any centre but sec only for theire centre
    	def allow = false
    	if(SpringSecurityUtils.ifAllGranted('ROLE_MB_SEC')) {
    		def secCentre = Individual.findByLoginid(username)?.iskconCentre
    		if(secCentre && secCentre==mbProfile.referrerCenter)
    			allow = true
    	}
    	if(!allow)
    		return "Can not review as profile from other centre."
    	
    	//now update the fields
    	mbProfile.profileStatus = params.status
    	
    	if(mbProfile.profileStatus=='COMPLETE')
		mbProfile.workflowStatus='UNASSIGNED'
	
	mbProfile.updator = username
	if(!mbProfile.save()) {
		mbProfile.errors.allErrors.each {log.debug("updateProfileStatus:"+it)}
		return "Some error occurred while updating ProfileStatus..Pls contact admin with errorcode MB"
	}
		
    	return "ProfileStatus updated succesfully..."
    }

    def getYearFromDate(Date date){
        def year = new SimpleDateFormat("yyyy").format(date)
        return Integer.parseInt(year)
    }

    def getYearFromDate(String date){
        return Integer.parseInt(date)
    }
    
    def createProfileFromAttrs(String objectClassName,Long objectId) {
    	//get all the attr values first
    	def attrValues = AttributeValue.findAllByObjectClassNameAndObjectId(objectClassName,objectId)
    	//now create params map
    	Map  params = [:]
    	attrValues.each{
    		if(it.value)
    			params.put(it.attribute.name,it.value)
    	}

    	def mbProfileId = initiateProfile(params)
    	params.put('id',mbProfileId)
    	updateProfile(params)
    	
    	//update the attr values with the created object
    	attrValues.each{
    		it.objectClassName="MB"
    		it.objectId = mbProfileId
    		it.save()
    	}    	
    	
    	return mbProfileId
    }
    
    def suggest(Map params) {
    	def candidate = MbProfile.get(params.candidateid)
    	if(!candidate)
    		return 0
    	if(!candidate.matches)
    		candidate.matches=[]
    		
    	def prospect,pmatch
	def idList = params.prospects.tokenize(',')
	idList.each{
		prospect = MbProfile.get(it)
		if(prospect)
			{
			pmatch = new MbProfileMatch()
			pmatch.candidate = candidate
			pmatch.prospect = prospect
			pmatch.stage = "FIRST"
			if(!pmatch.save())
			    pmatch.errors.each { log.debug("pmatch:"+it)}
			else {
				//do the same for prospect if specified
				if(params.type=='both') {
					suggest([candidateid:prospect.id.toString(),prospects:candidate.id.toString()])
				}
			}
			}
    		}    	
    }
    
    def propose(Map params) {
    	def candidate = MbProfile.get(params.candidateid)
    	if(!candidate)
    		return 0
    		
    	def pmatch
	def idList = params.prospects.tokenize(',')
	idList.each{
		pmatch = MbProfileMatch.get(it)
		if(pmatch)
			{
			pmatch.stage = "SECOND"
			pmatch.mbStatus = "FULLPROFILE"
			pmatch.mbDate = new Date()
			if(!pmatch.save())
			    pmatch.errors.each { log.debug("pmatch:"+it)}
			else
				{
				//now update workflow statuses
				pmatch.candidate.workflowStatus='PROPOSED'
				if(!candidate.save())
				    candidate.errors.each { log.debug("upd cand:"+it)}
				//also send the candidate's limited profile to the prospect
				if(!pmatch.prospect.matches)
					pmatch.prospect.matches= []
				def match = new MbProfileMatch()
				match.candidate = pmatch.prospect
				match.prospect = pmatch.candidate
				match.stage = "FIRST"
				if(!match.save())
				    match.errors.each { log.debug("match:"+it)}
				}
			}
    		}    	
    }

    def announce(Map params) {
    	def candidate = MbProfile.get(params.candidateid)
    	if(!candidate)
    		return 0
    		
    	def match
	def idList = params.prospects.tokenize(',')
	if(idList.size()>1)
		return 0
	idList.each{
		match = MbProfileMatch.get(it)
		if(match)
			{
			match.stage = "THIRD"
			match.mbStatus = "ANNOUNCE"
			match.mbDate = new Date()
			if(!match.save())
			    match.errors.each { log.debug("match:"+it)}
			else
				{
				//now update workflow statuses
					def otherMatch = MbProfileMatch.findByCandidateAndProspect(match.prospect,match.candidate)
					if(otherMatch) {
						//update workflow status for both
						match.candidate.workflowStatus = 'ANNOUNCE'
						if(!match.candidate.save())
							match.candidate.errors.allErrors.each {log.debug("ANNOUNCE:"+it)}
						otherMatch.candidate.workflowStatus = 'ANNOUNCE'
						if(!otherMatch.candidate.save())
							otherMatch.candidate.errors.allErrors.each {log.debug("ANNOUNCE:"+it)}
					}    				
				}
			}
    		}    	
    }


 /*   generic method to create family members of the candidate.
    it assumes all params viz relation,name, education , occupation are sent as numbered params
    relation should be harcoded/hidden var in the gsp or available from a select box
    totalNumberOfFamily members to capture the count*/
    def processFamilyDetails(Individual candidate, Map params) {
    	def totalNumberOfFamily = 8,relationshipGroup = null
 /*   	try{
    		totalNumberOfFamily = new Integer(params.totalNumberOfFamily)
    	}
    	catch(Exception e){}*/
        if(Relationship.findByIndividual2(candidate))
    	    relationshipGroup = Relationship.findByIndividual2(candidate).relationshipGroup
    	for(int i=1;i<=totalNumberOfFamily;i++)
    		{
    		//1. create individual
    		if(params.('relativeName'+i))
    			{
                if(params.('relativeId'+i))
                {
                    Individual.findById(params.('relativeId'+i)).legalName = params.('relativeName'+i)
                    Individual.findById(params.('relativeId'+i)).initiatedName = params.('relativeIName'+i)
                    Individual.findById(params.('relativeId'+i)).education = params.('relativeEducation'+i)
                    Individual.findById(params.('relativeId'+i)).profession = params.('relativeProfession'+i)
                }
                else
                {
                    def relative = individualService.createBasicIndividual([name: params.('relativeName' + i), education: params.('relativeEducation' + i), profession: params.('relativeProfession' + i)])
                    //create relationship
                    if (relative && params.('relationName' + i))
                    {
                        def relation = Relation.findByName(params.('relationName' + i))
                        if (relation)
                        {
                            //create relationshipGroup for the 1st time only
                            if (!relationshipGroup)
                            {
                                relationshipGroup = new RelationshipGroup()
                                relationshipGroup.refid = candidate.id
                                relationshipGroup.groupName = 'Family of ' + candidate.toString()
                                relationshipGroup.category = 'Family'
                                relationshipGroup.status = 'ACTIVE'
                                relationshipGroup.updator = relationshipGroup.creator = springSecurityService.principal.username
                                if (!relationshipGroup.save())
                                    relationshipGroup.errors.each { log.debug("Exception in creating RG:" + it) }
                            }
                            //now create relationship
                            if(relationshipGroup)
                            {
                                def relationship = new Relationship()
                                relationship.individual1 = relative
                                relationship.individual2 = candidate
                                relationship.relationshipGroup = relationshipGroup
                                relationship.relation = relation
                                relationship.status = 'ACTIVE'
                                relationship.updator = relationship.creator = springSecurityService.principal.username
                                if (!relationship.save())
                                    relationship.errors.each { log.debug("Exception in creating Relationship:" + it) }

                            }
                        }
                    }
                }
            }
        }
    }
    
    def configureCentres(Map params) {
    	//first check whether already created??
    	def attribute = Attribute.findByDomainClassNameAndDomainClassAttributeNameAndCategory('Mb','Centre','Config')
    	if(!attribute) {
    		log.debug("configureCentres..creating attr");
		attribute = new Attribute()
		attribute.domainClassName='Mb'
		attribute.domainClassAttributeName='Centre'
		attribute.category='Config'
		attribute.type='Master'
		attribute.name='Centre'
		attribute.displayName='Centre'
		attribute.position=0
		if(!attribute.save())
		    attribute.errors.allErrors.each {
				log.debug("configureCentres..creating attr..:Exception in saving attr"+it)
			    }
    	}
    	
    	//now create av as per supplied list
    	params.centres.tokenize(',').each{centre->
		def attributeValue = new AttributeValue()			
		attributeValue.attribute  = attribute
		attributeValue.objectClassName = attribute.domainClassName
		attributeValue.objectId = new Long(1)	//irrelevant
		attributeValue.creator = 'system'
		attributeValue.value = centre
		attributeValue.updator = 'system'
		if(!attributeValue.save())
		    attributeValue.errors.allErrors.each {
				log.debug("configureCentres:Exception in saving attrv"+it)
			    }
	}
    	
	return true    	
    }
    
    def assignProfile(Map params) {
    	def profile = MbProfile.get(params.profileid)
    	def assignedTo = Individual.get(params.assignedToId)
    	
    	if(assignedTo && profile && profile.profileStatus=='COMPLETE' && profile.workflowStatus=='UNASSIGNED')
    		{
    		//assign
    		profile.assignedTo = assignedTo
    		profile.workflowStatus = "AVAILABLE"
    		if(!profile.save())
 		    profile.errors.allErrors.each {
				log.debug("assignProfile:Exception in saving profile"+it)
			    }
		else
			return "Assigned successfully!"
   			
    		}
	else
		return "Not found!!"
    }
    
    def addBoardMember(Map params) {
	  def indparams = [:]
	  indparams.category = 'MB_BOARD'
	  indparams.legalName = params.name
	  indparams.contact = params.phone
	  indparams.email = params.email
	  indparams.iskconCentre = params.centre

	  def individual = individualService.createIndividual(indparams)
	  if (individual) {

	    def mrole = Role.findByNameAndCategory('MEMBER','MarriageBoard')
	    def srole = Role.findByNameAndCategory('SECRETARY','MarriageBoard')
	    def role
	    
	    switch(params.role) {
	    	case 'MEMBER':
			    //assign the role
			    role = mrole
	    		break
	    	case 'SECRETARY':
			    //assign the role
			    role = srole
	    		break
	    	default:
	    		break
	    		
	    }
	    if(role) {
		def indRole = new IndividualRole()
		indRole.individual = individual
		indRole.role = role
		indRole.status = 'VALID'
		indRole.creator = indRole.updator = springSecurityService.principal.username
		if(!indRole.save()) {
			indRole.errors.allErrors.each {log.debug("indRole:"+it)}
		}
		//now create the loginid
		housekeepingService.createLogin(individual,IcsRole.findByAuthority(role.authority))
	    }

	   }
    }
    
    def changeWorkflowStatus(Map params) {
         def username=''
         try{
		 username = springSecurityService.principal.username
         }
         catch(Exception e){username='unknown'}

    	def profile = MbProfile.get(params.mbprofileid)
    	if(profile && params.status) {
		//check for ownership of profile..i.e. who can modify the status
		//admin can modify for any centre but sec only for theire centre
		def allow = false
		if(SpringSecurityUtils.ifAllGranted('ROLE_MB_SEC')) {
			def secCentre = Individual.findByLoginid(username)?.iskconCentre
			if(secCentre && secCentre==profile.referrerCenter)
				allow = true
		}
		if(!allow)
			return "Can not set workflow status as profile from other centre."

    		profile.workflowStatus = params.status
    		if(!profile.save())
    			profile.errors.allErrors.each {log.debug(it)}
    		else
    			return "Workflow status updated."
    	}
    }
    
    def stats() {
    	def stats = [:]
    	def result
    	def query
    	def sql = new Sql(dataSource)
    	
    	//profile stats
    	result = MbProfile.createCriteria().list(){
			projections {
				groupProperty('profileStatus')
				rowCount('id')
			}
    		}
    	def map = [:]
    	result.each{map.put(it[0],it[1])}
    	log.debug('ProfileStats:'+map)
    	stats.put('ProfileStats',map)
    	
    	//workflow stats
    	result = MbProfile.createCriteria().list(){
			projections {
				groupProperty('workflowStatus')
				rowCount('id')
			}
    		}
    	def wmap = [:]
    	result.each{wmap.put(it[0],it[1])}
    	log.debug('WorkflowStats:'+wmap)
    	stats.put('WorkflowStats',wmap)

    	//last 10 logins    	
	def llist = []
    	query = "select a.*,i.id,i.legal_name,i.initiated_name,i.category from access_log a , individual i where a.loginid=i.loginid and (i.category='MB' or i.category='MB_BOARD') order by a.id desc limit 10"
    	result = sql.rows(query)
        result.each{row->
	        def rowMap = [:]
        	row.keySet().each {column ->
            		rowMap[column] = row[column]
            		}
            	llist.add(rowMap)
        	}
        
    	log.debug('LoginStats:'+llist)
    	stats.put('LoginStats',llist)

    	//match stats
    	result = MbProfileMatch.createCriteria().list(max:10){
    			order('id','desc')
    		}
    	log.debug('MatchStats:'+result)
    	stats.put('MatchStats',result)
    	
    	sql.close()
    	
    	return stats

    }

    def getHeight(String height){
        def ft = Integer.parseInt(height.split('"')[0])
        def inch = Integer.parseInt(height.split('"')[1].replace("'",""))
        return (ft*12 + inch)
    }    

    def unlockAndResetUser(Individual individual) {
    	def iuser  = IcsUser.findByUsername(individual?.loginid)
    	iuser?.accountLocked = false
    	iuser?.setPassword('harekrishna')
    	if(iuser)
    		return true
    	else
    		return false
    }

	def genderwiseReport(Map params) {
		def result = MbProfile.createCriteria().list{
				if(params.centre)
					eq('referrerCenter',params.centre)
				candidate{
					projections {
					groupProperty('isMale')
					rowCount('id')
					}
				}
				}
		def series = []
		result.each{series.add([it[0]?'Prabhuji':'Mataji',it[1]])}
		return [series]
	}	

	def candidateAttributeReport(Map params) {
		def result = MbProfile.createCriteria().list{
				if(params.centre)
					eq('referrerCenter',params.centre)
				candidate{
					projections {
					groupProperty(params.attribute)
					rowCount('id')
					}
				}
				}
		def series = []
		result.each{series.add([it[0],it[1]])}
		return [series]
	}	

	def mbProfileAttributeReport(Map params) {
		def result = MbProfile.createCriteria().list{
				if(params.centre)
					eq('referrerCenter',params.centre)
				projections {
				groupProperty(params.attribute)
				rowCount('id')
				}
				}
		def series = []
		result.each{series.add([it[0],it[1]])}
		return [series]
	}	

}
