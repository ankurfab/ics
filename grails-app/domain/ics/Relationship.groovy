package ics

class Relationship {

    static constraints = {
    relationshipGroup()
    individual1()
    relation()
    individual2()
    comment(nullable:true)

    dateCreated()
    creator()
    lastUpdated()
    updator()

   }
    String comment
    String status

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static belongsTo = [individual1:Individual, individual2:Individual, relation:Relation, relationshipGroup: RelationshipGroup]

            String toString() {
            if (relationshipGroup.groupName != "dummy")
            	{
                	relation.toString()+ " of " + individual2.toString() 
                }
            else
            	relation.toString() +" " + individual2
    	  }
        

}
