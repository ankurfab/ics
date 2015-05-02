package ics
import org.codehaus.groovy.grails.plugins.springsecurity.*
import org.springframework.web.context.request.RequestContextHolder
import java.util.Random
import com.krishna.*
import groovy.sql.Sql;
import groovy.time.*

class AssessmentService {

    def springSecurityService
    def individualService
    def commsService
    def dataSource
    
    //Generate a question paper for the specified assessment
    def generateQP(Map params) {
    	def retval = false
    	Assessment assmnt = Assessment.get(params.id)
    	//first create blank qp
    	def qp = new QuestionPaper()
    	qp.name = "System Generated on "+new Date()
    	qp.status = "UNDER PREPERATION"
    	qp.totalMarks = new Integer(0)
    	qp.timeLimit = new Integer(0)
    	qp.totalMarks = new Integer(0)
    	qp.assessment = assmnt
 	qp.language = params.language
 	qp.category = params.category
 	if(params.'course.id')
 		qp.course = Course.get(new Long(params.'course.id'))
    		
    	qp.updator=qp.creator="system"
    	
    	//then assigns questions
	generateQP(qp,new Integer(params.numQuestions),new Integer(params.perctEasy), new Integer(params.perctMedium),new Integer(params.perctHard) )
	
	qp.numQuestions = qp.questions?.size()
	qp.totalMarks = 0
	qp.questions.each{qp.totalMarks+=it.marks}
	
	if(!qp.save())
	    qp.errors.allErrors.each {
		log.debug("Errors in generateQP"+ it)
		}
	else
		retval = true
	return retval
		
    }
    
    //Generate a question paper for the specified individual assessment
    def generateQP(IndividualAssessment indAssmnt) {
    }
    
    //Generate question paper with specified criteria
    //the assumption is all questions have same marks (not necessarily 1)
    def generateQP(QuestionPaper qp,Integer numQuestions,Integer perctEasy, Integer perctMedium, Integer perctHard ) {
    	//first get the counts for the respective category
    	Integer numEasy = Math.floor(numQuestions*(perctEasy/100)) as Integer
    	Integer numMedium = Math.floor(numQuestions*(perctMedium/100)) as Integer
    	Integer numHard = Math.floor(numQuestions*(perctHard/100)) as Integer
    	
    	//increase the num qns if there is a shortfall
    	def totalQns = numEasy + numMedium + numHard
    	def shortfall = numQuestions - totalQns
    	if(shortfall > 0)
    		{
    		//fill shortfall in medium questions
    		numMedium += shortfall
    		}
    	totalQns = numEasy + numMedium + numHard
    	log.debug("Total questions = "+totalQns+":"+numEasy+":"+numMedium+":"+numHard)
    	
    	//now randomly get a question from the question bank
    	def question=null, existingq, cnt
    	int i=0
    	//EASY
    	for(i=0;i<numEasy;i++)
    		{
    		question=null
    		cnt=0
    		while(!question && cnt<10) {	//keep on searching  for a new question or abandon after 10 tries
			question = getRandomQuestion(qp.course,qp.category,qp.language,'EASY')
			if(!question)
				{
				cnt++
				}
			else
				{
				//the question shouldn't already exist in the question paper
				existingq = null
				if(qp.questions && qp.questions.size()>0)
					{
					existingq = QuestionPaper.createCriteria().get{
						questions{
							eq('id',question.id)
							}
						}
					if(existingq)
						{
						question = null
						cnt++
						}
					}
				}
    			}
    		if(question)
    			{
    			if(!qp.questions)
    				qp.questions = []
    			qp.questions << question
    			}
    		}
    	//MEDIUM
    	for(i=0;i<numMedium;i++)
    		{
    		question=null
    		cnt=0
    		while(!question && cnt<10) {	//keep on searching  for a new question or abandon after 10 tries
			question = getRandomQuestion(qp.course,qp.category?:'',qp.language?:'','MEDIUM')
			if(!question)
				{
				cnt++
				}
			else
				{
				//the question shouldn't already exist in the question paper
				existingq = null
				if(qp.questions && qp.questions.size()>0)
					{
					existingq = QuestionPaper.createCriteria().get{
						questions{
							eq('id',question.id)
							}
						}
					if(existingq)
						{
						question = null
						cnt++
						}
					}
				}
    			}
    		if(question)
    			{
    			if(!qp.questions)
    				qp.questions = []
    			qp.questions << question
    			}
    		}
    	//HARD
    	for(i=0;i<numHard;i++)
    		{
    		question=null
    		cnt=0
    		while(!question && cnt<10) {	//keep on searching  for a new question or abandon after 10 tries
			question = getRandomQuestion(qp.course,qp.category?:'',qp.language?:'','HARD')
			if(!question)
				{
				cnt++
				}
			else
				{
				//the question shouldn't already exist in the question paper
				existingq = null
				if(qp.questions && qp.questions.size()>0)
					{
					existingq = QuestionPaper.createCriteria().get{
						questions{
							eq('id',question.id)
							}
						}
					if(existingq)
						{
						question = null
						cnt++
						}
					}
				}
    			}
    		if(question)
    			{
    			if(!qp.questions)
    				qp.questions = []
    			qp.questions << question
    			}
    		}
    	
    }
    
