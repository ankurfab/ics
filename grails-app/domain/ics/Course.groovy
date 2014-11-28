package ics

class Course {

    static constraints = {
	    category()
	    type()
	    name()
	    description()
	    department(nullable:true)
    }
    
    String category
    String type
    String name
    String description
    Department department
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator 
    
    String toString() {
	name
	}
    
}
