package ics

class Content {

    static constraints = {
	    name()
	    description(nullable:true)
	    htmlContent(nullable:true,size:0..8000)

	    category inList: ["PRE", "POST"]
	    type(nullable:true)
	    language inList: ["ENGLISH", "HINDI", "MARATHI"]
	    status inList: ["ACTIVE", "INACTIVE"]

	    department(nullable:true)
	    course(nullable:true)
	    assessment(nullable:true)
    }
    
    String name
    String description
    String htmlContent
    
    String category
    String type
    String language
    String status
    
    Department department
    Course course
    Assessment assessment
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator 
    

    String toString() {
	name
	}
    
}