    //Generate question paper with specified criteria
    //the assumption is all questions have same marks (not necessarily 1)
    def generateQP(QuestionPaper qp,Integer numQuestions,String category ) {
    	//randomly get a question from the question bank
    	def question=null, existingq, cnt
    	int i=0
    	for(i=0;i<numQuestions;i++)
    		{
    		question=null
    		cnt=0
    		while(!question && cnt<10) {	//keep on searching  for a new question or abandon after 10 tries
			question = getRandomQuestion(qp.course,category,qp.language,'')
			if(!question)
				{
				cnt++
				}
			else
				{
				//the question shouldn't already exist in the question paper
				/*existingq = null
				if(qp.questions && qp.questions.size()>0)
					{
					existingq = QuestionPaper.createCriteria().get{
						questions{
							eq('id',question.id)
							}
						}
					if(existingq)
						{
						question = null
						cnt++
						}
					}*/
				existingq = null
				if(qp.questions && qp.questions.size()>0) {
					if(qp.questions.contains(question))
						existingq = question
					if(existingq)
						{
						question = null
						cnt++
						}
					}
				}
    			}
    		if(question)
    			{
    			if(!qp.questions)
    				qp.questions = []
    			qp.questions << question
    			}
    		}
    	if(!qp.save())
		qp.errors.allErrors.each {log.debug("generateQP in updating qp:"+e)}    		
    }

    //gets a random question from the question bank for the specifies params
    def getRandomQuestion(Course course, String category, String language, String level) {
    	//first get a count of questions in the bank matching the provided criteria
    	def numQns = Question.createCriteria().list{
    			if(course)
    				eq('course',course)
    			else
    				isNull('course')
    			if(category)
    				eq('category',category)
    			else
    				isNull('category')
    			if(language)
    				eq('language',language)
    			else
    				isNull('language')
    			if(level)
    				eq('level',level)
    			projections{count('id')}    			
    			}[0]?.intValue()?:0
    	def question = null
    	def rowOffset
    	if(numQns>0)
    		{
    		rowOffset = new Random().nextInt(numQns)//should vary between 0 and (numQns-1), need to be randomised
    		question = Question.createCriteria().list(max:1, offset:rowOffset){
    			if(course)
    				eq('course',course)
    			else
    				isNull('course')
    			if(category)
    				eq('category',category)
    			else
    				isNull('category')
    			if(language)
    				eq('language',language)
    			else
    				isNull('language')
    			if(level)
    				eq('level',level)
    			
    			}[0]
    		}
    	//log.debug("Num qns found : "+numQns+" :"+(course?:'')+(category?:'')+(language?:'')+(level?:''))
   	//log.debug("random rowoffset : "+rowOffset)
    	log.debug("Returning random question "+(question?:'')+"Num qns found : "+numQns+" :"+(course?:'')+(category?:'')+(language?:'')+(level?:'')+"random rowoffset : "+rowOffset)
    	return question
    		
    }
    
