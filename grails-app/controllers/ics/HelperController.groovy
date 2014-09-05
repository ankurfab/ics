package ics

import grails.converters.JSON
import com.krishna.*
import groovy.sql.Sql;
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.springframework.util.ClassUtils
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import java.util.zip.ZipOutputStream  
import java.util.zip.ZipEntry  
import org.grails.plugins.csv.CSVWriter
import org.apache.commons.lang.StringEscapeUtils.*

class HelperController {
//def searchableService
def springSecurityService
def springSecurityUtils
def housekeepingService
def reportService

def dataService
def dataSource
// Export service provided by Export plugin	
def exportService
def grailsApplication  //inject GrailsApplication

def helperService 
def individualService
def donationService
    
    def index = { 
	def birthdayList = [], mAnniversaryList = []
	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
	{
		
		def login = springSecurityService.principal.username
		def individual = Individual.findByLoginid(login)
	
		def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
		def patronCareHead, patronCareSevaks = []
		def individualInstanceList = [], individualRels = []
		def cultivatedByRelation = Relation.findByName("Cultivated by")
		
		for(int i=0; i<pcRole.size(); i++)
		{
			if(pcRole[i].toString() == "PatronCare")
			{
				individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
				for(int j=0; j<individualRels.size(); j++)
				{
					individualInstanceList[j] = individualRels[j].individual1
				}

				def sevakOfRelation = Relation.findByName("Sevak of")
				patronCareSevaks = Relationship.findAllWhere(individual2:individual, relation:sevakOfRelation, status:"ACTIVE").individual1		
				for(int j=0; j<patronCareSevaks.size(); j++)
				{
					individualRels = Relationship.findAllWhere(individual2:patronCareSevaks[j], relation:cultivatedByRelation, status:"ACTIVE")
					for(int k=0; k<individualRels.size(); k++)
					{
						individualInstanceList.add(individualRels[k].individual1)
					}
				}
			}
			if(pcRole[i].toString() == "PatronCareSevak")
			{
				individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
				for(int j=0; j<individualRels.size(); j++)
				{
					individualInstanceList[j] = individualRels[j].individual1
				}
			}			
		}
		
		individualInstanceList = individualInstanceList.unique()
		
		  def now = new Date()
		  def tomorrowsDate = now.next()

		  def j = 0, birthMonthOfDonor, birthDateOfDonor
		  for(int i=0;i<individualInstanceList.size();i++)
		  {
			  if(individualInstanceList[i]?.dob)
			  {
				  birthMonthOfDonor = ((individualInstanceList[i].dob).month).toInteger()
				  birthDateOfDonor = (individualInstanceList[i].dob).getDate()
				if ((birthMonthOfDonor == tomorrowsDate.month && birthDateOfDonor == tomorrowsDate.getDate()))
				{
					birthdayList[j] = individualInstanceList[i]
					j++
				}
			  }
		  }
		  
		  birthdayList = birthdayList.unique()
		  birthdayList = birthdayList.sort{it?.dob}
		  
		  def mAnnMonthOfDonor, mAnnDateOfDonor
		  for(int i=0;i<individualInstanceList.size();i++)
		  {
			  if(individualInstanceList[i]?.marriageAnniversary)
			  {
				  mAnnMonthOfDonor = ((individualInstanceList[i].marriageAnniversary).month).toInteger()
				  mAnnDateOfDonor = (individualInstanceList[i].marriageAnniversary).getDate()
				if ((mAnnMonthOfDonor == tomorrowsDate.month && mAnnDateOfDonor == tomorrowsDate.getDate()))
				{
					mAnniversaryList[j] = individualInstanceList[i]
					j++
				}
			  }
		  }
		  mAnniversaryList = mAnniversaryList.unique()
		  mAnniversaryList = mAnniversaryList.sort{it?.marriageAnniversary}
		  
	
	def displayString = ""
	if(birthdayList.size()>0)
	{
	     displayString = "<b>Devotees celebrating their birthday tomorrow:</b>\n<table border='1' cellspacing='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody>"
	     for(int i=0; i<birthdayList.size(); i++)
	     {
		displayString = displayString+"<tr><td><b>"+birthdayList[i]?.legalName+"</b></td><td><b>"+birthdayList[i]?.initiatedName?birthdayList[i]?.initiatedName:'-'+"</b></td><td><b>"+birthdayList[i]?.dob?.format('dd-MM-yyyy')+"</b></td><td><b>"+birthdayList[i]?.address+"</b></td><td><b>"+birthdayList[i]?.voiceContact+"</b></td><td><b>"+birthdayList[i]?.emailContact+"</b></td></tr>"
	     }
	     displayString = displayString+"</tbody></table>"
	}
	if(mAnniversaryList.size()>0)
	{
	     displayString = "<b>Devotees celebrating their marriage anniversary tomorrow:</b>\n<table border='1' cellspacing='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody>"
	     for(int i=0; i<mAnniversaryList.size(); i++)
	     {
		displayString = displayString+"<tr><td><b>"+mAnniversaryList[i]?.legalName+"</b></td><td><b>"+mAnniversaryList[i]?.initiatedName+"</b></td><td><b>"+mAnniversaryList[i]?.marriageAnniversary?.format('dd-MM-yyyy')+"</b></td><td><b>"+mAnniversaryList[i]?.address+"</b></td><td><b>"+mAnniversaryList[i]?.voiceContact+"</b></td><td><b>"+mAnniversaryList[i]?.emailContact+"</b></td></tr>"
	     }
	     displayString = displayString+"</tbody></table>"
	}
	
	//displayString = "Devotees celebrating their birthday today or tomorrow:<table border='1' cellspacing='0' cellpadding='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody><tr><td><b>abp2</b></td><td><b>null</b></td><td><b>27-07-2012</b></td><td><b>[]</b></td><td><b>[]</b></td><td><b>[]</b></td></tr></tbody></table>"
	if (displayString == "")
		displayString = "No Birthdays/Marriage Anniversaries tomorrow."
	return [birthdayList: birthdayList, mAnniversaryList:mAnniversaryList, displayString:displayString]
	}
    }
    
    def changePassword = {
    	log.debug("Inside changePassword with params:"+params)
        def IcsUserInstance
    	def principal = springSecurityService.principal
	String username = principal.username
    	IcsUserInstance = IcsUser.findByUsername(username)
    	
	String password = params.opassword
	String newPassword = params.password
	String newPassword2 = params.rpassword
	if (!password || !newPassword || !newPassword2 || newPassword != newPassword2) {
		//response.status = 500
		render([success: false, message: 'Please enter your current password and a valid new password'] as JSON)
		return
		}
	if (!springSecurityService.passwordEncoder.isPasswordValid(IcsUserInstance.password, password, null/*salt*/)) {
		//response.status = 500
		render([success: false, message: 'Current password is incorrect'] as JSON)
		return
		}
	if (springSecurityService.passwordEncoder.isPasswordValid(IcsUserInstance.password, newPassword, null/*salt*/)) {
		//response.status = 500
		render([success: false, message: 'Please choose a different password from your current one'] as JSON)
		return
		}
    	
    	//IcsUserInstance.setPassword(springSecurityService.encodePassword(params.password))
    	IcsUserInstance.setPassword(params.password)
    	IcsUserInstance.setPasswordExpired(false)
	render([success: true, message: 'Password changed successfully!'] as JSON)
	}

    def resetPassword = {
	if(!params.username)
		{
		response.status = 500
		render('No username provided')
		return
		}
        
        def IcsUserInstance = IcsUser.findByUsername(params.username)
    	//IcsUserInstance.setPassword(springSecurityService.encodePassword('harekrishna'))
    	if(IcsUserInstance)
    	{
		IcsUserInstance.setPassword('harekrishna')
		render([success: true, data: 'krishna', errors:''] as JSON)
	}
	else
		render([success: false, data: 'krishna', errors:'Username '+params.username+' not found!'] as JSON)
	}
	
	def ajaxListIcsUsers = {
	    	def icsRole = IcsRole.get(params.id)
	    	def icsUsericsRoles = IcsUserIcsRole.findAllByIcsRole(icsRole)
	    	def icsUsers = []
	    	icsUsericsRoles.each{icsUsers.push(it.icsUser)}
	    	icsUsers.sort{it.username}
	        render icsUsers as JSON
	        }

	def ajaxListIndividuals = {
	    	def role = Role.get(params.id)
	    	def individualRoles = IndividualRole.findAllByRole(role)
	    	def individuals = []
	    	individualRoles.each{individuals.push(it.individual)}
	    	individuals.sort{it.initiatedName}
	        render individuals as JSON
	        }
	        
	def dashboardInput = {
		def i, yearsMonthwise = []
		def sql = new Sql(dataSource)
		def yearsQry = "select distinct YEAR(donation_date) year from donation order by YEAR(donation_date)"
		def yearsResult = sql.rows(yearsQry)
		for(i=0; i<yearsResult.size(); i++)
		{
			if(yearsResult.year[i])
				yearsMonthwise.add(yearsResult.year[i])
		}
		
		sql.close()
		
		return [yearsMonthwise: yearsMonthwise]
	}
	
	    def dashboard = {

		def yearsMonthwise = params.yearsMonthwise
		def sql = new Sql(dataSource)
		def i,j
		
		//bar yearwiseCollectionAmount
		def yearwiseCollectionQuery = "select sum(amount) amt, YEAR(donation_date) year from donation where YEAR(donation_date) is not null group by YEAR(donation_date)"
		def yearwiseCollection = sql.rows(yearwiseCollectionQuery)
		def years = []
		def collectionAmount = []
		def yearwiseCollectionAmount = []
		for(i=0; i<yearwiseCollection.size(); i++)
		{
			if(yearwiseCollection.year[i])
			{
				years.add(yearwiseCollection.year[i])
				collectionAmount.add(yearwiseCollection.amt[i])
			}
		}
		def yearTicks = []
		i = years[0]
		j = 0
		
		if(years.size() > 0)
		{
			while(i <= years[years.size()-1])
			{
				yearTicks.add(i)
				if(years[j] == i)
				{
					yearwiseCollectionAmount.add(collectionAmount[j])
					j++
				}
				else
				{
					yearwiseCollectionAmount.add(0)
				}
				i++
			}
		}
		//yearTicks.add(i)
		//yearwiseCollectionAmount.add(0)

////////////////////////
		//bar yearwiseCollectionAmount for patroncare
		def pc_yearwiseCollectionQuery = "select sum(d.amount) amt, YEAR(d.donation_date) year from donation d, individual i, individual_role ir, role r where YEAR(d.donation_date) is not null and i.id=d.collected_by_id and ir.individual_id=i.id and ir.role_id=r.id and r.name='PatronCare' group by YEAR(d.donation_date)"
		def pc_yearwiseCollection = sql.rows(pc_yearwiseCollectionQuery)
		def pc_years = []
		def pc_collectionAmount = []
		def pc_yearwiseCollectionAmount = []
		for(i=0; i<pc_yearwiseCollection.size(); i++)
		{
			if(pc_yearwiseCollection.year[i])
			{
				pc_years.add(pc_yearwiseCollection.year[i])
				pc_collectionAmount.add(pc_yearwiseCollection.amt[i])
			}
		}
		def pc_yearTicks = []
		i = pc_years[0]
		j = 0
		
		if(pc_years.size() > 0)
		{
			while(i <= pc_years[pc_years.size()-1])
			{
				pc_yearTicks.add(i)
				if(pc_years[j] == i)
				{
					pc_yearwiseCollectionAmount.add(pc_collectionAmount[j])
					j++
				}
				else
				{
					pc_yearwiseCollectionAmount.add(0)
				}
				i++
			}
		}
////////////////////////
		// bar Monthwise Collection by year
		def yearsMonthwiseQry = "select sum(amount) amt, MONTH(donation_date) from donation where YEAR(donation_date)='" + yearsMonthwise + "' group by MONTH(donation_date)"
		def monthWise = sql.rows(yearsMonthwiseQry)
		def monthWiseCollection = []
		for(i=0; i<monthWise.size(); i++)
			monthWiseCollection.add(monthWise[i].amt)
			
		
/////////////
		// bar Monthwise Collection by year of patroncare devotees
		def pc_yearsMonthwiseQry = "select sum(d.amount) amt, MONTH(d.donation_date) from donation d, individual i, individual_role ir, role r where i.id=d.collected_by_id and ir.individual_id=i.id and ir.role_id=r.id and r.name='PatronCare' and YEAR(d.donation_date)='" + yearsMonthwise + "' group by MONTH(d.donation_date)"
		def pc_monthWise = sql.rows(pc_yearsMonthwiseQry)
		def pc_monthWiseCollection = []
		for(i=0; i<pc_monthWise.size(); i++)
			pc_monthWiseCollection.add(pc_monthWise[i].amt)
			

/////////////
		//meterguage amt
	    def query = "select sum(amount) amt from donation"
	    def row = sql.firstRow(query)
	    
		//pie totalsByScheme
		def totalQry = "select s.name schm ,sum(d.amount) amount from donation d, scheme s where d.scheme_id=s.id group by s.name"
		
		def totalsByScheme = sql.rows(totalQry)
		
		
		def schm=[], amtByScheme=[]
		for (i=0; i<totalsByScheme.size(); i++)
		{
			schm.add("'"+totalsByScheme.schm[i]+"'");
			amtByScheme.add(totalsByScheme.amount[i]);
		}		
		

////////////		
		
		
		//return [schm: schm, amtByScheme:amtByScheme, amt: row.amt, yearwiseCollectionAmount:yearwiseCollectionAmount, yearTicks:yearTicks, pc_yearwiseCollectionAmount:pc_yearwiseCollectionAmount, pc_yearTicks:pc_yearTicks, yearsMonthwise:yearsMonthwise, monthWiseCollection:monthWiseCollection, pc_monthWiseCollection:pc_monthWiseCollection, location_ids:location_ids, location_names:location_names, collection_location:collection_location, temp:temp]
		return [schm: schm, amtByScheme:amtByScheme, amt: row.amt, yearwiseCollectionAmount:yearwiseCollectionAmount, yearTicks:yearTicks, pc_yearwiseCollectionAmount:pc_yearwiseCollectionAmount, pc_yearTicks:pc_yearTicks, yearsMonthwise:yearsMonthwise, monthWiseCollection:monthWiseCollection, pc_monthWiseCollection:pc_monthWiseCollection]
	    }

	def patronCareDashboardInput = {    
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
		{
			def i, j, yearsMonthwise = []
			def individualInstanceList = [], individualRels = []

			def login = springSecurityService.principal.username
			def individual = Individual.findByLoginid(login)

			def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
			def patronCareSevaks = [], patronCareSevaksIds = []
			def cultivatedByRelation = Relation.findByName("Cultivated by")
			
			individualRels = Relationship.findAllWhere(individual2:Individual.get(params."patronCareSevaks.id"), relation:cultivatedByRelation, status:"ACTIVE")
			for(j=0; j<individualRels.size(); j++)
			{
				individualInstanceList[j] = individualRels[j].individual1
			}

			individualInstanceList = individualInstanceList.unique()
			def individualInstanceIdsList = individualInstanceList.id
			def individualInstanceIdsListStr = individualInstanceIdsList.toString().replace("[","")
			individualInstanceIdsListStr = individualInstanceIdsListStr.toString().replace("]","")
			
			for(i=0; i<pcRole.size(); i++)
			{
				if(pcRole[i].toString() == "PatronCare")
				{
					def sevakOfRelation = Relation.findByName("Sevak of")
					patronCareSevaks = Relationship.findAllWhere(individual2:individual, relation:sevakOfRelation, status:"ACTIVE").individual1		
					patronCareSevaksIds = patronCareSevaks.id
				}
			}

			patronCareSevaks.add(individual)
			def sql = new Sql(dataSource)
			def yearsQry = "select distinct YEAR(donation_date) year from donation order by YEAR(donation_date)"
			def yearsResult = sql.rows(yearsQry)
			for(i=0; i<yearsResult.size(); i++)
			{
				if(yearsResult.year[i])
					yearsMonthwise.add(yearsResult.year[i])
			}

			sql.close()			
			return [yearsMonthwise: yearsMonthwise, patronCareSevaks: patronCareSevaks, patronCareSevaksIds: patronCareSevaksIds]
		}
	}

	def patronCareDashboardLinks = {
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
		{
			return [patronCareSevaks: params.patronCareSevaks, patronCareSevaksIds: params."patronCareSevaks.id"]
		}
	}
	
	def patronCareDashboardYearwise = {
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
		{

			def login = springSecurityService.principal.username
			def individual = Individual.findByLoginid(login)

			def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
			def i, j, k
			def patronCareHead, patronCareSevaks = []
			def individualInstanceList = [], individualRels = []
			def cultivatedByRelation = Relation.findByName("Cultivated by")

			individualRels = Relationship.findAllWhere(individual2:Individual.get(params."patronCareSevaksIds"), relation:cultivatedByRelation, status:"ACTIVE")
			for(j=0; j<individualRels.size(); j++)
			{
				individualInstanceList[j] = individualRels[j].individual1
			}

			individualInstanceList = individualInstanceList.unique()
			def individualInstanceIdsList = individualInstanceList.id
			def donationsList = [], donationInstanceList = []

			if(individualInstanceList.size() > 0)
			{
				for(i=0; i<individualInstanceList.size(); i++)
				{
					donationsList[i] = Donation.findAllByDonatedBy(individualInstanceList[i])
					for(j=0; j<donationsList[i].size(); j++)
						donationInstanceList.add(donationsList[i][j])

				}
				if(donationInstanceList.size() > 0)
					donationInstanceList = donationInstanceList.sort{ it.fundReceiptDate }

				def yearsMonthwise = params.yearsMonthwise
				def sql = new Sql(dataSource)

				def individualInstanceIdsListStr = individualInstanceIdsList.toString().replace("[","")
				individualInstanceIdsListStr = individualInstanceIdsListStr.toString().replace("]","")

				//bar yearwiseCollectionAmount
				def yearwiseCollectionQuery = "select sum(amount) amt, YEAR(donation_date) year from donation where YEAR(donation_date) is not null and donated_by_id in ("+ individualInstanceIdsListStr +") group by YEAR(donation_date)"
				def yearwiseCollection = sql.rows(yearwiseCollectionQuery)
				def years = []
				def collectionAmount = []
				def yearwiseCollectionAmount = []
				for(i=0; i<yearwiseCollection.size(); i++)
				{
					if(yearwiseCollection.year[i])
					{
						years.add(yearwiseCollection.year[i])
						collectionAmount.add(yearwiseCollection.amt[i])
					}
				}
				def yearTicks = []
				i = years[0]
				j = 0

				if(years.size() > 0)
				{
					while(i <= years[years.size()-1])
					{
						yearTicks.add(i)
						if(years[j] == i)
						{
							yearwiseCollectionAmount.add(collectionAmount[j])
							j++
						}
						else
						{
							yearwiseCollectionAmount.add(0)
						}
						i++
					}
				}
				//yearTicks.add(i)
				//yearwiseCollectionAmount.add(0)

		////////////////////////
				// bar Monthwise Collection by year
				def yearsMonthwiseQry = "select sum(amount) amt, MONTH(donation_date) from donation where YEAR(donation_date)='" + yearsMonthwise + "'  and donated_by_id in ("+ individualInstanceIdsListStr +") group by MONTH(donation_date)"
				def monthWise = sql.rows(yearsMonthwiseQry)
				def monthWiseCollection = []
				for(i=0; i<monthWise.size(); i++)
					monthWiseCollection.add(monthWise[i].amt)



		/////////////
				//meterguage amt
			    def query = "select sum(amount) amt from donation"
			    def row = sql.firstRow(query)

				//pie totalsByScheme
				def totalQry = "select s.name schm ,sum(d.amount) amount from donation d, scheme s where d.scheme_id=s.id and d.donated_by_id in ("+ individualInstanceIdsListStr +") group by s.name"

				def totalsByScheme = sql.rows(totalQry)

				def schm=[], amtByScheme=[]
				for (i=0; i<totalsByScheme.size(); i++)
				{
					schm.add("'"+totalsByScheme.schm[i]+"'");
					amtByScheme.add(totalsByScheme.amount[i]);
				}		


		////////////		


				//return [schm: schm, amtByScheme:amtByScheme, amt: row.amt, yearwiseCollectionAmount:yearwiseCollectionAmount, yearTicks:yearTicks, pc_yearwiseCollectionAmount:pc_yearwiseCollectionAmount, pc_yearTicks:pc_yearTicks, yearsMonthwise:yearsMonthwise, monthWiseCollection:monthWiseCollection, pc_monthWiseCollection:pc_monthWiseCollection, location_ids:location_ids, location_names:location_names, collection_location:collection_location, temp:temp]
				return [patronCareSevaksIds:params.patronCareSevaksIds, patronCareSevaks:params.patronCareSevaks, individualInstanceList:individualInstanceList, schm: schm, amtByScheme:amtByScheme, amt: row.amt, yearwiseCollectionAmount:yearwiseCollectionAmount, yearTicks:yearTicks,  yearsMonthwise:yearsMonthwise, monthWiseCollection:monthWiseCollection]

			}

			else
			{
				return[patronCareSevaksIds:params.patronCareSevaksIds, patronCareSevaks:params.patronCareSevaks, individualInstanceList:individualInstanceList]
			}			
			//return [patronCareSevaks: params.patronCareSevaks, patronCareSevaksIds: params.patronCareSevaksIds]
		}
	}
	def patronCareDashboardMonthwise = {
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
		{

			def login = springSecurityService.principal.username
			def individual = Individual.findByLoginid(login)

			def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
			def i, j, k
			def patronCareHead, patronCareSevaks = []
			def individualInstanceList = [], individualRels = []
			def cultivatedByRelation = Relation.findByName("Cultivated by")

			individualRels = Relationship.findAllWhere(individual2:Individual.get(params."patronCareSevaksIds"), relation:cultivatedByRelation, status:"ACTIVE")
			for(j=0; j<individualRels.size(); j++)
			{
				individualInstanceList[j] = individualRels[j].individual1
			}

			individualInstanceList = individualInstanceList.unique()
			def individualInstanceIdsList = individualInstanceList.id
			def donationsList = [], donationInstanceList = []

			if(individualInstanceList.size() > 0)
			{
				for(i=0; i<individualInstanceList.size(); i++)
				{
					donationsList[i] = Donation.findAllByDonatedBy(individualInstanceList[i])
					for(j=0; j<donationsList[i].size(); j++)
						donationInstanceList.add(donationsList[i][j])

				}
				if(donationInstanceList.size() > 0)
					donationInstanceList = donationInstanceList.sort{ it.fundReceiptDate }

				def yearsMonthwise = params.yearsMonthwise
				def sql = new Sql(dataSource)

				def individualInstanceIdsListStr = individualInstanceIdsList.toString().replace("[","")
				individualInstanceIdsListStr = individualInstanceIdsListStr.toString().replace("]","")

				//bar yearwiseCollectionAmount
				def yearwiseCollectionQuery = "select sum(amount) amt, YEAR(donation_date) year from donation where YEAR(donation_date) is not null and donated_by_id in ("+ individualInstanceIdsListStr +") group by YEAR(donation_date)"
				def yearwiseCollection = sql.rows(yearwiseCollectionQuery)
				def years = []
				def collectionAmount = []
				def yearwiseCollectionAmount = []
				for(i=0; i<yearwiseCollection.size(); i++)
				{
					if(yearwiseCollection.year[i])
					{
						years.add(yearwiseCollection.year[i])
						collectionAmount.add(yearwiseCollection.amt[i])
					}
				}
				def yearTicks = []
				i = years[0]
				j = 0

				if(years.size() > 0)
				{
					while(i <= years[years.size()-1])
					{
						yearTicks.add(i)
						if(years[j] == i)
						{
							yearwiseCollectionAmount.add(collectionAmount[j])
							j++
						}
						else
						{
							yearwiseCollectionAmount.add(0)
						}
						i++
					}
				}
				//yearTicks.add(i)
				//yearwiseCollectionAmount.add(0)

		////////////////////////
				// bar Monthwise Collection by year
				def yearsMonthwiseQry = "select sum(amount) amt, MONTH(donation_date) from donation where YEAR(donation_date)='" + yearsMonthwise + "'  and donated_by_id in ("+ individualInstanceIdsListStr +") group by MONTH(donation_date)"
				def monthWise = sql.rows(yearsMonthwiseQry)
				def monthWiseCollection = []
				for(i=0; i<monthWise.size(); i++)
					monthWiseCollection.add(monthWise[i].amt)



		/////////////
				//meterguage amt
			    def query = "select sum(amount) amt from donation"
			    def row = sql.firstRow(query)

				//pie totalsByScheme
				def totalQry = "select s.name schm ,sum(d.amount) amount from donation d, scheme s where d.scheme_id=s.id and d.donated_by_id in ("+ individualInstanceIdsListStr +") group by s.name"

				def totalsByScheme = sql.rows(totalQry)

				def schm=[], amtByScheme=[]
				for (i=0; i<totalsByScheme.size(); i++)
				{
					schm.add("'"+totalsByScheme.schm[i]+"'");
					amtByScheme.add(totalsByScheme.amount[i]);
				}		


		////////////		
				//return [schm: schm, amtByScheme:amtByScheme, amt: row.amt, yearwiseCollectionAmount:yearwiseCollectionAmount, yearTicks:yearTicks, pc_yearwiseCollectionAmount:pc_yearwiseCollectionAmount, pc_yearTicks:pc_yearTicks, yearsMonthwise:yearsMonthwise, monthWiseCollection:monthWiseCollection, pc_monthWiseCollection:pc_monthWiseCollection, location_ids:location_ids, location_names:location_names, collection_location:collection_location, temp:temp]
				return [patronCareSevaksIds:params.patronCareSevaksIds, patronCareSevaks:params.patronCareSevaks, individualInstanceList:individualInstanceList, schm: schm, amtByScheme:amtByScheme, amt: row.amt, yearwiseCollectionAmount:yearwiseCollectionAmount, yearTicks:yearTicks,  yearsMonthwise:yearsMonthwise, monthWiseCollection:monthWiseCollection]

			}

			else
			{
				return[patronCareSevaksIds:params.patronCareSevaksIds, patronCareSevaks:params.patronCareSevaks, individualInstanceList:individualInstanceList]
			}			
		}
	}
	def patronCareDashboardSchemewise = {
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
		{

			def login = springSecurityService.principal.username
			def individual = Individual.findByLoginid(login)

			def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
			def i, j, k
			def patronCareHead, patronCareSevaks = []
			def individualInstanceList = [], individualRels = []
			def cultivatedByRelation = Relation.findByName("Cultivated by")

			individualRels = Relationship.findAllWhere(individual2:Individual.get(params."patronCareSevaksIds"), relation:cultivatedByRelation, status:"ACTIVE")
			for(j=0; j<individualRels.size(); j++)
			{
				individualInstanceList[j] = individualRels[j].individual1
			}

			individualInstanceList = individualInstanceList.unique()
			def individualInstanceIdsList = individualInstanceList.id
			def donationsList = [], donationInstanceList = []

			if(individualInstanceList.size() > 0)
			{
				for(i=0; i<individualInstanceList.size(); i++)
				{
					donationsList[i] = Donation.findAllByDonatedBy(individualInstanceList[i])
					for(j=0; j<donationsList[i].size(); j++)
						donationInstanceList.add(donationsList[i][j])

				}
				if(donationInstanceList.size() > 0)
					donationInstanceList = donationInstanceList.sort{ it.fundReceiptDate }

				def yearsMonthwise = params.yearsMonthwise
				def sql = new Sql(dataSource)

				def individualInstanceIdsListStr = individualInstanceIdsList.toString().replace("[","")
				individualInstanceIdsListStr = individualInstanceIdsListStr.toString().replace("]","")

				//bar yearwiseCollectionAmount
				def yearwiseCollectionQuery = "select sum(amount) amt, YEAR(donation_date) year from donation where YEAR(donation_date) is not null and donated_by_id in ("+ individualInstanceIdsListStr +") group by YEAR(donation_date)"
				def yearwiseCollection = sql.rows(yearwiseCollectionQuery)
				def years = []
				def collectionAmount = []
				def yearwiseCollectionAmount = []
				for(i=0; i<yearwiseCollection.size(); i++)
				{
					if(yearwiseCollection.year[i])
					{
						years.add(yearwiseCollection.year[i])
						collectionAmount.add(yearwiseCollection.amt[i])
					}
				}
				def yearTicks = []
				i = years[0]
				j = 0

				if(years.size() > 0)
				{
					while(i <= years[years.size()-1])
					{
						yearTicks.add(i)
						if(years[j] == i)
						{
							yearwiseCollectionAmount.add(collectionAmount[j])
							j++
						}
						else
						{
							yearwiseCollectionAmount.add(0)
						}
						i++
					}
				}
				//yearTicks.add(i)
				//yearwiseCollectionAmount.add(0)

		////////////////////////
				// bar Monthwise Collection by year
				def yearsMonthwiseQry = "select sum(amount) amt, MONTH(donation_date) from donation where YEAR(donation_date)='" + yearsMonthwise + "'  and donated_by_id in ("+ individualInstanceIdsListStr +") group by MONTH(donation_date)"
				def monthWise = sql.rows(yearsMonthwiseQry)
				def monthWiseCollection = []
				for(i=0; i<monthWise.size(); i++)
					monthWiseCollection.add(monthWise[i].amt)



		/////////////
				//meterguage amt
			    def query = "select sum(amount) amt from donation"
			    def row = sql.firstRow(query)

				//pie totalsByScheme
				def totalQry = "select s.name schm ,sum(d.amount) amount from donation d, scheme s where d.scheme_id=s.id and d.donated_by_id in ("+ individualInstanceIdsListStr +") group by s.name"

				def totalsByScheme = sql.rows(totalQry)

				def schm=[], amtByScheme=[]
				for (i=0; i<totalsByScheme.size(); i++)
				{
					schm.add("'"+totalsByScheme.schm[i]+"'");
					amtByScheme.add(totalsByScheme.amount[i]);
				}		


		////////////		


				//return [schm: schm, amtByScheme:amtByScheme, amt: row.amt, yearwiseCollectionAmount:yearwiseCollectionAmount, yearTicks:yearTicks, pc_yearwiseCollectionAmount:pc_yearwiseCollectionAmount, pc_yearTicks:pc_yearTicks, yearsMonthwise:yearsMonthwise, monthWiseCollection:monthWiseCollection, pc_monthWiseCollection:pc_monthWiseCollection, location_ids:location_ids, location_names:location_names, collection_location:collection_location, temp:temp]
				return [patronCareSevaksIds:params.patronCareSevaksIds, patronCareSevaks:params.patronCareSevaks, individualInstanceList:individualInstanceList, schm: schm, amtByScheme:amtByScheme, amt: row.amt, yearwiseCollectionAmount:yearwiseCollectionAmount, yearTicks:yearTicks,  yearsMonthwise:yearsMonthwise, monthWiseCollection:monthWiseCollection]

			}

			else
			{
				return[patronCareSevaksIds:params.patronCareSevaksIds, patronCareSevaks:params.patronCareSevaks, individualInstanceList:individualInstanceList]
			}			
		}
	}
	def patronCareDashboardMonthwiseInput = {
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
		{
			def yearsMonthwise = []
			def sql = new Sql(dataSource)
			def yearsQry = "select distinct YEAR(donation_date) year from donation order by YEAR(donation_date)"
			def yearsResult = sql.rows(yearsQry)
			for(int  i=0; i<yearsResult.size(); i++)
			{
				if(yearsResult.year[i])
					yearsMonthwise.add(yearsResult.year[i])
			}

			sql.close()			
			
			return [yearsMonthwise:yearsMonthwise, patronCareSevaks: params.patronCareSevaks, patronCareSevaksIds: params.patronCareSevaksIds]
		}
	}
	def showGraphs = {}
	def patronCareDashboard = {
			
		def login = springSecurityService.principal.username
		def individual = Individual.findByLoginid(login)

		def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
		def i, j, k
		def patronCareHead, patronCareSevaks = []
		def individualInstanceList = [], individualRels = []
		def cultivatedByRelation = Relation.findByName("Cultivated by")

		individualRels = Relationship.findAllWhere(individual2:Individual.get(params."patronCareSevaks.id"), relation:cultivatedByRelation, status:"ACTIVE")
		for(j=0; j<individualRels.size(); j++)
		{
			individualInstanceList[j] = individualRels[j].individual1
		}
				
		individualInstanceList = individualInstanceList.unique()
		def individualInstanceIdsList = individualInstanceList.id
		def donationsList = [], donationInstanceList = []

		if(individualInstanceList.size() > 0)
		{
			for(i=0; i<individualInstanceList.size(); i++)
			{
				donationsList[i] = Donation.findAllByDonatedBy(individualInstanceList[i])
				for(j=0; j<donationsList[i].size(); j++)
					donationInstanceList.add(donationsList[i][j])

			}
			if(donationInstanceList.size() > 0)
				donationInstanceList = donationInstanceList.sort{ it.fundReceiptDate }

			def yearsMonthwise = params.yearsMonthwise
			def sql = new Sql(dataSource)

			def individualInstanceIdsListStr = individualInstanceIdsList.toString().replace("[","")
			individualInstanceIdsListStr = individualInstanceIdsListStr.toString().replace("]","")

			//bar yearwiseCollectionAmount
			def yearwiseCollectionQuery = "select sum(amount) amt, YEAR(donation_date) year from donation where YEAR(donation_date) is not null and donated_by_id in ("+ individualInstanceIdsListStr +") group by YEAR(donation_date)"
			def yearwiseCollection = sql.rows(yearwiseCollectionQuery)
			def years = []
			def collectionAmount = []
			def yearwiseCollectionAmount = []
			for(i=0; i<yearwiseCollection.size(); i++)
			{
				if(yearwiseCollection.year[i])
				{
					years.add(yearwiseCollection.year[i])
					collectionAmount.add(yearwiseCollection.amt[i])
				}
			}
			def yearTicks = []
			i = years[0]
			j = 0

			if(years.size() > 0)
			{
				while(i <= years[years.size()-1])
				{
					yearTicks.add(i)
					if(years[j] == i)
					{
						yearwiseCollectionAmount.add(collectionAmount[j])
						j++
					}
					else
					{
						yearwiseCollectionAmount.add(0)
					}
					i++
				}
			}
			//yearTicks.add(i)
			//yearwiseCollectionAmount.add(0)

	////////////////////////
			// bar Monthwise Collection by year
			def yearsMonthwiseQry = "select sum(amount) amt, MONTH(donation_date) from donation where YEAR(donation_date)='" + yearsMonthwise + "'  and donated_by_id in ("+ individualInstanceIdsListStr +") group by MONTH(donation_date)"
			def monthWise = sql.rows(yearsMonthwiseQry)
			def monthWiseCollection = []
			for(i=0; i<monthWise.size(); i++)
				monthWiseCollection.add(monthWise[i].amt)



	/////////////
			//meterguage amt
		    def query = "select sum(amount) amt from donation"
		    def row = sql.firstRow(query)

			//pie totalsByScheme
			def totalQry = "select s.name schm ,sum(d.amount) amount from donation d, scheme s where d.scheme_id=s.id and d.donated_by_id in ("+ individualInstanceIdsListStr +") group by s.name"

			def totalsByScheme = sql.rows(totalQry)

			def schm=[], amtByScheme=[]
			for (i=0; i<totalsByScheme.size(); i++)
			{
				schm.add("'"+totalsByScheme.schm[i]+"'");
				amtByScheme.add(totalsByScheme.amount[i]);
			}		


	////////////		


			//return [schm: schm, amtByScheme:amtByScheme, amt: row.amt, yearwiseCollectionAmount:yearwiseCollectionAmount, yearTicks:yearTicks, pc_yearwiseCollectionAmount:pc_yearwiseCollectionAmount, pc_yearTicks:pc_yearTicks, yearsMonthwise:yearsMonthwise, monthWiseCollection:monthWiseCollection, pc_monthWiseCollection:pc_monthWiseCollection, location_ids:location_ids, location_names:location_names, collection_location:collection_location, temp:temp]
			return [patronCareSevaks:params.patronCareSevaks, individualInstanceList:individualInstanceList, schm: schm, amtByScheme:amtByScheme, amt: row.amt, yearwiseCollectionAmount:yearwiseCollectionAmount, yearTicks:yearTicks,  yearsMonthwise:yearsMonthwise, monthWiseCollection:monthWiseCollection]
			
		}
		
		else
		{
			return[patronCareSevaks:params.patronCareSevaks, individualInstanceList:individualInstanceList]
		}
	}
	
