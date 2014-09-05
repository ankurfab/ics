package ics

class ReceiptBookIssued {

    static constraints = {
	receiptBook()
	issuedTo()
    issueDate()
    returnDate(nullable:true)
    comments(nullable:true)
    isBlank(nullable:true)
    
    tempCash(nullable:true)
    tempCheque(nullable:true)
	
    dateCreated()
    creator()
    lastUpdated()
    updator()
    batchId(nullable:true)
    }

    static belongsTo = [receiptBook:ReceiptBook, issuedTo:Individual]
    Date issueDate
    Date returnDate
    String comments
    boolean isBlank
    String status
    
    //for un-entered offline donations
    BigDecimal tempCash
    BigDecimal tempCheque
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator
	int batchId
}
