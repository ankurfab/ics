package ics

class Role {
    static constraints = {
    name()
    description()
    category()
    authority(nullable:true)

    dateCreated()
    creator()
    lastUpdated()
    updator()

    }
    String name
    String description
    String category
    String authority

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

   static hasMany = [individualRoles:IndividualRole]
   
   String toString() {
   		  return name
	  }
}
