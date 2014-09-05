package ics

class Pdc {

    static constraints = {
	    issuedBy()
	    chequeNo(blank:false)
	    chequeDate()
	    bank()
	    branch()
	    amount()
	    collectedBy()
	    receivedBy()
	    receiptDate()
	    comments(nullable:true,blank:true)
	    status()
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
    
    Individual issuedBy
    String chequeNo
    Date chequeDate
    Bank bank
    String branch
    BigDecimal amount
    Individual receivedBy
    Individual collectedBy
    Date receiptDate
    String comments
    String status
    Scheme scheme

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    String toString() {
            return issuedBy+"/"+chequeNo+"/"+chequeDate.format("dd-MM-yy")+"/"+bank+"/"+(branch?:'')+"/"+amount
	  }

}