       def donorLocation(String location) {
	    def addresses = Address.search(location,[reload: true, result: 'every'])
	    addresses.each { addr ->
		    println addr
		    println Individual.get(addr?.individual?.id)
		    }
    }
	
    def areawiseCollectionReport = {
    
    }
    
    def areawiseCollectionViewReport = {
    	def sql = new Sql(dataSource)
    	def i
    	def locationName = Locations.get(params."locations.id").name

	def haveQuery
	def haveResults
	def searchResult
	def count
	def addresses
	def donationsQry, uniqueDonations = []
	haveQuery = locationName + "~"
	count = Address.countHits(haveQuery)
	println "There are ${count} hits for query "
	addresses =  Address.search(haveQuery,[reload: true, result: 'every'])
	addresses.each { addr ->
		println 'Donor='+addresses?.individual
		println 'Addresses='+addresses
		if(addr.toString().indexOf(haveQuery.substring(0,3))>=0)
		{
			println 'i.id='+(addr?.individual?.id)
			donationsQry = "select i.id,sum(d.amount) amt, group_concat(concat('<br>',nvcc_receipt_book_no,'/',nvcc_receipt_no,'/',cast(amount as char(12)),'/',Day(donation_date),'-',Month(donation_date),'-',Year(donation_date),'/',Day(fund_receipt_date),'-',Month(fund_receipt_date),'-',Year(fund_receipt_date))) details from donation d, individual i where i.id = '"+addr?.individual?.id+"' and d.donated_by_id=i.id and (d.status is null or d.status != 'BOUNCED') group by i.id"
			println 'donationsQry='+donationsQry
			uniqueDonations.add(sql.firstRow(donationsQry))
			println 'uniqueDonations='+uniqueDonations

		}

		sql.close()

	}


	return [locationName:locationName,uniqueDonations:uniqueDonations]
    
    }
    def citywiseCollectionReport = {
    
    }
    
    def citywiseCollectionViewReport = {
    	println 'params='+params
    	def sql = new Sql(dataSource)
    	def i
    	def cityName = City.get(params."city.id").name

	def haveQuery
	def haveResults
	def searchResult
	def count
	def addresses
	def donationsQry, uniqueDonations = []
	haveQuery = cityName + "~"
	count = Address.countHits(haveQuery)
	println "There are ${count} hits for query "
	addresses =  Address.search(haveQuery,[reload: true, result: 'every'])
	addresses.each { addr ->
		println 'Donor='+addresses?.individual
		println 'Addresses='+addresses
		if(addr.toString().indexOf(haveQuery.substring(0,3))>=0)
		{
			println 'i.id='+(addr?.individual?.id)
			donationsQry = "select i.id,sum(d.amount) amt, group_concat(concat('<br>',nvcc_receipt_book_no,'/',nvcc_receipt_no,'/',cast(amount as char(12)),'/',Day(donation_date),'-',Month(donation_date),'-',Year(donation_date),'/',Day(fund_receipt_date),'-',Month(fund_receipt_date),'-',Year(fund_receipt_date))) details from donation d, individual i where i.id = '"+addr?.individual?.id+"' and d.donated_by_id=i.id and (d.status is null or d.status != 'BOUNCED') group by i.id"
			println 'donationsQry='+donationsQry
			uniqueDonations.add(sql.firstRow(donationsQry))
			println 'uniqueDonations='+uniqueDonations

		}

		sql.close()

	}
	return [cityName:cityName,uniqueDonations:uniqueDonations]
    
    }
    
    def allAreawiseCollectionViewReport = {
    	def sql = new Sql(dataSource)
    	def i
	def locationQry = "select id, name from locations"
	def locations = sql.rows(locationQry)
	locations = locations.sort()
	def location_ids = []
	def location_names = []
	//println "----locations:"+locations
	def collectionByAreaQry, collectionByArea = []
	for(i=0; i<locations.size(); i++)
	{
		location_ids.add(locations[i].id)
		location_names.add("'"+locations[i].name+"'")

	}
	//println "----location_ids:"+location_ids
	//println "----location_names:"+location_names
	sql.close() 


	def haveQuery
	def haveResults
	def searchResult
	def count
	def className
	locations=locations.sort{it.name}
	def addresses
	def summaryDonation
	def sum_location = 0
	def collection_location = []
	def temp = []
	location_names = location_names.sort()
	for(i=0; i<locations.size(); i++)
	{
		temp[i] = location_names[i]
		sum_location = 0
		haveQuery = locations[i].name + "~"

		count = Address.countHits(haveQuery)
		//println "There are ${count} hits for query "

		addresses =  Address.search(haveQuery,[reload: true, result: 'every'])
		addresses.each { addr ->

		if(addr.toString().indexOf(haveQuery.substring(0,3))>=0)
		{
			summaryDonation = housekeepingService.donationSummary((addr?.individual?.id).toString())
			//println 'summaryDonation='+summaryDonation.amtInd 
			if (summaryDonation.amtInd)
				sum_location = sum_location.toLong() + summaryDonation.amtInd
		}
       }
       println 'sum_location='+sum_location
       collection_location.add(sum_location)
       println 'collection_location='+collection_location 
/////////////
	}
	return [collection_location:collection_location, temp:temp]
    }


    def viewreport = {
    	println "View Report:"+params
    	def p1 = ''
    		p1 = params.param1_year +"-" + params.param1_month + "-" + params.param1_day +" 00:00:00"
    	println p1
    	def p2 = ''
    		p2 = params.param2_year +"-" + params.param2_month + "-" + params.param2_day +" 00:00:00"
    	println p2
    	
	def p3 = "XYZ"+params.param3
	if(p3.find(','))
		{
		p3= p3[4..-2]
		}
	else
		p3 = params.param3
		
	println p3
	
	[msg:"Please click a link above!",reportName:params.reportName, param1:p1, param2:p2, param3:p3, param4:params.param4, param5:params.param5]
	}

    def dailyTransactionReport = {
        	def role = Role.findByName("Receiver")
        	def c = Individual.createCriteria()
		//show all recepients
		def recepients = c.list
			{
			individualRoles
				{
				eq("role",role)
				}
				order("initiatedName", "asc")
				order("legalName", "asc")
			}
		return [recepients: recepients]
	}

    def amountReport = {
    println "amountreport: "+params
    
    		if(!params.fromamount)
    			return

    		def cond = null
	   switch (params.fromcriteria) {
	      case "Equal to":
	          cond = '='
	          break
	      case "Less than":
	          cond = '<'
	          break
	      case "Less than or Equal to":
	          cond = "<="
	          break
	      case "Greater than":
	          cond = ">"
	          break
	      case "Greater than or Equal to":
	          cond = ">="
	          break
	      default:
	          cond = null
		}
		
	if (!cond || !params.fromamount?.isInteger())
		{
	            flash.message = "Please provide valid input!!"
	            return [fromamount:params.fromamount, fromcriteria:params.fromcriteria, toamount:params.toamount, tocriteria:params.tocriteria]
		}
		
	def tocond = null
	def validtoamt = false
	def optflag = false
	if(!params.toamount && !params.tocriteria)
		optflag = true
	if(params.toamount?.isInteger() && params.toamount.toInteger() > params.fromamount.toInteger())
	{
		validtoamt = true
	}
	if(validtoamt)
	{
	   switch (params.tocriteria) {
	      case "Equal to":
	          tocond = '='
	          break
	      case "Less than":
	          tocond = '<'
	          break
	      case "Less than or Equal to":
	          tocond = "<="
	          break
	      case "Greater than":
	          tocond = ">"
	          break
	      case "Greater than or Equal to":
	          tocond = ">="
	          break
	      default:
	          tocond = null
		}
	}
	
	if (!optflag && (!tocond || !validtoamt))
		{
	            flash.message = "Please provide valid input for To amount/criteria!!"
	            return [fromamount:params.fromamount, fromcriteria:params.fromcriteria, toamount:params.toamount, tocriteria:params.tocriteria]
		}


	   def sql = new Sql(dataSource);
	   def queryInd = "select donated_by_id did,amt from (select donated_by_id, sum(amount) amt from donation where status is null or status != 'BOUNCED' group by donated_by_id) d where d.amt "+cond+" "+params.fromamount
	   if(tocond)
	   	queryInd += " and d.amt "+tocond+" "+params.toamount
	   def dList = sql.rows(queryInd)
	   sql.close()
	   println "queryInd="+queryInd
	   
	   def iList = []
	   def aList = []
	   dList.each { i ->
	     iList.add(i.did)
	     aList.add(i.amt)
	   }
	   println "individuals"+iList
	   println "amount"+aList
	
	/*String path = "./web-app/images/grails_logo.jpg"

	sendMail {     
	  multipart true
	  to "prashant.kaushal@bt.com"     
	  subject "Hello Fred"     
	  body 'How are you?' 
	  attachBytes path,'image/jpg', new File(path).readBytes()
	}*/

	return [fromamount: params.fromamount, fromcriteria: params.fromcriteria, toamount:params.toamount, tocriteria:params.tocriteria, individualList: (iList?.size()>0)?Individual.getAll(iList):null, amountList : aList]
	}

    
    def amountViewReport = {
        println "amountreport: "+params
     	def fd='',td=''
    	if(params.fromDate)
    	{
    		fd = Date.parse('dd-MM-yyyy', params.fromDate)
    		fd.clearTime()
    	}
    	else
    	{
    		def sql = new Sql(dataSource);
    		//fd = new Date().previous()
    		def queryFromDate = "SELECT min(fund_receipt_date) fd FROM donation"
    		fd = sql.firstRow(queryFromDate).fd
    		sql.close()
    		//fd = new Date()
    	}
    	
    	println "fd="+fd
    	
	
    	if(params.toDate)
    		td = Date.parse('dd-MM-yyyy', params.toDate)
    	else
    		td = new Date()
    	//td = td.next()
    	td.clearTime()
    		
    	println "between:"+fd+"<=>"+td     
        
	if(!params.fromamount)
		return
		//params.fromamount = 0

	def cond = null
    	   switch (params.fromcriteria) {
    	      case "Equal to":
    	          cond = '='
    	          break
    	      case "Less than":
    	          cond = '<'
    	          break
    	      case "Less than or Equal to":
    	          cond = "<="
    	          break
    	      case "Greater than":
    	          cond = ">"
    	          break
    	      case "Greater than or Equal to":
    	          cond = ">="
    	          break
    	      default:
    	          cond = null
    		}
    		
    	if (!cond || !params.fromamount?.isInteger())
    		{
    	            flash.message = "Please provide valid input!!"
    	            return [fromamount:params.fromamount, fromcriteria:params.fromcriteria, toamount:params.toamount, tocriteria:params.tocriteria]
    		}
    		
    	def tocond = null
    	def validtoamt = false
    	def optflag = false
    	if(!params.toamount && !params.tocriteria)
    		optflag = true
    	if(params.toamount?.isInteger() && params.toamount.toInteger() > params.fromamount.toInteger())
    	{
    		validtoamt = true
    	}
    	if(validtoamt)
    	{
    	   switch (params.tocriteria) {
    	      case "Equal to":
    	          tocond = '='
    	          break
    	      case "Less than":
    	          tocond = '<'
    	          break
    	      case "Less than or Equal to":
    	          tocond = "<="
    	          break
    	      case "Greater than":
    	          tocond = ">"
    	          break
    	      case "Greater than or Equal to":
    	          tocond = ">="
    	          break
    	      default:
    	          tocond = null
    		}
    	}
    	
    	if (!optflag && (!tocond || !validtoamt))
    		{
    	            flash.message = "Please provide valid input for To amount/criteria!!"
    	            return [fromamount:params.fromamount, fromcriteria:params.fromcriteria, toamount:params.toamount, tocriteria:params.tocriteria]
    		}
    
    
    	   def sql = new Sql(dataSource);
    	   
    	   //def queryInd = "select donated_by_id did,amt, collected_by_id cid from (select donated_by_id, sum(amount) amt, collected_by_id  from donation where status is null or status != 'BOUNCED' group by donated_by_id) d where d.amt "+cond+" "+params.fromamount
    	   def queryInd = "select donated_by_id did,amt, collected_by_id cid, fund_receipt_date from (select donated_by_id, sum(amount) amt, collected_by_id, fund_receipt_date  from donation where (status is null or status != 'BOUNCED') and fund_receipt_date>='"+String.format('%tF',fd)+"' and fund_receipt_date<='"+String.format('%tF',td)+"' group by donated_by_id) d where d.amt "+cond+" "+params.fromamount
    	   
    	   if(tocond)
    	   	queryInd += " and d.amt "+tocond+" "+params.toamount
    	   def dList = sql.rows(queryInd)
    	   sql.close()
    	   println "queryInd="+queryInd
    	   
    	   def iList = []
    	   def aList = []
    	   def cList = []
    	   def dtList = []
    	   dList.each { i ->
    	     iList.add(i.did)
    	     aList.add(i.amt)
    	     cList.add(i.cid)
    	     dtList.add(i.fund_receipt_date)
    	   }

    	   println "cList"+cList
    	

    
    	return [fromamount: params.fromamount, fromcriteria: params.fromcriteria, toamount:params.toamount, tocriteria:params.tocriteria, individualList: (iList?.size()>0)?Individual.getAll(iList):null, amountList : aList, collectorList: cList, dateList:dtList, fd:fd, td:td]
    	}
    
	 def addressByDonationReport = {
	 }
	 
	 def addressByDonationViewReport = {
        println "addressByDonationViewReport: "+params
    	def parameter1 = param.fromcriteria
    	def parameter2 = param.fromamount
    	def parameter3 = param.tocriteria
    	def parameter4 = param.toamount
    	println "parameter1="+parameter1
    	println "parameter2="+parameter2
    	println "parameter3="+parameter3
    	println "parameter4="+parameter4
	
		[msg:"Please click a link above!",reportName:params.reportName, parameter1:parameter1, parameter2:parameter2, parameter3:parameter3, parameter4:parameter4]
	 }
    
	 def collectorAmountSchemeReport	= {
		def collectors = IndividualRole.findAllByRole(Role.findByName("Collector")).individual
		
		return [collectors: collectors]
	}
	
	 def collectorAmountSchemeViewReport	= {
	 println "---------------------collectorAmountSchemeViewReport------------------------"
		println "params="+params
		if(params.fromamount)
		{
        		def cond = null
    	   switch (params.fromcriteria) {
    	      case "Equal to":
    	          cond = '='
    	          break
    	      case "Less than":
    	          cond = '<'
    	          break
    	      case "Less than or Equal to":
    	          cond = "<="
    	          break
    	      case "Greater than":
    	          cond = ">"
    	          break
    	      case "Greater than or Equal to":
    	          cond = ">="
    	          break
    	      default:
    	          cond = null
    		}
    		
    	if (!cond || !params.fromamount?.isInteger())
    		{
    	            flash.message = "Please provide valid input!!"
    	            return [fromamount:params.fromamount, fromcriteria:params.fromcriteria, toamount:params.toamount, tocriteria:params.tocriteria]
    		}
    		
    	def tocond = null
    	def validtoamt = false
    	def optflag = false
    	if(!params.toamount && !params.tocriteria)
    		optflag = true
    	if(params.toamount?.isInteger() && params.toamount.toInteger() > params.fromamount.toInteger())
    	{
    		validtoamt = true
    	}
    	if(validtoamt)
    	{
    	   switch (params.tocriteria) {
    	      case "Equal to":
    	          tocond = '='
    	          break
    	      case "Less than":
    	          tocond = '<'
    	          break
    	      case "Less than or Equal to":
    	          tocond = "<="
    	          break
    	      case "Greater than":
    	          tocond = ">"
    	          break
    	      case "Greater than or Equal to":
    	          tocond = ">="
    	          break
    	      default:
    	          tocond = null
    		}
    	}
    	
    	if (!optflag && (!tocond || !validtoamt))
    		{
    	            flash.message = "Please provide valid input for To amount/criteria!!"
    	            return [fromamount:params.fromamount, fromcriteria:params.fromcriteria, toamount:params.toamount, tocriteria:params.tocriteria]
    		}
    
    
    	   def sql = new Sql(dataSource);
    	   def queryScheme = ""
    	   //def subQueryScheme = ""
    	   
    	   if (params.schemeid)
    	   {
    	   	//subQueryScheme += ", scheme_id schm"
    	   	queryScheme += " (scheme_id = '"+params.schemeid+"') and "
    	  	}
    	  	
    	   def queryCollector = ""
    	   
    	   def subQueryCollector = ""
    	   def collectorIdList = []
    	  
    	   if((params.h_collectorid).toInteger() == 1)
    	   	collectorIdList[0] = params.oneSelection
    	   if((params.h_collectorid).toInteger() > 1) 	
    	   {
		   for(int j=0; j<(params.h_collectorid).toInteger(); j++)
		   {
			   collectorIdList[j] = params."collector.id"[j]
			   println "j="+j
			   println collectorIdList[j]
		   }
    	   }
    	   
    	   if((params.h_collectorid).toInteger() >0)
    	   	queryCollector = "("
    	   
    	   if ((params.h_collectorid).toInteger() == 1)
    	   
    	   		queryCollector += "collected_by_id = '" +params.oneSelection+"') and "
    	   		
    	   		
    	   if ((params.h_collectorid).toInteger() > 1)
	   {
		for(int i=0; i<(params.h_collectorid).toInteger(); i++)
		{
			queryCollector += "collected_by_id = '" +collectorIdList[i] + "' or "
		}
		queryCollector = queryCollector[0..-2]
		queryCollector = queryCollector[0..-2]
		queryCollector = queryCollector[0..-2]

		queryCollector += ") and "

		println "queryCollector="+queryCollector
	   }	
    	   	
    	   //def queryInd = "select donated_by_id did,amount amnt, collected_by_id cid, scheme_id schm, amt from (select donated_by_id, amount , collected_by_id, scheme_id, sum(amount) amt from donation where "+queryCollector + queryScheme+"  status is null or status != 'BOUNCED' group by donated_by_id order by collected_by_id asc) d where  d.amt  "+cond+" "+params.fromamount
    	   def queryInd = "select donated_by_id did,amount amnt, collected_by_id cid, scheme_id schm,amt from (select donated_by_id, amount, collected_by_id, scheme_id, sum(amount) amt  from donation where "+queryCollector + queryScheme+" (status is null or status != 'BOUNCED') group by donated_by_id) d where  d.amt "+cond+" "+params.fromamount
    	   println "queryInd="+queryInd
    	   
    	   //queryInd=select donated_by_id did,amt, collected_by_id cid from (select donated_by_id, sum(amount) amt, collected_by_id , 
    	   //scheme_id from donation where  scheme_id = 1 and  status is null or status != 'BOUNCED' group by donated_by_id) d where d.amt > 2000
    	   
    	   if(tocond)
    	   	queryInd += " and d.amt "+tocond+" "+params.toamount
    	   	
    	   
    	   def dList = sql.rows(queryInd)
    	   sql.close()
    	   
    	   def iList = []
    	   def aList = []
    	   def cList = []
    	   def sList = []
    	   def amtList = []
    	   def totalAmt = (0.00)
    	   dList.each { i ->
    	     iList.add(i.did)
    	     //
    	    	amtList.add(i.amnt)
    	     cList.add(i.cid)
    	     sList.add(i.schm)
    	      aList.add(i.amt)
    	      totalAmt += (i.amt).toLong()
    	   }

    	   //println "cList"+cList
    	   println "dList"+dList
    	   
    	   def scheme = Scheme.findById(params.schemeid)
    	   def toamount
    	   return [dList: dList, fromcriteria: params.fromcriteria, fromamount: params.fromamount, tocriteria: params.tocriteria, toamount: toamount, scheme: scheme, totalAmt: totalAmt]
    	}
    	   
    	else
    	{
    	   def sql = new Sql(dataSource);
    	   def queryScheme = ""
    	   def subQueryScheme = ""
    	   
    	   if (params.schemeid)
    	   {
    	   	//subQueryScheme += ", scheme_id schm"
    	   	queryScheme += " (scheme_id = '"+params.schemeid+"') and "
    	  	}
    	  	
    	   def queryCollector = ""
    	   
    	   def subQueryCollector = ""
    	   def collectorIdList = []

    	   if((params.h_collectorid).toInteger() == 1)
    	   	collectorIdList[0] = params.oneSelection
    	   if((params.h_collectorid).toInteger() > 1) 	
    	   {
		for(int j=0; j<(params.h_collectorid).toInteger(); j++)
		{
		   collectorIdList[j] = params."collector.id"[j]
		   //println "j="+j
		   //println collectorIdList[j]
		}
    	   }
    	   
    	   if((params.h_collectorid).toInteger() >0)
    	   	queryCollector = "("
    	   if ((params.h_collectorid).toInteger() == 1)
    	   	
    	   	queryCollector += "collected_by_id = '" +params.oneSelection+"') and "

    	   if ((params.h_collectorid).toInteger() > 1)
	   {
		for(int i=0; i<(params.h_collectorid).toInteger(); i++)
		{
			queryCollector += "collected_by_id = '" +collectorIdList[i] + "' or "
		}
		queryCollector = queryCollector[0..-2]
		queryCollector = queryCollector[0..-2]
		queryCollector = queryCollector[0..-2]

		queryCollector += ") and "

		println "queryCollector="+queryCollector
	   }	
    	   	//queryCollector += ")"
    	   	
    	   def queryInd = "select donated_by_id did,amount amnt, collected_by_id cid, scheme_id schm from (select donated_by_id, amount , collected_by_id, scheme_id from donation where "+queryCollector + queryScheme+" (status is null or status != 'BOUNCED') order by collected_by_id asc) d"
    	   println "queryInd="+queryInd
    	   
    	   //queryInd=select donated_by_id did,amt, collected_by_id cid from (select donated_by_id, sum(amount) amt, collected_by_id , 
    	   //scheme_id from donation where  scheme_id = 1 and  status is null or status != 'BOUNCED' group by donated_by_id) d where d.amt > 2000

    	   def dList = sql.rows(queryInd)
    	   sql.close()
    	   
    	   def iList = []
    	   //def aList = []
    	   def cList = []
    	   def sList = []
    	    def amtList = []
    	    def totalAmt = (0.00)
    	   dList.each { i ->
    	     iList.add(i.did)
    	     
    	     amtList.add(i.amnt)
    	     cList.add(i.cid)
    	     sList.add(i.schm)
    	     //aList.add(i.amt)
    	     //println "i.amnt="+i.amnt
    	     
    	     totalAmt += (i.amnt).toLong()
    	     //println "totalAmt="+totalAmt
    	   }
    	   /*println "individuals"+iList
    	   //println "amount"+aList*/
    	   //println "cList"+cList
    	  // println "dList"+dList 
    	   
    	   def scheme = Scheme.findById(params.schemeid)
    	   
    	   return [dList: dList, scheme: scheme, totalAmt: totalAmt]
    	}
    	
	}    
	
	def birthdayReport = {

	}
	
	def birthdayViewReport = {
		println '--------------------birthdayViewReport-----------------'
		println "params=>"+params
		println params.selIndex
		def birthdayList = []
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
		{
			def login = springSecurityService.principal.username
			println "Loggedin user: "+login
			def individual = Individual.findByLoginid(login)
			println "setSessionParams for: "+individual

			def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
			println 'pcRole='+pcRole
			def patronCareHead, patronCareSevaks = []
			def individualInstanceList = [], individualRels = []
			def cultivatedByRelation = Relation.findByName("Cultivated by")

			for(int i=0; i<pcRole.size(); i++)
			{
				if(pcRole[i].toString() == "PatronCare")
				{
					individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
					for(int j=0; j<individualRels.size(); j++)
					{
						individualInstanceList[j] = individualRels[j].individual1
					}

					def sevakOfRelation = Relation.findByName("Sevak of")
					patronCareSevaks = Relationship.findAllWhere(individual2:individual, relation:sevakOfRelation, status:"ACTIVE").individual1		
					for(int j=0; j<patronCareSevaks.size(); j++)
					{
						individualRels = Relationship.findAllWhere(individual2:patronCareSevaks[j], relation:cultivatedByRelation, status:"ACTIVE")
						for(int k=0; k<individualRels.size(); k++)
						{
							println 'k='+k
							println 'individualRels[k]='+individualRels[k]
							println 'individualRels[k].individual1='+individualRels[k].individual1
							individualInstanceList.add(individualRels[k].individual1)
						}
					}
				}
				if(pcRole[i].toString() == "PatronCareSevak")
				{
					individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
					for(int j=0; j<individualRels.size(); j++)
					{
						individualInstanceList[j] = individualRels[j].individual1
					}
				}			
			}

			individualInstanceList = individualInstanceList.unique()
			
			if(params.selIndex == "0")
			{
				  def now = new Date()

				  def j = 0, birthMonthOfDonor, birthDateOfDonor
				  for(int i=0;i<individualInstanceList.size();i++)
				  {
					  if(individualInstanceList[i].dob)
					  {
						  birthMonthOfDonor = ((individualInstanceList[i].dob).month).toInteger()
						  birthDateOfDonor = (individualInstanceList[i].dob).getDate()
						if (birthMonthOfDonor == now.month && birthDateOfDonor == now.getDate())
						{
							birthdayList[j] = individualInstanceList[i]
							j++
						}
					  }
				  }
				  birthdayList = birthdayList.unique()
				  //return [birthdayList: birthdayList, selIndex:params.selIndex]
			}
			else if(params.selIndex == "1")
			{
				  def now = new Date()
				  def tomorrowsDate = now.next()

				  def j = 0, birthMonthOfDonor, birthDateOfDonor
				  for(int i=0;i<individualInstanceList.size();i++)
				  {
					  if(individualInstanceList[i].dob)
					  {
						  birthMonthOfDonor = ((individualInstanceList[i].dob).month).toInteger()
						  birthDateOfDonor = (individualInstanceList[i].dob).getDate()
						if (birthMonthOfDonor == tomorrowsDate.month && birthDateOfDonor == tomorrowsDate.getDate())
						{
							birthdayList[j] = individualInstanceList[i]
							j++
						}
					  }
				  }
				  birthdayList = birthdayList.unique()
				  //return [birthdayList: birthdayList, selIndex:params.selIndex]
			}
			
			else
			{
				  //def bDayList = Donation.findAllByCollectedBy(Individual.get(session.individualid))

				  def j = 0, birthMonthOfDonor
				  for(int i=0;i<individualInstanceList.size();i++)
				  {
					  if(individualInstanceList[i].dob)
					  {

						birthMonthOfDonor = (((individualInstanceList[i].dob).month).toInteger()+(1*1).toInteger())*1
						println 'birthMonthOfDonor='+birthMonthOfDonor
						println '(params.selIndex).toInteger()='+((params.selIndex).toInteger() - 1)
						if (birthMonthOfDonor == ((params.selIndex).toInteger() - 1))
						{
							birthdayList[j] = individualInstanceList[i]
							j++
						}
					}
				  }
				  birthdayList = birthdayList.unique()
				  //return [birthdayList: birthdayList, selIndex:params.selIndex]
			}
			
			//[individualInstanceList: individualInstanceList, individualInstanceTotal: individualInstanceList.size()]		
		}
		
		return [birthdayList: birthdayList, selIndex:params.selIndex]
	}

	def marriageAnniversaryReport = {

	}
	
	def marriageAnniversaryViewReport = {
		println '--------------------marriageAnniversaryViewReport-----------------'
		println "params=>"+params
		//println params.selIndex
		def mAnniversaryList = []
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
		{
			
			def login = springSecurityService.principal.username
			println "Loggedin user: "+login
			def individual = Individual.findByLoginid(login)
			println "setSessionParams for: "+individual

			def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
			println 'pcRole='+pcRole
			def patronCareHead, patronCareSevaks = []
			def individualInstanceList = [], individualRels = []
			def cultivatedByRelation = Relation.findByName("Cultivated by")

			for(int i=0; i<pcRole.size(); i++)
			{
				if(pcRole[i].toString() == "PatronCare")
				{
					individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
					for(int j=0; j<individualRels.size(); j++)
					{
						individualInstanceList[j] = individualRels[j].individual1
					}

					def sevakOfRelation = Relation.findByName("Sevak of")
					patronCareSevaks = Relationship.findAllWhere(individual2:individual, relation:sevakOfRelation, status:"ACTIVE").individual1		
					for(int j=0; j<patronCareSevaks.size(); j++)
					{
						individualRels = Relationship.findAllWhere(individual2:patronCareSevaks[j], relation:cultivatedByRelation, status:"ACTIVE")
						for(int k=0; k<individualRels.size(); k++)
						{
							println 'k='+k
							println 'individualRels[k]='+individualRels[k]
							println 'individualRels[k].individual1='+individualRels[k].individual1
							individualInstanceList.add(individualRels[k].individual1)
						}
					}
				}
				if(pcRole[i].toString() == "PatronCareSevak")
				{
					individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
					for(int j=0; j<individualRels.size(); j++)
					{
						individualInstanceList[j] = individualRels[j].individual1
					}
				}			
			}

			individualInstanceList = individualInstanceList.unique()
			
			if(params.selIndex == "0")
			{
				  def now = new Date()
				  //def mAnnList = Donation.findAllByCollectedBy(Individual.get(session.individualid))


				  def j = 0, mAnnMonthOfDonor, mAnnDateOfDonor
				  for(int i=0;i<individualInstanceList.size();i++)
				  {
					  if(individualInstanceList[i].marriageAnniversary)
					  {
						  mAnnMonthOfDonor = ((individualInstanceList[i].marriageAnniversary).month).toInteger()
						  mAnnDateOfDonor = (individualInstanceList[i].marriageAnniversary).getDate()
						if (mAnnMonthOfDonor == now.month && mAnnDateOfDonor == now.getDate())
						{
							mAnnList[j] = individualInstanceList[i]
							j++
						}
					  }
				  }
				  mAnniversaryList = mAnniversaryList.unique()
				  //return [mAnniversaryList: mAnniversaryList, selIndex:params.selIndex]
			}
			else if(params.selIndex == "1")
			{
				  def now = new Date()
				  def tomorrowsDate = now.next()
				  //def mAnnList = Donation.findAllByCollectedBy(Individual.get(session.individualid))


				  def j = 0, mAnnMonthOfDonor, mAnnDateOfDonor
				  for(int i=0;i<individualInstanceList.size();i++)
				  {
					  if(individualInstanceList[i].marriageAnniversary)
					  {
						  mAnnMonthOfDonor = ((individualInstanceList[i].marriageAnniversary).month).toInteger()
						  mAnnDateOfDonor = (individualInstanceList[i].marriageAnniversary).getDate()
						if (mAnnMonthOfDonor == tomorrowsDate.month && mAnnDateOfDonor == tomorrowsDate.getDate())
						{
							mAnnList[j] = individualInstanceList[i]
							j++
						}
					  }
				  }
				  mAnniversaryList = mAnniversaryList.unique()
				  //return [mAnniversaryList: mAnniversaryList, selIndex:params.selIndex]
			}
			
			else
			{
				  //def mAnnList = Donation.findAllByCollectedBy(Individual.get(session.individualid))
				  def j = 0, mAnnMonthOfDonor
				  for(int i=0;i<individualInstanceList.size();i++)
				  {
					  if(individualInstanceList[i].marriageAnniversary)
					  {
						mAnnMonthOfDonor = (((individualInstanceList[i].marriageAnniversary).month).toInteger()+(1*1).toInteger())*1
						
						if (mAnnMonthOfDonor == ((params.selIndex).toInteger() - 1))
						{
							mAnniversaryList[j] = individualInstanceList[i]
							j++
						}
					}
				  }
				  mAnniversaryList = mAnniversaryList.unique()
				  mAnniversaryList = mAnniversaryList.sort{it.marriageAnniversary}
				  //return [mAnniversaryList: mAnniversaryList, selIndex:params.selIndex]
			}

			//[individualInstanceList: individualInstanceList, individualInstanceTotal: individualInstanceList.size()]		
		}
		

		return [mAnniversaryList: mAnniversaryList, selIndex:params.selIndex]
	}
	
    def councellorReport = {
     	//println "Inside councellorReport! Params: "+ params + "RANI:"+ params.acCouncellor
    		if(!params.acCouncellor)
    			return

	   def sql = new Sql(dataSource);


	   def queryIClee = "select distinct iclee.id from individual iclee , relation r, relationship rship, individual iclor where iclor.id="+params.acCouncellor_id+ " and iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and iclee.id=rship.individual1_id order by iclee.legal_name"
	   def cList = sql.rows(queryIClee)
	   def isList = ''
	   def iList = []
	   cList.each { i ->
	     isList += i.id + ","
	     iList.add(i.id)
	   }
	  def l = isList.length()
	  if(l>0)
	  	isList = isList.substring(0,l-1)

	   def queryAmt = "select donated_by_id did,sum(amount) amt from donation where status is null or status != 'BOUNCED' group by donated_by_id having donated_by_id in ("+isList +")"
	   def aList = sql.rows(queryAmt)

	
	   def aMap = [:]
	   def totalIndividualAmt = 0
	   aList.each { i ->
	     aMap[i.did] = i.amt
	     totalIndividualAmt += i.amt
	   }

	   def queryIClor = "select distinct iclor.id id from individual iclor , role r, individual_role ir where ir.individual_id = iclor.id and ir.role_id=r.id and r.name='Collector' and iclor.id in ("+isList +")"
	   def iclorList = sql.rows(queryIClor)

	   def cMap = [:]
	   iclorList.each { i ->
	     cMap[i.id] = 'Yes'
	   }

	   def queryCAmt = "select collected_by_id cid,sum(amount) amt from donation where status is null or status != 'BOUNCED'  group by collected_by_id having collected_by_id in ("+isList +")"
	   def caList = sql.rows(queryCAmt)

	   def cAmtMap = [:]
	   def totalCollectionAmt = 0
	   caList.each { i ->
	     cAmtMap[i.cid] = i.amt
	     totalCollectionAmt += i.amt
	   }
	   sql.close()
	return [amount: params.amount, criteria: params.criteria, councellorId: params.acCouncellor_id, councellorName: Individual.get(params.acCouncellor_id), individualList: Individual.getAll(iList), amountMap : aMap, collectorMap: cMap, collectionMap: cAmtMap, totalIndividualAmt: totalIndividualAmt, totalCollectionAmt: totalCollectionAmt]
	}

