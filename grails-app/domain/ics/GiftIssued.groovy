package ics

class GiftIssued {

    static constraints = {
    gift()
    issuedTo()
    issueDate()
    issuedQty(min:1)
    issuedBy()
    comments(nullable:true)
    donation(nullable:true)
	nvccDonarType(nullable:true)
	nvccDonarId(nullable:true)
	nvccGiftId(nullable:true)
	nvccGift(nullable:true)
	nvccAmount(nullable:true)

    dateCreated()
    creator()
    lastUpdated()
    updator()

}

    Gift gift
    int issuedQty
    Individual issuedTo
    Individual issuedBy
    Date issueDate
    String comments
    Donation donation
    String nvccDonarType
    String nvccDonarId
    String nvccGiftId
    String nvccGift
    String nvccAmount
    

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static belongsTo = [donation:Donation]


            String toString() {
                if(nvccGift!=null && nvccGift.length()>0)
                	return nvccGift
                else
                	return gift.toString()
    	  }
    	  
    
}
