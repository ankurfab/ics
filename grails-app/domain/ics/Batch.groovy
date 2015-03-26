package ics

class Batch {

    static constraints = {
	    category()
	    type()
	    name()
	    description(nullable:true)
	    ref()
	    fromDate()
	    toDate()
	    status()

	    dateCreated()
	    lastUpdated()
	    creator()
	    updator()
    }
    
    String category
    String type
    String name
    String description
    String ref
    Date fromDate
    Date toDate
    String status

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static hasMany = [items:BatchItem]

    String toString() {
        return name
	  }
    
    
}
