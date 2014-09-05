package ics

class ServiceRequest {

    static constraints = {
    	description size: 1..2000
    }

      static mapping = {
         status index: 'srStatusIdx'
         priority index: 'srPriorityIdx'
         severity index: 'srSeverityIdx'
      }
    
    Department department
    Individual raisedBy
    Individual acceptedBy
    Followup followup
    String description
    String action
    Date actionDate
    Date openDate
    Date closeDate
    Status status
    int priority = 0	//default 0, lower nos mean lower priority
    Severity severity 

    Date dateCreated
    Date lastUpdated
    String creator
    String updator 

}
