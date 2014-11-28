package ics

class Share {

    static constraints = {
    	company()
    	shareSerialNo()
    	shareAmount()
    	status(nullable:true,blank:true)
    }
    
    String company
    String shareSerialNo
    BigDecimal shareAmount
    String status
    
    String toString() {
        return company+"/"+shareSerialNo+"/"+shareAmount
	  }
    
}
