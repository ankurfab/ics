package ics

class Project {

    static constraints = {
	centre(nullable:true)
	department(nullable:true)
	costCenter(nullable:true)

	category(nullable:true)
	type(nullable:true)
	name()
	description(nullable:true,size:0..500)
	comments(nullable:true,size:0..500)
	status(nullable:true)
	amount(nullable:true)
	ref(nullable:true)
	expectedStartDate(nullable:true)
	expectedEndDate(nullable:true)
	actualStartDate(nullable:true)
	actualEndDate(nullable:true)
	priority(nullable:true)
	advanceAmount(nullable:true)
	advanceAmountIssued(nullable:true)
	advanceIssued(nullable:true)
	
	    advanceIssuedTo(nullable:true)
	    advancePaymentMode(nullable:true)
	    advancePaymentComments(nullable:true)
	    advancePaymentVoucher(nullable:true)
	
	
	settleAmount(nullable:true)
	settleDate(nullable:true)

	submitter(nullable:true)
	submitDate(nullable:true)
	submitComments(nullable:true,size:0..500)
	submitStatus(nullable:true)
	submittedAmount(nullable:true)

	reviewer1(nullable:true)
	review1Date(nullable:true)
	review1Comments(nullable:true,size:0..500)
	review1Status(nullable:true)
	reviewer1Amount(nullable:true)

	reviewer2(nullable:true)
	review2Date(nullable:true)
	review2Comments(nullable:true,size:0..500)
	review2Status(nullable:true)
	reviewer2Amount(nullable:true)

	reviewer3(nullable:true)
	review3Date(nullable:true)
	review3Comments(nullable:true,size:0..500)
	review3Status(nullable:true)
	reviewer3Amount(nullable:true)
	
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()

    }
    
    Centre centre
    Department department
    CostCenter costCenter
    
    String category
    String type
    String name
    String description
    String comments
    String status
    BigDecimal amount
    String ref
    Date expectedStartDate
    Date expectedEndDate
    Date actualStartDate
    Date actualEndDate
    String priority
    BigDecimal advanceAmount
    BigDecimal advanceAmountIssued
    Boolean advanceIssued
    Individual advanceIssuedTo
    PaymentMode advancePaymentMode
    String advancePaymentComments
    Voucher advancePaymentVoucher
    
    BigDecimal settleAmount
    Date settleDate
    
    Individual submitter
    Date submitDate
    String submitComments
    String submitStatus
    BigDecimal submittedAmount
    
    Individual reviewer1
    Date review1Date
    String review1Comments
    String review1Status
    BigDecimal reviewer1Amount
    
    Individual reviewer2
    Date review2Date
    String review2Comments
    String review2Status
    BigDecimal reviewer2Amount
    
    Individual reviewer3
    Date review3Date
    String review3Comments
    String review3Status
    BigDecimal reviewer3Amount
        
    Date dateCreated
    Date lastUpdated
    String creator
    String updator 

    String toString() {
        return name
    }

    
}
