package ics

class Book {

    static constraints = {
    name()
    author()
    category()
    }
    
    String name
    String author
    String category
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator 
    
    String toString() {
	name
	}
}