    //record the choice(s) made by the user
    def evaluate(IndividualAssessment ia, Map params) {
    	//first check if the inputs received are valid
    	//log.debug("inside evaluate with params "+params)
    	def mock = true
    	if(ia.assessmentDate)
    		mock = false
    	def iaqa
    	try{
    		iaqa = IndividualAssessmentQA.get(new Long(params.iaqaid))
    	}
    	catch(Exception e){}
    	if(iaqa) {
    		if(iaqa.individualAssessment==ia) {
    			if((mock && iaqa.category=='MOCK') || (!mock && iaqa.category=='ACTUAL')) {
    				//log.debug("correct pair")
    				//the qid supplied should be the one for last shown
    				def iaqaList = IndividualAssessmentQA.findAllByIndividualAssessmentAndShownAndCategory(ia,true,(mock?'MOCK':'ACTUAL'),[max: 1, sort: "lastShown", order: "desc"])
    				if(iaqaList.size()>0)
    					{
    					
    					//log.debug(iaqa.question?.id+"<=>"+iaqaList[0]?.question?.id)
    					
    					//now the qid and this should match
    					if(iaqa.question==iaqaList[0]?.question) {
    						//got genuine reply..store the choice
    						def choices
    						try{
    							choices = params.iaqac.replaceAll("userCheckbox","")?.tokenize(',')
    							//log.debug("parsed choices.."+choices)
    							choices.each{
    								switch(it) {
    									case '1':
    										iaqa.selectedChoice1=true
    										break
    									case '2':
    										iaqa.selectedChoice2=true
    										break
    									case '3':
    										iaqa.selectedChoice3=true
    										break
    									case '4':
    										iaqa.selectedChoice4=true
    										break
    									default:
    										break
    								}
    							}
						    if(!iaqa.save())
							{
							    iaqa.errors.allErrors.each {
								log.debug("In evaluate: error in saving:"+ it)
								}
							}
    						}
    						catch(Exception e) {println e}
    						
    						}    						
    					}
    				}
    				
    			}
    	}
    }
    
    //get the result
    def getResult(IndividualAssessment ia) {
 	log.debug("getResult:ia:"+ia)
    	def mock = true
    	if(ia.assessmentDate)
    		{
    		mock = false

		//get timestamp of  the last shown iaqa
		//def iaqas = IndividualAssessmentQA.findAllWhere(individualAssessment:ia,category:(mock?'MOCK':'ACTUAL'),shown:true,[max: 1, sort: "lastShown", order: "desc"])
		def iaqas = IndividualAssessmentQA.findAllByIndividualAssessmentAndCategoryAndShownIsNotNull(ia,(mock?'MOCK':'ACTUAL'),[sort:'lastShown',max: 1, order: "desc"])
		def lastShownOn = iaqas[0]?.lastShown?:new Date()

    		TimeDuration duration = TimeCategory.minus(lastShownOn, ia.assessmentDate)
    		log.debug("getResult:duration:"+duration)
    		ia.timeTaken = duration.hours*60*60 + duration.minutes*60 + duration.seconds
		log.debug("getResult:ia:"+ia+":lastShownOn:"+lastShownOn+":timeTaken:"+ia.timeTaken)    		
    		}
    	def iaqaList = IndividualAssessmentQA.findAllWhere(individualAssessment:ia,category:(mock?'MOCK':'ACTUAL'),shown:true)
    	ia.score = 0
    	def numQ = 0
    	def totalMarks = ia.questionPaper?.totalMarks?:100
    	iaqaList.each{
    		score(it)
    		ia.score += (it.score?:0)
    		numQ++
    		//totalMarks += it.question.marks
    	}
    	
    	//for grades
    	def scorePct = (ia.score/totalMarks)*100
    	def grade=""
    	if(scorePct<40)
    		grade = "F"
    	else if(scorePct<50)
    		grade = "D"
    	else if(scorePct<60)
    		grade = "C"
    	else if(scorePct<70)
    		grade = "B"
    	else if(scorePct<80)
    		grade = "B+"
    	else if(scorePct<90)
    		grade = "A"
    	else
    		grade = "A+"

    	
    	if(!mock) {
	    	ia.assessmentCode = grade
    		if(!ia.save())
			ia.errors.allErrors.each {
				log.debug("In getResult: error in saving:"+ it)
				}    			
    	}
    	
    	//For percent score: return (ia.score/totalMarks)*100 +" %"
    	
    	log.debug("Result for IA:"+ia+":"+ia.score+":"+grade)
    	//@TODO: hardcoded for GPL
	if(ia?.eventRegistration?.event?.title=='GPL2015')
		return "Score: "+(ia.score?:'')
	else
		return "Grade: "+grade
    }
    
