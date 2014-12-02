package ics
import com.krishna.*

import java.text.SimpleDateFormat

class MbService {

    def individualService
    def housekeepingService
    def helperService
    def springSecurityService
    
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
    	mbProfile.profileStatus = 'INITIATED'
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
	try{         mbProfile.candidate.varna=params.varna } catch(Exception e){}
	try{         mbProfile.scstCategory=params.scstCategory } catch(Exception e){}
	try{         mbProfile.candidate.caste=params.caste } catch(Exception e){}
	try{         mbProfile.candidate.subCaste=params.subCaste } catch(Exception e){}
	try{         mbProfile.candidate.height=Integer.parseInt(params.height) } catch(Exception e){}
	try{         mbProfile.candidate.motherTongue=params.motherTongue } catch(Exception e){}
    try{         mbProfile.languagesKnown=params.languagesKnown } catch(Exception e){}
	try{         mbProfile.candidate.income=params.candidateIncome //change the type of the column in db
	} catch(Exception e){}
	try{         mbProfile.horoscopeToBeMatched=params.horoscopeToBeMatched } catch(Exception e){}
	try{         mbProfile.manglik=params.manglik } catch(Exception e){}
	try{
		if(params.addrline1) {
			def candAddr = Address.findByIndividualAndCategory(mbProfile.candidate,'PresentAddress')
			if(!candAddr) {
			    mbProfile.candidate.address.add(helperService.createAddress([individual: mbProfile.candidate, category: 'PresentAddress', addressLine1: params.addrline1, addressLine2: params.addrline2, addressLine3: params.addrline3, 'cityname': params.city, 'statename': params.state, pincode: params.pincode]))
			}
			else
			    helperService.updateAddress([id:candAddr?.id,individual:mbProfile.candidate,category:'PresentAddress',addressLine1:params.addrline1,addressLine2:params.addrline2,addressLine3:params.addrline3,'cityname':params.city,'statename':params.state,pincode:params.pincode])
		}
         } catch(Exception e){}
        mbProfile.referrer=params.references
        def contactno = VoiceContact.findByIndividual(mbProfile.candidate)
        contactno?.number = params.contact
        contactno?.save()
        def emailadd= EmailContact.findByIndividual(mbProfile.candidate)
        emailadd?.emailAddress=params.email
        emailadd?.save()
    try{        mbProfile.personalInfo = params.personalInfo} catch(Exception e){}
        //step 2
        mbProfile.nativePlace=params.nativePlace
        mbProfile.nativeState=params.nativeState

