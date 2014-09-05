package ics

class Centre {

    static constraints = {
    }
    
    String name
    String address
    String description

    Date dateCreated
    Date lastUpdated
    String creator
    String updator 
    
    static hasMany = [departments: Department]

    String toString() {
	name
	}
    
}
