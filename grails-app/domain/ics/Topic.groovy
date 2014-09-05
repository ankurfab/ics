package ics

class Topic {

    static constraints = {
    	name()
    	frequency inList: ["DAILY", "WEEKLY", "MONTHLY"]
    	viaEmail()
    	viaSMS()
    	viaPost()
    	comments(nullable:true)
    	status inList: ["ACTIVE", "INACTIVE"]
    }
    
    String name
    String frequency
    Boolean viaSMS=false
    Boolean viaEmail=true
    Boolean viaPost=false
    String comments
    String status

    static hasMany = [subscribers:TopicSubscription]

    String toString() {
	name
	}

}
