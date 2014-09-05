package ics

class CostCenter {

    static constraints = {
	    name()
	    alias()
	    owner(nullable:true)
	    owner1(nullable:true)
	    owner2(nullable:true)
	    budget(nullable:true)
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }

    String name
    String alias
    Individual owner
    Individual owner1
    Individual owner2
    Integer budget	//monthly budget

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static belongsTo = [costCategory: CostCategory]

        String toString() {
            return name+"("+costCategory?.alias+alias+")"
    	  }
}
