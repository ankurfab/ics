package ics

class IndividualAssessment {

    static constraints = {
    	assessmentCode(nullable:true)
    	individual()
    	assessment()
    	questionPaper(nullable:true)
    	assessmentDate(nullable:true)
    	status inList: ["PRE-REGISTRATION","REGISTERED","READY", "STARTED", "SUBMITTED", "CANCELLED", "PARKED", "RESUMED"]
    	comments(nullable:true)
    	score(nullable:true)
    	timeTaken nullable:true
    	certificateIssued()
    	language(nullable:true)
    	eventRegistration(nullable:true)
    }
    
    Individual individual
    Assessment assessment
    QuestionPaper questionPaper
    Date assessmentDate
    String status
    String comments
    String assessmentCode
    Integer score=0
    Integer timeTaken
    Boolean certificateIssued=false
    String language	//null would mean default i.e. ENGLISH
    EventRegistration eventRegistration

    Date dateCreated
    Date lastUpdated
    String creator
    String updator 

    static hasMany = [answers:IndividualAssessmentQA]
    
}
