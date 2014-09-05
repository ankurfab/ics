package ics

class Vehicle {

    static constraints = {
	    regNum(unique:true)
	    model()
	    make(nullable:true, blank:true)
	    type(nullable:true, blank:true)
	    numCapacity()
	    comments(nullable:true, blank:true)
	    status(nullable:true, blank:true)
	    availableFrom()
	    availableTill()
	    owner(nullable:true)
	    driver(nullable:true)
	    assistant(nullable:true)
	    ownerName(nullable:true, blank:true)
	    ownerNumber(nullable:true, blank:true)
	    driverName(nullable:true, blank:true)
	    driverNumber(nullable:true, blank:true)
	    assistantName(nullable:true, blank:true)
	    assistantNumber(nullable:true, blank:true)
    }
    
    String regNum
    String model
    String make
    String type
    Integer numCapacity
    String comments
    String status
    Date availableFrom
    Date availableTill

    Individual owner
    Individual driver
    Individual assistant
    
    String ownerName
    String ownerNumber
    String driverName
    String driverNumber
    String assistantName
    String assistantNumber
    
    Boolean vipExclusive = false
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    String toString() {
    	return model+"("+(type?:"") +" "+regNum+")"
    }
}
