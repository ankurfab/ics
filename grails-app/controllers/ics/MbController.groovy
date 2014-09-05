package ics

import grails.converters.JSON

class MbController {

    def MbService
    
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
            redirect(action: "search")
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
      def sortIndex = params.sidx ?: 'regNum'
      def sortOrder  = params.sord ?: 'asc'

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
            	    it.matchMakingStatus,
            	    it.workflowStatus,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def jq_mbProfile_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = MbProfile.createCriteria().list(max:maxRows, offset:rowOffset) {
		if(params.name) {
			candidate{
				or{
					ilike('legalName',params.name)
					ilike('initiatedName',params.name)
				}
			}
		}
		order(sortIndex, sortOrder)
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.candidate?.toString(),
            	    it.candidate?.dob?.format('dd-MM-yyyy HH:mm:ss'),
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
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
    
}
