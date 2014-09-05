package ics

class TripAllotment {

    static constraints = {
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
	    trip(unique:['eventRegistration'])
    }

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static belongsTo = [trip: Trip, eventRegistration:EventRegistration]
    
    
}
