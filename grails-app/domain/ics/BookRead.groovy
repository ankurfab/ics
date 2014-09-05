package ics

class BookRead {

    static constraints = {
    individual()
    book()
    }

    Date dateCreated
    Date lastUpdated
    String creator
    String updator 

    static belongsTo = [individual:Individual, book:Book]
    
    String toString() {
	individual.toString() + " has read " + book.toString()
	}

}
