package ics

class ChartItem {

    static constraints = {
	    date()
	    slot()
	    comments(nullable:true, blank:true)
	    ia0(nullable:true)
	    ia1(nullable:true)
	    ia2(nullable:true)
	    ia3(nullable:true)
	    ia4(nullable:true)
	    ia5(nullable:true)
	    ia6(nullable:true)
	    sa0(nullable:true, blank:true)
	    sa1(nullable:true, blank:true)
	    sa2(nullable:true, blank:true)
	    sa3(nullable:true, blank:true)
	    sa4(nullable:true, blank:true)
	    sa5(nullable:true, blank:true)
	    sa6(nullable:true, blank:true)
	    updator()
	    lastUpdated()
	    creator()
	    dateCreated()
    }
    
    Date date
    String slot
    String comments
    Integer ia0
    Integer ia1
    Integer ia2
    Integer ia3
    Integer ia4
    Integer ia5
    Integer ia6
    String sa0
    String sa1
    String sa2
    String sa3
    String sa4
    String sa5
    String sa6

    String updator
    Date lastUpdated
    String creator
    Date dateCreated

    static belongsTo = [chart:Chart]

    String toString() {
	id+":"+date.format('dd-MM-yyyy')+":"+slot+":"+((ia1?:0)+(ia2?:0)+(ia3?:0)+(ia4?:0)+(ia5?:0)+(ia6?:0))
	}    

}
