package ics

class Image {

    static constraints = {
    	name(nullable:true)
    	description(nullable:true)
    	entity(nullable:true)
    	entityId(nullable:true)
    	category(nullable:true)
    	type(nullable:true)
    	status(nullable:true)
    	imageData(maxSize: 65535 /* 64K */)
    }
    
    String name
    String description
    String entity
    Long entityId
    String category
    String type
    String status
    
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
