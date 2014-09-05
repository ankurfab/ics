package ics

class Title {
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

        static hasMany = [individuals:Individual]
        
            String toString() {
	        return name
		  }


}