	if(params.famaddrline1) {
		if(!mbProfile.familyAddress)
		    mbProfile.familyAddress = helperService.createAddress([individual:mbProfile.candidate,category:'FamilyAddress',addressLine1:params.famaddrline1,addressLine2:params.famaddrline2,addressLine3:params.famaddrline3,'cityname':params.permcity,'statename':params.familystate,pincode:params.permpincode])
		else
		    helperService.updateAddress([id:mbProfile.familyAddress.id,individual:mbProfile.candidate,category:'FamilyAddress',addressLine1:params.famaddrline1,addressLine2:params.famaddrline2,addressLine3:params.famaddrline3,'cityname':params.permcity,'statename':params.familystate,pincode:params.permpincode])
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
	try{         mbProfile.parentsSpMaster = params.parentsSpMaster } catch(Exception e){}
	try{         mbProfile.yourFamily = params.youFamily } catch(Exception e){}

        //step3
	try{         mbProfile.eduCat = params.eduCat } catch(Exception e){}
	try{         mbProfile.eduQual = params.eduQual } catch(Exception e){}
	try{         mbProfile.occupationStatus = params.occupationStatus } catch(Exception e){}
	try{         mbProfile.companyName = params.companyName } catch(Exception e){}
	try{         mbProfile.designation = params.designation } catch(Exception e){}

	if(params.compAddrLine1) {
		if(!mbProfile.companyAddress)
		    mbProfile.companyAddress = helperService.createAddress([individual:mbProfile.candidate,category:'CompanyAddress',addressLine1:params.compAddrLine1,addressLine2:params.compAddrLine2,addressLine3:params.compAddrLine3,'cityname':params.compCity,'statename':params.compState,pincode:params.compPin])
		else
		    helperService.updateAddress([id:mbProfile.companyAddress.id,individual:mbProfile.candidate,category:'CompanyAddress',addressLine1:params.compAddrLine1,addressLine2:params.compAddrLine2,addressLine3:params.compAddrLine3,'cityname':params.compCity,'statename':params.compState,pincode:params.compPin])
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
	try{         mbProfile.extraMaritalAffair = (params.extraMaritalAffair=='Yes') } catch(Exception e){}
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
	try{         mbProfile.flexibleOrigin = Boolean.valueOf(params.flexibleOrigin) } catch(Exception e){}
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
	try{         mbProfile.prefSpMaster=params.prefSpMaster } catch(Exception e){}
	try{         mbProfile.prefCentre=params.prefCentre } catch(Exception e){}
	try{         mbProfile.prefNationality=params.prefNationality } catch(Exception e){}
	try{         mbProfile.prefOrigin=params.prefOrigin } catch(Exception e){}
	try{         mbProfile.prefVarna=params.prefVarna } catch(Exception e){}
	try{         mbProfile.prefCategory=params.prefCategory } catch(Exception e){}
	try{         mbProfile.prefCaste=params.prefCaste } catch(Exception e){}
	try{         mbProfile.prefsubCaste=params.prefsubCaste } catch(Exception e){}
	try{         mbProfile.prefeducationCategory=params.prefeducationCategory } catch(Exception e){}
	try{         mbProfile.prefqualification=params.prefqualification } catch(Exception e){}
	try{         mbProfile.prefAgeDiff=params.prefAgeDiff } catch(Exception e){}
	try{         mbProfile.prefHeight=params.prefHeight } catch(Exception e){}
	try{         mbProfile.prefLooks=params.prefLooks } catch(Exception e){}
	try{         mbProfile.prefCandIncome=params.prefCandIncome } catch(Exception e){}
	try{         mbProfile.prefLangKnown=params.prefLangKnown } catch(Exception e){}
	try{         mbProfile.prefManglik=params.prefManglik } catch(Exception e){}
    try{         mbProfile.otherExpectations=params.otherExpectations } catch(Exception e){}

        //step 6
	try{         mbProfile.keenDevProfile=params.keenDevProfile } catch(Exception e){}
	try{         mbProfile.primdepMB=params.primdepMB } catch(Exception e){}
	try{         mbProfile.regotherMB=params.regotherMB } catch(Exception e){}
	try{         mbProfile.parentsSearch=params.parentsSearch } catch(Exception e){}
	try{         mbProfile.profileoutsideISKCON=params.profileoutsideISKCON } catch(Exception e){}
	try{         mbProfile.financialDiff=params.financialDiff } catch(Exception e){}
	try{         mbProfile.physicalMental=params.physicalMental } catch(Exception e){}
	try{         mbProfile.depLifelong=params.depLifelong } catch(Exception e){}


        mbProfile.updator = springSecurityService.principal.username
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
    	//first get the MbProfile
    	def mbProfile = MbProfile.get(params.id)
    	if(!mbProfile)
    		return -1	//MbProfile not found
    	//now update the fields
	mbProfile.workflowStatus='APPROVED'
	mbProfile.save()
    	return 1
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
    
    def propose(Map params) {
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
			else
				{
				candidate.matches.add(pmatch)
				candidate.workflowStatus='INPROGRESS'
				if(!candidate.save())
				    candidate.errors.each { log.debug("upd cand:"+it)}
				prospect.workflowStatus='PROPOSED'
				if(!prospect.save())
				    prospect.errors.each { log.debug("upd pros:"+it)}
				}
			}
    		}    	
    }
    
 /*   generic method to create family members of the candidate.
    it assumes all params viz relation,name, education , occupation are sent as numbered params
    relation should be harcoded/hidden var in the gsp or available from a select box
    totalNumberOfFamily members to capture the count*/
    def processFamilyDetails(Individual candidate, Map params) {
    	def totalNumberOfFamily = 8
 /*   	try{
    		totalNumberOfFamily = new Integer(params.totalNumberOfFamily)
    	}
    	catch(Exception e){}*/
    	def relationshipGroup = Relationship.findByIndividual2(candidate).relationshipGroup
    	for(int i=1;i<=totalNumberOfFamily;i++)
    		{
    		//1. create individual
    		if(params.('relativeName'+i))
    			{
                if(params.('relativeId'+i))
                {
                    Individual.findById(params.('relativeId'+i)).legalName = params.('relativeName'+i)
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

}
