package ics

class Period {

    static constraints = {
	    name()
	    category()
	    type()
	    fromDate(nullable:true)
	    toDate(nullable:true)
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }

    String name
    String category
    String type
    Date fromDate
    Date toDate
    

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
   
        String toString() {
            return name +"( "+fromDate+" - "+toDate+" "
    	  }

}
