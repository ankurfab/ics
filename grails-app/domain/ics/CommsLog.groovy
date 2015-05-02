package ics

class CommsLog {

    static constraints = {
    	template(nullable:true)
    }
    
    DepartmentCP depcp
    Template template
    Individual sender
    Integer counter
    Date dateSent
    
}
