package ics

class BookPrice {

    static constraints = {
    }
    
    Book book
    BigDecimal price
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator 
    
    static belongsTo = [campaign: Campaign]

    String toString() {
    	book+" Price: "+price
    }
}
