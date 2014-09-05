package ics

class OtherContact {
    static constraints = {
    individual()
    category()
    contactType()
    contactValue()
    clean(nullable:true)

    dateCreated()
    creator()
    lastUpdated()
    updator()
    }

    String category
    String contactType
    String contactValue
    Individual individual
    Boolean clean

    Date dateCreated
    Date lastUpdated
    String creator
    String updator


                String toString() {
    	        return category+":"+contactType+":"+contactValue
    		  }

}
