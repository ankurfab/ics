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
	
	def ccList = CostCenter.findAllByStatusIsNull()
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

		//code to handle multiple email addrs for a person
		def toAddrs = params.toEmail?.replaceAll(';',',')
		toAddrs?.tokenize(',')?.each{
			recpts.add(new MandrillRecipient(name:params.toName, email:it))
		}

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
		catch(Exception e) {log.debug("EXCEPTION IN sendMandrill :"+e)}
		
		return ret?.status?:''
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
    
    def genericComms(Map params) {
    	switch(params.commsType) {
    		case "EMAIL":
    			genericEmailComms(params)
    			break
    		case "SMS":
    			genericSmsComms(params)
    			break
    		default:
    			break
    	}
    	return "OK"
    }

    @Async
    def genericSmsComms(Map params) {
	def template = Template.get(params.tid)
	def depcp = DepartmentCP.get(params.depcpid)
	def total=0,success=0
	params.indids?.tokenize(',').each {
		total++
		try{
			def individual = Individual.get(it)
			def loginid = Eval.x( individual, "x.${'loginid'}" )
			def body = fillTemplate(template,[individual.toString(),loginid])
			log.debug("sending genericSmsComms:"+body)
			sendSms(depcp.cp,VoiceContact.findByCategoryAndIndividual('CellPhone',individual)?.number,body)
			success++
		}
		catch(Exception e){
			log.debug(e)
			}
	}
	log.debug("genericSmsComms:"+success+"/"+total)
    }

    @Async
    def genericEmailComms(Map params) {
	def template = Template.findByCodeAndCategory("EPSETUP","EMAIL")
	def body = commsService.fillTemplate(template,[ep.individual.toString(),loginid])
	commsService.sendMandrill([key:depcp?.cp?.apikey,sender:depcp.sender,toName:ep.individual.toString(),toEmail:EmailContact.findByCategoryAndIndividual('Personal',ep.individual)?.emailAddress,emailsub:template.name,emailbody:body,type:template.type])
    }

    def sendComms(String departmentName, String templateCode, String toName, String number, String toEmail, List contentParams) {
	    //SMS
	    try{
		//send sms
		def depcp_sms = DepartmentCP.createCriteria().get{
				department{eq('name',departmentName)}	//@TODO: handle multi-center scenario
				cp{eq('type','SMS')}
				}
		if(depcp_sms)
			{
			if(number) {
				def template = Template.findByCodeAndCategory(templateCode,"SMS")
				if(template) {
					def body = commsService.fillTemplate(template,contentParams)
					sendSms(depcp_sms.cp,number,body)
				}
			}
			}
	    }
	    catch(Exception e){log.debug("sendcomms sms exception:"+e)}

	    //EMAIL
	    try{
		//send the email
		def depcp = DepartmentCP.createCriteria().get{
				department{eq('name',departmentName)}	//@TODO: handle multi-center scenario
				cp{eq('type','Mandrill')}
				}
		if(depcp)
			{
			if(toEmail) {
				def template = Template.findByCodeAndCategory(templateCode,"EMAIL")
				if(template) {
					def body = commsService.fillTemplate(template,contentParams)
					sendMandrill([key:depcp?.cp?.apikey,sender:depcp.sender,toName:toName,toEmail:toEmail,emailsub:template.name,emailbody:body,type:template.type])
				}
			}
			}
	    }
	    catch(Exception e){log.debug("sendcomms email stage:"+stage+" exception:"+e)}
    }

}
