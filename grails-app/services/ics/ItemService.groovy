package ics
import org.codehaus.groovy.grails.plugins.springsecurity.*
import org.springframework.web.context.request.RequestContextHolder

class ItemService {

    def springSecurityService
    
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
    
        
}