    def councellorViewReport = {
     	println "Inside councellorReport! Params: "+ params + "RANI:"+ params.acCouncellor
    		if(!params.acCouncellor)
    			return

	   def sql = new Sql(dataSource);


	   def queryIClee = "select distinct iclee.id from individual iclee , relation r, relationship rship, individual iclor where iclor.id="+params.acCouncellor_id+ " and iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and iclee.id=rship.individual1_id order by iclee.legal_name"
	   def cList = sql.rows(queryIClee)
	   def isList = ''
	   def iList = []
	   cList.each { i ->
	     isList += i.id + ","
	     iList.add(i.id)
	   }
	  def l = isList.length()
	  if(l>0)
	  	isList = isList.substring(0,l-1)

	   def queryAmt = "select donated_by_id did,sum(amount) amt from donation where status is null or status != 'BOUNCED' group by donated_by_id having donated_by_id in ("+isList +")"
	   def aList = sql.rows(queryAmt)

	
	   def aMap = [:]
	   def totalIndividualAmt = 0
	   aList.each { i ->
	     aMap[i.did] = i.amt
	     totalIndividualAmt += i.amt
	   }

	   def queryIClor = "select distinct iclor.id id from individual iclor , role r, individual_role ir where ir.individual_id = iclor.id and ir.role_id=r.id and r.name='Collector'  and iclor.id in ("+isList +")"
	   def iclorList = sql.rows(queryIClor)

	   def cMap = [:]
	   iclorList.each { i ->
	     cMap[i.id] = 'Yes'
	   }

	   //def queryCAmt = "select collected_by_id cid,sum(amount) amt from donation  where status is null or status != 'BOUNCED' group by collected_by_id having collected_by_id in ("+isList +")"
	   def queryCAmt = "select collected_by_id cid,sum(amount) amt from donation where (status is null or status != 'BOUNCED') and collected_by_id <> donated_by_id group by collected_by_id having collected_by_id in ("+isList +")"
	   def caList = sql.rows(queryCAmt)

	   def cAmtMap = [:]
	   def totalCollectionAmt = 0
	   caList.each { i ->
	     cAmtMap[i.cid] = i.amt
	     totalCollectionAmt += i.amt
	   }

	   sql.close()
	   
	   	println   'caList='+caList
	   	println   'aList='+aList
	   	
	return [amount: params.amount, criteria: params.criteria, councellorId: params.acCouncellor_id, councellorName: Individual.get(params.acCouncellor_id), individualList: Individual.getAll(iList), amountMap : aMap, collectorMap: cMap, collectionMap: cAmtMap, totalIndividualAmt: totalIndividualAmt, totalCollectionAmt: totalCollectionAmt]
	}

	def allCouncellorReport = {
	}
	
	
	def allCouncellorViewReport = {
		  // println "Inside allCouncellorReport! Params: "+ params + "RANI:"+ params.acCouncellor

		println '------allCouncellorViewReport'
		def fd, td
		def sql = new Sql(dataSource)
		if(params.fromDate)
		{
			fd = Date.parse('dd-MM-yyyy', params.fromDate)
			fd.clearTime()
		}
		else
		{
			//fd = new Date().previous()
			def queryFromDate = "SELECT min(fund_receipt_date) fd FROM donation"
			fd = sql.firstRow(queryFromDate).fd
			//fd = new Date()
		}

		println "fd="+fd

		if(params.toDate)
			td = Date.parse('dd-MM-yyyy', params.toDate)
		else
			td = new Date()
		//td = td.next()
		td.clearTime()
		println "td="+td
		
		
		def cQuery = "select iclor.id councellor_id, iclor.initiated_name councellor_name, iclee.id councellee_id, iclee.legal_name councellee_legal_name, iclee.initiated_name councellee_initiated_name, amount collection, fund_receipt_date submissionDate from individual iclee ,donation d, relation r, relationship rship, individual iclor where  iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and rship.status='ACTIVE' and iclee.id=rship.individual1_id and d.collected_by_id=iclee.id and fund_receipt_date>='"+String.format('%tF',fd)+"' and fund_receipt_date<='"+String.format('%tF',td)+"' order by iclor.initiated_name,iclee.legal_name"
		println 'cQuery='+cQuery
		def cList = sql.rows(cQuery)
		println 'cList='+cList

		return [cList: cList, fd:fd, td:td]

	}

    def datewiseCouncellorReport = {
    }

    def datewiseCouncellorViewReport = {
     	println "Inside datewiseCouncellorViewReport! Params: "+ params + "RANI:"+ params.acCouncellor
    	if(!params.acCouncellor)
    		return
    	
    	def fd, td
    	def sql = new Sql(dataSource);
    	
    	if(params.fromDate)
    	{
    		fd = Date.parse('dd-MM-yyyy', params.fromDate)
    		fd.clearTime()
    	}
    	else
    	{
    		//fd = new Date().previous()
    		def queryFromDate = "SELECT min(fund_receipt_date) fd FROM donation"
    		fd = sql.firstRow(queryFromDate).fd
    		//fd = new Date()
    	}
    	
    	println "fd="+fd
    	
    	if(params.toDate)
    		td = Date.parse('dd-MM-yyyy', params.toDate)
    	else
    		td = new Date()
    	//td = td.next()
    	td.clearTime()
	println "td="+td

	   


	   def queryIClee = "select distinct iclee.id from individual iclee , relation r, relationship rship, individual iclor where iclor.id="+params.acCouncellor_id+ " and iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and rship.status='ACTIVE' and iclee.id=rship.individual1_id order by iclee.legal_name"
	   def cList = sql.rows(queryIClee)
	   def isList = ''
	   def iList = []
	   cList.each { i ->
	     isList += i.id + ","
	     iList.add(i.id)
	   }
	  def l = isList.length()
	  if(l>0)
	  	isList = isList.substring(0,l-1)

	   def queryAmt = "select donated_by_id did,sum(amount) amt from donation where (status is null or status != 'BOUNCED') and fund_receipt_date>='"+String.format('%tF',fd)+"' and fund_receipt_date<='"+String.format('%tF',td)+"' group by donated_by_id having donated_by_id in ("+isList +")"
	   def aList = sql.rows(queryAmt)

	
	   def aMap = [:]
	   def totalIndividualAmt = 0
	   aList.each { i ->
	     aMap[i.did] = i.amt
	     totalIndividualAmt += i.amt
	   }

	   def queryIClor = "select distinct iclor.id id from individual iclor , role r, individual_role ir where ir.individual_id = iclor.id and ir.role_id=r.id and r.name='Collector' and iclor.id in ("+isList +")"
	   def iclorList = sql.rows(queryIClor)

	   def cMap = [:]
	   iclorList.each { i ->
	     cMap[i.id] = 'Yes'
	   }

	   def queryCAmt = "select collected_by_id cid,sum(amount) amt from donation where (status is null or status != 'BOUNCED') and fund_receipt_date>='"+String.format('%tF',fd)+"' and fund_receipt_date<='"+String.format('%tF',td)+"' and collected_by_id <> donated_by_id group by collected_by_id having collected_by_id in ("+isList +")"
	   def caList = sql.rows(queryCAmt)

	   def cAmtMap = [:]
	   def totalCollectionAmt = 0
	   caList.each { i ->
	     cAmtMap[i.cid] = i.amt
	     totalCollectionAmt += i.amt
	   }

	   sql.close()
	   
	   	   
	return [amount: params.amount, criteria: params.criteria, councellorId: params.acCouncellor_id, councellorName: Individual.get(params.acCouncellor_id), individualList: Individual.getAll(iList), amountMap : aMap, collectorMap: cMap, collectionMap: cAmtMap, totalIndividualAmt: totalIndividualAmt, totalCollectionAmt: totalCollectionAmt, fd:fd, td:td]
	}
	
     def allCouncellorsViewReport = {
	def role = Role.findByName("Councellor")
	def c = Individual.createCriteria()
	def collectors = c.list
	{

		individualRoles
		{
			and
			{
				eq("role",role)
				eq("status", "VALID")
			}
		}
		order("initiatedName", "asc")
		order("legalName", "asc")
	}
        response.setHeader("Cache-Control", "no-store")

        def results = collectors.collect {
            [  id: it.id,
               name: it.toString() ]
        }
     	println "results:"+results
     	for(int i=0; i<results.size(); i++)
     	{
     		//println "results:"+(((Individual.get(results[i]?.id))?.individualRoles)?.role)?.name
     		println "results:"+(Individual.get(results[i]?.id))?.relative1?.relation?.name
     		println "status:"+(Individual.get(results[i]?.id))?.relative1?.status
     		println "size:"+(Individual.get(results[i]?.id))?.relative1?.relation.size()
     		println "name:"+((Individual.get(results[i]?.id))?.relative1?.relation)[0]?.name
     		println "ind2:"+((Individual.get(results[i]?.id))?.relative1)[0]?.individual2
     	}
     }
     
     def collectorReport = {
    		if(!params.acCollector)
    			return
    	
    	def collector = Individual.get(params.acCollector_id)
    	if(!collector)
    		return
    		
    		//def donationList = Donation.findAllByCollectedByAndStatusIsNull(collector, [sort:"donatedBy", order:"asc"])
    		def donationList = Donation.findAllByCollectedBy(collector, [sort:"donatedBy", order:"asc"])
    		

	return [collector: collector, donationList: donationList]
	}
	
     def collectorViewReport = {
    		if(!params.acCollector)
    			return
    	
    	def collector = Individual.get(params.acCollector_id)
    	if(!collector)
    		return
    		
    	def fd='',td=''
    	
    	
    	if(params.fromDate)
    	{
    		fd = Date.parse('dd-MM-yyyy', params.fromDate)
    		fd.clearTime()
    	}
    	else
    	{
    		def sql = new Sql(dataSource);
    		//fd = new Date().previous()
    		def queryFromDate = "SELECT min(fund_receipt_date) fd FROM donation"
    		fd = sql.firstRow(queryFromDate).fd
    		sql.close()
    		//fd = new Date()
    	}
    	
    	println "fd="+fd
    	
	
    	if(params.toDate)
    		td = Date.parse('dd-MM-yyyy', params.toDate)
    	else
    		td = new Date()
    	//td = td.next()
    	td.clearTime()
    		
    	println "between:"+fd+"<=>"+td

    		//def donationList = Donation.findAllByCollectedByAndStatusIsNull(collector, [sort:"donatedBy", order:"asc"])
    		def donationList = Donation.findAllByCollectedByAndFundReceiptDateBetween(collector, fd , td, [sort:"fundReceiptDate", order:"asc"])
	//FundReceiptDateBetween(fd , td, [sort:"fundReceiptDate", order:"asc"])

	return [collector: collector, donationList: donationList]
	}

     def collectorwiseDonorsReport = {
     println "---------------"+params
    		if(!params.acCollector)
    			return
    	
    	def collector = Individual.get(params.acCollector_id)
    	if(!collector)
    		return
    		
    		//def donationList = Donation.findAllByCollectedByAndStatusIsNull(collector, [sort:"donatedBy", order:"asc"])
    		def donationList = Donation.findAllByCollectedBy(collector, [sort:"donatedBy", order:"asc"])
    		
	
	return [acCollector:params.acCollector, acCollector_id:params.acCollector_id, collector: collector, donationList: donationList]
	}
	
     def collectorwiseDonorsViewReport = {
	     println "########################"+params
	     println "params.acCollector:"+params.acCollector
	     println "params.acCollector_id:"+params.acCollector_id
    		if(!params.acCollector)
    			return
    	
    	def collector = Individual.get(params.acCollector_id)
    	if(!collector)
    		return
    		
    	println "---collector="+collector
    	
    	
		//def donationList = Donation.findAllByCollectedByAndStatusIsNull(collector, [sort:"donatedBy", order:"asc"])
		//def donationList = Donation.findAllByCollectedByAndStatusIsNull(collector, [sort:"donatedBy", order:"asc"]).donatedBy
		def donationList = Donation.findAllByCollectedBy(collector, [sort:"donatedBy", order:"asc"]).donatedBy
		def sql = new Sql(dataSource)
		def donorQry = "select i.id, i.legal_name, i.initiated_name, sum(d.amount) amt from individual i ,donation d where d.collected_by_id='"+ params.acCollector_id +"' and i.id=d.donated_by_id group by i.legal_name"
		//"select distinct i.id, i.legal_name, i.initiated_name, i.address  from individual i ,donation d where d.collected_by_id=315 and i.id=d.donated_by_id"    		
		def donors = sql.rows(donorQry)
		//println "donors="+donors
		
		println "-------------------------------------"
		def Indv = []
		def indvDonations = []
		def otherCollectors = []
		def otherCollectorsList = []
		def collectorsQry = []
		//def addFlg
		for(int i=0; i<donors.size(); i++)
		{
			Indv.add(Individual.get(donors[i].id))
			if(Indv[i].legalName != "Dummy Donor for daily transactions" && Indv[i].legalName != "Hundi Collection")
				indvDonations[i] = (Donation.findAllByDonatedBy(Indv[i]))
			else
				indvDonations[i] = ""
			//println "---indvDonations[i]="+indvDonations[i]
		}
		//println "---Indv="+Indv
		//println "---indvDonations="+indvDonations
		
		for(int i=0; i<indvDonations.size(); i++)
		{
			
			for(int j=0; j<indvDonations[i].size(); j++)
			{//addFlg = 1
				//if(Indv[i].toString() != "Dummy Donor for daily transactions")
				
				if(indvDonations[i] != "" && indvDonations[i][j].collectedBy != collector)
					otherCollectors.add(indvDonations[i][j].collectedBy)
				else
					otherCollectors.add("")
			}
			otherCollectors = otherCollectors.unique()
			otherCollectorsList.add(otherCollectors)
			otherCollectors = []
		}
			
			println "---otherCollectorsList="+otherCollectorsList
			
		sql.close()
		//otherCollectors = otherCollectors.replace(",","<br>")
		

		return [acCollector:params.acCollector, acCollector_id:params.acCollector_id, collector: collector, donationList: donationList, donors:donors, Indv:Indv, otherCollectors:otherCollectors, otherCollectorsList:otherCollectorsList]
	}
     def allCollectionsReport = {

     }

     def allCollectionsViewReport = {
     	def fd='',td=''
    	if(params.fromDate)
    	{
    		fd = Date.parse('dd-MM-yyyy', params.fromDate)
    		fd.clearTime()
    	}
    	else
    	{
    		def sql = new Sql(dataSource);
    		//fd = new Date().previous()
    		def queryFromDate = "SELECT min(fund_receipt_date) fd FROM donation"
    		fd = sql.firstRow(queryFromDate).fd
    		sql.close()
    		//fd = new Date()
    	}
    	
    	println "fd="+fd
    	
	
    	if(params.toDate)
    		td = Date.parse('dd-MM-yyyy', params.toDate)
    	else
    		td = new Date()
    	//td = td.next()
    	td.clearTime()
    		
    	println "between:"+fd+"<=>"+td     
     	def sql = new Sql(dataSource);

     	//def collectionsQuery = "select d.collected_by_id, i.legal_name, i.initiated_name, group_concat(distinct(v.number)) as number, sum(amount) as amt from donation d,individual i, voice_contact v where i.id=d.collected_by_id and i.id=v.individual_id and d.collected_by_id <> d.donated_by_id group by d.collected_by_id"
     	def collectionsQuery = "select d.collected_by_id , q2.legal_name, q2.initiated_name, q2.number, sum(d.amount) as amt from donation d, ( select i.id, i.legal_name, i.initiated_name, group_concat(distinct(v.number)) as number from individual i, voice_contact v where i.id=v.individual_id and i.id in (select distinct (collected_by_id) from donation) group by i.legal_name) as q2 where q2.id=d.collected_by_id and d.collected_by_id<>d.donated_by_id and d.fund_receipt_date>='"+String.format('%tF',fd)+"' and d.fund_receipt_date<='"+String.format('%tF',td)+"' group by d.collected_by_id order by q2.legal_name"
     	def collectionsResult = sql.rows(collectionsQuery)
     	sql.close()
     	println "collectionsResult="+collectionsResult
     	
     	return [collectionsResult: collectionsResult, fd:fd, td:td]
     }
     
     def allCouncellorsCouncelleesSummaryReport = {
     }
     
     def allCouncellorsCouncelleesSummaryViewReport = {
     	def fd='',td=''
    	if(params.fromDate)
    	{
    		fd = Date.parse('dd-MM-yyyy', params.fromDate)
    		fd.clearTime()
    	}
    	else
    	{
    		def sql = new Sql(dataSource);
    		//fd = new Date().previous()
    		def queryFromDate = "SELECT min(fund_receipt_date) fd FROM donation"
    		fd = sql.firstRow(queryFromDate).fd
    		sql.close()
    		//fd = new Date()
    	}
    	
    	if(params.toDate)
    		td = Date.parse('dd-MM-yyyy', params.toDate)
    	else
    		td = new Date()
    	td.clearTime()
    		def sql = new Sql(dataSource);
    		
    		def query = "select * from (select * from (select iclor.id councellor_id1, iclor.initiated_name councellor_name1, iclee.id councellee_id1, iclee.legal_name councellee_legal_name1, iclee.initiated_name councellee_initiated_name1, sum(amount) collection from individual iclee ,donation d, relation r, relationship rship, individual iclor where  iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and rship.status='ACTIVE' and iclee.id=rship.individual1_id and d.collected_by_id=iclee.id and d.collected_by_id<>d.donated_by_id and d.donated_by_id not in (select distinct d.donated_by_id from individual iclee ,donation d, relation r, relationship rship, individual iclor where  iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and rship.status='ACTIVE' and iclee.id=rship.individual1_id and d.donated_by_id=iclee.id and d.donated_by_id<>d.collected_by_id and d.fund_receipt_date>='"+String.format('%tF',fd)+"' and d.fund_receipt_date<='"+String.format('%tF',td)+"') and d.fund_receipt_date>='"+String.format('%tF',fd)+"' and d.fund_receipt_date<='"+String.format('%tF',td)+"' group by  iclee.legal_name order by iclor.initiated_name,iclee.legal_name) q1 left join (select iclor.id councellor_id2, iclor.initiated_name councellor_name2, iclee.id councellee_id2, iclee.legal_name councellee_legal_name2, iclee.initiated_name councellee_initiated_name2, sum(amount) donation from individual iclee ,donation d, relation r, relationship rship, individual iclor where  iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and rship.status='ACTIVE' and iclee.id=rship.individual1_id and d.donated_by_id=iclee.id and d.fund_receipt_date>='"+String.format('%tF',fd)+"' and d.fund_receipt_date<='"+String.format('%tF',td)+"'  group by  iclee.legal_name order by iclor.initiated_name,iclee.legal_name) q2 on q1.councellee_legal_name1=q2.councellee_legal_name2) q3 left join (select iclor.id councellor_id1, iclor.initiated_name councellor_name, iclee.id councellee_id, iclee.legal_name councellee_legal_name, iclee.initiated_name councellee_initiated_name, sum(amount) loanAmount from individual iclee ,loan l, relation r, relationship rship, individual iclor where  iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and rship.status='ACTIVE' and iclee.id=rship.individual1_id and l.loaned_by_id=iclee.id  and l.loan_date>='"+String.format('%tF',fd)+"' and l.loan_date<='"+String.format('%tF',td)+"' group by  iclee.legal_name order by iclor.initiated_name,iclee.legal_name) q4 on q3.councellee_legal_name1=q4.councellee_legal_name"
    		
    		/*** new logic
    		def donor_collectorid_query = "select c.name AS donor,c.counsellor AS donors_counsellor,d.collected_by_id AS collectorid,round(sum(d.amount)) AS donation from (donation d join individual_counsellor_view c) where ((d.donated_by_id = c.id) and (d.fund_receipt_date >= '"+String.format('%tF',fd)+"') and (d.fund_receipt_date <= '"+String.format('%tF',td)+"')) group by c.name,c.counsellor,d.collected_by_id"
    		
    		def query = "select i.id AS id,d.donor AS donor,d.donors_counsellor AS donors_counsellor,d.donation AS donation,if(isnull(d.donors_counsellor),i.name,d.donor) AS collector,ifnull(d.donors_counsellor,i.counsellor) AS collectors_counsellor from (("+donor_collectorid_query+") d join individual_counsellor_view i) where (d.collectorid = i.id);"
    		****/
    		
    		//def queryResult = sql.rows(query)
    		def queryResult
    		sql.close()
     		return [queryResult: queryResult, fd:fd, td:td]
     }

     def xlsallCouncellorsCouncelleesSummaryViewReport = {
     	def fd='',td=''
    	if(params.fromDate)
    	{
    		fd = Date.parse('dd-MM-yyyy', params.fromDate)
    		fd.clearTime()
    	}
    	else
    	{
    		def sql = new Sql(dataSource);
    		//fd = new Date().previous()
    		def queryFromDate = "SELECT min(fund_receipt_date) fd FROM donation"
    		fd = sql.firstRow(queryFromDate).fd
    		sql.close()
    		//fd = new Date()
    	}
    	
    	if(params.toDate)
    		td = Date.parse('dd-MM-yyyy', params.toDate)
    	else
    		td = new Date()
    	td.clearTime()

	if(params?.format && params.format != "html"){
		response.contentType = grailsApplication.config.grails.mime.types[params.format]
		String fileName = "CounsellorCounselleeCollectionReport.${params.extension}"
		response.setHeader("Content-disposition", "attachment; filename="+fileName)
		//List fields = ["id","fundReceiptDate","nvccReceiptBookNo","nvccReceiptNo","donationDate","amount","donatedBy.id","donatedBy.legalName","donatedBy.initiatedName","donorName","donorAddress","donorContact","donorEmail","collectedBy.id","collectedBy.legalName","collectedBy.initiatedName"]
		List fields = ["id","fundReceiptDate","nvccReceiptBookNo","nvccReceiptNo","donationDate","amount","donorId","systemdonorName","donorCounsellor","donorName","donorAddress","donorContact","donorEmail","collectedById","collectedByName","collectedByCounsellorName"]
		Map labels = [:]
		exportService.export(params.format, response.outputStream, dataService.counsellorCounselleeCollectionData(fd,td), fields, labels, [:], [:])
	}	

     }
     
     def jq_collection_list() {
     }
     
     def nvccSevakReport = {
     	
     }

     def nvccSevakViewReport = {
     	def fd='',td=''
    	if(params.fromDate)
    	{
    		fd = Date.parse('dd-MM-yyyy', params.fromDate)
    		fd.clearTime()
    	}
    	else
    	{
    		def sql = new Sql(dataSource);
    		//fd = new Date().previous()
    		def queryFromDate = "SELECT min(fund_receipt_date) fd FROM donation"
    		fd = sql.firstRow(queryFromDate).fd
    		sql.close()
    		//fd = new Date()
    	}
    	
    	println "fd="+fd
    	
	
    	if(params.toDate)
    		td = Date.parse('dd-MM-yyyy', params.toDate)
    	else
    		td = new Date()
    	//td = td.next()
    	td.clearTime()
    		
    	println "between:"+fd+"<=>"+td     
    	def queryResult, collectionQueryResult=[], donationQueryResult=[], advanceDonationQueryResult=[]
    		def sql = new Sql(dataSource);
    		def commitmentQuery = "select iclor.id councellorid, iclor.initiated_name councellorname, iclee.id councelleeid, iclee.legal_name councellee_legal_name, iclee.initiated_name councellee_initiated_name, committed_amount, commitment_on, commitment_till  from commitment c, individual iclee ,relation r, relationship rship, individual iclor where  iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and rship.status='ACTIVE' and iclee.id=rship.individual1_id and c.committed_by_id=iclee.id"
    		def commitmentQueryResult = sql.rows(commitmentQuery)
    		println "commitmentQueryResult"+commitmentQueryResult
    		
    		for(int i=0; i<commitmentQueryResult.size(); i++)
    		{
    			collectionQueryResult.add(sql.firstRow("select sum(amount) as Collection from donation where collected_by_id='"+commitmentQueryResult[i].councelleeid+"' and collected_by_id<>donated_by_id  and fund_receipt_date>='"+String.format('%tF',fd)+"' and fund_receipt_date<='"+String.format('%tF',td)+"'")) //Donation.findAll("from Donation where collected_by_id='"+commitmentQueryResult[i].councelleeid+"' and collected_by_id<>donated_by_id  and fund_receipt_date>='"+String.format('%tF',fd)+"' and fund_receipt_date<='"+String.format('%tF',td)+"'")
    			donationQueryResult.add(sql.firstRow("select sum(amount) as Donation from donation where donated_by_id='"+commitmentQueryResult[i].councelleeid+"' and fund_receipt_date>='"+String.format('%tF',fd)+"' and fund_receipt_date<='"+String.format('%tF',td)+"'"))
    			advanceDonationQueryResult.add(sql.firstRow("select sum(amount) as AdvanceDonation from loan where loaned_by_id='"+commitmentQueryResult[i].councelleeid+"' and loan_date>='"+String.format('%tF',fd)+"' and loan_date<='"+String.format('%tF',td)+"'"))
    		}
    		println "collectionQueryResult"+collectionQueryResult
    		println "collectionQueryResult.size()"+collectionQueryResult.size()
    		//def queryResult = sql.rows(query)
    		sql.close()
     		return [commitmentQueryResult: commitmentQueryResult, collectionQueryResult:collectionQueryResult, donationQueryResult:donationQueryResult, advanceDonationQueryResult:advanceDonationQueryResult, fd:fd, td:td]
     	
     }

     def commitmentReport = {
     	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_COUNSELLOR'))
     		{
     			forward action: "commitmentViewReport", params: [clorid: session.individualid]
     			return
     		}
     	
     }

     def commitmentViewReport = {
    	if (!params.fromDate)
    		params.fromDate =  new Date() - 11*30
    	return reportService.commitmentSummary(params)   	
     }

     def donationReport = {
     	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_COUNSELLOR'))
     		{
     			forward action: "donationViewReport", params: [clorid: session.individualid]
     			return
     		}
     	
     }

     def donationViewReport = {
    	return reportService.donationSummary(params)   	
     }


     def cultivatorReport = {
    		if(!params.acCultivator)
    			return
    	
    	def cultivator = Individual.get(params.acCultivator_id)
    	if(!cultivator)
    		return
    		
    	def cultRel = Relation.findByName("Cultivated By")
    	
    	def relationships = Relationship.findAllByIndividual2AndRelation(cultivator,cultRel, [sort:"individual1", order:"asc"])
    	
    	
    		def individualList = []
    		
	   relationships.each { i ->
	     individualList.add(i.individual1)
	   }
	   
	 def donationMap = [:]
	 def amountMap = [:]
	 def amt = 0
	 def sum = 0
	 individualList.each { i ->
	 //donationMap[i.id] = Donation.findAllByDonatedByAndStatusIsNull(i, [sort:"donationDate", order:"asc"])
	 donationMap[i.id] = Donation.findAllByDonatedBy(i, [sort:"donationDate", order:"asc"])
	 amt = 0
	 donationMap[i.id].each { j ->
	 	amt += j.amount
	 	sum += amt
	 	}
	 amountMap[i.id] = amt
	 }
    		

	return [cultivator: cultivator, individualList: individualList, donationMap : donationMap, amountMap: amountMap, sum: sum]
	}


     def cultivatorViewReport = {
    		if(!params.acCultivator)
    			return
    	
    	def cultivator = Individual.get(params.acCultivator_id)
    	if(!cultivator)
    		return
    		
    	def cultRel = Relation.findByName("Cultivated By")
    	
    	def relationships = Relationship.findAllByIndividual2AndRelation(cultivator,cultRel, [sort:"individual1", order:"asc"])
    	
    	
    		def individualList = []
    		
	   relationships.each { i ->
	     individualList.add(i.individual1)
	   }
	   
	 def donationMap = [:]
	 def amountMap = [:]
	 def amt = 0
	 def sum = 0
	 individualList.each { i ->
	 //donationMap[i.id] = Donation.findAllByDonatedByAndStatusIsNull(i, [sort:"donationDate", order:"asc"])
	 donationMap[i.id] = Donation.findAllByDonatedBy(i, [sort:"donationDate", order:"asc"])
	 amt = 0
	 donationMap[i.id].each { j ->
	 	amt += j.amount
	 	sum += amt
	 	}
	 amountMap[i.id] = amt
	 }
    		

	return [cultivator: cultivator, individualList: individualList, donationMap : donationMap, amountMap: amountMap, sum: sum]
	}



     def schemeReport = {
    		if(!params.schemeid && !params.category)
    			{
			//find the department of the logged in user
			def department = null
			def ir
			if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
				def donationRole = Role.findByAuthority('ROLE_DONATION_EXECUTIVE')
				log.debug("In schemeReport: donationRole:"+donationRole)
				if(donationRole)
					ir = IndividualRole.findWhere('individual.id':session.individualid,role:donationRole,status:'VALID')
				if(ir)
					{
					department = ir.department
					}
				}    
			log.debug("In schemeReport: department:"+department)
    			return [department:department]
    			}
    	
    	def scheme = Scheme.get(params.schemeid)
    	def donationList
    	if (params.schemeid && params.category)
    		donationList = Donation.findAllBySchemeAndCategory(scheme,params.category, [sort:"donationDate", order:"desc"])
    	else if (params.schemeid && !params.category)
    		donationList = Donation.findAllByScheme(scheme, [sort:"donationDate", order:"desc"])
    	else
    		donationList = Donation.findAllByCategory(params.category, [sort:"donationDate", order:"desc"])
    		
    	//remove bounced donations
    	def tlist = []
    	donationList.each{d ->
    	if(d.status != 'BOUNCED')
    		tlist.add(d)
    	}
    	donationList = tlist

