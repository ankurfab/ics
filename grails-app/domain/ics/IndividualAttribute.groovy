package ics

class IndividualAttribute {

    static constraints = {
    }
    
    Individual individual
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
