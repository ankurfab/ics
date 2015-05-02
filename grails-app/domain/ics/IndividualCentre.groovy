package ics

class IndividualCentre {

    static constraints = {
	    individual()
	    centre()
	    status()
	    type(nullable:true)
	    comments(nullable:true)
	    since(nullable:true)
	    till(nullable:true)
    }
    String status
    String type
    Date since
    Date till
    String comments
    Date dateCreated
    Date lastUpdated
    String creator
    String updator 

    static belongsTo = [individual:Individual, centre:Centre]

    String toString() {
	individual.toString() + " is connected with " + centre.toString()
	}
}
