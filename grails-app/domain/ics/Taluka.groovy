package ics

class Taluka {

    static constraints = {
    	name()
    }
    
    String name
    
    static hasMany = [villages:Village]
    static belongsTo = [district: District]

    String toString() {
    	name
    }
}
