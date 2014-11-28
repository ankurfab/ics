package ics

class ShareCertificate {

    static constraints = {
    	certificateNo()
    	shareNos(nullable:true,blank:true)
    	numShares(nullable:true)
    	amountShares(nullable:true)
    	status(nullable:true,blank:true)
    }
    
    String certificateNo
    String shareNos
    BigDecimal numShares
    BigDecimal amountShares
    String status
    
    static hasMany = [shares: Share]

    String toString() {
        return certificateNo+"(Quantity:"+(numShares?:'')+" Amount:"+(amountShares?:'')+" Nos:"+(shareNos?:'')
	  }

}
