package ics

class AttributeValue {

    static constraints = {
    }
    
    String objectClassName
    Long objectId
    Attribute attribute
    String value
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator


    String toString() {
    	return value
    }

}
