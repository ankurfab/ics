package ics

import grails.converters.JSON

class GiftIssuedController {
    def springSecurityService
    def housekeepingService
    
    
    
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
	    if (request.xhr) {
		render(template: "giftIssuedGrid", model: [issuedToid : params.'issuedTo.id'])
		return
	    }
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        params.sort = "lastUpdated"//'issueDate'
        params.order = 'desc'
        [giftIssuedInstanceList: GiftIssued.list(params), giftIssuedInstanceTotal: GiftIssued.count()]
    }

    def create = {
        def giftIssuedInstance = new GiftIssued()
        giftIssuedInstance.properties = params
        return [giftIssuedInstance: giftIssuedInstance]
    }

    def save = {
    def fromDonation=false
    if(params.issueDate)
		params.issueDate = Date.parse('dd-MM-yyyy', params.issueDate)
	if (params."gift.id" == null)
		{
		params."gift.id" = params."acGift_id"
		params."issuedTo.id" = params."acIssuedTo_id"
		params."issuedBy.id" = params."acIssuedBy_id"
		fromDonation = true
    		}
		if (springSecurityService.isLoggedIn()) {
			params.creator=springSecurityService.principal.username
		}
		else
			params.creator=""
		params.updator=params.creator

        def giftIssuedInstance = new GiftIssued(params)
    	
    	//verify the quantity
    	def gift = Gift.get(params."gift.id")
    	def sq = gift.qtyInStock
    	def q = params.issuedQty.toInteger()
    	
    	if((sq-q)<0)
    	{
    	
	    flash.message = "Request quantity more than what is available in stock ("+gift.qtyInStock+")"
	    def viewName = "create"
	    if(fromDonation)
	    	viewName = "createfordonation"
	    	
	    render(view: viewName, model: [giftIssuedInstance: giftIssuedInstance])
	}
	else
	{
	    
        if (giftIssuedInstance.save(flush: true)) {
        	
        	//deduct the gift qty
        	gift.qtyInStock = gift.qtyInStock - q
        	gift.updator = springSecurityService.principal.username
        	gift.save()
        	
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'giftIssued.label', default: 'GiftIssued'), giftIssuedInstance.id])}"
            redirect(action: "show", id: giftIssuedInstance.id)
        }
        else {
            render(view: "create", model: [giftIssuedInstance: giftIssuedInstance])
        }
        }
    }

    def show = {
        def giftIssuedInstance = GiftIssued.get(params.id)
        if (!giftIssuedInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'giftIssued.label', default: 'GiftIssued'), params.id])}"
            redirect(action: "list")
        }
        else {
            [giftIssuedInstance: giftIssuedInstance]
        }
    }

    def edit = {
        def giftIssuedInstance = GiftIssued.get(params.id)
        //--------SLDD--------1 begin
	    /*def  sq1, q1
	    def gift1 = giftIssuedInstance.gift //Gift.get(params."gift.id")
	    println "params:"+params
	    println "gift1="+gift1
    //--------SLDD--------1 end
        
        //--------SLDD--------2 begin
        if (giftIssuedInstance)
        {
        	println 'giftIssuedInstance'
		//println "q11="+q1
		if (gift1)
		{
			//println "Edit"
			sq1 = gift1.qtyInStock
			println 'sq1='+sq1
			q1 = params.issuedQty.toInteger() 
			println "q12="+q1
		}
				
        }*/
        //--------SLDD--------2 end
        
        if (!giftIssuedInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'giftIssued.label', default: 'GiftIssued'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [giftIssuedInstance: giftIssuedInstance]
        }
    }

    def update = {
        def giftIssuedInstance = GiftIssued.get(params.id)
    	if(params.issueDate)
		params.issueDate = Date.parse('dd-MM-yyyy', params.issueDate)

    	//--------SLDD--------3 begin
    	//verify if
    	//a. gift is same but quantity is changed
    	//b. gift is changed
    	
    	def q1, gift1
    	q1 = giftIssuedInstance.issuedQty
    	gift1 = giftIssuedInstance.gift
    	println "q1="+q1
    	
    	def gift2 = Gift.get(params."gift.id")
    	def q2 = params.issuedQty.toInteger()
    	println "q2="+q2
    	def sq2, qdiff
    	
    	println 'params='+params
    	//a. if gift is same but quantity is changed
    	if (gift1.id == gift2.id)
    	{
    		if (q1 < q2)
    		{
			qdiff = q2 - q1
			println 'qdiff='+qdiff
			sq2 = gift2.qtyInStock - qdiff
			 
	    		if((sq2-q2)<0)
		    	{	    	
			    flash.message = "Request quantity more than what is available in stock ("+sq2+")"
			    		    	
			    render(view: "edit", model: [giftIssuedInstance: giftIssuedInstance])
			}
			else
			{
				gift2.qtyInStock = sq2
				gift2.updator = springSecurityService.principal.username
        			gift2.save()
			}
			
    		}
    		if (q1 > q2)
    		{
			qdiff = q1 - q2
			gift2.qtyInStock = gift2.qtyInStock + qdiff
	    		gift2.updator = springSecurityService.principal.username
        		gift2.save()
    		}
    	}
	else //b. if gift is changed
	{
		sq2 = gift2.qtyInStock
		if((sq2-q2)<0)
		    	
		{	    	
		    flash.message = "Request quantity more than what is available in stock ("+gift2.qtyInStock+")"
		    def viewName = "edit"
		    //if(fromDonation)
		    //	viewName = "createfordonation"
		    	
		    render(view: viewName, model: [giftIssuedInstance: giftIssuedInstance])
		}
		else
		{
			//deduct the new gift qty
			gift2.qtyInStock = gift2.qtyInStock - q2
	    		gift2.updator = springSecurityService.principal.username
        		gift2.save()

        		//add the old gift qty
        		gift1.qtyInStock = gift1.qtyInStock + q1
        		gift1.updator = springSecurityService.principal.username
        		gift1.save()
        	}
	}
	//--------SLDD--------3 end
	
        if (giftIssuedInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (giftIssuedInstance.version > version) {
                    
                    giftIssuedInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'giftIssued.label', default: 'GiftIssued')] as Object[], "Another user has updated this GiftIssued while you were editing")
                    render(view: "edit", model: [giftIssuedInstance: giftIssuedInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            giftIssuedInstance.properties = params
            if (!giftIssuedInstance.hasErrors() && giftIssuedInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'giftIssued.label', default: 'GiftIssued'), giftIssuedInstance.id])}"
                redirect(action: "show", id: giftIssuedInstance.id)
            }
            else {
                render(view: "edit", model: [giftIssuedInstance: giftIssuedInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'giftIssued.label', default: 'GiftIssued'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def giftIssuedInstance = GiftIssued.get(params.id)
        if (giftIssuedInstance) {
            try {
                giftIssuedInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'giftIssued.label', default: 'GiftIssued'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'giftIssued.label', default: 'GiftIssued'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'giftIssued.label', default: 'GiftIssued'), params.id])}"
            redirect(action: "list")
        }
    }

    def createfordonation = {
        def giftIssuedInstance = new GiftIssued()
        
        println "In createfordonation"+params
        
        def donation = Donation.get(params.'donation.id')
        params."issuedTo.id" = donation?.donatedBy.id
        params."issuedBy.id" = donation?.receivedBy.id
        
        giftIssuedInstance.properties = params

	//get summary donation
	def summaryDonation = housekeepingService.donationSummary(""+donation?.donatedBy.id)

        return [giftIssuedInstance: giftIssuedInstance,totalDonation:summaryDonation.amtInd,totalGiftsWorth:summaryDonation.amtGiftInd,totalGiftsNumber:summaryDonation.numGiftInd]
    }

    def search = {
	if(params.sIssueDate)
		params.sIssueDate = Date.parse('dd-MM-yyyy', params.sIssueDate)
    def criteria = GiftIssued.createCriteria()
    def giftIssuedInstanceList = criteria {
			and {
				if (params.sDonorLegalName)
					{
					issuedTo {
					        like("legalName", "%"+params.sDonorLegalName+"%")
					    }
					}
				if (params.sDonorInitName)
					{
					issuedTo {
					        like("initiatedName", "%"+params.sDonorInitName+"%")
					    }
					}
				if (params.sGiftName)
					{
					gift {
					        like("name", "%"+params.sGiftName+"%")
					    }
					}
				if (params.sIssuedByLegalName)
					{
					issuedBy {
					        like("legalName", "%"+params.sIssuedByLegalName+"%")
					    }
					}
				if (params.sIssuedByInitName)
					{
					issuedBy {
					        like("initiatedName", "%"+params.sIssuedByInitName+"%")
					    }
					}
				if (params.sIssueDate)
			    		eq("issueDate", params.sIssueDate)
				if (params.sComments)
			    		like("comments", "%"+params.sComments+"%")
				}
       		 	}
                render(view: "list", model: [giftIssuedInstanceList: giftIssuedInstanceList, search: true])

    }

    def jq_giftIssued_list = {
      def sortIndex = 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = GiftIssued.createCriteria().list(max:maxRows, offset:rowOffset) {
			issuedTo{
				eq('id',new Long(params.'issuedTo.id'))
				}
			order(sortIndex, sortOrder)
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.gift?.name,
            	    it.issuedQty,
            	    it.issuedQty * (it.gift?.worth?:0),
            	    it.issueDate?.format("dd-MM-yyyy"),
            	    it.comments
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_giftIssued = {
	      log.debug('In jq_giftIssued_edit:'+params)
	      def message = ""
	      def state = "FAIL"
	      def id
	      def comm

	  if(params.issueDate)
		  params.issueDate = Date.parse('dd-MM-yyyy',params.issueDate)

	      // determine our action
	      switch (params.oper) {
		case 'add':
		
		  comm = new GiftIssued(params)

		comm.updator = comm.creator=springSecurityService.principal.username
		comm.issuedBy = Individual.get(session.individualid)

		  if (! comm.hasErrors() && comm.save()) {
		    message = "GiftIssued Saved.."
		    id = comm.id
		    state = "OK"
		  } else {
		    comm.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save GiftIssued"
		  }
		  break;
		case 'del':
			def idList = params.id.tokenize(',')
			idList.each
			{
			  // check comm exists
			  comm  = GiftIssued.get(it)
			  if (comm) {
				//comm.status='DELETED'
				//comm.updator = springSecurityService.principal.username
			    if(!comm.delete())
				{
				    comm.errors.allErrors.each {
					log.debug("In jq_giftIssued_edit: error in deleting giftIssued:"+ it)
					}
				}
			    else {
				    message = "Deleted!!"
				    state = "OK"
			    }
			  }
			}
		  break;
		 default :

		  comm = GiftIssued.get(params.id)
		  if (comm) {
		    // set the properties according to passed in parameters
		    comm.properties = params

		    if (!comm.hasErrors() && comm.save()) {
		      message = "GiftIssued  ${comm.id} Updated"
		      id = comm.id
		      state = "OK"
		    } else {
			    comm.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update giftIssued"
		    }
		  }
		  break;
	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
    }

}
