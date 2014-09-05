package ics

class RecipeType {

    String name
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static constraints = {
    
 	name()   
    
    	creator()
    	dateCreated()
    	updator()
    	lastUpdated()

    }
    
    String toString() {
      	return name
      }

}
