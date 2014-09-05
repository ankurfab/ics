package ics
import grails.converters.JSON

class EventPrasadamController {

    def springSecurityService
    def registrationService
    def prasadamService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [eventPrasadamInstanceList: EventPrasadam.list(params), eventPrasadamInstanceTotal: EventPrasadam.count()]
    }

    def runtimelist () {
    }
    
    def create = {
        def eventPrasadamInstance = new EventPrasadam()
        eventPrasadamInstance.properties = params
        return [eventPrasadamInstance: eventPrasadamInstance]
    }

    def save = {
        params.creator=springSecurityService.principal.username
        params.updator=params.creator
        def eventPrasadamInstance = new EventPrasadam(params)
        if (!eventPrasadamInstance.hasErrors() && eventPrasadamInstance.save()) {
            flash.message = "eventPrasadam.created"
            flash.args = [eventPrasadamInstance.id]
            flash.defaultMessage = "EventPrasadam ${eventPrasadamInstance.id} created"
            redirect(action: "show", id: eventPrasadamInstance.id)
        }
        else {
            render(view: "create", model: [eventPrasadamInstance: eventPrasadamInstance])
        }
    }

    def show = {
        def eventPrasadamInstance = EventPrasadam.get(params.id)
        if (!eventPrasadamInstance) {
            flash.message = "eventPrasadam.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventPrasadam not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [eventPrasadamInstance: eventPrasadamInstance]
        }
    }

    def edit = {
        def eventPrasadamInstance = EventPrasadam.get(params.id)
        if (!eventPrasadamInstance) {
            flash.message = "eventPrasadam.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventPrasadam not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [eventPrasadamInstance: eventPrasadamInstance]
        }
    }

    def update = {
        def eventPrasadamInstance = EventPrasadam.get(params.id)
        if (eventPrasadamInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (eventPrasadamInstance.version > version) {
                    
                    eventPrasadamInstance.errors.rejectValue("version", "eventPrasadam.optimistic.locking.failure", "Another user has updated this EventPrasadam while you were editing")
                    render(view: "edit", model: [eventPrasadamInstance: eventPrasadamInstance])
                    return
                }
            }
            params.updator=springSecurityService.principal.username
            eventPrasadamInstance.properties = params
            if (!eventPrasadamInstance.hasErrors() && eventPrasadamInstance.save()) {
                flash.message = "eventPrasadam.updated"
                flash.args = [params.id]
                flash.defaultMessage = "EventPrasadam ${params.id} updated"
                redirect(action: "show", id: eventPrasadamInstance.id)
            }
            else {
                render(view: "edit", model: [eventPrasadamInstance: eventPrasadamInstance])
            }
        }
        else {
            flash.message = "eventPrasadam.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventPrasadam not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def eventPrasadamInstance = EventPrasadam.get(params.id)
        if (eventPrasadamInstance) {
            try {
                eventPrasadamInstance.delete()
                flash.message = "eventPrasadam.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "EventPrasadam ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "eventPrasadam.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "EventPrasadam ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "eventPrasadam.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EventPrasadam not found with id ${params.id}"
            redirect(action: "list")
        }
    }

// return JSON list of prasadams
    def jq_prasadam_list = {
	def vipFlag = false
	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION,ROLE_VIP_TRANSPORTATION,ROLE_VIP_PRASADAM'))
		vipFlag = true
	else 
		vipFlag = false
      boolean runtime = params.runtime ? true:false
      
      def sortIndex = params.sidx ?: 'mealDate'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def totalRows = 3
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = []
      def resultB = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','22-02-2013 10:00')
      def resultL = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','22-02-2013 15:00')
      def resultD = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','22-02-2013 22:00')
      

      jsonCells.add (
            [cell: [
            	    'Fri 22',
                    (resultB['total'])+"(P"+resultB['numPrji']+",M"+resultB['numMataji']+",C"+resultB['numChildren']+",B"+resultB['numBrahmachari']+")",
                    (resultL['total'])+"(P"+resultL['numPrji']+",M"+resultL['numMataji']+",C"+resultL['numChildren']+",B"+resultL['numBrahmachari']+")",
                    (resultD['total'])+"(P"+resultD['numPrji']+",M"+resultD['numMataji']+",C"+resultD['numChildren']+",B"+resultD['numBrahmachari']+")"
                ], id: 0]
        )
      
      resultB = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','23-02-2013 10:00')
      resultL = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','23-02-2013 15:00')
      resultD = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','23-02-2013 22:00')

      jsonCells.add (
            [cell: [
            	    'Sat 23',
                    (resultB['total'])+"(P"+resultB['numPrji']+",M"+resultB['numMataji']+",C"+resultB['numChildren']+",B"+resultB['numBrahmachari']+")",
                    (resultL['total'])+"(P"+resultL['numPrji']+",M"+resultL['numMataji']+",C"+resultL['numChildren']+",B"+resultL['numBrahmachari']+")",
                    (resultD['total'])+"(P"+resultD['numPrji']+",M"+resultD['numMataji']+",C"+resultD['numChildren']+",B"+resultD['numBrahmachari']+")"
                ], id: 0]
        )

      resultB = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','24-02-2013 10:00')
      resultL = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','24-02-2013 15:00')
      resultD = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','24-02-2013 22:00')

      jsonCells.add (
            [cell: [
            	    'Sun 24',
                    (resultB['total'])+"(P"+resultB['numPrji']+",M"+resultB['numMataji']+",C"+resultB['numChildren']+",B"+resultB['numBrahmachari']+")",
                    (resultL['total'])+"(P"+resultL['numPrji']+",M"+resultL['numMataji']+",C"+resultL['numChildren']+",B"+resultL['numBrahmachari']+")",
                    (resultD['total'])+"(P"+resultD['numPrji']+",M"+resultD['numMataji']+",C"+resultD['numChildren']+",B"+resultD['numBrahmachari']+")"
                ], id: 0]
        )

        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_prasadam = {
	      def prasadam = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add instruction sent
		  params.mealDate = Date.parse('dd-MM-yy', params.mealDate)
		  prasadam = new EventPrasadam(params)
		  prasadam.creator = springSecurityService.principal.username
		  prasadam.updator = prasadam.creator
		  prasadam.event = Event.findByTitle('RVTO')
		  
		  if (! prasadam.hasErrors() && prasadam.save()) {
		    message = "prasadam ${prasadam.id} Added"
		    id = prasadam.id
		    state = "OK"
		  } else {
		    prasadam.errors.allErrors.each {
			println it
			}
		    message = "Could Not Save prasadam"
		  }
		  break;
		case 'del':
		  // check prasadam exists
		  prasadam = prasadam.get(params.id)
		  if (prasadam) {
		    // delete prasadam
		    prasadam.delete()
		    message = "prasadam  ${prasadam.id} Deleted"
		    state = "OK"
		  }
		  break;
		 default :
		  // edit action
		  // first retrieve the prasadam by its ID
		  prasadam = EventPrasadam.get(params.id)
		  if (prasadam) {
		    // set the properties according to passed in parameters
		    params.requiredFrom = Date.parse('dd-MM-yyyy HH:mm', params.requiredFrom)
		    params.requiredTill = Date.parse('dd-MM-yyyy HH:mm', params.requiredFrom)
		    prasadam.properties = params
		    prasadam.updator = springSecurityService.principal.username
		    if (! prasadam.hasErrors() && prasadam.save()) {
		      message = "prasadam  ${prasadam.id} Updated"
		      id = prasadam.id
		      state = "OK"
		    } else {
			    prasadam.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update prasadam"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

// return JSON list of charts
    def jq_chart_list = {
      def chart = registrationService.initializeChart(params.name)

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1
      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
      def totalRows = 1
      def numberOfPages = Math.ceil(totalRows / maxRows)
      
      def event = Event.findByTitle("RVTO")
      Date d = Date.parse('dd-MM-yyyy', '22-02-2013')
      def result
      def jsonCells = []
      
      for(int i=0;i<4;i++) {
		log.debug("Charting for date: "+d)
	      result = ChartItem.findAllByChartAndDate(chart,d,['sort':'slot'])
	      log.debug(result)
	      jsonCells.add([cell: [d.format('E d')]+ result.collect{it.ia0+"(P"+it.ia1+",M"+it.ia2+",C"+it.ia3+",B"+it.ia4+")"}
			, id: 0]
		)
		d= d+1
      }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def jq_prasadamcount_list() {
      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1
      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
      def totalRows = 1
      def numberOfPages = Math.ceil(totalRows / maxRows)
      
      def jsonCells = []
      
      for(int i=0;i<4;i++) {
		log.debug("Charting for date: "+d)
	      result = ChartItem.findAllByChartAndDate(chart,d,['sort':'slot'])
	      log.debug(result)
	      jsonCells.add([cell: [d.format('E d')]+ result.collect{it.ia0+"(P"+it.ia1+",M"+it.ia2+",C"+it.ia3+",B"+it.ia4+")"}
			, id: 0]
		)
		d= d+1
      }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON    	
    }

    def jq_travelling_prasadam_list = {
	def vipFlag = false
	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION,ROLE_VIP_TRANSPORTATION,ROLE_VIP_PRASADAM'))
		vipFlag = true
	else 
		vipFlag = false

      boolean runtime = params.runtime ? true:false
      log.debug("In jq_travelling_prasadam_list:runtime:"+runtime)

      def sortIndex = params.sidx ?: 'mealDate'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def totalRows = 3
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = []
      def result22 = prasadamService.getTPCount(runtime,vipFlag,'21-02-2013 23:59','22-02-2013 23:59')
      def result23 = prasadamService.getTPCount(runtime,vipFlag,'22-02-2013 23:59','23-02-2013 23:59')
      def result24 = prasadamService.getTPCount(runtime,vipFlag,'23-02-2013 23:59','24-02-2013 23:59')
      
      jsonCells.add (
            [cell: [
            	    'Fri 22',
                    result22['numB'],
                    result22['numL'],
                    result22['numD']
                ], id: 0]
        )
      jsonCells.add (
            [cell: [
            	    'Sat 23',
                    result23['numB'],
                    result23['numL'],
                    result23['numD']
                ], id: 0]
        )
      jsonCells.add (
            [cell: [
            	    'Sun 24',
                    result24['numB'],
                    result24['numL'],
                    result24['numD']
                ], id: 0]
        )
      
    
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def jq_net_prasadam_list = {
	log.debug("In jq_net_prasadam_list")
	def vipFlag = false
	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION,ROLE_VIP_TRANSPORTATION,ROLE_VIP_PRASADAM'))
		vipFlag = true
	else 
		vipFlag = false

      boolean runtime = params.runtime ? true:false

      def sortIndex = params.sidx ?: 'mealDate'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def totalRows = 3
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = []
      def resultB = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','22-02-2013 10:00')
      def resultL = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','22-02-2013 15:00')
      def resultD = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','22-02-2013 22:00')
      def resultBD = prasadamService.getDepartureCount(runtime,vipFlag,'21-02-2013 23:59','22-02-2013 10:00')
      def resultLD = prasadamService.getDepartureCount(runtime,vipFlag,'21-02-2013 23:59','22-02-2013 15:00')
      def resultDD = prasadamService.getDepartureCount(runtime,vipFlag,'21-02-2013 23:59','22-02-2013 22:00')
      

      jsonCells.add (
            [cell: [
            	    'Fri 22',
                    ((resultB['total']?:0)-(resultBD['total']?:0))+"(P"+((resultB['numPrji']?:0)-(resultBD['numPrji']?:0))+",M"+((resultB['numMataji']?:0)-(resultBD['numMataji']?:0))+",C"+((resultB['numChildren']?:0)-(resultBD['numChildren']?:0))+",B"+((resultB['numBrahmachari']?:0)-(resultBD['numBrahmachari']?:0))+")",
                    ((resultL['total']?:0)-(resultLD['total']?:0))+"(P"+((resultL['numPrji']?:0)-(resultLD['numPrji']?:0))+",M"+((resultL['numMataji']?:0)-(resultLD['numMataji']?:0))+",C"+((resultL['numChildren']?:0)-(resultLD['numChildren']?:0))+",B"+((resultL['numBrahmachari']?:0)-(resultLD['numBrahmachari']?:0))+")",
                    ((resultD['total']?:0)-(resultDD['total']?:0))+"(P"+((resultD['numPrji']?:0)-(resultDD['numPrji']?:0))+",M"+((resultD['numMataji']?:0)-(resultDD['numMataji']?:0))+",C"+((resultD['numChildren']?:0)-(resultDD['numChildren']?:0))+",B"+((resultD['numBrahmachari']?:0)-(resultDD['numBrahmachari']?:0))+")",
                ], id: 0]
        )
      
      resultB = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','23-02-2013 10:00')
      resultL = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','23-02-2013 15:00')
      resultD = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','23-02-2013 22:00')
      resultBD = prasadamService.getDepartureCount(runtime,vipFlag,'21-02-2013 23:59','23-02-2013 10:00')
      resultLD = prasadamService.getDepartureCount(runtime,vipFlag,'21-02-2013 23:59','23-02-2013 15:00')
      resultDD = prasadamService.getDepartureCount(runtime,vipFlag,'21-02-2013 23:59','23-02-2013 22:00')

      jsonCells.add (
            [cell: [
            	    'Sat 23',
                    ((resultB['total']?:0)-(resultBD['total']?:0))+"(P"+((resultB['numPrji']?:0)-(resultBD['numPrji']?:0))+",M"+((resultB['numMataji']?:0)-(resultBD['numMataji']?:0))+",C"+((resultB['numChildren']?:0)-(resultBD['numChildren']?:0))+",B"+((resultB['numBrahmachari']?:0)-(resultBD['numBrahmachari']?:0))+")",
                    ((resultL['total']?:0)-(resultLD['total']?:0))+"(P"+((resultL['numPrji']?:0)-(resultLD['numPrji']?:0))+",M"+((resultL['numMataji']?:0)-(resultLD['numMataji']?:0))+",C"+((resultL['numChildren']?:0)-(resultLD['numChildren']?:0))+",B"+((resultL['numBrahmachari']?:0)-(resultLD['numBrahmachari']?:0))+")",
                    ((resultD['total']?:0)-(resultDD['total']?:0))+"(P"+((resultD['numPrji']?:0)-(resultDD['numPrji']?:0))+",M"+((resultD['numMataji']?:0)-(resultDD['numMataji']?:0))+",C"+((resultD['numChildren']?:0)-(resultDD['numChildren']?:0))+",B"+((resultD['numBrahmachari']?:0)-(resultDD['numBrahmachari']?:0))+")",
                ], id: 0]
        )

      resultB = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','24-02-2013 10:00')
      resultL = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','24-02-2013 15:00')
      resultD = prasadamService.getArrivalCount(runtime,vipFlag,'21-02-2013 23:59','24-02-2013 22:00')
      resultBD = prasadamService.getDepartureCount(runtime,vipFlag,'21-02-2013 23:59','24-02-2013 10:00')
      resultLD = prasadamService.getDepartureCount(runtime,vipFlag,'21-02-2013 23:59','24-02-2013 15:00')
      resultDD = prasadamService.getDepartureCount(runtime,vipFlag,'21-02-2013 23:59','24-02-2013 22:00')

      jsonCells.add (
            [cell: [
            	    'Sun 24',
                    ((resultB['total']?:0)-(resultBD['total']?:0))+"(P"+((resultB['numPrji']?:0)-(resultBD['numPrji']?:0))+",M"+((resultB['numMataji']?:0)-(resultBD['numMataji']?:0))+",C"+((resultB['numChildren']?:0)-(resultBD['numChildren']?:0))+",B"+((resultB['numBrahmachari']?:0)-(resultBD['numBrahmachari']?:0))+")",
                    ((resultL['total']?:0)-(resultLD['total']?:0))+"(P"+((resultL['numPrji']?:0)-(resultLD['numPrji']?:0))+",M"+((resultL['numMataji']?:0)-(resultLD['numMataji']?:0))+",C"+((resultL['numChildren']?:0)-(resultLD['numChildren']?:0))+",B"+((resultL['numBrahmachari']?:0)-(resultLD['numBrahmachari']?:0))+")",
                    ((resultD['total']?:0)-(resultDD['total']?:0))+"(P"+((resultD['numPrji']?:0)-(resultDD['numPrji']?:0))+",M"+((resultD['numMataji']?:0)-(resultDD['numMataji']?:0))+",C"+((resultD['numChildren']?:0)-(resultDD['numChildren']?:0))+",B"+((resultD['numBrahmachari']?:0)-(resultDD['numBrahmachari']?:0))+")",
                ], id: 0]
        )

        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

}
