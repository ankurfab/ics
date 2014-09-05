package ics

class IndividualSkill {

    static constraints = {
	    individual()
	    skill()
	    status()
	    comments(nullable:true)
    }
    
    String status
    String comments
    Date dateCreated
    Date lastUpdated
    String creator
    String updator 

    static belongsTo = [individual:Individual, skill:Skill]
    
    String toString() {
	individual.toString() + " with skill " + skill.toString()
	}
}
