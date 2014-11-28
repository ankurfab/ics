package ics

class Expense {

    static constraints = {
    	department()
    	raisedBy()
    	type()
    	category()
    	description()
    	amount()
    	expenseDate()
    	raisedOn()
    	status()
    	approvedBy(nullable:true)
    	approvedAmount(nullable:true)
    	approvalDate(nullable:true)
    	approvalComments(nullable:true)
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
    
    Department department
    Individual raisedBy
    String type
    String category
    String description
    BigDecimal amount
    Date expenseDate
    Date raisedOn
    Individual approvedBy
    String status
    BigDecimal approvedAmount
    Date approvalDate
    String approvalComments

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    String toString() {
    	amount+"/"+expenseDate
    }
    
}
