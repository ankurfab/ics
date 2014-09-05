package ics

class Chart {

    static constraints = {
	    name()
	    comments(nullable:true, blank:true)
	    category(nullable:true, blank:true)
	    status(nullable:true, blank:true)
	    updator()
	    lastUpdated()
	    creator()
	    dateCreated()
    }
    
    String name
    String comments
    String category
    String status

    String updator
    Date lastUpdated
    String creator
    Date dateCreated
    
    static hasMany = [chartItems:ChartItem]
    
    String toString() {
	name
	}    
    
}
