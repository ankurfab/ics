package ics

import org.springframework.web.context.request.RequestContextHolder

class ReceiptSequenceService {

    def springSecurityService

    def serviceMethod() {

    }
    
    def getNext(String type) {
    	//@TODO: some hardcoded logic
    	//get the department of the logged in user
    	def dep
    	def rs
    	def retVal = 0
    	
    	dep = Department.get(RequestContextHolder.currentRequestAttributes().getSession()?.receiverDepId)
    	if(!dep)
    		{
		dep = IndividualRole.findWhere(individual:Individual.findByLoginid(springSecurityService.principal.username),role:Role.findByName('Receiver'),status:'VALID')?.department
		log.debug("dep found outside session"+dep)
		}
    	if(dep)
    		{
    		rs = ReceiptSequence.findByTypeAndDepartment(type,dep)
    		//store in httpsession for quicker lookup next time
    		RequestContextHolder.currentRequestAttributes().getSession()?.receiverDepId= dep?.id
    		RequestContextHolder.currentRequestAttributes().getSession()?.receiverDepAlias = dep?.alias
    		}
	else
	    {
	    //first find if any seq exists with the provided type, if not create and return
	    //else increment and return
	    rs = ReceiptSequence.findByType(type)
	    if(!rs)
		{
		rs = new ReceiptSequence(type:type,seq:0)
		}
	    }
	//now get the exact seq no
	rs.seq = rs.seq + 1
	retVal = rs.seq
	rs.save()
	return retVal
    }
}
