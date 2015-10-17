package ics

//this is mainly for staff
//for higher roles, pls fetch department from individual role

class IndividualDepartment {

    static constraints = {
	    individual()
	    department()
	    status()
	    salary(nullable:true)
	    accNo(nullable:true)
	    accRef(nullable:true)
	    comments(nullable:true)
	    since(nullable:true)
	    till(nullable:true)
    }
    String status
    Date since
    Date till
    Integer salary	//per month, null or 0 means voluntary service
    
    String accNo	//bank a/c no
    String accRef	//bank reference for eg IFSC code
    
    String comments
    Date dateCreated
    Date lastUpdated
    String creator
    String updator 

    static belongsTo = [individual:Individual, department:Department]
    static hasMany = [salaryRecords:SalaryRecord, leaveRecords:LeaveRecord, loanRecords:LoanRecord]

    String toString() {
	individual.toString() + " belongs to " + department.toString()
	}
}
