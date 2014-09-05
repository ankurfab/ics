package ics

class MenuItem {

    RecipeVersion recipe

    //ordered
    BigDecimal oqty
    Unit ounit
    
    //yield
    BigDecimal yqty
    Unit yunit
    
    //surplus
    BigDecimal sqty
    Unit sunit
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static belongsTo = [menu:Menu]

    static constraints = {


	recipe()
	oqty(nullable:true)
	ounit(nullable:true)
	
	yqty(nullable:true)
	yunit(nullable:true)

	sqty(nullable:true)
	sunit(nullable:true)
	  

	creator(nullable:true)
	dateCreated()
	updator(nullable:true)
	lastUpdated()
	
    }

	String toString() {
		      	return recipe?.recipe?.name;
	}

}
