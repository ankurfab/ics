package ics

import grails.converters.JSON

import javax.imageio.ImageIO
import java.util.zip.ZipOutputStream
import java.util.zip.ZipEntry  
import org.grails.plugins.csv.CSVWriter
import org.apache.commons.lang.StringEscapeUtils.*
import groovy.time.TimeCategory
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.grails.plugins.imagetools.*


class MbController {

    def MbService
    def dataService
    def individualService
    def springSecurityService
    def commsService
    
    def index = {

    }
    def mbLogin = {

    }
    
    def home() {
    	if(SpringSecurityUtils.ifAllGranted('ROLE_MB_CANDIDATE'))
    		render (view: "chome")
    	else
    		redirect(action:"dashboard")
    }
    
    
    def pendingApprovals = {
        def centre = Individual.get(session.individualid)?.iskconCentre?:''
        def objIds = AttributeValue.withCriteria {
            if(SpringSecurityUtils.ifAllGranted('ROLE_MB_SEC')) {
            	attribute{
            		eq('domainClassName','TempMbProfile')
            		eq('name','refCentre')
            	}
            	eq('value',centre)
            }
            eq('objectClassName','TempMbProfile')
            projections {
                distinct("objectId")
            }
        }
        def paramsArr = []
        objIds.each {
            def Map params = [:]
            params.put("objId",it)
            def attrVals = AttributeValue.findAllByObjectId(it)
            attrVals.each {
                params.put(it.attribute.name,it.value)
            }
            paramsArr.push(params)
        }
        [profiles: paramsArr]
    }

    def approveProfile = {
        mbService.initiateProfile(params)
        deleteTempProfile(params)
    }

    def deleteTempProfile =  {
        def idToDelete = Long.parseLong(params.profId)
        if(params.profDenied) {
            def contentParams = [params.donorName]
            commsService.sendComms('MarriageBoard', "PROFILE_START_DENIED", params.donorName, params.donorContact, params.donorEmail, contentParams)
        }
        AttributeValue.executeUpdate("delete AttributeValue where objectId=:objId",[objId:idToDelete])
        redirect(action:"pendingApprovals")
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [mbInstanceList: Mb.list(params), mbInstanceTotal: Mb.count()]
    }

