package ics

class Cuisine {

    String name
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static hasMany = [recipe: Recipe]

    static constraints = {
    
        name()
        recipe()
    
        creator()
    	dateCreated()
    	updator()
	lastUpdated()
    }
    
    String toString() {
    	return name
    }

}
