package ics

class Commitment {

    static constraints = {
    ccAmount(nullable:true)
    donatedAmount(nullable:true)
    collectedAmount(nullable:true)
    commitmentOn(nullable:true)
    commitmentTill(nullable:true)
    holdTill(nullable:true)
    scheme(nullable:true)
    status(nullable:true)
    ecsMandate(nullable:true)
    scheme unique: 'committedBy'
    dateCreated()
    creator()
    lastUpdated()
    updator()
    }
    
    BigDecimal committedAmount	//for personal/family donations
    BigDecimal ccAmount	// collection committed amount
    BigDecimal donatedAmount
    BigDecimal collectedAmount
    Individual committedBy
    Scheme scheme
    String status
    String ecsMandate
    Date commitmentOn
    Date commitmentTill
    Date holdTill //if status is On Hold then this is useful
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

        String toString() {
           return committedBy
    	  }
    
}
