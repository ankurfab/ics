package ics

class CommsProvider {

    static constraints = {
	name(nullable:true)
	type(nullable:true) 
	baseUrl(nullable:true)
	path(nullable:true)
	query(nullable:true)
	apikey(nullable:true)
	uri(nullable:true)
	user(nullable:true)
	pwd(nullable:true)
	host(nullable:true)
	port(nullable:true)  
    }
    
    String name
    String type	//sms , email, smtp
    String baseUrl
    String path
    String query
    String uri
    String user
    String pwd
    String apikey
    String  host
    Integer port
    
    String toString() {
	name
	}
    
    
}
