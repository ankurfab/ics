package ics

class Country {

    static constraints = {
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
    String name

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static hasMany = [addresses:Address]
    
        String toString() {
            return name
    	  }

}
