package ics

class Scheme {
    static constraints = {
	    department(nullable:true)
	    name()
	    category()
	    minAmount()
	    description(size:1..2000)
	    benefits(size:1..2000)
	    effectiveFrom()
	    effectiveTill()
	    costCategory(nullable:true)
	    costCenter(nullable:true)
	    costCategoryAlias(nullable:true)
	    costCenterAlias(nullable:true)
	    cc(nullable:true)

	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
    
    Department department
    String category
    String name
    int minAmount
    String benefits
    Date effectiveFrom
    Date effectiveTill
    String description
    String costCategory
    String costCenter
    String costCategoryAlias
    String costCenterAlias
    CostCenter cc

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static hasMany = [donations:Donation, gifts:Gift]
    
                String toString() {
                    return name
    	  }

}
