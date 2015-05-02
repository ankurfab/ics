package ics

class Code {

    static constraints = {
    	codeno()
    	centre(nullable:true)
    	department(nullable:true)
    	type(nullable:true)
    	category(nullable:true)
    	status(nullable:true)
    	validFrom(nullable:true)
    	validTill(nullable:true)
    }
    
    String codeno
    Centre centre
    Department department
    String type
    String category
    String status
    Date validFrom
    Date validTill

    String toString() {
            return codeno
	  }
    
}
