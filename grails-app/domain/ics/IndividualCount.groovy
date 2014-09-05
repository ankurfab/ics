package ics

class IndividualCount {

    IndividualCategory individualCategory
    Integer num
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static constraints = {


	individualCategory()
	num()

	creator()
	dateCreated()
	updator()
	lastUpdated()

	}

	String toString() {
	      	return individualCategory.toString()+' '+num
	}

}
