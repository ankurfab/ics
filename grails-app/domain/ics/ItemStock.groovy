package ics

class ItemStock {

    Item item
    
    BigDecimal qty
    Unit unit
    BigDecimal rate

    BigDecimal nqty	//normalized
    Unit nunit		//normalized
    BigDecimal nrate	//normalized


    Individual supplementedBy
    Date supplementedOn
    String supplementComments
    Individual consumedBy
    Date consumedOn
    String consumeComments
    Individual auditedBy
    Date auditedOn
    String auditComments
    
    Department department

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static constraints = {
	    supplementedBy(nullable:true)
	    consumedBy(nullable:true)
	    auditedBy(nullable:true)
	    department(nullable:true)
	    supplementedOn(nullable:true)
	    consumedOn(nullable:true)
	    auditedOn(nullable:true)
	    supplementComments(nullable:true)
	    consumeComments(nullable:true)
	    auditComments(nullable:true)
	}

}
