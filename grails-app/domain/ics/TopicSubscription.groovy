package ics

class TopicSubscription {

    static constraints = {
    	individual(nullable:true)
    	person(nullable:true)
    	language(nullable:true)
    }
    
    Individual individual
    Person person
    String language
    Boolean viaSMS=false
    Boolean viaEmail=true
    Boolean viaPost=false
    

    static belongsTo = [topic:Topic]


    String toString() {
	(person?.toString()?:individual?.toString())+":"+topic.name
	}

}
