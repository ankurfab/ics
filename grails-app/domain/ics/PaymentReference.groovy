package ics

class PaymentReference {

    static constraints = {
	    paymentBy(nullable:true)
	    paymentTo(nullable:true)
	    mode()
	    amount()
	    paymentDate()
	    details(nullable:true,blank:true)
	    department(nullable:true)

	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }

    Individual paymentBy
    Individual paymentTo
    PaymentMode mode
    BigDecimal amount
    Date paymentDate
    String details
    Department department
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    String toString() {
	    return "Paid "+amount+" to "+(paymentTo?:'')+" vide "+mode+" ("+details+") "+" on "+paymentDate?.format('dd-MM-yy')+" by "+(paymentBy?:'')
  	}
}
