package ics

class Challan {

    static constraints = {
	    refNo(nullable:true)
	    issuedTo()
	    issuedBy()
	    settleBy(nullable:true)
	    issueDate()
	    settleDate(nullable:true)
	    advanceAmount(nullable:true)
	    totalAmount(nullable:true)
	    settleAmount(nullable:true)
	    type()
	    status()
	    comments(nullable:true)
	    
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
    
    String refNo
    Individual issuedTo
    Individual issuedBy
    Individual settleBy
    Date issueDate
    Date settleDate
    BigDecimal advanceAmount
    BigDecimal totalAmount
    BigDecimal settleAmount
    String type	//inward or outward
    String status
    String comments
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static hasMany = [lineItems:ChallanLineItem, paymentReferences:PaymentReference, expenses:Expense]
    
}
