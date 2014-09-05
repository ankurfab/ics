package ics

class SalaryRecord {

    static constraints = {
    	datePaid()
    	amountPaid()
    	paymentDetails(nullable:true)
    	comments(nullable:true)

	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
    
    Date datePaid
    Integer amountPaid
    String paymentDetails
    String comments
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static belongsTo = [individualDepartment:IndividualDepartment]

    String toString() {
    	individualDepartment.toString()+":"+datePaid.format('dd-MM-yyyy hh:mm')+"/"+amountPaid
    }
    
}
