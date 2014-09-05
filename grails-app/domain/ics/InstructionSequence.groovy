package ics

class InstructionSequence {
	
    Instruction instruction
    int sequence
    /*
    int from 
    int to 
    */
    
    //static belongsTo = [instructionGroup:InstructionGroup]

    //static hasOne = [instruction:Instruction]

    static constraints = {
    	instruction unique: true
    	
    	/*from(nullable:true)
        to(nullable:true)*/        
    }
    
    String toString() {
        	sequence+":"+instruction.toString()	
    }
}
