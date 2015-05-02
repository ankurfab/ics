package ics

class CostCategory {

    static constraints = {
	    name()
	    alias()
	    owner(nullable:true)
	    status(nullable:true)
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }

    String name
    String alias
    Individual owner
    String status

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static hasMany = [costCenters:CostCenter]
    
        String toString() {
            return name+"("+alias+")"
    	  }
}
