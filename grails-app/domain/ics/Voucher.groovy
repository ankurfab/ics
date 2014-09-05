package ics

class Voucher {

    static constraints = {
	    voucherDate()
	    departmentCode()
	    voucherNo()
	    amount(nullable:true)
	    description(nullable:true,blank:true)
	    amountSettled(nullable:true)
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }

    Date voucherDate
    CostCenter departmentCode
    String voucherNo
    Integer amount
    String description
    Integer amountSettled

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

        String toString() {
            return departmentCode?.toString()+":"+voucherNo
    	  }
}
