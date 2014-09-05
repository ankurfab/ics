package ics

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class ItemStockController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def helperService 


    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [itemStockInstanceList: ItemStock.list(params), itemStockInstanceTotal: ItemStock.count()]
    }

    def create() {
        [itemStockInstance: new ItemStock(params)]
    }

    def save() {
        def itemStockInstance = new ItemStock(params)
        if (!itemStockInstance.save(flush: true)) {
            render(view: "create", model: [itemStockInstance: itemStockInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'itemStock.label', default: 'ItemStock'), itemStockInstance.id])
        redirect(action: "show", id: itemStockInstance.id)
    }

    def show() {
        def itemStockInstance = ItemStock.get(params.id)
        if (!itemStockInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemStock.label', default: 'ItemStock'), params.id])
            redirect(action: "list")
            return
        }

        [itemStockInstance: itemStockInstance]
    }

    def edit() {
        def itemStockInstance = ItemStock.get(params.id)
        if (!itemStockInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemStock.label', default: 'ItemStock'), params.id])
            redirect(action: "list")
            return
        }

        [itemStockInstance: itemStockInstance]
    }

    def update() {
        def itemStockInstance = ItemStock.get(params.id)
        if (!itemStockInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemStock.label', default: 'ItemStock'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (itemStockInstance.version > version) {
                itemStockInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'itemStock.label', default: 'ItemStock')] as Object[],
                          "Another user has updated this ItemStock while you were editing")
                render(view: "edit", model: [itemStockInstance: itemStockInstance])
                return
            }
        }

        itemStockInstance.properties = params

        if (!itemStockInstance.save(flush: true)) {
            render(view: "edit", model: [itemStockInstance: itemStockInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'itemStock.label', default: 'ItemStock'), itemStockInstance.id])
        redirect(action: "show", id: itemStockInstance.id)
    }

    def delete() {
        def itemStockInstance = ItemStock.get(params.id)
        if (!itemStockInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemStock.label', default: 'ItemStock'), params.id])
            redirect(action: "list")
            return
        }

        try {
            itemStockInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'itemStock.label', default: 'ItemStock'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'itemStock.label', default: 'ItemStock'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

// return JSON list of itemStock
    def jq_stock_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def result = ItemStock.createCriteria().list(max:maxRows, offset:rowOffset) {
            // name case insensitive where the field contains with the search term
            if (params.name)
                ilike('name','%'+params.name + '%')

            // address case insensitive where the field contains with the search term
            if (params.address)
                ilike('address','%'+params.address + '%')

            // phone case insensitive where the field contains with the search term
            if (params.phone)
                ilike('phone','%'+params.phone + '%')

            // email case insensitive where the field contains with the search term
            if (params.email)
                ilike('email','%'+params.email + '%')

            //order(sortIndex, sortOrder)
      }
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [it.item.name,
                    it.item.otherNames,
                    it.item.category,
                    it.item.variety,
                    it.item.brand,
                    it.qty,
                    it.unit.toString(),
                    it.rate
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }
    
	def jq_edit_stock = {
	      def stock
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  id = helperService.addStock(params)
		  if (id>0) {
		    message = "Record Added"
		    state = "OK"
		  } else {
		    message = "Could Not Save"
		  }
		  break;
		case 'del':
		  // check person exists
		  stock = ItemStock.get(params.id)
		  if (stock) {
		    // delete person
		    if(stock.delete())
			    {
			    message = "Deleted!!"
			    state = "OK"
			    }
		    else
		    	message = "Delete failed!!"
		  }
		  break;
		 default :
		  // edit action
		    id = helperService.editStock(params)
		    if (id>0) {
		      message = "Updated!!"
		      state = "OK"
		    } else {
		      message = "Update failed!!"
		    }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }


}
