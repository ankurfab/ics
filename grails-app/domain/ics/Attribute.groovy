package ics

class Attribute {

    static constraints = {
    	name()
    	type(nullable:true)
    	category(nullable:true)
    	department(nullable:true)
    	centre(nullable:true)
    	displayName(nullable:true)
    	domainClassName(nullable:true)
    	domainClassAttributeName(nullable:true)
    	position(nullable:true)
    }
    
    Department department
    Centre centre
    String type
    String category
    String name
    String displayName
    String domainClassName
    String domainClassAttributeName
    Integer position	//for quicker csv upload, 0 based
    
    String toString() {
    	return name
    }
    
}
