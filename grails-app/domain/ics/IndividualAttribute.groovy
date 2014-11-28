package ics

class IndividualAttribute {

    static constraints = {
    	attrName(nullable:true)
    }
    
    Individual individual
    Attribute attribute
    String attrName
    String attrValue
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    String toString() {
    	return attrName+" : "+attrValue
    }
}
