package ics

class DonationRecord {

    static constraints = {
	    donatedBy()
	    donationDate()
	    amount()
	    expectedamount(nullable:true)
	    scheme(nullable:true)
        centre(nullable:true)
	    reference(nullable:true,blank:true)
	    comments(nullable:true,blank:true)
	    mode(nullable:true)
	    paymentDetails(nullable:true,blank:true,size:0..2000)
	    transactionDetails(nullable:true,blank:true,size:0..2000)
        receiptReceivedStatus(nullable:true,blank:true)
        transactionId(nullable:true)
        rbno(nullable:true)
        rno(nullable:true)
        donation(nullable:true)
        collectedBy(nullable:true)
        
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
     static transients = ['donorName','consumberNumber','alreadyExist','samemonthdonations','memberdetails','schemeMember','usepercentagededuction','amountafterdeduction']

    Individual collectedBy
    Individual donatedBy
    String donorName
    String consumberNumber
    String alreadyExist
    String usepercentagededuction
    DonationRecord[] samemonthdonations
    String memberdetails
    SchemeMember schemeMember
    Scheme scheme
    Centre centre
    Date donationDate
    String reference
    String comments
    BigDecimal amount
    BigDecimal amountafterdeduction
    BigDecimal expectedamount
    PaymentMode mode
    String paymentDetails	//also used to capture bankname
    String receiptReceivedStatus
    String transactionId	//also used to capture chequeno
    String transactionDetails	//also used to capture branch name
    
    
    //for offline collection i.e. using receipt books
    String rbno	//receipt book no
    String rno	//receipt no
    
    //linked donation
    Donation donation
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    
    String toString() {
        return donationDate?.toString()+":"+mode?.toString()+":"+amount+":"+paymentDetails
	  }
}
