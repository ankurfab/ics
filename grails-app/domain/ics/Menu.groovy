package ics

class Menu {

    Meal meal
    Date mealDate
    
    BigDecimal totalCost
    BigDecimal mealCost
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator


    static hasMany = [menuItems:MenuItem, orderedIndividualCounts: IndividualCount, actualIndividualCounts: IndividualCount]

    static belongsTo = [menuChart:MenuChart] 

    static constraints = {
  
	meal()
	mealDate()

	menuItems(nullable:true)
	orderedIndividualCounts(nullable:true)
	actualIndividualCounts(nullable:true)
	
	
	totalCost(nullable:true)
	mealCost(nullable:true)
	  
	  

	creator(nullable:true)
	dateCreated()
	updator()
	lastUpdated(nullable:true)
    }

	String toString() {
		      	return meal.toString()
	}
}
