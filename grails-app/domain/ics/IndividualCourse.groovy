package ics

class IndividualCourse {

    static constraints = {
	    individual()
	    course()
    }
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator 

    static belongsTo = [individual:Individual, course:Course]
    
    String toString() {
	individual.toString() + " has taken course/workshop " + course.toString()
	}
}
