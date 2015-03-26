package ics

class Voucher {

    static constraints = {
	    voucherDate()
	    departmentCode(nullable:true)
	    voucherNo()
	    amount(nullable:true)
	    description(nullable:true,blank:true)
	    amountSettled(nullable:true)
	    type(nullable:true)
	    refNo(nullable:true)

		debit(nullable:true)
		mode(nullable:true)
		anotherDepartmentCode(nullable:true)
		anotherDescription(nullable:true)
		individual(nullable:true)
		anotherIndividual(nullable:true)
		ledger(nullable:true)
		anotherLedger(nullable:true)
		ledgerHead(nullable:true)
		anotherLedgerHead(nullable:true)
		instrumentNo(nullable:true)
		instrumentDate(nullable:true)
		bankName(nullable:true)
		bankBranch(nullable:true)
		crossUsing(nullable:true)
		status(nullable:true)

	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }

    Date voucherDate
    CostCenter departmentCode
    String voucherNo
    String refNo
    BigDecimal amount
    String description
    BigDecimal amountSettled
    String type
    
    Boolean debit
    PaymentMode mode
    Individual individual
    Individual anotherIndividual
    CostCenter anotherDepartmentCode
    String anotherDescription
    String ledger
    LedgerHead ledgerHead
    String anotherLedger
    LedgerHead anotherLedgerHead
    String instrumentNo
    Date instrumentDate
    String bankName
    String bankBranch
    String crossUsing
    String status
    

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

        String toString() {
            return departmentCode?.toString()+":"+voucherNo
    	  }
}
