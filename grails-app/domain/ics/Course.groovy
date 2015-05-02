package ics

class Course {

    static constraints = {
	    category()
	    type()
	    name()
	    description()
	    department(nullable:true)
	    instructor(nullable:true)
    }
    
    String category
    String type
    String name
    String description
    Department department
    Individual instructor
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator 
    
    String toString() {
	category+"/"+type+"/"+name
	}
    
}
