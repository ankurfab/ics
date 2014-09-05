package ics

class MenuChart {

    String chartName
    String category
    Date chartDate
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static hasMany = [menu:Menu]

    static constraints = {
    	menu(nullable:true)
    	category(nullable:true)
    	chartDate(nullable:true)

	creator(nullable:true)
	dateCreated()
	updator(nullable:true)
	lastUpdated()

	}
	
	String toString() {
		      	return chartName;
	}
}
