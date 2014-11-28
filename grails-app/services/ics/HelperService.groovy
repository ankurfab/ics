package ics
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import java.util.zip.Adler32

class HelperService {

    def springSecurityService

    def serviceMethod() {



    }

    def test(Centre centreInstance) {

    	centreInstance.departments?.each{
    		if(it.name == 'Kitchen')
    			println centreInstance.toString() + " has a Kitchen!!"
    		}
    }

    def getIngredients(MenuItem menuItemInstance) {

        int i=0

    	println "\n"+"Instructions before cooking:"
    	print "      "+menuItemInstance.recipe.preprocInstructions + "\n"

    	println "\n"+"Ingredients:"

    	menuItemInstance.recipe.ingredients?.each{

    		println "\n" + menuItemInstance.recipe.ingredients.item[i]
    		print menuItemInstance.recipe.ingredients.qty[i] +"  "+menuItemInstance.recipe.ingredients.unit[i]

    		i++
    	}
    	println "\n"+"Cooking instructions:"
    	println "      "+ menuItemInstance.recipe.cookingInstructions + "\n"


    	/*
    	recipe.preporc
    	for each
    		Qty=itemCountVar.qty/recipe.qty X Yqty .

    		Println itemcountVar.item+' '+Qty

    	recipe.cookingInstructions
    	*/


    }

    def editStock(Map params) {
    	//first get the stock 
    	def stock = ItemStock.get(params.id)
    	if(!stock)
    		return -1
    	//now update the values
    	//to do later
    	return stock.id
    }
    
    def addStock(Map params) {
    	println "Inside addStock with params: " + params
    	//create Item first
    	def item = new Item(params)
    	item.creator = "system" //todo integrate with SpringSecurity
    	item.updator = item.creator
    	if(!item.save())
    		{
			prinltn "addStock(): Errors in saving item!!"
			item.errors.allErrors.each {
				println it
				}
			return -1
    		}
    	//now create ItemStock
    	def is = new ItemStock()
    	is.item = item
    	is.qty = new BigDecimal(params.qty)
    	is.rate = new BigDecimal(params.rate)
    	is.unit = params.unit
    	is.nqty = new BigDecimal(params.qty)
    	is.nrate = new BigDecimal(params.rate)
    	is.nunit = params.unit
    	is.creator = "system" //todo integrate with SpringSecurity
    	is.updator = item.creator
    	if(!is.save())
    		{
			println "addStock(): Errors in saving item stock!!"
			is.errors.allErrors.each {
				println it
				}
			return -1
    		}
    	return is.id
    }
    
    def createMenu(Map m)
    {
    	def menu = new Menu()
    	
    	def mc = new MenuChart()
    	mc.chartName=m.eventdata.EventName
    	mc.menu = []
    	mc.creator="system" //todo integrate with SpringSecurity
    	mc.updator=mc.creator
    	if(!mc.save())
    		{
			println "createMenu(): Errors in saving MenuChart!!"
			mc.errors.allErrors.each {
				println it
				}
			return menu
    		}
    	menu.menuChart = mc
    	menu.meal = Meal.BREAKFAST
    	menu.mealDate = new Date()
    	menu.totalCost = new BigDecimal(0)
    	menu.mealCost = new BigDecimal(0)    	
    	menu.creator="system" //todo integrate with SpringSecurity
    	menu.updator=menu.creator
    	if(!menu.save())
    		{
			println "createMenu(): Errors in saving Menu!!"
			menu.errors.allErrors.each {
				println it
				}
			return menu
    		}
    	return menu
    }

    def findColumnIndex(String[] tokens,String val){
        
        def index = 0
        for(token in tokens){
            if(token== val){
                return index
            }
            else index++
        }
        return -1
     }

     def getDepartmentForRole(String rolename, Long individualid){
         def loginInd = Individual.get(individualid)
        def donationExecRole = Role.findByAuthority(rolename)
        def dep = IndividualRole.findWhere('individual.id':individualid,role:donationExecRole,status:'VALID')?.department       

        return dep
     }

      def getSchemesForRole(String rolename, Long individualid){
         def loginInd = Individual.get(individualid)
        def donationExecRole = Role.findByAuthority(rolename)

        println "############ donation role "+donationExecRole
        def dep = IndividualRole.findWhere('individual.id':individualid,role:donationExecRole,status:'VALID')?.department       
        def schemes
         if(dep)
            schemes = Scheme.findAllByDepartment(dep,[sort:'name'])
        log.debug("Got schemes.."+schemes)
        return schemes
     }
    	def getCenterForIndividualRole(String rolename, Long individualid){
         def loginInd = Individual.get(individualid)
        def donationExecRole = Role.findByAuthority(rolename)
        def centre = IndividualRole.findWhere('individual.id':individualid,role:donationExecRole,status:'VALID')?.centre       
       
        return centre
     }

