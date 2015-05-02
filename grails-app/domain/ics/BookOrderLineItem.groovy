package ics

class BookOrderLineItem {

    static constraints = {
    }

    Book book
    Integer requiredQuantity

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static belongsTo = [order: BookOrder]



}
