package ics
import org.codehaus.groovy.grails.plugins.springsecurity.*
import org.springframework.web.context.request.RequestContextHolder
import groovy.sql.Sql;

class ItemService {

    def springSecurityService
    def dataSource
    
    def serviceMethod() {
    }

    def addItem(Map params) {	
    	def item = new Item(params)
    	item.updator=item.creator=springSecurityService.principal.username    
    	if(!item.save())
    		{
    		item.errors.each {println it}
    		return null
    		}
    	else
    		return item	    	
    }
    
    //normalize the provided quantity to the normalized unit as per Item
    def normalize(Item item, BigDecimal quantity, BigDecimal unitSize, Unit unit) {
    	//@TODO : improve the algo, could do better
    	Map normVal
    	def nqty
    	unitSize = unitSize?:1
    	def unitFactor = unitSize/(item.nunitSize?:1)
    	switch(unit) {
    		case 'ML':
			switch(item.nunit) {
				case 'ML':
					normVal = [quantity:quantity*unitFactor,unitSize: item.nunitSize, unit:item.nunit]
					break
				case 'L':
					normVal = [quantity:(quantity/1000)*unitFactor,unitSize: item.nunitSize, unit:item.nunit]
					break
				case 'GMS':
					normVal = [quantity:quantity*unitFactor*(item.densityFactor?:1),unitSize: item.nunitSize, unit:item.nunit]
					break
				case 'KG':
					normVal = [quantity:(quantity/1000)*unitFactor*(item.densityFactor?:1),unitSize: item.nunitSize, unit:item.nunit]
					break
			}
			break
    		case 'L':
			switch(item.nunit) {
				case 'ML':
					normVal = [quantity:quantity*1000*unitFactor,unitSize: item.nunitSize, unit:item.nunit]
					break
				case 'L':
					normVal = [quantity:quantity*unitFactor,unitSize: item.nunitSize, unit:item.nunit]
					break
				case 'GMS':
					normVal = [quantity:(quantity/1000)*unitFactor*(item.densityFactor?:1),unitSize: item.nunitSize, unit:item.nunit]
					break
				case 'KG':
					normVal = [quantity:quantity*unitFactor*(item.densityFactor?:1),unitSize: item.nunitSize, unit:item.nunit]
					break
			}
			break
    		case 'GMS':
			switch(item.nunit) {
				case 'KG':
					normVal = [quantity:(quantity/1000)*unitFactor,unitSize: item.nunitSize, unit:item.nunit]
					break
				case 'GMS':
					normVal = [quantity:quantity*unitFactor,unitSize: item.nunitSize, unit:item.nunit]
					break
				case 'L':
					normVal = [quantity:(quantity/1000)*unitFactor*(item.densityFactor?:1),unitSize: item.nunitSize, unit:item.nunit]
					break
				case 'ML':
					normVal = [quantity:quantity*unitFactor*(item.densityFactor?:1),unitSize: item.nunitSize, unit:item.nunit]
					break
			}
			break
    		case 'KG':
			switch(item.nunit) {
				case 'GMS':
					normVal = [quantity:(quantity/1000)*unitFactor,unitSize: item.nunitSize, unit:item.nunit]
					break
				case 'KG':
					normVal = [quantity:quantity*unitFactor,unitSize: item.nunitSize, unit:item.nunit]
					break
				case 'ML':
					normVal = [quantity:(quantity/1000)*unitFactor*(item.densityFactor?:1),unitSize: item.nunitSize, unit:item.nunit]
					break
				case 'L':
					normVal = [quantity:quantity*unitFactor*(item.densityFactor?:1),unitSize: item.nunitSize, unit:item.nunit]
					break
			}
			break
    	}
    return normVal
    }
    
    
    def createPurchaseList(Map params) {
    	def purchaseList = new PurchaseList()
    	purchaseList.purchaseListDate = new Date()
    	purchaseList.preparedBy = Individual.findByLoginid(springSecurityService.principal.username)
    	purchaseList.name = "VS Request by "+purchaseList.preparedBy?.toString()+" on "+purchaseList.purchaseListDate
    	purchaseList.status = "SUBMITTED"	//@TODO: need to make it consistent with kitchen
    	purchaseList.department = Department.findByName('VaishnavSamvardhan')	//@TODO: hardcoding
    	purchaseList.requiredItems = []
    	purchaseList.purchasedItems = []
    	purchaseList.creator = purchaseList.updator = springSecurityService.principal.username
	def idList = params.idlist.tokenize(',')
	idList.each{
	  purchaseList.requiredItems.add(new PurchaseItem(item:Item.get(it),qty:params.('qtyitem'+it),unit:params.('unititem'+it)))
	  purchaseList.purchasedItems.add(new PurchaseItem(item:Item.get(it),qty:params.('qtyitem'+it),unit:params.('unititem'+it)))
	}
	if(!purchaseList.save(flush:true))
	    purchaseList.errors.allErrors.each {
		log.debug("In createPurchaseList: error in saving purchaseList:"+ it)
		}
    }
    
