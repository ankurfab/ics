package ics

class Objective {

    static constraints = {
	    assignedBy(nullable:true)
	    assignedTo(nullable:true)
	    category(nullable:true)
	    name()
	    description(nullable:true)
	    objFrom()
	    objTo()
	    comments(nullable:true)    
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }

    String category
    String name
    String description
    Date objFrom
    Date objTo
    String comments
    Boolean isComplete
    Individual assignedBy
    Individual assignedTo

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    
        String toString() {
		name
	}
}
