package ics

class Image {

    static constraints = {
    	name(nullable:true)
    	description(nullable:true)
    }
    
    String name
    String description
    
    byte[] imageData
    String imageType

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    String toString() {
    	return name
    }
}
