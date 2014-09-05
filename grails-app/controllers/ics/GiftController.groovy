package ics
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import grails.converters.JSON

class GiftController {
    def springSecurityService
    def helperService 

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
         if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
            /*for donation executive only list the gifts belonging to his scheme
            */
            def department = helperService.getDepartmentForRole('ROLE_DONATION_EXECUTIVE',session.individualid)

         return  [giftInstanceList: Gift.createCriteria().list(params){eq('department',department)}, giftInstanceTotal: Gift.count()]

           
        }
        [giftInstanceList: Gift.list(params), giftInstanceTotal: Gift.count()]
    }

    def create = {
        def giftInstance = new Gift()
        giftInstance.properties = params
        println 'gift create params='+params
        return [giftInstance: giftInstance]
    }

    def save = {
    	if(params.effectiveFrom)
			params.effectiveFrom = Date.parse('dd-MM-yyyy', params.effectiveFrom)
	if(params.effectiveTill)
		params.effectiveTill = Date.parse('dd-MM-yyyy', params.effectiveTill)
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator
    println 'gift save params='+params
        def giftInstance = new Gift(params)
        if (giftInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'gift.label', default: 'Gift'), giftInstance.id])}"
            redirect(action: "show", id: giftInstance.id)
        }
        else {
            render(view: "create", model: [giftInstance: giftInstance])
        }
        
    }

    def show = {
        def giftInstance = Gift.get(params.id)
        if (!giftInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gift.label', default: 'Gift'), params.id])}"
            redirect(action: "list")
        }
        else {
            [giftInstance: giftInstance]
        }
    }

    def edit = {
        def giftInstance = Gift.get(params.id)
    	if(params.effectiveFrom)
			params.effectiveFrom = Date.parse('dd-MM-yyyy', params.effectiveFrom)
	if(params.effectiveTill)
		params.effectiveTill = Date.parse('dd-MM-yyyy', params.effectiveTill)
        
        if (!giftInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gift.label', default: 'Gift'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [giftInstance: giftInstance]
        }
    }

    def update = {
        def giftInstance = Gift.get(params.id)
    	if(params.effectiveFrom)
			params.effectiveFrom = Date.parse('dd-MM-yyyy', params.effectiveFrom)
	if(params.effectiveTill)
		params.effectiveTill = Date.parse('dd-MM-yyyy', params.effectiveTill)
        
        if (giftInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (giftInstance.version > version) {
                    
                    giftInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'gift.label', default: 'Gift')] as Object[], "Another user has updated this Gift while you were editing")
                    render(view: "edit", model: [giftInstance: giftInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            giftInstance.properties = params
            if (!giftInstance.hasErrors() && giftInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'gift.label', default: 'Gift'), giftInstance.id])}"
                redirect(action: "show", id: giftInstance.id)
            }
            else {
                render(view: "edit", model: [giftInstance: giftInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gift.label', default: 'Gift'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def giftInstance = Gift.get(params.id)
        if (giftInstance) {
            try {
                giftInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'gift.label', default: 'Gift'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'gift.label', default: 'Gift'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gift.label', default: 'Gift'), params.id])}"
            redirect(action: "list")
        }
    }

    def findGiftsAsJSON = {
    		def query = params.query
        	def gifts = Gift.findAllByNameLike("%"+query+"%",[sort:'name'])
        	
        response.setHeader("Cache-Control", "no-store")

        def results = gifts.collect {
            [  id: it.id,
               name: it.toString() ]
        }

        def data = [ result: results ]
        render data as JSON
    }

    def getAmount = {
    	println "In gift.getAmount():"+params
    	def giftInstance = Gift.get(params.id)
    	println "In gift.getAmount() for worth:"+giftInstance?.worth
    	def amount = giftInstance?.worth * new Integer(params.quantity?:1)
    	println "amount: "+amount
    	render amount
    }


}
