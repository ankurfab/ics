package ics

class Department {

    String name
    String description
    String alias
    CostCenter costCenter
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static belongsTo = [centre:Centre]
    static hasMany = [individualRoles:IndividualRole]    
    
    static constraints = {
  
        name()
        description(nullable:true, blank:true)
        alias(nullable:true,unique:true)
        costCenter(nullable:true)
                
	creator()
	dateCreated()
	updator()
	lastUpdated()

     }
     
     String toString() {
     	return name+" ("+centre?.name+") "
     	}

}
