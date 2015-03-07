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
	    isProfitCenter(nullable:true)
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
    Boolean isProfitCenter

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static belongsTo = [costCategory: CostCategory]

        String toString() {
            return name+"("+costCategory?.alias+alias+")"
    	  }
}
