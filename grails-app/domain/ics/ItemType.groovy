package ics

class ItemType {

    String type
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static hasMany = [categories:ItemCategory]
    
    static constraints = {
 
	type()   
  
	creator()
	dateCreated()
	updator()
	lastUpdated()	
  }
  
  String toString() {
  	return type
  }

}
