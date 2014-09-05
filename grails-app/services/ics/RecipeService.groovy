package ics

class RecipeService {

    def serviceMethod() {

    }
    
    
    
    def createRecipe(Map m){
    
    println "inside Recipe Service : "+ m
    
            def recipeVersionInstance
            def recipeInstance
            
            
            switch (m.Command) {
	    		case "create":
				recipeInstance = new Recipe(m)
				//recipeInstance = Recipe.get(m.recipeId)
				println "in create"
				break;
				
			case "edit":
				recipeInstance = Recipe.get(m.recipeId)
				            	
				recipeInstance.name=m.name
				recipeInstance.cuisine=m.cuisine
				
				recipeInstance.category=[]
				m.category.each{
					 recipeInstance.category.add(Category.get(it))
				}
				
				recipeInstance.rating=m.rating      
				recipeInstance.spicy=m.spicy
				recipeInstance.healthy=m.healthy
				recipeInstance.economical=m.economical
				recipeInstance.preprationtime=m.preprationtime
				recipeInstance.shelflife=m.shelflife
				recipeInstance.feedback=m.feedback				

			        //recipeInstance.id=m.recipeId
				recipeInstance.defaultRecipe.chef=Person.get(m.chef.id)
				recipeVersionInstance = recipeInstance.defaultRecipe			                    
            			
            			break;            			            		
            		}	
			
					
			
            recipeInstance.creator = "system"	//todo get username from spring security core 
            recipeInstance.updator = recipeInstance.creator //
            
            /*
            recipeInstance.spicy=""
            recipeInstance.healthy=""
            recipeInstance.economical=""
            recipeInstance.preprationtime=""
            recipeInstance.shelflife=""
            recipeInstance.feedback=""
            */
            
            if (!recipeInstance.save(flush: true)) {
            
                recipeInstance.errors.allErrors.each {
				    	println it
    			}
            
                //render(view: "create", model: [recipeInstance: recipeInstance])
                return 0
            }
            
    
    	def inst
         if(m.Command=="create")
         {
        
                recipeVersionInstance = new RecipeVersion(m)
        	        recipeVersionInstance.creator = "system"	//todo get username from spring security core 
        	        recipeVersionInstance.updator = recipeVersionInstance.creator     	        
        	            	        
        		recipeVersionInstance.rating='ONE'
        		recipeVersionInstance.feedback='OK'
        		recipeVersionInstance.comments='ok'
        		
        		recipeVersionInstance.name=m.name		
        		//recipeVersionInstance.chef=m.chef.id          		
        		
        		if(m.yield1)
        			recipeVersionInstance.yield1=Double.valueOf(m.yield1)
        		if(m.yield2)
        			recipeVersionInstance.yield2=Double.valueOf(m.yield2)
        		if(m.yield3)
        			recipeVersionInstance.yield3=Double.valueOf(m.yield3)
        		recipeVersionInstance.yieldUnit1=m.unit1
        		recipeVersionInstance.yieldUnit2=m.unit2
        		recipeVersionInstance.yieldUnit3=m.unit3        		
        		
        		recipeVersionInstance.recipe=recipeInstance
        		    
        		              	       
        	        if (!recipeVersionInstance.save(flush: true)) {
        	        
        	            recipeVersionInstance.errors.allErrors.each {
    		    			    	println it
        			}
        	            //render(view: "create", model: [recipeVersionInstance: recipeVersionInstance])
        	            return 0
                	} 
          		
          	   println "inside Recipe version create : "+ recipeVersionInstance.yield1 	
                                
                    recipeInstance.recipeVersions= []
                    recipeInstance.recipeVersions.add(recipeVersionInstance)
                    recipeInstance.defaultRecipe = recipeVersionInstance
                    recipeInstance.save()
                    
                    
                    
                    inst= new Instruction()
                    inst.instructionString=""
                    inst.ingredients = []
                    if (!inst.save(flush: true)) {

			    inst.errors.allErrors.each {
							println it
			}
		    }

                    
                    def is = new InstructionSequence()
                    is.sequence=0
                    is.instruction= inst
                    if (!is.save(flush: true)) {
		    		            	        
			    is.errors.allErrors.each {
							println it
			}
		     }
                    
                    
                    def ig = new InstructionGroup()
                    ig.recipeVersion = recipeVersionInstance
                    ig.sequence = 0
                    ig.instructionSeq= []
                    ig.instructionSeq.add(is)
                    
                    if (!ig.save(flush: true)) {
		            	        
			    ig.errors.allErrors.each {
							println it
			}
		    }	
		    
		    
                    recipeVersionInstance.instructionGroup=[]
                    recipeVersionInstance.instructionGroup.add(ig)
                    recipeVersionInstance.save()
                    
                    println "PRINT BEFORE RETURN:" + recipeVersionInstance.id + "AND" + inst.id
                    
	    }
	        
            return recipeVersionInstance.id
            //return inst.id //todo verify
    }

   
    def verify(){
    	//create deafault recipe
    	def recipe = new Recipe()
    	recipe.name = ""
    	
    	
    	//create default recipeversion
    	def rv = new RecipeVersion()
    	rv.name = "default recipe version"
       	rv.chef = Person.get(1)

    	
    	//create default instruction group
    	def ig = new InstructionGroup()
    	ig.sequence = 1
    	
    	//create default instruction seq
	  def instseq = new InstructionSequence()
	  instseq.sequence = 1

    	//create default instruction
	  def inst = new Instruction()
	  inst.instructionString = ""
    	
	def ic = new ItemCount()
	ic.item = Item.get(1)
	ic.qty = 1
	ic.unit = "KG"
	
	inst.ingredients = []
	inst.ingredients.add(ic)
	
	instseq.instruction = inst
	
	ig.instructionSeq = []
	ig.instructionSeq.add(instseq)
	
	rv.instructionGroup = []
	rv.instructionGroup.add(ig)

    	//recipe.defaultRecipe=rv
    	recipe.recipeVersions=[]
    	recipe.recipeVersions.add(rv)

    	if(!recipe.save())
    		recipe.errors.allErrors.each{println it}
    }

