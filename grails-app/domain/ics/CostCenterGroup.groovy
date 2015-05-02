package ics

class CostCenterGroup {

    static constraints = {
	    name()
	    description(nullable:true)
	    owner(nullable:true)
	    owner1(nullable:true)
	    owner2(nullable:true)
	    status(nullable:true)
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
    
    String name
    String description
    Individual owner
    Individual owner1
    Individual owner2
    String status

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static hasMany = [costCenters:CostCenter]

	String toString() {
	    return name
	  }
    
}
