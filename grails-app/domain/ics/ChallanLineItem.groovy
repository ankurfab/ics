package ics

class ChallanLineItem {

    static constraints = {
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
    
    Book book
    Integer issuedQuantity
    Integer returnedQuantity	//in case challan is not settled, it indicates the no of books still with the distributor, for scoring
    BigDecimal rate
    BigDecimal discountedRate

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static belongsTo = [challan: Challan]
    
}
