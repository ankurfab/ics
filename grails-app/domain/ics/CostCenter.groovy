package ics

class CostCenter {

    static constraints = {
	    name()
	    alias()
	    owner(nullable:true)
	    owner1(nullable:true)
	    owner2(nullable:true)
	    budget(nullable:true)
	    quarterBudget(nullable:true)
	    yearBudget(nullable:true)
	    balance(nullable:true)
	    quarterBalance(nullable:true)
	    yearBalance(nullable:true)
	    capitalBudget(nullable:true)
	    capitalQuarterBudget(nullable:true)
	    capitalYearBudget(nullable:true)
	    capitalBalance(nullable:true)
	    capitalQuarterBalance(nullable:true)
	    capitalYearBalance(nullable:true)
	    isProfitCenter(nullable:true)
	    isServiceCenter(nullable:true)
	    costCenterGroup(nullable:true)
	    donationAccepted(nullable:true)
	    status(nullable:true)
	    centre(nullable:true)
	    
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
    Integer budget	//current monthly budget
    Integer quarterBudget	//current quaterly budget
    Integer yearBudget	//current yearly budget
    BigDecimal balance	//current monthly balance
    BigDecimal quarterBalance	//current quaterly balance
    BigDecimal yearBalance	//current yearly balance
    Integer capitalBudget	//current monthly capital budget
    Integer capitalQuarterBudget	//current capital quaterly budget
    Integer capitalYearBudget	//current capital yearly budget
    BigDecimal capitalBalance	//current capital monthly balance
    BigDecimal capitalQuarterBalance	//current capital quaterly balance
    BigDecimal capitalYearBalance	//current capital yearly balance
    Boolean isProfitCenter	//can spend only as much as it has earned
    Boolean isServiceCenter	//can provide services to other cost centers against payment
    Boolean donationAccepted	//whether the cost center can accept donations
    String status
    Centre centre

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static belongsTo = [costCategory: CostCategory,costCenterGroup: CostCenterGroup]

        String toString() {
            return name+"("+costCategory?.alias+alias+")"
    	  }
}
