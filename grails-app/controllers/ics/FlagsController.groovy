package ics

import groovy.sql.Sql;
import grails.converters.JSON

class FlagsController {
    def springSecurityService
    def dataSource

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        [flagsInstanceList: Flags.findAllByUpdatorAndFormstatus(springSecurityService.principal.username,'UNDER VERIFICATION')]
    }

    def create = {
    	def flagsInstance
    	//first check if flags already exist, if yes, show then else create new
    	flagsInstance = Flags.findByIndividualid(params.indid)
    	if(flagsInstance)
    		{
            	redirect(action: "edit", id: flagsInstance.id)
    		}
    	else
    		{
		flagsInstance = new Flags()
		flagsInstance.individualid = params.indid.toInteger()
		return [flagsInstance: flagsInstance]
        	}
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def flagsInstance = new Flags(params)
        if (flagsInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'flags.label', default: 'Flags'), flagsInstance.id])}"
            redirect(action: "show", id: flagsInstance.id)
        }
        else {
            render(view: "create", model: [flagsInstance: flagsInstance])
        }
    }

    def show = {
        def flagsInstance = Flags.get(params.id)
        if (!flagsInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'flags.label', default: 'Flags'), params.id])}"
            redirect(action: "list")
        }
        else {
            [flagsInstance: flagsInstance]
        }
    }

    def edit = {
        def flagsInstance = Flags.get(params.id)
        if (!flagsInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'flags.label', default: 'Flags'), params.id])}"
            redirect(action: "list")
        }
        else {
		def collectors = []
		def i=0
		def sql = new Sql(dataSource)
		def query = "select distinct collected_by_id collid from donation where donated_by_id !=collected_by_id and donated_by_id="+params.id
		def result = sql.rows(query)
		for(i=0; i<result.size(); i++)
			collectors.add(result.collid[i])
		sql.close()
		println "Collectors.."+collectors
            
            return [flagsInstance: flagsInstance, collectors: collectors]
        }
    }

    def update = {
        println "Inside update.."+params
        def flagsInstance = Flags.get(params.id)
        if (flagsInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (flagsInstance.version > version) {
                    
                    flagsInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'flags.label', default: 'Flags')] as Object[], "Another user has updated this Flags while you were editing")
                    render(view: "edit", model: [flagsInstance: flagsInstance])
                    return
                }
            }

	//get the individual
	def ind = Individual.get(params.ind_id)
	
	//update cellphone
	if(params.cp_id || params.cpno)
		{
		def cp = VoiceContact.get(params.cp_id)
		if(cp)
			{
			cp.number = params.cpno
			cp.updator = springSecurityService.principal.username
			cp.save(flush:true)
			}
		else if(params.cpno) //whether to create new entry
			{
			cp = new VoiceContact()
			cp.category = 'CellPhone'
			cp.number = params.cpno
			cp.individual = ind
			cp.creator = springSecurityService.principal.username
			cp.updator = springSecurityService.principal.username
			cp.save(flush:true)
			}
		}
	
	//update homephone
	if(params.hp_id || params.hpno)
		{
		def hp = VoiceContact.get(params.hp_id)
		if(hp)
			{
			hp.number = params.hpno
			hp.updator = springSecurityService.principal.username
			hp.save(flush:true)
			}
		else if(params.hpno) //whether to create new entry
			{
			hp = new VoiceContact()
			hp.category = 'HomePhone'
			hp.number = params.hpno
			hp.individual = ind
			hp.creator = springSecurityService.principal.username
			hp.updator = springSecurityService.principal.username
			hp.save(flush:true)
			}
		}
	
	//update companyphone
	if(params.cop_id || params.copno)
		{
		def cop = VoiceContact.get(params.cop_id)
		if(cop)
			{
			cop.number = params.copno
			cop.updator = springSecurityService.principal.username
			cop.save(flush:true)
			}
		else if(params.copno) //whether to create new entry
			{
			cop = new VoiceContact()
			cop.category = 'CompanyPhone'
			cop.number = params.copno
			cop.individual = ind
			cop.creator = springSecurityService.principal.username
			cop.updator = springSecurityService.principal.username
			cop.save(flush:true)
			}
		}
	
	//update email
	if(params.em_id || params.emaddr)
		{
		def em = EmailContact.get(params.em_id)
		if(em)
			{
			em.emailAddress = params.emaddr
			em.updator = springSecurityService.principal.username
			em.save(flush:true)
			}
		else if(params.emaddr) //whether to create new entry
			{
			em = new EmailContact()
			em.category = 'Personal'
			em.emailAddress = params.emaddr
			em.individual = ind
			em.creator = springSecurityService.principal.username
			em.updator = springSecurityService.principal.username
			em.save(flush:true)
			}
		}
	
	//update company email
	if(params.emco_id || params.emcoaddr)
		{
		def emco = EmailContact.get(params.emco_id)
		if(emco)
			{
			emco.emailAddress = params.emcoaddr
			emco.updator = springSecurityService.principal.username
			emco.save(flush:true)
			}
		else if(params.emcoaddr) //whether to create new entry
			{
			emco = new EmailContact()
			emco.category = 'Official'
			emco.emailAddress = params.emcoaddr
			emco.individual = ind
			emco.creator = springSecurityService.principal.username
			emco.updator = springSecurityService.principal.username
			emco.save(flush:true)
			}
		}
	
	//update correspondence address
	if(params.ca_id || params.ca_addressLine1)
		{
		def ca = Address.get(params.ca_id)
		if(ca)
			{
			ca.addressLine1 = params.ca_addressLine1
			ca.pincode = params.ca_pin
			ca.city = City.get(params.ca_city_id)
			ca.state = State.get(params.ca_state_id)
			ca.country = Country.get(params.ca_country_id)
			ca.updator = springSecurityService.principal.username
			ca.save(flush:true)
			}
		else if(params.ca_addressLine1) //whether to create new entry
			{
			ca = new Address()
			ca.category = 'Correspondence'
			ca.addressLine1 = params.ca_addressLine1
			ca.pincode = params.ca_pin
			ca.city = City.get(params.ca_city_id)
			ca.state = State.get(params.ca_state_id)
			ca.country = Country.get(params.ca_country_id)
			ca.individual = ind
			ca.creator = springSecurityService.principal.username
			ca.updator = springSecurityService.principal.username
			ca.save(flush:true)
			}
		}
	
	//update permanent address
	if(params.pa_id || params.pa_addressLine1)
		{
		def pa = Address.get(params.pa_id)
		if(pa)
			{
			pa.addressLine1 = params.pa_addressLine1
			pa.pincode = params.pa_pin
			pa.city = City.get(params.pa_city_id)
			pa.state = State.get(params.pa_state_id)
			pa.country = Country.get(params.pa_country_id)
			pa.updator = springSecurityService.principal.username
			pa.save(flush:true)
			}
		else if(params.pa_addressLine1) //whether to create new entry
			{
			pa = new Address()
			pa.category = 'Permanent'
			pa.addressLine1 = params.pa_addressLine1
			pa.pincode = params.pa_pin
			pa.city = City.get(params.pa_city_id)
			pa.state = State.get(params.pa_state_id)
			pa.country = Country.get(params.pa_country_id)
			pa.individual = ind
			pa.creator = springSecurityService.principal.username
			pa.updator = springSecurityService.principal.username
			pa.save(flush:true)
			}
		}
	
	//update company address
	if(params.coa_id || params.coa_addressLine1)
		{
		def coa = Address.get(params.coa_id)
		if(coa)
			{
			coa.addressLine1 = params.coa_addressLine1
			coa.pincode = params.coa_pin
			coa.city = City.get(params.coa_city_id)
			coa.state = State.get(params.coa_state_id)
			coa.country = Country.get(params.coa_country_id)
			coa.updator = springSecurityService.principal.username
			coa.save(flush:true)
			}
		else if(params.coa_addressLine1) //whether to create new entry
			{
			coa = new Address()
			coa.category = 'Company'
			coa.addressLine1 = params.coa_addressLine1
			coa.pincode = params.coa_pin
			coa.city = City.get(params.coa_city_id)
			coa.state = State.get(params.coa_state_id)
			coa.country = Country.get(params.coa_country_id)
			coa.individual = ind
			coa.creator = springSecurityService.princicoal.username
			coa.updator = springSecurityService.princicoal.username
			coa.save(flush:true)
			}

		if(ind) //for company name
			{
			ind.companyName = params.co_name
			ind.updator = springSecurityService.principal.username
			ind.save(flush:true)
			}
		}
	

	//update flags
		if (springSecurityService.isLoggedIn()) {
			params.updator=springSecurityService.principal.username
		}
		else
			params.updator="unknown"
			
            flagsInstance.properties = params
            if (!flagsInstance.hasErrors() && flagsInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'flags.label', default: 'Flags'), flagsInstance.id])}"
                redirect(action: "show", id: flagsInstance.id)
            }
            else {
                render(view: "edit", model: [flagsInstance: flagsInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'flags.label', default: 'Flags'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def flagsInstance = Flags.get(params.id)
        if (flagsInstance) {
            try {
                flagsInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'flags.label', default: 'Flags'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'flags.label', default: 'Flags'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'flags.label', default: 'Flags'), params.id])}"
            redirect(action: "list")
        }
    }

    def cancel = {
        def flagsInstance = Flags.get(params.id)
        if (flagsInstance) {
            try {
                flagsInstance.formstatus='UNVERIFIED'
                if(!flagsInstance.save(flush: true))
                	{
					println "Error in saving flags: "+flagsInstance
					if(flagsInstance.hasErrors()) {
					    flagsInstance.errors.each {
						  println it
					    }
					}
                	
                	}
                render(view: "/index.gsp")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'flags.label', default: 'Flags'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'flags.label', default: 'Flags'), params.id])}"
            redirect(action: "list")
        }
    }
    
    def markRecords() {
	log.debug("In markRecords with params: "+params)
	def flags
	def ids = params.idList.tokenize(',')
	ids = ids?.unique() //remove duplicate ids if supplied by mistake
	ids.each
		{
		flags = Flags.findByIndividualid(it)
		if(!flags)
			{
			//create in runtime
			flags = new Flags()
			flags.individualid = new Long(it)
			flags.creator = springSecurityService.principal.username
			}
		if(flags)
			{
			switch(params.attr) {
			 case 'rec':
			 	if(params.val=='clean')
			 		flags.formstatus='VERIFIED'
			 	else if(params.val=='unclean')
			 		flags.formstatus='UNDER VERIFICATION'
			 	break
			 case 'phone':
			 	if(params.val=='clean')
			 		flags.mobileNo=true
			 	else if(params.val=='unclean')
			 		flags.mobileNo=false
			 	break
			 case 'email':
			 	if(params.val=='clean')
			 		flags.email=true
			 	else if(params.val=='unclean')
			 		flags.email=false
			 	break
			 case 'address':
			 	if(params.val=='clean')
			 		flags.address=true
			 	else if(params.val=='unclean')
			 		flags.address=false
			 	break
			 default:
			 	break
			 }
			 flags.updator=springSecurityService.principal.username
			 if(!flags.save())
			    flags.errors.allErrors.each {
				log.debug("In markRecords: error in marking flags:"+ it)
				}
			}
		}
	render([message:"OK"] as JSON) 
    }

}
