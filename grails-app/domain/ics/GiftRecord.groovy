package ics

class GiftRecord {

    static constraints = {
	    giftedTo()
	    gift()
	    giftDate()
	    quantity()
        scheme(nullable:true)
        centre(nullable:true)
	    reference(nullable:true,blank:true)
	    comments(nullable:true,blank:true)
            giftReceivedStatus(nullable:true,blank:true)
            giftChannel(nullable:true,blank:true)
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }

    Individual giftedTo
    Scheme scheme
    Centre centre
    Gift gift
    Date giftDate
    String reference
    String comments
    int quantity
    String giftReceivedStatus
    String giftChannel // the way gift is collected by person
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    
}