    def startProfile = {
        log.debug("startProfile:"+params)
	    params.remove("action")
	    params.remove("controller")
	    dataService.storeHeader('TempMbProfile',params.keySet())
	    def objId = System.currentTimeMillis()
        def result = AttributeValue.createCriteria().list{
            attribute{
            	eq('domainClassName','TempMbProfile')
            	eq('name','donorContact')
            }
            eq("value",params.donorContact)
        }
        def result1 = AttributeValue.createCriteria().list{
            attribute{
            	eq('domainClassName','TempMbProfile')
            	eq('name','donorEmail')
            }
            eq("value",params.donorEmail)
        }
        if(result.isEmpty() && result1.isEmpty()) {
            dataService.storeValues('TempMbProfile', objId, params)
            render(view: "mbLogin", model: [textMsg: "Your Profile has been created successfully and sent to Marriage Board for approval. Once approved you will receive an update from us to complete your profile."])
        }
        else
        {
            render(view: "mbLogin", model: [textMsg: "We are sorry but we already have your profile under pending approval status. Please wait while it is processed and approved."])
        }
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
            if(params.formSubmit){
                def img1 = Image.findByImageTypeAndEntityId('closePrim',mbProfile.id)
                def img2 = Image.findByImageTypeAndEntityId('fullPrim',mbProfile.id)
                if(img1 && img2) {
                    markProfileComplete()
                    flash.message = "Profile Submitted succesfully..."
                    redirect(action: "editProfile")
                }
                else{
                    flash.message = '<div class=\"message\" role=\"status\" style=\"color:red\">Either your closeup or full profile primary image is missing. Please upload these to be able to submit your profile.</div>'
                    redirect(action: "editProfile")
                }
            }
            else {
                flash.message = "Profile updated succesfully..."
                redirect(action: "editProfile")
            }
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
        def imageObj
        def mbProfile = MbProfile.findByCandidate(cand)
        def imageTool = new ImageTool()
        def appDir = servletContext.getRealPath("/")
        File fileDest = new File(appDir,"images/tempImg"+session.individualid+".jpg")
	  // Save the image and mime type
	    render([status:1, msg:"Image uploaded succesfully!!"] as JSON)
    switch (params.imgType) {
        case 'closePrim':
            imageObj = Image.findByImageTypeAndEntityId('closePrim',mbProfile.id)
            if (!imageObj) {
                imageObj = new Image()
            }
            def temp = request.getFile('closeUpPrimInput')
            temp.transferTo(fileDest)
            break
        case 'closeSec':
            imageObj = Image.findByImageTypeAndEntityId('closeSec',mbProfile.id)
            if (!imageObj) {
                imageObj = new Image()
            }
            def temp = request.getFile('closeUpSecInput')
            temp.transferTo(fileDest)
            break
        case 'fullPrim':
            imageObj = Image.findByImageTypeAndEntityId('fullPrim',mbProfile.id)
            if (!imageObj) {
                imageObj = new Image()
            }
            def temp = request.getFile('fullPrimInput')
            temp.transferTo(fileDest)
            break
        case 'fullSec':
            imageObj = Image.findByImageTypeAndEntityId('fullSec',mbProfile.id)
            if (!imageObj) {
                imageObj = new Image()
            }
            def temp = request.getFile('fullSecInput')
            temp.transferTo(fileDest)
            break
    }
        imageTool.load(fileDest.getBytes())
        imageTool.thumbnail(500)
        imageTool.writeResult(appDir+"/images/tempImgSmall"+session.individualid+".jpg","JPEG")
        def f = new File(appDir+"/images/tempImgSmall"+session.individualid+".jpg")
        imageObj.imageData = f.getBytes()
        imageObj.creator = imageObj.updator = springSecurityService.principal.username
        imageObj.imageType = params.imgType
        imageObj.entityId = mbProfile.id
        imageObj.entity = 'mbProfile'
        imageObj.type = 'image/jpeg'
        fileDest.delete()
        f.delete()
        // Validation works, will check if the image is too big
        if (!imageObj.save()) {
            log.debug("Some error")
            return;
        }
}

def showImage = {
  def image = Image.findByImageTypeAndEntityId(params.imgType,params.entityId)
  if(!image)
  	{
	    response.sendError(404)
	    return;
  	}
  switch(image.imageType) {
  	case 'closePrim':
		  response.setContentType(image.type)
		  response.setContentLength(image.imageData.size())
		  OutputStream out = response.getOutputStream();
		  out.write(image.imageData);
		  out.close();
	  break
  	case 'closeSec':
		  response.setContentType(image.type)
		  response.setContentLength(image.imageData.size())
		  OutputStream out = response.getOutputStream();
		  out.write(image.imageData);
		  out.close();
	  break
  	case 'fullPrim':
		  response.setContentType(image.type)
		  response.setContentLength(image.imageData.size())
		  OutputStream out = response.getOutputStream();
		  out.write(image.imageData);
		  out.close();
	  break
  	case 'fullSec':
		  response.setContentType(image.type)
		  response.setContentLength(image.imageData.size())
		  OutputStream out = response.getOutputStream();
		  out.write(image.imageData);
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
		if(params.loginid)
			candidate{eq('loginid',params.loginid)}
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
            	    it.candidate.loginid,
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
                    and { 'in'('spiritualMaster', params.prefSpMaster) }
                }

                if (params.flexibleCentre == "false" && params.prefCentre) {
                    def valList = params.prefCentre.split(',')
                    and { candidate { 'in'('iskconCentre', valList) } }
                }

                if (params.flexibleCurrentCountry == "false" && params.prefCurrentCountry) {
                    and { candidate { eq('nationality', params.prefCurrentCountry, [ignoreCase: true]) } }
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
                    ArrayList<String> categories = new ArrayList<>(Arrays.asList('SSC (10th equivalent)', 'HSC (12th equivalent)', 'Undergraduate', 'Diploma(or equivalent)', 'Graduate', 'Post Graduate', 'Doctorate'));
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
                it.prospect?.candidate?.legalName,
                it.prospect?.candidate?.dob?.format('dd-MM-yyyy'),
                it.prospect?.candidate?.pob,
                it.prospect?.candidate?.dob?.format('HH:mm:ss'),
                it.prospect.candidate?.caste,
                it.prospect.candidate?.height,
                it.prospect.candidate?.income,
                it.candidateStatus,
                it.mbStatus,
                it.id
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
            	    it.candidateStatus,
            	    it.candidateReason,
            	    it.candidateDate?.format('dd-MM-yyyy HH:mm:ss'),
            	    it.mbStatus,
            	    it.mbReason,
            	    it.mbDate?.format('dd-MM-yyyy HH:mm:ss')
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
	    	else {
                def objId = AttributeValue.createCriteria().get{
                    projections {
                        max "objectId"
                    }
                } as Long
                objId = objId ? objId : 0
                dataService.storeValues('MB-' + ts, objId, tokens)
            }
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
    
    /*def propose() {
    log.debug("proposing.."+params)
	mbService.propose(params)
	render([status:"OK"] as JSON)    	
    }
    
    def announce() {
    	log.debug("announcing.."+params)
	mbService.announce(params)
	render([status:"OK"] as JSON)    	
    }*/

    def prospects() {
    }
    
    def prospectsNextStep() {
    	def match = MbProfileMatch.get(params.matchid)
        if(match.candidateStatus == match.mbStatus) {
            switch (match.candidateStatus) {
                case 'LIMITED PROFILE':
                    match.candidateStatus = 'FULL PROFILE'
                    break
                case 'FULL PROFILE':
                    match.candidateStatus = 'BOY GIRL MEET'
                    break
                case 'BOY GIRL MEET':
                    match.candidateStatus = 'PARENTS MEET'
                    break
                case 'PARENTS MEET':
                    match.candidateStatus = 'PROPOSAL AGREED'
                    break
                case 'PROPOSAL AGREED':
                    render([status: "Cannot go Further than proposal Agreed!!"] as JSON)
                default:
                    break
            }
            match.candidateDate = new Date()
            if (!match.save())
                match.errors.each { log.debug("match:" + it) }
        }
        /*else if(match.mbStatus == 'DECLINED'){
            render([status: "Sorry You Cannot Move Further. Match with this candidate is declined because: \n"+match.mbReason] as JSON)
        }*/
        else{
            render([status: "Sorry You Cannot Move Further. Your advance to next stage is still pending for approval with marriage board!!"] as JSON)
        }
    }

    def mbNextStep(){
        def match = MbProfileMatch.get(params.matchid)
        def otherMatch
        if(match.candidateStatus == 'DECLINED'){
            render([status: "Sorry! Cannot approve as candidate has declined. Please click on decline and close the match with proper reason."] as JSON)
        }
        else {
            switch (match.mbStatus) {
                case 'LIMITED PROFILE':
                    if (match.candidateStatus == 'FULL PROFILE') {
                        match.mbStatus = 'FULL PROFILE'
                        otherMatch = MbProfileMatch.findByCandidateAndProspect(match.prospect, match.candidate)
                        if (otherMatch && otherMatch.mbStatus == 'FULL PROFILE') {
                            otherMatch.candidate.workflowStatus = otherMatch.prospect.workflowStatus = "PROPOSED"
                            otherMatch.mbDate = new Date()
                        }
                    } else {
                        render([status: "Cannot Proceed!! Candidate still in Limited profile stage"] as JSON)
                    }
                    break
                case 'FULL PROFILE':
                    if (match.candidateStatus == 'BOY GIRL MEET') {
                        otherMatch = MbProfileMatch.findByCandidateAndProspect(match.prospect, match.candidate)

                        if (otherMatch && otherMatch.candidateStatus == 'BOY GIRL MEET') {
                            match.mbStatus = otherMatch.mbStatus = 'BOY GIRL MEET'
                            otherMatch.candidate.workflowStatus = otherMatch.prospect.workflowStatus = "BOYGIRLMEET"
                            otherMatch.mbDate = new Date()
                        } else {
                            render([status: "Cannot approve as the other candidate has not yet agreed to meet the candidate."] as JSON)
                        }
                    } else {
                        render([status: "Cannot Proceed!! Candidate still in full profile stage"] as JSON)
                    }
                    break
                case 'BOY GIRL MEET':
                    if (match.candidateStatus == 'PARENTS MEET') {
                        otherMatch = MbProfileMatch.findByCandidateAndProspect(match.prospect, match.candidate)

                        if (otherMatch && otherMatch.candidateStatus == 'PARENTS MEET') {
                            match.mbStatus = otherMatch.mbStatus = 'PARENTS MEET'
                            otherMatch.candidate.workflowStatus = otherMatch.prospect.workflowStatus = "PARENTSMEET"
                            otherMatch.mbDate = new Date()
                        }
                        else{
                            render([status: "Cannot approve as the other candidate has not yet agreed for the parents meeting."] as JSON)
                        }
                    } else {
                        render([status: "Cannot Proceed!! Candidate still in boy girl meet stage"] as JSON)
                    }
                    break
                case 'PARENTS MEET':
                    if (match.candidateStatus == 'PROPOSAL AGREED') {

                        otherMatch = MbProfileMatch.findByCandidateAndProspect(match.prospect, match.candidate)
                        if (otherMatch && otherMatch.candidateStatus == 'PROPOSAL AGREED') {
                            match.mbStatus = otherMatch.mbStatus = 'PROPOSAL AGREED'
                            otherMatch.candidate.workflowStatus = otherMatch.prospect.workflowStatus = "PROPOSALAGREED"
                            otherMatch.mbDate = new Date()
                        }
                        else{
                            render([status: "Cannot approve as the other candidate has not yet agreed to the proposal."] as JSON)
                        }
                    } else {
                        render([status: "Cannot Proceed!! Candidate still in parents meet stage"] as JSON)
                    }
                    break
                case 'PROPOSAL AGREED':
                    match.mbStatus = 'ANNOUNCE'
                    otherMatch = MbProfileMatch.findByCandidateAndProspect(match.prospect, match.candidate)
                    otherMatch.mbStatus = 'ANNOUNCE'
                    otherMatch.candidate.workflowStatus = otherMatch.prospect.workflowStatus = 'ANNOUNCE'
                    otherMatch.mbDate = new Date()
                    break
                case 'ANNOUNCE':
                    match.mbStatus = 'MARRIED THROUGH MB'
                    otherMatch = MbProfileMatch.findByCandidateAndProspect(match.prospect, match.candidate)
                    otherMatch.mbStatus = 'MARRIED THROUGH MB'
                    otherMatch.candidate.workflowStatus = otherMatch.prospect.workflowStatus = 'MARRIEDTHRUMB'
                    otherMatch.mbDate = new Date()
                    break
            }
            match.mbDate = new Date()
            if (!match.save())
                match.errors.each { log.debug("match:" + it) }
            render([status: ""] as JSON)
        }
    }

    def decline = {
        def match = MbProfileMatch.get(params.matchid)
        def otherMatch
        switch(params.origin) {
            case 'candidate':
                match.candidateStatus = 'DECLINED'
                match.candidateReason = params.reason
                match.candidateDate = new Date()
                break
            case 'mb':
                otherMatch = MbProfileMatch.findByCandidateAndProspect(match.prospect,match.candidate)
                if(otherMatch){
                    otherMatch.candidateStatus = 'DECLINED'
                    otherMatch.mbStatus = 'DECLINED'
                    otherMatch.mbReason = params.reason
                    otherMatch.mbDate = new Date()
                    if(!otherMatch.save())
                        match.errors.each { log.debug("match:"+it)}
                }
                match.candidateStatus = 'DECLINED'
                match.mbStatus = 'DECLINED'
                match.mbReason = params.reason
                match.candidate.workflowStatus = match.prospect.workflowStatus = 'AVAILABLE'
                match.mbDate = new Date()
                break
        }
        if(!match.save())
            match.errors.each { log.debug("match:"+it)}
        render([status:""] as JSON)
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
		if (params.loginid)
			eq('loginid',params.loginid)
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
            	    it.loginid,
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
		  individual = mbService.addBoardMember(params)
		  if(individual) {
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
		      message = "Individual  ${individual.icsid} Updated"
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

    def getProfileByStage(params){
        log.debug("Inside get profile by stage: "+params)
        def match = MbProfileMatch.get(params.matchid)
        if(match && match.candidate.candidate.loginid==springSecurityService.principal.username){
           if(match.mbStatus=='FULL PROFILE') {
               render(template: "fullProfile", model: [profile: match.prospect])
           }
           else if(match.mbStatus=='LIMITED PROFILE'){
               render(template: "limitedProfile", model: [profile: match.prospect])
           }
        }
        else{
            render "Error. The Profile is currently not available for view. Please get in touch with marriage board admin for more details or wite to rk.mb.system@gmail.com."
        }
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
    	//log.debug("Inside showReportResult with params : "+params)	    	
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
    
    def jq_varnaCategory_list() {
          def sortIndex = params.sidx ?: 'id'
          def sortOrder  = params.sord ?: 'desc'
    
          def maxRows = Integer.valueOf(params.rows)
          def currentPage = Integer.valueOf(params.page) ?: 1
    
          def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
              
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
    	if(params.nationality)
    		candidate{ilike('nationality',params.nationality)}
    	if(params.origin)
    		candidate{ilike('origin',params.origin)}
    	if(params.varna)
    		candidate{ilike('varna',params.varna)}
    	if(params.caste)
    		candidate{ilike('caste',params.caste)}
    	if(params.nationality)
    		candidate{ilike('nationality',params.nationality)}
    	if(params.subCaste)
    		candidate{ilike('subCaste',params.subCaste)}
    	if(params.scstCategory)
    		ilike('scstCategory',params.scstCategory)
    	if(params.manglik)
    		ilike('manglik',params.manglik)
    
    
    	order(sortIndex, sortOrder)
    	}
          
          def totalRows = result.totalCount
          def numberOfPages = Math.ceil(totalRows / maxRows)
          
         
          def jsonCells
          jsonCells = result.collect {
                [cell: [
                	    it.category,
                	    it.referrerCenter,
                	    it.candidate.isMale?'Boy':'Girl',
                	    it.workflowStatus,
                	    it.candidate.toString(),
                	    it.candidate.nationality,
                	    it.candidate.origin,
                	    it.candidate.varna,
                	    it.scstCategory,
                	    it.candidate.caste,
                	    it.candidate.subCaste,
                	    it.manglik,
                    ], id: it.id]
            }
            def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
            render jsonData as JSON
    }

    def jq_salientFeatures_list() {
          def sortIndex = params.sidx ?: 'id'
          def sortOrder  = params.sord ?: 'desc'
    
          def maxRows = Integer.valueOf(params.rows)
          def currentPage = Integer.valueOf(params.page) ?: 1
    
          def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
              
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
    	if(params.income)
    		candidate{ilike('income',params.income)}
    	if(params.languagesKnown)
    		ilike('languagesKnown',params.languagesKnown)
    	if(params.height)
    		candidate{ilike('height',params.height)}
    	if(params.weight)
    		ilike('weight',params.weight)
    	if(params.eduCat)
    		candidate{ilike('eduCat',params.eduCat)}
    	if(params.eduQual)
    		candidate{ilike('eduQual',params.eduQual)}
    	if(params.spiritualMaster)
    		ilike('spiritualMaster',params.spiritualMaster)    
    
    	order(sortIndex, sortOrder)
    	}
          
          def totalRows = result.totalCount
          def numberOfPages = Math.ceil(totalRows / maxRows)
          
         
          def jsonCells
          jsonCells = result.collect {
                [cell: [
                	    it.category,
                	    it.referrerCenter,
                	    it.candidate.isMale?'Boy':'Girl',
                	    it.workflowStatus,
                	    it.candidate.toString(),
                	    it.candidate.income,
                	    it.languagesKnown,
                	    it.candidate.height,
                	    it.weight,
                	    it.candidate.eduCat,
                	    it.candidate.eduQual,
                	    it.spiritualMaster
                    ], id: it.id]
            }
            def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
            render jsonData as JSON
    }

    def jq_rejectionReason_list() {
          def sortIndex = params.sidx ?: 'id'
          def sortOrder  = params.sord ?: 'desc'
    
          def maxRows = Integer.valueOf(params.rows)
          def currentPage = Integer.valueOf(params.page) ?: 1
    
          def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
          
    	def result = MbProfileMatch.createCriteria().list(max:maxRows, offset:rowOffset) {
    				
    	isNotNull('candidateReason')	    
    	if(params.db)
    		candidate{eq('category',params.db)}
    	if(params.centre)
    		candidate{eq('referrerCenter',params.centre)}
    	if(params.gender) {
    		if(params.gender=='BOY')
    			candidate{candidate{eq('isMale',true)}}
    		else
    			candidate{candidate{eq('isMale',false)}}
    		}
    	if(params.workflowStatus)
    		candidate{eq('workflowStatus',params.workflowStatus)}
    	if(params.name)
    		candidate{candidate{
    			or{
    			ilike('legalName',params.name)
    			ilike('initiatedName',params.name)
    			}
    		}}
    
    
    	order(sortIndex, sortOrder)
    	}
          
          def totalRows = result.totalCount
          def numberOfPages = Math.ceil(totalRows / maxRows)
          
         
          
          def jsonCells
          jsonCells = result.collect {
                [cell: [
                	    it.candidate.category,
                	    it.candidate.referrerCenter,
                	    it.candidate.candidate.isMale?'Boy':'Girl',
                	    it.candidate.candidate.toString(),
                	    it.candidate.workflowStatus,
                	    it.candidateStatus,
                	    it.candidateReason,
                	    it.candidateDate?.format('dd-MM-yy HH:mm:ss')
                    ], id: it.id]
            }
            def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
            render jsonData as JSON
    }
    
    def unlockAndResetUser() {
	def flag
	if(params.idlist) {
		def idList = params.idlist.tokenize(',')
		def individual
		idList.each{
			individual = Individual.get(it)
			if(individual.category=='MB_BOARD')
				flag = mbService.unlockAndResetUser(individual)
			}
    	}
    	else if(params.mbprofile_idlist) {
		def pidList = params.mbprofile_idlist.tokenize(',')
		def individual
		pidList.each{
			individual = MbProfile.get(it)?.candidate
			if(individual.category=='MB')
				flag = mbService.unlockAndResetUser(individual)
			}
    	}
	render([message:flag] as JSON)
    }
    
    def snapshot() {[centre:params.centre]}
    
    def genderwiseReport() {
		def result = mbService.genderwiseReport(params)
		render( result as JSON)
    }

    def candidateAttributeReport() {
		def result = mbService.candidateAttributeReport(params)
		render( result as JSON)
    }

    def mbProfileAttributeReport() {
		def result = mbService.mbProfileAttributeReport(params)
		render( result as JSON)
    }

    def forgotPassword ()    {

    }
    def activityStream() {}
    
    def resources() {}

    
}
