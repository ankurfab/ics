package ics

class Bank {

    static constraints = {
    dateCreated()
    creator()
    lastUpdated()
    updator()
    }
    String name
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static hasMany = [donations:Donation]
    
    String toString() {
        return name
	  }
}
