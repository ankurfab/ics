package ics

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.dao.DataIntegrityViolationException
import groovy.sql.Sql;
import grails.converters.JSON
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import com.krishna.*
import org.hibernate.criterion.CriteriaSpecification

import org.apache.commons.codec.binary.Hex

import org.apache.commons.codec.digest.DigestUtils
import java.security.SecureRandom

class AccommodationAllotmentController {

    def housekeepingService
    def springSecurityService
    def dataSource; 
    def accommodationService

    
    def index = { 	
 }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
    }

    def create = {
        def accommodationAllotmentInstance = new AccommodationAllotment()
        accommodationAllotmentInstance.properties = params
        return [accommodationAllotmentInstance: accommodationAllotmentInstance]
    }

    def save = {
        def accommodationAllotmentInstance = new AccommodationAllotment(params)
        if (!accommodationAllotmentInstance.hasErrors() && accommodationAllotmentInstance.save()) {
            flash.message = "accommodationAllotment.created"
            flash.args = [accommodationAllotmentInstance.id]
            flash.defaultMessage = "AccommodationAllotment ${accommodationAllotmentInstance.id} created"
            redirect(action: "show", id: accommodationAllotmentInstance.id)
        }
        else {
            render(view: "create", model: [accommodationAllotmentInstance: accommodationAllotmentInstance])
        }
    }

    def show = {
        def accommodationAllotmentInstance = AccommodationAllotment.get(params.id)
        if (!accommodationAllotmentInstance) {
            flash.message = "accommodationAllotment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "AccommodationAllotment not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [accommodationAllotmentInstance: accommodationAllotmentInstance]
        }
    }

    def edit = {
        def accommodationAllotmentInstance = AccommodationAllotment.get(params.id)
        if (!accommodationAllotmentInstance) {
            flash.message = "accommodationAllotment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "AccommodationAllotment not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [accommodationAllotmentInstance: accommodationAllotmentInstance]
        }
    }

    def update = {
        def accommodationAllotmentInstance = AccommodationAllotment.get(params.id)
        if (accommodationAllotmentInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (accommodationAllotmentInstance.version > version) {
                    
                    accommodationAllotmentInstance.errors.rejectValue("version", "accommodationAllotment.optimistic.locking.failure", "Another user has updated this AccommodationAllotment while you were editing")
                    render(view: "edit", model: [accommodationAllotmentInstance: accommodationAllotmentInstance])
                    return
                }
            }
            accommodationAllotmentInstance.properties = params
            if (!accommodationAllotmentInstance.hasErrors() && accommodationAllotmentInstance.save()) {
                flash.message = "accommodationAllotment.updated"
                flash.args = [params.id]
                flash.defaultMessage = "AccommodationAllotment ${params.id} updated"
                redirect(action: "show", id: accommodationAllotmentInstance.id)
            }
            else {
                render(view: "edit", model: [accommodationAllotmentInstance: accommodationAllotmentInstance])
            }
        }
        else {
            flash.message = "accommodationAllotment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "AccommodationAllotment not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def accommodationAllotmentInstance = AccommodationAllotment.get(params.id)
        if (accommodationAllotmentInstance) {
            try {
                accommodationAllotmentInstance.delete()
                flash.message = "accommodationAllotment.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "AccommodationAllotment ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "accommodationAllotment.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "AccommodationAllotment ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "accommodationAllotment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "AccommodationAllotment not found with id ${params.id}"
            redirect(action: "list")
        }
    }


    def accommodationAllotment = {
	println "in accommodationAllotment: "+params
	//def eventRegistrationInstance
	def eventRegistrationInstance  = EventRegistration.get(new Long(params.id))
	//get the current allocations
	int numA=0
	int numPA=0
	int numMA=0
	int numCA=0
	int numBA=0
	def allotments = AccommodationAllotment.findAllByEventRegistration(eventRegistrationInstance)
	allotments.each{
		numA += it.numberAllotted
		numPA += it.numberofPrabhujisAllotted
		numMA += it.numberofMatajisAllotted
		numCA += it.numberofChildrenAllotted
		numBA += it.numberofBrahmacharisAllotted
	}
	log.debug("accommodationAllotment: "+numA+":"+numPA+":"+numMA+":"+numCA+":"+numBA)
	[eventRegistrationInstance: eventRegistrationInstance, numA: numA, numPA: numPA, numMA: numMA, numCA: numCA, numBA: numBA]
    }

    def jq_chart_list = {
	      println "in jq_chart_list: "+params
	      def maxRows = Integer.valueOf(params.rows)
	      def currentPage = Integer.valueOf(params.page) ?: 1
	      def vip = ''
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION'))
			vip = 'VIP'
		else 
			vip = ''	
	      
	      def result=accommodationService.suggest(vip,Date.parse('dd-MM-yyyy HH:mm', params.fromDate),Date.parse('dd-MM-yyyy HH:mm', params.toDate),params.int('numR')?:0,params.int('numP')?:0,params.int('numM')?:0,params.int('numC')?:0,params.int('numB')?:0)
	      def totalRows = result.size()
	      def numberOfPages = Math.ceil(totalRows / maxRows)
	      def acco,accoid,acconame,len
	      def jsonCells = result.collect {
		    len = it.name?.size()
		   if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION'))
		    	accoid=it.name[8..len-1]
		    else
		    	accoid=it.name[5..len-1]
		    log.info("Accoid:"+ accoid)
		    acco = EventAccommodation.get(accoid)
		    [cell: [acco.name,acco.address,acco.rankOverall,acco.maxCapacity,acco.availableCapacity
			], id: acco.id]
		}
		//todo now sort the json cells in decending order of rank
		
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
	        render jsonData as JSON    	
    }

    def jq_availability_list = {
	      println "in jq_availability_list: "+params
	      def sortIndex = params.sidx ?: 'rankOverall'
	      def sortOrder  = params.sord ?: 'desc'

	      def maxRows = Integer.valueOf(params.rows)
	      def currentPage = Integer.valueOf(params.page) ?: 1

	      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	      /*def vip = ''
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION'))
			vip = 'VIP'
		else 
			vip = ''	
	      
	      def result=accommodationService.search(vip,params.int('numP')?:0,params.int('numM')?:0,params.int('numC')?:0,params.int('numB')?:0)
	      */

    	def numR = (params.int('numP')?:0)+(params.int('numM')?:0)+(params.int('numC')?:0)+(params.int('numB')?:0)
    	if(numR==0)
    		numR=9999 //setting to a very large no so that no record is found..

	def result = EventAccommodation.createCriteria().list(max:maxRows, offset:rowOffset) {
		isNull('status')
		
		if(SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION'))
			eq('isVipAccommodation',true)
		else if(SpringSecurityUtils.ifNotGranted('ROLE_EVENTADMIN'))
			eq('isVipAccommodation',false)

		ge('availableCapacity',numR)
		
		if (params.name)
			ilike('name','%'+params.name + '%')

		if (params.address)
			ilike('address','%'+params.address + '%')

		if (params.comments)
			ilike('comments','%'+params.comments + '%')

		if (params.rankOverall)
				ge('rankOverall',params.int('rankOverall'))

		if (params.maxCapacity)
				ge('maxCapacity',params.int('maxCapacity'))

		if (params.availableCapacity)
				ge('availableCapacity',params.int('availableCapacity'))

		order(sortIndex, sortOrder)

	}

	      
	      def totalRows = result.totalCount
	      def numberOfPages = Math.ceil(totalRows / maxRows)
	      def jsonCells = result.collect {acco->
		    [cell: [acco.name,acco.address,acco.rankOverall,acco.comments,acco.availableCapacity,acco.maxCapacity
			], id: acco.id]
		}
		//todo now sort the json cells in decending order of rank
		
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
	        render jsonData as JSON    	
    }

    // return JSON list of Registration

    def jq_accommodation_list = {
              def now = new Date()
	      def today = now.format('D')
	      
	      def sortIndex = params.sidx ?: 'name'
	      def sortOrder  = params.sord ?: 'asc'

	      def maxRows = Integer.valueOf(params.rows)
	      def currentPage = Integer.valueOf(params.page) ?: 1

	      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
	      def result

	      def vip = false
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION'))
			vip = true
		else 
			vip = false

	      def sql = new Sql(dataSource);
	      String query = ""
	      query = "select id, name, rank_overall, available_from_date as availableFromDate, available_till_date as availableTillDate, max_capacity, max_prabhujis as maxPrabhujis, max_matajis as maxMatajis, max_childrens as maxChildrens, max_brahmacharis, available_capacity, available_prabhujis as availablePrabhujis, available_matajis as availableMatajis, available_childrens as availableChildrens,available_brahmacharis from event_accommodation where manual_mode=true and available_capacity > 0"
	      
	      if(vip)
	      	query += " and is_vip_accommodation=true"
	      else
	      	query += " and is_vip_accommodation=false"
		      
	      //add conditions
	      if (params.name)
	      {
		query += " and name like '%"+name+"%'"
	      }
	      //add sorting,ordering
	      query += " order by "+sortIndex+" "+sortOrder
	      
	      result = sql.rows(query,rowOffset,maxRows)

	      String countQuery = "select count(1) cnt from ("+query+") q"
	      
	      def totalRows = sql.firstRow(countQuery)?.cnt
	      def numberOfPages = Math.ceil(totalRows / maxRows)
	      
	      sql.close()
		
		
	      def jsonCells = result.collect {
		    [cell: [it.name,
			    it.rank_overall,
			    it.availableFromDate?.format('dd-MM HH:mm'),
			    it.availableTillDate?.format('dd-MM HH:mm'),
			    it.max_capacity,
			    it.maxPrabhujis,
			    it.maxMatajis,
			    it.maxChildrens,
			    it.max_brahmacharis,
			    it.available_capacity,
			    it.availablePrabhujis,
			    it.availableMatajis,
			    it.availableChildrens,
			    it.available_brahmacharis,
			    0,
			    0,
			    0,
			    0,
			    0,
			    params.erid
			], id: it.id]
		}
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
	        render jsonData as JSON
		
   }
    
	def jq_edit_accommodations() {
		log.debug("Inside jq_edit_accommodations:"+params)
		def acc = EventAccommodation.get(params.id)
		def reg = EventRegistration.get(params.erid)
		def aa = new AccommodationAllotment()
		aa.eventRegistration = reg
		aa.eventAccommodation = acc
		aa.numberAllotted = params.int('numberAllotted')?:0
		aa.numberofPrabhujisAllotted = params.int('numberofPrabhujisAllotted')?:0
		aa.numberofMatajisAllotted = params.int('numberofMatajisAllotted')?:0
		aa.numberofChildrenAllotted = params.int('numberofChildrenAllotted')?:0
		aa.numberofBrahmacharisAllotted = params.int('numberofBrahmacharisAllotted')?:0
		aa.allottFrom = acc.availableFromDate
		aa.allottTill = acc.availableTillDate
		aa.updator=aa.creator=springSecurityService.principal.username
		if(!aa.save())
			aa.errors.allErrors.each {println it}
		else
			{
			//now update the count in acc
			acc.availableCapacity -= aa.numberAllotted
			acc.availablePrabhujis -= aa.numberofPrabhujisAllotted
			acc.availableMatajis -= aa.numberofMatajisAllotted
			acc.availableChildrens -= aa.numberofChildrenAllotted
			acc.availableBrahmacharis -= aa.numberofBrahmacharisAllotted
			if(!acc.save())
				     acc.errors.allErrors.each {
						 println "jq_edit_accommodations error in updating acc"+it
					    }
			}
		  flash.message = "Alloted!!"

		  def response = [id:aa.id]

		  render response as JSON
	}


	def jq_edit_accommodations_old = {
	      print("In Edit-->"+params)

	      int noAllotted = params.int('numberAllotted')?:0
	      int noPrabhujis = params.int('numberofPrabhujisAllotted')?:0
	      int noMatajis = params.int('numberofMatajisAllotted')?:0
	      int noChildrens = params.int('numberofChildrenAllotted')?:0
	      int noBrahmacharis = params.int('numberofBrahmacharisAllotted')?:0
	      int accommodationAllotmentId
	      def accommodationAllotment
	      
	      def eventRegistration = EventRegistration.get(params.erid)
	      def eventAccommodation = EventAccommodation.get(params.id)

	      def allotments = AccommodationAllotment.findAllByEventRegistration(eventRegistration)

	      int prabhjisAccommodatedTillNow = 0
	      int matajisAccommodatedTillNow = 0
	      int childrensAccommodatedTillNow = 0

	      int allotmentIsCorrect
	      String message = ""

	      allotments.each { allotment ->
	          if (allotment.eventAccommodation.id == eventAccommodation.id){
			accommodationAllotmentId = allotment.id
	          }
		  prabhjisAccommodatedTillNow = prabhjisAccommodatedTillNow + allotment.numberofPrabhujisAllotted
		  matajisAccommodatedTillNow = matajisAccommodatedTillNow + allotment.numberofMatajisAllotted
		  childrensAccommodatedTillNow = childrensAccommodatedTillNow + allotment.numberofChildrenAllotted
	      }

	      //check allotment is according to availability
	      if(eventAccommodation.availablePrabhujis >= noPrabhujis &&
		 eventAccommodation.availableMatajis >= noMatajis &&
		 eventAccommodation.availableChildrens >= noChildrens 
		 ) {
		 allotmentIsCorrect = 1
	      } else {
		 allotmentIsCorrect = 0
		 message = message.concat("New allotment is not acoording to Availability.")
	      }
	      
	      //check new allotment 
	      if((eventRegistration.numberofPrabhujis - prabhjisAccommodatedTillNow) >= noPrabhujis &&
		 (eventRegistration.numberofMatajis - matajisAccommodatedTillNow) >= noMatajis &&
		 (eventRegistration.numberofChildren - childrensAccommodatedTillNow) >= noChildrens &&
		  allotmentIsCorrect == 1
		 ) {
		 allotmentIsCorrect = 1
	      } else {
	         allotmentIsCorrect = 0
		 message = message.concat("New allotment is not acoording to accommodations required by guest.")
	      }
	      	      
	      if(accommodationAllotmentId) {
		 accommodationAllotment = AccommodationAllotment.get(accommodationAllotmentId) 
		 accommodationAllotment.numberofPrabhujisAllotted = accommodationAllotment.numberofPrabhujisAllotted + noPrabhujis
		 accommodationAllotment.numberofMatajisAllotted = accommodationAllotment.numberofMatajisAllotted + noMatajis
		 accommodationAllotment.numberofChildrenAllotted = accommodationAllotment.numberofChildrenAllotted + noChildrens
	      } else {
		 accommodationAllotment = new AccommodationAllotment()
		 accommodationAllotment.eventRegistration = eventRegistration
		 accommodationAllotment.eventAccommodation = eventAccommodation
		 accommodationAllotment.numberofPrabhujisAllotted = noPrabhujis
		 accommodationAllotment.numberofMatajisAllotted = noMatajis
		 accommodationAllotment.numberofChildrenAllotted = noChildrens
	      }

	      accommodationAllotment.creator = "temp"
	      accommodationAllotment.updator = "temp"

	      if (allotmentIsCorrect == 1) {
	      
	         if (accommodationAllotment.save(flush: true)) {
		    
		    // check if allotment status of registration needs to be change 

		    if(prabhjisAccommodatedTillNow + noPrabhujis == eventRegistration.numberofPrabhujis &&
		       matajisAccommodatedTillNow + noMatajis == eventRegistration.numberofMatajis &&
		       childrensAccommodatedTillNow + noChildrens == eventRegistration.numberofChildren ) {
			eventRegistration.accommodationAllotmentStatus = AccommodationAllotmentStatus.ALLOTEMENT_COMPLETE
		    } else {
			eventRegistration.accommodationAllotmentStatus = AccommodationAllotmentStatus.ALLOTEMENT_IN_PROGRESS
		    }
		    
		    if (!eventRegistration.save(flush: false)) {
			    eventRegistration.errors.allErrors.each {
				 println it
		            }
		    }
		    
		    
			
		    eventAccommodation.availablePrabhujis = eventAccommodation.availablePrabhujis - noPrabhujis
		    eventAccommodation.availableMatajis = eventAccommodation.availableMatajis - noMatajis
		    eventAccommodation.availableChildrens = eventAccommodation.availableChildrens - noChildrens
		    if (!eventAccommodation.save(flush: false)) {
			eventAccommodation.errors.allErrors.each {
				println it
			}
		    }

		    message = message.concat("Allotment successfully saved.") 

	      } else if (allotmentIsCorrect == 1){
		    accommodationAllotment.errors.allErrors.each {
			 println it
		    }
	      }
	 
	  }

	  flash.message = message

	  def response = [id:eventRegistration.id]

	  render response as JSON
       }


       def jq_registration_list = {
              def now = new Date()
	      def today = now.format('D')
	      
	      def sortIndex = params.sidx ?: 'a.name'
	      def sortOrder  = params.sord ?: 'asc'

	      def maxRows = Integer.valueOf(params.rows)
	      def currentPage = Integer.valueOf(params.page) ?: 1

	      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
	      def result
	      def sql = new Sql(dataSource);
	      String query = ""
	      query = "select a.id, a.name, a.address, a.comments, aa.allott_from as availableFromDate, aa.allott_till as availableTillDate, aa.number_allotted as totalAllotted, aa.numberof_prabhujis_allotted as prabhujisAllotted, aa.numberof_matajis_allotted as matajisAllotted, aa.numberof_children_allotted as childrensAllotted, aa.numberof_brahmacharis_allotted as brahmacharisAllotted from event_accommodation a, accommodation_allotment aa where a.id = aa.event_accommodation_id  and aa.event_registration_id = "+params.id

	      //add conditions
	      if (params.name)
	      {
		query += " and name like '%"+name+"%'"
	      }
	      //add sorting,ordering
	      query += " order by "+sortIndex+" "+sortOrder
	      
	      result = sql.rows(query,rowOffset,maxRows)

	      String countQuery = "select count(1) cnt from ("+query+") q"
	      
	      def totalRows = sql.firstRow(countQuery)?.cnt
	      def numberOfPages = Math.ceil(totalRows / maxRows)
	      
	      sql.close()
		
		
	      def jsonCells = result.collect {
		    [cell: [it.name,
			    it.address,
			    it.comments,
			    it.totalAllotted,
			    it.prabhujisAllotted,
			    it.matajisAllotted,
			    it.childrensAllotted,
			    it.brahmacharisAllotted,
			], id: it.id]
		}
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
	        render jsonData as JSON
		
   }
    
	def jq_edit_registrations = {
	      
	      print("In Edit-->"+params)

	      def accommodationAllotment = AccommodationAllotment.get(params.id) 

	      int noPrabhujis
	      int noMatajis
	      int noChildrens

	      if (accommodationAllotment.numberofPrabhujisAllotted != params.int('prabhujisAllotted')){
		  noPrabhujis = params.int('prabhujisAllotted')	
	      } else {
	          noPrabhujis = 0
	      }
	      
	      if (accommodationAllotment.numberofMatajisAllotted != params.int('matajisAllotted')){
		  noMatajis = params.int('matajisAllotted')	
	      } else {
	          noMatajis = 0
	      }

	      if (accommodationAllotment.numberofChildrenAllotted != params.int('childrensAllotted')){
		  noChildrens = params.int('childrensAllotted')	
	      } else {
	          noChildrens = 0
	      }

	      //Calculated the difference

	      int diffPrabhujis = accommodationAllotment.numberofPrabhujisAllotted - noPrabhujis
	      int diffMatajis = accommodationAllotment.numberofMatajisAllotted - noMatajis
	      int diffChildrens = accommodationAllotment.numberofChildrenAllotted - noChildrens

	      
	      def eventRegistration = EventRegistration.get(accommodationAllotment.eventRegistration.id)
	      def eventAccommodation = EventAccommodation.get(accommodationAllotment.eventAccommodation.id)

	      def allotments = AccommodationAllotment.findAllByEventRegistration(eventRegistration)

	      int prabhjisAccommodatedTillNow = 0
	      int matajisAccommodatedTillNow = 0
	      int childrensAccommodatedTillNow = 0

	      int allotmentIsCorrect
	      String message = ""

	      allotments.each { allotment ->
	          if (allotment.eventAccommodation.id == eventAccommodation.id){
			prabhjisAccommodatedTillNow = prabhjisAccommodatedTillNow + noPrabhujis
			matajisAccommodatedTillNow = matajisAccommodatedTillNow + noMatajis
			childrensAccommodatedTillNow = childrensAccommodatedTillNow + noChildrens
	          } else {
			prabhjisAccommodatedTillNow = prabhjisAccommodatedTillNow + allotment.numberofPrabhujisAllotted
			matajisAccommodatedTillNow = matajisAccommodatedTillNow + allotment.numberofMatajisAllotted
			childrensAccommodatedTillNow = childrensAccommodatedTillNow + allotment.numberofChildrenAllotted
		  }
		  
	      }

	      //check new allotment for guest requirement
	      if(eventRegistration.numberofPrabhujis >= prabhjisAccommodatedTillNow &&
		 eventRegistration.numberofMatajis >= matajisAccommodatedTillNow &&
		 eventRegistration.numberofChildren >= childrensAccommodatedTillNow
		 ) {
		 allotmentIsCorrect = 1
	      } else {
                 allotmentIsCorrect = 0	          
		 message = message.concat("New allotment is exceeding guest requirement.")
	      }
	      
	      //check new allotment for maximum limit 
	      if(eventAccommodation.maxPrabhujis >= (eventAccommodation.availablePrabhujis + noPrabhujis) &&
		 eventAccommodation.maxMatajis >= (eventAccommodation.availableMatajis + noMatajis) &&
		 eventAccommodation.maxChildrens >= (eventAccommodation.availableChildrens + noChildrens) &&
		 allotmentIsCorrect == 1
		 ) {
		 allotmentIsCorrect = 1
	      } else {
		 allotmentIsCorrect = 0
		 message = message.concat("New allotment is exceeding maximum limit.")
	      }
	      	      
	      if (noPrabhujis != 0 ){
		 accommodationAllotment.numberofPrabhujisAllotted = noPrabhujis
	      }
	      if (noMatajis != 0 ){
		 accommodationAllotment.numberofMatajisAllotted = noMatajis
	      }
	      if (noChildrens != 0 ){
		 accommodationAllotment.numberofChildrenAllotted = noChildrens
	      }
	      accommodationAllotment.creator = "temp"
	      accommodationAllotment.updator = "temp"

	      print("Allotment-"+allotmentIsCorrect)
	      print("message-"+message)

	      if (allotmentIsCorrect == 1) {
	         
		 if(accommodationAllotment.save(flush: true)) {
		    
		    // check if allotment status of registration needs to be change 

		    if(prabhjisAccommodatedTillNow + noPrabhujis == eventRegistration.numberofPrabhujis &&
		       matajisAccommodatedTillNow + noMatajis == eventRegistration.numberofMatajis &&
		       childrensAccommodatedTillNow + noChildrens == eventRegistration.numberofChildren ) {
			
			eventRegistration.accommodationAllotmentStatus = AccommodationAllotmentStatus.ALLOTEMENT_COMPLETE
		    } else {
			eventRegistration.accommodationAllotmentStatus = AccommodationAllotmentStatus.ALLOTEMENT_IN_PROGRESS
		    }
		    
		    if (!eventRegistration.save(flush: false)) {
			    eventRegistration.errors.allErrors.each {
				 println it
		            }
		    }
		    
			
		    eventAccommodation.availablePrabhujis = eventAccommodation.availablePrabhujis + diffPrabhujis
		    eventAccommodation.availableMatajis = eventAccommodation.availableMatajis + diffMatajis
		    eventAccommodation.availableChildrens = eventAccommodation.availableChildrens + diffChildrens
		    if (!eventAccommodation.save(flush: false)) {
			eventAccommodation.errors.allErrors.each {
				println it
			}
		    }

		    message = message.concat("Allotment successfully saved.") 

	      } else {
		    accommodationAllotment.errors.allErrors.each {
			 println it
		    }
	      }
	 
	   }

	   flash.message = message

	   def response = [id:eventRegistration.id,message:message]

	   render response as JSON
         
       
       }
       
       def allot() {
	log.debug("In allot call..with params:"+params)
	def eventRegistrationInstance
	if(params.id)
		eventRegistrationInstance  = EventRegistration.get(new Long(params.id))
	else if (params.regCode)
		eventRegistrationInstance  = EventRegistration.findByRegCode(params.regCode)
	else return
	
	//get the current allocations
	int numA=0
	int numPA=0
	int numMA=0
	int numCA=0
	int numBA=0
	def allotments = AccommodationAllotment.findAllByEventRegistration(eventRegistrationInstance)
	allotments.each{
		numA += it.numberAllotted
		numPA += it.numberofPrabhujisAllotted
		numMA += it.numberofMatajisAllotted
		numCA += it.numberofChildrenAllotted
		numBA += it.numberofBrahmacharisAllotted
	}
	[eventRegistrationInstance: eventRegistrationInstance, numA: numA, numPA: numPA, numMA: numMA, numCA: numCA, numBA: numBA]
       }
       
       def jq_allocation_summary() {
		def eventRegistrationInstance
		if(params.searchString)
			{
			eventRegistrationInstance = EventRegistration.findByRegCode(params.searchString)
			/*redirect(action: "allot", id: eventRegistrationInstance.id)
			return*/
			}
		else
			eventRegistrationInstance = EventRegistration.get(params.id)
		//get the current allocations
		int num = eventRegistrationInstance.numberofPrabhujis+eventRegistrationInstance.numberofMatajis+eventRegistrationInstance.numberofChildren+eventRegistrationInstance.numberofBrahmacharis
		int numA=0
		int numPA=0
		int numMA=0
		int numCA=0
		int numBA=0
		int numC=0
		int numPC=0
		int numMC=0
		int numCC=0
		int numBC=0
		
		def allotments = AccommodationAllotment.findAllByEventRegistration(eventRegistrationInstance)
		allotments.each{
			numA += it.numberAllotted
			numPA += it.numberofPrabhujisAllotted
			numMA += it.numberofMatajisAllotted
			numCA += it.numberofChildrenAllotted
			numBA += it.numberofBrahmacharisAllotted
			/*numC += it.numberCheckedin
			numPC += it.numberofPrabhujisCheckedin
			numMC += it.numberofMatajisCheckedin
			numCC += it.numberofChildrenCheckedin
			numBC += it.numberofBrahmacharisCheckedin*/
		}
	      
	      def jsonCells = [[cell: [
	      		    'Registered Group',
	      		    eventRegistrationInstance.name,
	      		    eventRegistrationInstance.contactNumber,
	      		    eventRegistrationInstance.regCode,
			    eventRegistrationInstance.arrivalDate?.format('dd-MM HH:mm'),
			    eventRegistrationInstance.departureDate?.format('dd-MM HH:mm'),
			    numA+"/"+num,
			    numPA+"/"+eventRegistrationInstance.numberofPrabhujis,
			    numMA+"/"+eventRegistrationInstance.numberofMatajis,
			    numCA+"/"+eventRegistrationInstance.numberofChildren,
			    numBA+"/"+eventRegistrationInstance.numberofBrahmacharis,
			], id: eventRegistrationInstance.id]]
		//now add the data for the runtime groups
		def erg = EventRegistrationGroup.findByMainEventRegistration(eventRegistrationInstance)

		int cnt=0,total=0,prji=0,mataji=0,children=0,bchari=0
		int totalC=0,prjiC=0,matajiC=0,childrenC=0,bchariC=0

		erg?.subEventRegistrations?.each{
			def subAA = AccommodationAllotment.findBySubEventRegistration(it)
			numC = subAA?.numberCheckedin?:0
			numPC = subAA?.numberofPrabhujisCheckedin?:0
			numMC = subAA?.numberofMatajisCheckedin?:0
			numCC = subAA?.numberofChildrenCheckedin?:0
			numBC = subAA?.numberofBrahmacharisCheckedin?:0
			jsonCells.add(
				[cell: [
				    'SubGroup',
				    it.name,
				    it.contactNumber,
				    "",
				    "",
				    "",
				    numC+"/"+(it.numberofPrabhujis+it.numberofMatajis+it.numberofChildren+it.numberofBrahmacharis),
				    numPC+"/"+it.numberofPrabhujis,
				    numMC+"/"+it.numberofMatajis,
				    numCC+"/"+it.numberofChildren,
				    numBC+"/"+it.numberofBrahmacharis,
				], id: it.id]
			)
				cnt++
				total+=it.numberofPrabhujis+it.numberofMatajis+it.numberofChildren+it.numberofBrahmacharis
				prji+=it.numberofPrabhujis
				mataji+=it.numberofMatajis
				children+=it.numberofChildren
				bchari+=it.numberofBrahmacharis
				
				totalC+=numC
				prjiC+=numPC
				matajiC+=numMC
				childrenC+=numCC
				bchariC+=numBC
				
		}
	      def maxRows = Integer.valueOf(params.rows)
	      def currentPage = Integer.valueOf(params.page) ?: 1
	      def totalRows = cnt+1
	      def numberOfPages = Math.ceil(totalRows / maxRows)

		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages, userdata:[arrival:'Total',departure:'CheckedIn/Arrived',total:totalC+"/"+total,prji:prjiC+"/"+prji,mataji:matajiC+"/"+mataji,children:childrenC+"/"+children,brahmacharis:bchariC+"/"+bchari]]
	        render jsonData as JSON       
       }
       
       def complete() {
       	log.debug("Inside AccommodationAllotment.complete()"+params)
       	def eventRegistrationInstance  = EventRegistration.get(params.erid)
       	eventRegistrationInstance.accommodationAllotmentStatus = AccommodationAllotmentStatus.ALLOTEMENT_COMPLETE
	if(!eventRegistrationInstance.save(flush:true))
		{
		eventRegistrationInstance.errors.allErrors.each { println it   }
		}
       }
       
       def jq_allotment_list = {
	      log.debug("In jq_allotment_list.."+params)
	      def sortIndex = params.sidx ?: 'numberAllotted'
	      def sortOrder  = params.sord ?: 'asc'

	      def maxRows = Integer.valueOf(params.rows)
	      def currentPage = Integer.valueOf(params.page) ?: 1

	      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
	      
	      def result = AccommodationAllotment.createCriteria().list(max:maxRows, offset:rowOffset) {
		    if (params.id)
			eq('eventRegistration',EventRegistration.get(params.id))
		    order(sortIndex, sortOrder)
	      }
	      def totalRows = result.totalCount
	      def numberOfPages = Math.ceil(totalRows / maxRows)

		def numberAllotted = 0
		def numberofPrabhujisAllotted = 0
		def numberofMatajisAllotted = 0
		def numberofChildrenAllotted = 0
		def numberofBrahmacharisAllotted = 0
		def numberCheckedin = 0
		def numberofPrabhujisCheckedin = 0
		def numberofMatajisCheckedin = 0
		def numberofChildrenCheckedin = 0
		def numberofBrahmacharisCheckedin = 0
		
		
	      def jsonCells = result.collect {

		numberAllotted += it.numberAllotted
		numberofPrabhujisAllotted += it.numberofPrabhujisAllotted
		numberofMatajisAllotted += it.numberofMatajisAllotted
		numberofChildrenAllotted += it.numberofChildrenAllotted
		numberofBrahmacharisAllotted += it.numberofBrahmacharisAllotted
		numberCheckedin += it.numberCheckedin
		numberofPrabhujisCheckedin += it.numberofPrabhujisCheckedin
		numberofMatajisCheckedin += it.numberofMatajisCheckedin
		numberofChildrenCheckedin += it.numberofChildrenCheckedin
		numberofBrahmacharisCheckedin += it.numberofBrahmacharisCheckedin

		    [cell: [it.eventAccommodation?.name,
			    it.eventAccommodation?.address,
			    it.eventAccommodation?.comments,
			    it.numberAllotted,
			    it.numberofPrabhujisAllotted,
			    it.numberofMatajisAllotted,
			    it.numberofChildrenAllotted,
			    it.numberofBrahmacharisAllotted,
			    it.subEventRegistration?.name?:'',
			    it.numberCheckedin,
			    it.numberofPrabhujisCheckedin,
			    it.numberofMatajisCheckedin,
			    it.numberofChildrenCheckedin,
			    it.numberofBrahmacharisCheckedin
			], id: it.id]
		}
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages,userdata:[comments:'Total',numberAllotted:numberAllotted,numberofPrabhujisAllotted:numberofPrabhujisAllotted,numberofMatajisAllotted:numberofMatajisAllotted,numberofChildrenAllotted:numberofChildrenAllotted,numberofBrahmacharisAllotted:numberofBrahmacharisAllotted,numberCheckedin:numberCheckedin,numberofPrabhujisCheckedin:numberofPrabhujisCheckedin,numberofMatajisCheckedin:numberofMatajisCheckedin,numberofChildrenCheckedin:numberofChildrenCheckedin,numberofBrahmacharisCheckedin:numberofBrahmacharisCheckedin]]
	        render jsonData as JSON
		
   }
       
	def jq_edit_allotment = {
	      log.debug("In jq_edit_allotment with params:"+params)
	      def accommodationAllotment = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			    // delete accommodationAllotment
			    if(accommodationService.deleteAA(it))
			    	{
				    message = "AccommodationAllotment  ${accommodationAllotment.name} Deleted"
				    state = "OK"
				    log.debug("In jq_edit_allotment:del: "+message)
			    	}
		  	}
		  break;
		 default :
		  // edit action
		  id = params.id
		  if (accommodationService.updateAA(params)) {
		      message = "AccommodationAllotment Updated"
		      state = "OK"
		    } else {
			    accommodationAllotment.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update AccommodationAllotment"
		    }
		  log.debug("In jq_edit_allotment:edit: "+message)
		  break;
		  }
      def response = [message:message,state:state,id:id]

      render response as JSON
    }
    
    def checkin() {
    	log.debug("In checkin: "+params)
    	int count=0
    	def message=""
    	def er = EventRegistration.get(params.erid)
    	if(er?.regCode)
    		message="Please select the sub-group not the original group leader!!"
    	def aa = AccommodationAllotment.get(params.aaid)
    	if(er && !er.regCode && aa)
    		{
    		if(aa.subEventRegistration == null)
    			{
			if(er.numberofPrabhujis<=aa.numberofPrabhujisAllotted && er.numberofMatajis<=aa.numberofMatajisAllotted && er.numberofChildren<=aa.numberofChildrenAllotted && er.numberofBrahmacharis<=aa.numberofBrahmacharisAllotted) 
				{
				aa.numberofPrabhujisCheckedin = er.numberofPrabhujis
				aa.numberofMatajisCheckedin = er.numberofMatajis
				aa.numberofChildrenCheckedin = er.numberofChildren
				aa.numberofBrahmacharisCheckedin = er.numberofBrahmacharis
				aa.numberCheckedin = aa.numberofPrabhujisCheckedin+aa.numberofMatajisCheckedin+aa.numberofChildrenCheckedin+aa.numberofBrahmacharisCheckedin
				aa.subEventRegistration = er
				if(!aa.save())
					{
					log.debug("Error in updating aa during checkin..") 
					aa.errors.allErrors.each { println it   }
					}
				else
					count=aa.subEventRegistration.id	//to be used in printing ACS
					//update the checkin count in accommodation
					def acco = aa.eventAccommodation
					acco.totalCheckedin += aa.numberCheckedin
					acco.totalPrjiCheckedin += aa.numberofPrabhujisCheckedin
					acco.totalMatajiCheckedin += aa.numberofMatajisCheckedin
					acco.totalChildrenCheckedin += aa.numberofChildrenCheckedin
					acco.totalBrahmachariCheckedin += aa.numberofBrahmacharisCheckedin
					if(!acco.save())
						{
						log.debug("Error in updating acco during checkin..") 
						acco.errors.allErrors.each { println it   }
						}
				}
			else
				{
				message="Cannot checkin more number of guests than already allotted!!"
				}
			}
		else
			message="A subgroup has already checked-in. Please edit the entry for adding more guests!!"
    		}
    	render([count:count,message:message] as JSON)
    }
        
    def invalidlist() {
    }
    
    def jq_invalid_list = {
      def sortIndex = params.sidx ?: 'numberAllotted'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = AccommodationAllotment.createCriteria().list(max:maxRows, offset:rowOffset) {
			eventRegistration{
					or{
						ne('verificationStatus',VerificationStatus.VERIFIED)
						eq('isAccommodationRequired',false)
					}
				}
			order(sortIndex, sortOrder)
			}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.eventRegistration.regCode,
            	    it.eventRegistration.name,
            	    it.eventAccommodation.name,
            	    it.numberAllotted
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_invalid = {
	      log.debug('In jq_edit_invalid:'+params)
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			    // free accommodationAllotment
			    if(!accommodationService.free(it))
			    	{
				    message = "Could not free the allotment!!"
				    state = "FAIL"
			    	}
			    else {
				    message = "Deleted!!"
				    state = "OK"
			    }
		  	}
		  break;
		 default :
		  // edit action
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }
       
    def jq_full_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def sql = new Sql(dataSource);
      String query = ""

	      query = "select er.id,er.reg_code,er.name,er.verification_status,er.is_accommodation_required,er.numberof_prabhujis,er.numberof_matajis,er.numberof_children,er.numberof_brahmacharis,er.accommodation_allotment_status,a.eaname,a.eaca from event_registration er left join (select aa.id aaid,event_registration_id erid,ea.name eaname,ea.available_capacity eaca from accommodation_allotment aa , event_accommodation ea where aa.event_accommodation_id=ea.id) a on er.id=a.erid"
	      //add conditions
	      
	      if(params.name || params.address || params.number || params.email || params.counsellor || params.guru || params.dobFlag)
	      	query += " where "
	      
	      def numCondns = 0
	      
	      if (params.legalname)
	      {
	      	query += " icv.legalname like '%"+params.legalname+"%'"
	      	numCondns++
	      }
	      
	      if (params.initiatedname)
	      {
	      	if(numCondns>0)
	      		query += " and icv.initiatedname like '%"+params.initiatedname+"%'"
	      	else
	      		query += " icv.initiatedname like '%"+params.initiatedname+"%'"
	      	numCondns++
	      }
	      
      //add sorting,ordering
      query += " order by "+sortIndex+" "+sortOrder
      
      //println query
      def result = sql.rows(query,rowOffset,maxRows)

	//println 'result='+result
      String countQuery = "select count(1) cnt from ("+query+") q"
      //println countQuery
      
      def totalRows = sql.firstRow(countQuery)?.cnt
      def numberOfPages = Math.ceil(totalRows / maxRows)
      
      sql.close()

      def jsonCells = result.collect {
            [cell: [
            	    it.reg_code,
            	    it.name,
            	    it.verification_status,
            	    it.is_accommodation_required,
            	    it.numberof_prabhujis,
            	    it.numberof_matajis,
            	    it.numberof_children,
            	    it.numberof_brahmacharis,
            	    it.numberof_prabhujis+it.numberof_matajis+it.numberof_children+it.numberof_brahmacharis,
            	    it.accommodation_allotment_status,
            	    it.eaname,
            	    it.eaca,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages,userdata:[]]
        render jsonData as JSON
        }    
}