     def getDonationUserRole(){
         def role
         if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') ){
            role = 'ROLE_DONATION_EXECUTIVE'
         }
         else  if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_COORDINATOR') ){
            role = 'ROLE_DONATION_COORDINATOR'
         }
         else  if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_HOD') ){
            role = 'ROLE_DONATION_HOD'
         }
    }
    
    def getFamilyMembers(Long id) {
    	def rg = RelationshipGroup.findByRefid(id)
    	if(rg)
    		return Relationship.findAllByRelationshipGroup(rg)?.collect{it.individual1.id}
    	else
    		return []
    		
    }

    def isDevotee(Long donorId){
	def rshipList = Relationship.createCriteria().list() {
			eq("status",'ACTIVE')
			individual1{eq('id',donorId)}
			relation{or{eq('name','Disciple of') eq('name','Councellee of')}}
		}
	if(rshipList?.size()>0)
		return true
	else
		return false
    }

    def getIndividualAddress(Individual individual,String category){
        def addresses = individual.address
        for(address in addresses){
            if(address.category== category) 
              return getprintedAddress(address)
        }
    }

    def getprintedAddress(Address address){
        def str = address.addressLine1+" "+(address.addressLine2?:'')+" "+(address.addressLine3?:'')+" "+(address.city?:'')+", "+(address.state?:'')+", "+(address.country?:'')+". "+(address.pincode?:'')
         return str
    }

    def getIndividualVOICEContact(Individual individual,String category){
        def contacts= individual.voiceContact
        for(contact in contacts){
            if(contact.category == category){
                return contact.number
            }
        }
    }

    def getIndividualEmailContact(Individual individual,String category){
        def emails= individual.emailContact
        for(email in emails){
            if(email.category== category){
                return email.emailAddress
            }
        }
    }

def createChecksum(str)
	{
			Adler32  adl = new Adler32();
			adl.update(str.getBytes());
			return String.valueOf(adl.getValue());
	}
	
def verifyChecksum(str,cksum)
	{
		Adler32  adl = new Adler32();                 
		adl.update(str.getBytes());
		long adler = adl.getValue();

		String newChecksum = String.valueOf(adl.getValue());
		return (newChecksum.equals(cksum)) ? true : false;
	}

    //generic method to create an address..this needs to be
    def createAddress(Map params) {
        log.debug("creating address:"+params)
        def user
        try{
            user = springSecurityService.principal.username
        }
        catch(all) {
            user="mbuser"
        }
        def city
        city = City.findByName(params.'cityname')
        if(params.'cityname' && !city)
        {
            city = new City(name:params.'cityname',creator:user,updator:user)
            city.save()
        }
        params.city=city
        def state
            state = State.findByName(params.'statename')
        if(params.'statename' && !state)
        {
            state = new State(name:params.'statename',creator:user,updator:user)
            state.save()
        }
        params.state=state
        def country
            country = Country.findByName(params.'countryname')
        if(params.'countryname' && !country)
        {
            country = new Country(name:'countryname'.donorCountry,creator:user,updator:user)
            country.save()
        }
        params.country=country
        def address = new Address(params)

        address.creator = address.updator = user

        if(!address.save())
            address.errors.each {
                println it;
            }
        return address
    }

    def updateAddress(Map params) {
        def user
        try{
            user = springSecurityService.principal.username
        }
        catch(all) {
            user="mbuser"
        }
        def city
        city = City.findByName(params.'cityname')
        if(params.'cityname' && !city)
        {
            city = new City(name:params.'cityname',creator:user,updator:user)
            city.save()
        }
        params.city=city
        def state
        state = State.findByName(params.'statename')
        if(params.'statename' && !state)
        {
            state = new State(name:params.'statename',creator:user,updator:user)
            state.save()
        }
        params.state=state
        def country
        country = Country.findByName(params.'countryname')
        if(params.'countryname' && !country)
        {
            country = new Country(name:'countryname'.donorCountry,creator:user,updator:user)
            country.save()
        }
        params.country=country
        def address = Address.get(params.id)
            address.properties=params
        address.updator = user

        if(!address.save())
            address.errors.each {
                println it;
            }
        return address
    }


}
