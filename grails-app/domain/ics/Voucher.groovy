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

		    dataCaptured(nullable:true)
		    dataCaptureDate(nullable:true)
		    dataCapturedBy(nullable:true)
		    dataCaptureStatus(nullable:true)
		    dataCaptureComments(nullable:true)
		    instrumentReady(nullable:true)
		    instrumentReadyDate(nullable:true)
		    instrumentReadyBy(nullable:true)
		    instrumentReadyStatus(nullable:true)
		    instrumentReadyComments(nullable:true)
		    instrumentCollected(nullable:true)
		    instrumentCollectedDate(nullable:true)
		    instrumentCollectedBy(nullable:true)
		    instrumentCollectedStatus(nullable:true)
		    instrumentCollectedComments(nullable:true)

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
    
    Boolean dataCaptured
    Date dataCaptureDate
    Individual dataCapturedBy
    String dataCaptureStatus
    String dataCaptureComments
    
    Boolean instrumentReady
    Date instrumentReadyDate
    Individual instrumentReadyBy
    String instrumentReadyStatus
    String instrumentReadyComments

    Boolean instrumentCollected
    Date instrumentCollectedDate
    Individual instrumentCollectedBy
    String instrumentCollectedStatus
    String instrumentCollectedComments

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

        String toString() {
            return departmentCode?.toString()+":"+voucherNo
    	  }
}
