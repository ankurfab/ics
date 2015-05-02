package ics

class EventDetail {

    static constraints = {
    	category()
    	type()
    	details(size:0..2500)
    }
    
    String category
    String type
    String details

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static belongsTo = [event:Event]
}
