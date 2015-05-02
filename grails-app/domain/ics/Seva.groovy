package ics

class Seva {

    static constraints = {
	    category()
	    type()
	    name()
	    description()
	    department(nullable:true)
	    incharge(nullable:true)
    }

    String category
    String type
    String name
    String description
    Department department
    Individual incharge
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator 
    
    String toString() {
	category+"."+type+"."+name
	}
    
}
