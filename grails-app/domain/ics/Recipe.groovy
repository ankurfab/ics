package ics

class Recipe {

    String name
    
    /*
    Cuisine cuisine
    RecipeType type
    String category
    */
    
    String cuisine    
    String spicy 
    String healthy
    String economical
    String preprationtime
    String shelflife
    
    //Category category 
        
    RecipeVersion defaultRecipe    

    Rating rating
    String feedback
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator       
    
    static hasMany = [recipeVersions:RecipeVersion, category: Category]

    static constraints = {
    
	name()
	
	recipeVersions()
	
	defaultRecipe(nullable:true)
	
        cuisine(nullable:true)
        category()
        spicy(nullable:true) 
        healthy(nullable:true)
        economical(nullable:true)
        preprationtime(nullable:true)
        shelflife(nullable:true)


	rating(nullable:true)
	feedback(nullable:true)
	
	
	creator(nullable:true)
	dateCreated()
	updator(nullable:true)
	lastUpdated()

	}
	
	String toString() {
	  	return name
	 }

}
