package ics
import org.grails.mandrill.MandrillRecipient;
import org.grails.mandrill.MandrillMessage;
import org.springframework.scheduling.annotation.Async
import org.grails.mandrill.*
import grails.converters.JSON
import groovyx.net.http.*
import groovyx.net.http.ContentType.*
import groovyx.net.http.Method.*
import org.codehaus.groovy.grails.web.util.WebUtils

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
    
    //replace the markers in the template with param values (positional)
    def fillTemplate(Template template, List values) {
    	def returnText = template.body
    	values.each{
	    	returnText = returnText.replaceFirst("ZZZ",it)
	    	}
	return returnText
    }
    

	def sendMandrill(Map params) {
		//log.debug("In sendMandrill:"+params)
		def recpts = []
		recpts.add(new MandrillRecipient(name:params.toName, email:params.toEmail))
		def message
	
		if(params.type=="HTML")
			message = new MandrillMessage(
				  html:params.emailbody,
				  subject:params.emailsub,
				  from_email:params.sender,
				  to:recpts)
		else
			message = new MandrillMessage(
				  text:params.emailbody,
				  subject:params.emailsub,
				  from_email:params.sender,
				  to:recpts)

		def ret
		try{
		ret = mandrillService.send(params.key,message)
		log.debug("Mandrill mail "+ret?.status+":"+params.toName+":"+params.toEmail)
		}
		catch(Exception e) {log.debug(e)}
		
		return ret?.status
	}
	
	def sendSms(String baseUrl,String path,Map<String,String> query) {
		//log.debug(baseUrl+" : "+path+" : "+query)
		def ret=null
		def http = new HTTPBuilder(baseUrl)
		def postBody=query
		http.request(groovyx.net.http.Method.POST,ContentType.TEXT) {
			uri.path = path
			requestContentType = ContentType.URLENC
			body = postBody
			response.success = {resp, reader ->
				ret = reader.getText()
			}
			response.failure = { resp, reader ->
				ret = reader.getText()
			}
		}
		return ret
    }

    @Async
    def sendSms(CommsProvider cp,String phoneNosStr, String smstext) {
    	def ret = ''

    	//first populate phone nos
    	def query = cp.query.replaceFirst("ZZZ",phoneNosStr)
    	//then sms text
    	query = query.replaceFirst("ZZZ",smstext)
    	
    	//create query map
    	def queryMap = WebUtils.fromQueryString(query)
    	
    	ret = sendSms(cp.baseUrl,cp.path,queryMap)
    	
    	log.debug("SMS sent status: "+ret)
    	
    }

}
