package ics

import grails.converters.JSON

class MbController {

    def MbService
    def dataService
    
    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [mbInstanceList: Mb.list(params), mbInstanceTotal: Mb.count()]
    }

    def startProfile = {
    }
    
    def editProfile() {
    	Individual cand = Individual.get(session.individualid)
    	def mbProfile = MbProfile.findByCandidate(cand)
    	[mbProfile: mbProfile]
    }

    def save = {
        def retVal = MbService.initiateProfile(params)
        if (retVal>0) {
            flash.defaultMessage = "MB profile creation initiated succesfully..."
            render(view: "manage")
        }
        else {
            flash.defaultMessage = "Some error occurred..Pls contact admin with errorcode MB"+retVal
            render(view: "startProfile", model: [mbProfileInstance: params, retVal:retVal])
        }
    }

    def show = {
        def mbProfileInstance = MbProfile.get(params.id)
        if (!mbProfileInstance) {
            flash.message = "mb.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "MbProfile not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            render(view: "editProfile", model: [mbProfile: mbProfileInstance])
        }

    }

    def edit = {
        def mbInstance = Mb.get(params.id)
        if (!mbInstance) {
            flash.message = "mb.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Mb not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [mbInstance: mbInstance]
        }
    }

    def updateProfile = {
        log.debug("Inside updateProfile with params: "+params)
        def mbProfile = MbProfile.get(params.id)
        if (mbProfile) {
            if (params.version) {
                def version = params.version.toLong()
                if (mbProfile.version > version) {
                    
                    mbProfile.errors.rejectValue("version", "mb.optimistic.locking.failure", "Another user has updated this profile while you were editing")
                    render(view: "editProfile", model: [mbProfile: mbProfile])
                    return
                }
            }
		def retVal = MbService.updateProfile(params)
		if (retVal>0) {
		    flash.message = "Profile updated succesfully..."
	            redirect(action: "editProfile")
		}
		else {
		    flash.message = "Some error occurred..Pls contact admin with errorcode MB"+retVal
		    render(view: "editProfile", model: [mbProfile: params, retVal:retVal])
		}
        }
        else {
            flash.message = "mb.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Profile not found with id ${params.id}"
            redirect(action: "editProfile")
        }
    }

    def delete = {
        def mbInstance = Mb.get(params.id)
        if (mbInstance) {
            try {
                mbInstance.delete()
                flash.message = "mb.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Mb ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "mb.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Mb ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "mb.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Mb not found with id ${params.id}"
            redirect(action: "list")
        }
    }

    def search() {
        def mbProfile = MbProfile.get(params.id)
        [mbProfile: mbProfile]
    }

    def manage() {
    }

def uploadImage = {
    	log.debug("Inside uploadImage with params: "+params)
    	Individual cand = Individual.get(session.individualid)
    	def mbProfile = MbProfile.findByCandidate(cand)
	  def individual = cand
	  // Get the avatar file from the multi-part request
	  def f
	  // Save the image and mime type
	  switch (params.type) {
	  case 'fv':
		  f = request.getFile('imgFile')
		  individual.avatar = f.getBytes()
		  individual.avatarType = f.getContentType()
		  log.info("fv File uploaded: " + individual.avatarType)
		  // Validation works, will check if the image is too big
		  if (!individual.save()) {
		    log.debug("Some error")
		    return;
		  }
		  break
	  case 'sv':
		  f = request.getFile('imgFileSV')
		  mbProfile.photo = f.getBytes()
		  mbProfile.photoType = f.getContentType()
		  log.info("sv File uploaded: " + mbProfile.photoType)
		  if (!mbProfile.save()) {
		    log.debug("Some error")
		    return;
		  }
		  break
	  default:
	  	break
	  }
	render([status:1, msg:"Image uploaded succesfully!!"] as JSON)
}

def showImage = {
  def mbProfile = MbProfile.get(params.id)
  if(!mbProfile)
  	{
	    response.sendError(404)
	    return;
  	}
  switch(params.imgtype) {
  	case 'fv':
	  def avatarUser = mbProfile.candidate
	  if (!avatarUser || !avatarUser.avatar || !avatarUser.avatarType) {
	    response.sendError(404)
	    return;
	  }
	  response.setContentType(avatarUser.avatarType)
	  response.setContentLength(avatarUser.avatar.size())
	  OutputStream out = response.getOutputStream();
	  out.write(avatarUser.avatar);
	  out.close();
  	  break
  	case 'sv':
	  if(mbProfile.photoType) {
		  response.setContentType(mbProfile.photoType)
		  response.setContentLength(mbProfile.photo.size())
		  OutputStream out = response.getOutputStream();
		  out.write(mbProfile.photo);
		  out.close();
	  }
	  break
	default:
	  break  	
  }
  return
}

    def markProfileComplete() {
    	Individual cand = Individual.get(session.individualid)
    	def mbProfile = MbProfile.findByCandidate(cand)
    	mbProfile.profileStatus = "COMPLETE"
    	if(!mbProfile.save())
    		mbProfile.errors.allErrors.each {println it}
    	render(view: "editProfile", model: [mbProfile: mbProfile])
    }


    def jq_mbManageProfile_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = MbProfile.createCriteria().list(max:maxRows, offset:rowOffset) {
		order(sortIndex, sortOrder)
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.candidate.icsid,
            	    it.candidate?.toString(),
            	    IndividualCentre.findByIndividual(it.candidate)?.centre,
            	    VoiceContact.findByCategoryAndIndividual('CellPhone',it.candidate)?.number,
            	    it.profileStatus,
            	    it.workflowStatus,
            	    it.matchMakingStatus,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def jq_mbProfile_list = {
        log.debug("jq_mbProfile_list:"+params)
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def mbprofile = MbProfile.get(params.mbProfileId)
      
      def result = []
      

        if(mbprofile)
        {
		result = MbProfile.createCriteria().list(max:maxRows, offset:rowOffset) {
			eq('workflowStatus','APPROVED')
		    ne('id',mbprofile.id)

		    //check for opposite gender
		    if(mbprofile.candidate?.isMale)
			candidate{eq('isMale',false)}
		    else
			candidate{eq('isMale',true)}
			
		if(!params.showAll) {

		    //check for chanting preference
		    if(params.flexibleChanting){

		    }

		    if(params.flexibleSpMaster=="false" && params.prefSpMaster){
		       and {eq('spiritualMaster',params.prefSpMaster,[ignoreCase: true])}
		    }

		    if(params.flexibleCentre=="false" && params.prefCentre){
			def valList = params.prefCentre.split(',')
		       and {candidate{'in'('iskconCentre',valList)}}
		    }

		    if(params.flexibleNationality=="false" && params.prefNationality){
		       and {candidate{eq('nationality',params.prefNationality,[ignoreCase: true])}}
		    }

		    if(params.flexibleOrigin=="false" && params.prefOrigin){
			and {candidate{'in'('origin',params.prefOrigin)}}
		    }

		    if(params.flexibleVarna=="false" && params.prefVarna){
		       and {candidate{'in'('varna',params.prefVarna)}}
		    }

		    if(params.flexibleCategory=="false" && params.prefCategory){
			and {eq('scstCategory',params.prefCategory,[ignoreCase: true])}
		    }

		    if(params.flexibleCaste=="false" && params.prefCaste){
			def valList = params.prefCaste.split(',')
			and {candidate{'in'('caste',valList)}}
		    }

		    if(params.flexibleSubcaste=="false" && params.prefSubCaste){
			def valList = params.prefSubCaste.split(',')
			and {candidate{'in'('subCaste',valList)}}
		    }

		    if(params.flexibleLangknown=="false" && params.prefLangKnown){
			and {'in'('languagesKnown',params.prefLangKnown)}
		    }

		    if(params.flexibleEducationCat){}

		    if(params.flexibleAgediff){}

		    if(params.flexibleHeight=="false"){}

		    if(params.flexibleCandidateIncome){}

		    if(params.flexibleManglik=="false" && params.prefManglik){
			and {'in'('manglik',params.prefManglik)}
		    }

		    if(params.flexibleQualifications){}
		    
		    }

		    order(sortIndex, sortOrder)
		}
	}

      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.candidate?.toString(),
            	    it.candidate?.dob?.format('dd-MM-yyyy'),
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }
    
    def jq_prospects_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

    	Individual cand = Individual.get(session.individualid)
    	def mbprofile = MbProfile.findByCandidate(cand)
      
      def totalRows = mbprofile?.matches?.size()
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = mbprofile?.matches?.findAll{it.candidateStatus==null || it.candidateStatus!='DECLINE'}?.sort{it.prospect?.candidate?.legalName}?.collect {
            [cell: [
            	    it.prospect?.candidate?.legalName,
            	    it.prospect?.candidate?.initiatedName,
            	    it.prospect?.candidate?.dob?.format('dd-MM-yyyy'),
			it.prospect?.candidate?.pob,
			it.prospect?.candidate?.dob?.format('HH:mm:ss'),
			it.prospect?.candidate?.iskconCentre,
			it.prospect.candCounsellor,
			it.prospect?.candidate?.origin,
			it.prospect?.candidate?.varna,
			it.prospect.scstCategory,
			it.prospect.candidate?.caste,
			it.prospect.candidate?.subCaste,
			it.prospect.candidate?.height,
			it.prospect.candidate?.motherTongue,
			it.prospect.candidate?.income,
			it.prospect.eduCat,
			it.prospect.eduQual,
			it.prospect.regulated,
			it.prospect.numberOfRounds,
			it.prospect.chantingSixteenSince,
			it.candidateStatus
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:1,records:totalRows,total:1]
        render jsonData as JSON
        }
    
    def jq_mbProspect_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def mbprofile = MbProfile.get(params.candidateid)
      
      def totalRows = mbprofile?.matches?.size()
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = mbprofile?.matches?.collect {
            [cell: [
            	    it.prospect?.candidate?.toString(),
            	    it.prospect?.candidate?.dob?.format('dd-MM-yyyy'),
            	    it.candidateStatus,
            	    it.candidateReason,
            	    it.mbStatus,
            	    it.mbReason            	    
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:1,records:totalRows,total:1]
        render jsonData as JSON
        }

    def updateProfileStatus() {
	def retVal = MbService.updateProfileStatus(params)
	if (retVal>0) {
	    flash.message = "ProfileStatus updated succesfully..."
	}
	else {
	    flash.message = "Some error occurred while updating ProfileStatus..Pls contact admin with errorcode MB"+retVal
	}  	
	    redirect(action: "manage")
  }
  
    def upload() {
	    def f = request.getFile('myFile')
	    if (f.empty) {
		flash.message = 'file cannot be empty'
		render(view: 'manage')
		return
	    }

	    int i=-1
	    def ts = new Date().format('dd-MM-yyyy HH:mm:ss')
	    
	    f.inputStream.toCsvReader().eachLine{ tokens ->
	    	i++
	    	if(i==0)
	    		dataService.storeHeader('MB',tokens)
	    	else
	    		dataService.storeValues('MB-'+ts,new Long(i),tokens)
	    }
	    
	    flash.message = i+' records processed!!'
	    redirect (action: "manage")
    }
    
    def createProfileFromAttrs() {
	def idList = params.objectId.tokenize(',')
	idList.each{
		mbService.createProfileFromAttrs(params.objectClassName,new Long(it))
    		}
	redirect(action: "manage")
    }
    
    def propose() {
    	log.debug("proposing.."+params)
	mbService.propose(params)
	render([status:"OK"] as JSON)    	
    }
    
    def prospects() {
    }
    
    def prospectsNextStep() {
    	def match = MbProfileMatch.get(params.matchid)
    	switch(params.status) {
    		case 'PROCEED':
    			match.candidateStatus='PROCEED'
    			break
    		case 'DECLINE':
    			match.candidateStatus='DECLINE'
    			match.candidateReason = params.reason
    			break
    		default:
    			break
    	}
    	if(!match.save())
		match.errors.each { log.debug("match:"+it)}  
	else
		render([status:"OK"] as JSON)
    	
    }    
    
}
