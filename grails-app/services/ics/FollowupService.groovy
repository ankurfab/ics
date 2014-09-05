package ics
import org.codehaus.groovy.grails.plugins.springsecurity.*
import org.springframework.web.context.request.RequestContextHolder

class FollowupService {
    
    def serviceMethod() {
    }
    
    //get the most recent followup date with this individual by the cultivator
    def recentCultivation(Individual ind) {
    	def recentDate = null
    	def recentFup
    	//first get the cultivator
    	/*SLOW def cult = Relationship.findWhere(individual1:ind,relation:Relation.findByName('Cultivated by'),status:'ACTIVE')?.individual2
    	if(cult) {
    		//now get the most recent followup
    		recentFup = Followup.findAllByFollowupWithAndFollowupBy(ind,cult,[max:1,sort:'startDate',order:'desc'])
    		if(recentFup?.size()==1)
    			recentDate = recentFup[0].startDate
    	}*/

	recentFup = Followup.findAllByFollowupWith(ind,[max:1,sort:'startDate',order:'desc'])
	if(recentFup?.size()==1)
		recentDate = recentFup[0].startDate

    	return recentDate
    }
    
}
