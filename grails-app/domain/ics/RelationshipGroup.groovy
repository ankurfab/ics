package ics

class RelationshipGroup {
    static constraints = {
    groupName()
    comments(nullable:true, blank:true)
    refid()

    dateCreated()
    creator()
    lastUpdated()
    updator()
    }
    String groupName
    String comments
    Integer refid

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static hasMany = [relationships:Relationship]
    
    String toString() {
    return groupName
    }
}
