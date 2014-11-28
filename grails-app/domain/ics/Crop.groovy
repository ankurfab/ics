package ics

class Crop {

    static constraints = {
    }
    
    String name

    String toString() {
        return name
	  }

    static hasMany = [farmers:FarmerCrop]

}
