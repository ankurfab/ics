package ics

class Relation {

    static constraints = {
    name()
    category(nullable:true)

    dateCreated()
    creator()
    lastUpdated()
    updator()
    }

    String name
    String category
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static hasMany = [relationship:Relationship]
    
    String toString() {
    return name
    }
}
