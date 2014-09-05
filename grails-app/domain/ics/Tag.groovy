package ics

class Tag {

    static constraints = {
    	name()
    	category(nullable:true)
    	department(nullable:true)
    }
    
    String name
    String category
    Department department

    Date dateCreated
    Date lastUpdated
    String creator
    String updator 

    String toString() {
	name
	}

}
