package ics

import org.springframework.dao.DataIntegrityViolationException
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import grails.converters.JSON

class PurchaseListController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def springSecurityService

    def index() {
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [purchaseListInstanceList: PurchaseList.list(params), purchaseListInstanceTotal: PurchaseList.count()]
    }

    def create() {
        [purchaseListInstance: new PurchaseList(params)]
    }

    def save() {
        def purchaseListInstance = new PurchaseList(params)
        if (!purchaseListInstance.save(flush: true)) {
            render(view: "create", model: [purchaseListInstance: purchaseListInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'purchaseList.label', default: 'PurchaseList'), purchaseListInstance.id])
        redirect(action: "show", id: purchaseListInstance.id)
    }

    def show() {
        def purchaseListInstance = PurchaseList.get(params.id)
        if (!purchaseListInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'purchaseList.label', default: 'PurchaseList'), params.id])
            redirect(action: "list")
            return
        }

        [purchaseListInstance: purchaseListInstance]
    }

    def edit() {
        def purchaseListInstance = PurchaseList.get(params.id)
        if (!purchaseListInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'purchaseList.label', default: 'PurchaseList'), params.id])
            redirect(action: "list")
            return
        }

        [purchaseListInstance: purchaseListInstance]
    }

    def update() {
        def purchaseListInstance = PurchaseList.get(params.id)
        if (!purchaseListInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'purchaseList.label', default: 'PurchaseList'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (purchaseListInstance.version > version) {
                purchaseListInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'purchaseList.label', default: 'PurchaseList')] as Object[],
                          "Another user has updated this PurchaseList while you were editing")
                render(view: "edit", model: [purchaseListInstance: purchaseListInstance])
                return
            }
        }

        purchaseListInstance.properties = params

        if (!purchaseListInstance.save(flush: true)) {
            render(view: "edit", model: [purchaseListInstance: purchaseListInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'purchaseList.label', default: 'PurchaseList'), purchaseListInstance.id])
        redirect(action: "show", id: purchaseListInstance.id)
    }

    def delete() {
        def purchaseListInstance = PurchaseList.get(params.id)
        if (!purchaseListInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'purchaseList.label', default: 'PurchaseList'), params.id])
            redirect(action: "list")
            return
        }

        try {
            purchaseListInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'purchaseList.label', default: 'PurchaseList'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'purchaseList.label', default: 'PurchaseList'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jq_purchaseList_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = PurchaseList.createCriteria().list(max:maxRows, offset:rowOffset) {
	    if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VS_ADMIN,ROLE_VS_USER'))
	    	department{eq('name','VaishnavSamvardhan')}
	    if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VS_USER'))
	    	preparedBy{eq('id',session.individualid)}

		if (params.name)
			ilike('name','%'+params.name + '%')

		if (params.status)
				ilike('status','%'+params.status + '%')

		if (params.'preparedBy')
				preparedBy{
					or
						{
						ilike('legalName','%'+params.preparedBy + '%')
						ilike('initiatedName','%'+params.preparedBy + '%')
						}
					}
		if (params.preparationComments)
			ilike('preparationComments','%'+params.preparationComments + '%')

		if (params.'purchasedBy')
				purchasedBy{
					or
						{
						ilike('legalName','%'+params.purchasedBy + '%')
						ilike('initiatedName','%'+params.purchasedBy + '%')
						}
					}
		if (params.purchaseComments)
			ilike('purchaseComments','%'+params.purchaseComments + '%')


		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.name,
            	    it.status,
            	    it.preparedBy?.toString(),
            	    it.purchaseListDate?.format('dd-MM-yyyy HH:mm'),
            	    it.preparationComments,
            	    it.purchasedBy?.toString(),
            	    it.purchaseDateDate?.format('dd-MM-yyyy HH:mm'),
            	    it.purchaseComments,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    	def jq_edit_purchaseList = {
    	      def purchaseList = null
    	      def message = ""
    	      def state = "FAIL"
    	      def id
    
    	      // determine our action
    	      switch (params.oper) {
    		case 'add':
    		  // add instruction sent
    		  params.creator = springSecurityService.principal.username
    		  params.updator = params.creator
    		  purchaseList = new PurchaseList(params)
    		  purchaseList.preparedBy = Individual.get(session.individualid)
    		  purchaseList.purchaseListDate = new Date()
    		  if (! purchaseList.hasErrors() && purchaseList.save()) {
    		    message = "PurchaseList ${purchaseList.name} Added"
    		    id = purchaseList.id
    		    state = "OK"
    		  } else {
    		    purchaseList.errors.allErrors.each {
    			println it
    		    }		    
    		    message = "Could Not Save PurchaseList"
    		  }
    		  break;
    		case 'del':
    		  // check purchaseList exists
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  purchaseList = PurchaseList.get(it)
			  if (purchaseList) {
			    // delete purchaseList
			    purchaseList.delete()
			    message = "PurchaseList  ${purchaseList.name} Deleted"
			    state = "OK"
			  }
			}
    		  break;
    		 default :
    		  // edit action
    		  // first retrieve the purchaseList by its ID
    		  purchaseList = PurchaseList.get(params.id)
    		  if (purchaseList) {
    		    // set the properties according to passed in parameters
    		    params.updator = springSecurityService.principal.username
    		    purchaseList.properties = params
    		    if (! purchaseList.hasErrors() && purchaseList.save()) {
    		      message = "PurchaseList  ${purchaseList.name} Updated"
    		      id = purchaseList.id
    		      state = "OK"
    		    } else {
    		    purchaseList.errors.allErrors.each {
    			println it
    		    }		    
    		      message = "Could Not Update PurchaseList"
    		    }
    		  }
    		  break;
     	 }
    
    	      def response = [message:message,state:state,id:id]
    
    	      render response as JSON
    }

    def jq_requiredItem_list = {
      def purchaseList
      if(params.purchaseListid)
      	purchaseList=PurchaseList.get(new Long(params.purchaseListid))
      def jsonCells = purchaseList?.requiredItems?.sort{it.item.name}.collect {
            [cell: [
            	    it.item.name,
            	    it.qty,
            	    it.unit.toString(),
            	    it.rate,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:1,records:purchaseList?.requiredItems?.size(),total:1]
        render jsonData as JSON
        }

	def jq_edit_requiredItem = {
	      def purchaseItem = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  purchaseItem = new PurchaseItem(params)
		  purchaseItem.updator=purchaseItem.creator=springSecurityService.principal.username
		  purchaseItem.nqty = purchaseItem.qty
		  purchaseItem.nrate = purchaseItem.rate
		  purchaseItem.nunit = purchaseItem.unit
		  purchaseItem.item = Item.get(params.'item.name')
		  if (! purchaseItem.hasErrors() && purchaseItem.save()) {
		    message = "PurchaseItem Saved.."
		    id = purchaseItem.id
		    state = "OK"
		  } else {
		    purchaseItem.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save PurchaseItem"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check purchaseItem exists
			  purchaseItem  = PurchaseItem.get(it)
			  if (purchaseItem) {
			    // delete purchaseItem
			    if(!purchaseItem.delete())
			    	{
				    purchaseItem.errors.allErrors.each {
					log.debug("In jq_purchaseItem_edit: error in deleting purchaseItem:"+ it)
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
		  // first retrieve the purchaseItem by its ID
		  purchaseItem = PurchaseItem.get(params.id)
		  if (purchaseItem) {
		    // set the properties according to passed in parameters
		    purchaseItem.properties = params
			  purchaseItem.updator = springSecurityService.principal.username
		    if (! purchaseItem.hasErrors() && purchaseItem.save()) {
		      message = "PurchaseItem  ${purchaseItem.id} Updated"
		      id = purchaseItem.id
		      state = "OK"
		    } else {
			    purchaseItem.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update PurchaseItem"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }
    
    def jq_purchasedItem_list = {
      def purchaseList
      if(params.purchaseListid)
      	purchaseList=PurchaseList.get(new Long(params.purchaseListid))
      def jsonCells = purchaseList?.purchasedItems?.sort{it.item.name}.collect {
            [cell: [
            	    it.item.name,
            	    it.qty,
            	    it.unit.toString(),
            	    it.rate,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:1,records:purchaseList?.requiredItems?.size(),total:1]
        render jsonData as JSON
        }

	def jq_edit_purchasedItem = {
	      def purchaseItem = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  purchaseItem = new PurchaseItem(params)
		  purchaseItem.updator=purchaseItem.creator=springSecurityService.principal.username
		  purchaseItem.nqty = purchaseItem.qty
		  purchaseItem.nrate = purchaseItem.rate
		  purchaseItem.nunit = purchaseItem.unit
		  purchaseItem.item = Item.get(params.'item.name')
		  if (! purchaseItem.hasErrors() && purchaseItem.save()) {
		    message = "PurchaseItem Saved.."
		    id = purchaseItem.id
		    state = "OK"
		  } else {
		    purchaseItem.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save PurchaseItem"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check purchaseItem exists
			  purchaseItem  = PurchaseItem.get(it)
			  if (purchaseItem) {
			    // delete purchaseItem
			    if(!purchaseItem.delete())
			    	{
				    purchaseItem.errors.allErrors.each {
					log.debug("In jq_purchaseItem_edit: error in deleting purchaseItem:"+ it)
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
		  // first retrieve the purchaseItem by its ID
		  purchaseItem = PurchaseItem.get(params.id)
		  if (purchaseItem) {
		    // set the properties according to passed in parameters
		    purchaseItem.properties = params
			  purchaseItem.updator = springSecurityService.principal.username
		    if (! purchaseItem.hasErrors() && purchaseItem.save()) {
		      message = "PurchaseItem  ${purchaseItem.id} Updated"
		      id = purchaseItem.id
		      state = "OK"
		    } else {
			    purchaseItem.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update PurchaseItem"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }
    

}
