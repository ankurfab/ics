package ics

class Expense {

    static constraints = {
    	centre(nullable:true)
    	department()
    	costCenter(nullable:true)
    	
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
    	invoiceAvailable(nullable:true)
    	invoiceRaisedBy(nullable:true)
    	invoiceNo(nullable:true)
    	invoiceDate(nullable:true)
    	invoicePaymentMode(nullable:true)

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
	
	project(nullable:true)
	ledgerHead(nullable:true)
	ref(nullable:true)
	paymentVoucher(nullable:true)
	
	    deductionType(nullable:true)
	    deductionDescription(nullable:true)
	    deductionPercentage(nullable:true)
	    deductionAmount(nullable:true)

	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
    
    Centre centre
    Department department
    CostCenter costCenter
    
    Individual raisedBy
    String type
    String category
    String description
    BigDecimal amount
    Date expenseDate
    String invoiceAvailable
    String invoiceRaisedBy
    String invoiceNo
    Date invoiceDate
    PaymentMode invoicePaymentMode
    Date raisedOn
    Individual approvedBy
    String status
    BigDecimal approvedAmount
    Date approvalDate
    String approvalComments
    
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
    
    Project project
    LedgerHead ledgerHead
    String ref
    Voucher paymentVoucher
    
    String deductionType
    String deductionDescription
    BigDecimal deductionPercentage
    BigDecimal deductionAmount
    

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    String toString() {
    	amount+"/"+expenseDate
    }
    
}
