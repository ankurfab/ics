package ics

class VoiceContact {
static searchable = { only = ['number']}
static constraints = {
    individual()
    category()
    number()
    clean(nullable:true)

    dateCreated()
    creator()
    lastUpdated()
    updator()

    }
    String category
    String number
    Boolean clean

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static belongsTo = [individual:Individual]

                String toString() {
    	        return category+" : "+number
    		  }

}
