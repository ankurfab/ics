package ics
import org.grails.mandrill.MandrillRecipient;
import org.grails.mandrill.MandrillMessage;
import org.springframework.scheduling.annotation.Async

class CommsService {

    def mandrillService
    def reportService

    def serviceMethod() {

    }
    
    @Async
    def sendMail() {
	def recpts = []
	recpts.add(new MandrillRecipient(name:"foo", email:"kaushal.prashant@gmail.com"))
	def message = new MandrillMessage(
					  text:"this is a text message",
					  subject:"this is a subject",
					  from_email:"thisisatest@yopmail.com",
					  to:recpts) 
	message.tags.add("test")
	def ret = mandrillService.send(message)
    }
	@Async
	def sendCCStmt(String toAddr, String sub, EventRegistration er) {

		try {
			sendMail {
				to      toAddr
				from	"nvcc@iskconpune.in"
				subject sub
				body( view:"/email/_registrationDone", 
					    model:[eventRegistrationInstance:er])
			}
			log.debug( "Email Sent to " + toAddr)
		} catch(Exception e) {
			println e
		}
	}

    @Async
    def sendCCStmt() {
	def recpts = []
	def result = []
	def fd = new Date().clearTime()
	def td = fd+1
	
	def ccList = CostCenter.list()
	ccList.each{cc->
		recpts = []
		result = []
		recpts = EmailContact.findAllByCategoryAndIndividual('Personal',cc.owner)?.collect{it.emailAddress}
		recpts += EmailContact.findAllByCategoryAndIndividual('Personal',cc.owner1)?.collect{it.emailAddress}
		recpts += EmailContact.findAllByCategoryAndIndividual('Personal',cc.owner2)?.collect{it.emailAddress}
		recpts = recpts.flatten()
		if(recpts.size()>0)
		{
			println "Sending stmt for cc "+cc+" got owners "+recpts
			result = reportService.ccStatement(cc,fd,td)
			try {
				sendMail {
					to      recpts.toArray()
					from	"ao@iskconpune.in"
					subject "Daily Account Statement for "+fd.format("dd-MM-yyyy")
					body( view:"/costCenter/_statementTemplate", 
						    model:[department: cc,fd:fd, td: td, balance:cc.budget?:0, records: result])
				}
			} catch(Exception e) {
				println e
			}
		}
	}
    }
    

}
