package ics

class LoanRecord {

    static constraints = {
    	loan()
    	receiptVoucher()
    	status()
    	comments(nullable:true)

	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
    
    Loan loan
    Voucher receiptVoucher
    String status
    String comments
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static belongsTo = [individualDepartment:IndividualDepartment]
    
    String toString() {
    	individualDepartment.toString()
    }
    
    
}
