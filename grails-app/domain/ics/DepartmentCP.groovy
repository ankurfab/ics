package ics

class DepartmentCP {

    static constraints = {
    	sender(nullable:true)
    }
    
    Department department
    CommsProvider cp
    String sender
    Integer count=0
    
    String toString() {
	department +" : "+cp+" : "+count
	}
    
}
