package ics

class EventSeva {

    static constraints = {
	    comments(nullable:true,blank:true)
	    requiredFrom(nullable:true,blank:true)
	    requiredTill(nullable:true,blank:true)
    	    incharge(nullable:true)
    	    inchargeEmail(nullable:true,blank:true,email:true)
    	    onlyBrahmachariRequired(nullable:true)
    	    onlyPrjiRequired(nullable:true)
    	    onlyMatajiRequired(nullable:true)
    }
    
    int maxRequired = 0
    int maxPrjiRequired = 0
    int maxMatajiRequired = 0
    int maxBrahmachariRequired = 0
    
    Boolean onlyBrahmachariRequired
    Boolean onlyPrjiRequired
    Boolean onlyMatajiRequired
    
    int totalOpted = 0
    int prjiOpted = 0
    int matajiOpted = 0
    int brahmachariOpted = 0
    
    int totalAllotted = 0
    int prjiAllotted = 0
    int matajiAllotted = 0
    int brahmachariAllotted = 0

    Individual incharge
    String inchargeName=""
    String inchargeContact=""
    String inchargeEmail=""
    
    Date requiredFrom
    Date requiredTill

    String comments
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static belongsTo = [seva: Seva, event:Event]
}
