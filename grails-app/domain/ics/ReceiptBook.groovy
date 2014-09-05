package ics

class ReceiptBook {

    static constraints = {
    category(nullable:true)
    bookSeries(nullable:true)
    bookSerialNumber()
    status(nullable:true)
    comments(nullable:true)
    startingReceiptNumber()
    numPages()
    isBlank(nullable:true)

    dateCreated()
    creator()
    lastUpdated()
    updator()

    }

    String category
    String bookSeries
    int bookSerialNumber
    boolean isBlank
    int startingReceiptNumber
    int numPages
    String status
    String comments
    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static hasMany = [receipts:Receipt]

	static mapping = {
		receipts sort:'receiptNumber'
	}
    
            String toString() {
            
            	//(category?:"")+"/"+(bookSeries?:"")+bookSerialNumber
            	(bookSeries?:"")+bookSerialNumber
            	/*if (bookSeries==null || bookSeries.trim().length()==0)
                	return bookSerialNumber
                else
                	return bookSeries?.toString()+bookSerialNumber*/
                
        	  }

}
