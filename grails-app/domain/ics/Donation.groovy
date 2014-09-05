package ics

class Donation {
static searchable = { 
	only = ['comments','paymentComments']
	}

static constraints = {
    nvccReceiptBookNo(nullable:true)
    nvccReceiptNo(nullable:true)
    donorName(nullable:true)
    donorAddress(nullable:true)
    donorContact(nullable:true)
    donorPAN(nullable:true)
    donorEmail(nullable:true)
    donatedBy()
    collectedBy()
    amount()
    donationDate(nullable:true)
    donationReceipt()
    receivedBy()
    fundReceiptDate(nullable:true)
    fundReceivedAck()
    comments()
    nvccBank(nullable:true)
    nvccDonationType(nullable:true)
    nvccDonarCode(nullable:true)
    nvccCollectorName(nullable:true)
    nvccReceiverName(nullable:true)
    nvccDonationMode(nullable:true)
    nvccDonarName(nullable:true)
    fundReceivedAck(nullable:true)
    comments(nullable:true)
    bank(nullable:true)
    bankName(nullable:true)
    bankBranch(nullable:true)
    chequeNo(nullable:true)
    chequeDate(nullable:true)
    /* validation moved to the client side..javascript
    chequeDepositDate(nullable:true, validator: { val, obj ->
                // Ensure that if specified, the date of cheque deposit is later than the cheque date
                return val == null || (obj.chequeDate!=null && val.after(obj.chequeDate))
            })*/
    chequeDepositDate(nullable:true)
    paymentComments(nullable:true)
    scheme(nullable:true)
    currency()
    category(nullable:true)
    nameInPadaSevaBook(nullable:true, blank:true)
    status(nullable:true)
    receiptPrintedOn(nullable:true)
    receiptPrintedBy(nullable:true)
    collectionType(nullable:true)
    taxBenefit(nullable:true)

    dateCreated()
    creator()
    lastUpdated()
    updator()
    
    receiptImage(nullable:true, maxSize: 204800 /* 200K */)
    receiptImageType(nullable:true)    
    }
	
	String donorName
	String donorAddress
	String donorContact
	String donorEmail
	String donorPAN
    Individual donatedBy
    Individual collectedBy
    Individual receivedBy
    BigDecimal amount
    String currency
    Date donationDate
    Receipt donationReceipt
    String fundReceivedAck
    Date fundReceiptDate
    String comments
    Scheme scheme
    PaymentMode mode
    Bank bank
    String bankName
    String bankBranch
    String chequeNo
    Date chequeDate
    Date chequeDepositDate
    String category
    String paymentComments
    String nameInPadaSevaBook
    String nvccReceiptBookNo
    String nvccReceiptNo
    String nvccCollectorName
    String nvccReceiverName
    String nvccDonationMode
    String nvccDonationType
    String nvccBank
    String nvccDonarCode
    String nvccDonarName
    String status
    Date receiptPrintedOn
    String receiptPrintedBy
    String collectionType
    Boolean taxBenefit

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
	byte[] receiptImage
	String receiptImageType    

    static hasMany = [giftIssued:GiftIssued]


	static mapping = {
		giftIssued sort:'issueDate'
		nvccReceiptBookNo index:'nvccReceiptBookNo_Idx'
		nvccReceiptNo index:'nvccReceiptNo_Idx'
	}

    String toString() {
    	//(donationDate==null?"":(donationDate.toString()[0..9]))+":"+donationReceipt.toString()+":"+currency+new Integer(amount).toString()
    	if(nvccReceiptNo && nvccReceiptBookNo)
    		String.format('%td-%<tm-%<tY',donationDate)+":"+nvccReceiptBookNo+"/"+nvccReceiptNo+":"+(currency?:'')+":"+amount
    	else
    		if(donationReceipt)
    			String.format('%td-%<tm-%<tY',donationDate)+":"+donationReceipt?.receiptBook?.category+"/"+donationReceipt?.receiptBook?.bookSeries+"/"+donationReceipt?.receiptBook?.bookSerialNumber+"/"+donationReceipt?.receiptNumber+":"+(currency?:'')+":"+amount
    		else
    			comments
    	

    }

}
