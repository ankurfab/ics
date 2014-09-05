package ics

class LeaveRecord {

    static constraints = {
    	dateFrom()
    	dateTill()
    	status()
    	comments(nullable:true)

	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
    
    Date dateFrom	//inclusive
    Date dateTill	//inclusive
    String status	//applied,withdrawn,approved,rejected
    String comments
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static belongsTo = [individualDepartment:IndividualDepartment]
    
    String toString() {
    	individualDepartment.toString()+":"+dateFrom.format('dd-MM-yyyy hh:mm')+"-"+dateTill.format('dd-MM-yyyy hh:mm')+":"+status
    }
    
    
}
