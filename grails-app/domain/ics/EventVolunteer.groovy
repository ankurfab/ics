package ics

class EventVolunteer {

    static constraints = {
	    event()
	    department()
	    seva()
	    requiredFrom()
	    requiredTill()
	    numPrjiRequired()
	    numMatajiRequired()
	    numPrjiAllotted()
	    numMatajiAllotted()
	    comments(nullable:true,blank:true)
	    updator()
	    lastUpdated()
	    creator()
	    dateCreated()
    }
    
    Event event
    String department
    String seva
    Integer numPrjiRequired=0
    Integer numMatajiRequired=0
    Integer numPrjiAllotted=0
    Integer numMatajiAllotted=0
    Date requiredFrom
    Date requiredTill
    String comments
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    String toString() {
    	department+":"+seva+"("+(numPrjiRequired+numMatajiRequired)+")"
    }    
}
