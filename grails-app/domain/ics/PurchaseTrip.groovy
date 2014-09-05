package ics

class PurchaseTrip {

    static constraints = {
    	amountTaken(nullable:true)
    	cashPurchase(nullable:true)
    	creditPurchase(nullable:true)
    	donationReceived(nullable:true)
    	balance(nullable:true)    	
    }
    
    Trip trip
    BigDecimal amountTaken
    BigDecimal cashPurchase
    BigDecimal creditPurchase
    BigDecimal donationReceived
    BigDecimal balance
    
    
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static hasMany = [invoices:Invoice]

    String toString() {
    	return trip.toString()
    }
}
