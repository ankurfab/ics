package ics

class Question {

    static constraints = {
    	questionText(minSize:10,maxSize:2000)
       	choice1(minSize:1, maxSize:1000)
    	choice2(minSize:1, maxSize:1000)
    	choice3(minSize:1, maxSize:1000)
    	choice4(minSize:1, maxSize:1000)
    	isChoice1Correct nullable:false
    	isChoice2Correct nullable:false
    	isChoice3Correct nullable:false
    	isChoice4Correct nullable:false
    	marks(min:1, max:20)
    	hint(nullable:true, blank:true, minSize:1, maxSize:2000)
    	info(nullable:true, blank:true, minSize:1, maxSize:2000)
    	status inList: ["UNDER PREPERATION", "PREPARED", "AVAILABLE", "PARKED"]
    	type inList: ["SINGLE CHOICE", "MULTIPLE CHOICE", "NOT SPECIFIED"]
    	level inList: ["EASY", "MEDIUM", "HARD"]
    	language nullable:true	//null would mean default i.e. English
    	category nullable:true	//null would make it visible to everyone
    	course nullable:true
    }
    
    Course course	//For a specific subject for eg BG, NoD etc
    String category	//for mock test, or any advanced level test ..basically a sub-division
    String language	//eng,hindi,marathi etc
    String type		//single choice, multi choice etc
    String status	//ready to be used??
    
    String questionText
    String choice1
    String choice2
    String choice3
    String choice4
    Boolean isChoice1Correct
    Boolean isChoice2Correct
    Boolean isChoice3Correct
    Boolean isChoice4Correct
    String hint
    String info
    String level	//easy,medium,hard
    Integer marks=1

    Date dateCreated
    Date lastUpdated
    String creator
    String updator 
    
    static hasMany = [tags:Tag]
}
