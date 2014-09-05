package ics

class Receipt {

    static constraints = {
    receiptBook()
    receiptNumber()
    isBlank()
    book(nullable:true)


    dateCreated()
    creator()
    lastUpdated()
    updator()
    }

    String receiptNumber
    String book
    boolean isBlank

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static belongsTo = [receiptBook:ReceiptBook]

            String toString() {
                return receiptBook?.toString()+"/"+receiptNumber
        	  }


}
