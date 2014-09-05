package ics

class CommsProvider {

    static constraints = {
	type(nullable:true) 
	uri(nullable:true)
	user(nullable:true)
	pwd(nullable:true)
	apikey(nullable:true)
	host(nullable:true)
	port(nullable:true)        
    }
    
    String type	//sms , email, smtp
    String uri
    String user
    String pwd
    String apikey
    String  host
    Integer port
    
    String toString() {
	type+" : "+uri+" : "+host
	}
    
    
}
