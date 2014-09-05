package ics

class MbProfileMatch {

    static constraints = {
    	candidate()
    	prospect()
    	stage(nullable:true)
    	preferenceOrder(nullable:true)
    	candidateStatus(nullable:true)
    	candidateReason(nullable:true)
    	mbStatus(nullable:true)
    	mbReason(nullable:true)
    }
    
    MbProfile candidate
    MbProfile prospect
    
    String stage		//1st stage-> very limited profile, 2nd stage-> further info
    Integer preferenceOrder
    String candidateStatus	//status as per candidate
    String candidateReason	//reason as per the candidate's rejection
    String mbStatus		//status as per MB
    String mbReason		//reason as per the mb's rejection
}
