package ics

class EventParticipant {

    static constraints = {
    event()
    individual()
    attended()
    invited()
    confirmed()
    comments()
    regCode(nullable:true)
    role(nullable:true)

    dateCreated()
    creator()
    lastUpdated()
    updator()

    }

    static belongsTo = [event:Event, individual:Individual]
    boolean attended
    boolean invited
    boolean confirmed
    boolean flgAddressPrinted
    String comments
    String regCode
    String role

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

        String toString() {
            return event.toString()+" : "+individual.toString()
    	  }

}