    def getIngredients(MenuItem menuItemInstance) {
    
        int i=0
    
    	println "\n"+"Instructions before cooking:"
    	print "      "+menuItemInstance.recipe.preprocInstructions + "\n"
    	
    	println "\n"+"Ingredients:"    	
    	
    	menuItemInstance.recipe.ingredients?.each{
    	    			
    		println "\n" + menuItemInstance.recipe.ingredients.item[i]
    		print menuItemInstance.recipe.ingredients.qty[i] +"  "+menuItemInstance.recipe.ingredients.unit[i]
    		 
    		i++    	
    	}
    	println "\n"+"Cooking instructions:"
    	println "      "+ menuItemInstance.recipe.cookingInstructions + "\n"
    	    	    
    	    	
    	/*
    	recipe.preporc
    	for each   
    		Qty=itemCountVar.qty/recipe.qty X Yqty .
    		
    		Println itemcountVar.item+' '+Qty  
    	
    	recipe.cookingInstructions
    	*/
    	
	
    }


    def yieldtoIngredients(RecipeVersion rv, BigDecimal yieldQuantity, Unit unit) 	
    {
             	/*        	
        	NOTE: Yield never has to be fed with conversion factor. There will be a standard Recipe that will be 
        	entered with standard quantity of the individual ingredients. The yield may be entered in more than 
        	one unit eg: Ladoo in KG and NUMBERS. But in either case using simple unitary method you can calculate 
        	the quantity in the standard unit specified.Make approriate changes to include more than one unit in 
        	domain.
        	
        	Only in case when individual units you want to see in some other unit then you have to use the 
        	density factor of individual items to display items in desired unit. Like a house wife recipe you want 
        	use it in mass qauntity Kitchen. Or Vice versa        	
        	*/               
        	
        	def standardYield        	
        	
        	if(rv.yieldUnit1 == unit)
        	{	
        		standardYield = rv.yield1
        	}
               	else if(rv.yieldUnit2 == unit)
		{	
			standardYield = rv.yield2
		}
		else if(rv.yieldUnit3 == unit)
		{	
			standardYield = rv.yield3
		}		
		
        	def ig = InstructionGroup.findBySequenceAndRecipeVersion(0,rv)
        	
        	ig.is.each{is->
        		is.instruction.ingredients.each{ic->
        	
        	   		ic.qty= ic.nqty/standardYield * yieldQuantity   
        	   	               	   		
               	   		ic.unit = ic.nunit
               	   		//Here we are dealing with the standard units only
				
        	   		ic.save() 
        		}
        	}        
    }

}
