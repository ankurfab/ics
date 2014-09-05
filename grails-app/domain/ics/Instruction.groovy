package ics

class Instruction {

    String instructionString
    
    static hasMany = [ingredients:ItemCount]
    //static belongsTo = [instructionSequence: InstructionSequence]

    static constraints = {
    ingredients(nullable:true) //tod is it correct?    
    }
    
    String toString() {
    	instructionString	//todo show only max 10chars or so..
    }
}
