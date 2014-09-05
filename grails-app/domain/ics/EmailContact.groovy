package ics

class EmailContact {
static searchable = { only = ['emailAddress']}
static constraints = {
    individual()
    category()
    emailAddress()
    clean(nullable:true)

    dateCreated()
    creator()
    lastUpdated()
    updator()


    }

    String category
    String emailAddress
    Boolean clean

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static belongsTo = [individual:Individual]

        String toString() {
            return category+" : "+ emailAddress
    	  }

}
