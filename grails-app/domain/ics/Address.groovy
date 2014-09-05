package ics

class Address {
static searchable = { only = ['addressLine?'] }
    static constraints = {
    individual()
    category(nullable:true,blank:false,maxSize:32)
    addressLine1(blank:false,maxSize:255)
    addressLine2(nullable:true,blank:true,maxSize:100)
    addressLine3(nullable:true,blank:true,maxSize:100)
    city(nullable:true)
    state(nullable:true)
    country(nullable:true)
    pincode(nullable:true,blank:true,maxsize:10)
    clean(nullable:true)
    dateCreated()
    creator()
    lastUpdated()
    updator()
    }

    String category
    String addressLine1
    String addressLine2
    String addressLine3
    City city
    State state
    Country country
    String pincode
    Boolean clean

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static belongsTo = [individual:Individual]

        String toString() {
        if(category)
		category+" : "+addressLine1+" "+(addressLine2?:'')+" "+(addressLine3?:'')+" "+(city?:'')+", "+(state?:'')+", "+(country?:'')+". "+(pincode?:'')
	else
		addressLine1+" "+(addressLine2?:'')+" "+(addressLine3?:'')

	}

}
