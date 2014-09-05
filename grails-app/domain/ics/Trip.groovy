package ics

class Trip {

    static constraints = {
	    vehicle()
	    source()
	    destination()
	    departureTime()
	    arrivalTime(nullable:true)
	    incharge(nullable:true)
	    inchargeName(nullable:true,blank:true)
	    inchargeNumber(nullable:true,blank:true)
	    driver(nullable:true)
	    driverName(nullable:true,blank:true)
	    driverNumber(nullable:true,blank:true)
	    comments(nullable:true,blank:true)
	    category(nullable:true)
	    type(nullable:true)
	    status(nullable:true)
    }
    
    Vehicle vehicle
    String source
    String destination
    Date departureTime
    Date arrivalTime
    Individual incharge
    String inchargeName
    String inchargeNumber
    Individual driver
    String driverName
    String driverNumber
    String comments
    String category
    String type
    String status
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    String toString() {
    	return vehicle.toString()+" : "+source+"->"+destination
    }
}