    def score(IndividualAssessmentQA iaqa) {
    	Set correctList = []
    	if(iaqa.question.isChoice1Correct)
    		correctList.add(1)
    	if(iaqa.question.isChoice2Correct)
    		correctList.add(2)
    	if(iaqa.question.isChoice3Correct)
    		correctList.add(3)
    	if(iaqa.question.isChoice4Correct)
    		correctList.add(4)

    	Set answerList = []
    	if(iaqa.selectedChoice1)
    		answerList.add(1)
    	if(iaqa.selectedChoice2)
    		answerList.add(2)
    	if(iaqa.selectedChoice3)
    		answerList.add(3)
    	if(iaqa.selectedChoice4)
    		answerList.add(4)
    		
    	//log.debug("iaqa:"+iaqa+":corect:"+correctList+":answer:"+answerList)
    	if(correctList.size()>0&&answerList==correctList)
    		{
    		iaqa.score = iaqa.question.marks
		    if(!iaqa.save())
			{
			    iaqa.errors.allErrors.each {
				log.debug("In score: error in saving:"+ it)
				}
			}
    		}
    	//log.debug("Score for iaqaid:"+iaqa.id+" = "+iaqa.score)
    }
    
    
    def getQuestion(IndividualAssessment ia, Map params) {
    	//first store the choice for previous question, if any
    	evaluate(ia,params)
    	
    	def questionText, choices
	def examover = true
	def question
	def iaqa
    	//countByIndividualAssessmentAndShownIsNull(ia) ==> not sure what is the error
    	def numQ = IndividualAssessmentQA.createCriteria().list{
		if(ia.assessmentDate)
			eq('category','ACTUAL')
		else
			eq('category','MOCK')
    		eq('individualAssessment',ia)
    		projections{count('id')}
    		}[0]
	def qNum = numQ +"/"+numQ
    	def numUnshownQ = IndividualAssessmentQA.createCriteria().list{
		if(ia.assessmentDate)
			eq('category','ACTUAL')
		else
			eq('category','MOCK')
    		eq('individualAssessment',ia)
    		isNull('shown')
    		projections{count('id')}
    		}[0]
	if(numUnshownQ>0)
	{
		def rowOffset = new Random().nextInt(numUnshownQ.intValue())
		//log.debug("getQuestion "+ia?.questionPaper.numQuestions+" "+numUnshownQ+" "+rowOffset)
		iaqa = IndividualAssessmentQA.createCriteria().list(max:1, offset:rowOffset){
				if(ia.assessmentDate)
					eq('category','ACTUAL')
				else
					eq('category','MOCK')
				eq('individualAssessment',ia)
				isNull('shown')
				}[0]
		if(iaqa)
			{
			examover=''
			question = iaqa.question
			iaqa.shown=true
			iaqa.lastShown=new Date()
			if(!iaqa.save())
			    iaqa.errors.allErrors.each {
				log.debug("Errors in updating shown for iaqa"+ it)
				}
			}
		else
			examover=true
		
		try{
			qNum = ((numQ-numUnshownQ)+1) +"/"+numQ
		}
		catch(Exception e) {log.debug(e)}
	}
	
	//if examover then get result
	def result=''
	if(examover)
		result=getResult(ia)
	
	return [questionText: question?.questionText?:'', choice1: question?.choice1?:'', choice2: question?.choice2?:'', choice3: question?.choice3?:'', choice4: question?.choice4?:'',qNum:qNum,time:ia?.questionPaper?.timeLimit?:'10:00',iaqaid:iaqa?.id,examover:examover,result:result]
    	
    }

