package ics
import com.krishna.*

class MbService {

    def individualService
    def housekeepingService
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
    	indRole.role = Role.findByCategoryAndName('MB','MB_CAND')
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
    	//now update the fields
	mbProfile.candidate.legalName=params.legalName
	mbProfile.candidate.initiatedName=params.initiatedName
	mbProfile.candidate.dob=params.dob
	mbProfile.candidate.pob=params.pob
	mbProfile.updator = springSecurityService.principal.username
	//@TODO: update not working for all the fields
	if(!mbProfile.candidate?.save())
		{
		return -2	//cant update dob
		}
		
	//check if the modifications happened after 'mark complete'
	if(mbProfile.profileStatus == 'COMPLETE')
		{
		//need to alert the secs
		def motd = new Motd()
		motd.quote = "Profile for "+mbProfile.candidate.toString()+" has been updated on "+new Date().format('dd-MM-yyyy HH:mm:ss')
		motd.reference = "MB:updateProfile:"+mbProfile.id
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
    
}
