package ics
import org.codehaus.groovy.grails.plugins.springsecurity.*
import org.springframework.web.context.request.RequestContextHolder
import java.util.Random 

class AssessmentService {

    def springSecurityService
    def individualService
    
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
    	log.debug("Num qns found : "+numQns+" :"+(course?:'')+(category?:'')+(language?:'')+(level?:''))
    	def question = null
    	if(numQns>0)
    		{
    		def rowOffset = new Random().nextInt(numQns)//should vary between 0 and (numQns-1), need to be randomised
    		log.debug("random rowoffset : "+rowOffset)
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
    	log.debug("Returning random question "+(question?:''))
    	return question
    		
    }
    
    //record the choice(s) made by the user
    def evaluate(IndividualAssessment ia, Map params) {
    	//first check if the inputs received are valid
    	log.debug("inside evaluate with params "+params)
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
    				log.debug("correct pair")
    				//the qid supplied should be the one for last shown
    				def iaqaList = IndividualAssessmentQA.findAllByIndividualAssessmentAndShownAndCategory(ia,true,(mock?'MOCK':'ACTUAL'),[max: 1, sort: "lastShown", order: "desc"])
    				if(iaqaList.size()>0)
    					{
    					
    					log.debug(iaqa.question?.id+"<=>"+iaqaList[0]?.question?.id)
    					
    					//now the qid and this should match
    					if(iaqa.question==iaqaList[0]?.question) {
    						//got genuine reply..store the choice
    						def choices
    						try{
    							choices = params.iaqac.replaceAll("userCheckbox","")?.tokenize(',')
    							log.debug("parsed choices.."+choices)
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
    	def mock = true
    	if(ia.assessmentDate)
    		mock = false
    	def iaqaList = IndividualAssessmentQA.findAllByIndividualAssessmentAndCategory(ia,mock?'MOCK':'EXACT')
    	ia.score = 0
    	def numQ = 0
    	def totalMarks = 0
    	iaqaList.each{
    		score(it)
    		ia.score += (it.score?:0)
    		numQ++
    		totalMarks += it.question.marks
    	}
    	
    	if(!mock)
    		ia.save()
    	
    	return (ia.score/totalMarks)*100 +" %"
    	
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
    	log.debug("Score for iaqaid:"+iaqa.id+" = "+iaqa.score)
    }
    
    
    def getQuestion(IndividualAssessment ia, Map params) {
    	//first store the choice for previous question, if any
    	evaluate(ia,params)
    	
    	def questionText, choices
	def examover = true
	def question
	def iaqa
    	//countByIndividualAssessmentAndShownIsNull(ia) ==> not sure what is the error
    	def numUnshownQ = IndividualAssessmentQA.createCriteria().list{eq('individualAssessment',ia) isNull('shown') projections{count('id')}}[0]
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
	}
	
	//if examover then get result
	def result=''
	if(examover)
		result=getResult(ia)
	
	return [questionText: question?.questionText?:'', choice1: question?.choice1?:'', choice2: question?.choice2?:'', choice3: question?.choice3?:'', choice4: question?.choice4?:'',iaqaid:iaqa?.id,examover:examover,result:result]
    	
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
			return false
		
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
    	def er = EventRegistration.get(params.id)
    	def ind = individualService.createIndividualFromER(er)
    	def ia = new IndividualAssessment()
    	ia.individual = ind
    	ia.assessment = er.assessment
    	ia.eventRegistration = er
    	ia.status = 'READY'
    	ia.creator = ia.updator = springSecurityService.principal.username
    	if(!ia.save()) {
	    ia.errors.allErrors.each {
		log.debug("Errors in setuing up ia "+ it)
		}
	    return [status:'FAIL',message:ia.eventRegistration.name+' setup un-successfull!!']
	}
	else
		return [status:'OK',message:ia.eventRegistration.name+' setup successfully!!Loginid generate: '+ind?.loginid]
    }
    
    //need to set relevant QP in IA
    def setupForExam(Map params) {
    	//assessment.id=1&questionPaper.id=3&individual.id=54703&status=READY&assessmentCode=abcd

    }
}