    def prepareIAQA(IndividualAssessment ia) {
	def questions = ia.questionPaper?.questions
	def qCnt = 0
	if(!questions) //mock test scenario
		{
		
		//first check if iaqa already generated
		qCnt = IndividualAssessmentQA.countByIndividualAssessmentAndCategory(ia,'MOCK')		
		if(qCnt>0)
			{
			//remove existing questions
			IndividualAssessmentQA.findAllByIndividualAssessmentAndCategory(ia,'MOCK')?.each{it.delete()}
			}
		
		//@TODO: hardcoded for now; get random 10 questions from the sample questions
		def question,iaqa
		for(int i=0;i<10;i++) {
			question = getRandomQuestion(ia?.assessment?.course,'SAMPLE',ia?.language?:'ENGLISH','')
			def tryCnt=0
			def flag=true
			while(question&&tryCnt<10&&flag) {
				//check if this exists in IAQA
				iaqa =  IndividualAssessmentQA.findByIndividualAssessmentAndCategoryAndQuestion(ia,'MOCK',question)
				if(iaqa)
					tryCnt++
				else
					flag=false
				}
			log.debug("prepareIAQA i:"+i+":"+question+":"+(iaqa?:''))
			if(question&&!iaqa)
				{
				iaqa = new IndividualAssessmentQA()
				iaqa.individualAssessment = ia
				iaqa.question = question
				iaqa.category = "MOCK"
				if(!iaqa.save())
				    iaqa.errors.allErrors.each {
					log.debug("Errors in saving iaqa"+ it)
					}
				}
			}		
		}
	else {
		//first check if iaqa already generated
		qCnt = IndividualAssessmentQA.countByIndividualAssessmentAndCategory(ia,'ACTUAL')		
		if(qCnt>0)
			return true
		
		//actual assessment
		//also set up the IAQA
		def iaqa
		questions.each{question->
			iaqa = new IndividualAssessmentQA()
			iaqa.individualAssessment = ia
			iaqa.question = question
			iaqa.category = "ACTUAL"
			if(!iaqa.save())
			    iaqa.errors.allErrors.each {
				log.debug("Errors in saving iaqa"+ it)
				}
		}
	}
	
	return true
    }
    
    def setup(Map params) {
    	log.debug("Inside assessment setup with params "+params)  
    	def cnt=0,message
    	def newind=false
	def idList = params.idlist.tokenize(',')
	idList.each
	{
		def er = EventRegistration.get(it)
		def ind = er?.individual
		if(!ind)
			{
			ind = individualService.createIndividualFromER(er)
			newind=true
			}
		def ia = new IndividualAssessment()
		ia.individual = ind
		ia.assessment = er.assessment
		ia.language = er.otherGuestType?.toUpperCase()
		ia.eventRegistration = er
		ia.status = 'READY'
		try{
		ia.creator = ia.updator = springSecurityService.principal.username
		}
		catch(Exception e) {
			ia.creator = ia.updator = "anonymous"
		}
		
		if(!ia.save()) {
		    ia.errors.allErrors.each {
			log.debug("Errors in setuing up ia "+ it)
			}		    
		}
		else
			{
			cnt++
			if(newind) {
				//send the email to candidate with userid
				def template = Template.findByName("GPL Registration")
				def body = commsService.fillTemplate(template,[er.name,er.assessment?.toString(),er.otherGuestType,er.regCode,er.arrivalDate?.format('dd-MM-yyyy HH:mm:ss'),ind?.loginid,ind?.loginid])
				def depcp = DepartmentCP.findByDepartment(Department.findByName("GPL"))
				commsService.sendMandrill([key:depcp?.cp?.apikey,sender:depcp.sender,toName:er.name,toEmail:er.email,emailsub:template.name,emailbody:body,type:template.type])
				}
			}
	}
	return [status:'OK',message:cnt+' registrations setup successfully!!']
    }

