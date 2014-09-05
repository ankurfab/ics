package ics
import grails.converters.JSON
import java.util.zip.ZipOutputStream  
import java.util.zip.ZipEntry  
import org.grails.plugins.csv.CSVWriter
import org.apache.commons.lang.StringEscapeUtils.*

class AssessmentController {

    def springSecurityService
    def assessmentService
    def invoiceService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def registrations = {
    }

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [assessmentInstanceList: Assessment.list(params), assessmentInstanceTotal: Assessment.count()]
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
    [ia: IndividualAssessment.findByIndividual(Individual.get(session.individualid))]
    }
    
    def userStart() {
    	def ia = IndividualAssessment.findByIndividual(Individual.get(session.individualid))
    	def success = false
	if(ia.questionPaper){	//ie real question paper has been assigned
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
		render([error:"Already taken the test earlier"] as JSON)
		return
		}
		
  	
    }
    
    def userQuestion() {
    	def ia = IndividualAssessment.findByIndividual(Individual.get(session.individualid))
  	render assessmentService.getQuestion(ia,params) as JSON
    }

    def jq_registration_list() {
      def sortIndex = params.sidx ?: 'arrivalDate'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = EventRegistration.createCriteria().list(max:maxRows, offset:rowOffset) {
			event{eq('id',new Long(params.eid))}
			if(params.name)
				ilike('name',params.name)
			if(params.isMale)
				{
				if(params.isMale=='M' || params.isMale=='m')
					eq('isMale',true)
				else
					eq('isMale',false)
				}
			if(params.contactNumber)
				eq('contactNumber',params.contactNumber)
			if(params.email)
				ilike('email',params.email)
			if(params.address)
				ilike('address',params.address)
			if(params.connectedIskconCenter)
				ilike('connectedIskconCenter',params.connectedIskconCenter)
			if(params.otherGuestType)
				ilike('otherGuestType',params.otherGuestType)
			if(params.arrivalDate)
				eq('regCode',params.arrivalDate)
			order(sortIndex, sortOrder)
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.name,
            	    it.dob?.format('dd-MM-yyyy'),
            	    it.isMale?'Male':'Female',
            	    it.contactNumber,
            	    it.email,
            	    it.address,
            	    it.connectedIskconCenter,
            	    it.year,
            	    it.idproofType,
            	    it.idProofId,
            	    it.assessment?.name,
            	    it.otherGuestType,
            	    it.comments,
            	    it.paymentReference?.toString(),
            	    (it.regCode?:'')+" ("+it.arrivalDate?.format('dd-MM-yyyy HH:mm:ss')+")",
            	    IndividualAssessment.findByEventRegistration(it)?.id
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
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
			  // check vehicle exists
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
    	[individual:individual]
    }

    def userStudy() {
    	def individual = Individual.get(session.individualid)
    	[individual:individual]
    }

    def userMore() {
    	def individual = Individual.get(session.individualid)
    	[individual:individual]
    }
    
    def exportQB() {
      def result = Question.list()
      
	response.contentType = 'application/zip'
	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		zipOutputStream.putNextEntry(new ZipEntry("questions.csv"))
		//header
		zipOutputStream << "category,language,status,questionText,choice1,choice2,choice3,choice4,isChoice1Correct,isChoice2Correct,isChoice3Correct,isChoice4Correct" 

		result.each{ row ->
			zipOutputStream << "\n"
			zipOutputStream <<   (row.category?:'')+","+(row.language?:'')+","+(row.status?:'')+","+
				  (row.questionText?:'').tr('\n\r\t',' ').replaceAll(',',';') +","+
				  (row.choice1?:'').tr('\n\r\t',' ').replaceAll(',',';')+","+(row.choice2?:'').tr('\n\r\t',' ').replaceAll(',',';')+","+(row.choice3?:'').tr('\n\r\t',' ').replaceAll(',',';')+","+(row.choice4?:'').tr('\n\r\t',' ').replaceAll(',',';')+","+
				  (row.isChoice1Correct?:'')+","+(row.isChoice2Correct?:'')+","+(row.isChoice3Correct?:'')+","+(row.isChoice4Correct?:'')
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
	    f.inputStream.toCsvReader(['skipLines':'1']).eachLine{ tokens ->
	    	question = new Question()
	    	question.category = tokens[0]
	    	question.language = tokens[1]
	    	question.status = tokens[2]
	    	question.questionText = tokens[3]
	    	question.choice1 = tokens[4]
	    	question.choice2 = tokens[5]
	    	question.choice3 = tokens[6]
	    	question.choice4 = tokens[7]
	    	question.isChoice1Correct = tokens[8]?true:false
	    	question.isChoice2Correct = tokens[9]?true:false
	    	question.isChoice3Correct = tokens[10]?true:false
	    	question.isChoice4Correct = tokens[11]?true:false
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

    
    
}
