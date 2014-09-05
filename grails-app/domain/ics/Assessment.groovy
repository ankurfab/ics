package ics

class Assessment {

    static constraints = {
    	name()
    	status inList: ["SUBMITTED", "CANCELLED", "PARKED", "RESUMED"]
    	description nullable:true
    	incharge nullable:true
    	course nullable:true
    	department nullable:true
    	fees nullable:true
    }
    
    String name
    String status
    String description
    Individual incharge
    Course course
    Department department
    BigDecimal fees

    Date dateCreated
    Date lastUpdated
    String creator
    String updator 

    static hasMany = [questionPapers:QuestionPaper]

    String toString() {
	name+" => Fees INR: "+(fees?:'')
	}
    
}
