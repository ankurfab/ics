package ics

class RelationshipGroup {
    static constraints = {
    groupName()
    comments(nullable:true, blank:true)
    category(nullable:true, blank:true)
    status(nullable:true, blank:true)
    refid()
    fromDate(nullable:true)
    tillDate(nullable:true)

    dateCreated()
    creator()
    lastUpdated()
    updator()
    }
    String groupName
    String comments
    Integer refid	//@TODO: this should have been long
    String category	//Family,BookDistribution etc
    String status	//Active,Inactive,Deleted
    Date fromDate	//group effective from
    Date tillDate	//group effective till

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static hasMany = [relationships:Relationship]
    
    String toString() {
    return groupName
    }
}
