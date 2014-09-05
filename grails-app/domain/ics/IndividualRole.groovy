package ics

class IndividualRole {

    static constraints = {
	individual()
	role()
	department(nullable:true)
	centre(nullable:true)
	status()
	remarks(nullable:true,blank:true)

	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()

    }
    
    String status //CEASED,DELETED,VALID,INVALID etc
    String remarks

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static belongsTo = [individual:Individual, role:Role,department:Department, centre:Centre]
    
    String toString() {
        return individual.toString() + " is a " + role.name + (department?(" in department "+department):"")
	  }
    
    

}
