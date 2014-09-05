package ics

class Name {

    static constraints = {
    	nativeName(nullable:true)
    }
    
    String name		//name in english letters for eg. arbi for colacacia
    Language language
    String nativeName	//unicode
    

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    String toString() {
    	return name
    }
}
