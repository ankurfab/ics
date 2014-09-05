package ics

class Person {

static searchable = true

    String name
    String spouse
    String father
    String address
    String officeAddress
    String locality
    String phone
    String email
    String lmno
    String panno
    Date dob
    Date dom
    Boolean isPrimary
    Boolean isDonor
    String primaryMember
    String relation
    String reference
    
    Individual matchedIndividual
    String status
    String category
    String comments

    Date dateCreated
    Date lastUpdated
    String creator
    String updator


    static constraints = {
    
    	name()
    	spouse(nullable:true)
    	father(nullable:true)
    	address(nullable:true)
    	officeAddress(nullable:true)
    	locality(nullable:true)
    	phone(nullable:true)
    	email(nullable:true)
    	lmno(nullable:true)
    	panno(nullable:true)
    	dob(nullable:true)
    	dom(nullable:true)
	isPrimary(nullable:true)
	isDonor(nullable:true)
	primaryMember(nullable:true)
    	relation(nullable:true)
	reference(nullable:true)    	
    	matchedIndividual(nullable:true)
    	status(nullable:true)
    	category(nullable:true)
    	comments(nullable:true)
    }

    String toString() {
            return name
	  }

}
