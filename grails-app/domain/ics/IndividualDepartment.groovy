package ics

class IndividualDepartment {

    static constraints = {
	    individual()
	    department()
	    status()
	    salary(nullable:true)
	    comments(nullable:true)
	    since(nullable:true)
	    till(nullable:true)
    }
    String status
    Date since
    Date till
    Integer salary	//per month, null or 0 means voluntary service
    String comments
    Date dateCreated
    Date lastUpdated
    String creator
    String updator 

    static belongsTo = [individual:Individual, department:Department]
    static hasMany = [salaryRecords:SalaryRecord, leaveRecords:LeaveRecord]

    String toString() {
	individual.toString() + " belongs to " + department.toString()
	}
}
