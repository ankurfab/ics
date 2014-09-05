package ics

class AccommodationAllotment {
	static constraints = {
	    numberofPrabhujisAllotted blank: false, nullable:false
	    numberofMatajisAllotted   blank: false, nullable:false
	    numberofChildrenAllotted  blank: false, nullable:false
	    numberofBrahmacharisAllotted  blank: false, nullable:false
	    
	    subEventRegistration nullable:true
	
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()

	    eventRegistration(unique:['eventAccommodation'])

	}

	int		numberAllotted
	int		numberofPrabhujisAllotted
	int		numberofMatajisAllotted
	int		numberofChildrenAllotted
	int		numberofBrahmacharisAllotted
	Date allottFrom
	Date allottTill

	int		numberCheckedin=0
	int		numberofPrabhujisCheckedin=0
	int		numberofMatajisCheckedin=0
	int		numberofChildrenCheckedin=0
	int		numberofBrahmacharisCheckedin=0

	AccommodationAllotment() {
	    numberAllotted = 0
	    numberofPrabhujisAllotted = 0
	    numberofMatajisAllotted = 0
	    numberofChildrenAllotted = 0
	    numberofBrahmacharisAllotted = 0
	}

	static belongsTo = [eventRegistration: EventRegistration, eventAccommodation:EventAccommodation, subEventRegistration: EventRegistration]

	Date dateCreated
	Date lastUpdated
	String creator
	String updator

}
