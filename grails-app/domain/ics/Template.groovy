package ics

class Template {

    static constraints = {
    	name()
    	code(nullable:true)
    	body(minSize:1,maxSize:4000)
    	category(nullable:true)
    	type(nullable:true)
    	department(nullable:true)
    }
    
    String name
    String code
    String body
    String category	//email,sms etc
    String type		//html,text,unicode etc
    Department department
    
	String toString() {
	    return name+":"+(code?:'')+":"+body.substring(10)+":"+(category?:'')+":"+(type?:'')+":"+(department?:'')
		}
    
}
