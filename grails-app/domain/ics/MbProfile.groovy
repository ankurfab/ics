package ics

class MbProfile {

    static constraints = {
	    candidate()
	    initiatedBy()
	    referredBy(nullable:true)
	    assignedTo(nullable:true)
	    profileStatus(nullable:true)
	    matchMakingStatus(nullable:true)
	    workflowStatus(nullable:true)
	    category(nullable:true)
	    severity(nullable:true)
	    priority(nullable:true)
	    photo(nullable:true, maxSize: 512000 /* 500K */)
	    photoType(nullable:true)
	    originPreference(nullable:true)
	    castePreference(nullable:true)
	    qualPreference(nullable:true)
	    devPreference(nullable:true)
	    otherPreference(nullable:true)
    }
    
    Individual candidate
    Individual initiatedBy
    Individual referredBy
    Individual assignedTo
    
    String profileStatus
    String matchMakingStatus
    String workflowStatus
    
    String category	//for future use...severity,priority should be properly used
    String severity	//external commitment for eg having a counsellor..Level 1,2..n
    String priority	//internal surrender Level1,2,3...
    
    byte[] photo
    String photoType
    
    //Expectations from prospects
    String originPreference
    String castePreference
    String qualPreference
    String devPreference
    boolean workingSpouse
    boolean settleOutside
    String otherPreference

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static hasMany = [matches:MbProfileMatch]
    static mappedBy = [matches:"candidate"]
    
}
