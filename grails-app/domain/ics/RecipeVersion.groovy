package ics


class RecipeVersion {

    String name

    Rating rating
    String feedback
    Individual chef
    String comments
    RecipeStatus recipeStatus
    
    BigDecimal yield1
    Unit yieldUnit1
     
    BigDecimal yield2
    Unit yieldUnit2
    
    BigDecimal yield3
    Unit yieldUnit3
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static belongsTo = [recipe:Recipe]

    static hasMany = [instructionGroup:InstructionGroup]

    static constraints = {
        	
    	name()
    	
    	rating(nullable:true)
    	feedback(nullable:true)
    	chef()
    	recipeStatus()    	
    	
    	yield1(nullable:true)
    	yieldUnit1(nullable:true)
    	
    	yield2(nullable:true)
	yieldUnit2(nullable:true)
    	
    	yield3(nullable:true)
	yieldUnit3(nullable:true)
    	
    	comments(nullable:true)
    	    
    	creator(nullable:true)
    	dateCreated()
    	updator(nullable:true)
    	lastUpdated()

    }
    
    String toString() {
      	return name
      }

}
