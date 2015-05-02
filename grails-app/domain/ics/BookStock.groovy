package ics

class BookStock {

    static constraints = {
    }
    
    Date stockDate
    BigDecimal price
    Integer stock

    Date dateCreated
    Date lastUpdated
    String creator
    String updator 

    static belongsTo = [book: Book]
    
}
