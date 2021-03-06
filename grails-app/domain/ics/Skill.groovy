package ics

class Skill {

    static constraints = {
	    category()
	    type()
	    name()
	    description()
    }

    String category
    String type
    String name
    String description
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator 
    
    String toString() {
	type+"."+name
	}
}
