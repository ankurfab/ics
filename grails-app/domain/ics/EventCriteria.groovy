package ics

class EventCriteria {

    static constraints = {
    name()
    description(nullable:true)
    conditon1(nullable:true)
    conditon2(nullable:true)
    conditon3(nullable:true)
    conditon4(nullable:true)

    dateCreated()
    creator()
    lastUpdated()
    updator()
    }

    String name
    String description
    String conditon1
    String conditon2
    String conditon3
    String conditon4

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

        String toString() {
            return name
    	  }
    
}