	return [schemeid: params.schemeid, category: params.category, donationList: donationList]
	}


     def schemeViewReport = {
	if(!params.schemeid && !params.category)
		return
    	
    	def scheme = Scheme.get(params.schemeid)
    	
    	
    	def sql = new Sql(dataSource);
    	
    	def donationsQry
    	def donationList
    	if (params.schemeid && params.category)
    		donationsQry = "select i.id,sum(d.amount) amt,s.name sname, group_concat(concat('<br>',nvcc_receipt_book_no,'/',nvcc_receipt_no,'/',cast(amount as char(12)),'/',Day(donation_date),'-',Month(donation_date),'-',Year(donation_date),'/',Day(fund_receipt_date),'-',Month(fund_receipt_date),'-',Year(fund_receipt_date))) details from donation d, individual i, scheme s where d.donated_by_id=i.id and d.scheme_id=s.id and d.scheme_id="+params.schemeid+" and d.category='"+params.category+"' and (d.status is null or d.status != 'BOUNCED') group by i.id"
    		//donationList = Donation.findAllBySchemeAndCategory(scheme,params.category, [sort:"donationDate", order:"desc"])
    	else if (params.schemeid && !params.category)
    		donationsQry = "select i.id,sum(d.amount) amt,s.name sname, group_concat(concat('<br>',nvcc_receipt_book_no,'/',nvcc_receipt_no,'/',cast(amount as char(12)),'/',Day(donation_date),'-',Month(donation_date),'-',Year(donation_date),'/',Day(fund_receipt_date),'-',Month(fund_receipt_date),'-',Year(fund_receipt_date))) details from donation d, individual i, scheme s where d.donated_by_id=i.id and d.scheme_id=s.id and d.scheme_id="+params.schemeid+" and (d.status is null or d.status != 'BOUNCED') group by i.id"
    		//donationList = Donation.findAllByScheme(scheme, [sort:"donationDate", order:"desc"])
    	else
    		donationsQry = "select i.id,sum(d.amount) amt, group_concat(concat('<br>',nvcc_receipt_book_no,'/',nvcc_receipt_no,'/',cast(amount as char(12)),'/',Day(donation_date),'-',Month(donation_date),'-',Year(donation_date),'/',Day(fund_receipt_date),'-',Month(fund_receipt_date),'-',Year(fund_receipt_date))) details from donation d, individual i, scheme s where d.donated_by_id=i.id and d.category='"+params.category+"' and (d.status is null or d.status != 'BOUNCED') group by i.id"
    		//donationList = Donation.findAllByCategory(params.category, [sort:"donationDate", order:"desc"])
    		
	
	println 'donationsQry='+donationsQry
	def uniqueDonations = sql.rows(donationsQry)
	println 'uniqueDonations='+uniqueDonations
	
    	//remove bounced donations
    	def tlist = []
    	donationList.each{d ->
    	if(d.status != 'BOUNCED')
    		tlist.add(d)
    	}
    	donationList = tlist
    	
    	println 'donationList='+donationList
    	println 'donationList.size()='+donationList.size()
    	
    	//PK's code
    	//def ilist = donationList.donatedBy.unique()
    	
	return [schemeid: params.schemeid, category: params.category, donationList: donationList, uniqueDonations:uniqueDonations]
    }

	def patronCareSchemeReport = {
	}
	
	def patronCareSchemeViewReport = {
    		if(!params.schemeid)
    			return
		def fd='',td=''
		if(params.fromDate)
		{
			fd = Date.parse('dd-MM-yyyy', params.fromDate)
			fd.clearTime()
		}
		else
		{
			def sql = new Sql(dataSource);
			//fd = new Date().previous()
			def queryFromDate = "SELECT min(fund_receipt_date) fd FROM donation"
			fd = sql.firstRow(queryFromDate).fd
			sql.close()
			//fd = new Date()
		}

		println "fd="+fd


		if(params.toDate)
			td = Date.parse('dd-MM-yyyy', params.toDate)
		else
			td = new Date()
		//td = td.next()
		td.clearTime()

		println "between:"+fd+"<=>"+td     

		def scheme = Scheme.get(params.schemeid)
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
		{
			
			def login = springSecurityService.principal.username
			println "Loggedin user: "+login
			def individual = Individual.findByLoginid(login)
			println "setSessionParams for: "+individual

			def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
			println 'pcRole='+pcRole
			def patronCareHead, patronCareSevaks = []
			def individualInstanceList = [], individualRels = []
			def cultivatedByRelation = Relation.findByName("Cultivated by")

			for(int i=0; i<pcRole.size(); i++)
			{
				if(pcRole[i].toString() == "PatronCare")
				{
					individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
					for(int j=0; j<individualRels.size(); j++)
					{
						individualInstanceList[j] = individualRels[j].individual1
					}

					def sevakOfRelation = Relation.findByName("Sevak of")
					patronCareSevaks = Relationship.findAllWhere(individual2:individual, relation:sevakOfRelation, status:"ACTIVE").individual1		
					for(int j=0; j<patronCareSevaks.size(); j++)
					{
						individualRels = Relationship.findAllWhere(individual2:patronCareSevaks[j], relation:cultivatedByRelation, status:"ACTIVE")
						for(int k=0; k<individualRels.size(); k++)
						{
							println 'k='+k
							println 'individualRels[k]='+individualRels[k]
							println 'individualRels[k].individual1='+individualRels[k].individual1
							individualInstanceList.add(individualRels[k].individual1)
						}
					}
				}
				if(pcRole[i].toString() == "PatronCareSevak")
				{
					individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
					for(int j=0; j<individualRels.size(); j++)
					{
						individualInstanceList[j] = individualRels[j].individual1
					}
				}			
			}

			individualInstanceList = individualInstanceList.unique()
			
			def donationsList = [], donationInstanceList = []

			for(int i=0; i<individualInstanceList.size(); i++)
			{
				//donationsList[i] = Donation.findAllByDonatedBy(individualInstanceList[i])
				donationsList[i] = Donation.findAllWhere(scheme:scheme, donatedBy:individualInstanceList[i])
				
				//println 'donationsList[i]='+donationsList[i]
				for(int j=0; j<donationsList[i].size(); j++)
				{
					if(donationsList[i][j].fundReceiptDate >= fd && donationsList[i][j].fundReceiptDate <= td)
						donationInstanceList.add(donationsList[i][j])
				}
				//println 'donationInstanceList='+donationInstanceList

			}
			donationInstanceList = donationInstanceList.sort{ it.fundReceiptDate }
			//def donationInstanceList = Donation.findAllByDonatedBy(individualInstanceList)
			[scheme:scheme, donationInstanceList: donationInstanceList, donationInstanceTotal: donationInstanceList.size(), fd:fd, td:td]
		}		
	}
	
    def patronCareAmountReport = {
    	println "amountreport: "+params
    
	if(!params.fromamount)
		return

	def cond = null
	   switch (params.fromcriteria) {
	      case "Equal to":
	          cond = '='
	          break
	      case "Less than":
	          cond = '<'
	          break
	      case "Less than or Equal to":
	          cond = "<="
	          break
	      case "Greater than":
	          cond = ">"
	          break
	      case "Greater than or Equal to":
	          cond = ">="
	          break
	      default:
	          cond = null
		}
		
	if (!cond || !params.fromamount?.isInteger())
		{
	            flash.message = "Please provide valid input!!"
	            return [fromamount:params.fromamount, fromcriteria:params.fromcriteria, toamount:params.toamount, tocriteria:params.tocriteria]
		}
		
	def tocond = null
	def validtoamt = false
	def optflag = false
	if(!params.toamount && !params.tocriteria)
		optflag = true
	if(params.toamount?.isInteger() && params.toamount.toInteger() > params.fromamount.toInteger())
	{
		validtoamt = true
	}
	if(validtoamt)
	{
	   switch (params.tocriteria) {
	      case "Equal to":
	          tocond = '='
	          break
	      case "Less than":
	          tocond = '<'
	          break
	      case "Less than or Equal to":
	          tocond = "<="
	          break
	      case "Greater than":
	          tocond = ">"
	          break
	      case "Greater than or Equal to":
	          tocond = ">="
	          break
	      default:
	          tocond = null
		}
	}
	
	if (!optflag && (!tocond || !validtoamt))
		{
	            flash.message = "Please provide valid input for To amount/criteria!!"
	            return [fromamount:params.fromamount, fromcriteria:params.fromcriteria, toamount:params.toamount, tocriteria:params.tocriteria]
		}


	   def sql = new Sql(dataSource);
	   def queryInd = "select donated_by_id did,amt from (select donated_by_id, sum(amount) amt from donation where (status is null or status != 'BOUNCED') and collected_by_id = "+session.individualid+" group by donated_by_id) d where d.amt "+cond+" "+params.fromamount
	   if(tocond)
	   	queryInd += " and d.amt "+tocond+" "+params.toamount
	   def dList = sql.rows(queryInd)
	   sql.close()
	   println "queryInd="+queryInd
	   
	   def iList = []
	   def aList = []
	   dList.each { i ->
	     iList.add(i.did)
	     aList.add(i.amt)
	   }
	   //println "individuals"+iList
	   //println "amount"+aList
	

	return [fromamount: params.fromamount, fromcriteria: params.fromcriteria, toamount:params.toamount, tocriteria:params.tocriteria, individualList: (iList?.size()>0)?Individual.getAll(iList):null, amountList : aList]
	}

    
    def patronCareAmountViewReport = {
        //println "amountreport: "+params
     	def fd='',td=''
    	if(params.fromDate)
    	{
    		fd = Date.parse('dd-MM-yyyy', params.fromDate)
    		fd.clearTime()
    	}
    	else
    	{
    		def sql = new Sql(dataSource);
    		//fd = new Date().previous()
    		def queryFromDate = "SELECT min(fund_receipt_date) fd FROM donation"
    		fd = sql.firstRow(queryFromDate).fd
    		sql.close()
    		//fd = new Date()
    	}
    	
    	println "fd="+fd
    	
	
    	if(params.toDate)
    		td = Date.parse('dd-MM-yyyy', params.toDate)
    	else
    		td = new Date()
    	//td = td.next()
    	td.clearTime()
    		
    	println "between:"+fd+"<=>"+td     

        
	if(!params.fromamount)
		return
	/*{
		def frmAmt="0"
		params.fromamount = frmAmt.toInteger()
	}
	println "params.fromamount="+params.fromamount
	*/

	def cond = null
    	   switch (params.fromcriteria) {
    	      case "Equal to":
    	          cond = '='
    	          break
    	      case "Less than":
    	          cond = '<'
    	          break
    	      case "Less than or Equal to":
    	          cond = "<="
    	          break
    	      case "Greater than":
    	          cond = ">"
    	          break
    	      case "Greater than or Equal to":
    	          cond = ">="
    	          break
    	      default:
    	          cond = null
    		}
    		
    	//println "params.fromamount again="+params.fromamount
    	//println "params.fromamount?.isInteger()="+(params.fromamount).isInteger()
    	if (!cond || !params.fromamount?.isInteger())
    		{
    	            flash.message = "Please provide valid input!!"
    	            return [fromamount:params.fromamount, fromcriteria:params.fromcriteria, toamount:params.toamount, tocriteria:params.tocriteria]
    		}
    		
    	def tocond = null
    	def validtoamt = false
    	def optflag = false
    	if(!params.toamount && !params.tocriteria)
    		optflag = true
    	if(params.toamount?.isInteger() && (params.toamount.toInteger() > params.fromamount.toInteger()))
    	{
    		validtoamt = true
    	}
    	if(validtoamt)
    	{
    	   switch (params.tocriteria) {
    	      case "Equal to":
    	          tocond = '='
    	          break
    	      case "Less than":
    	          tocond = '<'
    	          break
    	      case "Less than or Equal to":
    	          tocond = "<="
    	          break
    	      case "Greater than":
    	          tocond = ">"
    	          break
    	      case "Greater than or Equal to":
    	          tocond = ">="
    	          break
    	      default:
    	          tocond = null
    		}
    	}
    	
    	if (!optflag && (!tocond || !validtoamt))
    		{
    	            flash.message = "Please provide valid input for To amount/criteria!!"
    	            return [fromamount:params.fromamount, fromcriteria:params.fromcriteria, toamount:params.toamount, tocriteria:params.tocriteria]
    		}
    
		def login = springSecurityService.principal.username
		println "Loggedin user: "+login
		def individual = Individual.findByLoginid(login)
		println "setSessionParams for: "+individual

		def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
		println 'pcRole='+pcRole
		def patronCareHead, patronCareSevaks = []
		def individualInstanceList = [], individualRels = []
		def cultivatedByRelation = Relation.findByName("Cultivated by")

		for(int i=0; i<pcRole.size(); i++)
		{
			if(pcRole[i].toString() == "PatronCare")
			{
				individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
				for(int j=0; j<individualRels.size(); j++)
				{
					individualInstanceList[j] = individualRels[j].individual1
				}

				def sevakOfRelation = Relation.findByName("Sevak of")
				patronCareSevaks = Relationship.findAllWhere(individual2:individual, relation:sevakOfRelation, status:"ACTIVE").individual1		
				for(int j=0; j<patronCareSevaks.size(); j++)
				{
					individualRels = Relationship.findAllWhere(individual2:patronCareSevaks[j], relation:cultivatedByRelation, status:"ACTIVE")
					for(int k=0; k<individualRels.size(); k++)
					{
						println 'k='+k
						println 'individualRels[k]='+individualRels[k]
						println 'individualRels[k].individual1='+individualRels[k].individual1
						individualInstanceList.add(individualRels[k].individual1)
					}
				}
			}
			if(pcRole[i].toString() == "PatronCareSevak")
			{
				individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
				for(int j=0; j<individualRels.size(); j++)
				{
					individualInstanceList[j] = individualRels[j].individual1
				}
			}			
		}

		individualInstanceList = individualInstanceList.unique()
		def individualIds = individualInstanceList.id
		println 'individualIds='+individualIds
    		def individualIdsStr = individualIds.toString().replace("[","(")
    		individualIdsStr = individualIdsStr.toString().replace("]",")")
    		
    	   def sql = new Sql(dataSource);
    	   //def queryInd = "select donated_by_id did,amt, collected_by_id cid from (select donated_by_id, sum(amount) amt, collected_by_id  from donation where (status is null or status != 'BOUNCED') and donated_by_id in "+individualIdsStr+" group by donated_by_id) d where d.amt "+cond+" "+params.fromamount
    	   
    	    def queryInd = "select donated_by_id did,amt, collected_by_id cid, fund_receipt_date from (select donated_by_id, sum(amount) amt, collected_by_id, fund_receipt_date  from donation where (status is null or status != 'BOUNCED') and donated_by_id in "+individualIdsStr+" and fund_receipt_date>='"+String.format('%tF',fd)+"' and fund_receipt_date<='"+String.format('%tF',td)+"' group by donated_by_id) d where d.amt "+cond+" "+params.fromamount
    	   println "queryInd="+queryInd 
    	   if(tocond)
    	   	queryInd += " and d.amt "+tocond+" "+params.toamount
	   println "queryInd="+queryInd    	   	
    	   def dList = sql.rows(queryInd)
    	   sql.close()
    	   
    	   
    	   def iList = []
    	   def aList = []
    	   def cList = []
    	   def dtList = []
    	   dList.each { i ->
    	     iList.add(i.did)
    	     aList.add(i.amt)
    	     cList.add(i.cid)
    	     dtList.add(i.fund_receipt_date)
    	     
    	   }
    
    	return [fromamount: params.fromamount, fromcriteria: params.fromcriteria, toamount:params.toamount, tocriteria:params.tocriteria, individualList: (iList?.size()>0)?Individual.getAll(iList):null, amountList : aList, collectorList: cList, dateList:dtList, fd:fd, td:td]
    	}
    	
     def patronCareDonorReport() {}
     
     
     def patronCareCollectionReport = {
	def pcGroup = []
	if(SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE_HEAD'))
		{
		pcGroup = housekeepingService.getAllPC()
		}
	else
		{
		def pcGroupIds = housekeepingService.getPCGroup()
		for(int i=0; i<pcGroupIds.size(); i++)

			pcGroup[i] = Individual.get(pcGroupIds[i])
		//println "pcGroup="+pcGroup

		}
	pcGroup.unique()
	return [pcGroup:pcGroup]
	}
	
     def patronCareCollectionViewReport = {
    		//if(!params.acCollector)
    			//return
    	println "params.'patronCareSevaks.id'="+params."patronCareSevaks.id"
    	
    	def fd='',td=''
    	def collector = null
    	
    	if(params."patronCareSevaks.id")
	    	collector = Individual.get(params."patronCareSevaks.id")
    	
    	if(params.fromDate)
    	{
    		fd = Date.parse('dd-MM-yyyy', params.fromDate)
    		fd.clearTime()
    	}
    	else
    	{
    		def sql = new Sql(dataSource);
    		//fd = new Date().previous()
    		def queryFromDate = "SELECT min(fund_receipt_date) fd FROM donation"
    		fd = sql.firstRow(queryFromDate).fd
    		sql.close()
    		//fd = new Date()
    	}
    	
    	println "fd="+fd
    	
	
    	if(params.toDate)
    		td = Date.parse('dd-MM-yyyy', params.toDate)
    	else
    		td = new Date()
    	//td = td.next()
    	td.clearTime()
    		
    	println "between:"+fd+"<=>"+td

    	def donationList = null
	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifNotGranted('ROLE_NVCC_ADMIN'))
    		donationList = Donation.findAllByCollectedByAndFundReceiptDateBetween(collector, fd , td, [sort:"fundReceiptDate", order:"asc"])
    	else
    		{
    		def sql = new Sql(dataSource);
    		def query = "select distinct individual1_id from relationship where status='ACTIVE' and relation_id=(select id from relation where name='Cultivated by') and individual2_id in(select distinct individual_id from individual_role where role_id in (select id from role where name like 'PatronCare%'))"
    		def result = sql.rows(query)
    		sql.close()
    		def idList = result.collect{it.individual1_id}
    		
    		donationList = Donation.createCriteria().list() {
    				ge('fundReceiptDate',fd)
    				le('fundReceiptDate',td)
    				donatedBy{'in'('id',idList)}
    				order('fundReceiptDate', 'asc')
    				}	
    		}
	
	return [collector: collector, donationList: donationList]
    }
    	
     def patronCareFollowupReport = {
    	def pcGroupIds = housekeepingService.getPCGroup()
    	def pcGroup = []
    	for(int i=0; i<pcGroupIds.size(); i++)
    	
    		pcGroup[i] = Individual.get(pcGroupIds[i])
	println "pcGroup="+pcGroup
	
	return [pcGroup:pcGroup]
	}
	
     def patronCareFollowupViewReport = {
    		//if(!params.acCollector)
    			//return
    	println "params.'patronCareSevaks.id'="+params."patronCareSevaks.id"
    	
    	def fd='',td=''
    	def followupBy = Individual.get(params."patronCareSevaks.id")
    	println "followupBy="+followupBy
    	
    	if(params.fromDate)
    	{
    		fd = Date.parse('dd-MM-yyyy', params.fromDate)
    		fd.clearTime()
    	}
    	else
    	{
    		def sql = new Sql(dataSource);
    		//fd = new Date().previous()
    		def queryFromDate = "SELECT min(start_date) fd FROM followup"
    		fd = sql.firstRow(queryFromDate).fd
    		sql.close()
    		//fd = new Date()
    	}
    	
    	println "fd="+fd
    	
	
    	if(params.toDate)
    		td = Date.parse('dd-MM-yyyy', params.toDate)
    	else
    		td = new Date()
    	//td = td.next()
    	td.clearTime()
    		
    	println "between:"+fd+"<=>"+td

    	def followupList = Followup.findAllByFollowupByAndStartDateBetween(followupBy, fd , td, [sort:"startDate", order:"asc"])
	
	return [followupBy: followupBy, followupList: followupList]
    }
    	
     def schemewiseIndividualsReport = {  
	}

     def schemewiseIndividualsViewReport = {
     //println 'params='+params
    		if(!params.schemeid)
    			return
    	
    	def scheme = Scheme.get(params.schemeid)
    	//println 'scheme='+scheme
    	def schemeMemberList
    	if (params.schemeid)
    		schemeMemberList = SchemeMember.findAllByScheme(Scheme.get(params.schemeid))
    		println 'schemeMemberList='+schemeMemberList
		return [schemeid: params.schemeid, scheme: scheme, schemeMemberList: schemeMemberList]
	}

     def individualwiseSchemesReport = {

	}
	
     def individualwiseSchemesViewReport = {
     println 'params='+params
    		if(!params.'acIndividual_id')
    			return
    	
    	def member = Individual.get(params.'acIndividual_id')
    	println 'member='+member
    	def schemeMemberList
    	if (params.'acIndividual_id')
    		schemeMemberList = SchemeMember.findAllByMember(Individual.get(params.'acIndividual_id'))
    		println 'schemeMemberList='+schemeMemberList.size()

		return [member: member, schemeMemberList: schemeMemberList]
	}

	
	def addressBySchemeReport = {
		
	}
	
	def addressBySchemeViewReport = {
    	//println "View Report:"+params
    	def parameter1 = params.schemeid
    	//println "parameter1="+parameter1
	
	[msg:"Please click the link above!",reportName:params.reportName, parameter1:parameter1]		
	}	
	
	def trialReport = {
		
	}	
	def trialViewReport = {
    	//println "View Report:"+params
        		def parameter1 = null
    	   switch (params.fromcriteria) {
    	      case "Equal to":
    	          parameter1 = '='
    	          break
    	      case "Less than":
    	          parameter1 = '<'
    	          break
    	      case "Less than or Equal to":
    	          parameter1 = "<="
    	          break
    	      case "Greater than":
    	          parameter1 = ">"
    	          break
    	      case "Greater than or Equal to":
    	          parameter1 = ">="
    	          break
    	      default:
    	          parameter1 = null
    		}
	
	[msg:"Please click the link above!",reportName:params.reportName, parameter1:parameter1, parameter2:params.fromamount]		
	}	

	def rolewiseAddressesReport = {
		if(!params.roleid)
			return
			
		def role = Role.get(params.roleid)
		//println 'role='+role
		def ind = []
		ind = Individual_Role.FindAllByRoleId(params.roleid)
		//println 'ind='+ind
	}
	
	def rolewiseAddressesViewReport = {
		if(!params.name)
			return
		def name = (params.name)
		//println 'name='+name
		
		def role = Role.get(name)
		//println 'role='+role
		def indv = []
		indv = ((IndividualRole.findAllByRoleAndStatus(role, "VALID")).individual)
		def addr = []
		for(int i=0; i<indv.size(); i++)
		{
			if ((IndividualRole.findAllByRoleAndStatus(role, "VALID")).individual[i])
				addr[i] = Address.findByIndividual((IndividualRole.findAllByRoleAndStatus(role, "VALID")).individual[i])
		}
		
		return [role: role, indv: indv, addr: addr, name:params.name]
	}

	def nameInPadaSevaBookReport = {
		def nameInPadaSevaBookList = []
		nameInPadaSevaBookList = Donation.executeQuery("Select nvccDonarName, nameInPadaSevaBook from Donation where nameInPadaSevaBook != '' and nameInPadaSevaBook is not null and nameInPadaSevaBook != 'None'")
		//println 'nameInPadaSevaBookList='+nameInPadaSevaBookList
		
		return [nameInPadaSevaBookList: nameInPadaSevaBookList]
	}

	def loanSummaryReport = {
		def totalAmount = Loan.executeQuery("Select sum(amount) from Loan where status!='INVALID'")
		def findTotalFDAmount = (Loan.executeQuery("Select sum(amount) from Loan where status='ACCEPTED' and fd_number is not null"))
		println 'findTotalFDAmount='+findTotalFDAmount
		def totalFDAmount = 0
		if(findTotalFDAmount.size()>0)
		{
			if(findTotalFDAmount[0])
				totalFDAmount = findTotalFDAmount[0].toInteger()/2
		}
		return [totalAmount: totalAmount[0], totalFDAmount: totalFDAmount]
	}

	def loanDetailedReport = {
		def loanList = Loan.findAllByStatusNotEqual('INVALID')
		println 'loanList='+loanList
		//def payMode = PaymentMode.find
		def totalAmount = Loan.executeQuery("Select sum(amount) from Loan where status!='INVALID'")
		def findTotalFDAmount = (Loan.executeQuery("Select sum(amount) from Loan where status='ACCEPTED' and fd_number is not null"))
		def totalFDAmount = 0
		if(findTotalFDAmount.size()>0)
		{
			if(findTotalFDAmount[0])
				totalFDAmount = findTotalFDAmount[0].toInteger()/2
		}
		
		return [loanList: loanList, totalAmount: totalAmount[0], totalFDAmount: totalFDAmount]
	}

	def councellorLoanSummaryReport = {
		println ' councellorLoanSummaryReport params='+params
		if(!params.acCouncellor)
    			return

    	return [councellorId: params."acCouncellor_id"]
	}
	
	def councellorLoanSummaryViewReport = {
		println ' councellorLoanSummaryViewReport params='+params
		if(!params.acCouncellor)
				return
		
		def totalAmount = Loan.executeQuery("Select sum(amount) from Loan where status!='INVALID' and reference1_id = "+params."acCouncellor_id")
		def findTotalFDAmount = (Loan.executeQuery("Select sum(amount) from Loan where status='ACCEPTED' and fd_number is not null and reference1_id = "+params."acCouncellor_id"))
		def totalFDAmount = 0
		if(findTotalFDAmount.size()>0)
		{
			if(findTotalFDAmount[0])
				totalFDAmount = findTotalFDAmount[0].toInteger()/2
		}
		return [councellor: params.acCouncellor,totalAmount: totalAmount[0], totalFDAmount: totalFDAmount]
	}
	
	def councellorLoanDetailedReport = {
		println ' councellorLoanDetailedReport params='+params
		if(!params.acCouncellor)
    			return

    	return [councellorId: params."acCouncellor_id"]
	}
	
	def councellorLoanDetailedViewReport = {
		println ' councellorLoanDetailedViewReport params='+params
		println 'params.acCouncellor='+params.acCouncellor
		if(!params.acCouncellor)
				return
		def councellorLoanDetailedList = Loan.findAllByReference1(Individual.get(params."acCouncellor_id"))
		println 'councellorLoanDetailedList='+councellorLoanDetailedList
		def totalAmount = Loan.executeQuery("Select sum(amount) from Loan where status!='INVALID' and reference1_id = "+params."acCouncellor_id")
		def findTotalFDAmount = (Loan.executeQuery("Select sum(amount) from Loan where status='ACCEPTED' and fd_number is not null and reference1_id = "+params."acCouncellor_id"))
		def totalFDAmount = 0
		if(findTotalFDAmount.size()>0)
		{
			if(findTotalFDAmount[0])
				totalFDAmount = findTotalFDAmount[0].toInteger()/2
		}
		return [councellor:params.acCouncellor, councellorLoanDetailedList: councellorLoanDetailedList, totalAmount: totalAmount[0], totalFDAmount: totalFDAmount]
	}
	
	def individualLoanDetailedReport = {
		println ' individualLoanDetailedReport params='+params
		if(!params.acIndividual)
    			return

    	return [individualId: params."acIndividual_id"]
	}
	
	def individualLoanDetailedViewReport = {
		println ' individualLoanDetailedViewReport params='+params
		println 'params.acIndividual='+params.acIndividual
		if(!params.acIndividual)
			return
		def individualLoanDetailedList = Loan.findAllByLoanedBy(Individual.get(params."acIndividual_id"))
		println 'individualLoanDetailedList='+individualLoanDetailedList
		def totalAmount = Loan.executeQuery("Select sum(amount) from Loan where status!='INVALID' and loaned_by_id = "+params."acIndividual_id")
		def totalFDAmount_tocal = (Loan.executeQuery("Select sum(amount) from Loan where status='ACCEPTED' and fd_number is not null and loaned_by_id = "+params."acIndividual_id"))[0]
		def totalFDAmount
		if (totalFDAmount_tocal)
			totalFDAmount = totalFDAmount_tocal.toInteger()/2
		return [individual:params.acIndividual, individualLoanDetailedList: individualLoanDetailedList, totalAmount: totalAmount[0], totalFDAmount: totalFDAmount]
	}
	
	def datewiseLoanReport = {
		println '------------------datewiseLoanReport--------------------'
		println ' datewiseLoanReport params='+params
		if(!params.acCouncellor)
    			return

    	return [councellorId: params."acCouncellor_id"]
	}
	
	def datewiseLoanViewReport = {
		println '------------------datewiseLoanViewReport--------------------'
		println ' datewiseLoanViewReport params='+params
		def fromDate1, toDate1
		if(params.fromDate)
			fromDate1 = Date.parse('dd-MM-yyyy', params.fromDate)
		if(params.toDate)
			toDate1 = Date.parse('dd-MM-yyyy', params.toDate)
		
		println 'fromDate1='+fromDate1
		println 'toDate1='+toDate1
		def loanList = Loan.findAllByStatusNotEqualAndLoanDateBetween('INVALID',fromDate1,toDate1)
		println 'loanList='+loanList
		def totalAmount = 0
		def totalFDAmount = 0
		for(int i=0; i<loanList.size(); i++)
		{
			totalAmount = totalAmount + loanList.amount[i].toInteger()
			if(loanList.fdNumber[i] != null)
				totalFDAmount = totalFDAmount + loanList.amount[i].toInteger()/2
		}
		
		return [loanList:loanList, totalAmount: totalAmount, totalFDAmount: totalFDAmount]
		
	}
	
     def dailyTransactionOnlineReport = {
     
     println "Inside dailyTransactionOnlineReport: Params:"+params
    		if(params.first)
    			return
    	
    	def receiver, receiverId
	
    	println "params.acReceiver_id="+params.acReceiver_id
	def auth = springSecurityService.authentication
	
    	//if (springSecurityUtils.ifAnyGranted("ROLE_DUMMY"))
    	def donationList
    	def denominationInstanceList
    	def fd='',td=''
    	if(params.fromDate)
    		fd = Date.parse('dd-MM-yyyy', params.fromDate)
    	else
    		fd = new Date().previous()
    	fd.clearTime()
    	if(params.toDate)
    		td = Date.parse('dd-MM-yyyy', params.toDate)
    	else
    		td = new Date()
    	td.next()
    	td.clearTime()
    		
    	println "between:"+fd+"<=>"+td
    	
    	if(!receiver)
    		donationList = Donation.findAllByFundReceiptDateBetween(fd , td, [sort:"fundReceiptDate", order:"asc"])
    	else
    		{
    		donationList = Donation.findAllByReceivedByAndFundReceiptDateBetween(receiver, fd, td, [sort:"fundReceiptDate", order:"asc"])
    		denominationInstanceList = Denomination.findAllByCollectedByAndCollectionDateBetween(receiver,fd,td,[sort:"collectionDate", order:"asc"])
    		}
    		
    	//remove bounced donations
    	def tlist = []
    	denominationInstanceList.each{d ->
    	if(d.status != 'BOUNCED')
    		tlist.add(d)
    	}
    	denominationInstanceList = tlist
	return [receiver: receiver, receiverId: receiverId, donationList: donationList, fd: fd, td: td, denominationInstanceList: denominationInstanceList]
	}


     def dailyTransactionOnlineViewReport = {
     
     println "Inside dailyTransactionOnlineViewReport: Params:"+params
    		if(params.first)
    			return
    	
    	def receiver = Individual.get(params.receiverId)
    		receiver = Individual.get(params.acReceiver_id)
    		
    	def donationList
    	def denominationInstanceList
    	def fd='',td=''
    	if(params.fromDate)
    		{
    		//make it 00:00 based
    		params.fromDate += ' 00:00:00'
    		fd = Date.parse('dd-MM-yyyy HH:mm:ss', params.fromDate)
    		}
    	else
    		//fd = new Date().previous()
    		fd = new Date()
    	//fd.clearTime()
    	if(params.toDate)
    		{
    		params.toDate += ' 23:59:59'
    		td = Date.parse('dd-MM-yyyy HH:mm:ss', params.toDate)
    		}
    	else
    		td = new Date()
    	//td = td.next()
    	//td.clearTime()
    		
    	println "between:"+fd+"<=>"+td
    	
    	def fdStr = fd.format('yyyy-MM-dd HH:mm:ss')
    	def tdStr = td.format('yyyy-MM-dd HH:mm:ss')
    	
    	log.debug("fdstr tdstr"+fdStr+" "+tdStr)
    	//println 'receiver='+params.receiver
    	if(!receiver)
    		donationList = Donation.findAllByFundReceiptDateBetween(fd , td, [sort:"fundReceiptDate", order:"asc"])
    	else
    		{
    		donationList = Donation.findAllByReceivedByAndFundReceiptDateBetween(receiver, fd, td, [sort:"fundReceiptDate", order:"asc"])
    		denominationInstanceList = Denomination.findAllByCollectedByAndCollectionDateBetween(receiver,fd,td,[sort:"collectionDate", order:"asc"])
    		}
    	//println 'donationList='+donationList	
    	def bulkDonationReceiptBookNo =[]
    	def bulkDonationReceiptNo =[]
    	for(int i=0; i<donationList.size(); i++)
    	{
    		if(!donationList.nvccReceiptBookNo[i])
    			bulkDonationReceiptBookNo[i] = Receipt.get(donationList.donationReceiptId[i]).receiptBook
    		if(!donationList.nvccReceiptNo[i])
    			bulkDonationReceiptNo[i] = Receipt.get(donationList.donationReceiptId[i]).receiptNumber
    	}
    	def totalsByMode
	def sql = new Sql(dataSource)
	def totalQry	
	if(receiver)
		totalQry = "select pm.name pmode,sum(d.amount) amount from donation d, payment_mode pm where d.mode_id=pm.id and d.received_by_id="+receiver.id+" and d.fund_receipt_date>='"+fdStr+"' and d.fund_receipt_date<='"+tdStr+"'   group by pm.name"

	else
		totalQry = "select pm.name pmode,sum(d.amount) amount from donation d, payment_mode pm where d.mode_id=pm.id and d.fund_receipt_date>='"+fdStr+"' and d.fund_receipt_date<='"+tdStr+"'   group by pm.name"	

		//def totalsByMode =  Donation.executeQuery(totalQry)
		totalsByMode = sql.rows(totalQry)


    	def totalsByScheme
	if(receiver)
		totalQry = "select s.name scheme,sum(d.amount) amount from donation d, scheme s where d.scheme_id=s.id and d.received_by_id="+receiver.id+" and d.fund_receipt_date>='"+fdStr+"' and d.fund_receipt_date<='"+tdStr+"'   group by s.name"

	else
		totalQry = "select s.name scheme,sum(d.amount) amount from donation d, scheme s where d.scheme_id=s.id and d.fund_receipt_date>='"+fdStr+"' and d.fund_receipt_date<='"+tdStr+"'   group by s.name"	

	totalsByScheme = sql.rows(totalQry)

    	def totalsByCostCenter
	if(receiver)
		totalQry = "select ccat.name costcategory,cc.name costcenter,m.name mode,sum(d.amount) amount from donation d, scheme s, cost_center cc, cost_category ccat,payment_mode m where d.scheme_id=s.id and s.cc_id=cc.id and cc.cost_category_id=ccat.id and d.mode_id=m.id and d.received_by_id="+receiver.id+" and d.fund_receipt_date>='"+fdStr+"' and d.fund_receipt_date<='"+tdStr+"'   group by ccat.name,cc.name,m.name order by ccat.name,cc.name,m.name"

	else
		totalQry = "select ccat.name costcategory,cc.name costcenter,m.name mode,sum(d.amount) amount from donation d, scheme s, cost_center cc, cost_category ccat,payment_mode m where d.scheme_id=s.id and s.cc_id=cc.id and cc.cost_category_id=ccat.id and d.mode_id=m.id and d.fund_receipt_date>='"+fdStr+"' and d.fund_receipt_date<='"+tdStr+"'   group by s.name"	

	totalsByCostCenter = sql.rows(totalQry)
		
	sql.close()
    		
	
    	//remove bounced donations
    	def tlist = []
    	denominationInstanceList.each{d ->
    	if(d.status != 'BOUNCED')
    		tlist.add(d)
    	}
    	denominationInstanceList = tlist
		//td = td.previous()
		println 'fd='+fd
		println 'td='+td
	println 'receiver='+receiver
	println 'totalsByMode='+totalsByMode
	def grandTotal = 0
	if(totalsByMode)
	{
		for(int i=0; i<totalsByMode.size(); i++)
		{
			println 'totalsByMode[i].amount='+totalsByMode[i].amount
			grandTotal = grandTotal + totalsByMode[i].amount
			println 'grandTotal='+grandTotal
		}
	}
	println 'grandTotal='+grandTotal
	//return [receiver: receiver, param_receivers: (params.acReceiver_id),reportName:params.reportName, donationList: donationList, fd: fd, param_fromDate:fd.format('yyyy-MM-dd'), td: td, param_toDate:td.format('yyyy-MM-dd'), denominationInstanceList: denominationInstanceList, totalsByMode: totalsByMode, bulkDonationReceiptBookNo: bulkDonationReceiptBookNo, bulkDonationReceiptNo: bulkDonationReceiptNo, param_grandTotal: grandTotal]
	return [receiver: receiver, param_receivers: (params.acReceiver_id), reportName:params.reportName, donationList: donationList, fd: fd, param_fromDate:fd.format('yyyy-MM-dd'), td: td, param_toDate:td.format('yyyy-MM-dd'), denominationInstanceList: denominationInstanceList, totalsByMode: totalsByMode, totalsByScheme: totalsByScheme, bulkDonationReceiptBookNo: bulkDonationReceiptBookNo, bulkDonationReceiptNo: bulkDonationReceiptNo, param_grandTotal: grandTotal, totalsByCostCenter: totalsByCostCenter]
	}

    def receiptBookIssuedViewReport = {
	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
	{
		def login = springSecurityService.principal.username
		println "Loggedin user: "+login
		def individual = Individual.findByLoginid(login)
		println "setSessionParams for: "+individual

		def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
		println 'pcRole='+pcRole
		def patronCareHead, patronCareSevaks = []
		def individualInstanceList = [], individualRels = []
		def cultivatedByRelation = Relation.findByName("Cultivated by")
		def patronCareReceiptBooks = []
		def sevakOfRelation = Relation.findByName("Sevak of")
		def patronCareRB = [], patronCareSevaksRB = []

		for(int i=0; i<pcRole.size(); i++)
		{
			if(pcRole[i].toString() == "PatronCare")
			{
				patronCareSevaks = Relationship.findAllWhere(individual2:individual, relation:sevakOfRelation, status:"ACTIVE").individual1		
				patronCareRB = ReceiptBookIssued.findAllByIssuedTo(individual)
				for(int j=0; j<patronCareRB.size(); j++)
					patronCareReceiptBooks.add(patronCareRB[j])
				for(int j=0; j<patronCareSevaks.size(); j++)
				{
					patronCareSevaksRB = ReceiptBookIssued.findAllByIssuedTo(patronCareSevaks[j])
					for(int k=0; k<patronCareSevaksRB.size(); k++)
						patronCareReceiptBooks.add(patronCareSevaksRB[k])
					println 'patronCareReceiptBooks='+patronCareReceiptBooks
				}
			}
			if(pcRole[i].toString() == "PatronCareSevak")
				patronCareReceiptBooks = ReceiptBookIssued.findAllByIssuedTo(individual)		
		}
		println 'patronCareReceiptBooks='+patronCareReceiptBooks
		return [patronCareReceiptBooks: patronCareReceiptBooks]
	}
    }
    
    def familyDonationsViewReport = {
    	println 'familyDonationsViewReport'

    	def queryFam, amtFam = []
    	def sql = new Sql(dataSource);
	queryFam = "select * from (select d.donated_by_id primaryid,d.donated_by_id donorid,sum(amount) amount from donation d where exists (select 1 from relationship_group rg , relationship r where rg.refid=d.donated_by_id and r.individual2_id=rg.refid and r.relationship_group_id<>0) group by d.donated_by_id) qi left join (select qt.primaryid,sum(qt.amount) famount from (select q.refid primaryid,q.individual1_id donorid,sum(d.amount) amount from donation d, (SELECT rg.refid,r.individual1_id,r.relation_id,r.individual2_id FROM relationship_group rg , relationship r where rg.refid<>0 and rg.id=r.relationship_group_id and r.status='ACTIVE') q where d.donated_by_id=q.individual1_id group by d.donated_by_id) qt group by qt.primaryid) qf on qi.primaryid=qf.primaryid"
	amtFam = sql.rows(queryFam)
    	sql.close()
    	println 'amtFam='+amtFam
    	println 'amtFam.size()='+amtFam.size()
    	return [amtFam: amtFam]
    	
    }
    
    def familyDonationsViewReport1 = {
    	println 'familyDonationsViewReport'
    	def individuals = [], amtInd = [], amtFam = []
    	
    	def rels = Relationship.findAllByRelationshipGroupNotEqual("dummy")
    	
    	individuals = Individual.list()
    	println 'individuals='+individuals
    	def summaryDonation = [0]
    	for(int i=0; i<individuals.size(); i++)
    	{
    		amtInd[i] = "0.00"
    		amtFam[i] = "0.00"
    		//println '(individuals[i]?.id).toString()='+(individuals[i]?.id).toString()
    		if(individuals[i]?.id)
    		{
    			summaryDonation[i]=(housekeepingService.donationSummary((individuals[i]?.id).toString()))
    			if(summaryDonation[i].amtInd)
    				amtInd[i] = summaryDonation[i].amtInd
    			if(summaryDonation[i].amtFam && summaryDonation[i].amtInd)
    				amtFam[i] = summaryDonation[i].amtFam - summaryDonation[i].amtInd
    		}
    		//println 'summaryDonation[i]='+summaryDonation[i]
    	}
    	return [individuals: individuals, summaryDonation: summaryDonation, amtInd: amtInd, amtFam: amtFam]
    	
    }

    //wrote this method for internet disconnection issue due to which sms's and mails were not sent to donors between th eperiod 27th July 2012 and 5th August 2012.
    def sendSMStoDonors = { 
    
	   def sql = new Sql(dataSource);
	   //def queryInd = "select id, donor_name, donor_contact, donor_email, amount, date_created, last_updated, updator from donation where date_created> '2012-07-27' and date_created< '2012-08-06' and donor_contact in (9850820215) order by id"
	   def queryInd = "select id, donor_name, donor_contact, donor_email, amount, date_created, last_updated, updator from donation where date_created> '2012-07-24' and date_created< '2012-08-06' and donor_contact in (9764560433,9557275726,9860295499,9970735764,9821428992,8600163338,9881209223,8805502288,9922773699,8956006180,9665243729,9552522426,9850093784,9850033292,9820718069,9822867405,9850120197,9371015231,9225069219,9850892953,9535790669,7709110807,9922268078,9209241109,9890228408,9820059479,9326022224,9423585811,9820374281,9922448373,8928245453,9822342052,9822607876,9422024897,8605411249,9422008537,9869410834,8087992275,9765406690,9922990698,9822970918,8888093561,9821260910,9552502340,9011095878,9740081000,9028059120,9270000433,9763701691,9767103493,9881148101,9823254549,9860595158,9922217699,9890811861,9850091804,9881432493,9890667369,9226133435,9371063856,9822671007,9822036999,9689880814,9371016478,9428630682,9970007200,8237897364,9372404311,9822597779,9823601652,9122300503,9825310714,9673336302,9850545475,9823413957,9422337126,9420697584,9975788915,9890413643,9762191925,9823857753,9922484889,9689893415,9822040731,9922265263,9970710828,9921827238,9011358923,9762191925,9689880821,9922744178,9822755555,9850733571,9763876554,9922410108,9422079238,9527093522,9860044897,9823817396,9850211250,9881467314,9765433420,9960855545,9527195544,9922007047,9881300215,9881738421,9923030121,9371015374,9822645077,9822118393,9371102051,9049002960,9766351997,9850042778,9890745168,9422024897,8888832977,9860903693,9922948672,9822911143,9326533184,9881436210,9552522423,9422311878,9823856507,7588290598,9673063777,9922558889,9403051000,9850073902,9923696517,9881123328,9850725212,9765539720,9763866105,8087603077,9850110467,9689880783,9561345445,9167204733,9822029412,9822040969,9822528920,9049990812,9850161155,9822011214,9422467050,9880811315,9986007646,9822009300,9689860006,9823141073,9764465745,8308838830,9372106500,9762191925,9819002209,9322748796,9819002209,9828337593,9029055332,9890100333,9822034081,9822301530,9823090441,9011332878,9911442285,9822282718,9822683988,9545509234,9552569520,9860093221,9049935454,9371018389,9371877987,9867119220,9552510917,9822494115,9881434337,9890310005,9822257474,9881068387,8805964838,8888808451,9657001849,9373895412,9326999150,9689880814,9850508373,9850004254,8379876636,9822014039,9823435071,9822284259,9764042129) order by id"

	   def queryResult = sql.rows(queryInd)
	   sql.close()
	   println ' '
	   println 'queryInd='+queryInd
	   println 'queryResult='+queryResult
	   def donorNameForSMS, mailBody, mailIds
	   
	   for(int i=0; i<queryResult.size(); i++)
	   {
	   	if(queryResult[i].donor_name)
	   	{
			donorNameForSMS = (queryResult[i].donor_name).toString().replace(" ","%20")
			println ' '
			println 'queryResult[i].donor_contact='+queryResult[i].donor_contact
			println 'msg='+'Dear%20'+donorNameForSMS+',%20Hare%20Krishna!%20Thank%20you%20for%20the%20donation%20of%20Rs.%20'+queryResult[i].amount+'.%20May%20Lord%20Krishna%20shower%20His%20choicest%20blessings%20upon%20you.%20-ISKCON%20Pune'
			housekeepingService.sendSMS(queryResult[i].donor_contact,'Dear%20'+donorNameForSMS+',%20Hare%20Krishna!%20Thank%20you%20for%20the%20donation%20of%20Rs.%20'+queryResult[i].amount+'.%20May%20Lord%20Krishna%20shower%20His%20choicest%20blessings%20upon%20you.%20-ISKCON%20Pune')

			println ' '
			println 'queryResult[i].donor_email='+queryResult[i].donor_email
			if(queryResult[i].donor_email)
			{
				mailIds = queryResult[i].donor_email.split(",")
				println 'queryResult[i].donor_email='+queryResult[i].donor_email
				println 'mailIds='+mailIds
				mailBody = 'Dear '+queryResult[i].donor_name+', \nHare Krishna! \n\nThank you for the donation of Rs. '+queryResult[i].amount+'. May the Lord shower His choicest blessings upon you. \n\n--ISKCON NVCC.' 
				println 'mailBody='+mailBody
				try{
					sendMail {     
					  to mailIds
					  subject "Thank you for the Donation."     
					  body mailBody
					}  
				}
				catch(Exception e)
				{
					println e
				}
			}
	   	}
	   }
    }    
    
    def mapdummydonarlist = {
    	def sql = new Sql(dataSource);
    	def query = "select distinct trim(remarks) as donar from ssrvcdb.donations where donar_code=202624 and remarks is not null and trim(remarks) <> '' order by donar"
        def donarList = sql.rows(query)
        def individualList = []
        def retList = []
        donarList.each{d ->
        	try{
			def individual = Individual.searchTop(d.donar)
			individualList.add(individual)
		        def a = new Object[2]
			a[0] = d.donar
			a[1] = individual
			retList.add(a)	
			if(individual)
				println d.donar + "=>" + individual.nvccDonarCode + "=>"+ individual
		}
		catch(Exception e)
		{
			println e
		}
        }
        sql.close()
        return [donarList:donarList, individualList: individualList, retList:retList]
	}

    def automapdummydonar = {
    	//update donation d, individual i set d.donated_by_id=i.id,d.status='AUTOMAPPED_LNAME' where d.comments=i.legal_name and d.status='DUMMY'
    	//update donation d set d.status='AUTOMAPPED_DUMMY' where d.status='DUMMY' and d.comments is null
    	//update donation d set d.status='AUTOMAPPED_DUMMY' where d.status='DUMMY' and d.comments = ''
    	println "In auto mapdummydonar: params: " + params
    	def fuzzy = false
    	if(params.fuzzy)
    		fuzzy = true
    	//pickup a dummy donation with valid comments
    	def donation
    	def individuals
    	while(true)
    		{
    		def dflag = true
		while(dflag)
			{
			donation = Donation.findByStatus("DUMMY")
			if(!donation)
				return
			def rem = donation.comments
			if(!rem || rem.trim().size() < 4)
				{
				//println donation.toString() +" has insiginificant remarks!"
				donation.status = "AUTOMAPPED_TOOSHORT"
				donation.save(flush:true)
				}
			else
				dflag = false
			}
		//now try searching for the individual
		//if fuzzy then tokenize and append ~
		def searchStr = donation.comments
		searchStr = searchStr.replaceAll(~/\(/,"")
		searchStr = searchStr.replaceAll(~/\)/,"")
		println "Searching for (raw): " + searchStr
		if(fuzzy)
			{
			def tokens = searchStr.split()
			searchStr = ''
			tokens.each
				{
				if(it.size()>3)
					searchStr += it +"~ "
				}
			}
		println "Searching for: " + searchStr
		if(searchStr && searchStr.size()>3)
			individuals = Individual.searchEvery(searchStr)
		//println "found individuals" + individuals
		if(!individuals || individuals?.size()==0)
				{
				println donation.toString() +" has unmatched donar from remarks!"
				donation.status = "DUMMY_MANUAL"
				donation.save(flush:true)
				}
		if(individuals.size()==1)
			{
				println "Match found!! "+individuals.get(0)
				donation.donatedBy = individuals.get(0)
				if(fuzzy)
					donation.status = "AUTOMAPPED_FUZZY"
				else
				donation.status = "AUTOMAPPED"
				donation.save(flush:true)
			}
		else if(individuals.size()>1)
			{
				println donation.toString() +" has many matched donar from remarks!"
				def dcstr = ''
				individuals.each{ind -> dcstr += ind.nvccDonarCode+";"}
				if(dcstr.size()>255)
					dcstr = dcstr.substring(0,254)
				donation.paymentComments = dcstr
				if(fuzzy)
					donation.status = "DUMMY_MANUAL_MANY_FUZZY"
				else
				donation.status = "DUMMY_MANUAL_MANY"
				donation.save(flush:true)
			}
		}
    	
    	//return [donation:donation, individuals:individuals]
    	redirect(action: "automaplist")
	}
	
    def mapdummydonar = {
    	println "In auto mapdummydonar: params: " + params
    	def fuzzy = false
    	if(params.fuzzy)
    		fuzzy = true
    	//pickup a dummy donation with valid comments
    	def donation
    	def individuals
    	while(!individuals)
    		{
    		def dflag = true
		while(dflag)
			{
			donation = Donation.findByStatus("DUMMY")
			if(!donation)
				return
			def rem = donation.comments
			if(!rem || rem.trim().size() < 4)
				{
				//println donation.toString() +" has insiginificant remarks!"
				donation.status = "AUTOMAPPED_DUMMY_TOOSHORT"
				donation.save(flush:true)
				}
			else
				dflag = false
			}
		//now try searching for the individual
		//if fuzzy then tokenize and append ~
		def searchStr = donation.comments
		searchStr = searchStr.replaceAll(~/\(/,"")
		searchStr = searchStr.replaceAll(~/\)/,"")
		println "Searching for (raw): " + searchStr
		def tokens = searchStr.split()
		if(fuzzy)
			{
			searchStr = ''
			tokens.each
				{
				if(it.size()>3)
					searchStr += it +"~ "
				}
			}
		//println "Searching for: " + searchStr
		if(searchStr && searchStr.size()>3)
			individuals = Individual.searchEvery(searchStr)
		if(!individuals)
				{
				println donation.toString() +" has unmatched donar from remarks!"
				donation.status = "DUMMY_MANUAL"
				donation.save(flush:true)
				}
		}
    	
    	return [donation:donation, individuals:individuals]
	}
	
    def automaplist = {
    	def donationList = Donation.findAllByStatus("AUTOMAPPED")
    	def donationIdList = []
    	def i
    	for(i=0; i<donationList.size(); i++)
    		donationIdList[i] = donationList[i].id
    	/*
    	for (i=0; i<donationList.size(); i++)
    		donationList[i].status = "DUMMY_AUTOMAPPED_UNDER_VERIFICATION"
    	*/
    	return [donationList: donationList, donationIdList: donationIdList]
    
    }
   
    def automap = {
    	println "In automap: " + params
    	def donation, donation1
    	def donations = []
    	def donationIds = []
    	def i
    	donationIds = params.donationIdList.split(",")
    	
    	println "params.donationIdList="+params.donationIdList
    	println "donationIds="+donationIds[0]
    	println "donationIds.size()="+donationIds.size()
    	println "params.myCheckbox="+params.myCheckbox
    	println "params.myCheckbox.size()="+params.myCheckbox.size()
    	
    	for(i=0; i<params.myCheckbox.size(); i++)
    	{
    		donation = Donation.findById(params.myCheckbox[i])
    		donation.status = "DUMMY_AUTOMAPPED_VERIFIED"
    		donation.save(flush:true)
    	}

	donationIds[0] = donationIds[0].toString().replace('[','')
	donationIds[donationIds.size()-1] = donationIds[donationIds.size()-1].toString().replace(']','')
    		
    	if(donationIds.size() > params.myCheckbox.size())
    	{
		for(i=0; i<donationIds.size(); i++)
		{
			println "donationIds[i]="+donationIds[i]
			donation1 = Donation.findById(donationIds[i].toInteger())
			println "donation1="+donation1
			if(donation1.status != "DUMMY_AUTOMAPPED_VERIFIED")
			{
				donation1.status = "DUMMY_AUTOMAPPED_INVALID"
				donation1.save(flush:true)
			}
		}
    	}
	redirect(action: "automaplist")
    }
   
    def linkdonar = {
    	println "In linkdonar: " + params
    	def donation = Donation.get(params.donationid)
    	if(params.map=="MapAndShow" || params.map=="MapAndContinue")
    		{
		donation.donatedBy = Individual.get(params.individualRadio)
		println "Linked Donar:" + donation.donatedBy
		donation.status="MAPPED"
    		}
    	else
		donation.status="DUMMY_MANUAL"
    	
    	donation.save(flush:true)
    	switch(params.map)
    	{
    		case "MapAndShow":
    			redirect(controller: "donation", action: "show", id: params.donationid)
    			return
    		default:
    			redirect(action: "mapdummydonar", params:[fuzzy:params.fuzzy])
    			return
    	}
    	}
    	
    def phonenos = {
    	return housekeepingService.getAllphonenos()
    }

    def assignCultivator = {
    
    }

    def assignCultivatorToDonorsList = {
    	println "params:"+params

		println 'params.acpatronCareCollector_id='+params.acpatronCareCollector_id
		def donationList = Donation.findAllByCollectedBy(Individual.get(params.acpatronCareCollector_id), [sort:"donatedBy", order:"asc"]).donatedBy
		//println "donationList="+donationList		
		def sql = new Sql(dataSource)
		def donorQry = "select i.id, i.legal_name, i.initiated_name, sum(d.amount) amt from individual i ,donation d where d.collected_by_id='"+ params.acpatronCareCollector_id +"' and i.id=d.donated_by_id group by i.legal_name"
		//"select distinct i.id, i.legal_name, i.initiated_name, i.address  from individual i ,donation d where d.collected_by_id=315 and i.id=d.donated_by_id"    		
		def donors = sql.rows(donorQry)
		//println "donors="+donors
		
		println "-------------------------------------"
		def Indv = []
		def indvDonations = []
		def otherCollectors = []
		def otherCollectorsList = []
		def collectorsQry = []
		def collector = Individual.get(params.acpatronCareCollector_id)
		//def addFlg
		def crel = Relation.findByName('Cultivated by')
		def cultivatorRels = [], cultivatorRel = []
		for(int i=0; i<donors.size(); i++)
		{
			Indv.add(Individual.get(donors[i].id))
			if(Indv[i].legalName != "Dummy Donor for daily transactions" && Indv[i].legalName != "Hundi Collection")
				indvDonations[i] = (Donation.findAllByDonatedBy(Indv[i]))
			else
				indvDonations[i] = ""
			//println "---indvDonations[i]="+indvDonations[i]
        	
        	        cultivatorRels = Relationship.findAllByIndividual1AndRelation(Indv[i],crel)
        	        for(int j=0; j<cultivatorRels.size(); j++)
        	        {
				if(cultivatorRels[j].status == "ACTIVE")
					cultivatorRel[i] = cultivatorRels[j]?.individual2
        	        }
		}
		//println "---Indv="+Indv
		//println "---cultivatorRel="+cultivatorRel
		//println "---indvDonations="+indvDonations
		
		for(int i=0; i<indvDonations.size(); i++)
		{
			
			for(int j=0; j<indvDonations[i].size(); j++)
			{//addFlg = 1
				//if(Indv[i].toString() != "Dummy Donor for daily transactions")
				
				if(indvDonations[i] != "" && indvDonations[i][j].collectedBy != Individual.get(params.acpatronCareCollector_id))
					otherCollectors.add(indvDonations[i][j].collectedBy)
				else
					otherCollectors.add("")
	
			}
			otherCollectors = otherCollectors.unique()
			otherCollectorsList.add(otherCollectors)
			otherCollectors = []
		}
			
			//println "---otherCollectorsList="+otherCollectorsList
			
		sql.close()
		//otherCollectors = otherCollectors.replace(",","<br>")
		return [acpatronCareCollector:params.acpatronCareCollector, acpatronCareCollector_id:params.acpatronCareCollector_id, donationList: donationList, donors:donors, Indv:Indv, otherCollectors:otherCollectors, otherCollectorsList:otherCollectorsList,cultivatorRel:cultivatorRel]
    }
    
    def assignCultivatorToNonDonorsList = {
    
    }
    
    def assignCultivatorToDonors = {
    	println 'assignCultivatorToDonors params='+params
    	println 'params.Assign='+params.Assign
	def relnship = new Relationship()
	def relation = Relation.findByName("Cultivated by")
	def relationshipgroup = RelationshipGroup.findByGroupName("dummy")
    	def assignList = params.list('Assign')
    	def relnshipPresent = []
    	def relnshipPresentInstance
    	for(int i=0; i<(assignList).size(); i++)
    	{
    		println 'assignList='+assignList[i]
        	//Now save Cultivator info
        	if(params.acpatronCareCollector_id)
		{

			//assign cultivator
			relnship.individual1 = Individual.get(assignList[i])
			relnship.individual2 = Individual.get(params.acpatronCareCollector_id)
			relnship.relation = relation
			relnship.relationshipGroup = relationshipgroup
			relnship.status = "ACTIVE"
			relnship.comment = "Assigning Patron Care Collector "+relnship.individual2+" as Cultivator"
			relnship.creator = springSecurityService.principal.username
			relnship.updator = springSecurityService.principal.username
			println 'relnship.individual1='+relnship.individual1
			println 'relnship='+relnship
			//first delete cultivator if already present
			relnshipPresent = Relationship.findAllByIndividual1AndRelation(Individual.get(assignList[i]),relation)
			println 'relnshipPresent='+relnshipPresent
			if(relnshipPresent.size() > 0)
			{
				for(int j=0; j<relnshipPresent.size(); j++)
				{
					if(relnshipPresent[j].status == "ACTIVE")
					{
						relnshipPresentInstance = Relationship.get(relnshipPresent[j].id)
						println 'relnshipPresent[j]='+relnshipPresent[j]
						relnshipPresentInstance.status = "INACTIVE"
						if (!relnshipPresentInstance.save(flush: true))
							println "Error in making INACTIVE: "+relnshipPresent[j]
						else 
							println "saved relnship after making INACTIVE: "+relnshipPresent[j]
					}
				}
			}
			if (!relnship.save(flush: true))
				println "Error in saving cultivator relationship: "+relnship
			else 
				println "saved relnship: "+relnship				
		}
     		
    	}
    	redirect(action: "assignCultivatorToDonorsList", params:[acpatronCareCollector_id:params.acpatronCareCollector_id]) 
    }
    
    def advanced() {
    }
    
    def reports() {
    }

    def events() {
    }
    
    def searchIndividual() {
    }
    
    def bulkcreate() {
    }
    
    def searchIndividualByRole() {
    }
    
    def searchCheque() {
    }
    
    def compareIndividuals() {
    }
    
    def uploadImages() {
    	def indList = Individual.findAllByPicFileURLIsNotNullAndAvatarTypeIsNull();
    	indList.each{ind->
    	if(ind?.picFileURL && !ind?.avatarType && !ind?.picFileURL?.contains("Counter"))
    		{
			try{
				def fileName = grailsApplication.config.photos.location.toString() + ind.picFileURL
				def f 
				  f = new File(fileName)

				if(f)
					{
					println "File Name: "+fileName
					ind.avatar = f?.readBytes();
					ind.avatarType = 'image/jpeg'
					if(!ind.save(flush:true))
						{
							if(ind.hasErrors()) {
							    ind.errors.each {
								  println it
							    }
							}	
						}
					}
			}catch(e){
			  println e
			}
    			
    		}
    	}
    		
    }
    
    def tryUpload(){
    	def temp = [], picFile1, picFile2
    	def indList = Individual.findAllByPicFileURLIsNotNullAndAvatarTypeIsNull();

    	def fileName, f
    	
	indList.each{ind->
	    	if(ind?.picFileURL && !ind?.avatarType)
		{
			println 'ind.picFileURL='+ind.picFileURL.toString().substring(43,ind.picFileURL.toString().size())
			picFile1 = ind.picFileURL.toString().substring(43,ind.picFileURL.toString().size())
			try{
	
				fileName = grailsApplication.config.photos.location.toString() + picFile1
				println 'fileName='+fileName
				  f = new File(fileName)

				if(f)
				{
					println "File Name: "+fileName
					ind.avatar = f?.readBytes();
					//println "ind.avatar: "+ind.avatar
					ind.avatarType = 'image/jpeg'
					//println "ind.avatarType: "+ind.avatarType
					//ind.save()
					if(ind.save(flush: true))
						println "saved"
					else
						println "not saved"
					
				}
			}catch(e){
			  println e
			}
			
		}
	  }
    }
    
    
    //returns the list of individuals having donations in the specified range
    def donorInRange(String minAmt, String maxAmt) {
        def sql = new Sql(dataSource)
        String query = "select f.id id ,f.individualid,t.amt from (select donated_by_id, sum(amount) amt from donation d  group by d.donated_by_id having amt >= "+minAmt +" and  amt < " + maxAmt+") t left join flags f on t.donated_by_id=f.individualid where f.formstatus='UNVERIFIED' order by t.amt desc"
        println "In donorsInRange..."+query
    	def res = sql.firstRow(query)
        sql.close()
        def flagInstance = Flags.get(res?.id)
        if(flagInstance)
        	{
        	flagInstance.formstatus="PENDING"
        	flagInstance.save(flush:true)
	        redirect(controller: "flags", action: "edit", id: flagInstance.id)
	        return
        	}
        else
        	"No Unvalidated records exist!!"
        
    }
    
    //return the contact details of an unverified individual in the order of donation
    def verifyDonor() {
        def sql = new Sql(dataSource)
        String query = "select f.id id from flags f where formstatus='UNVERIFIED' order by amount desc"
        println "In verifyDonor..."+query
    	def res = sql.firstRow(query)
        sql.close()
        def flagInstance = Flags.get(res?.id)
        if(flagInstance)
        	{
        	flagInstance.formstatus="UNDER VERIFICATION"
        	flagInstance.save(flush:true)
	        redirect(controller: "flags", action: "edit", id: flagInstance.id)
	        return
        	}
        else
        	"No Unvalidated records exist!!"
        
    }
    
    //stats of various flags
    def verificationStats() {
    	def sql = new Sql(dataSource)
    	String query = "select formstatus,count(*) c from flags group by formstatus order by formstatus"
    	def res = sql.rows(query)
    	query = "select updator,formstatus,count(*) c from flags group by updator,formstatus"
    	def detstats = sql.rows(query)
    	sql.close()
	[stats:res, detstats : detstats]    
    }
    
    def clearPending(String updator) {
    	def sql = new Sql(dataSource)
    	String query = "update flags set formstatus='UNVERIFIED',updator='system' where formstatus='UNDER VERIFICATION' and updator='"+updator+"'"
    	def res = sql.executeUpdate(query)
    	sql.close()
    	flash.message = "'UNDER VERIFICATION' verifications reset!!"
	redirect(action: "verificationStats") 
    
    }
    
    def uvDonor(){
    	def flags = Flags.findByUpdatorAndFormstatus(springSecurityService.principal.username,'UNDER VERIFICATION')
    	redirect(controller: "flags", action: "edit", id: flag?.id)
    }
    
    def sendSMS(String mobileNo, String message)
    {
    	println "Helper:mobileNo="+mobileNo
    	println "Helper:message="+message
    	render housekeepingService.sendSMS(mobileNo,message)
    }

    def message(){
	   println "Inside message with params: "+params
	  def emailAddrsList = []
	  def phoneNosList = []
	  def emailAddrs = ""
	  def phoneNos = ""
	  def individuals = []
	   switch (params.entity) {
	      case "Role":
		   def role = Role.get(params.id)
		   if(!role)
		   	{
		   	flash.message = "Role not found!!"+params.id
		   	break
		   	}
		   def individualRoleList = IndividualRole.findAllByRole(role)
		   individualRoleList.each{ir->
		   	individuals.add(ir.individual)
		   }
		   switch (params.via) {
		      case "EMAIL":
			  individuals.each{i->
			  	def ea = []
			  	EmailContact.findAllByIndividual(i).each{ec->
			  		ea.add(ec.emailAddress)
			  		}
			  	emailAddrsList.add(ea)
			  	emailAddrsList = emailAddrsList.flatten()
			  }
			emailAddrsList.each{e->
				emailAddrs += e +","
			}
			emailAddrs = emailAddrs.substring(0,emailAddrs.size()-1)
			  break
		      case "SMS":
			  individuals.each{i->
			  	def pn = []
			  	VoiceContact.findAllByIndividualAndCategory(i,'CellPhone').each{vc->
			  		pn.add(vc.number)
			  		}
			  	phoneNosList.add(pn)
			  	phoneNosList = phoneNosList.flatten()
			  }
			phoneNosList.each{p->
				phoneNos += p +","
			}
			phoneNos = phoneNos.substring(0,phoneNos.size()-1)
			  break
			}
	          break
	      default:
	          flash.message = params.entity +" Not found !! Id : " + params.id
		}
	    [via:params.via, emailAddrs:emailAddrs, phoneNos:phoneNos, individuals: individuals]
    }
    
    def sendmessage(){
	   switch (params.via) {
	      case "EMAIL":
		  housekeepingService.sendEmail(params.to?.tokenize(',;'),params.sub,params.msg)
		  flash.message = "EMAIL sent to : "+params.to+"\n with subject : "+params.sub +" and message : "+params.msg
		  break
	      case "SMS":
		  housekeepingService.sendSMS(params.to,params.msg)
		  flash.message = "SMS sent to : "+params.to+"\n with message : "+params.msg
		  break
		}
	redirect(controller: "role", action: "list")
    }
    
     def updateDb(String query) {
		println "In updateDb : query : "+query
		if(query)
			{
				def sql = new Sql(dataSource)
				def res = sql.executeUpdate(query)
				sql.close()
				render "Result of updateDb with query : "+query+" : " + res
			}
		else
			render "No query specified!!"
     }
     
     def bookReport = {
	}
	
     def courseReport = {
	}

     def sevaReport = {
	}
	
	def notifications() {
		def num = Motd.count();
		if (num>0)
		{
		def motdInstance = Motd.findById(new Random().nextInt(num)+1);
		render motdInstance?.quote +"<br><br>" + motdInstance?.reference
	    }
	    else
		render "Hare Krishna!"
	}

	def bdaysTodayCount = {
	      def now = new Date()
	      def today = now.format('D')

		def indList = Individual.createCriteria().list{
				relative1{
				eq("individual2",Individual.get(session.individualid))
				eq("relation",Relation.findByName("Cultivated by"))
				eq("status","ACTIVE")
				}
				//todo works in latest verion, sqlinjection safe sqlRestriction "dayofyear(dob) >= ? AND dayofyear(dob) <= ?", [1, 10]
				sqlRestriction "day(dob) = "+now.date+" AND month(dob) = "+((now.month).toInteger()+(1*1).toInteger())*1
			}
		//println 'indList='+indList
		//return indList
		render([count: indList.size()] as JSON)
	}

	def bdaysTomorrowCount() {
	      def now = new Date()
	      def today = now.format('D')
	      def tomorrow = now.next()
		def indList = Individual.createCriteria().list{
				relative1{
				eq("individual2",Individual.get(session.individualid))
				eq("relation",Relation.findByName("Cultivated by"))
				eq("status","ACTIVE")
				}
				//todo works in latest verion, sqlinjection safe sqlRestriction "dayofyear(dob) >= ? AND dayofyear(dob) <= ?", [1, 10]
				//sqlRestriction "dayofyear(dob) = "+today+1
				sqlRestriction "day(dob) = "+tomorrow.date+" AND month(dob) = "+((tomorrow.month).toInteger()+(1*1).toInteger())*1
			}
		//println 'indList='+indList
		//return indList
		render([count: indList.size()] as JSON)
	}

	def mannivsTodayCount() {
	      def now = new Date()
	      def today = now.format('D')
		def indList = Individual.createCriteria().list{
				relative1{
				eq("individual2",Individual.get(session.individualid))
				eq("relation",Relation.findByName("Cultivated by"))
				eq("status","ACTIVE")
				}
				//todo works in latest verion, sqlinjection safe sqlRestriction "dayofyear(marriage_anniversary) >= ? AND dayofyear(dob) <= ?", [1, 10]
				//sqlRestriction "dayofyear(marriage_anniversary) = "+today
				sqlRestriction "day(marriage_anniversary) = "+now.date+" AND month(marriage_anniversary) = "+((now.month).toInteger()+(1*1).toInteger())*1
			}
		//println 'indList='+indList
		//return indList
		render([count: indList.size()] as JSON)
	}
	
	def mannivsTomorrowCount() {
	      def now = new Date()
	      def today = now.format('D')
	      def tomorrow = now.next()
		def indList = Individual.createCriteria().list{
				relative1{
				eq("individual2",Individual.get(session.individualid))
				eq("relation",Relation.findByName("Cultivated by"))
				eq("status","ACTIVE")
				}
				//todo works in latest verion, sqlinjection safe sqlRestriction "dayofyear(dob) >= ? AND dayofyear(dob) <= ?", [1, 10]
				//sqlRestriction "dayofyear(marriage_anniversary) = "+today+1
				sqlRestriction "day(marriage_anniversary) = "+tomorrow.date+" AND month(marriage_anniversary) = "+((tomorrow.month).toInteger()+(1*1).toInteger())*1
			}
		//println 'indList='+indList
		//return indList
		render([count: indList.size()] as JSON)
	}
	
	def notificationsSummary() {
		
		def login1 = springSecurityService.principal.username

		def bcList = BouncedCheque.createCriteria().list()
			{
			donation{
					collectedBy{
						eq("loginid",login1)
					}
				}
			}
		def bccount = bcList.size()
		
		def panelContent = ""
		if (bccount>0)
			panelContent = '<b>You have '+bccount+' dishonoured cheque(s) to followup!!</b><br>'

		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
		{
			def login = springSecurityService.principal.username
			def displayString = ""

			if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
			{

				def cardsArrived = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(Individual.findByLoginid(login),"Card Arrived").lifeMember
				def cardsArrivedStr = cardsArrived.toString().replace("[","")
				cardsArrivedStr = cardsArrivedStr.toString().replace("]","")

				//println 'cardsArrivedStr='+cardsArrivedStr
				def cardsArrivedMsg = '<b>The card(s) for Life Patron(s) '+ cardsArrivedStr +' has(ve) arrived. Please collect.<b>' 

				if(cardsArrived.size() > 0)
					panelContent = panelContent + '\n\n'+cardsArrivedMsg
					
				def result
				
				result = housekeepingService.bdaysToday()
				if(result.size()>0)
				{
				     displayString = "<b>Devotees celebrating their birthday today:</b>\n<table border='1' cellspacing='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody>"
				     for(int i=0; i<result.size(); i++)
					displayString = displayString+"<tr><td><b>"+result[i]?.legalName+"</b></td><td><b>"+(result[i]?.initiatedName?:'')+"</b></td><td><b>"+result[i]?.dob?.format('dd-MM-yyyy')+"</b></td><td><b>"+result[i]?.address+"</b></td><td><b>"+result[i]?.voiceContact+"</b></td><td><b>"+result[i]?.emailContact+"</b></td></tr>"

				     displayString = displayString+"</tbody></table>"
				}
				else
					displayString = "<br>No Birthdays today."

				result = housekeepingService.mannivsToday()
				if(result.size()>0)
				{
				     displayString = displayString+"<br><b>Devotees celebrating their marriage anniversary today:</b>\n<table border='1' cellspacing='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody>"
				     for(int i=0; i<result.size(); i++)
					displayString = displayString+"<tr><td><b>"+result[i]?.legalName+"</b></td><td><b>"+(result[i]?.initiatedName?:'')+"</b></td><td><b>"+result[i]?.marriageAnniversary?.format('dd-MM-yyyy')+"</b></td><td><b>"+result[i]?.address+"</b></td><td><b>"+result[i]?.voiceContact+"</b></td><td><b>"+result[i]?.emailContact+"</b></td></tr>"

				     displayString = displayString+"</tbody></table>"
				}
				else
					displayString = displayString+"<br>No Marriage Anniversaries today."

				result = housekeepingService.bdaysTomorrow()
				if(result.size()>0)
				{
				     displayString = displayString+"<br><b>Devotees celebrating their birthday tomorrow:</b>\n<table border='1' cellspacing='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody>"
				     for(int i=0; i<result.size(); i++)
					displayString = displayString+"<tr><td><b>"+result[i]?.legalName+"</b></td><td><b>"+(result[i]?.initiatedName?:'')+"</b></td><td><b>"+result[i]?.dob?.format('dd-MM-yyyy')+"</b></td><td><b>"+result[i]?.address+"</b></td><td><b>"+result[i]?.voiceContact+"</b></td><td><b>"+result[i]?.emailContact+"</b></td></tr>"

				     displayString = displayString+"</tbody></table>"
				}
				else
					displayString = displayString+"<br>No Birthdays tomorrow."

				result = housekeepingService.mannivsTomorrow()
				if(result.size()>0)
				{
				     displayString = displayString+"<br><b>Devotees celebrating their marriage anniversary tomorrow:</b>\n<table border='1' cellspacing='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody>"
				     for(int i=0; i<result.size(); i++)
					displayString = displayString+"<tr><td><b>"+result[i]?.legalName+"</b></td><td><b>"+(result[i]?.initiatedName?:'')+"</b></td><td><b>"+result[i]?.marriageAnniversary?.format('dd-MM-yyyy')+"</b></td><td><b>"+result[i]?.address+"</b></td><td><b>"+result[i]?.voiceContact+"</b></td><td><b>"+result[i]?.emailContact+"</b></td></tr>"

				     displayString = displayString+"</tbody></table>"
				}
				else
					displayString = displayString+"<br>No Marriage Anniversaries tomorrow."
			}
			
			//displayString = "Devotees celebrating their birthday today or tomorrow:<table border='1' cellspacing='0' cellpadding='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody><tr><td><b>abp2</b></td><td><b>null</b></td><td><b>27-07-2012</b></td><td><b>[]</b></td><td><b>[]</b></td><td><b>[]</b></td></tr></tbody></table>"
			if (displayString == "")
				displayString = "No Birthdays/Marriage Anniversaries tomorrow."
			panelContent = panelContent + '\n\n'+displayString

		}
		render panelContent
	}
    
	def clornotificationsSummary() {
		def panelContent = ""
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_COUNSELLOR'))
		{
			def login = springSecurityService.principal.username
			def displayString = ""

				def result
				
				result = housekeepingService.bdaysToday()
				if(result.size()>0)
				{
				     displayString = "<b>Devotees celebrating their birthday today:</b>\n<table border='1' cellspacing='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody>"
				     for(int i=0; i<result.size(); i++)
					displayString = displayString+"<tr><td><b>"+result[i]?.legalName+"</b></td><td><b>"+(result[i]?.initiatedName?:'')+"</b></td><td><b>"+result[i]?.dob?.format('dd-MM-yyyy')+"</b></td><td><b>"+result[i]?.address+"</b></td><td><b>"+result[i]?.voiceContact+"</b></td><td><b>"+result[i]?.emailContact+"</b></td></tr>"

				     displayString = displayString+"</tbody></table>"
				}
				else
					displayString = "<br>No Birthdays today."

				result = housekeepingService.mannivsToday()
				if(result.size()>0)
				{
				     displayString = displayString+"<br><b>Devotees celebrating their marriage anniversary today:</b>\n<table border='1' cellspacing='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody>"
				     for(int i=0; i<result.size(); i++)
					displayString = displayString+"<tr><td><b>"+result[i]?.legalName+"</b></td><td><b>"+(result[i]?.initiatedName?:'')+"</b></td><td><b>"+result[i]?.marriageAnniversary?.format('dd-MM-yyyy')+"</b></td><td><b>"+result[i]?.address+"</b></td><td><b>"+result[i]?.voiceContact+"</b></td><td><b>"+result[i]?.emailContact+"</b></td></tr>"

				     displayString = displayString+"</tbody></table>"
				}
				else
					displayString = displayString+"<br>No Marriage Anniversaries today."

				result = housekeepingService.bdaysTomorrow()
				if(result.size()>0)
				{
				     displayString = displayString+"<br><b>Devotees celebrating their birthday tomorrow:</b>\n<table border='1' cellspacing='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody>"
				     for(int i=0; i<result.size(); i++)
					displayString = displayString+"<tr><td><b>"+result[i]?.legalName+"</b></td><td><b>"+(result[i]?.initiatedName?:'')+"</b></td><td><b>"+result[i]?.dob?.format('dd-MM-yyyy')+"</b></td><td><b>"+result[i]?.address+"</b></td><td><b>"+result[i]?.voiceContact+"</b></td><td><b>"+result[i]?.emailContact+"</b></td></tr>"

				     displayString = displayString+"</tbody></table>"
				}
				else
					displayString = displayString+"<br>No Birthdays tomorrow."

				result = housekeepingService.mannivsTomorrow()
				if(result.size()>0)
				{
				     displayString = displayString+"<br><b>Devotees celebrating their marriage anniversary tomorrow:</b>\n<table border='1' cellspacing='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody>"
				     for(int i=0; i<result.size(); i++)
					displayString = displayString+"<tr><td><b>"+result[i]?.legalName+"</b></td><td><b>"+(result[i]?.initiatedName?:'')+"</b></td><td><b>"+result[i]?.marriageAnniversary?.format('dd-MM-yyyy')+"</b></td><td><b>"+result[i]?.address+"</b></td><td><b>"+result[i]?.voiceContact+"</b></td><td><b>"+result[i]?.emailContact+"</b></td></tr>"

				     displayString = displayString+"</tbody></table>"
				}
				else
					displayString = displayString+"<br>No Marriage Anniversaries tomorrow."
			
			
			//displayString = "Devotees celebrating their birthday today or tomorrow:<table border='1' cellspacing='0' cellpadding='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody><tr><td><b>abp2</b></td><td><b>null</b></td><td><b>27-07-2012</b></td><td><b>[]</b></td><td><b>[]</b></td><td><b>[]</b></td></tr></tbody></table>"
			if (displayString == "")
				displayString = "No Birthdays/Marriage Anniversaries tomorrow."
			panelContent = panelContent + '\n\n'+displayString

		}
		render panelContent
	}
    
    def bcnotify = {
        def login = springSecurityService.principal.username
        
        def bcList = BouncedCheque.createCriteria().list()
        	{
        	donation{
				collectedBy{
					eq("loginid",login)
				}
        		}
        	}
	def bccount = bcList.size()
        
        render([count: bccount, text: 'You have '+bccount+' dishonoured cheque(s) to followup!!<br>'] as JSON)
	}

    def lifePatronCardArrivalNotification = {
	def login = springSecurityService.principal.username    
    	def cardsArrived = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(Individual.findByLoginid(login),"Card Arrived").lifeMember
	def cardsArrivedStr = cardsArrived.toString().replace("[","")
	cardsArrivedStr = cardsArrivedStr.toString().replace("]","")
    	
    	def cardsArrivedMsg = 'The card(s) for Life Patron(s) '+ cardsArrivedStr +' has(ve) arrived. Please collect.' 
    	render([count: cardsArrived.size(), text: cardsArrivedMsg] as JSON)
    }
  

    def cultivatorConflict = {
        def cultivatorConflictCount = Person.findAllByStatus("CONFLICT").size()
        render([count: cultivatorConflictCount, text: 'You have '+cultivatorConflictCount+' persons having cultivator conflicts to followup!!<br>'] as JSON)
	}

	def panel(String id) {


		def displayString = ""
		def result

	
		switch(id) {
			case "l1":
				result = housekeepingService.bdaysToday()
				if(result.size()>0)
				{
				     displayString = "<b>Devotees celebrating their birthday today:</b>\n<table border='1' cellspacing='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody>"
				     for(int i=0; i<result.size(); i++)
					displayString = displayString+"<tr><td><b><a href='/ics/individual/show?id="+result[i]?.id+"'>"+result[i]?.legalName+"</a></b></td><td><b>"+(result[i]?.initiatedName?:'')+"</b></td><td><b>"+result[i]?.dob?.format('dd-MM-yyyy')+"</b></td><td><b>"+result[i]?.address+"</b></td><td><b>"+result[i]?.voiceContact+"</b></td><td><b>"+result[i]?.emailContact+"</b></td></tr>"
				    
				     displayString = displayString+"</tbody></table>"
				}
				else
					displayString = "No Birthdays today."
			
				render displayString
				break
			case "l2":
				result = housekeepingService.mannivsToday()
				if(result.size()>0)
				{
				     displayString = "<b>Devotees celebrating their marriage anniversary today:</b>\n<table border='1' cellspacing='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>MarriageDate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody>"
				     for(int i=0; i<result.size(); i++)
					displayString = displayString+"<tr><td><b><a href='/ics/individual/show?id="+result[i]?.id+"'>"+result[i]?.legalName+"</a></b></td><td><b>"+(result[i]?.initiatedName?:'')+"</b></td><td><b>"+result[i]?.marriageAnniversary?.format('dd-MM-yyyy')+"</b></td><td><b>"+result[i]?.address+"</b></td><td><b>"+result[i]?.voiceContact+"</b></td><td><b>"+result[i]?.emailContact+"</b></td></tr>"
				     
				     displayString = displayString+"</tbody></table>"
				}
				else
					displayString = "No Marriage Anniversaries today."
				render displayString
				break
			case "r1":
				result = housekeepingService.bdaysTomorrow()
				if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
				{
					if(result.size()>0)
					{
					     displayString = "<b>Devotees celebrating their birthday tomorrow:</b>\n<table border='1' cellspacing='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody>"
					     for(int i=0; i<result.size(); i++)
						displayString = displayString+"<tr><td><b><a href='/ics/individual/show?id="+result[i]?.id+"'>"+result[i]?.legalName+"</a></b></td><td><b>"+(result[i]?.initiatedName?:'')+"</b></td><td><b>"+result[i]?.dob?.format('dd-MM-yyyy')+"</b></td><td><b>"+result[i]?.address+"</b></td><td><b>"+result[i]?.voiceContact+"</b></td><td><b>"+result[i]?.emailContact+"</b></td></tr>"
					     
					     displayString = displayString+"</tbody></table>"
					}
					else
						displayString = "No Birthdays tomorrow."
					render displayString
				}
				if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_NVCC_ADMIN'))
				{
					cultivatorConflictCount = Person.findAllByStatus("CONFLICT").size()
					render "There are "+cultivatorConflictCount+" persons having cultivator conflicts to followup!!"
				}				
				
				break
			case "r2":
				result = housekeepingService.mannivsTomorrow()
				if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
				{
					if(result.size()>0)
					{
					     displayString = "<b>Devotees celebrating their marriage anniversary tomorrow:</b>\n<table border='1' cellspacing='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>MarriageDate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody>"
					     for(int i=0; i<result.size(); i++)
						displayString = displayString+"<tr><td><b><a href='/ics/individual/show?id="+result[i]?.id+"'>"+result[i]?.legalName+"</a></b></td><td><b>"+(result[i]?.initiatedName?:'')+"</b></td><td><b>"+result[i]?.marriageAnniversary?.format('dd-MM-yyyy')+"</b></td><td><b>"+result[i]?.address+"</b></td><td><b>"+result[i]?.voiceContact+"</b></td><td><b>"+result[i]?.emailContact+"</b></td></tr>"
					     
					     displayString = displayString+"</tbody></table>"
					}
					else
						displayString = "No Marriage Anniversaries tomorrow."
					render displayString
				}
				if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_NVCC_ADMIN'))
				{
					matchedContacts = Person.findAllByStatusOrStatus("MATCHED","AUTOMATCHED")
					render "There are "+matchedContacts+" matched contacts"
				}				
				
				break
			default:
				render "Chant Hare Krishna and Be Happy!!"
				
		}
		
		return 
	}
	
	def pendingItems = {	
		def login = springSecurityService.principal.username
		//def pendingItemsListCount = 0
		
		def bcList = BouncedCheque.createCriteria().list()
			{
			donation{
					collectedBy{
						eq("loginid",login)
					}
				}
			}
		def bccount = bcList.size()
		
		def pendingItemsList = []
		def bcPendingItem = ""
		
		if (bccount>0)
		{
			//pendingItemsList.add('<b>You have '+bccount+' dishonoured cheque(s) to followup.<br>')
			bcPendingItem = '<b>You have '+bccount+' dishonoured cheque(s) to followup.</b><br>'
			for(int i=0; i<bccount; i++)
			{
				bcPendingItem = bcPendingItem +'<table width="50%"><tr><td width="1%">'+(i.toInteger()+1)+'</td><td width="3%">Donor</td><td width="30%">'+bcList[i].issuedBy+'</td></tr>'
				bcPendingItem = bcPendingItem +'<tr><td width="1%"></td><td width="3%">Cheque No.</td><td width="30%">'+bcList[i].chequeNo+'</td></tr>'
				bcPendingItem = bcPendingItem +'<tr><td width="1%"></td><td width="3%">Cheque Date</td><td width="30%">'+bcList[i].chequeDate?.format('dd-MM-yyyy')+'</td></tr>'
				bcPendingItem = bcPendingItem +'<tr><td width="1%"></td><td width="3%">Bank</td><td width="30%">'+bcList[i].bankName+'</td></tr>'
				bcPendingItem = bcPendingItem +'<tr><td width="1%"></td><td width="3%">Branch</td><td width="30%">'+bcList[i].branchName+'</td></tr></table>'
			}
			//pendingItemsListCount++
			pendingItemsList.add(bcPendingItem)
		}
			
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
		{

			def cardsArrived = LifeMembershipCard.findAllByOriginatingDeptCollectorAndCardStatus(Individual.findByLoginid(login),"Card Arrived").lifeMember
			def cardsArrivedStr = cardsArrived.toString().replace("[","")
			cardsArrivedStr = cardsArrivedStr.toString().replace("]","")
			cardsArrivedStr = cardsArrivedStr.toString().replace(",","<br>")

			//println 'cardsArrivedStr='+cardsArrivedStr
			def cardsArrivedMsg = '<b>The card(s) for Life Patron(s)</b><br>'+ cardsArrivedStr +'<br><b>has(ve) arrived. Please collect.</b>' 

			if(cardsArrived.size() > 0)
			{
				pendingItemsList.add(cardsArrivedMsg)
				//pendingItemsListCount++
			}
		}
		
		//render([count: pendingItemsList.size(), text: pendingItemsList] as JSON)
		return [pendingItemsList: pendingItemsList]
	}

	def generateLogin() {
		def rglist = RelationshipGroup.findAllByGroupNameLike('CG%')
		rglist.each{rg->
			//check if the group leader has loginid or not else create
			def gl = Individual.get(rg.refid)
			housekeepingService.createLogin(gl,IcsRole.findByAuthority('ROLE_COUNSELLOR_GROUP'))
			//now do it for all the group members
			def rships = Relationship.findAllByRelationshipGroupAndStatus(rg,'ACTIVE')
			rships.each{rship->
				housekeepingService.createLogin(rship.individual1,IcsRole.findByAuthority('ROLE_COUNSELLOR'))
			}
		}
	}
	
	def eventDashboard() {
	}

	def eventRegistrationSummaryByStatusData() {
		def vipFlag = false
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION,ROLE_VIP_TRANSPORTATION,ROLE_VIP_PRASADAM'))
			vipFlag = true
		else 
			vipFlag = false

		def result = dataService.eventRegistrationSummaryByStatusData(vipFlag)
		render( result as JSON)
	}

	def eventRegistrationSummaryData() {
		def vipFlag = false
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION,ROLE_VIP_TRANSPORTATION,ROLE_VIP_PRASADAM'))
			vipFlag = true
		else 
			vipFlag = false

		def result = dataService.eventRegistrationSummaryData(vipFlag)
		render( result as JSON)
	}

	def eventRegistrationDetailData() {
		def vipFlag = false
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION,ROLE_VIP_TRANSPORTATION,ROLE_VIP_PRASADAM'))
			vipFlag = true
		else 
			vipFlag = false

		def result = dataService.eventRegistrationDetailData(vipFlag)
		render( result as JSON)
	}

	def eventSummaryData() {
		def vipFlag = false
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION,ROLE_VIP_TRANSPORTATION,ROLE_VIP_PRASADAM'))
			vipFlag = true
		else 
			vipFlag = false

		def result = dataService.eventSummaryData(vipFlag)
		render( result as JSON)
	}
	
	def genLoginLocal() {
		def loginMap=""
		def icsRole = IcsRole.findByAuthority('ROLE_RVTO_COUNSELOR')
		def indlist = Individual.findAllByCategory('RVTOCounselor')
		def login
		indlist.each{
			login=null
			login=housekeepingService.createLogin(it,icsRole)
			if(login)
				loginMap += it.legalName+"->"+login+";"
			}
		[loginMap: loginMap]
	}
	
	def eventRegReport() {
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=RegistrationReport.${params.extension}")
			List fields = ["regCode", "name","connectedIskconCenter","contactNumber","email","creator","numberofPrabhujis","numberofMatajis","numberofChildren","numberofBrahmacharis","verificationStatus","isAccommodationRequired","accommodationAllotmentStatus","guestType","arrivalDate","departureDate","isTravelingPrasadRequired","noofBreakfasts","noofLunches","noofDinners","pickUpRequired","dropRequired","updator","lastUpdated","creator","dateCreated"]
			Map labels = ["regCode": "RegistrationCode", "connectedIskconCenter": "ConnectedIskconCenter","contactNumber":"ContactNumber","email":"Email","creator":"RegisteredBy","numberofPrabhujis":"Prabhujis","numberofMatajis":"Matajis","numberofChildren":"Children","numberofBrahmacharis":"Brahmacharis","verificationStatus":"VerificationStatus","isAccommodationRequired":"AccommodationRequired","accommodationAllotmentStatus":"AccommodationAllotmentStatus","guestType":"GuestType","arrivalDate":"ArrivalDateTime","departureDate":"DepartureDateTime","isTravelingPrasadRequired":"Travel Prasadam Needed?","noofBreakfasts":"Breakfast Packets","noofLunches":"Lunch Packets","noofDinners":"Dinner Packets","pickUpRequired":"Pickup Required","dropRequired":"Drop Required","updator":"updator","lastUpdated":"lastUpdated","creator":"creator","dateCreated":"dateCreated"]
			//exportService.export(params.format, response.outputStream,EventRegistration.findAllByStatusIsNull(), [:], [:])
			if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION'))
				exportService.export(params.format, response.outputStream, EventRegistration.findAllByStatusIsNullAndIsVipDevotee(true), fields, labels, [:], [:])
			else if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_REGISTRATION_COORDINATOR,ROLE_ACCOMMODATION_COORDINATOR'))
				exportService.export(params.format, response.outputStream, EventRegistration.findAllByStatusIsNullAndIsVipDevotee(false), fields, labels, [:], [:])
			else if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_EVENTADMIN'))
				exportService.export(params.format, response.outputStream, EventRegistration.findAllByStatusIsNull(), fields, labels, [:], [:])
		}	
	}
	
	def eventRegWithAccoReportOld() {
		if(params?.format && params.format != "html"){
		      //get the data
		      def result
		      def sql = new Sql(dataSource);
		      String baseQuery = "select er.reg_code regCode,er.name name,er.connected_iskcon_center connectedIskconCenter, er.contact_number contactNumber,er.email email,er.creator creator,er.numberof_prabhujis numberofPrabhujis,er.numberof_matajis numberofMatajis,er.numberof_children numberofChildren,er.numberof_brahmacharis numberofBrahmacharis,er.verification_status verificationStatus,er.is_accommodation_required isAccommodationRequired,er.accommodation_allotment_status accommodationAllotmentStatus,er.guest_type guestType,date_format(er.arrival_date,'%d/%m/%y %H:%i') arrivalDate,date_format(er.departure_date,'%d/%m/%y %H:%i') departureDate, er.is_traveling_prasad_required isTravelingPrasadRequired, er.noof_breakfasts noofBreakfasts, er.noof_lunches noofLunches,er.noof_dinners noofDinners,er.pick_up_required pickUpRequired, er.drop_required dropRequired,er.updator updator, date_format(er.last_updated,'%d/%m/%y %H:%i:%s:%f') lastUpdated, er.creator creator,date_format(er.date_created,'%d/%m/%y %H:%i:%s:%f') dateCreated,a.acconame accommodation from event_registration er left join (select aa.event_registration_id id,ea.name acconame,ea.address,ea.comments,ea.rank_overall from accommodation_allotment aa , event_accommodation ea where aa.event_accommodation_id=ea.id) a on er.id=a.id where er.verification_status='VERIFIED' and er.status is null"
		      String query = baseQuery +" and is_vip_devotee=false"
		      String vipQuery=baseQuery +" and is_vip_devotee=true"


			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=RegistrationReportWithAcco.${params.extension}")
			List fields = ["regCode", "name","connectedIskconCenter","contactNumber","email","creator","numberofPrabhujis","numberofMatajis","numberofChildren","numberofBrahmacharis","verificationStatus","isAccommodationRequired","accommodationAllotmentStatus","guestType","arrivalDate","departureDate","isTravelingPrasadRequired","noofBreakfasts","noofLunches","noofDinners","pickUpRequired","dropRequired","updator","lastUpdated","creator","dateCreated","accommodation"]
			Map labels = ["regCode": "RegistrationCode", "connectedIskconCenter": "ConnectedIskconCenter","contactNumber":"ContactNumber","email":"Email","creator":"RegisteredBy","numberofPrabhujis":"Prabhujis","numberofMatajis":"Matajis","numberofChildren":"Children","numberofBrahmacharis":"Brahmacharis","verificationStatus":"VerificationStatus","isAccommodationRequired":"AccommodationRequired","accommodationAllotmentStatus":"AccommodationAllotmentStatus","guestType":"GuestType","arrivalDate":"ArrivalDateTime","departureDate":"DepartureDateTime","isTravelingPrasadRequired":"Travel Prasadam Needed?","noofBreakfasts":"Breakfast Packets","noofLunches":"Lunch Packets","noofDinners":"Dinner Packets","pickUpRequired":"Pickup Required","dropRequired":"Drop Required","updator":"updator","lastUpdated":"lastUpdated","creator":"creator","dateCreated":"dateCreated","accommodation":"Accommodation"]
			//exportService.export(params.format, response.outputStream,EventRegistration.findAllByStatusIsNull(), [:], [:])
			if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION'))
				{
			      result = sql.rows(vipQuery)
				}
			else if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_REGISTRATION_COORDINATOR,ROLE_ACCOMMODATION_COORDINATOR'))
				{
			      result = sql.rows(query)
				}
			else if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_EVENTADMIN'))
				{
			      result = sql.rows(baseQuery)
				}
		      sql.close()
			exportService.export(params.format, response.outputStream, result, fields, labels, [:], [:])

		}	
	}



	
	def eventRegWithAccoReport() {
		if(params?.format && params.format != "html"){
		      //get the data
		      def result
		      def sql = new Sql(dataSource);
		      String baseQuery = "select * from event_registration er left join (select aa.event_registration_id,ea.name HostName from accommodation_allotment aa , event_accommodation ea where aa.event_accommodation_id=ea.id) a on er.id=a.event_registration_id "
		      String query = baseQuery +" where er.is_vip_devotee = false"
		      String vipQuery="select name guest_Name,guest_Type,other_Guest_Type,numberof_Brahmacharis,numberof_Prabhujis,numberof_Matajis,numberof_Children,email,contact_Number,pick_Up_Required,arrival_Date,arrival_Number,arrival_Point,arrival_Transport_Mode,arrival_Traveling_Details,drop_Required,departure_Date,departure_Name,departure_Number,departure_Point,departure_Transport_Mode,departure_Traveling_Details,host_Name,host_Mobile_Number,host_Email,special_Instructions,verification_Status from event_registration er left join (select aa.event_registration_id,ea.name host_Name,ea.host_Mobile_Number,ea.host_Email from accommodation_allotment aa , event_accommodation ea where aa.event_accommodation_id=ea.id) a on er.id=a.event_registration_id  where er.is_vip_devotee = true"


			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=RegistrationReportWithAcco.${params.extension}")
			List fields = []
			Map labels = [:]
			//exportService.export(params.format, response.outputStream,EventRegistration.findAllByStatusIsNull(), [:], [:])
			if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION'))
				{
			      result = sql.rows(vipQuery)
			      fields = ['guest_Name','guest_Type','other_Guest_Type','numberof_Brahmacharis','numberof_Prabhujis','numberof_Matajis','numberof_Children','email','contact_Number','pick_Up_Required','arrival_Date','arrival_Number','arrival_Point','arrival_Transport_Mode','arrival_Traveling_Details','drop_Required','departure_Date','departure_Name','departure_Number','departure_Point','departure_Transport_Mode','departure_Traveling_Details','host_Name','host_Mobile_Number','host_Email','special_Instructions','verification_Status']
				}
			else if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_REGISTRATION_COORDINATOR,ROLE_ACCOMMODATION_COORDINATOR'))
				{
			      result = sql.rows(query)
				}
			else if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_EVENTADMIN'))
				{
			      result = sql.rows(baseQuery)
				}
		      sql.close()
			exportService.export(params.format, response.outputStream, result, fields, labels, [:], [:])

		}	
	}
	
	def eventRegLocalReport() {
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=PuneRegistrationReport.${params.extension}")
			List fields = ["name", "category","phone","relation","reference"]
			Map labels = ["name": "Name", "category": "Category","phone":"Phone","relation":"Counselor","reference":"Service"]
			
			//exportService.export(params.format, response.outputStream,Person.findAllByStatus('RVTO_LOCAL_REG'), [:], [:])
			exportService.export(params.format, response.outputStream, Person.findAllByStatus('RVTO_LOCAL_REG'), fields, labels, [:], [:])
		}	
	}
	
	def eventServiceAllotmentReport() {
		log.debug("eventServiceAllotmentReport")
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=ServiceAllotmentReport.${params.extension}")
			List fields = ["eventSeva.seva.name","person.name", "person.category","person.phone","person.relation"]
			Map labels = ["eventSeva.seva.name":"Service","person.name": "Name", "person.category": "Category","person.phone":"Phone","person.relation":"Counselor"]
			exportService.export(params.format, response.outputStream, EventSevaAllotment.list(), fields, labels, [:], [:])
		}	
	}
	
	def eventServiceAllotmentOPReport() {
		log.debug("eventServiceAllotmentReport")
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=OutsidePuneServiceAllotmentReport.${params.extension}")
			List fields = ["eventSeva.seva.name","eventRegistration.name", "eventRegistration.regCode","eventRegistration.connectedIskconCenter","eventRegistration.contactNumber"]
			Map labels = ["eventSeva.seva.name":"Service","eventRegistration.name": "Name", "eventRegistration.regCode": "RegCode","eventRegistration.connectedIskconCenter":"Centre","eventRegistration.contactNumber":"Contact"]
			exportService.export(params.format, response.outputStream, EventSevaGroupAllotment.list(), fields, labels, [:], [:])
		}	
	}
	
	def eventAccoReport() {
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=AccommodationReport.${params.extension}")
			List fields = ["name", "address","distanceFromNVCC","hostMobileNumber","accommodationInChargeName","accommodationInChargeContactNumber","maxCapacity","comments"]
			Map labels = ["name": "Name","address": "Address","distanceFromNVCC":"DistanceFromNVCC","hostMobileNumber": "HostMobileNumber","accommodationInChargeName": "DevoteeInCharge","accommodationInChargeContactNumber": "DevoteeInChargeContactNumber","maxCapacity": "MaxCapacity","comments":"Comments"]
			if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION'))
				exportService.export(params.format, response.outputStream, EventAccommodation.findAllByIsVipAccommodationAndStatusIsNull(true), fields, labels, [:], [:])
			else if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_REGISTRATION_COORDINATOR,ROLE_ACCOMMODATION_COORDINATOR'))
				exportService.export(params.format, response.outputStream, EventAccommodation.findAllByIsVipAccommodationAndStatusIsNull(false), fields, labels, [:], [:])
			else
				exportService.export(params.format, response.outputStream, EventAccommodation.findAllByStatusIsNull(), fields, labels, [:], [:])
		}	
	}
	
	def eventAccoAllotmentReport() {
		log.debug("eventAccoAllotmentReport")
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=AccommodationAllotmentReport.${params.extension}")
			List fields = ["eventAccommodation.name","eventRegistration.name","eventRegistration.regCode","numberofPrabhujisAllotted","numberofMatajisAllotted","numberofChildrenAllotted","numberofBrahmacharisAllotted","eventRegistration.arrivalDate","eventRegistration.departureDate"]
			Map labels = ["eventAccommodation.name":"Accommodation Name","eventRegistration.name":"GroupLeaderName","eventRegistration.regCode":"Registration Code","numberofPrabhujisAllotted":"PrabhujisAllotted","numberofMatajisAllotted":"MatajisAllotted","numberofChildrenAllotted":"ChildrenAllotted","numberofBrahmacharisAllotted":"BrahmacharisAllotted","eventRegistration.arrivalDate":"ArrivalDate","eventRegistration.departureDate":"DepartureDate"]
			if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION'))
				exportService.export(params.format, response.outputStream, AccommodationAllotment.createCriteria().list{eventRegistration{eq("isVipDevotee",true) eq("verificationStatus",VerificationStatus.VERIFIED) isNull("status")}}, fields, labels, [:], [:])
			else if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_REGISTRATION_COORDINATOR,ROLE_ACCOMMODATION_COORDINATOR'))
				exportService.export(params.format, response.outputStream, AccommodationAllotment.createCriteria().list{eventRegistration{eq("isVipDevotee",false) eq("verificationStatus",VerificationStatus.VERIFIED) isNull("status")}}, fields, labels, [:], [:])
			else
				exportService.export(params.format, response.outputStream, AccommodationAllotment.list(), fields, labels, [:], [:])
		}	
	}
	
	def eventAccoCheckinReport() {
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=AccommodationCheckinReport.${params.extension}")
			List fields = ["eventAccommodation.name","eventRegistration.name","eventRegistration.regCode","subEventRegistration.name","subEventRegistration.contactNumber","numberofPrabhujisCheckedin","numberofMatajisCheckedin","numberofChildrenCheckedin","numberofBrahmacharisCheckedin"]
			Map labels = ["eventAccommodation.name":"Accommodation Name","eventRegistration.name":"Main Group Leader Name","eventRegistration.regCode":"Registration Code","subEventRegistration.name":"SubGroup Leader Name","subEventRegistration.contactNumber":"SubGroup Leader Contact","numberofPrabhujisCheckedin":"PrabhujisCheckedin","numberofMatajisCheckedin":"MatajisCheckedin","numberofChildrenCheckedin":"ChildrenCheckedin","numberofBrahmacharisCheckedin":"BrahmacharisCheckedin"]
			if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION'))
				exportService.export(params.format, response.outputStream, AccommodationAllotment.createCriteria().list{eventRegistration{eq("isVipDevotee",true)} isNotNull('subEventRegistration')}, fields, labels, [:], [:])
			else if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_REGISTRATION_COORDINATOR,ROLE_ACCOMMODATION_COORDINATOR'))
				exportService.export(params.format, response.outputStream, AccommodationAllotment.createCriteria().list{eventRegistration{eq("isVipDevotee",false)} isNotNull('subEventRegistration')}, fields, labels, [:], [:])
			else
				exportService.export(params.format, response.outputStream, AccommodationAllotment.list(), fields, labels, [:], [:])
		}	
	}

	def eventVehicleReport() {
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=VehicleReport.${params.extension}")
			List fields = ["vehicle.regNum","source","departureTime","destination","arrivalTime","inchargeName","inchargeNumber","driverName","driverNumber","comments"]
			Map labels = ["vehicle.regNum":"Vehicle RegNum","source":"FromLocation","departureTime":"FromTime","destination":"ToLocation","arrivalTime":"ToTime","inchargeName":"InchargeName","inchargeNumber":"InchargeNumber","driverName":"DriverName","driverNumber":"DriverNumber","comments":"Comments"]
			if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION'))
				exportService.export(params.format, response.outputStream, Trip.createCriteria().list{vehicle{eq("vipExclusive",true)}}, fields, labels, [:], [:])
			else if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_TRANSPORTATION_COORDINATOR'))
				exportService.export(params.format, response.outputStream, Trip.createCriteria().list{vehicle{eq("vipExclusive",false)}}, fields, labels, [:], [:])
			else
				exportService.export(params.format, response.outputStream, Trip.list(), fields, labels, [:], [:])
		}	
	}
	
	def eventArrivalReport() {
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=ArrivalReport.${params.extension}")
			List fields = ["arrivalDate","arrivalPoint","name","contactNumber","regCode","arrivalTransportMode","arrivalNumber","arrivalName","arrivalTravelingDetails","numberofPrabhujis","numberofMatajis","numberofChildren","numberofBrahmacharis"]
			Map labels = ["arrivalDate":"DateTime","arrivalPoint":"Location","name":"GroupLeaderName","contactNumber":"Contact","regCode":"RegCode","arrivalTransportMode":"Mode","arrivalNumber":"Number","arrivalName":"Name","arrivalTravelingDetails":"Details","numberofPrabhujis":"Prji","numberofMatajis":"Mataji","numberofChildren":"Children","numberofBrahmacharis":"Brahmachari/Student"]
			if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION'))
				exportService.export(params.format, response.outputStream, EventRegistration.createCriteria().list{
					eq('isVipDevotee',true)
					eq('verificationStatus',VerificationStatus.VERIFIED)
					isNull('status')
					eq('pickUpRequired',true)
				}, fields, labels, [:], [:])
			else if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_TRANSPORTATION_COORDINATOR'))
				exportService.export(params.format, response.outputStream, EventRegistration.createCriteria().list{
					eq('isVipDevotee',false)
					eq('verificationStatus',VerificationStatus.VERIFIED)
					isNull('status')
					eq('pickUpRequired',true)
				}, fields, labels, [:], [:])
			else
				exportService.export(params.format, response.outputStream, EventRegistration.createCriteria().list{
					eq('verificationStatus',VerificationStatus.VERIFIED)
					isNull('status')
					eq('pickUpRequired',true)
				}, fields, labels, [:], [:])
		}	
	}
	
	def eventDepartureReport() {
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=DepartureReport.${params.extension}")
			List fields = ["departureDate","departurePoint","name","contactNumber","regCode","departureTransportMode","departureNumber","departureName","departureTravelingDetails","numberofPrabhujis","numberofMatajis","numberofChildren","numberofBrahmacharis"]
			Map labels = ["departureDate":"DateTime","departurePoint":"Location","name":"GroupLeaderName","contactNumber":"Contact","regCode":"RegCode","departureTransportMode":"Mode","departureNumber":"Number","departureName":"Name","departureTravelingDetails":"Details","numberofPrabhujis":"Prji","numberofMatajis":"Mataji","numberofChildren":"Children","numberofBrahmacharis":"Brahmachari/Student"]
			if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION'))
				exportService.export(params.format, response.outputStream, EventRegistration.createCriteria().list{
					eq('isVipDevotee',true)
					eq('verificationStatus',VerificationStatus.VERIFIED)
					isNull('status')
					eq('dropRequired',true)
				}, fields, labels, [:], [:])
			else if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_TRANSPORTATION_COORDINATOR'))
				exportService.export(params.format, response.outputStream, EventRegistration.createCriteria().list{
					eq('isVipDevotee',false)
					eq('verificationStatus',VerificationStatus.VERIFIED)
					isNull('status')
					eq('dropRequired',true)
				}, fields, labels, [:], [:])
			else
				exportService.export(params.format, response.outputStream, EventRegistration.createCriteria().list{
					eq('verificationStatus',VerificationStatus.VERIFIED)
					isNull('status')
					eq('dropRequired',true)
				}, fields, labels, [:], [:])
		}	
	}

	def eventDepartureActualReport() {
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=DepartureActualReport.${params.extension}")
			List fields = ["mainEventRegistration.departureDate","mainEventRegistration.departurePoint","mainEventRegistration.name","mainEventRegistration.contactNumber","mainEventRegistration.regCode","mainEventRegistration.departureTransportMode","mainEventRegistration.departureNumber","mainEventRegistration.departureName","mainEventRegistration.departureTravelingDetails","mainEventRegistration.numberofPrabhujis","mainEventRegistration.numberofMatajis","mainEventRegistration.numberofChildren","mainEventRegistration.numberofBrahmacharis"]
			Map labels = ["mainEventRegistration.departureDate":"DateTime","mainEventRegistration.departurePoint":"Location","mainEventRegistration.name":"GroupLeaderName","mainEventRegistration.contactNumber":"Contact","mainEventRegistration.regCode":"RegCode","mainEventRegistration.departureTransportMode":"Mode","mainEventRegistration.departureNumber":"Number","mainEventRegistration.departureName":"Name","mainEventRegistration.departureTravelingDetails":"Details","mainEventRegistration.numberofPrabhujis":"Prji","mainEventRegistration.numberofMatajis":"Mataji","mainEventRegistration.numberofChildren":"Children","mainEventRegistration.numberofBrahmacharis":"Brahmachari/Student"]
			if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION'))
				exportService.export(params.format, response.outputStream, EventRegistrationGroup.createCriteria().list{
					mainEventRegistration{eq('isVipDevotee',true)}
					mainEventRegistration{eq('dropRequired',true)}
				}, fields, labels, [:], [:])
			else if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_TRANSPORTATION_COORDINATOR'))
				exportService.export(params.format, response.outputStream, EventRegistrationGroup.createCriteria().list{
					mainEventRegistration{eq('isVipDevotee',false)}
					mainEventRegistration{eq('dropRequired',true)}
				}, fields, labels, [:], [:])
			else
				exportService.export(params.format, response.outputStream, EventRegistrationGroup.createCriteria().list{
					mainEventRegistration{eq('dropRequired',true)}
				}, fields, labels, [:], [:])
		}	
	}

	def eventTripReport() {
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=TripReport.${params.extension}")
			List fields = ["trip.vehicle.regNum","trip.source","trip.departureTime","trip.destination","trip.arrivalTime","trip.inchargeName","trip.inchargeNumber","trip.driverName","trip.driverNumber","trip.comments","eventRegistration.name","eventRegistration.contactNumber","eventRegistration.connectedIskconCenter","eventRegistration.regCode","eventRegistration.numberofPrabhujis","eventRegistration.numberofMatajis","eventRegistration.numberofChildren","eventRegistration.numberofBrahmacharis","eventRegistration.arrivalDate","eventRegistration.arrivalPoint","eventRegistration.arrivalTransportMode","eventRegistration.arrivalNumber","eventRegistration.arrivalName","eventRegistration.arrivalTravelingDetails","eventRegistration.departureDate","eventRegistration.departurePoint","eventRegistration.departureTransportMode","eventRegistration.departureNumber","eventRegistration.departureName","eventRegistration.departureTravelingDetails"]
			Map labels = ["trip.vehicle.regNum":"Vehicle RegNum","trip.source":"TripFrom","trip.departureTime":"TripFromTime","trip.destination":"TripTo","trip.arrivalTime":"TripToTime","trip.inchargeName":"TripIncharge","trip.inchargeNumber":"TripInchargeNumber","trip.driverName":"TripDriver","trip.driverNumber":"TripDriverNumber","trip.comments":"TripComments","eventRegistration.name":"GroupLeaderName","eventRegistration.contactNumber":"GLContact","eventRegistration.connectedIskconCenter":"GL Temple/Centre","eventRegistration.regCode":"RegCode","eventRegistration.numberofPrabhujis":"Prji","eventRegistration.numberofMatajis":"Mataji","eventRegistration.numberofChildren":"Childreb","eventRegistration.numberofBrahmacharis":"Brahmachari/Student","eventRegistration.arrivalDate":"Arrival","eventRegistration.arrivalPoint":"ArrivalLocation","eventRegistration.arrivalTransportMode":"ArrivalMode","eventRegistration.arrivalNumber":"ArrivalNumber","eventRegistration.arrivalName":"ArrivalName","eventRegistration.arrivalTravelingDetails":"ArrivalDetails","eventRegistration.departureDate":"Departure","eventRegistration.departurePoint":"DepartureLocation","eventRegistration.departureTransportMode":"DepartureMode","eventRegistration.departureNumber":"DepartureNumber","eventRegistration.departureName":"DepartureName","eventRegistration.departureTravelingDetails":"DepartureDetails"]
			if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION'))
				exportService.export(params.format, response.outputStream, TripAllotment.createCriteria().list{
					eventRegistration{eq('isVipDevotee',true)}
				}, fields, labels, [:], [:])
			else if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_TRANSPORTATION_COORDINATOR'))
				exportService.export(params.format, response.outputStream, TripAllotment.createCriteria().list{
					eventRegistration{eq('isVipDevotee',false)}
				}, fields, labels, [:], [:])
			else
				exportService.export(params.format, response.outputStream, TripAllotment.createCriteria().list{
				}, fields, labels, [:], [:])
		}	
	}

	def eventServiceInchargeReport() {
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=VolunteerReport.${params.extension}")
			List fields = ["eventSeva.seva.name","person.name","person.category","person.phone","person.relation"]
			Map labels = ["eventSeva.seva.name":"Service","person.name":"Name","person.category":"Category","person.phone":"Phone","person.relation":"Volunteer's Counsellor"]
				exportService.export(params.format, response.outputStream, EventSevaAllotment.createCriteria().list{
					eventSeva{eq('inchargeName',session.individualname)}
				}, fields, labels, [:], [:])
		}	
	}

	def eventSendSMS() {
		log.debug("In eventSendSMS:"+params)
		def phonenoList = []
		def phonenos = ""
		int count=0
		def val=""
		switch(params.entityName) {
			case "EventRegistration":
				params.ids?.tokenize(',').each {
						val=EventRegistration.get(it)?.contactNumber
						if(val)
							{
							phonenoList.add(val)
							count++
							}
					}
				break
			case "EventSeva":
				params.ids?.tokenize(',').each {
						val=EventSeva.get(it)?.inchargeContact
						if(val)
							{
							phonenoList.add(val)
							count++
							}
					}
				break
			case "EventSevaAllotment":
				params.ids?.tokenize(',').each {
						val=EventSevaAllotment.get(it)?.person?.phone
						if(val)
							{
							phonenoList.add(val)
							count++
							}
					}
				break
			case "Person":
				params.ids?.tokenize(',').each {
						val=Person.get(it)?.phone
						if(val)
							{
							phonenoList.add(val)
							count++
							}
					}
				break
			case "Vehicle":
				params.ids?.tokenize(',').each {
						val=Vehicle.get(it)?.driverNumber
						if(val)
							{
							phonenoList.add(val)
							count++
							}
					}
				break
			case "Individual":
				params.ids?.tokenize(',').each {
						val=VoiceContact.findByCategoryAndIndividual('CellPhone',Individual.get(it))?.number
						if(val)
							{
							phonenoList.add(val)
							count++
							}
					}
				break
			case "IndividualRole":
				params.ids?.tokenize(',').each {
						val=VoiceContact.findByCategoryAndIndividual('CellPhone',IndividualRole.get(it)?.individual)?.number
						if(val)
							{
							phonenoList.add(val)
							count++
							}
					}
				break
			default:
				break
				
		}
		def phonenoSet = phonenoList as Set
		phonenoSet.each{phonenos+=it+","}
		//now add ccNos if any
		log.debug(phonenos)
		if(params.ccNos)
			phonenos+=params.ccNos
		log.debug(phonenos)			
		housekeepingService.sendGenericSMS(phonenos,params.smstext)
		render([count:phonenoSet.size()] as JSON)
	}
	
	def eventSendEMAIL() {
		log.debug("In eventSendEMAIL:"+params)
		def emailList = []
		def emails = ""
		int count=0
		def val=""
		switch(params.entityName) {
			case "EventRegistration":
				params.ids?.tokenize(',').each {
						val=EventRegistration.get(it)?.email
						if(val)
							{
							emailList.add(val)
							count++
							}
					}
				break
			case "EventSeva":
				params.ids?.tokenize(',').each {
						val=EventSeva.get(it)?.inchargeEmail
						if(val)
							{
							emailList.add(val)
							count++
							}
					}
				break
			case "Individual":
				params.ids?.tokenize(',').each {
						val=EmailContact.findByCategoryAndIndividual('Personal',Individual.get(it))?.emailAddress
						if(val)
							{
							emailList.add(val)
							count++
							}
					}
				break
			case "IndividualRole":
				params.ids?.tokenize(',').each {
						val=EmailContact.findByCategoryAndIndividual('Personal',IndividualRole.get(it)?.individual)?.number
						if(val)
							{
							emailList.add(val)
							count++
							}
					}
				break
			default:
				break
				
		}
		def emailSet = emailList as Set
		housekeepingService.sendGenericEMAIL(emailSet as List,params.emailfrom,params.emailsub,params.emailbody,params.ccSender,params.bccRecipients)
		render([count:emailSet.size()] as JSON)
	}
	
	def eventCheckSMSBalance() {
		def retVal = housekeepingService.getSMSBalance()
		render([balance:retVal] as JSON)
	}
	
	def generateEventSeva() {
		def event = Event.findByTitle('RVTO')
		def sevaList = Seva.findAllByCategory("RVTO")
		sevaList.each {
			if(it.name!="Would not be able to render service")
				{
				def eventSeva = EventSeva.findBySeva(it)
				if(!eventSeva)
					{
					eventSeva = new EventSeva()
					eventSeva.seva = it
					eventSeva.event = event
					eventSeva.updator = eventSeva.creator = "system"
					  if (!eventSeva.save())
					    eventSeva.errors.allErrors.each {
						log.debug(it)
						}
					}
				}
		}
	}
	
	def eventGenACS() {
		def retString=""
		def it,ser
		params.idlist?.tokenize(',').each{i->
			if(params.type=="aa")
				it = AccommodationAllotment.get(i)
			else
				{
				ser = EventRegistration.get(i)
				it = AccommodationAllotment.findBySubEventRegistration(ser)
				}

			if(it)
				retString+="<table><tr><td><img src=\"${resource(dir:'images',file:'iskcon-logo.png')}\"/></td><td/><td/><td><img src=\"${resource(dir:'images',file:'iskcon_nvcc_logo.png')}\"/></td></tr></table><table border='1'> 					<tr> 						<td>MainGroupLeader</td> 						<td>"+it.eventRegistration.name +"</td>"+ 						"<td>MainGroupLeaderContact</td> 						<td>"+it.eventRegistration.contactNumber +"</td> 					</tr>"+ 					"<tr> 						<td>MainGroupLeaderRegistrationCode</td> 						<td><h1><b>"+it.eventRegistration.regCode +"</b></h1></td> 						<td/> 						<td/> 					</tr>"+ 					"<tr> 						<td>SubGroupLeaderName</td> 						<td><b>"+it.subEventRegistration.name +"</b></td>"+ 						"<td>SubGroupLeaderContact</td> 						<td>"+it.subEventRegistration.contactNumber +"</td> 					</tr>"+ 					"<tr> 						<td>AccommodationName</td> 						<td><b>"+it.eventAccommodation.name +"</b></td>"+ 						"<td>AccommodationAddress</td> 						<td><b>"+it.eventAccommodation.address +"</b></td> 					</tr>"+ 					"<tr> 						<td>Check-In Time</td> 						<td><b>"+it.eventAccommodation.availableFromDate?.format('dd-MM-yyyy hh:mm a') +"</b></td>"+ 						"<td>Check-Out Time</td> 						<td><b>"+it.eventAccommodation.availableTillDate?.format('dd-MM-yyyy hh:mm a') +"</b></td> 					</tr>"+ 						"<td>DevoteeInchargeName</td> 						<td>"+it.eventAccommodation.accommodationInChargeName +"</td>"+ 						"<td>DevoteeInchargeContact</td> 						<td>"+it.eventAccommodation.accommodationInChargeContactNumber +"</td> 					</tr><tr><td>Number of Prji</td><td>Number of Mataji</td><td>Number of Children</td><td>Number of Brahmachari/Student</td></tr><tr><td>"+it.numberofPrabhujisCheckedin+"</td><td>"+it.numberofMatajisCheckedin+"</td><td>"+it.numberofChildrenCheckedin+"</td><td>"+it.numberofBrahmacharisCheckedin+"</td></tr></table>"
		}
		render retString
	}
	
	def testEmail(String from, String to, String sub, String body, Integer count) {
		def toAddr = []
		toAddr.add(to)
		for(int i=0;i<count;i++)
			{
			println "testEmail: "+i
			housekeepingService.sendGenericEMAIL(toAddr, from, sub, body, "false", "false")
			}
	}

    def uploadForLogin() {
	    def f = request.getFile('myFile')
	    if (f.empty) {
		render('file cannot be empty')
		return
	    	}

		def loginMap=""
		def icsRole
		def ind
		def login

	   // f.inputStream.eachCsvLine(['skipLines':'1']) { tokens -> 
	    f.inputStream.toCsvReader().eachLine{ tokens ->
	    	ind = Individual.get(tokens[0])
	    	icsRole = IcsRole.get(tokens[1])

			login=null
			login=housekeepingService.createLogin(ind,icsRole)
			if(login)
				loginMap += ind.id+"->"+ind.legalName+"->"+ind.initiatedName+"->"+login+";"
	    }
	    
	    render loginMap
    }	

	def schemeSummaryReport() {
		def totalmemberSummary;
		def memberscount=[]
		def membersprofileCompleteCount=[]
		def centers=[]
		def maxmembercount 
        if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') || SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_HOD')){
        	def schemes = helperService.getSchemesForRole(helperService.getDonationUserRole(),session.individualid)
        	//println '==========='+schemes
            totalmemberSummary = SchemeMember.createCriteria().list{
                projections{                                        
                    groupProperty("status")
                    count("member")                     
                    isNotNull("status")
                }
               'in'('scheme',schemes)
                
            }
           

        }
        def totalConcernsSummary;
        if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') || SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_HOD')){
        	def schemes = helperService.getSchemesForRole(helperService.getDonationUserRole(),session.individualid)
            totalConcernsSummary = SchemeMember.createCriteria().list{
                projections{                                        
                    groupProperty("addressTheConcern")
                    count("member")                     
                    isNotNull("addressTheConcern")
                }
               'in'('scheme',schemes)
                
            }

        }
        def totalCenterSummary;
        def totalProfileCompleteSummary;
        def summaryhash = new HashMap()
        if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') || SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_HOD')){
        	def schemes = helperService.getSchemesForRole(helperService.getDonationUserRole(),session.individualid)
        	
            totalCenterSummary = SchemeMember.createCriteria().list{
                projections{                                        
                    groupProperty("centre")
                    count("member")                     
                    isNotNull("centre")
                }
                'in'('scheme',schemes)
                'in'('status',['ACTIVE','RESUMED','IRREGULAR'])
            }

            totalProfileCompleteSummary = SchemeMember.createCriteria().list{
                projections{                                        
                    groupProperty("centre")
                    count("member")                   
                    isNotNull("centre")
                }
                eq("isProfileComplete",true)
                'in'('scheme',schemes)
                'in'('status',['ACTIVE','RESUMED','IRREGULAR'])
            } 
             for(row in totalCenterSummary){
             	summaryhash[row[0]] = [row[1],0]
            	 
            }
            for(row in totalProfileCompleteSummary){
            	 
            	summaryhash[row[0]][1] = row[1]
            }
            summaryhash.each{key, value ->            	
            	memberscount.add(value.getAt(0))
            	membersprofileCompleteCount.add(value.getAt(1))
            	centers.add("'"+key+"'") 
            }
            maxmembercount = memberscount.max()
            maxmembercount = maxmembercount + (10- maxmembercount%10 )

        }
        return [membersummary:totalmemberSummary,memberscount:memberscount,membersprofileCompleteCount:membersprofileCompleteCount,centers:centers,maxmembercount:maxmembercount ,concernssummary:totalConcernsSummary, centersummary:totalCenterSummary]
	}

	 def schemeTotalMemberSummaryReportAsCVS(){ 
	 	println "====exporting into CVS===="
	 	def totalCenterSummary;
	 	 def totalProfileCompleteSummary;
	 	 def summaryhash = new HashMap()
        if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') || SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_HOD')){
        	def schemes = helperService.getSchemesForRole(helperService.getDonationUserRole(),session.individualid)
        	
            totalCenterSummary = SchemeMember.createCriteria().list{
                projections{                                        
                    groupProperty("centre")
                    count("member")   
                    sum("isProfileComplete")                
                    isNotNull("centre")
                }
                'in'('scheme',schemes)
                'in'('status',['ACTIVE','RESUMED','IRREGULAR'])
            }
            totalProfileCompleteSummary = SchemeMember.createCriteria().list{
                projections{                                        
                    groupProperty("centre")
                    count("member")                   
                    isNotNull("centre")
                }
                eq("isProfileComplete",true)
                'in'('scheme',schemes)
                'in'('status',['ACTIVE','RESUMED','IRREGULAR'])
            } 
             for(row in totalCenterSummary){
             	summaryhash[row[0]] = [row[1],0]
            	 
            }
            for(row in totalProfileCompleteSummary){
            	 
            	summaryhash[row[0]][1] = row[1]
            }

             def filename = "Member_Count_Active_Resumed_Irregular"+".${params.extension}"
		  	response.contentType = grailsApplication.config.grails.mime.types[params.formats]
		  	response.setHeader("Content-disposition", "attachment; filename="+filename) 
		  	List fields = ["Center","Total Active,IRREGULAR,Resumed Members","Total Profile Complete"]
		  	Map labels = [:]
		  	def data=new ArrayList()
		  	def total= 0
		  	def totalProfileCompelte =0
		  	 summaryhash.each{key, value ->            	            	 
            	def row = new HashMap()
		  		row[fields[0]]=key
		  		row[fields[1]]=value.getAt(0)		  		
		  		row[fields[2]]= value.getAt(1)
		  		total = total +value.getAt(0)
		  		totalProfileCompelte = totalProfileCompelte + value.getAt(1)
		  		data.add(row)
		  		
            } 
		  	def row= new HashMap()
		  	row[fields[0]]="TOTAL MEMBER"
		  	row[fields[1]]= total
		  	row[fields[2]]= totalProfileCompelte
		  	data.add(row)
		  	
		  	exportService.export(params.format, response.outputStream,data, fields,labels, [:], [:])

        }
	 }
	  def schemeDonationRecordReportAsCVS(){
	  	def result = schemeDonationRecordReport()
	  	println "========exporting into CVS=========="
	  	
	  	def filename = result.title+".${params.extension}"
	  	response.contentType = grailsApplication.config.grails.mime.types[params.formats]
	  	response.setHeader("Content-disposition", "attachment; filename="+filename) 
	  	List fields = ["center","amount"]
	  	Map labels = [:]
	  	def data=new ArrayList()
	  	def total= new BigDecimal("0")
	  	for(record in result.donationRecordSummary){
	  		def row= new HashMap()
	  		row[fields[0]]=record[0]
	  		row[fields[1]]=record[1]
	  		total = total + record[1]
	  		data.add(row) 
	  	}
	  	def row= new HashMap()
	  	row[fields[0]]="TOTAL"
	  	row[fields[1]]= total
	  	data.add(row)
	  	
	  	exportService.export(params.format, response.outputStream,data, fields,labels, [:], [:])
	  }

	 def schemeDonationRecordReport(){
	 	if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') || SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_HOD')){

	 		def schemes = helperService.getSchemesForRole(helperService.getDonationUserRole(),session.individualid)

	 		 def title

	 		 def title2

	 		 def title3

	 		def donationRecordSummary
	 		def paymentModeSummary

	 		if(params.reportType==null){
	 			params.reportType = 'centre'
	 		}
	 		def reportType = params.reportType // 'center' , 'mode'

		 	def centretitle = ""

	        def centre = null
	         if(params."centre.id"!= null && params."centre.id" !='0'){
	         	centre= Centre.findById(params."centre.id")
	         	centretitle = centretitle +": For " + centre?.name
	         }
	         else{
	         	centretitle = centretitle +": For All Centres "
	         }


	 		def selectedDate
	 		if(params.startDate!=null && params.startDate!=''){
	 			selectedDate  = Date.parse('dd-MM-yyyy', params.startDate)
	 		}
	 		
	 		if(selectedDate==null){
	 			selectedDate = new Date()
	 		}
	 		def firstDate = selectedDate - selectedDate.getAt(Calendar.DAY_OF_MONTH)
	 		def lastDate = firstDate + 31

	 		if(params.endDate != null && params.endDate !=''){
	 			lastDate = Date.parse('dd-MM-yyyy', params.endDate)
	 			
	 			firstDate = selectedDate 

	 			title = 'Donation Report '+centretitle  +' from Date ' + firstDate.format('dd-MMM-yyyy') +' till Date '+ lastDate.format('dd-MMM-yyyy')
	 			title2 = 'Donation Report of Payment Modes :'+ centretitle+ ' from Date ' + firstDate.format('dd-MMM-yyyy') +' till Date '+ lastDate.format('dd-MMM-yyyy')
	 		}
	 		else{
	 			title = 'Donation Report  '+centretitle+' of Month ' + selectedDate.format('MMM')
	 			title2 = 'Donation Report of Payment Modes :'+centretitle+' of Month ' + selectedDate.format('MMM')
	 		}

	 		def numberofmonths = params.numberofmonths
	 		if(numberofmonths == null) numberofmonths= 1
	 		def range = 1..4
	        if(!range.contains(numberofmonths.toInteger())){
	           render "Select Proper Value!!"
	           return
	        }
	        title3 = 'Total Donation Report of ' +centretitle + ' within ' + numberofmonths +' months'
	        // finding total donation in some months

	        def count =0
	        def newdate = selectedDate
	        def montharray=[]
	        def collecteddonations=[]
	        while(count < numberofmonths.toInteger()){
	            
	            println "fetching donation records for "+newdate
	            def result = DonationRecord.createCriteria().list() {
	                projections{                                        
	                    sum("amount")                     
	                    isNotNull("centre")
	                }
	                'in'('scheme',schemes)
	                 
	                if(firstDate != null){
	                    sqlRestriction "month(donation_date) = "+((newdate.month).toInteger() +1) + "  AND year(donation_date) = "+((newdate.getAt(Calendar.YEAR)).toInteger())                        
	                }
					if(centre != null){
						eq('centre',centre)
					}	                
	            } 
	           	  montharray.add("'"+newdate?.format('MMM-yyyy')?.toString()+"'")
	           	  collecteddonations.add(result[0])
	            newdate = newdate - 30
	            count++
	            }
	         println montharray
	         println collecteddonations
	         def maxTotaldonation = collecteddonations.max()
            if(maxTotaldonation != null)maxTotaldonation = maxTotaldonation + 100
            else maxTotaldonation = 100

	 		println "====== schems="+ schemes
	 		println "=====selectedDate="+selectedDate
	 		donationRecordSummary = DonationRecord.createCriteria().list(){
	 				projections{                                        
	                    groupProperty(reportType)
	                    sum("amount")  
	                    isNotNull("centre")                 	                    
               		 }
	 				gt('donationDate',firstDate)
            		lt('donationDate',lastDate)
	 				'in'('scheme',schemes)
	 				if(centre!= null){
	 					eq('centre',centre)
	 				}
	 		}
	 		paymentModeSummary = DonationRecord.createCriteria().list(){
	 				projections{                                        
	                    groupProperty("mode")
	                    sum("amount")  
	                    isNotNull("centre")                 	                    
	                    isNotNull("mode")                 	                    
	                    gt("amount",new BigDecimal(0)) 
               		 }
	 				gt('donationDate',firstDate)
            		lt('donationDate',lastDate)
	 				'in'('scheme',schemes)
	 				if(centre!= null){
	 					eq('centre',centre)
	 				}
	 		}

	 		def totaldonations=[]
			def dcenters=[]
			def maxdonation

			for(row in donationRecordSummary){
				dcenters.add("'"+row[0]+"'")
				totaldonations.add(row[1])
			} 

			maxdonation = totaldonations.max()
            if(maxdonation != null)maxdonation = maxdonation + 100
            else maxdonation = 100

            def totalmodedonations=[]
            def paymentmodes=[]
            for(row in paymentModeSummary){
            	//paymentmodes.add("'"+row[0]+"'")
            	totalmodedonations.add(["'"+row[0]+"'",row[1]]) 
            }

            return [title3:title3,maxTotaldonation:maxTotaldonation,numberofmonths:numberofmonths,montharray:montharray,collecteddonations:collecteddonations,title2:title2,totalmodedonations:totalmodedonations,paymentmodes:paymentmodes,donationRecordSummary:donationRecordSummary,totaldonations:totaldonations,dcenters:dcenters,maxdonation:maxdonation, startDate:params.startDate, endDate:params.endDate,title:title,centre:centre]


	 		/*def list =[]
	 		for(row in donationRecordSummary){
	 			def data=[]
	 			data.add(row[0]?.name)
	 			data.add(row[1])
	 			list.add(data)
	 		}*/	 		
	 		//render ([list] as JSON)

	 	}
	 }

