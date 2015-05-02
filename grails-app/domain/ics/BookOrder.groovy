package ics

class BookOrder {

    static constraints = {
    	orderNo(nullable:true)
    	placedBy()
    	team(nullable:true)
    	orderDate()
    	status()
    	comments(nullable:true,blank:true)
    	challan(nullable:true)
	    
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()    	
    }

    String orderNo
    Individual placedBy
    RelationshipGroup team
    Date orderDate
    String status	//Draft,Submitted,In-Progress,Fulfilled,Cancelled,Rejected
    String comments
    Challan	challan
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static hasMany = [lineItems:BookOrderLineItem]
    
    String toString() {
    	(orderNo?:'') +" by "+placedBy+" on "+orderDate
    }


}
