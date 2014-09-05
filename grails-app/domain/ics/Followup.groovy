package ics

class Followup {

    static constraints = {
    followupWith()
    followupBy()
    startDate()
    endDate(nullable:true)
    category(nullable:true,blank:true)
    description()
    status(nullable:true,blank:true)
    comments(nullable:true,blank:true)
    ref(nullable:true,blank:true)

    dateCreated()
    creator()
    lastUpdated()
    updator()

    }

    Individual followupWith
    Individual followupBy
    Date startDate
    Date endDate
    String category
    String comments
    String status
    String description
    String ref

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    String toString() {
    	(category?:'')+" : " + description
    }
    
}
