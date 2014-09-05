package ics

class ReceiptSequence {

    static constraints = {
    	department(nullable:true)
    }
    
    String type
    Department department
    Long seq
}
