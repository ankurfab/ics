package ics

//to store old loginids for the individual so as to track older data
class IndividualLoginid {

    static constraints = {
	    individual()
	    loginid()
	    comments(nullable:true)
    }
    
    String loginid
    String comments
    Date dateCreated
    Date lastUpdated
    String creator
    String updator 

    static belongsTo = [individual:Individual]
    
}
