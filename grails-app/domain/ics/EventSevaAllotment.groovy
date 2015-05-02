package ics

class EventSevaAllotment {

    static constraints = {
    dateCreated()
    creator()
    lastUpdated()
    updator()
    eventSeva(unique:['person','individual'])
    }

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static belongsTo = [eventSeva: EventSeva, person:Person,individual:Individual]
    
    String toString() {
        return person?(person?.name +" in service "+eventSeva?.seva?.name):(individual?.toString() +" in service "+eventSeva?.seva?.name)
	  }
}