    def setupUV(EventRegistration er, String packetcode) {
    	log.debug("Inside assessment setupUV for "+er)  
	def ind = individualService.createIndividualFromER(er)
	if(ind) 
		{
		//update er with the created ind first
		er.individual = ind
		if(!er.save())
		    er.errors.allErrors.each {log.debug("Exception in attaching ind to er"+ it)}
		else
			{			
			//send the email to candidate with userid
			def template = Template.findByName("GPL Registration")
			def body = commsService.fillTemplate(template,[er.name,er.assessment?.toString(),er.otherGuestType,er.arrivalDate?.format('dd-MM-yyyy HH:mm:ss'),ind?.loginid,ind?.loginid])
			def depcp = DepartmentCP.findByDepartment(Department.findByName("GPL"))
			commsService.sendMandrill([key:depcp?.cp?.apikey,sender:depcp.sender,toName:er.name,toEmail:er.email,emailsub:template.name,emailbody:body,type:template.type])


			//try to verify the candidate
			if(packetcode) {
				//now get the matching code
				def code = Code.findByCodeno(packetcode) //@TODO: take care of dep,centre,type,category etc and also retries
				if(code && code.status==null)
					{
					code.status='VERIFIED_'+ind.id
					code.save()
					er.verificationStatus = VerificationStatus.VERIFIED
					er.save()
					try{
						makeVerified(er)
					}
					catch(Exception e){log.debug("Exception in veriying in setupuv"+e)}
					}				
				}
			}
		}
    }
    
    /*//need to set relevant QP in IA
    def setupForExam(Map params) {
    	//assessment.id=1&questionPaper.id=3&individual.id=54703&status=READY&assessmentCode=abcd
    }*/
    
    def makeVerified(EventRegistration er) {
    	Individual ind = er.individual
    	def iu = IcsUser.findByUsername(ind.loginid)
    	if(iu) {
    		IcsUserIcsRole.findAllByIcsUser(iu)?.each{it.delete()}
    		//now add the verified role
    		def iuir = new IcsUserIcsRole()
    		iuir.icsUser = iu
    		iuir.icsRole = IcsRole.findByAuthority('ROLE_ASMT_USER')
    		if(!iuir.save())
    			iuir.errors.allErrors.each {log.debug("Exception in adding verified role"+ it)}
    		else
    			{
    			setup([idlist:(er.id+",")])
    			try{sendConfirmationMail(er)}
    				catch(Exception e){log.debug("Exception in sending confirm mail.."+e)}
    			}
    	}
    }
    
    def sendConfirmationMail(EventRegistration er) {
	//send the email to candidate with userid
	def template = Template.findByName("GPL Registration Confirmation")
	def body = commsService.fillTemplate(template,[er.name])
	def depcp = DepartmentCP.findByDepartment(Department.findByName("GPL"))
	commsService.sendMandrill([key:depcp?.cp?.apikey,sender:depcp.sender,toName:er.name,toEmail:er.email,emailsub:template.name,emailbody:body,type:template.type])
    }
    
    def getCode(EventRegistration er) {
    	def codeno,code
    	if(er?.verificationStatus==VerificationStatus.VERIFIED)
    		{
		code = Code.findByDepartmentAndStatus(er?.event?.department,'VERIFIED_'+er?.individual?.id?.toString())
		codeno = code?.codeno
		}
	else if(er?.verificationComments=='3')
    		codeno = 'LOCKED'
    	return codeno?:''
    }
    
    def unlockCodeVerification(EventRegistration er) {
    	er.verificationComments = null
    	if(!er.save()) {
    		er.errors.each {log.debug("unlockCodeVerification:"+it)}
    		return false
    		}
    	else
    		return true
    }
    
    
    def getUser(EventRegistration er) {
    	def user = er?.individual?.loginid
    	def isLocked = false
    	if(user) {
    		isLocked = IcsUser.findByUsername(user)?.accountLocked
    		if(isLocked)
    			user += "(LOCKED)"
    	}
    	return user?:''
    }
    
