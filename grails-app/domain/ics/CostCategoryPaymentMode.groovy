package ics

class CostCategoryPaymentMode {

    static constraints = {
    	costCategory()
    	paymentMode()
    	bankCode()
	    
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
    
    CostCategory costCategory
    PaymentMode paymentMode
    String bankCode

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

        String toString() {
            return bankCode+"("+costCategory?.toString+" "+paymentMode?.toString()+")"
    	  }
    
}
