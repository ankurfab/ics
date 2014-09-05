package ics

class IndividualLanguage {

    static constraints = {
    
    }
    Integer readFluency	= 5//1-10, 1 -> low, 10 -> high
    Integer writeFluency = 5 //1-10, 1 -> low, 10 -> high
    boolean motherTongue = false

    Date dateCreated
    Date lastUpdated
    String creator
    String updator 
    
    static belongsTo = [individual:Individual, language:Language]

    String toString() {
	if(motherTongue)
		individual?.toString() + " mother tongue is " + language?.toString()
	else
		individual?.toString() + " knows " + language?.toString() + " with fluency Read("+readFluency+"), Write("+writeFluency+")"
	}

}
