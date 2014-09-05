package ics

class IndividualSeva {

    static constraints = {
	    individual()
	    seva()
	    status()
	    comments(nullable:true)
    
    }
    
    String status
    String comments
    boolean rendered = false
    boolean interested = false
    Date dateCreated
    Date lastUpdated
    String creator
    String updator 

    static belongsTo = [individual:Individual, seva:Seva]
    
    String toString() {
	individual.toString() + " in seva " + seva.toString()
	}
    
}