/*
	if only first date is selected then we consider the whole month
	otherwise we have those two dates.
	if no date is given then the today's date is considered as first date
*/
	 private def getFirstAndLastDate(){
	 		def selectedDate
	 		if(params.startDate!=null && params.startDate!=''){
	 			selectedDate  = Date.parse('dd-MM-yyyy', params.startDate)
	 		}
	 		if(selectedDate==null){
	 			selectedDate = new Date()
	 		}
	 		def firstDate = selectedDate - selectedDate.getAt(Calendar.DAY_OF_MONTH)
	 		def lastDate = firstDate + 31

	 		if(params.endDate != null && params.endDate !=''){
	 			lastDate = Date.parse('dd-MM-yyyy', params.endDate)
	 			
	 			firstDate = selectedDate 

	 		}

	 		return [firstDate,lastDate]
	 }
	 /*	 
	 list all those records such that their amount is ge to selected amount in the selected period
	 //list all those individuals who have monthly is ge to selected amount -- same as above as mostly for a individual in a month there will be one record only, so we can depecrate this
	 list all those individuals who have total contribution in that selected period greater than selected amount,

	 */

	 def schemeMembersGivenDonationMoreThanAmount(){

	 	if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') || SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_HOD')){

	 		def schemes = helperService.getSchemesForRole(helperService.getDonationUserRole(),session.individualid)
	 		def amount = params.selectedamount
	 		

	 		println "============ amount is ["+amount+"]"
	 		if(amount==null || amount?.trim()=='' ){
	 			render "no amount was specified"
	 			return
	 		}
	 		
	 		def dates = getFirstAndLastDate()
	 		def firstDate = dates[0]
	 		def lastDate = dates[1]

	 		def maxRows = Integer.valueOf(params.rows)
     		def currentPage = Integer.valueOf(params.page) ?: 1
      		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	 		def membersummary = DonationRecord.createCriteria().list(max:maxRows, offset:rowOffset){	 				
	 				gt('donationDate',firstDate)
            		lt('donationDate',lastDate)
	 				'in'('scheme',schemes)
	 				isNotNull("centre")                 	                    
	                ge("amount",new BigDecimal(Integer.parseInt(amount))) 
	                order("donationDate","asc")	                
	 		}
	 		def totalRows = membersummary.totalCount
      		def numberOfPages = Math.ceil(totalRows / maxRows)

      		def jsonCells = membersummary.collect {
            [cell: [
            	    it.donatedBy?.toString()?.encodeAsHTML(),
            	    it.amount,
            	    it.donationDate?.format('dd-MMM-yyyy')?.toString(),
            	    it.centre?.name,
            	    it.comments?.encodeAsHTML(),
            	    it.paymentDetails?.encodeAsHTML()            	    
                ], id: it.id]
	        }
	        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
	        render jsonData as JSON 

	 	}
	 }
	 /*
	 this will give how many members of difference center have given donation in that month and how many not given
	 only active, irregular and resumed members will be considered.
	 */
	 def schemeMemberDonationReport(){
	 	if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') || SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_HOD')){

	 		def schemes = helperService.getSchemesForRole(helperService.getDonationUserRole(),session.individualid)

	 		 def title

	 		def memberRecordSummary
	 		def bouncedRecordSummary
	 		

	 		if(params.reportType==null){
	 			params.reportType = 'centre'
	 		}
	 		def reportType = params.reportType // 'center' , 'mode'
	 		def selectedDate
	 		if(params.startDate!=null && params.startDate!=''){
	 			selectedDate  = Date.parse('dd-MM-yyyy', params.startDate)
	 		}

	 		def centre= params.centre
	 		
	 		if(selectedDate==null){
	 			selectedDate = new Date()
	 		}
	 		def firstDate = selectedDate - selectedDate.getAt(Calendar.DAY_OF_MONTH)
	 		def lastDate = firstDate + 31

	 		if(params.endDate != null && params.endDate !=''){
	 			lastDate = Date.parse('dd-MM-yyyy', params.endDate)
	 			
	 			firstDate = selectedDate 

	 			title = 'Member Report of All Centers from Date ' + firstDate.format('dd-MMM-yyyy') +' till Date '+ lastDate.format('dd-MMM-yyyy')
	 		}
	 		else{
	 			title = 'Member Report of All Centers of Month ' + selectedDate.format('MMM')
	 		}

	 		println "====== schems="+ schemes
	 		println "=====selectedDate="+selectedDate
	 		memberRecordSummary = DonationRecord.createCriteria().list(){
	 				projections{                                        
	                    groupProperty(reportType)
	                    countDistinct("donatedBy")  
	                    isNotNull("centre")                 	                    
	                    gt("amount",new BigDecimal(0)) 
               		 }
	 				gt('donationDate',firstDate)
            		lt('donationDate',lastDate)
	 				'in'('scheme',schemes)
	 		}

	 		bouncedRecordSummary = DonationRecord.createCriteria().list(){	 				
	 				gt('donationDate',firstDate)
            		lt('donationDate',lastDate)
	 				'in'('scheme',schemes)
	 				isNotNull("centre")                 	                    
	                eq("amount",new BigDecimal(0)) 
	                or{
	                	ilike("comments","%BOUNCED%")
	                	ilike("paymentDetails","%BOUNCED%")
	                }
	                if(centre!= null){
	                	centre{
	                		eq("id",centre)
	                	}
	                }
	 		}

	 		def bouncedRecordData=[]
	 		def totlaamountbounced = 0
	 		for(row in bouncedRecordSummary){
	 			
	 			def str = "{id:"+"'"+row?.id+"'"+","+"individual:"+"'"+row?.donatedBy?.toString()?.encodeAsHTML()+"'"  +"," +"donationdate:"+ "'"+row?.donationDate?.format('dd-MMM-yyyy')?.toString()+"'"
	 			str = str + ","+"centre:"+"'"+row?.centre?.name+"'"+","+"comments:"+"'"+row?.comments?.encodeAsHTML()+"'"+","+"details:"+ "'"+row?.paymentDetails?.encodeAsHTML()+"'"+"}"
	 			
	 			bouncedRecordData.add(str)
	 		}


	 		def totalmembers=[]
			def dcenters=[]
			def maxcount

			for(row in memberRecordSummary){
				dcenters.add("'"+row[0]+"'")
				totalmembers.add(row[1])
			} 

			maxcount = totalmembers.max()
            if(maxcount != null)maxcount = maxcount + 100
            else maxcount = 100

            return [bouncedRecordData:bouncedRecordData,memberRecordSummary:memberRecordSummary,totalmembers:totalmembers,dcenters:dcenters,maxcount:maxcount, startDate:params.startDate, endDate:params.endDate,title:title,selectedamount:params.selectedamount]

	 	}

	 }



	 def schemeMemberDonationReportAsCVS(){

	 	def result = schemeMemberDonationReport()
	  	println "========exporting into CVS=========="
	  	
	  	def filename = result.title+".${params.extension}"
	  	response.contentType = grailsApplication.config.grails.mime.types[params.formats]
	  	response.setHeader("Content-disposition", "attachment; filename="+filename) 
	  	List fields = ["Center","Total Members given Donation"]
	  	Map labels = [:]
	  	def data=new ArrayList()
	  	def total= new BigDecimal("0")
	  	for(record in result.memberRecordSummary){
	  		def row= new HashMap()
	  		row[fields[0]]=record[0]
	  		row[fields[1]]=record[1]
	  		total = total + record[1]
	  		data.add(row) 
	  	}
	  	def row= new HashMap()
	  	row[fields[0]]="TOTAL"
	  	row[fields[1]]= total
	  	data.add(row)
	  	
	  	exportService.export(params.format, response.outputStream,data, fields,labels, [:], [:])

	 }
