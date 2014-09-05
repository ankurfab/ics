package ics

class BouncedCheque {

    static constraints = {
    	donation(nullable:true)
    	loan(nullable:true)
    	chequeNo(blank:false,maxSize:10)
        chequeDate(blank:false)
        bankName()
        branchName()
        issuedBy()
        issuedTo(nullable:true)
    	presentedOn(nullable:true)
    	comments(nullable:true,blank:true)
    	status(nullable:true,blank:true)
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
    
    //Individual issuedBy1
    //Individual issuedTo1
    Donation donation
    Loan loan
    String chequeNo
    Date chequeDate
    String bankName
    //Bank bank
    String branchName
    String issuedBy
    String issuedTo
    Date presentedOn
    String comments
    String status

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    
        String toString() {
            return chequeNo+" : "+String.format('%td-%<tm-%<tY',chequeDate)+" : "+(bankName?:'')+" : "+(branchName?:'')
    	  }

}
