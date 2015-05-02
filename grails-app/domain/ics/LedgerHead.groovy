package ics

class LedgerHead {

    static constraints = {
    	name()
    	category(nullable:true)
    	type(nullable:true)
    	description(nullable:true)
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
    	name
    }
    
}