// both roles should be shave seperate query,
    def schemeIssueReport(){
        def totalIssueSummary;
        if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') || SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_HOD')){
        	def schemes = helperService.getSchemesForRole(helperService.getDonationUserRole(),session.individualid)
            totalIssueSummary = SchemeMember.createCriteria().list{
                projections{                                        
                    property("addressTheConcern")
                    property("recentCommunication")
                    property("member")
                    property("id")
                }
                ne("addressTheConcern","NONE")
                'in'('scheme',schemes)
            }

        }

        return [totalIssueSummary:totalIssueSummary]

    }

    def donationRecordSummaryForSchemeMember(){
    	println "donationRecordSummaryForSchemeMember"
    	def role = helperService.getDonationUserRole()
        def schemes = helperService.getSchemesForRole(role, session.individualid)
        def centre = helperService.getCenterForIndividualRole(role, session.individualid)

    	def donationRecordSummary
    	if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') || 
    		SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_HOD') ||
    		SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_COORDINATOR')){
    		def sortIndex = params.sidx ?: 'id'
		      def sortOrder  = params.sord ?: 'asc'

		      def maxRows = Integer.valueOf(params.rows)
		      def currentPage = Integer.valueOf(params.page) ?: 1

		      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
    		
    		def schemeMemberId = params.id

    		
    		def schemeMemberInstance = SchemeMember.get(schemeMemberId)
    		
    		def individualId = schemeMemberInstance.member?.id
    		
    		def schemeId = schemeMemberInstance.scheme?.id
    		

    		def result = DonationRecord.createCriteria().list(max:maxRows, offset:rowOffset){
    			
    			donatedBy{
    				eq("id",individualId)
    			}
    			scheme{
    				eq("id",schemeId)
    			}
    			if(SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_COORDINATOR')){
    				or{
    					eq('centre',centre)
    				}
    			}
    			order("donationDate","desc")
    		}

    		//println "donationRecordSummary::length::"+donationRecordSummary.length +" ::"+donationRecordSummary
    	 def totalRows = (result?.totalCount)?:0
	      def numberOfPages = Math.ceil(totalRows / maxRows)

	      def jsonCells = result.collect {
	            [cell: [
	            	   // it.scheme?.name,
	            	    //it.member?.toString(),
	            	    it.donationDate?.format('dd-MMM-yyyy')?.toString(),
	            	    it.amount,
	            	    it.mode?.name,
	            	    it.centre?.name,
	                    it.paymentDetails,
	                ], id: it.id]
	        }
	        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
	        render jsonData as JSON

    	}

    	render( [donationRecordSummary:donationRecordSummary] as JSON)
    	
    }

    def schemeMemberGiftReport(){
    	 if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') &&  !SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_HOD')){
           render "The record is not available for viewing!!"
           return
        }
                
        def donationExecRole = Role.findByAuthority(helperService.getDonationUserRole())

        def dep = IndividualRole.findWhere('individual.id':session.individualid,role:donationExecRole,status:'VALID')?.department
        def schemes
        if(dep)
            schemes = Scheme.findAllByDepartment(dep,[sort:'name'])

        def gifts
        if(dep)
            gifts = Gift.findAllByDepartment(dep,[sort:'effectiveFrom',order:'desc'])
        
        if(params."gift.id" == null && params."centre.id" == null){
        	return [schemes:schemes,gifts:gifts]
        }

        def comments= null
        if(params.comments != 'undefined' && params.comments !=''){
        	comments = params.comments
        }
        def gift = Gift.findById(params."gift.id")

        def giftmodereporttitle =gift?.name + ': Gift Report :Way of Giving Gift'

        def giftsummaryreporttitle =gift?.name +  ': Center wise Gift Report'

        def centre = null
         if(params."centre.id" !='0'){
         	centre= Centre.findById(params."centre.id")
         	giftmodereporttitle = giftmodereporttitle +": For " + centre?.name
         	giftsummaryreporttitle = giftsummaryreporttitle +": For " + centre?.name
         }
         else{
         	giftmodereporttitle = giftmodereporttitle +": For All Centre"
         	giftsummaryreporttitle = giftsummaryreporttitle +": For All Centre"
         }

         if(comments != null){
         	giftmodereporttitle = giftmodereporttitle + " with Comment ="+ comments
         	giftsummaryreporttitle = giftsummaryreporttitle + " with Comments ="+ comments
         }
        println "============loading scheme member Gift Report==========="

        def giftModeSummary = GiftRecord.createCriteria().list(){
	 				projections{                                        
	                    groupProperty("giftChannel")
	                    count("giftedTo") 
	                    isNotNull("giftChannel") 	                    
               		 }	
               		 eq('gift',gift) 				
	 				'in'('scheme',schemes)
	 				if(centre != null){
	 					eq('centre',centre)
	 				}
	 				if(comments != null) ilike('comments','%'+comments+'%')
	 		}
			
			def totalmodegifts=[]
            def giftmodes=[]
            for(row in giftModeSummary){
            	//paymentmodes.add("'"+row[0]+"'")
            	totalmodegifts.add(["'"+row[0]+"'",row[1]]) 
            }
        def memberscount=[]
		def membersGiftCount=[]
		def centers=[]
		def maxmembercount 
        def totalCenterSummary;
        def totalGiftGivenSummary;
        def summaryhash = new HashMap()
        	
            totalCenterSummary = SchemeMember.createCriteria().list{
                projections{                                        
                    groupProperty("centre")
                    countDistinct("member")                     
                    isNotNull("centre")
                }
                'in'('scheme',schemes)
                'in'('status',['ACTIVE','RESUMED','IRREGULAR','SUSPENDED'])
                 if(centre != null){
	 					eq('centre',centre)
	 				}  
            }

            totalGiftGivenSummary = GiftRecord.createCriteria().list{
                projections{                                        
                    groupProperty("centre")
                    countDistinct("giftedTo") 
                    isNotNull("centre")
                } 
                 eq('gift',gift) 	              
                'in'('scheme',schemes)                 
                if(centre != null){
	 					eq('centre',centre)
	 				} 
	 			if(comments != null) ilike('comments','%'+comments+'%')             
            } 
            println totalCenterSummary
            println totalGiftGivenSummary
             for(row in totalCenterSummary){
             	summaryhash[row[0]] = [row[1],0]
            	 
            }
            println summaryhash
            for(row in totalGiftGivenSummary){
            	 if(summaryhash[row[0]]==null)continue
            	summaryhash[row[0]][1] = row[1]
            }
            summaryhash.each{key, value ->            	
            	memberscount.add(value.getAt(0))
            	membersGiftCount.add(value.getAt(1))
            	centers.add("'"+key+"'") 
            }
            maxmembercount = memberscount.max()
            maxmembercount = (maxmembercount==null)?0:maxmembercount
            maxmembercount = maxmembercount + (10- maxmembercount%10 )

        

        return [comments:comments, centre:centre,gift:gift,schemes:schemes,gifts:gifts,totalmodegifts:totalmodegifts,giftsummaryreporttitle:giftsummaryreporttitle,giftmodereporttitle:giftmodereporttitle,memberscount:memberscount,membersGiftCount:membersGiftCount,centers:centers,maxmembercount:maxmembercount]


    }

    def schemeMembersGiftListOfCentre(){
    	 if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') &&  !SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_HOD')){
           render "The record is not available for viewing!!"
           return
        }
        println "=========schemeMembersGiftListOfCentre============"
        /*if(params.centre_id=='0'){
        	return
        }*/
         def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def gift = Gift.findById(params.gift_id)
        def centre = null
        if(params.centre_id!='0')centre= Centre.findById(params.centre_id)

         def comments= null
        if(params.comments != 'undefined' && params.comments !=''){
        	comments = params.comments
        }
        def role = helperService.getDonationUserRole()
      def schemes = helperService.getSchemesForRole(role, session.individualid)

        def giftRecordSummary = GiftRecord.createCriteria().list(max:maxRows, offset:rowOffset){
        	eq('gift',gift)
        	'in'('scheme',schemes)
        	if(centre != null){
	 			eq('centre',centre)
	 		}
	 		if(comments != null) ilike('comments','%'+comments+'%')  
        }

        
        def totalRows = (giftRecordSummary?.totalCount)?:0
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = giftRecordSummary.collect {
            [cell: [                    
                    it.giftedTo?.legalName,                    
                    it.gift?.name,
                    it.giftDate?.format('dd-MMM-yyyy')?.toString(),
                    it.centre?.name,
                    it.comments,
                    it.giftReceivedStatus,
                    it.giftChannel                    
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON

    }
    
    def donationBackup() {
    	response.contentType = 'application/zip'
    	def query = "select id,nvcc_receipt_book_no,nvcc_receipt_no,donation_date,fund_receipt_date,amount,ifnull(donor_name,nvcc_donar_name) donor_name,donor_contact,donor_email,donor_address,comments,donated_by_id,collected_by_id from donation"
    	def sql = new Sql(dataSource)
    	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		zipOutputStream.putNextEntry(new ZipEntry("donation.csv"))
		//header
		zipOutputStream << "id,nvcc_receipt_book_no,nvcc_receipt_no,donation_date,fund_receipt_date,amount,donor_name,donor_contact,donor_email,donor_address,comments,donated_by_id,collected_by_id" 
		sql.eachRow(query){ row ->
			//zipOutputStream.putNextEntry(new ZipEntry("invoice_${invoice.number}.pdf"))
			zipOutputStream << "\n"
			//zipOutputStream << row.id+","+row.nvcc_receipt_book_no+","+row.nvcc_receipt_no+","+row.donation_date+","+row.fund_receipt_date+","+row.amount+","+row.donor_name+","+row.donor_contact+","+row.donor_email+","+row.donor_address+","+row.comments+","+row.donated_by_id+","+row.collected_by_id
			//with escaping for excel
			zipOutputStream << row.id+","+row.nvcc_receipt_book_no+","+row.nvcc_receipt_no+","+row.donation_date+","+row.fund_receipt_date+","+row.amount+",\""+row.donor_name+"\",\""+row.donor_contact+"\",\""+row.donor_email+"\",\""+row.donor_address+"\",\""+row.comments+"\","+row.donated_by_id+","+row.collected_by_id
			   /*def sw = new StringWriter()
			   def b = new CSVWriter(sw, {
			      col1 { row.id }
			      col2 { row.nvcc_receipt_book_no }
			      col3 { row.nvcc_receipt_no }
			      col4 { row.donation_date }
			      col5 { row.fund_receipt_date }
			      col6 { row.amount }
			      col7 { row.donor_name }
			      col8 { row.donor_contact }
			      col9 { row.donor_email }
			      col10 { row.donor_address }
			      col11 { row.comments }
			      col12 { row.donated_by_id }
			      col13 { row.collected_by_id }
   				})
   			zipOutputStream << b.writer.toString()*/
		}
	}    	
    }

    def individualBackup() {
    	response.contentType = 'application/zip'
    	def query = "select i.id,i.legal_name,i.initiated_name,i.category,i.status from individual i"
    	def sql = new Sql(dataSource)
    	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		zipOutputStream.putNextEntry(new ZipEntry("individual.csv"))
		//header
		zipOutputStream << "id,legal_name,initiated_name,category,status" 
		sql.eachRow(query){ row ->
			zipOutputStream << "\n"
			zipOutputStream << row.id+","+row.legal_name+","+row.initiated_name+","+row.category+","+row.status
		}
	}    	
    }

    def ccBackup() {
    	response.contentType = 'application/zip'
    	def query = "select i.id,i.legal_name,i.initiated_name,i.category,i.status,r.individual2_id councellor_id from individual i  join relationship r on i.id=r.individual1_id  where r.status='ACTIVE' and r.relation_id=(select id from relation where name='Councellee of')"
    	def sql = new Sql(dataSource)
    	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		zipOutputStream.putNextEntry(new ZipEntry("cc.csv"))
		//header
		zipOutputStream << "id,legal_name,initiated_name,category,status,councellor_id" 
		sql.eachRow(query){ row ->
			zipOutputStream << "\n"
			zipOutputStream << row.id+","+row.legal_name+","+row.initiated_name+","+row.category+","+row.status+","+row.councellor_id
		}
	}
	}
    
     def GiftRecordSummaryForSchemeMember(){
    	println "GiftRecordSummaryForSchemeMember"
    	def giftRecordSummary
    	if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') || 
    		SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_HOD') ||
    		SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_COORDINATOR')){
    		def sortIndex = params.sidx ?: 'id'
		      def sortOrder  = params.sord ?: 'asc'

		      def maxRows = Integer.valueOf(params.rows)
		      def currentPage = Integer.valueOf(params.page) ?: 1

		      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
    		
    		def schemeMemberId = params.id

    		
    		def schemeMemberInstance = SchemeMember.get(schemeMemberId)
    		
    		def individualId = schemeMemberInstance.member?.id
    		
    		def schemeId = schemeMemberInstance.scheme?.id
    		

    		def result = GiftRecord.createCriteria().list(max:maxRows, offset:rowOffset){
    			
    			giftedTo{
    				eq("id",individualId)
    			}
    			scheme{
    				eq("id",schemeId)
    			}
    			order("giftDate","desc") 
    		}

    		//println "donationRecordSummary::length::"+donationRecordSummary.length +" ::"+donationRecordSummary
    	 def totalRows = (result?.totalCount)?:0
    	 println ""+totalRows+"========="
	      def numberOfPages = Math.ceil(totalRows / maxRows)

	      def jsonCells = result.collect {
	            [cell: [
	            	   it.scheme?.name,
	            	    //it.member?.toString(),
	            	    it.giftDate?.format('dd-MMM-yyyy')?.toString(),
	            	    it.gift?.name,	            	   
	                    it.comments,
	                ], id: it.id]
	        }
	        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
	        render jsonData as JSON

    	}

    	render( [giftRecordSummary:giftRecordSummary] as JSON)
    	
    }
    
    def costcenterReport() {
    }
    
    def jq_costcenter_list = {
      log.debug("Inside jq_costcenter_list with params: "+params)
      
      	def now = new Date()
      	now = now.clearTime()
      	
      	if(!params.dtFrom)
      		params.dtFrom = now.format('dd-MM-yyyy')
      	if(!params.dtTill)
      		params.dtTill = params.dtFrom

	params.dtFrom = Date.parse('dd-MM-yyyy', params.dtFrom)
	params.dtTill = params.dtTill+" 23:59:59"
	params.dtTill = Date.parse('dd-MM-yyyy HH:mm:ss', params.dtTill)
		
	log.debug("dtFrom: "+params.dtFrom+" dtTill: "+params.dtTill)
      
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

		
      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	if(params.oper=="excel" )
		{
			maxRows = 100000
			rowOffset = 0
		}

	def result = Donation.createCriteria().list(max:maxRows, offset:rowOffset) {
		ge("fundReceiptDate",params.dtFrom)
		le("fundReceiptDate",params.dtTill)
		if(params.reportName=="bankwisecheque")
			mode{or{ilike("name","Cheque") ilike("name","Draft")}}
		order(sortIndex, sortOrder)			
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

		if(params.oper=="excel")
		 {
			if(!params.reportName) {
				response.contentType = 'application/zip'
				new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
					zipOutputStream.putNextEntry(new ZipEntry("Transactions.csv"))
					//header
					zipOutputStream << "Receipt No,Date,Ledger,Cost Category,Cost Center,Credit Amount,Transaction Type,Instrument No,Instrument Date,Bank Name,Branch,Ledger Name,Debit Amount,Narration" 

					def bankCode=""
					result.each{ row ->
						bankCode=CostCategoryPaymentMode.findByCostCategoryAndPaymentMode(row.scheme?.cc?.costCategory,row.mode)
							 // (((row.scheme?.cc?.costCategory?.alias?:'')+(row.scheme?.cc?.alias))?:'') +","+

						zipOutputStream << "\n"
						zipOutputStream <<   row.nvccReceiptBookNo+"-"+row.nvccReceiptNo +","+
							  row.fundReceiptDate?.format('dd-MM-yyyy') +","+
							  (row.taxBenefit?'80GDonation':((row.collectionType?:"Donation"))) +","+
							  (row.scheme?.cc?.costCategory?.alias?:'')+"-"+(row.scheme?.cc?.costCategory?.name?:'')+ ","+
							  ((row.scheme?.cc?.name)?:'') +","+
							  row.amount +","+
							  row.mode?.name +","+
							  (row.chequeNo?:'').replaceAll(',',';') +","+
							  (row.chequeDate?.format('dd-MM-yyyy')?:'') +","+
							  (row.bankName?:'').replaceAll(',',';') +","+
							  (row.bankBranch?:'').replaceAll(',',';') +","+
							  (bankCode?.bankCode?:'') +","+
							  row.amount +","+
							  "Received from "+(row.donorName?:'').replaceAll(',',';')+" "+(row.donorAddress?:'').tr('\n\r\t',' ').replaceAll(',',';')+" "+(row.donorContact?:'').replaceAll(',',';')
					}
				}    		
				return
			}
			else if(params.reportName=="bankwisecheque") {	//bank wise cheque detail report
				response.contentType = 'application/zip'
				new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
					zipOutputStream.putNextEntry(new ZipEntry("bankwisecheque.csv"))
					//header
					zipOutputStream << "Receipt No,Date,Cost Category,Cost Center,Amount,Instrument No,Instrument Date,Bank Name,Branch,Ledger Name,Narration" 

					def bankCode=""
					result.each{ row ->
						bankCode=CostCategoryPaymentMode.findByCostCategoryAndPaymentMode(row.scheme?.cc?.costCategory,row.mode)
						zipOutputStream << "\n"
						zipOutputStream <<   row.nvccReceiptBookNo+"-"+row.nvccReceiptNo +","+
							  row.fundReceiptDate?.format('dd-MM-yyyy') +","+
							  (row.scheme?.cc?.costCategory?.alias?:'') +","+
							  (row.scheme?.cc?.alias?:'') +","+
							  row.amount +","+
							  row.mode?.name +","+
							  (row.chequeNo?:'').replaceAll(',',';') +","+
							  (row.chequeDate?.format('dd-MM-yyyy')?:'') +","+
							  (row.bankName?:'').replaceAll(',',';') +","+
							  (row.bankBranch?:'').replaceAll(',',';') +","+
							  (bankCode?.bankCode?:'') +","+
							  "Received from "+(row.donorName?:'').replaceAll(',',';')+" "+(row.donorAddress?:'').replaceAll(',',';')+" "+(row.donorContact?:'').replaceAll(',',';')
					}
				}    		
				return
			}		
		 }
		else
		{
		      def jsonCells = result.collect {
			    [cell: [
				    it.scheme?.cc?.toString(),
				    it.scheme?.name,
				    it.nvccReceiptBookNo+"-"+it.nvccReceiptNo,
				    it.fundReceiptDate?.format('dd-MM-yyyy'),
				    it.amount,
				    it.donorName
				], id: it.id]
			}
			def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
			render jsonData as JSON
			}
        }
        
    def forceChangePassword() {}
    
