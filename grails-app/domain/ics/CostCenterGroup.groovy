package ics

class CostCenterGroup {

    static constraints = {
	    name()
	    description(nullable:true)
	    owner(nullable:true)
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
    
    String name
    String description
    Individual owner

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static hasMany = [costCenters:CostCenter]

	String toString() {
	    return name
	  }
    
}
