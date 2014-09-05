package ics

class QuestionPaper {

    static constraints = {
    	name()
    	description nullable:true
    	status inList: ["UNDER PREPERATION", "PREPARED", "AVAILABLE", "PARKED"]
    	randomize()
    	totalMarks()
    	numQuestions(nullable:true)
    	compiledBy nullable:true
    	verifiedBy nullable:true
    	course nullable:true
    	department nullable:true
    	language(nullable:true)
    	category(nullable:true)
    }
    
    String name
    String description
    Individual compiledBy
    Individual verifiedBy
    String status
    String language
    String category
    Boolean randomize=false
    Integer numQuestions
    Integer totalMarks
    Integer timeLimit
    Course course
    Department department

    Date dateCreated
    Date lastUpdated
    String creator
    String updator 
    
    static hasMany = [questions:Question]
    static belongsTo = [assessment:Assessment]

    String toString() {
	name
	}
    
}