def jq_donor_list = {
                   
                   if(params.locality)
                   	render donationService.listDonorsInLocality(params) as JSON
                   
                   def sortIndex = params.sidx ?: 'amount'
                   def sortOrder  = params.sord ?: 'desc'
             
                   def maxRows = Integer.valueOf(params.rows)
                   def currentPage = Integer.valueOf(params.page) ?: 1
             
                   def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
             
		if(params.oper=="excel" || params.locality)
			{
				maxRows = 100000
				rowOffset = 0
			}

	      def sql = new Sql(dataSource);
	      //without scheme..String query = "select donated_by_id,if(initiated_name is not null and trim(initiated_name)!='',initiated_name,legal_name) donor, sum(amount) amount from donation d, individual i where d.donated_by_id=i.id group by d.donated_by_id,donor order by amount desc"
	      String query = "select donated_by_id,if(initiated_name is not null and trim(initiated_name)!='',initiated_name,legal_name) donor, sum(amount) amount,group_concat(distinct s.name) scheme from donation d left join scheme s on d.scheme_id=s.id, individual i where d.donated_by_id=i.id group by d.donated_by_id,donor "
	      String condQuery = " having amount>="+(params.minAmt?:0) +" and amount<="+(params.maxAmt?:999999999)
	      String orderQuery = "  order by amount "+sortOrder
	      String finalQuery = query + condQuery + orderQuery
	      //log.debug(finalQuery)
              def result = sql.rows(finalQuery,rowOffset,maxRows)
	      String countquery = "select count(1) cnt from ("+finalQuery+") q"
                   def totalRows = sql.firstRow(countquery)?.cnt
             	
             	sql.close()
                   
                   def numberOfPages = Math.ceil(totalRows / maxRows)
             
		if(params.oper=="excel")
		 {
                         def cultivatorRel = Relation.findByName('Cultivated by')
                         def counsellorRel = Relation.findByName('Councellee of')
				response.contentType = 'application/zip'
				def today = new Date().format("dd-MM-yyyy-HH-mm-SS")
				def fileName = "Donors-("+params.minAmt+"-"+params.maxAmt+")-"+today+".csv"
				def donor
				new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
					zipOutputStream.putNextEntry(new ZipEntry(fileName))
					//header
					zipOutputStream << "ICSID,Donor,Amount,Scheme,Address,Phone,Email,Cultivator,Collector,Counsellor" 

					result.each{ row ->
		                         donor = Individual.get(row.donated_by_id)
						zipOutputStream << "\n"
						zipOutputStream <<   donor.icsid +","+
							  donor.toString()?.tr('\n\r\t',' ').replaceAll(',',';') +","+
							  row.amount +","+
							  row.scheme.tr('\n\r\t',' ').replaceAll(',',';') +","+
							  Address.findAllByIndividual(donor)?.toString()?.tr('\n\r\t',' ').replaceAll(',',';') +","+
							  VoiceContact.findAllByIndividual(donor)?.toString()?.tr('\n\r\t',' ').replaceAll(',',';') +","+
							  EmailContact.findAllByIndividual(donor)?.toString()?.tr('\n\r\t',' ').replaceAll(',',';') +","+
							  Relationship.findAllWhere(individual1:donor,relation:cultivatorRel,status:'ACTIVE')?.collect{it.individual2?.toString()?.tr('\n\r\t',' ').replaceAll(',',';')} +","+
							  Donation.findAllByDonatedBy(donor,[sort: "donationDate", order: "desc"])?.collect{it.collectedBy?.toString()?.tr('\n\r\t',' ').replaceAll(',',';')}?.unique() +","+
							  Relationship.findAllWhere(individual1:donor,relation:counsellorRel,status:'ACTIVE')?.collect{it.individual2?.toString()?.tr('\n\r\t',' ').replaceAll(',',';')}
					}
				}    		
				return
			}
		else
			{
                   def jsonCells = []
                   def adrStr,donor
		 def cultivatorRel = Relation.findByName('Cultivated by')
		 def counsellorRel = Relation.findByName('Councellee of')                   
                   if(!params.locality)
                   	jsonCells = result.collect {
                         donor = Individual.get(it.donated_by_id)
                         [cell: [
                         	    it.donor,
                         	    it.amount,
                         	    it.scheme,
                         	    Address.findAllByIndividual(donor)?.toString(),
                         	    VoiceContact.findAllByIndividual(donor)?.toString(),
                         	    EmailContact.findAllByIndividual(donor)?.toString(),
                         	    Relationship.findAllWhere(individual1:donor,relation:cultivatorRel,status:'ACTIVE')?.collect{it.individual2?.toString()},
                         	    Donation.findAllByDonatedBy(donor,[sort: "donationDate", order: "desc"])?.collect{it.collectedBy?.toString()}?.unique(),
                         	    Relationship.findAllWhere(individual1:donor,relation:counsellorRel,status:'ACTIVE')?.collect{it.individual2?.toString()},
                             ], id: it.donated_by_id]
                     }
                    else
                    	{
                    	//filter data as per locality
                    	result.each{itl->
                    		donor = Individual.get(itl.donated_by_id)
				adrStr = Address.findAllByIndividual(donor)?.toString()
				if(adrStr.toLowerCase().contains(params.locality.toLowerCase()))
					{
					jsonCells.add(
						 [cell: [
						    itl.donor,
						    itl.amount,
						    itl.scheme,
						    adrStr,
						    VoiceContact.findAllByIndividual(donor)?.toString(),
						    EmailContact.findAllByIndividual(donor)?.toString(),
						    Relationship.findAllWhere(individual1:donor,relation:cultivatorRel,status:'ACTIVE')?.collect{it.individual2?.toString()},
						    Donation.findAllByDonatedBy(donor,[sort: "donationDate", order: "desc"])?.collect{it.collectedBy?.toString()}?.unique(),
						    Relationship.findAllWhere(individual1:donor,relation:counsellorRel,status:'ACTIVE')?.collect{it.individual2?.toString()},
					     ], id: itl.donated_by_id]					
					)
					}
				}
                    	}
                     def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
                     render jsonData as JSON
                     return
                     }
                  }

	def setCultivator() {
		log.debug("Inside setCultivator with params:"+params)
		def num = 0
		num = individualService.setCultivator(params)
		render([message:num+" cultivators set!!"] as JSON)
	}
	
	def clorDashboard() {
		[clor:Individual.get(session.individualid)]
	}

    def donationPeriodReport = {
      log.debug("Inside donationReport with params: "+params)
      def sql = new Sql(dataSource);
      String query = "select s.name scheme, ilcoll.name collector, ilcoll.counsellor collectorsCounsellor, ildonor.name donor, ildonor.counsellor donorsCounsellor, sum(amount) amount from donation d, scheme s, individuallist ildonor, individuallist ilcoll  where d.scheme_id=s.id and d.donated_by_id=ildonor.indid and d.collected_by_id=ilcoll.indid and fund_receipt_Date>='"+params.from+"' and fund_receipt_Date<'"+params.to+"' group by s.name,collected_by_id,donated_by_id"
      log.debug(query)
      def result = sql.rows(query)
	sql.close()
      
	response.contentType = 'application/zip'
	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		zipOutputStream.putNextEntry(new ZipEntry("donations.csv"))
		//header
		zipOutputStream << "scheme,collector,collectorsCounsellor,donor,donorsCounsellor,amount" 
		result.each{ row ->
			zipOutputStream << "\n"
			zipOutputStream <<   row.scheme+","+
				  row.collector +","+
				  (row.collectorsCounsellor?:'') +","+
				  row.donor.tr('\n\r\t',' ').replaceAll(',',';') +","+
				  (row.donorsCounsellor?:'') +","+
				  row.amount
		}
	}    		
	return

        }

    def donationRecordPeriodReport = {
      log.debug("Inside donationRecordPeriodReport with params: "+params)
      def sql = new Sql(dataSource);
      String query = "select s.name scheme, ildonor.name donor, ildonor.counsellor donorsCounsellor, sum(amount) amount from donation_record d, scheme s, individuallist ildonor  where d.scheme_id=s.id and d.donated_by_id=ildonor.indid and (receipt_received_status is null or (receipt_received_status!='GENERATED' and  receipt_received_status!='NOTGENERATED')) and fund_receipt_date>='"+params.from+"' and fund_receipt_date<'"+params.to+"' group by s.name,donated_by_id"
      log.debug(query)
      def result = sql.rows(query)
	sql.close()
      
	response.contentType = 'application/zip'
	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		zipOutputStream.putNextEntry(new ZipEntry("donationRecords.csv"))
		//header
		zipOutputStream << "scheme,donor,donorsCounsellor,amount" 
		result.each{ row ->
			zipOutputStream << "\n"
			zipOutputStream <<   row.scheme+","+
				  row.donor.tr('\n\r\t',' ').replaceAll(',',';') +","+
				  (row.donorsCounsellor?:'') +","+
				  row.amount
		}
	}    		
	return

        }

	def donationSummaryReport() {
		def msg = donationService.donationSummary(params)
		render msg
	}

    def ocReport() {}
    
    def ocViewReport() {
      log.debug("Inside ccReport with params: "+params)
      if(params.fromDate)
      	params.fromDate = Date.parse('dd-MM-yyyy', params.fromDate)
      else
      	params.fromDate = new Date()
      	
      params.fromDate.clearTime()

      def fromDate = params.fromDate.format('yyyy-MM-dd HH:mm:ss')	//'2014-05-01 00:00:00'

      if(params.toDate)
      	params.toDate = Date.parse('dd-MM-yyyy', params.toDate)
      else
      	params.toDate = new Date()
      	
      params.toDate.clearTime()

      def toDate = params.toDate.format('yyyy-MM-dd')+' 23:59:59'	//'2014-05-01 00:00:00'

      def sql = new Sql(dataSource);
      String query = "select ad.*,p.pc, p.pchead from (select ccat.name costcategory, cc.name costcenter, s.name scheme, ilcoll.name collector, ilcoll.counsellor collectorsCounsellor, ildonor.name donor, ildonor.counsellor donorsCounsellor,ildonor.familyof donorsFamily, sum(amount) amount from donation d, scheme s, cost_center cc, cost_category ccat, individuallist ildonor, individuallist ilcoll  where d.scheme_id=s.id and s.cc_id=cc.id and cc.cost_category_id=ccat.id and d.donated_by_id=ildonor.indid and d.collected_by_id=ilcoll.indid and fund_receipt_date>='"+fromDate+"' and fund_receipt_date<'"+toDate+"' group by s.name,collected_by_id,donated_by_id) ad left join pclist p on ad.collector=p.pc and ad.donorsCounsellor is null union select ccat.name costcategory, cc.name costcenter, s.name scheme, '', '', ildonor.name donor, ildonor.counsellor donorsCounsellor,'', sum(amount) amount,'','' from donation_record d, scheme s, cost_center cc, cost_category ccat, individuallist ildonor  where d.scheme_id=s.id and s.cc_id=cc.id and cc.cost_category_id=ccat.id and d.donated_by_id=ildonor.indid  and (d.receipt_received_status is null or (receipt_received_status!='GENERATED' and receipt_received_status!='NOTGENERATED')) and fund_receipt_date>='"+fromDate+"' and fund_receipt_date<'"+toDate+"' group by s.name,donated_by_id"
      log.debug(query)
      def result = sql.rows(query)
	sql.close()
      
	response.contentType = 'application/zip'
	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		zipOutputStream.putNextEntry(new ZipEntry("overalldonations.csv"))
		//header
		zipOutputStream << "costcategory,costcenter,scheme,collector,collectorsCounsellor,donor,donorsCounsellor,donorsFamily,amount,pc,pchead" 
		result.each{ row ->
			zipOutputStream << "\n"
			zipOutputStream <<   row.costcategory+","+row.costcenter+","+row.scheme+","+
				  row.collector +","+
				  (row.collectorsCounsellor?:'') +","+
				  row.donor.tr('\n\r\t',' ').replaceAll(',',';') +","+
				  (row.donorsCounsellor?:'') +","+
				  (row.donorsFamily?:'') +","+
				  row.amount +","+
				  (row.pc?:'')+","+(row.pchead?:'')
		}
	}    		
	return

        }

    def ccReport() {}
    
    def ccViewReport() {
      log.debug("Inside ccReport with params: "+params)
      if(params.fromDate)
      	params.fromDate = Date.parse('dd-MM-yyyy', params.fromDate)
      else
      	params.fromDate = new Date()
      	
      params.fromDate.clearTime()

      def fromDate = params.fromDate.format('yyyy-MM-dd HH:mm:ss')	//'2014-05-01 00:00:00'

      if(params.toDate)
      	params.toDate = Date.parse('dd-MM-yyyy', params.toDate)
      else
      	params.toDate = new Date()
      	
      params.toDate.clearTime()

      def toDate = params.toDate.format('yyyy-MM-dd')+' 23:59:59'	//'2014-05-01 00:00:00'

      def sql = new Sql(dataSource);
      String query = "select * from ccreport"
      log.debug(query)
      def result = sql.rows(query)
	sql.close()
      
	response.contentType = 'application/zip'
	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		zipOutputStream.putNextEntry(new ZipEntry("ccreport.csv"))
		//header
		zipOutputStream << "costcategory,costcenter,scheme,collector,collectorsCounsellor,donor,donorsCounsellor,donorsFamily,amount,pc,pchead,counsellor,counsellee,donation,collection,contribution" 

		result.each{ row ->
			zipOutputStream << "\n"
			zipOutputStream <<   row.costcategory+","+row.costcenter+","+row.scheme+","+
				  row.collector +","+
				  (row.collectorsCounsellor?:'') +","+
				  row.donor.tr('\n\r\t',' ').replaceAll(',',';') +","+
				  (row.donorsCounsellor?:'') +","+
				  (row.donorsFamily?:'') +","+
				  row.amount +","+
				  (row.pc?:'')+","+(row.pchead?:'')+","+
				  (row.counsellor?:'')+","+(row.counsellee?:'')+","+
				  (row.donation?:'')+","+(row.collection?:'')+","+(row.contribution?:'')
		}
	}    		
	return

        }

    def pcReport() {}
    
    def pcViewReport() {
      log.debug("Inside pcReport with params: "+params)
      if(params.fromDate)
      	params.fromDate = Date.parse('dd-MM-yyyy', params.fromDate)
      else
      	params.fromDate = new Date()
      	
      params.fromDate.clearTime()

      def fromDate = params.fromDate.format('yyyy-MM-dd HH:mm:ss')	//'2014-05-01 00:00:00'

      if(params.toDate)
      	params.toDate = Date.parse('dd-MM-yyyy', params.toDate)
      else
      	params.toDate = new Date()
      	
      params.toDate.clearTime()

      def toDate = params.toDate.format('yyyy-MM-dd')+' 23:59:59'	//'2014-05-01 00:00:00'

      def sql = new Sql(dataSource);
      String query = "select ccat.name costcategory, cc.name costcenter, s.name scheme, plcoll.pc pc_collector, plcoll.pchead pc_collectorHead, ildonor.name donor, ildonor.counsellor donorsCounsellor, sum(amount) amount from donation d, scheme s, cost_center cc, cost_category ccat, individuallist ildonor, pclist plcoll  where d.scheme_id=s.id and s.cc_id=cc.id and cc.cost_category_id=ccat.id and d.donated_by_id=ildonor.indid and d.collected_by_id=plcoll.pcid and ildonor.counsellor is null and fund_receipt_Date>='"+fromDate+"' and fund_receipt_Date<'"+toDate+"' group by s.name,collected_by_id,donated_by_id"
      log.debug(query)
      def result = sql.rows(query)
	sql.close()
      
	response.contentType = 'application/zip'
	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		zipOutputStream.putNextEntry(new ZipEntry("pcreport.csv"))
		//header
		zipOutputStream << "costcategory,costcenter,scheme,pc_collector,pc_collectorHead,donor,donorsCounsellor,amount" 
		result.each{ row ->
			zipOutputStream << "\n"
			zipOutputStream <<   row.costcategory+","+row.costcenter+","+row.scheme+","+
				  row.pc_collector +","+
				  (row.pc_collectorHead?:'') +","+
				  row.donor.tr('\n\r\t',' ').replaceAll(',',';') +","+
				  (row.donorsCounsellor?:'') +","+
				  row.amount
		}
	}    		
	return

        }
        
        def populatePeriodReport() {
        	def msg = ""
        	if(params.'period.id')
        		msg = reportService.populatePeriodReport(params)
        	else
        		{
        		if(params.all) {
        			def periods = Period.list()
        			periods.each{
        				msg += reportService.populatePeriodReport(['period.id':it.id])
        				}
        			}
        		}
        	render msg
        }

    def periodReport() {
    }

    def downloadPeriodReport() {
    	def period
    	
    	try{
    		period = Period.get(params.'period.id')
    	}
    	catch(Exception e){}
    	
    	if(!period)
    		render "Invalid period!!"

    	def tableName = 'ccreport_'+period.name
      def sql = new Sql(dataSource);
      String query = "select * from "+tableName
      def result = sql.rows(query)
	sql.close()
      
	response.contentType = 'application/zip'
	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		zipOutputStream.putNextEntry(new ZipEntry(tableName+".csv"))
		//header
		zipOutputStream << "costcategory,costcenter,scheme,collector,collectorsCounsellor,donor,donorsCounsellor,donorsFamily,amount,pc,pchead,counsellor,counsellee,donation,collection,contribution" 

		result.each{ row ->
			zipOutputStream << "\n"
			zipOutputStream <<   (row.costcategory?:'')+","+(row.costcenter?:'')+","+(row.scheme?:'')+","+
				  (row.collector?:'') +","+
				  (row.collectorsCounsellor?:'') +","+
				  row.donor.tr('\n\r\t',' ').replaceAll(',',';') +","+
				  (row.donorsCounsellor?:'') +","+
				  (row.donorsFamily?:'') +","+
				  row.amount +","+
				  (row.pc?:'')+","+(row.pchead?:'')+","+
				  (row.counsellor?:'')+","+(row.counsellee?:'')+","+
				  (row.donation?:'')+","+(row.collection?:'')+","+(row.contribution?:'')
		}
	}    		
	return

        }

  }