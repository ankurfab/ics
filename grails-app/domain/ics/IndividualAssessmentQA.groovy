package ics

class IndividualAssessmentQA {

    static constraints = {
    	individualAssessment()
    	question()
    	selectedChoice1(nullable:true)
    	selectedChoice2(nullable:true)
    	selectedChoice3(nullable:true)
    	selectedChoice4(nullable:true)
    	correctAnswer(nullable:true)
    	score(nullable:true)
    	shown(nullable:true)
    	category(nullable:true)
    	lastShown(nullable:true)
    }
    
    IndividualAssessment individualAssessment
    String category	//mock or actual
    Question question
    Boolean selectedChoice1
    Boolean selectedChoice2
    Boolean selectedChoice3
    Boolean selectedChoice4
    Boolean correctAnswer
    Integer score
    Boolean shown
    Date lastShown
    
}
