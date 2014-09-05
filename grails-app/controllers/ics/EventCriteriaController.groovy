package ics

import groovy.sql.Sql;
import grails.converters.JSON
class EventCriteriaController {
    def springSecurityService

	def dataSource ; 
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [eventCriteriaInstanceList: EventCriteria.list(params), eventCriteriaInstanceTotal: EventCriteria.count()]
    }

    def create = {
        def eventCriteriaInstance = new EventCriteria()
        eventCriteriaInstance.properties = params
        return [eventCriteriaInstance: eventCriteriaInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def eventCriteriaInstance = new EventCriteria(params)
        if (eventCriteriaInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'eventCriteria.label', default: 'EventCriteria'), eventCriteriaInstance.id])}"
            redirect(action: "show", id: eventCriteriaInstance.id)
        }
        else {
            render(view: "create", model: [eventCriteriaInstance: eventCriteriaInstance])
        }
    }

    def show = {
        def eventCriteriaInstance = EventCriteria.get(params.id)
        if (!eventCriteriaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'eventCriteria.label', default: 'EventCriteria'), params.id])}"
            redirect(action: "list")
        }
        else {
            [eventCriteriaInstance: eventCriteriaInstance]
        }
    }

    def edit = {
        def eventCriteriaInstance = EventCriteria.get(params.id)
        if (!eventCriteriaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'eventCriteria.label', default: 'EventCriteria'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [eventCriteriaInstance: eventCriteriaInstance]
        }
    }

    def update = {
        def eventCriteriaInstance = EventCriteria.get(params.id)
        if (eventCriteriaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (eventCriteriaInstance.version > version) {
                    
                    eventCriteriaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'eventCriteria.label', default: 'EventCriteria')] as Object[], "Another user has updated this EventCriteria while you were editing")
                    render(view: "edit", model: [eventCriteriaInstance: eventCriteriaInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            eventCriteriaInstance.properties = params
            if (!eventCriteriaInstance.hasErrors() && eventCriteriaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'eventCriteria.label', default: 'EventCriteria'), eventCriteriaInstance.id])}"
                redirect(action: "show", id: eventCriteriaInstance.id)
            }
            else {
                render(view: "edit", model: [eventCriteriaInstance: eventCriteriaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'eventCriteria.label', default: 'EventCriteria'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def eventCriteriaInstance = EventCriteria.get(params.id)
        if (eventCriteriaInstance) {
            try {
                eventCriteriaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'eventCriteria.label', default: 'EventCriteria'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'eventCriteria.label', default: 'EventCriteria'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'eventCriteria.label', default: 'EventCriteria'), params.id])}"
            redirect(action: "list")
        }
    }

    def slips = {
    }

    def generate = {
    	def idlist = ''
    	def query
    	if (params.acIndividual_id == null || params.acEvent_id == null || params.acEventCriteria_id == null)
    		{
    		flash.message = "One or more parameters not set!"
    		redirect(action: "slips")
    		}
    	def person = Individual.get(params.acIndividual_id)
    	def ec = EventCriteria.get(params.acEventCriteria_id)
   def sql = new Sql(dataSource);
    	
    	switch(params.slipFor)
    		{
    			case "Individual":
    				idlist = params.acIndividual_id
    				break
    			case "Collector":
				query ="select donated_by_id from (select donated_by_id,sum(amount) amount from donation where donation_date >='"+ec.conditon1+"' and donation_date <='"+ec.conditon2+"' group by donated_by_id) p where p.amount>="+ec.conditon3+" and p.amount<"+ec.conditon4+"  and donated_by_id in (select distinct donated_by_id from donation where collected_by_id="+params.acIndividual_id+") and donated_by_id not in (select distinct individual_id from event_participant where event_participant.invited=true and event_id="+params.acEvent_id+")"

				println query

				 sql.eachRow(query)
				 { row ->
				     idlist += row.donated_by_id+","

				}
				if (idlist != '')
					idlist = idlist.substring(0,idlist.length()-1)
				println idlist
    				break
    			case "Cultivator":
				query ="select donated_by_id from (select donated_by_id,sum(amount) amount from donation where donation_date >='"+ec.conditon1+"' and donation_date <='"+ec.conditon2+"' group by donated_by_id) p where p.amount>="+ec.conditon3+" and p.amount<"+ec.conditon4+"  and donated_by_id in (select distinct individual1_id from relationship,relation where relation.id=relationship.relation_id and relation.name='Cultivated by' and individual2_id="+params.acIndividual_id+") and donated_by_id not in (select distinct individual_id from event_participant where event_participant.invited=true and event_id="+params.acEvent_id+")"

				println query

				 sql.eachRow(query)
				 { row ->
				     idlist += row.donated_by_id+","

				}
				if (idlist != '')
					idlist = idlist.substring(0,idlist.length()-1)
				println idlist
    				break
    		}
    		sql.close()
    		
    	def registerParams = [idlist:idlist,eventid:params.acEvent_id]	
    	[msg:"Please take printout by clicking pdf link above!",id:"("+idlist+")",p:registerParams]

    }

    def findEventCriteriaAsJSON = {
    		def query = params.query
        	def c = EventCriteria.findAllByNameLike("%"+query+"%",[sort:'name'])
        response.setHeader("Cache-Control", "no-store")

        def results = c.collect {
            [  id: it.id,
               name: it.name ]
        }

        def data = [ result: results ]
        render data as JSON
    }
    
    def register = {
    
    println params
    def idlist = params.idlist.tokenize(',')
    def event = Event.get(params.eventid)
    def individual
    def ep
    idlist.each{
    
    	//first check for duplicate
    	individual = Individual.get(it)
    	def dbep = EventParticipant.findByIndividualAndEvent(individual,event)
    	if (dbep != null)
    		{
    			println "Found existing entry:"+dbep
    			dbep.comments += " : Regenerated on "+new Date()
    			dbep.updator = springSecurityService.principal.username
    			dbep.save()
    		}
    	else
    		{
		ep = new EventParticipant(event:event,individual:individual,attended:false,invited:true,confirmed:false,comments:'Auto generated from Slip',creator:springSecurityService.principal.username,updator:springSecurityService.principal.username)
		ep.save()
    		}
    }
    
    
    
	flash.message = "${idlist.size()} individuals invited for the event!"
    redirect(action: "slips")
    }


}
