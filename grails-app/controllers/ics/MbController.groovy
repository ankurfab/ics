package ics

import grails.converters.JSON
import java.util.zip.ZipOutputStream  
import java.util.zip.ZipEntry  
import org.grails.plugins.csv.CSVWriter
import org.apache.commons.lang.StringEscapeUtils.*
import groovy.time.TimeCategory


class MbController {

    def MbService
    def dataService
    def individualService
    def springSecurityService
    
    def index = { redirect(action: "manage", params: params) }

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
		  f = request.getFile('imgFileFV')
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
  	case 'sv':
	  if(mbProfile.photoType) {
		  response.setContentType(mbProfile.photoType)
		  response.setContentLength(mbProfile.photo.size())
		  OutputStream out = response.getOutputStream();
		  out.write(mbProfile.photo);
		  out.close();
	  }
	  break
  	case 'fv':
	default:
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
  }
  return
}

    def markProfileComplete() {
    	Individual cand = Individual.get(session.individualid)
    	def mbProfile = MbProfile.findByCandidate(cand)
    	mbProfile.profileStatus = "SUBMITTED"
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
		if(params.icsid)
			candidate{eq('icsid',new Long(params.icsid))}
		if(params.name)
			candidate{ilike('legalName',params.name)}
		if(params.referrerCenter)
			eq('referrerCenter',params.referrerCenter)
		if(params.contactNumber)
			candidate{voiceContact{eq('number',params.contactNumber)}}
		if(params.assignedTo)
			assignedTo{ilike('legalName',params.assignedTo)}
		if(params.profileStatus)
			eq('profileStatus',params.profileStatus)
		if(params.workflowStatus)
			eq('workflowStatus',params.workflowStatus)
		
		order(sortIndex, sortOrder)
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.id,
            	    it.candidate.icsid,
            	    it.candidate?.toString(),
            	    //@TODO: need to figure out IndividualCentre.findByIndividual(it.candidate)?.centre,
            	    it.referrerCenter,            	    
            	    VoiceContact.findByCategoryAndIndividual('CellPhone',it.candidate)?.number,
            	    it.assignedTo?.toString(),
            	    it.profileStatus,
            	    it.workflowStatus,
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
            eq('workflowStatus', 'AVAILABLE')
            ne('id', mbprofile.id)

            //check for opposite gender
            if (mbprofile.candidate?.isMale)
                candidate { eq('isMale', false) }
            else
                candidate { eq('isMale', true) }

            if (!params.showAll) {

                //check for chanting preference
                if (params.flexibleChanting) {
                }

                if (params.flexibleSpMaster == "false" && params.prefSpMaster) {
                    def valList = params.prefSpMaster.split(',')
                    and { 'in'('spiritualMaster', valList) }
                }

                if (params.flexibleCentre == "false" && params.prefCentre) {
                    def valList = params.prefCentre.split(',')
                    and { candidate { 'in'('iskconCentre', valList) } }
                }

                if (params.flexibleNationality == "false" && params.prefNationality) {
                    and { candidate { eq('nationality', params.prefNationality, [ignoreCase: true]) } }
                }

                if (params.flexibleCulturalInfluence == "false" && params.prefCulturalInfluence) {
                    and { 'in'('culturalInfluence', params.prefCulturalInfluence) }
                }

                if (params.flexibleVarna == "false" && params.prefVarna) {
                    and { candidate { 'in'('varna', params.prefVarna) } }
                }

                if (params.flexibleCategory == "false" && params.prefCategory) {
                    and { 'in'('scstCategory', params.prefCategory) }
                }

                if (params.flexibleCaste == "false" && params.prefCaste) {
                    def valList = params.prefCaste.split(',')
                    and { candidate { 'in'('caste', valList) } }
                }

                if (params.flexibleSubcaste == "false" && params.prefSubCaste) {
                    def valList = params.prefSubCaste.split(',')
                    and { candidate { 'in'('subCaste', valList) } }
                }

                if (params.flexibleLangknown == "false" && params.prefLangKnown) {
                    //and {'in'('languagesKnown',params.prefLangKnown)}
                }

                if (params.flexibleEducationCat == "false" && params.prefeducationCategory) {
                    ArrayList<String> categories = new ArrayList<>(Arrays.asList('SSC (or equivalent)', 'HSC (or equivalent)', 'Undergraduate', 'Diploma(or equivalent)', 'Graduate', 'Post Graduate', 'Doctorate'));
                    def pos = categories.indexOf(params.prefeducationCategory)
                    categories = categories.subList(pos,categories.size())
                    and {'in'('eduCat',categories)}
                }

                if (params.flexibleAgediff == "false" && params.prefAgeDiff) {
                    use(TimeCategory) {
                        def dobLower, dobUpper
                        if (mbprofile.candidate?.isMale) {
                            dobLower = Date.parse('dd-MM-yyyy hh:mm:ss', (mbprofile.candidate?.dob + Integer.parseInt(params.prefAgeDiff.split(" - ")[0]).years).format('dd-MM-yyyy hh:mm:ss'))
                            dobUpper = Date.parse('dd-MM-yyyy hh:mm:ss', (mbprofile.candidate?.dob + Integer.parseInt(params.prefAgeDiff.split(" - ")[1]).years).format('dd-MM-yyyy hh:mm:ss'))
                        } else {
                            dobLower = Date.parse('dd-MM-yyyy hh:mm:ss', (mbprofile.candidate?.dob - Integer.parseInt(params.prefAgeDiff.split(" - ")[1]).years).format('dd-MM-yyyy hh:mm:ss'))
                            dobUpper = Date.parse('dd-MM-yyyy hh:mm:ss', (mbprofile.candidate?.dob - Integer.parseInt(params.prefAgeDiff.split(" - ")[0]).years).format('dd-MM-yyyy hh:mm:ss'))
                        }
                        and { candidate { between('dob', dobLower, dobUpper) } }
                    }
                }

                if (params.flexibleHeight == "false" && params.prefHeight) {
                    and {
                        candidate {
                            between('height', MbService.getHeight(params.prefHeight.split(" - ")[0]), MbService.getHeight(params.prefHeight.split(" - ")[1]))
                        }
                    }
                }

                if (params.flexibleCandidateIncome == "false" && params.prefCandIncome) {
                    def lowerLimit = Integer.parseInt(params.prefCandIncome.split(" - ")[0])
                    def upperLimit = Integer.parseInt(params.prefCandIncome.split(" - ")[1])
                    ArrayList<String> incomeList = new ArrayList<String>();
                    for (int i = lowerLimit; i <= upperLimit; i++)
                        incomeList.add(i.toString() + ' Lakhs');
                    and { candidate { 'in'('income', incomeList) } }
                }

                if (params.flexibleManglik == "false" && params.prefManglik) {
                    def valList = params.prefManglik.split(',')
                    and { 'in'('manglik', valList) }
                }

                if (params.flexibleQualifications == "false" && params.prefqualification) {
                    def valList = params.prefqualification.split(',')
                    and { 'in'('eduQual', valList) }
                }

                order(sortIndex, sortOrder)
            }
        }
	}

      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.id,
            	    it.candidate?.toString(),
            	    it.referrerCenter,
            	    it.assignedTo?.toString(),
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

      //def jsonCells = mbprofile?.matches?.findAll{it.candidateStatus==null || it.candidateStatus!='DECLINE'}?.sort{it.prospect?.candidate?.legalName}?.collect {
      def jsonCells = mbprofile?.matches?.sort{it.lastUpdated}?.collect {
            [cell: [
            	    it.prospect.id,
            	    it.candidateStatus,
            	    it.prospect?.workflowStatus,
            	    it.lastUpdated?.format('dd-MM-yyyy HH:mm:ss'),
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
			it.candidateStatus,
			it.mbStatus
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

      //def jsonCells = mbprofile?.matches?.collect {
      def jsonCells = mbprofile?.matches?.sort{it.lastUpdated}?.collect {
            [cell: [
            	    it.prospect.id,
            	    it.prospect?.candidate?.toString(),
            	    it.prospect?.workflowStatus,
            	    it.stage,
            	    it.candidateStatus,
            	    it.candidateReason,
            	    it.candidateDate?.format('dd-MM-yyyy HH:mm-ss'),
            	    it.mbStatus,
            	    it.mbReason,
            	    it.mbDate?.format('dd-MM-yyyy HH:mm-ss')            	    
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:1,records:totalRows,total:1]
        render jsonData as JSON
        }

    def updateProfileStatus() {
	def retmsg = MbService.updateProfileStatus(params)
	flash.message = retmsg
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
    
    def suggest() {
    	log.debug("suggesting.."+params)
	mbService.suggest(params)
	render([status:"OK"] as JSON)    	
    }
    
    def propose() {
    	log.debug("proposing.."+params)
	mbService.propose(params)
	render([status:"OK"] as JSON)    	
    }
    
    def announce() {
    	log.debug("announcing.."+params)
	mbService.announce(params)
	render([status:"OK"] as JSON)    	
    }

    def prospects() {
    }
    
    def prospectsNextStep() {
    	def match = MbProfileMatch.get(params.matchid)
    	switch(params.status) {
    		case 'MEET_PROSPECT':
    			match.candidateStatus='MEET_PROSPECT'
    			match.candidateReason=''
    			//check from the other party
    			def otherMatch = MbProfileMatch.findByCandidateAndProspect(match.prospect,match.candidate)
    			if(otherMatch && otherMatch.candidateStatus=='MEET_PROSPECT') {
    				//update workflow status for both
    				match.candidate.workflowStatus = 'BOYGIRLMEET'
    				if(!match.candidate.save())
    					match.candidate.errors.allErrors.each {log.debug("BOYGIRLMEET:"+it)}
    				otherMatch.candidate.workflowStatus = 'BOYGIRLMEET'
    				if(!otherMatch.candidate.save())
    					otherMatch.candidate.errors.allErrors.each {log.debug("BOYGIRLMEET:"+it)}
    			}    				
    			break
    		case 'MEET_PARENT':
    			match.candidateStatus='MEET_PARENT'
    			match.candidateReason=''
    			//check from the other party
    			def otherMatch = MbProfileMatch.findByCandidateAndProspect(match.prospect,match.candidate)
    			if(otherMatch && otherMatch.candidateStatus=='MEET_PARENT') {
    				//update workflow status for both
    				match.candidate.workflowStatus = 'PARENTSMEET'
    				if(!match.candidate.save())
    					match.candidate.errors.allErrors.each {log.debug("PARENTSMEET:"+it)}
    				otherMatch.candidate.workflowStatus = 'PARENTSMEET'
    				if(!otherMatch.candidate.save())
    					otherMatch.candidate.errors.allErrors.each {log.debug("PARENTSMEET:"+it)}
    			}    				
    			break
    		case 'AGREE_PROPOSAL':
    			match.candidateStatus='AGREE_PROPOSAL'
    			match.candidateReason=''
    			//check from the other party
    			def otherMatch = MbProfileMatch.findByCandidateAndProspect(match.prospect,match.candidate)
    			if(otherMatch && otherMatch.candidateStatus=='AGREE_PROPOSAL') {
    				//update workflow status for both
    				match.candidate.workflowStatus = 'PROPOSALAGREED'
    				if(!match.candidate.save())
    					match.candidate.errors.allErrors.each {log.debug("PROPOSALAGREED:"+it)}
    				otherMatch.candidate.workflowStatus = 'PROPOSALAGREED'
    				if(!otherMatch.candidate.save())
    					otherMatch.candidate.errors.allErrors.each {log.debug("PROPOSALAGREED:"+it)}
    			}    				
    			break
    		case 'PROCEED':
    			match.candidateStatus='PROCEED'
    			match.candidateReason=''
    			break
    		case 'DECLINE':
    			match.candidateStatus='DECLINE'
    			match.candidateReason = params.reason
    			break
    		default:
    			break
    	}
    	match.candidateDate = new Date()
    	if(!match.save())
		match.errors.each { log.debug("match:"+it)}  
	else
		render([status:"OK"] as JSON)
    	
    }
    
    def manageBoard()  {}
    
    def configureCentres() {
    	log.debug("Inside configure centers:"+params)
    	def result = mbService.configureCentres(params)
    	render result
    }

    def jq_mb_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = Individual.createCriteria().list(max:maxRows, offset:rowOffset) {
		eq('category','MB_BOARD')
		if (params.icsid)
			eq('icsid',params.icsid)
		if (params.name)
			ilike('legalName',params.name)
		if (params.phone)
			VoiceContact{
				eq('category','CellPhone')
				eq('number',params.phone)
				}
		if (params.email)
			EmailContact{
				eq('category','Personal')
				eq('emailAddress',params.emailAddress)
				}
		if (params.centre)
			eq('iskconCentre',params.centre)
		if (params.role)
			individualRoles{
				role{
					eq('category','MarriageBoard')
					eq('name',params.role)
					}
				}

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.icsid,
            	    it.toString(),
            	    VoiceContact.findByIndividualAndCategory(it,'CellPhone')?.number,
            	    EmailContact.findByIndividualAndCategory(it,'Personal')?.emailAddress,
            	    it.iskconCentre,
            	    it.individualRoles?.collect{it?.role?.name},
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_mb = {
	      log.debug('In jq_edit_mb:'+params)
	      def individual = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  if(mbService.addBoardMember(params)) {
			    message = "Individual Saved.."
			    id = individual.id
			    state = "OK"
		  }
		  else {
			    message = "Could Not Save Individual"
		  }		  	
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check individual exists
			  individual  = Individual.get(it)
			  if (individual) {
			    // delete individual
			    if(!individual.delete())
			    	{
				    individual.errors.allErrors.each {
					log.debug("In jq_individual_edit: error in deleting individual:"+ it)
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
		  // first retrieve the individual by its ID
		  individual = Individual.get(params.id)
		  if (individual) {
		    // set the properties according to passed in parameters
		    individual.properties = params
			  individual.updator = springSecurityService.principal.username
		    if (! individual.hasErrors() && individual.save()) {
		      message = "Individual  ${individual.regNum} Updated"
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

    def assign() {
    	log.debug("inside assign:"+params)
    	def profile = MbProfile.get(params.profileid)
    	if(profile && profile.profileStatus=='COMPLETE' && profile.workflowStatus=='UNASSIGNED')
    		{
    			//find members from the relevant centres
    			def members = Individual.createCriteria().list(){
    					eq('category','MB_BOARD')
    					individualRoles{
    							role{
    								eq('category','MarriageBoard')
    								eq('name','MEMBER')
    							}
    						}
    				}
    			render(template: "assign", model: [profile:profile, members: members])
    		}
	else
		render "No complete and unassigned profile found with the specified id. Kindly contact admin!!"
    }

    def assignProfile() {
    	log.debug("inside assignProfile:"+params)
    	def retmsg = MbService.assignProfile(params)
	render ([message:retmsg] as JSON)
    }
    
    def fullProfile() {
    	log.debug("Inside fullProfile:"+params)
    	def match = MbProfileMatch.get(params.matchid)
    	if(match && match.mbStatus=='FULLPROFILE' && match.candidate.candidate.loginid==springSecurityService.principal.username) {    		    		
    		render(template: "fullProfile", model: [profile: match.prospect.candidate])
    	}
    	else
    		render "Unavailable!!"
    	
    }
    
    def dashboard() {
    	[stats:MbService.stats()]
    }
    
    def changeWorkflowStatus() {
    	def ret = MbService.changeWorkflowStatus(params)
    	render ([message:ret] as JSON)
    }

    def report() {}
    
    def showReportResult() {
    	log.debug("Inside showReportResult with params : "+params)	    	
    	render(template: params.reportName)
    }
    
    def jq_workflowStatus_list() {
          def sortIndex = params.sidx ?: 'id'
          def sortOrder  = params.sord ?: 'desc'
    
          def maxRows = Integer.valueOf(params.rows)
          def currentPage = Integer.valueOf(params.page) ?: 1
    
          def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
          
          if(params.oper=="excel" )
          		{
          			maxRows = 100000
          			rowOffset = 0
          			sortIndex = "id"
          			sortOrder = "asc"
    		}
    
    
    	def result = MbProfile.createCriteria().list(max:maxRows, offset:rowOffset) {
    				
    		    
    	if(params.db)
    		eq('category',params.db)
    	if(params.centre)
    		eq('referrerCenter',params.centre)
    	if(params.gender) {
    		if(params.gender=='BOY')
    			candidate{eq('isMale',true)}
    		else
    			candidate{eq('isMale',false)}
    		}
    	if(params.workflowStatus)
    		eq('workflowStatus',params.workflowStatus)
    	if(params.name)
    		candidate{
    			or{
    			ilike('legalName',params.name)
    			ilike('initiatedName',params.name)
    			}
    		}
    
    
    	order(sortIndex, sortOrder)
    	}
          
          def totalRows = result.totalCount
          def numberOfPages = Math.ceil(totalRows / maxRows)
          
         
         if(params.oper=="excel")
            {
         
    	def fileName = "mbworkflowstatus_"+new Date().format('ddMMyyyyHHmmss')+".csv"
    	response.contentType = 'application/zip'
    	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
    	zipOutputStream.putNextEntry(new ZipEntry(fileName))
    	
    	zipOutputStream << "DB,Centre,Gender,WorkflowStatus,Name" 
    	def sno = 0
    	result.each{ row ->
    	sno++
    	zipOutputStream <<"\n"
    	zipOutputStream <<(row.category?:'') +","+
    	(row.referrerCenter?:'') +","+
    	(row.candidate.isMale?'Boy':'Girl') +","+
    	(row.workflowStatus?:'') +","+
    	(row.candidate.toString()) 
    	    }
    	 }    		
    	return
    		 }
        else
    	{
          
          def jsonCells
          jsonCells = result.collect {
                [cell: [
                	    it.category,
                	    it.referrerCenter,
                	    it.candidate.isMale?'Boy':'Girl',
                	    it.workflowStatus,
                	    it.candidate.toString(),
                    ], id: it.id]
            }
            def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
            render jsonData as JSON
            }
    }
    

    
}
