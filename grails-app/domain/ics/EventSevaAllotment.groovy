package ics

class EventSevaAllotment {

    static constraints = {
    dateCreated()
    creator()
    lastUpdated()
    updator()
    eventSeva(unique:['person'])
    }

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static belongsTo = [eventSeva: EventSeva, person:Person]
    
    String toString() {
        return person?.name +" in service "+eventSeva?.seva?.name
	  }
}
