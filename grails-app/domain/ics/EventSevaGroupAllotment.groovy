package ics

class EventSevaGroupAllotment {

    static constraints = {
    dateCreated()
    creator()
    lastUpdated()
    updator()
    eventSeva(unique:['eventRegistration'])
    }
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static belongsTo = [eventSeva: EventSeva, eventRegistration:EventRegistration]
    
    String toString() {
        return eventRegistration?.name +"("+eventRegistration?.regCode+") in service "+eventSeva?.seva?.name
	  }
}
