package ics

class Sadhana {

    static constraints = {
	    devotee()
	    day()
	    attendedMangalAratik(nullable:true)
	    numRoundsBefore9(nullable:true)
	    numRoundsBetween9And12(nullable:true)
	    numRoundsBetween12And6(nullable:true)
	    numRoundsBetween6And9(nullable:true)
	    numRoundsAfter9(nullable:true)
	    minutesRead(nullable:true)
	    minutesHeard(nullable:true)
	    minutesAssociated(nullable:true)
	    attendedSandhyaAratik(nullable:true)
	    comments(nullable:true)
    }
    
    Individual devotee
    Date day
    Boolean attendedMangalAratik
    Integer numRoundsBefore9
    Integer numRoundsBetween9And12
    Integer numRoundsBetween12And6
    Integer numRoundsBetween6And9
    Integer numRoundsAfter9
    Integer minutesRead
    Integer minutesHeard
    Integer minutesAssociated
    Boolean attendedSandhyaAratik
    String comments
    
    String toString() {
    	devotee.toString()+":"+day.format("dd-MM-yyyy")
    }
    
    
}
