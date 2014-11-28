package ics

class Village {

    static constraints = {
    	name()
    }
    
    String name
    
    static belongsTo = [taluka: Taluka]

    String toString() {
    	name
    }
}
