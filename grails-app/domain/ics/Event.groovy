package ics

class Event {

    static constraints = {
    category()
    title()
    course(nullable:true)
    startDate()
    endDate()
    vstartDate(nullable:true)
    vendDate(nullable:true)
    venue()
    contactPerson()
    department(nullable:true)
    description(nullable:true)
    comments(nullable:true)
    coordinators(nullable:true)

    minAttendees(nullable:true)
    maxAttendees(nullable:true)
    minPrjiVolunteer(nullable:true)
    maxPrjiVolunteer(nullable:true)
    minMatajiVolunteer(nullable:true)
    maxMatajiVolunteer(nullable:true)

    dateCreated()
    creator()
    lastUpdated()
    updator()
    }

    String category
    String title
    Course course
    String description
    Date startDate
    Date endDate
    Date vstartDate	//for volunteers
    Date vendDate	//for volunteers
    String comments
    static hasMany = [participants:EventParticipant, coordinators: IndividualRole]
    String venue
    Individual contactPerson
    Department department
    
    Integer minAttendees=0
    Integer maxAttendees=0
    Integer minPrjiVolunteer=0
    Integer maxPrjiVolunteer=0
    Integer minMatajiVolunteer=0
    Integer maxMatajiVolunteer=0

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
        String toString() {
            return category+":"+title
    	  }
    
}