    def unlockAndResetUser(EventRegistration er) {
    	def iuser  = IcsUser.findByUsername(er?.individual?.loginid)
    	iuser?.accountLocked = false
    	iuser?.setPassword('harekrishna')
    	if(iuser)
    		return true
    	else
    		return false
    }
    
    
    //for performance
    def getDetails(EventRegistration er,Department department) {
    	def retUser="",retCode=""
    	
    	def individual = er?.individual
    	def user = individual?.loginid
    	def isLocked = false
    	if(user) {
    		isLocked = IcsUser.findByUsername(user)?.accountLocked
    		if(isLocked)
    			user += "(LOCKED)"
    	}
    	retUser= user?:''
    	//log.debug("retUser:"+retUser)
    	
    	def codeno,code
    	if(er?.verificationStatus==VerificationStatus.VERIFIED)
    		{
		code = Code.findByDepartmentAndStatus(department,'VERIFIED_'+individual?.id?.toString())
		codeno = code?.codeno
		}
	else if(er?.verificationComments=='3')
    		codeno = 'LOCKED'
    	retCode= codeno?:'' 
    	//log.debug("retCode:"+retCode)
    	
    	def result=''
    	def ia = IndividualAssessment.findByEventRegistration(er)
    	if(ia?.assessmentDate)
    		result = (ia.score?:'') +"/"+(ia.assessmentDate?.format('dd-MM-yy HH:mm:ss')?:'')+"/"+(ia.assessmentCode?:'')
    	//log.debug("result:"+result)
    	
    	return [retUser,retCode,result]
    }
    
    def getResult(EventRegistration er) {
    	def result = ''
    	def ia = IndividualAssessment.findByEventRegistration(er)
    	if(ia?.assessmentDate)
    		result = (ia.score?:'') +"/"+(ia.assessmentDate?.format('dd-MM-yy HH:mm:ss')?:'')+"/"+(ia.assessmentCode?:'')
    	return result
    }

    def retest(EventRegistration er) {
    	def ia = IndividualAssessment.findByEventRegistration(er)
    	//cleanup iaqa first
    	IndividualAssessmentQA.findAllByIndividualAssessmentAndCategory(ia,'ACTUAL').each{it.delete()}
    	ia.assessmentDate = null
    	ia.score = null
    	ia.assessmentCode = null
    	if(!ia.save()) {
    		er.errors.each {log.debug("retest:"+it)}
    		return false
    		}
    	else
    		{
    		return prepareIAQA(ia)
    		}
    }
    
    def feedback(Map params) {
    	def ias = IndividualAssessment.createCriteria().list(){
    			eventRegistration{event{eq('id',new Long(params.eventid))}}
    			isNotNull('assessmentDate')
    			order('assessmentDate','asc')
    		}
    	return ias
    }

    //create the basic datastructures viz qp, ia_qp, ia_qa etc for the specified params
    //Mandatory params: params.timeLimit,params.totalMarks,params.numQuestions
    //params.regcode or (params.language && params.eventid)
    def setupForExam(Map params)  {
    	def msg = ""
    	if(params.regcode) {
    		//setup only for the specified er
    		msg = setupForExamForER(EventRegistration.findByRegCode(params.regcode),params.timeLimit,params.totalMarks,params.numQuestions)
    		}
    	else if(params.language && params.eventid) {
    		//setup for the specified langauge
    		def ers = EventRegistration.findAllByEventAndOtherGuestTypeAndVerificationStatus(Event.get(params.eventid),params.language,VerificationStatus.VERIFIED)
    		def resp
    		ers.each{
    			resp = setupForExamForER(it,params.timeLimit,params.totalMarks,params.numQuestions)
    			if(resp)
    				msg += ' , '+resp
    		}
    	}
    	return msg
    }
    
