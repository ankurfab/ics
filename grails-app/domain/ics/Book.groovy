package ics

class Book {

    static constraints = {
    name()
    author()
    publisher(nullable:true)
    category()
    language(nullable:true)
    alias(nullable:true)
    costPrice(nullable:true)
    sellPrice(nullable:true)
    stock(nullable:true)
    reorderLevel(nullable:true)
    point(nullable:true)
    }
    
    String name
    String author
    String publisher
    String category
    String type
    String language
    String alias
    BigDecimal costPrice
    BigDecimal sellPrice
    Integer stock
    Integer reorderLevel
    Boolean orderable=true
    Boolean returnable=false
    BigDecimal point
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator 

    static hasMany = [stocks:BookStock]	//to take care of stocks of the book at varying purchase price
    
    String toString() {
	name+':'+(language?:'')+':'+(sellPrice?:'')+':'+(type?:'')+':'+(category?:'')
	}
}
