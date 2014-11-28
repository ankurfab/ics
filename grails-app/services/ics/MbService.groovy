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

    	
    	return 1
    }

    def updateProfile(Map params) {
    	//first get the MbProfile
    	def mbProfile = MbProfile.get(params.id)
    	if(!mbProfile)
    		return -1	//MbProfile not found
    	//now update the fields step1
        mbProfile.candidate.legalName=params.legalName
        mbProfile.candidate.initiatedName=params.initiatedName
        mbProfile.candidate.isMale=(params.isMale=='MALE')
        mbProfile.candidate.dob = new Date().parse('d/M/yyyy H:m:s',params.dob+" "+params.tob)
        mbProfile.candidate.pob=params.pob
        mbProfile.candidate.iskconCentre=params.iskconCentre
        mbProfile.candCounsellor=params.counselor
        mbProfile.candCounsellorAshram=params.counselorAshram
        mbProfile.candidate.nationality=params.nationality
        mbProfile.candidate.origin=params.originState
        mbProfile.candidate.varna=params.varna
        mbProfile.candidate.category=params.category
        mbProfile.candidate.caste=params.caste
        mbProfile.candidate.subCaste=params.subCaste
        mbProfile.candidate.height=Integer.parseInt(params.height)
        mbProfile.candidate.motherTongue=params.motherTongue
        mbProfile.candidate.otherLanguages==params.languagesKnown
        mbProfile.candidate.income=params.candidateIncome //change the type of the column in db
        mbProfile.horoscopeToBeMatched=params.horoscopeToBeMatched
        mbProfile.manglik=params.manglik
        def candAddr = Address.findByIndividualAndCategory(mbProfile.candidate,'PresentAddress')
        if(!candAddr) {

            mbProfile.candidate.address.add(helperService.createAddress([individual: mbProfile.candidate, category: 'PresentAddress', addressLine1: params.addrline1, addressLine2: params.addrline2, addressLine3: params.addrline3, 'cityname': params.city, 'statename': params.state, pincode: params.pincode]))
        }
        else
            helperService.updateAddress([id:candAddr?.id,individual:mbProfile.candidate,category:'PresentAddress',addressLine1:params.addrline1,addressLine2:params.addrline2,addressLine3:params.addrline3,'cityname':params.city,'statename':params.state,pincode:params.pincode])
        mbProfile.referrer=params.references
        def contactno = VoiceContact.findByIndividual(mbProfile.candidate)
        contactno.number = params.contact
        contactno.save()
        def emailadd= EmailContact.findByIndividual(mbProfile.candidate)
        emailadd.emailAddress=params.email
        emailadd.save()
        mbProfile.personalInfo = params.personalInfo
        //step 2
        mbProfile.nativePlace=params.nativePlace
        mbProfile.nativeState=params.nativeState

        if(!mbProfile.familyAddress)
            mbProfile.familyAddress = helperService.createAddress([individual:mbProfile.candidate,category:'FamilyAddress',addressLine1:params.famaddrline1,addressLine2:params.famaddrline2,addressLine3:params.famaddrline3,'cityname':params.permcity,'statename':params.familystate,pincode:params.permpincode])
        else
            helperService.updateAddress([id:mbProfile.familyAddress.id,individual:mbProfile.candidate,category:'FamilyAddress',addressLine1:params.famaddrline1,addressLine2:params.famaddrline2,addressLine3:params.famaddrline3,'cityname':params.permcity,'statename':params.familystate,pincode:params.permpincode])

        mbProfile.houseIs = params.houseIs
        mbProfile.houseArea = Integer.parseInt(params.houseArea)
        mbProfile.otherProperty = params.otherProperty
        mbProfile.fatherIncome = params.fatherIncome
        mbProfile.otherIncome = params.otherIncome
        mbProfile.fatherName = params.fatherName
        mbProfile.fatherEducation = params.fatherEducation
        mbProfile.fatherOccupation = params.fatherOccupation
        mbProfile.motherName = params.motherName
        mbProfile.motherEducation = params.motherEducation
        mbProfile.motherOccupation = params.motherOccupation
        mbProfile.brother1Name = params.brother1Name
        mbProfile.brother1Education = params.brother1Education
        mbProfile.brother1Occupation = params.brother1Occupation
        mbProfile.brother2Name = params.brother2Name
        mbProfile.brother2Education = params.brother2Education
        mbProfile.brother2Occupation = params.brother2Occupation
        mbProfile.brother3Name = params.brother3Name
        mbProfile.brother3Education = params.brother3Education
        mbProfile.brother3Occupation = params.brother3Occupation
        mbProfile.sister1Name = params.sister1Name
        mbProfile.sister1Education = params.sister1Education
        mbProfile.sister1Occupation = params.sister1Occupation
        mbProfile.sister2Name = params.sister2Name
        mbProfile.sister2Education = params.sister2Education
        mbProfile.sister2Occupation = params.sister2Occupation
        mbProfile.sister3Name = params.sister3Name
        mbProfile.sister3Education = params.sister3Education
        mbProfile.sister3Occupation = params.sister3Occupation
        mbProfile.sister3Occupation = params.sister3Occupation
        mbProfile.parentsInfo = params.parentsInfo
        mbProfile.parentsChanting = params.parentsChanting
        mbProfile.parentsInitiation = params.parentsInitiation
        mbProfile.parentsSpMaster = params.parentsSpMaster
        mbProfile.yourFamily = params.youFamily

        //step3
        mbProfile.eduCat = params.eduCat
        mbProfile.eduQual = params.eduQual
        mbProfile.occupationStatus = params.occupationStatus
        mbProfile.companyName = params.companyName
        mbProfile.designation = params.designation

        if(!mbProfile.companyAddress)
            mbProfile.companyAddress = helperService.createAddress([individual:mbProfile.candidate,category:'CompanyAddress',addressLine1:params.compAddrLine1,addressLine2:params.compAddrLine2,addressLine3:params.compAddrLine3,'cityname':params.compCity,'statename':params.compState,pincode:params.compPin])
        else
            helperService.updateAddress([id:mbProfile.companyAddress.id,individual:mbProfile.candidate,category:'CompanyAddress',addressLine1:params.compAddrLine1,addressLine2:params.compAddrLine2,addressLine3:params.compAddrLine3,'cityname':params.compCity,'statename':params.compState,pincode:params.compPin])

        //step4
        mbProfile.introductionYear = getYearFromDate(params.introductionYear)
        mbProfile.introductionCentre = params.introductionCentre
        mbProfile.currentlyVisiting = params.currentlyVisiting
        mbProfile.regularSince = getYearFromDate(params.regularSince)
        mbProfile.frequencyOfTempleVisits = params.frequencyOfTempleVisits
        mbProfile.likesInKc = params.likesInKc
        mbProfile.dislikesInKc = params.dislikesInKc
        mbProfile.teacoffee = (params.teacoffee=='Yes')
        mbProfile.oniongarlic = (params.oniongarlic=='Yes')
        mbProfile.nonveg = (params.nonveg=='Yes')
        mbProfile.intoxication = (params.intoxication=='Yes')
        mbProfile.gambling = (params.gambling=='Yes')
        mbProfile.extraMaritalAffair = (params.extraMaritalAffair=='Yes')
        mbProfile.regDetails = params.regDetails
        mbProfile.regulated = (params.regulated=='Yes')
        mbProfile.regulatedSince = getYearFromDate(params.regulatedSince)
        mbProfile.chantingSince = getYearFromDate(params.chantingSince)
        mbProfile.chantingSixteenSince = getYearFromDate(params.chantingSixteenSince)
        mbProfile.numberOfRounds=Integer.parseInt(params.numberOfRounds)
        mbProfile.spiritualMaster = params.spiritualMaster
        mbProfile.firstInitiation = new Date().parse('d/M/yyyy',params.firstInitiation)
        mbProfile.secondInitiation = new Date().parse('d/M/yyyy',params.secondInitiation)
        mbProfile.services = params.services
        mbProfile.interests = params.interests
        mbProfile.remarks = params.remarks
        //step 5
        mbProfile.devotionalCulture=params.devotionalCulture
        mbProfile.flexibleChanting = Boolean.valueOf(params.flexibleChanting)
        mbProfile.flexibleSpMaster = Boolean.valueOf(params.flexibleSpMaster)
        mbProfile.flexibleCentre = Boolean.valueOf(params.flexibleCentre)
        mbProfile.flexibleNationality = Boolean.valueOf(params.flexibleNationality)
        mbProfile.flexibleOrigin = Boolean.valueOf(params.flexibleOrigin)
        mbProfile.flexibleVarna = Boolean.valueOf(params.flexibleVarna)
        mbProfile.flexibleCategory = Boolean.valueOf(params.flexibleCategory)
        mbProfile.flexibleCaste = Boolean.valueOf(params.flexibleCaste)
        mbProfile.flexibleSubcaste = Boolean.valueOf(params.flexibleSubcaste)
        mbProfile.flexibleEducationCat = Boolean.valueOf(params.flexibleEducationCat)
        mbProfile.flexibleQualifications = Boolean.valueOf(params.flexibleQualifications)
        mbProfile.flexibleAgediff = Boolean.valueOf(params.flexibleAgediff)
        mbProfile.flexibleHeight = Boolean.valueOf(params.flexibleHeight)
        mbProfile.flexibleLooks = Boolean.valueOf(params.flexibleLooks)
        mbProfile.flexibleCandidateIncome = Boolean.valueOf(params.flexibleCandidateIncome)
        mbProfile.flexibleLangknown = Boolean.valueOf(params.flexibleLangknown)
        mbProfile.flexibleManglik = Boolean.valueOf(params.flexibleManglik)
        mbProfile.settleAbroadWorkingWife = params.settleAbroadWorkingWife
        mbProfile.prefChanting=params.prefChanting
        mbProfile.prefSpMaster=params.prefSpMaster
        mbProfile.prefCentre=params.prefCentre
        mbProfile.prefNationality=params.prefNationality
        mbProfile.prefOrigin=params.prefOrigin
        mbProfile.prefVarna=params.prefVarna
        mbProfile.prefCategory=params.prefCategory
        mbProfile.prefCaste=params.prefCaste
        mbProfile.prefsubCaste=params.prefsubCaste
        mbProfile.prefeducationCategory=params.prefeducationCategory
        mbProfile.prefqualification=params.prefqualification
        mbProfile.prefAgeDiff=params.prefAgeDiff
        mbProfile.prefHeight=params.prefHeight
        mbProfile.prefLooks=params.prefLooks
        mbProfile.prefCandIncome=params.prefCandIncome
        mbProfile.prefLangKnown=params.prefLangKnown
        mbProfile.prefManglik=params.prefManglik
        mbProfile.otherExpectations = params.otherExpectations
        //step 6
        mbProfile.keenDevProfile=params.keenDevProfile
        mbProfile.primdepMB=params.primdepMB
        mbProfile.regotherMB=params.regotherMB
        mbProfile.parentsSearch=params.parentsSearch
        mbProfile.profileoutsideISKCON=params.profileoutsideISKCON
        mbProfile.financialDiff=params.financialDiff
        mbProfile.physicalMental=params.physicalMental
        mbProfile.depLifelong=params.depLifelong

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

}
