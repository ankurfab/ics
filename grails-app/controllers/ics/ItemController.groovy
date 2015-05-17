package ics

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import java.util.zip.ZipOutputStream  
import java.util.zip.ZipEntry  
import org.grails.plugins.csv.CSVWriter
import org.apache.commons.lang.StringEscapeUtils.*

class ItemController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService
    def itemService

    def index() {
    	if(params.recreateindex)
    		Item.reindex()
    }

    /*def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [itemInstanceList: Item.list(params), itemInstanceTotal: Item.count()]
    }*/

    def list() {
            println "params in item.list:"+params
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            def itemInstanceList
            withFormat {
                html {
                    itemInstanceList = Item.list(params)
                    [itemInstanceList: itemInstanceList, itemInstanceTotal: Item.count()]
                    
                }
                json {
                itemInstanceList = Item.findAllByNameIlike(params.term+"%")
                
    		def itemList = []
    		itemInstanceList.each {item ->
    		//	 itemList << item.name
    		         itemList << [id:item.id, value:item.name, label:item.name] 
    		}    		   
    		
    		   itemList << [id:0, value:'NEW', label:'NEW', link:'']
                   println itemList
                   render itemList as JSON
                }
            }
        }

	
	
    def create() {
        [itemInstance: new Item(params)]
    }

    def save() {
    
    
        def itemInstance = new Item(params)
        
        //itemInstance.densityFactor = Double.valueOf(params.densityFactor)       

          def f
	  def okcontents = ['image/png', 'image/jpeg', 'image/gif']
	  
	for(int j=1; j<3; j++)
	{
	  f = request.getFile('image'+j)
	  // List of OK mime-types
	  if (! okcontents.contains(f.getContentType())) {
	    continue;
	  }
	  // Save the image and mime type
	  itemInstance.('image'+j+'Data') = f.getBytes()
	  itemInstance.('image'+j+'Type') = f.getContentType()
	}
        
        if (!itemInstance.save(flush: true)) {
            render(view: "create", model: [itemInstance: itemInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'item.label', default: 'Item'), itemInstance.id])
        redirect(action: "show", id: itemInstance.id)
    }

    def show() {
    
    	def itemInstance
    	
    	if(params.ic_id)
    	{
    	  def itemCountInstance= ItemCount.get(params.id)
    	  
    	  itemInstance = itemCountInstance.item
    	}
    	else
    	{
        	itemInstance = Item.get(params.id)
        }
        if (!itemInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'item.label', default: 'Item'), params.id])
            redirect(action: "list")
            return
        }

        [itemInstance: itemInstance]
    }

    def edit() {
        def itemInstance = Item.get(params.id)
        if (!itemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'item.label', default: 'Item'), params.id])
            redirect(action: "list")
            return
        }

        [itemInstance: itemInstance]
    }

    def update() {
        def itemInstance = Item.get(params.id)
        if (!itemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'item.label', default: 'Item'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (itemInstance.version > version) {
                itemInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'item.label', default: 'Item')] as Object[],
                          "Another user has updated this Item while you were editing")
                render(view: "edit", model: [itemInstance: itemInstance])
                return
            }
        }

        itemInstance.properties = params
          def f
	  def okcontents = ['image/png', 'image/jpeg', 'image/gif']
	  
	for(int j=1; j<3; j++)
	{
	  f = request.getFile('image'+j)
	  // List of OK mime-types
	  if (! okcontents.contains(f.getContentType())) {
	    continue;
	  }
	  // Save the image and mime type
	  itemInstance.('image'+j+'Data') = f.getBytes()
	  itemInstance.('image'+j+'Type') = f.getContentType()
	}

        if (!itemInstance.save(flush: true)) {
            render(view: "edit", model: [itemInstance: itemInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'item.label', default: 'Item'), itemInstance.id])
        redirect(action: "show", id: itemInstance.id)
    }

    def delete() {
        def itemInstance = Item.get(params.id)
        if (!itemInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'item.label', default: 'Item'), params.id])
            redirect(action: "list")
            return
        }

        try {
            itemInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'item.label', default: 'Item'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'item.label', default: 'Item'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jq_item_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
	if(params.oper=="excel" )
		{
			maxRows = 100000
			rowOffset = 0
			sortIndex = "name"
			sortOrder = "asc"
		}

	def result = Item.createCriteria().list(max:maxRows, offset:rowOffset) {
		if (params.name)
			ilike('name',params.name + '%')

		if (params.otherNames)
				ilike('otherNames',params.otherNames + '%')

		if (params.category)
			ilike('category',params.category + '%')

		if (params.subcategory)
			ilike('subcategory',params.subcategory + '%')

		if (params.variety)
			ilike('variety',params.variety + '%')

		if (params.brand)
			ilike('brand',params.brand + '%')

		if (params.comments)//service
			ilike('comments','%'+params.comments + '%')

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)
      
	if(params.oper=="excel")
	 {
		response.contentType = 'application/zip'
		def ts = new Date().format('ddMMyyyyHHmmSS')
		def fname = "item_"+ts+".csv"
		new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
			zipOutputStream.putNextEntry(new ZipEntry(fname))
			//header
			zipOutputStream << "Id,Name,OtherNames,Category,SubCategory,Variety,Brand,Description,Rate,Tax,Vendors,Consumers,NumVC,QtyPurchased,QtySold,Stock,Worth" 
			def numv,numc,pq,sq
			result.each{ row ->
				numv = itemService.numVendors(row)
				numc = itemService.numConsumers(row)
				pq = itemService.purchasedQuantity(row)
				sq = itemService.soldQuantity(row)
				zipOutputStream << "\n"
				zipOutputStream <<   row.id +","+(row.name?.replaceAll(',',';')?:'') +","+
					    (row.otherNames?.replaceAll(',',';')?:'') +","+
					    (row.category?.replaceAll(',',';')?:'') +","+
					    (row.subcategory?.replaceAll(',',';')?:'') +","+
					    (row.variety?.replaceAll(',',';')?:'') +","+
					    (row.brand?.replaceAll(',',';')?:'') +","+
					    (row.comments?.replaceAll(',',';')?:'') +","+
					    (row.rate?:'') +","+
					    (row.taxRate?:'') +","+
					    numv +","+
					    numc +","+
					    (numv+numc) +","+
					    pq +","+
					    sq +","+
					    (pq-sq)+","+
					    new Double((pq-sq)*row.rate*(1+((row.taxRate?:0)/100))).round(2)
			}
		}
	 	return
	 }
	else {
	      def jsonCells = result.collect {
		    [cell: [
			    it.name,
			    it.otherNames,
			    it.category,
			    it.subcategory,
			    it.variety,
			    it.brand,
			    it.comments,
			    it.updator,
			    it.lastUpdated?.format('dd-MM-yyyy HH:mm'),
			    it.creator,
			    it.dateCreated?.format('dd-MM-yyyy HH:mm')
			], id: it.id]
		}
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		render jsonData as JSON
        	}
        }

    	def jq_edit_item = {
    	      def item = null
    	      def message = ""
    	      def state = "FAIL"
    	      def id
    
    	      // determine our action
    	      switch (params.oper) {
    		case 'add':
    		  // add instruction sent
    		  params.creator = springSecurityService.principal.username
    		  params.updator = params.creator
    		  item = new Item(params)
    		  if (! item.hasErrors() && item.save()) {
    		    message = "Item ${item.name} Added"
    		    id = item.id
    		    state = "OK"
    		  } else {
    		    item.errors.allErrors.each {
    			println it
    		    }		    
    		    message = "Could Not Save Item"
    		  }
    		  break;
    		case 'del':
    		  // check item exists
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  item = Item.get(it)
			  if (item) {
			    // delete item
			    item.delete()
			    message = "Item  ${item.name} Deleted"
			    state = "OK"
			  }
			}
    		  break;
    		 default :
    		  // edit action
    		  // first retrieve the item by its ID
    		  item = Item.get(params.id)
    		  if (item) {
    		    // set the properties according to passed in parameters
    		    params.updator = springSecurityService.principal.username
    		    item.properties = params
    		    if (! item.hasErrors() && item.save()) {
    		      message = "Item  ${item.name} Updated"
    		      id = item.id
    		      state = "OK"
    		    } else {
    		    item.errors.allErrors.each {
    			println it
    		    }		    
    		      message = "Could Not Update Item"
    		    }
    		  }
    		  break;
     	 }
    
    	      def response = [message:message,state:state,id:id]
    
    	      render response as JSON
    }

    def jq_itemStock_list = {
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = ItemStock.createCriteria().list(max:maxRows, offset:rowOffset) {
		if(params.itemid)
			eq('item',Item.get(params.itemid))

		if (params.'item.name')
				item{ilike('name','%'+params.'item.name' + '%')}

		if (params.qty)
			eq('qty',params.qty)

		if (params.unit)
			ilike('unit','%'+params.unit + '%')

		if (params.rate)
			eq('rate',params.rate)

		if (params.'supplementedBy')
				supplementedBy{
					or
						{
						ilike('legalName','%'+params.supplementedBy + '%')
						ilike('initiatedName','%'+params.supplementedBy + '%')
						}
					}
		if (params.supplementComments)
			ilike('supplementComments','%'+params.supplementComments + '%')

		if(params.sidx=="item.name")
			item{order("name", sortOrder)}
		else	
			{
			def sortIndex = params.sidx ?: 'id'
			order(sortIndex, sortOrder)
			}

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.item.name,
            	    it.qty,
            	    it.unit.toString(),
            	    it.rate,
            	    it.supplementedBy?.toString(),
            	    it.supplementedOn?.format('dd-MM-yyyy HH:mm'),
            	    it.supplementComments,
            	    it.consumedBy?.toString(),
            	    it.consumedOn?.format('dd-MM-yyyy HH:mm'),
            	    it.consumeComments,
            	    it.auditedBy?.toString(),
            	    it.auditedOn?.format('dd-MM-yyyy HH:mm'),
            	    it.auditComments,
            	    it.updator,
            	    it.lastUpdated?.format('dd-MM-yyyy HH:mm'),
            	    it.creator,
            	    it.dateCreated?.format('dd-MM-yyyy HH:mm')
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_itemStock = {
	      def itemStock = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  itemStock = new ItemStock(params)
		  itemStock.updator=itemStock.creator=springSecurityService.principal.username
		  itemStock.nqty = itemStock.qty
		  itemStock.nrate = itemStock.rate
		  itemStock.nunit = itemStock.unit
		  if (! itemStock.hasErrors() && itemStock.save()) {
		    message = "ItemStock Saved.."
		    id = itemStock.id
		    state = "OK"
		  } else {
		    itemStock.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save ItemStock"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check itemStock exists
			  itemStock  = ItemStock.get(it)
			  if (itemStock) {
			    // delete itemStock
			    if(!itemStock.delete())
			    	{
				    itemStock.errors.allErrors.each {
					log.debug("In jq_itemStock_edit: error in deleting itemStock:"+ it)
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
		  // first retrieve the itemStock by its ID
		  itemStock = ItemStock.get(params.id)
		  if (itemStock) {
		    // set the properties according to passed in parameters
		    itemStock.properties = params
			  itemStock.updator = springSecurityService.principal.username
		    if (! itemStock.hasErrors() && itemStock.save()) {
		      message = "ItemStock  ${itemStock.regNum} Updated"
		      id = itemStock.id
		      state = "OK"
		    } else {
			    itemStock.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update ItemStock"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }
    
    def allItemsAsJSON_JQ = {
	def query = params.term
	def c = Item.createCriteria()
	def items = c.list(max:10)
		{
		like("name", query+"%")
		order("name", "asc")
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

    def allItemsAsJSON_Fuzzy_JQ = {
	def query=""
	def tokens = params.term.split()
	tokens.each
		{
			query += it +"~ "
		}
	
	def result = []
	if(query)
		result = Item.search(query,[max: 10,reload:true])

        response.setHeader("Cache-Control", "no-store")

        def results = result?.results.collect {
            [  
               id: it.id,
               value: it.toFullString(),
               label: it.toFullString() ]
        }

        render results as JSON
    }
    
    def pricelist(){
    	[itemList: Item.createCriteria().list{order("category", "asc") order("subcategory", "asc") order("name", "asc")}]
    }
    
    def jq_itemprice_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = Item.createCriteria().list(max:maxRows, offset:rowOffset) {
		if (params.name)
			ilike('name','%'+params.name + '%')

		if (params.otherNames)
				ilike('otherNames','%'+params.otherNames + '%')

		if (params.category)
			ilike('category','%'+params.category + '%')

		if (params.variety)
			ilike('variety','%'+params.variety + '%')

		if (params.brand)
			ilike('brand','%'+params.brand + '%')

		if (params.comments)//service
			ilike('comments','%'+params.comments + '%')

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.name,
            	    it.otherNames,
            	    it.category,
            	    it.variety,
            	    it.brand,
            	    it.comments,
            	    '',
            	    '',
            	    ''
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }
    
    def jq_itemVendor_list = {
      def sortIndex = params.sidx ?: 'invoiceDate'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = InvoiceLineItem.createCriteria().list(max:maxRows, offset:rowOffset) {
		if(params.'item.id')
			item{eq('id',new Long(params.'item.id'))}
		else
			item{eq('id',new Long(-1))}
		invoice{
			eq('type','PURCHASE')
			order(sortIndex, sortOrder)
			}
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.invoice?.preparedBy?.toString(),
            	    it.invoice?.invoiceDate?.format('dd-MM-yyyy'),
            	    it.invoice?.invoiceNumber,
            	    it.qty,
            	    it.unitSize,
            	    it.unit?.toString(),
            	    it.rate,
            	    it.taxRate,
            	    it.description
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }
    
    def jq_itemTaker_list = {
      def sortIndex = params.sidx ?: 'invoiceDate'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = InvoiceLineItem.createCriteria().list(max:maxRows, offset:rowOffset) {
		invoice{eq('type','SALES') order(sortIndex, sortOrder)}
		if(params.'item.id')
			item{eq('id',new Long(params.'item.id'))}
		else
			item{eq('id',new Long(-1))}
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.invoice?.personTo,
            	    it.invoice?.invoiceDate?.format('dd-MM-yyyy'),
            	    it.invoice?.invoiceNumber,
            	    it.qty,
            	    it.unitSize,
            	    it.unit?.toString(),
            	    it.rate,
            	    it.taxRate,
            	    it.description
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }
    
def item_image = {
  def item = Item.get(params.id)
  if (!item || !item.('image'+params.seq+'Data') || !item.('image'+params.seq+'Type')) {
    response.sendError(404)
    return;
  }
  response.setContentType(item.('image'+params.seq+'Type'))
  response.setContentLength(item.('image'+params.seq+'Data').size())
  OutputStream out = response.getOutputStream();
  out.write(item.('image'+params.seq+'Data'));
  out.close();
}

def upload_image = {
  def item = Item.get(params.id)
  // Get the image file from the multi-part request
  def f = request.getFile('image'+params.seq)
  // List of OK mime-types
  def okcontents = ['image/png', 'image/jpeg', 'image/gif']
  if (! okcontents.contains(f.getContentType())) {
    flash.message = "Image must be one of: ${okcontents}"
    render(view:'edit', model:[itemInstance:item])
    return;
  }
  // Save the image and mime type
  item.('image'+params.seq+'Data') = f.getBytes()
  item.('image'+params.seq+'Type') = f.getContentType()
  // Validation works, will check if the image is too big
  if (!item.save()) {
    render(view:'edit', model:[itemInstance:item])
    return;
  }
  flash.message = "Image uploaded."
  if (request.xhr)
  	{
	  /*response.setContentType(individual.itemType)
	  response.setContentLength(individual.item.size())
	  OutputStream out = response.getOutputStream();
	  out.write(individual.item);
	  out.close();*/
	  render "done"
	}
  else
	redirect(action:'show', id: item.id)
  
}

    def addItem() {
      log.debug("Inside addItem with params : "+params)
      def retVal = itemService.addItem(params)
      def response = [message:retVal?.toString(),state:"OK",id:0]
      render response as JSON
    }
    
    def vsUserItems() {
    }

    def vsUserIssue() {
    	log.debug("Inside vsUserIssue with params: "+params)
	def items = []
	def idList = params.idlist.tokenize(',')
	idList.each{
	  items.add(Item.get(it))
	}
    	render(template: "issueform", model: [items: items])
    }
    
    def vsUserSubmitItemIssue() {
    	log.debug("Inside vsUserSubmitItemIssue with params: "+params)
    	itemService.createPurchaseList(params)
    	render "submitted..."
    }

    def vsRequests() {
    }

    def vsReports() {
    }

    def vsUser_jq_item_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = Item.createCriteria().list(max:maxRows, offset:rowOffset) {
		department{eq('name','VaishnavSamvardhan')} //@TODO: hardcoded
		
		if (params.name)
			ilike('name',params.name)

		if (params.otherNames)
				ilike('otherNames',params.otherNames)

		if (params.category)
			ilike('category',params.category)

		if (params.subcategory)
			ilike('subcategory',params.subcategory)

		if (params.variety)
			ilike('variety',params.variety)

		if (params.brand)
			ilike('brand',params.brand)

		if (params.comments)//service
			ilike('comments','%'+params.comments + '%')

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.name,
            	    it.otherNames,
            	    it.category,
            	    it.subcategory,
            	    it.variety,
            	    it.brand,
            	    it.comments,
            	    it.rate?:''
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }


    def upload() {
	    def f = request.getFile('myFile')
	    if (f.empty) {
		flash.message = 'file cannot be empty'
	    }
	    else
	    {
	    def item
	    def vsDepartment = null
	    if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VS_ADMIN'))
	    	vsDepartment = Department.findByName('VaishnavSamvardhan')
	    f.inputStream.toCsvReader(['skipLines':'1']).eachLine{ tokens ->
	    //'Name','OtherNames','Category','SubCategory','Variety','Brand','Description','Rate'
	    	try{
	    	item = new Item()
	    	item.name = tokens[0]
	    	item.otherNames = tokens[1]
	    	item.category = tokens[2]
	    	item.subcategory = tokens[3]
	    	item.variety = tokens[4]
	    	item.brand = tokens[5]
	    	item.comments = tokens[6]
	    	item.rate = new BigDecimal(tokens[7])
	    	item.department = vsDepartment
	    	item.updator = item.creator = springSecurityService.principal.username
	    	if(!item.save())
				item.errors.allErrors.each {
					println "Error in bulk saving item :"+it
				}
		else
			log.debug(item.toString()+" saved!")
		}
		catch(Exception e) {
			log.debug("Exception occurred in parsing tokens for upload items : "+e)
		}
	    }
	    }
	    
	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VS_ADMIN'))
	    	redirect (action: "vsUserItems")
	else
		redirect (action: "list")
    }

	def vsUser_jq_edititem_list = {
	      log.debug('In vsUser_jq_edititem_list:'+params)
	      def item = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add item sent
		  item = new Item(params)
		  item.updator=item.creator=springSecurityService.principal.username
		  item.department = Department.findByName('VaishnavSamvardhan')	//@TODO: hardcoded
		  if (! item.hasErrors() && item.save()) {
		    message = "Item Saved.."
		    id = item.id
		    state = "OK"
		  } else {
		    item.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save Item"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check item exists
			  item  = Item.get(it)
			  if (item) {
			    // delete item
			    if(!item.delete())
			    	{
				    item.errors.allErrors.each {
					log.debug("In jq_item_edit: error in deleting item:"+ it)
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
		  // first retrieve the item by its ID
		  item = Item.get(params.id)
		  if (item) {
		    // set the properties according to passed in parameters
		    item.properties = params
			  item.updator = springSecurityService.principal.username
		    if (! item.hasErrors() && item.save()) {
		      message = "Item  ${item.name} Updated"
		      id = item.id
		      state = "OK"
		    } else {
			    item.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Item"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

	def updateRate() {
		def result = itemService.updateRate(params)
		render result
	}
	
	def merge() {
		def result = itemService.merge(params)
		render result
	}
	
}
