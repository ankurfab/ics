package ics

class District {

    static constraints = {
    	name()
    }
    
    String name
    
    static hasMany = [talukas:Taluka]

    String toString() {
    	name
    }
    
}
