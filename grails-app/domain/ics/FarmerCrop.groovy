package ics

class FarmerCrop {

    static constraints = {
    	comments(nullable:true)
    }
    
    BigDecimal area
    String comments
    
    static belongsTo = [farmer:Farmer, crop:Crop]
    
    String toString() {
        return farmer.toString()+":"+crop+":"+area
	  }
    
}
