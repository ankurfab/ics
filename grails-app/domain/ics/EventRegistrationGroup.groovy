package ics

class EventRegistrationGroup {

    static constraints = {
	    comments(nullable:true, blank:true)
	    status(nullable:true, blank:true)
    }
    
    String comments
    String status
    int numPrji=0
    int numMataji=0
    int numChildren=0
    int numBrahmachari=0
    int total=0
    int numGroups=0
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static belongsTo = [mainEventRegistration: EventRegistration]
    static hasMany = [subEventRegistrations:EventRegistration]
    
    String toString() {
    	numPrji+" "+numMataji+" "+numChildren+" "+numBrahmachari
    }
}
