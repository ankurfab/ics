package ics

class EventInstance {

    static constraints = {
    	startDate()
    	endDate()
    	description(nullable:true)
    	comments(nullable:true)
    	venue(nullable:true)
    	contactPerson(nullable:true)
    	status(nullable:true)    	
    }

    static belongsTo = [event:Event]
    static hasMany = [attendees:Individual]

    Date startDate
    Date endDate
    String description
    String comments
    String venue
    Individual contactPerson
    String status
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

        String toString() {
            return event.toString()+" : "+startDate.toString()+" : "+endDate.toString()+" : "+(venue?:'')
    	  }
    
    
}
