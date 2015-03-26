package ics

class BatchItem {

    static constraints = {
	    postingDate()
	    effectiveDate(nullable:true)
	    description(nullable:true)
	    ref()
	    debit()
	    grossAmount()
	    netAmount(nullable:true)
	    linkedEntityName(nullable:true)
	    linkedEntityRef(nullable:true)
	    linkedEntityId(nullable:true)
	    linkedBatchRef(nullable:true)
	    status()

	    dateCreated()
	    lastUpdated()
	    creator()
	    updator()
    
    }
    
    Date postingDate
    Date effectiveDate
    String description
    String ref
    Boolean debit
    BigDecimal grossAmount
    BigDecimal netAmount
    String linkedEntityName
    String linkedEntityRef
    String linkedEntityId
    String linkedBatchRef
    String status

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static belongsTo = [batch: Batch]

    String toString() {
        return ref
	  }

    
}
