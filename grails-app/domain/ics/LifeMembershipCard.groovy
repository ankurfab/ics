package ics

class LifeMembershipCard {

    static constraints = {
	 lifeMembershipCardNumber(nullable:true)   
	 lifeMember()
	 nameOnCard(nullable:true)
	 originatingDeptCollector()
	 forwardingDeptRepresentative()
	 acceptedByOriginatingDept(nullable:true)
	 dateFormSubmissionOriginatingDeptToForwardingDept(nullable:true) 
	 dateFormSentToProcessingDept(nullable:true)
	 dateCardArrival(nullable:true)
	 dateCardDelivery(nullable:true)
	 duplicate(nullable:true)
	 cardStatus()
	 cardCollectedBy(nullable:true)
	 dateCreated()
 	 lastUpdated()
 	 creator()
 	 updator()
    }
    
 String lifeMembershipCardNumber   
 Individual lifeMember
 String nameOnCard
 Individual originatingDeptCollector
 Individual forwardingDeptRepresentative
 Boolean acceptedByOriginatingDept
 Date dateFormSubmissionOriginatingDeptToForwardingDept //date of submission of form from patron care dept to nvcc
 Date dateFormSentToProcessingDept //date of form sent by nvcc to Juhu
 Date dateCardArrival //from Juhu
 Date dateCardDelivery //to the life member
 Boolean duplicate //this is not required, but we can have it for our record
 String cardStatus //status of the card
 String cardCollectedBy
 
 Date dateCreated
 Date lastUpdated
 String creator
 String updator    
}
