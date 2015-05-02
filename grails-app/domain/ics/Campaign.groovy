package ics

class Campaign {

    static constraints = {
    }
    
    String name
    String description
    Date fromDate
    Date tillDate
    String category	//Marathon,Festival etc
    String status	//Active,Inactive,Deleted

    Date dateCreated
    Date lastUpdated
    String creator
    String updator 
    
    static hasMany = [pricelist:BookPrice]
    
    String toString() {
    	name
    }

    
}
