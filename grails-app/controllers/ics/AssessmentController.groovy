package ics
import grails.converters.JSON
import java.util.zip.ZipOutputStream  
import java.util.zip.ZipEntry  
import org.grails.plugins.csv.CSVWriter
import org.apache.commons.lang.StringEscapeUtils.*

class AssessmentController {

    def springSecurityService
    def assessmentService
    def individualService
    def registrationService
    def invoiceService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def registrations = {
    	[events:Event.findAllByDepartment(IndividualRole.findWhere(individual:Individual.findByLoginid(springSecurityService.principal.username),role:Role.findByName('AssessmentAdmin'),status:'VALID')?.department,[sort:'title'])]
    }

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        def department = IndividualRole.findWhere(individual:Individual.findByLoginid(springSecurityService.principal.username),role:Role.findByName('AssessmentAdmin'),status:'VALID')?.department
        [assessmentInstanceList: Assessment.findAllByDepartment(department,params), assessmentInstanceTotal: Assessment.count()]
    }

    def create = {
        def assessmentInstance = new Assessment()
        assessmentInstance.properties = params
        return [assessmentInstance: assessmentInstance]
    }

    def save = {
	params.updator = params.creator=springSecurityService.principal.username
        def assessmentInstance = new Assessment(params)
        if (!assessmentInstance.hasErrors() && assessmentInstance.save()) {
            flash.message = "assessment.created"
            flash.args = [assessmentInstance.id]
            flash.defaultMessage = "Assessment ${assessmentInstance.id} created"
            redirect(action: "show", id: assessmentInstance.id)
        }
        else {
            render(view: "create", model: [assessmentInstance: assessmentInstance])
        }
    }

    def show = {
        def assessmentInstance = Assessment.get(params.id)
        if (!assessmentInstance) {
            flash.message = "assessment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Assessment not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            if(params.generate)
            	assessmentService.generateQP(assessmentInstance)
            return [assessmentInstance: assessmentInstance]
        }
    }

    def edit = {
        def assessmentInstance = Assessment.get(params.id)
        if (!assessmentInstance) {
            flash.message = "assessment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Assessment not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [assessmentInstance: assessmentInstance]
        }
    }

    def update = {
        def assessmentInstance = Assessment.get(params.id)
        if (assessmentInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (assessmentInstance.version > version) {
                    
                    assessmentInstance.errors.rejectValue("version", "assessment.optimistic.locking.failure", "Another user has updated this Assessment while you were editing")
                    render(view: "edit", model: [assessmentInstance: assessmentInstance])
                    return
                }
            }
            params.updator=springSecurityService.principal.username
            assessmentInstance.properties = params
            if (!assessmentInstance.hasErrors() && assessmentInstance.save()) {
                flash.message = "assessment.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Assessment ${params.id} updated"
                redirect(action: "show", id: assessmentInstance.id)
            }
            else {
                render(view: "edit", model: [assessmentInstance: assessmentInstance])
            }
        }
        else {
            flash.message = "assessment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Assessment not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def assessmentInstance = Assessment.get(params.id)
        if (assessmentInstance) {
            try {
                assessmentInstance.delete()
                flash.message = "assessment.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Assessment ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "assessment.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Assessment ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "assessment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Assessment not found with id ${params.id}"
            redirect(action: "list")
        }
    }
    
    def setup() {
	def retVal = assessmentService.setup(params)
	render(retVal as JSON)    	
    }
    
    def userExam() {
	    //log.debug("userExam:"+params)
	    def ia = IndividualAssessment.findByIndividual(Individual.get(session.individualid))
	    [ia: ia,domainClassName:'EVENT_FEEDBACK',domainClassId:ia?.eventRegistration?.event?.id?.toString(),customEntityName:'IndividualAssessment',customEntityId:ia.id,redirectController:"Assessment",redirectAction:"userDashboard",examtype:params.examtype]
    }
    
    def userStart() {
    	def ia
    	if(params.iaid)
    		ia = IndividualAssessment.get(params.iaid)
    	else
    		ia = IndividualAssessment.findByIndividual(Individual.get(session.individualid))
    	def success = false
	if(ia.questionPaper){	//ie real question paper has been assigned
		if(params.examtype=='MOCK') {
			//cant take mock test once qp has been assigned
			def errmsg = "MOCK test is currently unavailable!!"
			render([error:errmsg] as JSON)
			return			
		}
		if(!ia.assessmentDate) //taking the assessment for the first time
			{    		
			ia.assessmentDate = new Date()
			if(!ia.save())
			    ia.errors.allErrors.each {
				log.debug("Errors in starting ia "+ it)
				}
			else
				{
				success = assessmentService.prepareIAQA(ia)	//make the questions available for the ia
				}
			}
		
  	}
  	else {
  		//mock test scenario
		success = assessmentService.prepareIAQA(ia)	//make the questions available for the ia
	  	}
	if(success)
		{
			render assessmentService.getQuestion(ia,params) as JSON
			return 
		}
	else
		{
		def errmsg = "You have already taken the test earlier on "+(ia?.assessmentDate?.format("dd-MM-yy HH:mm:ss"))+" ! Please contact admin for any further assistance!!"
		render([error:errmsg] as JSON)
		return
		}
		
  	
    }
    
    def userQuestion() {
    	def ia = IndividualAssessment.findByIndividual(Individual.get(session.individualid))
  	render assessmentService.getQuestion(ia,params) as JSON
    }

    def userTimeOver() {
    	def ia = IndividualAssessment.findByIndividual(Individual.get(session.individualid))
    	def result = assessmentService.getResult(ia)
  	render ([result:result] as JSON)
    }

    def jq_registration_list() {
      def sortIndex = params.sidx ?: 'arrivalDate'
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

	def event = Event.get(params.eid)
	def result = EventRegistration.createCriteria().list(max:maxRows, offset:rowOffset) {
			eq('event',event)
			if(params.name)
				ilike('name',params.name)
			if(params.isMale=='Male')
				{
					eq('isMale',true)
				}
			if(params.isMale=='Female')
				{
					eq('isMale',false)
				}
			if(params.contactNumber)
				eq('contactNumber',params.contactNumber)
			if(params.email)
				ilike('email',params.email)
			if(params.address)
				ilike('address',params.address)
			if(params.addressPincode)
				like('addressPincode',params.addressPincode)
			if(params.connectedIskconCenter)
				ilike('connectedIskconCenter',params.connectedIskconCenter)
			if(params.centerLocation)
				ilike('centerLocation',params.centerLocation)
			if(params.otherGuestType)
				ilike('otherGuestType',params.otherGuestType)
			if(params.assessment)
				assessment{eq('name',params.assessment)}
			if(params.arrivalDate)
				eq('regCode',params.arrivalDate)
			if(params.comments)
				ilike('comments',params.comments)
			if(params.paymentReference)
				paymentReference{ilike('details',params.paymentReference)}
			if(params.user) 
				individual{eq('loginid',params.user)}
				
			order(sortIndex, sortOrder)
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)
      
      def department = event?.department
      def codes = []

		if(params.oper=="excel")
		 {
			response.contentType = 'application/zip'
			new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
				zipOutputStream.putNextEntry(new ZipEntry("registrations.csv"))
				//header
				
				zipOutputStream << "SNo,Name,DoB,Gender,Mobile,Email,Address,Pin,From,City,Year,IdType,IdNo,Assessment,Language,Comments,PaymentReference,RegistrationCode, Registration Date,LoginId,Code,Result" 
				def sno = 0
				result.each{ row ->
					sno++
					//log.debug(sno+" start")
					codes = assessmentService.getDetails(row,department)
					zipOutputStream << "\n"
					zipOutputStream <<   sno +","+row.name?.replaceAll(',',';') +","+
						    row.dob?.format('dd-MM-yyyy') +","+
						    (row.isMale?'Male':'Female') +","+
						    (row.contactNumber?:'') +","+
						    row.email?.replaceAll(',',';') +","+
						    row.address?.tr('\n\r\t',' ')?.replaceAll(',',';') +","+
						    row.addressPincode?.replaceAll(',',';') +","+
						    row.connectedIskconCenter?.replaceAll(',',';') +","+
						    row.centerLocation?.replaceAll(',',';') +","+
						    row.year?.replaceAll(',',';') +","+
						    (row.idproofType?:'') +","+
						    row.idProofId?.replaceAll(',',';') +","+
						    row.assessment?.name?.replaceAll(',',';') +","+
						    row.otherGuestType?.replaceAll(',',';') +","+
						    (row.comments?:'')?.tr('\n\r\t',' ')?.replaceAll(',',';') +","+
						    (row.paymentReference?:'')?.toString()?.replaceAll(',',';') +","+
						    (row.regCode?:'') +","+
						    row.arrivalDate?.format('dd-MM-yyyy HH:mm:ss') +","+
						    codes[0] +","+
			    			    codes[1] +","+
			    			    codes[2]
					//log.debug(sno+" end")
				}
			}    		
			return
		 }
		else
		{
	      def jsonCells = result.collect {
		    codes = assessmentService.getDetails(it,department)
		    [cell: [
			    it.name,
			    it.dob?.format('dd-MM-yyyy'),
			    it.isMale?'Male':'Female',
			    it.contactNumber,
			    it.email,
			    it.address,
			    it.addressPincode,
			    it.connectedIskconCenter,
			    it.centerLocation,
			    it.year,
			    it.idproofType,
			    it.idProofId,
			    it.assessment?.name,
			    it.otherGuestType,
			    it.comments,
			    it.paymentReference?.toString(),
			    codes[0],
			    codes[1],
			    codes[2],
			    (it.regCode?:'')+" ("+it.arrivalDate?.format('dd-MM-yyyy HH:mm:ss')+")",
			    IndividualAssessment.findByEventRegistration(it)?.id,
			    it.individual?.id,
			], id: it.id]
		}
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		render jsonData as JSON
		}
        }

	def jq_edit_registration = {
	      //log.debug('In jq_edit_registration:'+params)
	      def registration = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  registration  = EventRegistration.get(it)
			  if (registration && !registration.paymentReference) {
			    // delete vehicle if there is no payment
			    if(!registration.delete())
			    	{
				    registration.errors.allErrors.each {
					log.debug("In jq_edit_registration: error in deleting registration:"+ it)
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
		  // first retrieve the eventRegistration by its ID
		  def eventRegistration = EventRegistration.get(params.id)
		  if (eventRegistration) {
		    // set the properties according to passed in parameters
		    params.dob = Date.parse('dd-MM-yyyy',params.dob)
		    params.isMale = params.isMale=="Male"?true:false
		    params.assessment = Assessment.findByName(params.assessment)
		    
		    eventRegistration.properties = params
		    eventRegistration.updator = springSecurityService.principal.username
		    if (! eventRegistration.hasErrors() && eventRegistration.save()) {
		      message = "EventRegistration  ${eventRegistration.id} Updated"
		      id = eventRegistration.id
		      state = "OK"
		    } else {
			    eventRegistration.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update EventRegistration"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def savePaymentReference() {
      log.debug("Inside assessment.savePaymentReference "+params)
      params.'paymentTo.id'=session.individualid
      params.idType="Assessment"
      def retVal = invoiceService.savePaymentReference(params)
      def response = [message:retVal?.toString(),state:"OK",id:0]
      render response as JSON
    }
    
    def generateQP() {
        def assessmentInstance = Assessment.get(params.id)
        if (!assessmentInstance) {
            flash.message = "assessment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Assessment not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [assessmentInstance: assessmentInstance]
        }
    }
    
    def triggerGenerateQP() {
	def retVal = assessmentService.generateQP(params)
	if(retVal)
		flash.message = "QuestionPaper generated!!"
	else
		flash.message = "Some error occurred while generating QuestionPaper. Please contact admin!!"
	redirect(action: "show", id: params.id)
    }
    
    def userDashboard() {
    	def individual = Individual.get(session.individualid)
    	def er = EventRegistration.findByIndividual(individual)
    	[individual:individual,er:er]
    }

    def userStudy() {
    	def individual = Individual.get(session.individualid)
    	def er = EventRegistration.findByIndividual(individual)
    	[individual:individual,er:er]
    }

    def userMore() {
    	def individual = Individual.get(session.individualid)
    	def er = EventRegistration.findByIndividual(individual)
    	[individual:individual,er:er]
    }
    
    def exportQB() {
      def department = IndividualRole.findWhere(individual:Individual.findByLoginid(springSecurityService.principal.username),role:Role.findByName('AssessmentAdmin'),status:'VALID')?.department
      def result = Question.createCriteria().list() {
      			course{eq('department',department)}
      		}
      
	response.contentType = 'application/zip'
	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		zipOutputStream.putNextEntry(new ZipEntry("questions.csv"))
		//header
		zipOutputStream << "category,language,status,questionText,choice1,choice2,choice3,choice4,isChoice1Correct,isChoice2Correct,isChoice3Correct,isChoice4Correct,course" 

		result.each{ row ->
			zipOutputStream << "\n"
			zipOutputStream <<   (row.category?:'')+","+(row.language?:'')+","+(row.status?:'')+","+
				  (row.questionText?:'').tr('\n\r\t',' ').replaceAll(',',';') +","+
				  (row.choice1?:'').tr('\n\r\t',' ').replaceAll(',',';')+","+(row.choice2?:'').tr('\n\r\t',' ').replaceAll(',',';')+","+(row.choice3?:'').tr('\n\r\t',' ').replaceAll(',',';')+","+(row.choice4?:'').tr('\n\r\t',' ').replaceAll(',',';')+","+
				  (row.isChoice1Correct?:'')+","+(row.isChoice2Correct?:'')+","+(row.isChoice3Correct?:'')+","+(row.isChoice4Correct?:'')+","+(row.course?.name?:'')
		}
	}    		
	return
    }
    
    def importQB() {
	    def f = request.getFile('myFile')
	    if (f.empty) {
		flash.message = 'file cannot be empty'
		render(flash.message)
		return
	    }

	    def question
	    def course = Course.get(params.cid)
	    f.inputStream.toCsvReader(['skipLines':'1']).eachLine{ tokens ->
	    	question = new Question()
	    	question.course = course
	    	question.category = tokens[0]
	    	question.language = tokens[1]
	    	question.status = tokens[2]
	    	question.questionText = tokens[3]
	    	question.choice1 = tokens[4]
	    	question.choice2 = tokens[5]
	    	question.choice3 = tokens[6]
	    	question.choice4 = tokens[7]
	    	if(tokens.size()>9){
			question.isChoice1Correct = tokens[8]?true:false
			question.isChoice2Correct = tokens[9]?true:false
			question.isChoice3Correct = tokens[10]?true:false
			question.isChoice4Correct = tokens[11]?true:false
	    	}
	    	else {
	    		question.isChoice1Correct = question.isChoice2Correct = question.isChoice3Correct = question.isChoice4Correct = false
	    		switch(tokens[8]) {
	    			case '1':
	    				question.isChoice1Correct = true
	    				break
	    			case '2':
	    				question.isChoice2Correct = true
	    				break
	    			case '3':
	    				question.isChoice3Correct = true
	    				break
	    			case '4':
	    				question.isChoice4Correct = true
	    				break
	    			default:
	    				break
	    			
	    		}
	    	}
	    	question.type="SINGLE CHOICE"
	    	question.level="MEDIUM"
	    	question.updator = question.creator = springSecurityService.principal.username
	    	if(!question.save())
				question.errors.allErrors.each {
					println "Error in bulk saving question :"+it
				}
		else
			log.debug(question.toString()+" saved!")
	    }
	    
	    redirect (controller:"question",action: "list")
    }
    
    def verify() {
    	def success=false
    	def trycount=0
    	if(params.packetcode)
    		{
		//first get the individual
		def individual = Individual.findByLoginid(springSecurityService.principal.username)
		if(!individual)
			{
			flash.message = "Invalid user!!"
			}
		else
			{
			//now get the associated registration
			def er = EventRegistration.findByIndividual(individual)
			if(er) {
				//existing tries
				if(er.verificationComments)
					{
					try{
						trycount = new Integer(er.verificationComments)
					}
					catch(Exception e){trycount=0}
					}
				trycount++
				if(trycount<=3) {
					switch(er.verificationStatus) {
						case VerificationStatus.UNVERIFIED:
							//now get the matching code
							def code = Code.findByCodeno(params.packetcode) //@TODO: take care of dep,centre,type,category etc and also retries
							if(code && code.status==null)
								{
								code.status='VERIFIED_'+individual.id
								code.save()
								er.verificationStatus = VerificationStatus.VERIFIED
								flash.message = "Registration confirmed. Please logout and login again to access the features of this site."
								success = true
								try{
									assessmentService.makeVerified(er)
								}
								catch(Exception e){log.debug(e)}
								}
							else
								{
								flash.message = "Invalid code!!"
								}
							er.verificationComments = trycount
							er.save()
							break
						case VerificationStatus.VERIFIED:
							flash.message = "You have already been verified. Please wait for further messages from the GPL team!!"								
							break
						default:
							flash.message = "Invalid registration..please contact GPL team!!"
							break
					}
				}
				else
					flash.message = "You have exceeded the number of tries. Please contact GPL team for further assistance!!"
			}
			else
				flash.message = "Oops..Something went wrong..please contact GPL team!!"
			}
    		}
    	[success:success, trycount:trycount]
    }

    def sendConfirmationMail() {
	def idList = params.idlist.tokenize(',')
	idList.each{
		assessmentService.sendConfirmationMail(EventRegistration.get(it))
    		}
	render "done"
    }
    
    def unlockAndResetUser() {
	def idList = params.idlist.tokenize(',')
	idList.each{
		assessmentService.unlockAndResetUser(EventRegistration.get(it))
    		}
	render([message:"OK"] as JSON)
    }
        
    def unlockCodeVerification() {
	def idList = params.idlist.tokenize(',')
	idList.each{
		assessmentService.unlockCodeVerification(EventRegistration.get(it))
    		}
	render([message:"OK"] as JSON)
    }
        
    def retest() {
	def idList = params.idlist.tokenize(',')
	idList.each{
		assessmentService.retest(EventRegistration.get(it))
    		}
	render([message:"OK"] as JSON)
    }
        
    def uploadbulkregistration() {
	    log.debug("Inside uploadbulkregistration")
	    
	    def f = request.getFile('myFile')
	    if (f.empty) {
		flash.message = 'file cannot be empty'
		render(view: 'entry')
		return
	    }

	    def numRecords = 0, numCreated=0
	    def category = ""
	    f.inputStream.toCsvReader(['skipLines':'1']).eachLine{ tokens ->
	    	category = tokens[4]
	    	numRecords++
	    	if(individualService.createIndividual(['donorName':tokens[0],'donorAddress':tokens[1],'donorContact':tokens[2],'donorEmail':tokens[3],'category':category]))
	    		numCreated++
	    }
	    
	    registrationService.bulkRegistration([eid:params.bulkUploadEventId,aid:params.bulkUploadAssessmentId,category:category])
	    
	    flash.message="Bulk registered "+numCreated+"/"+numRecords+" individuals!!"
	    
	    redirect (action: "registrations")
	    return
    }

    def qasheet() {
    	def ia = IndividualAssessment.findByEventRegistration(EventRegistration.get(params.erid))
    	if(ia.assessmentDate)
    		{
    		def iaqas = IndividualAssessmentQA.findAllByIndividualAssessmentAndCategory(ia,'ACTUAL',[sort:'lastShown'])
    		render(template: "qasheet", model: [ia:ia,iaqas: iaqas])
    		}
    	else
    		render "No challan found with the specified id. Kindly contact admin!!"
    }
    
    def feedback()  {
    	log.debug("inside feedback with params:"+params)
    	def ias = assessmentService.feedback(params)
    	render(template: "feedbacks", model: [ias:ias])
    }


}