    def setupForExamForER(EventRegistration er,String timeLimit, String totalMarks, String numQuestions) {
    	def msg = ""
	def qp,ia,iaqa

    	if(!er || (er.verificationStatus != VerificationStatus.VERIFIED))
    		return msg

	ia = IndividualAssessment.findByEventRegistration(er)
	if(!ia || ia.questionPaper)
		return msg
		
    	log.debug("setupForExamForER:"+er)

        def username = ''
        try{
        username = springSecurityService.principal.username
        }
        catch(Exception e){username='unknown'}

    	try{
		//create qp
		qp = new QuestionPaper()
		qp.assessment = er.assessment
		qp.course = er.assessment.course
		qp.department = er.assessment.department
		qp.description = "Autogenerated on "+new Date()
		qp.name = "QP for "+er.name+" "+er.assessment.course.name+" "+er.otherGuestType+" ("+er.regCode+")"
		qp.randomize = true
		qp.language = er.otherGuestType
		qp.status = 'AVAILABLE'
		qp.timeLimit = new Integer(timeLimit)
		qp.totalMarks = new Integer(totalMarks)
		qp.numQuestions = new Integer(numQuestions)
		qp.creator = qp.updator = username
		if(!qp.save())
			qp.errors.allErrors.each {log.debug("setupForExamForER:Exception in creating qp"+e)}
		else {		
			log.debug("qp created for er:"+qp)
			//assign qns to qp
			if(assignQnsToQP(qp)) {
				log.debug("qns assigned:"+qp.questions.size())
				//assign qp to ia
				//ia = IndividualAssessment.findByEventRegistration(er)
				if(ia && !ia.questionPaper) {
					ia.questionPaper = qp
					if(!ia.save())
						ia.errors.allErrors.each {log.debug("setupForExamForER:Exception in assigning qp"+e)}
					else {		
						log.debug("ia updated:"+ia)
						//create iaqa
						qp.questions.each{question->
							iaqa = new IndividualAssessmentQA()
							iaqa.individualAssessment = ia
							iaqa.question = question
							iaqa.category = "ACTUAL"
							if(!iaqa.save())
								iaqa.errors.allErrors.each {log.debug("setupForExamForER:Exception in creating iaqa"+e)}
							else
								log.debug("iaqa created:"+iaqa)
						}
						msg = "ok for er:"+er
						log.debug("setupForExamForER:"+msg)
					}
				}
				
			}
		}
    	}
    	catch(Exception e) {log.debug(e)}
    	return msg
    }
    
    //@TODO: random assignment of qns to qp harcoded as per GPL logic
    def assignQnsToQP(QuestionPaper qp) {
	generateQP(qp,20,'SECTION1')
	generateQP(qp,50,'SECTION2')
	generateQP(qp,30,'SECTION3')
	return true
    }
    
    def stats(Event event) {
	def query,results,stats=[:]
	def sql = new Sql(dataSource)
    	//num of registrations by language and status    	
    	query = "select other_guest_type,verification_status,count(1) num from event_registration where event_id="+event?.id+" group by other_guest_type,verification_status"
	results = sql.rows(query)
	stats.put('numRegistrations',results)

    	//exam takers by language    	
    	query = "SELECT i.language,count(1) num FROM individual_assessment i,event_registration er where i.event_registration_id=er.id and er.event_id="+event?.id+" and i.assessment_date is not null group by i.language"
	results = sql.rows(query)
	stats.put('examTakers',results)

	sql.close()
	
	return stats    	    	
    }
    
    def feedback(IndividualAssessment ia) {
	def feedback=[:]
	AttributeValue.findAllByObjectClassNameAndObjectId('IndividualAssessment',ia.id.toString()).each{ fb->
	    def attr
	    if(fb.attribute.type=='MULTI') {
		attr = Attribute.findWhere(domainClassName:'EVENT_FEEDBACK',type:'RADIO',category:fb.attribute.name,position:new Integer(fb.value))?.displayName
		feedback.put(fb.attribute.name,attr)
	    }
	    else {
	    	feedback.put(fb.attribute.name,fb.value)
	    }
	}             		
	return feedback
    }
}
