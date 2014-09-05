package ics

class PaymentMode {

    static constraints = {
    inperson(nullable:true)
    dateCreated()
    creator()
    lastUpdated()
    updator()
    }

    String name
    Boolean inperson	//whether this payment mode can be accepted across the counter
    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
             String toString() {
                    return name
    	  }
}
