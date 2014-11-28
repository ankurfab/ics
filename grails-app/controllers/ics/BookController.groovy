package ics

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import java.util.zip.ZipOutputStream  
import java.util.zip.ZipEntry  
import org.grails.plugins.csv.CSVWriter
import org.apache.commons.lang.StringEscapeUtils.*

class BookController {
    def springSecurityService
    def housekeepingService
    def receiptSequenceService
    def bookService
    def individualService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [bookInstanceList: Book.list(params), bookInstanceTotal: Book.count()]
    }

    def create() {
        [bookInstance: new Book(params)]
    }

    def save() {
        params.creator=springSecurityService.principal.username
        params.updator=params.creator

        def bookInstance = new Book(params)
        if (!bookInstance.save(flush: true)) {
            render(view: "create", model: [bookInstance: bookInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'book.label', default: 'Book'), bookInstance.id])
        redirect(action: "show", id: bookInstance.id)
    }

    def show() {
        def bookInstance = Book.get(params.id)
        if (!bookInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), params.id])
            redirect(action: "list")
            return
        }

        [bookInstance: bookInstance]
    }

    def edit() {
        def bookInstance = Book.get(params.id)
        if (!bookInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), params.id])
            redirect(action: "list")
            return
        }

        [bookInstance: bookInstance]
    }

    def update() {
        def bookInstance = Book.get(params.id)
        if (!bookInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (bookInstance.version > version) {
                bookInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'book.label', default: 'Book')] as Object[],
                          "Another user has updated this Book while you were editing")
                render(view: "edit", model: [bookInstance: bookInstance])
                return
            }
        }

        params.updator=springSecurityService.principal.username
        bookInstance.properties = params

        if (!bookInstance.save(flush: true)) {
            render(view: "edit", model: [bookInstance: bookInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'book.label', default: 'Book'), bookInstance.id])
        redirect(action: "show", id: bookInstance.id)
    }

    def delete() {
        def bookInstance = Book.get(params.id)
        if (!bookInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), params.id])
            redirect(action: "list")
            return
        }

        try {
            bookInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'book.label', default: 'Book'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'book.label', default: 'Book'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

// return JSON list of books
    def jq_book_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def books = Book.createCriteria().list(max:maxRows, offset:rowOffset) {
            // name case insensitive where the field contains with the search term
            if (params.name)
                ilike('name',params.name)
            if (params.author)
                ilike('author',params.author)
            if (params.publisher)
                ilike('publisher',params.publisher)
            if (params.category)
                eq('category',params.category)
            if (params.type)
                eq('type',params.type)
            if (params.language)
                eq('language',params.language)
            if (params.alias)
                ilike('alias',params.alias)
            if (params.costPrice)
                ge('costPrice',new BigDecimal(params.costPrice))
            if (params.sellPrice)
                ge('sellPrice',new BigDecimal(params.sellPrice))
            if (params.stock)
                ge('stock',new BigDecimal(params.stock))
            if (params.reorderLevel)
                ge('reorderLevel',new BigDecimal(params.reorderLevel))

            order(sortIndex, sortOrder)
      }
      def totalRows = books.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = books.collect {
            [cell: [it.name,
            	it.author,
            	it.publisher,
            	it.category,
            	it.type,
            	it.language,
            	it.alias,
            	it.costPrice,
            	it.sellPrice,
            	it.stock,
            	it.reorderLevel
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }
    
	def jq_edit_book = {
	      def book = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add instruction sent
		  params.creator = springSecurityService.principal.username
		  params.updator = params.creator
		  book = new Book(params)
		  if (! book.hasErrors() && book.save()) {
		    message = "Book ${book.name} Added"
		    id = book.id
		    state = "OK"
		  } else {
		    book.errors.allErrors.each {
			println it
		    }		    
		    message = "Could Not Save Book"
		  }
		  break;
		case 'del':
		  // check book exists
		  book = Book.get(params.id)
		  if (book) {
		    // delete book
		    book.delete()
		    message = "Book  ${book.name} Deleted"
		    state = "OK"
		  }
		  break;
		 default :
		  // edit action
		  // first retrieve the book by its ID
		  book = Book.get(params.id)
		  if (book) {
		    // set the properties according to passed in parameters
		  	params.updator = springSecurityService.principal.username
		    book.properties = params
		    if (! book.hasErrors() && book.save()) {
		      message = "Book  ${book.name} Updated"
		      id = book.id
		      state = "OK"
		    } else {
		    book.errors.allErrors.each {
			println it
		    }		    
		      message = "Could Not Update Book"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }
	    
	def gridlist() {}

    def allBooksAsJSON_JQ = {
	def query = params.term
	def c = Book.createCriteria()
	def items = c.list(max:10)
		{
		or{
			like("name", query+"%")
			like("alias", query+"%")
		}
		order("name", "asc")
		order("language", "asc")
		order("sellPrice", "asc")
		order("type", "asc")
		order("category", "asc")
		}
        response.setHeader("Cache-Control", "no-store")

        def results = items.collect {
            [  
               id: it.id,
               value: it.toString(),
               label: it.toString() ]
        }

        render results as JSON
    }
    
    def team() {}
    
    def order() {[indid:session.individualid]}

    def settle() {}

    def jq_team_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = RelationshipGroup.createCriteria().list(max:maxRows, offset:rowOffset) {
	
		eq('category','JIVADAYA')
		eq('refid',session.individualid?.toInteger())
		
		if(params.groupName)
			ilike('groupName',params.groupName)
		if(params.comments)
			ilike('comments',params.comments)
		if(params.status)
			eq('status',params.status)
		if(params.fromDate)
			ge('fromDate',Date.parse('dd-MM-yyyy', params.fromDate))
		if(params.tillDate)
			le('tillDate',Date.parse('dd-MM-yyyy', params.tillDate))

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)
    
      def jsonCells = result.collect {
            [cell: [
            	    it.groupName,
            	    it.fromDate.format('dd-MM-yyyy'),
            	    it.tillDate.format('dd-MM-yyyy'),
            	    it.comments,
            	    it.status,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_team = {
	      log.debug('In jq_team_edit:'+params)
	      def team = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add team sent
		  //format the dates
		  params.fromDate = Date.parse('dd-MM-yyyy',params.fromDate)
		  params.tillDate = Date.parse('dd-MM-yyyy',params.tillDate)
		  params.refid = session.individualid
		  params.category = 'JIVADAYA'
				
		  team = new RelationshipGroup(params)
		  team.updator=team.creator=springSecurityService.principal.username
		  if (! team.hasErrors() && team.save()) {
		    message = "Team Saved.."
		    id = team.id
		    state = "OK"
		  } else {
		    team.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save Team"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check team exists
			  team  = Team.get(it)
			  if (team) {
			    // delete team
			    if(!team.delete())
			    	{
				    team.errors.allErrors.each {
					log.debug("In jq_team_edit: error in deleting team:"+ it)
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
		  // edit action
		  // first retrieve the team by its ID
		  team = Team.get(params.id)
		  if (team) {
		    // set the properties according to passed in parameters
		  params.fromDate = Date.parse('dd-MM-yyyy',params.fromDate)
		  params.tillDate = Date.parse('dd-MM-yyyy',params.tillDate)
		    team.properties = params
			  team.updator = springSecurityService.principal.username
		    if (! team.hasErrors() && team.save()) {
		      message = "Team  ${team.id} Updated"
		      id = team.id
		      state = "OK"
		    } else {
			    team.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Team"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def jq_teammember_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
	def result = Relationship.createCriteria().list(max:maxRows, offset:rowOffset) {
		relationshipGroup{eq('id',new Long(params.teamid?:-1))}
		if(params.name)
			individual1{
				or {
					ilike('legalName',params.name)
					ilike('initiatedName',params.name)
				}
			}
			
		if(sortIndex=='name')
			individual1{
				order('initiatedName', sortOrder)
				order('legalName', sortOrder)
			}
		else
			order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.individual1?.toString()
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_teammember = {
	      log.debug("Inside jq_edit_member : "+params)
	      def member = null
	      def message = ""
	      def state = "FAIL"
	      def id

		def team = null
		if(params.teamid)
			team=RelationshipGroup.get(params.teamid)

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add member sent
		  params.'individual1.id' = params.'item.id'
		  params.'individual2.id' = session.individualid
		  params.relationshipGroup = team
		  params.relation = Relation.findByCategoryAndName('JivaDaya','TeamMember')
		  params.status = 'ACTIVE'
		  member = new Relationship(params)		  
		  member.updator=member.creator=springSecurityService.principal.username
		  if (! member.hasErrors() && member.save()) {
		    message = "Member Saved.."
		    id = member.id
		    state = "OK"
		  } else {
		    member.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save Member"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check member exists
			  member  = Member.get(it)
			  if (member) {
			    // delete member
			    if(!member.delete())
			    	{
				    member.errors.allErrors.each {
					log.debug("In jq_member_edit: error in deleting member:"+ it)
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
		  // edit action
		  // first retrieve the member by its ID
		  member = Member.get(params.id)
		  if (member) {
		    // set the properties according to passed in parameters
		    member.properties = params
			  member.updator = springSecurityService.principal.username
		    if (! member.hasErrors() && member.save()) {
		      message = "Member  ${member.id} Updated"
		      id = member.id
		      state = "OK"
		    } else {
			    member.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Member"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }    

    def jq_order_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = BookOrder.createCriteria().list(max:maxRows, offset:rowOffset) {	
		if(SpringSecurityUtils.ifAnyGranted('ROLE_JIVADAYA_USER'))
			placedBy{eq('id',session.individualid)}
		if(SpringSecurityUtils.ifAnyGranted('ROLE_JIVADAYA_ADMIN,,ROLE_JIVADAYA_CLERK'))
			ne('status','Draft')
		if(params.orderNo)
			eq('orderNo',params.orderNo)
		if(params.'team.id')
			team{eq('id',new Long(params.'team.id'))}
		if(params.challan)
			challan{eq('refNo',params.challan)}
		if(params.comments)
			ilike('comments',params.comments)
		if(params.status)
			eq('status',params.status)
		if(params.orderDate)
			ge('orderDate',Date.parse('dd-MM-yyyy', params.orderDate))

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)
    
      def jsonCells = result.collect {
            [cell: [
            	    it.team?.groupName,
            	    it.comments?:'',
            	    it.orderNo?:'',
            	    it.orderDate?.format('dd-MM-yyyy HH:mm'),
            	    it.status?:'',
            	    it.challan?.refNo?:'',
            	    it.placedBy?.toString()
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_order = {
	      log.debug('In jq_edit_order:'+params)
	      def order = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add order sent
		  //format the dates
		  params.orderDate = new Date()
		  params.'placedBy.id' = session.individualid
		  params.status = "Draft"				
		  order = new BookOrder(params)
		  order.updator=order.creator=springSecurityService.principal.username
		  if (! order.hasErrors() && order.save()) {
		    //assign order no
		    order.orderNo = "JDORD"+housekeepingService.getFY() +"/"+ receiptSequenceService.getNext("JD-Order")
		    order.save()
		    message = "BookOrder Saved.."
		    id = order.id
		    state = "OK"
		  } else {
		    order.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save BookOrder"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check order exists
			  order  = BookOrder.get(it)
			  if (order) {
			    // delete order
			    if(!order.delete())
			    	{
				    order.errors.allErrors.each {
					log.debug("In jq_order_edit: error in deleting order:"+ it)
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
		  // edit action
		  // first retrieve the order by its ID
		  order = BookOrder.get(params.id)
		  if (order) {
		    // set the properties according to passed in parameters
		    order.properties = params
			  order.updator = springSecurityService.principal.username
		    if (! order.hasErrors() && order.save()) {
		      message = "BookOrder  ${order.id} Updated"
		      id = order.id
		      state = "OK"
		    } else {
			    order.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update BookOrder"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def jq_orderlineitem_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
	def result = BookOrderLineItem.createCriteria().list(max:maxRows, offset:rowOffset) {
		order{eq('id',new Long(params.orderid?:-1))}
		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.book?.name+":"+(it.book?.language?:'')+":"+(it.book?.type?:''),
            	    it.requiredQuantity
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_orderlineitem = {
	      log.debug("Inside jq_edit_orderlineitem : "+params)
	      def boli = null
	      def message = ""
	      def state = "FAIL"
	      def id

		def order = null
		if(params.orderid)
			order=BookOrder.get(params.orderid)

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add boli sent
		  params.order = order
		  params.book = Book.get(params.'item.id')
		  boli = new BookOrderLineItem(params)		  
		  boli.updator=boli.creator=springSecurityService.principal.username
		  if (! boli.hasErrors() && boli.save()) {
		    message = "BookOrderLineItem Saved.."
		    id = boli.id
		    state = "OK"
		  } else {
		    boli.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save BookOrderLineItem"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check boli exists
			  boli  = BookOrderLineItem.get(it)
			  if (boli) {
			    // delete boli
			    if(!boli.delete())
			    	{
				    boli.errors.allErrors.each {
					log.debug("In jq_boli_edit: error in deleting boli:"+ it)
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
		  // edit action
		  // first retrieve the boli by its ID
		  boli = BookOrderLineItem.get(params.id)
		  if (boli) {
		    // set the properties according to passed in parameters
		  params.order = order
		    params.book = Book.get(params.'item.id')
		    boli.properties = params
			  boli.updator = springSecurityService.principal.username
		    if (! boli.hasErrors() && boli.save()) {
		      message = "BookOrderLineItem  ${boli.id} Updated"
		      id = boli.id
		      state = "OK"
		    } else {
			    boli.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update BookOrderLineItem"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }
	    
	def orderSubmit() {
		def retVal = bookService.orderSubmit(params)
	      def response = [message:retVal?.toString(),state:"OK",id:0]
	      render response as JSON
	}

	def orderProcess() {
		def retVal = bookService.orderProcess(params)
	      def response = [message:retVal?.toString(),state:"OK",id:0]
	      render response as JSON
	}

	def orderIssue() {
		def order = bookService.orderIssue(params)
	      def response = [challanRefNo: order?.challan?.refNo, challanid:order?.challan?.id,state:"OK",id:0]
	      render response as JSON
	}

	def orderReject() {
		def retVal = bookService.orderReject(params)
	      def response = [message:retVal?.toString(),state:"OK",id:0]
	      render response as JSON
	}
	
	def campaign() {
	}
	
    def jq_campaign_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = Campaign.createCriteria().list(max:maxRows, offset:rowOffset) {	

		if(params.name)
			ilike('name',params.name)
		if(params.description)
			ilike('description',params.description)
		if(params.fromDate)
			ge('fromDate',Date.parse('dd-MM-yyyy', params.fromDate))
		if(params.tillDate)
			ge('tillDate',Date.parse('dd-MM-yyyy', params.tillDate))
		if(params.category)
			eq('category',params.category)
		if(params.status)
			eq('status',params.status)

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)
    
      def jsonCells = result.collect {
            [cell: [
            	    it.name,
            	    it.description?:'',
            	    it.fromDate?.format('dd-MM-yyyy'),
            	    it.tillDate?.format('dd-MM-yyyy'),
            	    it.category?:'',
            	    it.status?:'',
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_campaign = {
	      log.debug('In jq_edit_campaign:'+params)
	      def campaign = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add campaign sent
		  //format the dates
		  params.fromDate = Date.parse('dd-MM-yyyy', params.fromDate)
		  params.tillDate = Date.parse('dd-MM-yyyy', params.tillDate)
		  campaign = new Campaign(params)
		  campaign.updator=campaign.creator=springSecurityService.principal.username
		  if (! campaign.hasErrors() && campaign.save()) {
		    message = "Campaign Saved.."
		    id = campaign.id
		    state = "OK"
		  } else {
		    campaign.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save Campaign"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check campaign exists
			  campaign  = Campaign.get(it)
			  if (campaign) {
			    // delete campaign
			    if(!campaign.delete())
			    	{
				    campaign.errors.allErrors.each {
					log.debug("In jq_campaign_edit: error in deleting campaign:"+ it)
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
		  // edit action
		  // first retrieve the campaign by its ID
		  campaign = Campaign.get(params.id)
		  if (campaign) {
		    // set the properties according to passed in parameters
		    if(params.fromDate)
		  	params.fromDate = Date.parse('dd-MM-yyyy', params.fromDate)
		    if(params.tillDate)
			  params.tillDate = Date.parse('dd-MM-yyyy', params.tillDate)
		    campaign.properties = params
			  campaign.updator = springSecurityService.principal.username
		    if (! campaign.hasErrors() && campaign.save()) {
		      message = "Campaign  ${campaign.id} Updated"
		      id = campaign.id
		      state = "OK"
		    } else {
			    campaign.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Campaign"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def jq_bookprice_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
	def result = BookPrice.createCriteria().list(max:maxRows, offset:rowOffset) {
		campaign{eq('id',new Long(params.campaignid?:-1))}
		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.book?.name,
            	    it.book?.language,
            	    it.price
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_bookprice = {
	      log.debug("Inside jq_edit_bookprice : "+params)
	      def bookPrice = null
	      def message = ""
	      def state = "FAIL"
	      def id

		def campaign = null
		if(params.campaignid)
			campaign=Campaign.get(params.campaignid)

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add bookPrice sent
		  params.campaign = campaign
		  params.book = Book.get(params.'item.id')
		  bookPrice = new BookPrice(params)		  
		  bookPrice.updator=bookPrice.creator=springSecurityService.principal.username
		  if (! bookPrice.hasErrors() && bookPrice.save()) {
		    message = "BookPrice Saved.."
		    id = bookPrice.id
		    state = "OK"
		  } else {
		    bookPrice.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save BookPrice"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check bookPrice exists
			  bookPrice  = BookPrice.get(it)
			  if (bookPrice) {
			    // delete bookPrice
			    if(!bookPrice.delete())
			    	{
				    bookPrice.errors.allErrors.each {
					log.debug("In jq_bookPrice_edit: error in deleting bookPrice:"+ it)
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
		  // edit action
		  // first retrieve the bookPrice by its ID
		  bookPrice = BookPrice.get(params.id)
		  if (bookPrice) {
		    // set the properties according to passed in parameters
		  params.campaign = campaign
		    params.book = Book.get(params.'item.id')
		    bookPrice.properties = params
			  bookPrice.updator = springSecurityService.principal.username
		    if (! bookPrice.hasErrors() && bookPrice.save()) {
		      message = "BookPrice  ${bookPrice.id} Updated"
		      id = bookPrice.id
		      state = "OK"
		    } else {
			    bookPrice.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update BookPrice"
		    }
		  }
		  break;
 	 }
	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }
	
    def jq_bookstock_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
	def result = BookStock.createCriteria().list(max:maxRows, offset:rowOffset) {
		book{eq('id',new Long(params.bookid?:-1))}
		if(params.stockDate)
			ge('stockDate',Date.parse('dd-MM-yyyy', params.stockDate))

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.stockDate?.format('dd-MM-yyyy'),
            	    it.stock,
            	    it.price,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_bookstock = {
	      log.debug("Inside jq_edit_bookstock : "+params)
	      def bookStock = null
	      def message = ""
	      def state = "FAIL"
	      def id

		def book = null
		if(params.bookid)
			book=Book.get(params.bookid)

		    if(params.stockDate)
		  	params.stockDate = Date.parse('dd-MM-yyyy', params.stockDate)

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add bookStock sent
		  params.book = book
		  bookStock = new BookStock(params)		  
		  bookStock.updator=bookStock.creator=springSecurityService.principal.username
		  if (! bookStock.hasErrors() && bookStock.save()) {
		    message = "BookStock Saved.."
		    id = bookStock.id
		    state = "OK"
		    //also increment book stock
		    bookService.updateBookStock(book, bookStock.stock, 'increment')
		  } else {
		    bookStock.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save BookStock"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check bookStock exists
			  bookStock  = BookStock.get(it)
			  if (bookStock) {
			    //update stock first
			    bookService.updateBookStock(book,bookStock.stock, 'decrement')
			    // delete bookStock
			    if(!bookStock.delete())
			    	{
				    bookStock.errors.allErrors.each {
					log.debug("In jq_bookStock_edit: error in deleting bookStock:"+ it)
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
		  // edit action
		  // first retrieve the bookStock by its ID
		  bookStock = BookStock.get(params.id)
		  if (bookStock) {
		    // set the properties according to passed in parameters
		  params.book = book
		    bookStock.properties = params
			  bookStock.updator = springSecurityService.principal.username
		    if (! bookStock.hasErrors() && bookStock.save()) {
		      message = "BookStock  ${bookStock.id} Updated"
		      id = bookStock.id
		      state = "OK"
		    } else {
			    bookStock.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update BookStock"
		    }
		  }
		  break;
 	 }
	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def uploadBookStock() {
	    def f = request.getFile('myFile')
	    if (f.empty) {
		flash.message = 'file cannot be empty'
	   	redirect (action: "gridlist")
		return
	    }

	    def counter = 0,success=false,failedRecords=[],successRecords=[]
	    f.inputStream.toCsvReader(['skipLines':'1']).eachLine{ tokens ->
	    	counter++
	    	success = bookService.uploadBookStock(tokens)
	    	if(success)
	    		successRecords.add(counter)
	    	else
	    		failedRecords.add(counter)
	    }

	    flash.message = "BulkBookStock: Num records processed: "+counter+" Successful Records: "+successRecords+" Failed Records: "+failedRecords
	    redirect (action: "gridlist")
    }
    
    def orderBulkUpload() {
	    def counter = 0,success=false,failedRecords=[],successRecords=[]
	    def f = request.getFile('myFile')
	    if (f.empty) {
		flash.message = 'file cannot be empty'
	   	redirect (action: "order")
		return
	    }
	    
	    //first create order
	    def order = new BookOrder()
	    if(params.distributorIcsId)
	    	   {
		    order.placedBy = Individual.findByIcsid(params.distributorIcsId)
		    order.status = "Submitted"
		    }
	    else
	    	{
	    	order.placedBy = Individual.get(session.individualid)	
	    	 order.status = "Draft"
	    	 }
	    	 
	    order.orderDate = new Date()
	   
	    order.updator=order.creator=springSecurityService.principal.username
	  if (! order.hasErrors() && order.save()) {
	    //assign order no
	    order.orderNo = "JDORD"+housekeepingService.getFY() +"/"+ receiptSequenceService.getNext("JD-Order")
	    if(!order.save())
		    order.errors.allErrors.each {log.debug(it)}
	    else {
		    f.inputStream.toCsvReader(['skipLines':'1']).eachLine{ tokens ->
			counter++
			success = bookService.uploadBookOrder(order, tokens)
			if(success)
				successRecords.add(counter)
			else
				failedRecords.add(counter)
			}
		    if(!order.save())
			    order.errors.allErrors.each {log.debug(it)}			
	    	}
	  } else
	    	order.errors.allErrors.each {log.debug(it)}
		

	    flash.message = "BulkBookOrder: Num records processed: "+counter+" Successful Records: "+successRecords+" Failed Records: "+failedRecords
	    redirect (action: "order")
    }
    
    def orderBulkSettle() {
	    log.debug("Inside orderBulkSettle:"+params)
	    flash.message=""
	    def counter = 0,success=false,failedRecords=[],successRecords=[]
	    def f = request.getFile('myFile')
	    if (f.empty) {
		flash.message = 'file cannot be empty'
	   	redirect (action: "order")
		return
	    }
	    
	    //first get challan
	    def challan
	    try{
	    	challan = Challan.findByRefNo(params.challanRef)
	    }
	    catch(Exception e){flash.message="Incorrect challan no!!"}
	    
	  if (challan) {
		    f.inputStream.toCsvReader(['skipLines':'1']).eachLine{ tokens ->
			counter++
			success = bookService.updateChallanLineItem(challan, tokens)
			if(success)
				successRecords.add(counter)
			else
				failedRecords.add(counter)
			}
	  }
	    flash.message += "BulkChallanSettle: Num records processed: "+counter+" Successful Records: "+successRecords+" Failed Records: "+failedRecords
	    redirect (action: "order")
    }
    
    def createOrder() {
    	log.debug("In createOrder with params: "+params)
    	def success=false
	  // add order sent
	  try{
		  //modifiy contact details
		  if(params.modifyContact) {
			//update voice contact
			def vc = VoiceContact.get(params.contactid)
			if(vc) {
				vc.number = params.distributorContact
				vc.updator = springSecurityService.principal.username
				if(!vc.save())
					vc.errors.allErrors.each {log.debug(it)}
				}
			//update email contact
			def ec = EmailContact.get(params.emailid)
			if(ec) {
				ec.emailAddress = params.distributorEmail
				ec.updator = springSecurityService.principal.username
				if(!ec.save())
					ec.errors.allErrors.each {log.debug(it)}
				}	  	
		  }
	  }
	  catch(Exception e) {log.debug("Exception in modify contact while adding order"+e)}
	  
	  //check if existing distributor or new distributor
	  if(!params.distributorid)
	  	params.distributorid = individualService.createIndividualFromOrder(params)?.id
	  params.orderDate = new Date()
	  params.'placedBy.id' = params.distributorid
	  params.status = "In-Progress"				
	  def order = new BookOrder(params)
	  order.updator=order.creator=springSecurityService.principal.username
	  if (! order.hasErrors() && order.save()) {
	    //assign order no
	    order.orderNo = "JDORD"+housekeepingService.getFY() +"/"+ receiptSequenceService.getNext("JD-Order")
	    if(!order.save())
		    order.errors.allErrors.each {
			log.debug(it)
			}	    	
	    success=true
	  } else {
	    order.errors.allErrors.each {
		log.debug(it)
		}
	  }
	  	log.debug(order)
	      def response = [success:success,message:'']

	      render response as JSON	  
    }

    def printOrder() {
    	def bookOrder = BookOrder.get(params.orderid)
    	if(bookOrder)
    		render(template: "printOrder", model: [bookOrder: bookOrder])
    	else
    		render "No book order found with the specified id. Kindly contact admin!!"
    }
    
    def orderTemplate() {
      def result = Book.list(['sort':'name'])
	response.contentType = 'application/zip'
	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		zipOutputStream.putNextEntry(new ZipEntry("bulkorder.csv"))
		//header
		zipOutputStream << "Name,Language,Type,SellingPrice,IssueQuantity,ReturnQuantity" 

		result.each{ row ->
			zipOutputStream << "\n"
			zipOutputStream <<   (row.name?:'')+","+(row.language?:'')+","+(row.type?:'')+","+
				  (row.sellPrice?:'') +","+
				  '' +","+
				  ''
		}
	}    		
	return    
    }
    
    def scores() {
    	def scores = bookService.scores()
    	[scores:scores]
    }

}