    def updateRate(Map params) {
    	def count = 0
    	def ilis
    	Item.list().each{item->
    		ilis = InvoiceLineItem.createCriteria().list(max:1){
    			eq('item',item)
    			invoice{eq('type','PURCHASE')}
    			order("id", "desc")
    			}
    		if(ilis?.size()>0) {
    			//@TODO:normalization of unit
    			item.rate = ilis[0].rate?:0
    			item.taxRate = ilis[0].taxRate?:0
    			if(!item.save())
    				item.errors.allErrors.each {log.debug("exception in updateRate:"+it)}
    		}
    	}
    	return count
    }
    
    def export() {
    }
    
    def numVendors(Item item) {
	def c = InvoiceLineItem.createCriteria()
	def num = c.get {
		    eq('item',item)
		    invoice{
			    eq('type','PURCHASE')
			    projections {
				countDistinct "preparedBy"
			    }
		    }
		}
	return num?:0
    }
        
    def numConsumers(Item item) {
	def c = InvoiceLineItem.createCriteria()
	def num = c.get {
		    eq('item',item)
		    invoice{
			    eq('type','SALES')
			    projections {
				countDistinct "personTo"
			    }
		    }
		}
	return num?:0
    }
    
    def purchasedQuantity(Item item) {
	def c = InvoiceLineItem.createCriteria()
	def num = c.get {
		    eq('item',item)
		    invoice{
			    eq('type','PURCHASE')
		    }
		    projections {
			sum "qty"
		    }
		}
	return num?:0
    }
        
    def soldQuantity(Item item) {
	def c = InvoiceLineItem.createCriteria()
	def num = c.get {
		    eq('item',item)
		    invoice{
			    eq('type','SALES')
		    }
		    projections {
			sum "qty"
		    }
		}
	return num?:0
    }
    
    //eg usage
    //http://localhost:8080/ics/item/merge?idlist=555,558
    def merge(Map params) {
    	def items = []
    	def item
    	params.idlist.tokenize(',').each{
    		try{
    			log.debug("searching item:"+it)
    			item = Item.get(it)
    			if(item)
    				items.add(item)
    		}
    		catch(Exception e){
    			log.debug(e)
    		}
    	}
    	log.debug("items:"+items)
    	if(items.size()<=1)
    		return 'Not suffiecient records'
    		
    	//first one is to be retained and all others updated/deleted
    	def result = ""
    	for(int i=1;i<items.size();i++) {
    		result = updateInvoiceLineItems(items[i],items[0])
    		if(!items[1].delete())
    			items[1].errors.allErrors.each {
				log.debug("In merge: error in deleting item:"+ it)
			}
    	}
    	return result
    }
    
    def updateInvoiceLineItems(Item wrongItem, Item correctItem) {
	def sql = new Sql(dataSource);

	def query = "update invoice_line_item set item_id="+correctItem.id +" where item_id="+wrongItem.id

	def queryResult = sql.executeUpdate(query)
	
	sql.close()

	log.debug(queryResult+":"+query)
	
	return queryResult
    	
    }
}
