package ics

class EventPrasadam {

    static constraints = {
	    event()
	    meal()
	    mealDate()
	    numPrji()
	    numMataji()
	    numChildren()
	    comments(nullable:true,blank:true)
	    updator()
	    lastUpdated()
	    creator()
	    dateCreated()
    }
    
    Event event
    String meal
    Date mealDate
    Integer numPrji=0
    Integer numMataji=0
    Integer numChildren=0
    String comments

    Date dateCreated
    Date lastUpdated
    String creator
    String updator    

    String toString() {
    	meal+"("+(numPrji+numMataji+numChildren)+")"
    }        
}
