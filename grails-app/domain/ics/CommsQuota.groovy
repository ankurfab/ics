package ics

class CommsQuota {

    static constraints = {
    	sender()
    	depcp()
    	quota()
    }
    
    Individual sender
    DepartmentCP depcp
    Integer quota
    
}
