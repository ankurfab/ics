package ics

class InstructionGroup {

   int sequence 
   //int timelineMinutes
   /*int from
   int to */
	
   static hasMany = [instructionSeq:InstructionSequence]
   static belongsTo = [recipeVersion: RecipeVersion]

    static constraints = {
    
    /*from(nullable:true)
    to(nullable:true)*/
    }
}
