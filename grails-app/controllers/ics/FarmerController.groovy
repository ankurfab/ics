package ics
import grails.converters.JSON

class FarmerController {

    def receiptSequenceService
    def commsService
    def farmerService
    
    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [farmerInstanceList: Farmer.list(params), farmerInstanceTotal: Farmer.count()]
    }

    def create = {
        def farmerInstance = new Farmer()
        farmerInstance.properties = params
        return [farmerInstance: farmerInstance]
    }

    def save = {
        log.debug("Farmer:save:"+params)
        if(!params.irrigationFacility)
        	params.irrigationType = "None"
        if(params.district)
        	{
        	params.'district.id'=params.district
        	params.district=District.get(new Long(params.district))
        	}
        if(params.taluka)
        	{
        	params.'taluka.id'=params.taluka
        	params.taluka=Taluka.get(new Long(params.taluka))
        	}
        if(params.village)
        	{
        	params.'village.id'=params.village
        	params.village=Village.get(new Long(params.village))
        	}
        if(params.postVillage)
        	{
        	params.'postVillage.id'=params.postVillage
        	params.postVillage=Village.get(new Long(params.postVillage))
        	}

        def farmerInstance = new Farmer(params)

	try{
	//assign image
	  // Get the avatar file from the multi-part request
	  def f = request.getFile('avatar')
	  // List of OK mime-types
	  def okcontents = ['image/png', 'image/jpeg', 'image/gif']
	  if (f && okcontents.contains(f.getContentType())) {
		  // Save the image and mime type
		  farmerInstance.avatar = f.getBytes()
		  farmerInstance.avatarType = f.getContentType()
	  }
	  }
	  catch(Exception e){log.debug(e)}


        if (!farmerInstance.hasErrors() && farmerInstance.save()) {
        	//auto-generate share cert no
        	if(Share.countByStatusIsNull()>0&&farmerInstance.shareHolder && farmerInstance.shareAmount && farmerInstance.shareAmount>=0 && !farmerInstance.shareCertificateNo?.trim())
        		{
        			farmerService.generateShareCertificate(farmerInstance)
        		}
        	
        	//save the crops for the farmer
        	for(int i=1;i<11;i++)
        		{
        		if(params.("cropArea"+i))
        			{
        			def crop = Crop.findByName(params.("crop"+i))
        			if(crop)
        				{
					def farmerCrop = new FarmerCrop()
					farmerCrop.farmer = farmerInstance
					farmerCrop.crop = crop
					try{
					farmerCrop.area = new BigDecimal(params.("cropArea"+i))
					}
					catch(Exception e) {farmerCrop.area=0}
					if(!farmerCrop.save())
					    farmerCrop.errors.allErrors.each {
						log.debug("Error in saving farmerCrop:"+ it)
						}						
        				}
        			}
        		}
            flash.message = "farmer.created"
            flash.args = [farmerInstance.id]
            flash.defaultMessage = "Farmer ${farmerInstance.id} created"
            redirect(action: "show", id: farmerInstance.id)
        }
        else {
            render(view: "create", model: [farmerInstance: farmerInstance])
        }
    }

    def show = {
        def farmerInstance = Farmer.get(params.id)
        if (!farmerInstance) {
            flash.message = "farmer.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Farmer not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [farmerInstance: farmerInstance]
        }
    }

    def edit = {
        def farmerInstance = Farmer.get(params.id)
        if (!farmerInstance) {
            flash.message = "farmer.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Farmer not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [farmerInstance: farmerInstance]
        }
    }

    def update = {
        //log.debug("Farmer:update:"+params)
        def farmerInstance = Farmer.get(params.id)
        if (farmerInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (farmerInstance.version > version) {
                    
                    farmerInstance.errors.rejectValue("version", "farmer.optimistic.locking.failure", "Another user has updated this Farmer while you were editing")
                    render(view: "edit", model: [farmerInstance: farmerInstance])
                    return
                }
            }
        if(!params.irrigationFacility)
        	params.irrigationType = "None"
        if(params.district)
        	{
        	params.'district.id'=params.district
        	params.district=District.get(new Long(params.district))
        	}
        if(params.taluka)
        	{
        	params.'taluka.id'=params.taluka
        	params.taluka=Taluka.get(new Long(params.taluka))
        	}
        if(params.village)
        	{
        	params.'village.id'=params.village
        	params.village=Village.get(new Long(params.village))
        	}
        if(params.postVillage)
        	{
        	params.'postVillage.id'=params.postVillage
        	params.postVillage=Village.get(new Long(params.postVillage))
        	}
            farmerInstance.properties = params
            if (!farmerInstance.hasErrors() && farmerInstance.save()) {

        	//save the crops for the farmer
        	//first delete the old ones
        	FarmerCrop.findAllByFarmer(farmerInstance)?.each{it.delete()}
        	//farmerInstance.crops.each{farmerInstance.removeFromCrops(it)}
        	
        	//now recreate
        	for(int i=1;i<11;i++)
        		{
        		if(params.("cropArea"+i))
        			{
        			def crop = Crop.findByName(params.("crop"+i))
        			if(crop)
        				{
					def farmerCrop = new FarmerCrop()
					farmerCrop.farmer = farmerInstance
					farmerCrop.crop = crop
					try{
					farmerCrop.area = new BigDecimal(params.("cropArea"+i))
					}
					catch(Exception e) {farmerCrop.area=0}
					if(!farmerCrop.save())
					    farmerCrop.errors.allErrors.each {
						log.debug("Error in saving farmerCrop:"+ it)
						}						
        				}
        			}
        		}


                flash.message = "farmer.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Farmer ${params.id} updated"
                redirect(action: "show", id: farmerInstance.id)
            }
            else {
		    farmerInstance.errors.allErrors.each {
			log.debug("error in updating farmer:"+ it)
			}                
                render(view: "edit", model: [farmerInstance: farmerInstance])
            }
        }
        else {
            flash.message = "farmer.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Farmer not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def farmerInstance = Farmer.get(params.id)
        if (farmerInstance) {
            try {
                farmerInstance.delete()
                flash.message = "farmer.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Farmer ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "farmer.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Farmer ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "farmer.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Farmer not found with id ${params.id}"
            redirect(action: "list")
        }
    }
    
    def reports() {
    }
    
    def totalLandReport() {
    }
    
    def irrigatedLandReport() {
    }
    
    def nonirrigatedLandReport() {
    }
    
    def majorCropReport() {
    }
    
    def dairyBusinessReport() {
    }
    
    def wellIrrigationTypeReport() {
    }
    
    def borewellIrrigationTypeReport() {
    }
    
    def canalIrrigationTypeReport() {
    }
    
    def liftIrrigationTypeReport() {
    }
    
    def dripReport() {
    }
    
    def sprinklerReport() {
    }

    def jq_farmer_list = {		
      def sortIndex = params.sidx ?: 'firstName'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = Farmer.createCriteria().list(max:maxRows, offset:rowOffset) {
		if (params.firstName)
			ilike('firstName',params.firstName)
		if (params.middleName)
			ilike('middleName',params.middleName)
		if (params.lastName)
			ilike('lastName',params.lastName)
		if (params.post)
			postVillage{ilike('name',params.post)}
		if (params.village)
			village{ilike('name',params.village)}
		if (params.taluka)
			taluka{ilike('name',params.taluka)}
		if (params.district)
			district{ilike('name',params.district)}
		if (params.pincode)
			ilike('pincode',params.pincode)
		if (params.caste)
			ilike('caste',params.caste)
		if (params.mobileNo)
			ilike('mobileNo',params.mobileNo)
		if (params.shareAmount)
			ge('shareAmount',new BigDecimal(params.shareAmount))
		if (params.shareCertificateNo)
			ilike('shareCertificateNo',params.shareCertificateNo)
		if (params.areaOfIrrigatedLand)
			ge('areaOfIrrigatedLand',new BigDecimal(params.areaOfIrrigatedLand))
		if (params.areaOfNonIrrigatedLand)
			ge('areaOfNonIrrigatedLand',new BigDecimal(params.areaOfNonIrrigatedLand))
		if (params.areaOfTotalLand)
			ge('areaOfTotalLand',new BigDecimal(params.areaOfTotalLand))
		if (params.numDesiCows)
			ge('numDesiCows',new BigDecimal(params.numDesiCows))
		if (params.numHybridCows)
			ge('numHybridCows',new BigDecimal(params.numHybridCows))
		if (params.otherBusinessDetails)
			ilike('otherBusinessDetails',params.otherBusinessDetails)
		if (params.areaUnderDrip)
			ge('areaUnderDrip',new BigDecimal(params.areaUnderDrip))
		if (params.areaUnderSprinkler)
			ge('areaUnderSprinkler',new BigDecimal(params.areaUnderSprinkler))
		if (params.irrigationType)
			eq('irrigationType',params.irrigationType)
		if (params.farmingProcess)
			eq('farmingProcess',params.farmingProcess)
		if (params.receiptBookNo)
			ilike('receiptBookNo',params.receiptBookNo)
		if (params.receiptNo)
			ilike('receiptNo',params.receiptNo)
		if (params.category)
			eq('category',params.category)
		if (params.crops)
			crops{crop{eq('name',params.crops)}}


		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

	if(params.smstext)
		{
		//send SMS and return count
		def phoneNos = result.collect{it.mobileNo}
		def phoneNosStr = ''
		phoneNos?.each{
			phoneNosStr += it+","
			}
		commsService.sendSms(CommsProvider.findByName('RNSFPC'),phoneNosStr,params.smstext)
		def retVal = [count: phoneNos?.size(),phoneNos:phoneNos,smstext:params.smstext]
		render retVal as JSON
		return
		}
      def jsonCells = result.collect {
            [cell: [
		it.firstName?:'',
		it.middleName?:'',
		it.lastName?:'',
		it.village?.name?:'',
		it.taluka?.name?:'',
		it.district?.name?:'',
		it.postVillage?.name?:'',
		it.pincode?:'',
		it.caste?:'',
		it.mobileNo?:'',
		it.shareAmount?:'',
		it.shareCertificateNo?:'',
		it.areaOfIrrigatedLand?:'',
		it.areaOfNonIrrigatedLand?:'',
		it.areaOfTotalLand?:'',
		it.numDesiCows?:'',
		it.numHybridCows?:'',
		it.otherBusinessDetails?:'',
		it.areaUnderDrip?:'',
		it.areaUnderSprinkler?:'',
		it.irrigationType,
		it.farmingProcess,
		it.crops?.collect{it.crop.name+"("+it.area+")"}?:'',
		it.category?:'',
		it.receiptBookNo?:'',
		it.receiptNo?:'',
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_farmer = {
	      log.debug('In jq_farmer_edit:'+params)
	      def farmer = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add farmer sent				
		  farmer = new Farmer(params)
		  if (! farmer.hasErrors() && farmer.save()) {
		    message = "Farmer Saved.."
		    id = farmer.id
		    state = "OK"
		  } else {
		    farmer.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save Farmer"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check farmer exists
			  farmer  = Farmer.get(it)
			  if (farmer) {
			    // delete farmer
			    if(!farmer.delete())
			    	{
				    farmer.errors.allErrors.each {
					log.debug("In jq_farmer_edit: error in deleting farmer:"+ it)
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
		  // first retrieve the farmer by its ID
		  farmer = Farmer.get(params.id)
		  if (farmer) {
		    // set the properties according to passed in parameters
		    farmer.properties = params
		    if (! farmer.hasErrors() && farmer.save()) {
		      message = "Farmer  ${farmer.regNum} Updated"
		      id = farmer.id
		      state = "OK"
		    } else {
			    farmer.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Farmer"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }
	    
	def masterData(){}

def upload_avatar = {
  def farmer = Farmer.get(params.id)
  // Get the avatar file from the multi-part request
  def f = request.getFile('avatar')
  // List of OK mime-types
  def okcontents = ['image/png', 'image/jpeg', 'image/gif']
  if (! okcontents.contains(f.getContentType())) {
    flash.message = "Image must be one of: ${okcontents}"
    render(view:'edit', model:[farmerInstance:farmer])
    return;
  }
  // Save the image and mime type
  farmer.avatar = f.getBytes()
  farmer.avatarType = f.getContentType()
  //log.info("File uploaded: " + farmer.avatarType)
  // Validation works, will check if the image is too big
  if (!farmer.save()) {
    render(view:'edit', model:[farmerInstance:farmer])
    return;
  }
  flash.message = "Image (${farmer.avatarType}, ${farmer.avatar.size()} bytes) uploaded."
  redirect(action:'show', id: farmer.id)
  
}

def avatar_image = {
  def avatarUser = Farmer.get(params.id)
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

    def generateShares() {
    	def numShares = new Integer(params.numShares)
    	def shareAmount = new BigDecimal(params.shareAmount)
    	def company="RNSFPC"
    	def share
    	def cnt=0
    	for(int i=1;i<=numShares;i++)
    	 {
    	 	share = new Share()
    	 	share.company = company
    	 	share.shareAmount = shareAmount
    	 	share.shareSerialNo = receiptSequenceService.getNext("FDB-SH")
    	 	if(!share.save())
    	 		{
			    share.errors.allErrors.each {log.debug(it)}
			}
		else
			cnt++
    	 }
    	 
    	 render cnt +" shares created!!"
    	
    }
    
    def printShareCertificate() {
    	def farmerList = []
    	if(params.id)
    		farmerList.add(Farmer.get(params.id))
    	else
    		farmerList = Farmer.findAllByShareHolder(true)
    	
    	render(template: "sharecertificate", model: [farmerList:farmerList])
    }
    
    def generateShareCertificate() {
    	def fi,retval=""
	def idList = params.id.tokenize(',')
	idList.each{
		fi = farmerService.generateShareCertificate(Farmer.get(it))
		retval += fi.shareCertificates+"<br>"
    	}
    	render "Certificate generated "+retval
    }
	
}
