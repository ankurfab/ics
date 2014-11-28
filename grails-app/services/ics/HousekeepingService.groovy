package ics

import grails.plugins.springsecurity.Secured
import javax.servlet.http.HttpSession
import org.springframework.web.context.request.RequestContextHolder
import groovy.sql.Sql;
import com.krishna.*
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.springframework.scheduling.annotation.Async


class HousekeepingService {
def springSecurityService
def dataSource ; 
def config = ConfigurationHolder.config

    static transactional = false
	static scope = "singleton"

  private HttpSession getSession() {
    return RequestContextHolder.currentRequestAttributes().getSession()
  }
  
  def setSessionParams()
  {
    	def login = springSecurityService.principal.username
   	println "Loggedin user: "+login
   	def individual = Individual.findByLoginid(login)
   	println "setSessionParams for: "+individual
  	if(individual==null)
  	{
  		getSession().showall = true
  	}
  	else
	{
		getSession().individualname = individual.toString()
		getSession().individualid = individual.id
		getSession().individualemail = EmailContact.findByIndividual(individual)?.emailAddress
		getSession().individualphone = VoiceContact.findByIndividual(individual)?.number
		getSession().showall = false
	}
	getSession().isReceiver = null
	getSession().isAdmin = false
	def authorities = springSecurityService.principal.authorities
	println "Authorities:"+authorities
	authorities.each{if(it=='ROLE_ADMIN') getSession().isAdmin = true}
	println "session.individualid:"+session.individualid
	println "getSession().individualid:"+getSession().individualid
	println "RequestContextHolder.currentRequestAttributes().getSession()?.user="+RequestContextHolder.currentRequestAttributes().getSession()?.user
	
	//access log
	try{
	AccessLog.withTransaction {
	def accessLog = new AccessLog()
	accessLog.loginid = login
	accessLog.ipaddr = (RequestContextHolder.currentRequestAttributes()).getRequest().getRemoteAddr();
	accessLog.loginTime = new Date()
	if(!accessLog.save())
		accessLog.errors.allErrors.each {
						println it
				}
	}
	}
	catch(Exception e){
		log.debug("Some error occurred while creating acess log .. "+e)
	}

	//@TODO need to find a better way to store these reminders in session
	
	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
	{
		println 'bdays today ='+bday(0)

		getSession().BdayTodayCount = bdaysToday().size()
		//println "BdayTodayCount:"+session.BdayTodayCount

		getSession().BdayTomorrowCount = bdaysTomorrow().size()
		//println "BdayTomorrowCount:"+session.BdayTomorrowCount

		getSession().MannivTodayCount = mannivsToday().size()
		//println "MannivTodayCount:"+session.MannivTodayCount

		getSession().MannivTomorrowCount = mannivsTomorrow().size()
		//println "MannivTomorrowCount:"+session.MannivTomorrowCount

		for(int i=0; i<bdaysToday().size(); i++)
			println 'bdaysToday()[i] ='+bdaysToday()[i]
		
	}
	//---------------
		/*if(session.isReceiver==null)
		{
			//set whether receiver
			def individual1 = Individual.get(session.individualid)
			def flag=false
			individual1?.individualRoles?.each{if (it.role.name == "Receiver") flag=true}
			if(flag)
				session.isReceiver = true
			else
				session.isReceiver = false

			println "isReceiver: "+session.isReceiver
		}	*/	
	
	//---------------
	/*if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
	{
		println "inside if"
		def displayString1
		//println "getBDaysMAnns():"+getBDaysMAnns()
		//getSession().displayString = getBDaysMAnns()
		displayString1 = getBDaysMAnns()
		println "displayString1:"+displayString1
		//session.displayString = displayString1
		//println "session.displayString:"+session.displayString
	}*/
	
  }

    def getBDaysMAnns()
    {
	//Birthdays and marriage anniversaries
	def birthdayList = [], mAnniversaryList = []
	if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
	{
		
		def login = springSecurityService.principal.username
		println "getBDaysMAnns Loggedin user: "+login
		def individual = Individual.findByLoginid(login)
		individual.refresh()
		individual.attach()
		
		println "getBDaysMAnns individual: "+individual
		println "getBDaysMAnns individual legalName: "+individual.legalName
		def pcRole = []
		//def IndRole = IndividualRole.findAllByIndividual(individual)
		
		pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
		//IndividualRole.attach()
		//def IndRole = IndividualRole.findAllWhere(individual:Individual.get(session.individualid),status:"VALID")
		//println 'IndRole='+IndRole
		
		/*for(int i=0; i<IndRole.size(); i++)
		{
			pcRole.add(IndRole[i].role)
		}*/
		//pcRole = IndividualRole.findAllByIndividualAndStatus(Individual.get(session.individualid),"VALID").role
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
		
		  def now = new Date()
		  //def bDayList = Donation.findAllByCollectedBy(Individual.get(session.individualid))
		  //println 'bDayList='+bDayList
		  //println 'now='+now
		  //println 'now+1='+now.next()
		  def tomorrowsDate = now.next()

		  def j = 0, birthMonthOfDonor, birthDateOfDonor
		  for(int i=0;i<individualInstanceList.size();i++)
		  {
			  if(individualInstanceList[i]?.dob)
			  {
				  birthMonthOfDonor = ((individualInstanceList[i].dob).month).toInteger()
				  birthDateOfDonor = (individualInstanceList[i].dob).getDate()
				if ((birthMonthOfDonor == now.month && birthDateOfDonor == now.getDate()) || (birthMonthOfDonor == now.month && birthDateOfDonor == tomorrowsDate.getDate()))
				{
					birthdayList[j] = individualInstanceList[i]
					j++
				}
			  }
		  }
		  
		  birthdayList = birthdayList.unique()
		  birthdayList = birthdayList.sort{it?.dob}
		  println 'birthdayList='+birthdayList
		  
		  def mAnnMonthOfDonor, mAnnDateOfDonor
		  for(int i=0;i<individualInstanceList.size();i++)
		  {
			  if(individualInstanceList[i]?.marriageAnniversary)
			  {
				  mAnnMonthOfDonor = ((individualInstanceList[i].marriageAnniversary).month).toInteger()
				  mAnnDateOfDonor = (individualInstanceList[i].marriageAnniversary).getDate()
				if ((mAnnMonthOfDonor == now.month && mAnnDateOfDonor == now.getDate()) || (mAnnMonthOfDonor == now.month && mAnnDateOfDonor == tomorrowsDate.getDate()))
				{
					mAnniversaryList[j] = individualInstanceList[i]
					j++
				}
			  }
		  }
		  mAnniversaryList = mAnniversaryList.unique()
		  mAnniversaryList = mAnniversaryList.sort{it?.marriageAnniversary}
		  println 'mAnniversaryList='+mAnniversaryList
		  
	}
	def displayString = ""
	if(birthdayList.size()>0)
	{
	     displayString = "Devotees celebrating their birthday today or tomorrow:\n<table border='1' cellspacing='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody>"
	     for(int i=0; i<birthdayList.size(); i++)
	     {
		displayString = displayString+"<tr><td><b>"+birthdayList[i]?.legalName+"</b></td><td><b>"+birthdayList[i]?.initiatedName?birthdayList[i]?.initiatedName:'-'+"</b></td><td><b>"+birthdayList[i]?.dob?.format('dd-MM-yyyy')+"</b></td><td><b>"+birthdayList[i]?.address+"</b></td><td><b>"+birthdayList[i]?.voiceContact+"</b></td><td><b>"+birthdayList[i]?.emailContact+"</b></td></tr>"
	     }
	     displayString = displayString+"</tbody></table>"
	}
	if(mAnniversaryList.size()>0)
	{
	     displayString = "Devotees celebrating their marriage anniversary today or tomorrow:\n<table border='1' cellspacing='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody>"
	     for(int i=0; i<mAnniversaryList.size(); i++)
	     {
		displayString = displayString+"<tr><td><b>"+mAnniversaryList[i]?.legalName+"</b></td><td><b>"+mAnniversaryList[i]?.initiatedName+"</b></td><td><b>"+mAnniversaryList[i]?.marriageAnniversary?.format('dd-MM-yyyy')+"</b></td><td><b>"+mAnniversaryList[i]?.address+"</b></td><td><b>"+mAnniversaryList[i]?.voiceContact+"</b></td><td><b>"+mAnniversaryList[i]?.emailContact+"</b></td></tr>"
	     }
	     displayString = displayString+"</tbody></table>"
	}
	
	//displayString = "Devotees celebrating their birthday today or tomorrow:<table border='1' cellspacing='0' cellpadding='0'><thead><tr><th>Legal Name</th><th>Initiated Name</th><th>Birthdate</th><th>Address</th><th>Phone</th><th>Email</th></tr></thead><tbody><tr><td><b>abp2</b></td><td><b>null</b></td><td><b>27-07-2012</b></td><td><b>[]</b></td><td><b>[]</b></td><td><b>[]</b></td></tr></tbody></table>"
	println 'displayString='+displayString
	return displayString	
    }
	
    def getIndividual(String individualid)
    {
		def individual = Individual.get(individualid)

		return individual
       
     }
     
  	def getMaxBatchId()
  	{  
  
  		def maxBatchId = ReceiptBookIssued.executeQuery("SELECT max(batchId) FROM ReceiptBookIssued")
  		if (!maxBatchId[0])
  			maxBatchId[0] = 0
  		return maxBatchId[0]+1
  
  	}
  	
  	def getNextLotIdForLoan()
  	{  
  
  		def maxLotId = Loan.executeQuery("SELECT max(lotId) FROM Loan")
  		if (!maxLotId[0])
  			maxLotId[0] = 0
  		return maxLotId[0]+1
  
  	}

    def filterIndividualList()
    {
    	//get only those individuals who are 'related' to the logged-in user
    	if(getSession().showall!=null && getSession().showall==false)
    	{
		def individual = Individual.get(getSession().individualid)
		def relationships = Relationship.findAllByIndividual2(individual)
		def relatedIndividuals = []
		relationships.each{relatedIndividuals.push(it.individual1)}

		return relatedIndividuals
        }
        
     }
     
     def followupsBy()
     {
	def individual = Individual.get(getSession().individualid)
	def followupInstanceList = Followup.findAllByFollowupBy(individual)
	return followupInstanceList

     }
     
     def showSessionParams()
     {
     	println "Session params:"+getSession().showall+":"+getSession().individualid+":"+getSession().individualname
     }
     
     def uniqueSet(Set set1, Set set2)
     {
     def us = [] as Set
     set1.each{
     		us.add(it)
     		}
     set2.each{
     		us.add(it)
     		}
     return us
     }


	def bulkReceicpt(ReceiptBook rb, String bookLastSerialNumber)
	{
	
	println "Bulk creating ReceiptBooks! Starting from : " + rb
	println "Last serial number.."+bookLastSerialNumber
	
	int iRBStartSeq =  rb.bookSerialNumber;
	int iRFirst = rb.startingReceiptNumber;
	int iNumPages = rb.numPages;
	int iRBLastSeq = bookLastSerialNumber?.toInteger();
	
	int lastId = rb.id
	
	println "Values..:"+iRBStartSeq+"-"+iRFirst+"-"+iNumPages+"-"+iRBLastSeq

	int k = iRFirst;
	def rbinstance = rb
	for(int i=iRBStartSeq;i<=iRBLastSeq;i++)
	{
		for (int j=0;j<iNumPages;j++)
		{
			def receipt = new Receipt()
			receipt.book = (rb.bookSeries?:"")+i
			receipt.receiptBook = rbinstance
			receipt.receiptNumber = (rb.bookSeries?:"")+k
			receipt.isBlank = true
			receipt.creator = springSecurityService.principal.username
			receipt.updator = springSecurityService.principal.username
			if(!receipt.save())

			{
			    println "Some problem in saving receipts for RB "+rbinstance+" Leaf no: "+j
			    if(receipt.hasErrors()) {
				receipt.errors.each {
				  println it
				}
			    }
			}
			k++;
		}
		if(i!=iRBLastSeq)
			{
			//create next receipt book
			rbinstance = new ReceiptBook()
			rbinstance.category = rb.category
			rbinstance.status = rb.status
			rbinstance.comments = rb.comments
			rbinstance.bookSeries = rb.bookSeries
			rbinstance.bookSerialNumber = i+1
			rbinstance.startingReceiptNumber = k
			rbinstance.numPages = rb.numPages
			rbinstance.isBlank = true
			rbinstance.creator = springSecurityService.principal.username
			rbinstance.updator = springSecurityService.principal.username
			rbinstance.save()
			lastId = rbinstance.id
			}
	}
	return lastId
	}

	def createCollector(String name)
	{
		def ind = new Individual()
		ind.legalName = name
		ind.category = "Auto created from ReceiptBook"
		ind.save(flush:true)
		ind.icsid=ind.id+100000
		ind.save()
		
		def role = Role.findByName("Collector")
		
		def indRole = new IndividualRole()
		indRole.role = role
		indRole.individual = ind
		indRole.save(flush:true)
		
		return ind.id
	}
	
	def createRelationshipGroup(String name)
	{
		def rg = new RelationshipGroup()
		rg.groupName = name
		rg.comments = "Auto created"
		rg.save(flush:true)
		return rg.id
	}
	
	def createRelation(String name)
	{
		def r = new Relation()
		r.name = name
		r.save(flush:true)
		return r.id
	}
	
	def createUniqueString(String str1, String str2)
	{
		str1 = str1?.trim()
		str2 = str2?.trim()
		if (str1==null)
			return str2?:""
		if (str2==null)
			return str1?:""
		//both non-null
		//check if same
		if(str1==str2)
			return str1
		else if(str2?.size()>0)
			return str1+"!!"+str2
	}
	
	def markNotBlank(Long id)
	{
	
		def d = Donation.get(id)

		def receipt = d.donationReceipt
		receipt.isBlank = false
		receipt.save()

		def rb = receipt.receiptBook
		rb.isBlank = false
		rb.save()
	}
	
	def getNextCMPLRcptNo()
	{
	   def sql = new Sql(dataSource);
 	   def id = sql.firstRow("select count(*)+1 c from donation where nvcc_receipt_book_no='CMPL'")
 		return id.c

	}

	def checkUniqueRcptNo(String rb, String rno)
	{
	println "Inside:checkUniqueRcptNo"
	if (!rb || !rno)
		return false
	   def sql = new Sql(dataSource);
	   def query = "select count(*) c from donation where nvcc_receipt_book_no='"+rb+"' and nvcc_receipt_no='"+rno+"'"
 	   def id = sql.firstRow(query)
 	   println query
 	   println "Result:"+id+":"+id.c
 		if (id.c>=1)
 			return false
 		else
 			return true

	}

	def checkValidRcptNo(String rb, String rno)
	{
	println "Inside:checkValidRcptNo"
	if (!rb || !rno)
		return false
	
	//TODO: make it depend on the RB / R entities , this method should not be required in future
	//Works only for A series as of now
	if(rb.charAt(0)!='A')
		return true
	def nrb = rb.substring(1)
	def nr = rno.substring(1)
	println "NRB:"+nrb+" NR:"+nr
	//check whether in range or not
	def maxr = Integer.parseInt(nrb)*25
	def minr = (maxr-25) + 1
	
	println "minr:"+minr +" maxr:"+maxr
	
	if (Integer.parseInt(nr)>=minr && Integer.parseInt(nr)<=maxr)
		return true
	else
		return false

	}

	def donationRecordSummary(String indId)
	{
	   def sql = new Sql(dataSource);
	   def queryInd = "select sum(amount) amt from donation_record where (receipt_received_status is null or (receipt_received_status!='GENERATED' and receipt_received_status!='NOTGENERATED')) and donated_by_id="+indId
	   def queryScheme = "select s.name scheme,sum(amount) amt from donation_record d, scheme s where  (receipt_received_status is null or (receipt_received_status!='GENERATED' and receipt_received_status!='NOTGENERATED')) and d.scheme_id=s.id and donated_by_id="+indId+" group by s.name"
	   
 	   def amtInd = sql.firstRow(queryInd).amt
	   def sList = sql.rows(queryScheme)
	   sql.close()

 	   return [amtIndDR: amtInd, sListDR: sList]
	}


	def donationSummary(String indId)
	{
	   def sql = new Sql(dataSource);
	   def queryInd = "select sum(amount) amt from donation where (status is null or status <> 'BOUNCED') and donated_by_id="+indId
	   //def queryFam = "select sum(amount) amt from donation where (status is null or status <> 'BOUNCED') and donated_by_id in (select individual1_id from relationship where relationship_group_id in (select id from relationship_group where refid="+indId+" and group_name like 'Family%') union select "+indId+" from dual)"
	   def queryFam = "select sum(amount) amt from donation where (status is null or status <> 'BOUNCED') and donated_by_id in (select individual1_id from relationship where relationship_group_id in (select id from relationship_group where refid="+indId+" and group_name like 'Family%') union select "+indId+" from dual union (select distinct rg.refid from relationship r, relationship_group rg where r.relationship_group_id=rg.id and rg.group_name like 'Family%' and r.individual1_id="+indId+") union select distinct individual1_id from relationship where relationship_group_id = (select distinct rg.id from relationship r, relationship_group rg where r.relationship_group_id=rg.id and rg.group_name like 'Family%' and r.individual1_id="+indId+"))"
	   def queryCol = "select sum(amount) amt from donation where (status is null or status <> 'BOUNCED') and collected_by_id="+indId
	   def queryColExclOwn = "select sum(amount) amt from donation where (status is null or status <> 'BOUNCED') and collected_by_id<> donated_by_id and collected_by_id="+indId
	   def queryScheme = "select s.name scheme,sum(amount) amt from donation d, scheme s where d.scheme_id=s.id and (status is null or status <> 'BOUNCED') and donated_by_id="+indId+" group by s.name"
	   
 	   def amtInd = sql.firstRow(queryInd).amt
 	   def amtFam = 0
 	   def famrgid
 	   try{
 	   	amtFam = sql.firstRow(queryFam).amt
 	   }
 	   catch(e){
 	   	//individual related to many families
 	   	famrgid = getFamily()
 	   	if(famrgid!=-1)
 	   		{
			   try{
			   queryFam = "select sum(amount) amt from donation where (status is null or status <> 'BOUNCED') and donated_by_id in (select individual1_id from relationship where relationship_group_id in ("+famrgid+") union select "+indId+" from dual union (select distinct rg.refid from relationship r, relationship_group rg where r.relationship_group_id=rg.id and rg.id= "+famrgid+" and r.individual1_id="+indId+") union select distinct individual1_id from relationship where relationship_group_id = "+famrgid+")"
			   amtFam = sql.firstRow(queryFam).amt
			   }
			   catch(e1){log.debug(e1)}
 	   		}
 	   	else
 	   		amtFam = -1

 	   }
 	   def amtCol = sql.firstRow(queryCol).amt
 	   def amtColExclOwn = sql.firstRow(queryColExclOwn)?.amt

	   def sList = sql.rows(queryScheme)

	   /*def sAmtMap = [:]
	   sList.each { i ->
	     sAmtMap[i.scheme] = i.amt
	   }*/
	   
	   println "donationSummary:"+indId+":"+amtColExclOwn
	   println sList

 	   
 	   def queryGiftInd = "select sum(gi.issued_qty * g.worth) amt from gift g, gift_issued gi where gi.gift_id=g.id and gi.issued_to_id="+indId
 	   def queryGiftFam = "select sum(gi.issued_qty * g.worth) amt from gift g, gift_issued gi where gi.gift_id=g.id and gi.issued_to_id in (select individual1_id from relationship where relationship_group_id in (select id from relationship_group where refid="+indId+" and group_name like 'Family%') union select "+indId+" from dual  union (select distinct rg.refid from relationship r, relationship_group rg where r.relationship_group_id=rg.id and rg.group_name like 'Family%' and r.individual1_id="+indId+") union select distinct individual1_id from relationship where relationship_group_id = (select distinct rg.id from relationship r, relationship_group rg where r.relationship_group_id=rg.id and rg.group_name like 'Family%' and r.individual1_id="+indId+"))"

 	   def amtGiftInd = sql.firstRow(queryGiftInd).amt
 	   def amtGiftFam = 0
 	   try{
 	   	amtGiftFam = sql.firstRow(queryGiftFam).amt
 	   }
 	   catch(e){
 	   	try{
	 	   queryGiftFam = "select sum(gi.issued_qty * g.worth) amt from gift g, gift_issued gi where gi.gift_id=g.id and gi.issued_to_id in (select individual1_id from relationship where relationship_group_id in ("+famrgid+") union select "+indId+" from dual  union (select distinct rg.refid from relationship r, relationship_group rg where r.relationship_group_id=rg.id and rg.id = "+famrgid+" and r.individual1_id="+indId+") union select distinct individual1_id from relationship where relationship_group_id = ("+famrgid+"))"
 	   	   amtGiftFam = sql.firstRow(queryGiftFam).amt
 	   	}
 	   	catch(e1){}
 	   }
 	   
 	   def queryNumGiftInd = "select sum(gi.issued_qty) c from gift g, gift_issued gi where gi.gift_id=g.id and gi.issued_to_id="+indId
 	   def numGiftInd = sql.firstRow(queryNumGiftInd).c


 	   def queryBCInd = "SELECT sum(amount) amt FROM followup f,bounced_cheque bc,donation d where f.followup_with_id=d.donated_by_id and d.id = bc.donation_id and f.followup_with_id="+indId+" and f.status='Open' and f.category='Bounced Cheque'"
 	   def queryBCFam = "SELECT sum(amount) amt FROM followup f,bounced_cheque bc,donation d where f.followup_with_id=d.donated_by_id and d.id = bc.donation_id and f.followup_with_id in (select individual1_id from relationship where relationship_group_id in (select id from relationship_group where refid="+indId+" and group_name like 'Family%') union select "+indId+" from dual) and f.status='Open' and f.category='Bounced Cheque'"
 	   def amtBCInd = sql.firstRow(queryBCInd).amt
 	   def amtBCFam = sql.firstRow(queryBCFam).amt

	   sql.close()

 	   return [amtInd: amtInd, amtFam: amtFam, amtCol: amtCol, sList: sList, amtColExclOwn:amtColExclOwn, numGiftInd: numGiftInd, amtGiftInd: amtGiftInd, amtGiftFam:amtGiftFam, amtBCInd: amtBCInd, amtBCFam: amtBCFam]
	}

	@Async
	def sendSMS(String phonenos, String message)
	{
		//remove any space from message for SMS
		def tmsg = message.replace(" ","%20")

		//def url = new URL ("http://ctr.beyondmobile.co.in/sendhttp.php?user="+config.ics.sms.beyondmobile.user1.name+"&password="+config.ics.sms.beyondmobile.user1.pwd+"&mobiles="+phonenos+"&message="+message+"&sender=ICSPUN&unicode=1");
		def url = new URL ("http://203.212.70.200/smpp/sendsms?username="+config.ics.sms.beyondmobile.user2.name+"&password="+config.ics.sms.beyondmobile.user2.pwd+"&to="+phonenos+"&from=ICSPUN&udh=&text="+tmsg+"&dlr-mask=19&dlr-url&category=bulk");
		println "url="+url
		def conn = url.openConnection() 
		conn.setRequestMethod("POST") 

		String data = "firstname=joe&lastname=blog" 

		conn.doOutput = true 

        	try{
			Writer wr = new OutputStreamWriter(conn.outputStream) 
			wr.write(data) 
			wr.flush() 
			wr.close() 

			conn.connect() 
			println "conn.content.text="+conn.content.text 
			//errorcode = 0 --> success
			//errorcode = 3 --> something wrong(missing text)
			//errorcode = 14 --> invalid template
		}
		catch(Exception e)
		{
			println e
		}

	}

	@Async
	def sendGenericSMS(String phonenos, String message)
	{
		log.debug("In sendGenericSMS:"+message+phonenos)
		message = message.replace(" ","%20") //replace spaces
		message = message.replace("&","%26") //replace '&'
		message = message.replace("\n","%0d") //replace newline
		
		phonenos = phonenos.replace(" ","") //replace spaces
		phonenos = phonenos.replace("\t","") //replace tabs

		def url = new URL ("http://ctr.beyondmobile.co.in/sendhttp.php?user="+config.ics.sms.beyondmobile.user3.name+"&password="+config.ics.sms.beyondmobile.user3.pwd+"&mobiles="+phonenos+"&message="+message+"&sender=ICSPUN");
		log.debug(url)
		//http://ctr.beyondmobile.co.in/sendhttp.php?user=46279&password=password&mobiles=9999999999,919999999999&message=message&sender=senderid
		def conn = url.openConnection() 
		conn.setRequestMethod("POST") 

		String data = "firstname=joe&lastname=blog" 

		conn.doOutput = true 

        	try{
			Writer wr = new OutputStreamWriter(conn.outputStream) 
			wr.write(data) 
			wr.flush() 
			wr.close() 

			conn.connect() 
			println "conn.content.text="+conn.content.text 
			//errorcode = 0 --> success
			//errorcode = 3 --> something wrong(missing text)
			//errorcode = 14 --> invalid template
		}
		catch(Exception e)
		{
			println e
		}
	}
	
	def getSMSBalance()
	{
		log.debug("In getSMSBalance")

		def url = new URL ("http://ctr.beyondmobile.co.in/api/balance.php?user="+config.ics.sms.beyondmobile.user3.name+"&password="+config.ics.sms.beyondmobile.user3.pwd+"&type=template");
		def conn = url.openConnection() 
		conn.setRequestMethod("POST") 

		String data = "firstname=joe&lastname=blog" 

		conn.doOutput = true
		def retVal

        	try{
			Writer wr = new OutputStreamWriter(conn.outputStream) 
			wr.write(data) 
			wr.flush() 
			wr.close() 

			conn.connect() 
			retVal = conn.content.text 
		}
		catch(Exception e)
		{
			println e
		}
		return retVal
	}

	@Async
	def sendEmail(List toAddr, String sub, String message)
	{
		try{
			sendMail {     
			  to toAddr.toArray()
			  from "nvcc@iskconpune.in"
			  subject sub     
			  body message
			}   
		}
		catch(Exception e)
		{
			println e
		}
	}
	
	@Async
	def sendEventRegistrationEmail(String toAddr, String sub, EventRegistration er) {

		try {
			sendMail {
				to      toAddr
				from	"nvcc@iskconpune.in"
				subject sub
				body( view:"/email/_registrationDone", 
					    model:[eventRegistrationInstance:er])
			}
			log.debug( "Email Sent to " + toAddr)
		} catch(Exception e) {
			println e
		}
	}

	@Async
	def sendEventRegistrationConfirmationEmail(String toAddr, String sub, String loginid, String password, String regcode) {

		try {
			sendMail {
				to      toAddr
				from	"nvcc@iskconpune.in"
				subject sub
				body( view:"/email/_registrationConfirmation", 
					    model:[loginid:loginid, password: password,regcode: regcode])
			}
			println "Confirmation Email Sent to " + toAddr
		} catch(Exception e) {
			println e
		}
	}

	@Async
	def sendVIPEventRegistrationConfirmationEmail(String toAddr, String sub) {

		try {
			sendMail {
				to      toAddr
				from	"guestcare@iskconnvcc.org"
				subject sub
				body( view:"/email/_vipregistrationConfirmation")
			}
			println "Confirmation Email Sent to " + toAddr
		} catch(Exception e) {
			println e
		}
	}

	@Async
	def sendEventRegistrationNotificationEmail(List toAddr, String sub, EventRegistration er) {

		if(er.isVipDevotee)
			{
				try {
					sendMail {
						to      toAddr.toArray()
						from	"guestcare@iskconnvcc.org"
						subject "VIP Guest Registered!"
						body( view:"/email/_vipregistrationNotification", 
							    model:[eventRegistrationInstance:er])
					}
					println "Email Sent to " + toAddr
				} catch(Exception e) {
					println e
				}
			}
		else
			{
				try {
					sendMail {
						to      toAddr.toArray()
						from	"nvcc@iskconpune.in"
						subject sub
						body( view:"/email/_registrationNotification", 
							    model:[eventRegistrationInstance:er])
					}
					println "Email Sent to " + toAddr
				} catch(Exception e) {
					println e
				}
			}
		
	}
	
	@Async
	def sendGenericEMAIL(List toAddr, String frm, String sub, String bdy, String ccSender, String bccRecipients) {
		log.debug(ccSender+"   "+bccRecipients)
		try {
			sendMail {
				if(bccRecipients!="true")
					to      toAddr.toArray()
				else
					bcc toAddr.toArray()
					
				from	frm
				subject sub
				body bdy
				if(ccSender=="true")
					cc      frm
			}
			println "GenericEmail Sent to " + toAddr
		} catch(Exception e) {
			println e
		}
	}

	def getphonenos(Individual ind)
	{
		def allnos = ""
		ind?.voiceContact?.each{it ->
			allnos += (it.number?:"")+","
		}
		println "allnos: "+allnos
		def nlist = allnos.tokenize(",")
		def validnos = ""
		nlist.each{it ->
			//should be either number having 10 to 12 digits
			println "number: "+it
			if(it ==~ /\d\d\d\d\d\d\d\d\d\d/ || it ==~ /\d\d\d\d\d\d\d\d\d\d\d/ || it ==~ /\d\d\d\d\d\d\d\d\d\d\d\d/)
				{
				println "Valid: "+it
				validnos += it + ","
				}
				
		}
		return validnos
	}
	
	def getAllphonenos()
	{
		def fos= new FileWriter('allphonenos.txt')

	   def sql = new Sql(dataSource);
	   def query = "select donar_code,legalname,initiatedname,wellwisherflag,homephone,cellphone,companyphone from ssrvcdb.donar_master order by legalname"
	   def sList = sql.rows(query)

		println "start"
	   sList.each { i ->
		if(i.cellphone)
			i.cellphone.eachMatch( /[1-9][0-9]{9}/ ){ fos.write("Cellphone | "+i.legalname+" | "+it+"\n") }
		if(i.homephone)
			i.homephone.eachMatch( /[1-9][0-9]{9}/ ){ fos.write( "Homephone | "+i.legalname+" | "+it +"\n")}
		if(i.companyphone)
			i.companyphone.eachMatch( /[1-9][0-9]{9}/ ){ fos.write( "Companyphone | "+i.legalname+" | "+it +"\n")}
	   }
		println "done"
	   sql.close()
	   fos.close()
	}
	
	def getNextSequence(String cat, String typ)
	{
		println cat
		println typ
  		def maxSequence = SequenceGenerator.findByCategoryAndType(cat,typ)
		
  		if (!maxSequence)
  		{
			def sequenceGeneratorInstance = new SequenceGenerator() 
			sequenceGeneratorInstance.category = cat
			sequenceGeneratorInstance.type = typ  		
  		
  			sequenceGeneratorInstance.sequence = 1  			
			if (sequenceGeneratorInstance.save(flush: true)) {
			    return (1)
			}
			else
				println "error in saving"
  		}
  		else
  		{
  			println maxSequence?.sequence
  			def nextSeq = maxSequence?.sequence + 1

  			maxSequence.sequence = nextSeq
			if (maxSequence.save(flush: true)) {
			    return (nextSeq)
			}
			else
				println "error in saving"

  		}
	}
	
	def checkDependent(String id, Long sid)
	{
		//todo hardcoded check for now
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_COUNSELLOR_GROUP'))
			return true
		println "Checking dependency.."+id+" : "+sid
		def flag = false
		//check for self entry
		if(id.toLong()==sid)
			flag = true
		else
			{
			//check if guiding
			def rships = Relationship.findAllWhere(individual1: Individual.get(id),individual2:Individual.get(sid),status:'ACTIVE')
			if(rships.size()>0)
				flag = true
			}
		return flag
	}
	
	def searchIndividualName(String name)
	{

		if(!name)
			return []
			
		name = name.replace('.',' ')
		name = name.replace('~',' ')
		name = name.replace('*',' ')
		name = name.replace('-',' ')
		name = name.replace('\\(',' ')
		name = name.replace('\\)',' ')

		def sresults
		def indlist = []
		def searchStr, tokens
		sresults = Individual.search(name)
		if(sresults.total>0)
			{
			indlist = sresults.results
			}
		else
			{
			//try breaking the name
			tokens = name.split()
			searchStr = ''
			tokens.each
				{
				if(it.size()>3)
					searchStr += it +"~ "
				}
			println "In searchIndividualName: fuzzy search string 1st pass: " + searchStr
			sresults = Individual.search(searchStr)
			if(sresults.total>0)
				{
				indlist = sresults.results
				}
			else
				{
				//now try to middle tokens and preserve only 1st and last
				def origSearchStr = searchStr
				tokens = searchStr.split()
				if(tokens.size()>2)
					searchStr = tokens[0]+" "+tokens[tokens.size()-1]
				else
					searchStr = tokens[0]
				println "In searchIndividualName: fuzzy search string 2nd pass: " + searchStr
				sresults = Individual.search(searchStr)
				if(sresults.total>0)
					{
					indlist = sresults.results
					}
				//also try without the 1st word (mostly first name)
				tokens = origSearchStr.split()
				searchStr = ''
				if(tokens.size()>2)
					{
					tokens.eachWithIndex{obj,i ->
						if(i>0)
							searchStr += obj+" "
					}
					println "In searchIndividualName: fuzzy search string 3rd pass: " + searchStr
					sresults = Individual.search(searchStr)
					if(sresults.total>0)
						{
						indlist += sresults.results
						}
					}
				}
			}
		def searchResult = indlist.flatten()
		//now remove 'DELETED','MERGED' entries
		def result = []
		searchResult.each{it->
			if(!it.status || (it.status!='DELETED' && it.status!='MERGED'))
				result.add(it)
			}
		return result
	}

	def searchAddress(String addr)
	{
		println "Searching for address.."+addr
		//todo remove special chars like . ~ * - ( )
		//also remove in name search
		addr = addr.replace('.',' ')
		addr = addr.replace('~',' ')
		addr = addr.replace('*',' ')
		addr = addr.replace('-',' ')
		addr = addr.replace('\\(',' ')
		addr = addr.replace('\\)',' ')

		def tokens, searchStr='', saddrInds, tokens2, tokens3, tokens4
		def maddrInds = []
		
		//first chose relevant token only
		tokens = addr.split(',')
		tokens.each
			{
			if(it.size()>4)
				{
				//split this further
				tokens2 = it.split()
				tokens2.each{i->
					if(i.size()>4)
						{
						//check if this token has no digits
						if(!i.find(/\d+/))
							searchStr += i +"~ "
						}
					}
				}
			}
		//restrict search to few tokens only
		tokens4 = searchStr.split()
		println "before sorting..."+tokens4
		tokens4 = tokens4.sort{it.size()}
		println "after sorting..."+tokens4
		if(tokens4.size()>4)
			{
			println "restricting tokens:"+tokens4.size()
			tokens4 = tokens4[(tokens4.size()-4)..(tokens4.size()-1)]
			searchStr =""
			tokens4.each{it->
				searchStr+=it+" "
				}
			}
		println "addrs search string.."+searchStr
		try{
			saddrInds = Address.search(searchStr)
		}
		catch(Exception e)
			{}
		def ind
		if(saddrInds?.total>0)
			{
			saddrInds.results.each{
				ind = Address.get(it.id)?.individual
				if(!ind.status || (ind.status!='DELETED' && ind.status!='MERGED'))
					maddrInds.add(ind)
				}
			}
		return maddrInds
	}
	
	def bday(int nextday) {
	      def now = new Date()
	      def today = now.format('D')
	      println 'now.getDate()='+now.getDate()
	      println 'date='+now.date
	      println 'month='+((now.month).toInteger()+(1*1).toInteger())*1
		def indList = Individual.createCriteria().list{
				relative1{
				eq("individual2",Individual.get(session.individualid))
				eq("relation",Relation.findByName("Cultivated by"))
				eq("status","ACTIVE")
				}
				//todo works in latest verion, sqlinjection safe sqlRestriction "dayofyear(dob) >= ? AND dayofyear(dob) <= ?", [1, 10]
				sqlRestriction "dayofyear(dob) >= "+today+" AND dayofyear(dob) <= "+(nextday+today)
			}
		//println 'indList='+indList
		return indList
	}
	
	def bdaysToday() {
	      def now = new Date()
	      def today = now.format('D')
	      //println 'now='+now
	      //println 'today='+today
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
		return indList
	}


	
	def bdaysTomorrow() {
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
		return indList
	}



	def mannivsToday() {
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
		return indList
	}
	

	
	def mannivsTomorrow() {
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
		return indList
	}


	
	def getIndividualsCultivatedByPC() {
	
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
						individualInstanceList.add(individualRels[k].individual1)
				}
			}
			if(pcRole[i].toString() == "PatronCareSevak")
			{
				individualRels = Relationship.findAllWhere(individual2:individual, relation:cultivatedByRelation, status:"ACTIVE")
				for(int j=0; j<individualRels.size(); j++)
					individualInstanceList[j] = individualRels[j].individual1
			}			
		}
		
		individualInstanceList = individualInstanceList.unique()
		return individualInstanceList
	
	}
	
	def getPCGroup() {
		def login = springSecurityService.principal.username
		println "Loggedin user: "+login
		def individual = Individual.findByLoginid(login)
		println "setSessionParams for: "+individual
	
		def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
		println 'pcRole='+pcRole
		def patronCare = []
		def cultivatedByRelation = Relation.findByName("Cultivated by")
		
		for(int i=0; i<pcRole.size(); i++)
		{
			if(pcRole[i].toString() == "PatronCare")
			{

				def sevakOfRelation = Relation.findByName("Sevak of")
				patronCare = Relationship.findAllWhere(individual2:individual, relation:sevakOfRelation, status:"ACTIVE").individual1		
				
			}
		}
		patronCare.add(individual)
		patronCare = patronCare.id
		log.debug("PC list .. "+patronCare)
		return patronCare
	
	}
	
	def getAllPC() {
		def pcs = IndividualRole.createCriteria().list{
				eq('status','VALID')
				role{ilike('name','%patron%')}
				individual{order('legalName','asc')}				
			}.collect{it.individual}
		return pcs
	}

	def searchPersonName(String name)
	{

		name = name.replace('.',' ')
		name = name.replace('~',' ')
		name = name.replace('*',' ')
		name = name.replace('-',' ')
		name = name.replace('\\(',' ')
		name = name.replace('\\)',' ')

		def sresults
		def indlist = []
		def searchStr, tokens
		sresults = Person.search(name)
		if(sresults.total>0)
			{
			indlist = sresults.results
			}
		else
			{
			//try breaking the name
			tokens = name.split()
			searchStr = ''
			tokens.each
				{
				if(it.size()>3)
					searchStr += it +"~ "
				}
			println "In searchPersonName: fuzzy search string 1st pass: " + searchStr
			sresults = Person.search(searchStr)
			if(sresults.total>0)
				{
				indlist = sresults.results
				}
			else
				{
				//now try to middle tokens and preserve only 1st and last
				def origSearchStr = searchStr
				tokens = searchStr.split()
				if(tokens.size()>2)
					searchStr = tokens[0]+" "+tokens[tokens.size()-1]
				else
					searchStr = tokens[0]
				println "In searchPersonName: fuzzy search string 2nd pass: " + searchStr
				sresults = Person.search(searchStr)
				if(sresults.total>0)
					{
					indlist = sresults.results
					}
				//also try without the 1st word (mostly first name)
				tokens = origSearchStr.split()
				searchStr = ''
				if(tokens.size()>2)
					{
					tokens.eachWithIndex{obj,i ->
						if(i>0)
							searchStr += obj+" "
					}
					println "In searchPersonName: fuzzy search string 3rd pass: " + searchStr
					sresults = Person.search(searchStr)
					if(sresults.total>0)
						{
						indlist += sresults.results
						}
					}
				}
			}
		return indlist.flatten()
	}
	
	def createLogin(Individual i, IcsRole ir)
	{
		def iu,name
		//first check if loginid present or not
		if(!i.loginid)
			{
			//generate the loginid
			//i.loginid = genlogin(i)
			name = i.initiatedName?:i.legalName
			i.loginid = genloginFromName(name)
			println "generated loginid: "+i.loginid
			if(!i.save(flush:true))
				{
				iu.errors.allErrors.each {
					println it
				}
				return ""
				}
			
			//now create the user
			iu = new IcsUser(username: i.loginid, password: i.loginid, enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false)
			if(!iu.save(flush:true)) {
				iu.errors.allErrors.each {
					println it
				}
				return ""
				}
			}
		else
			iu = IcsUser.findByUsername(i.loginid)
		
		println "IU: "+iu
		if(!iu)
			return ""
			
		//now add the role if not exists
		/*def ir = IcsRole.findByAuthority(role)
		if(!ir)
			{
			println role +" not found!!"
			return ""
			}*/

		def ur = IcsUserIcsRole.findByIcsUserAndIcsRole(iu,ir)
		if(!ur)
		{
			def iuir = new IcsUserIcsRole()
			iuir.icsUser = iu
			iuir.icsRole = ir
			if(!iuir.save(flush:true)) {
				iuir.errors.allErrors.each {
					println it
				}
				return ""
				}
			else return i.loginid
		}
		return ""
	}
	
	//genererate the login id string
	def genlogin(Individual i)
	{
		def login = ""
		def name = i.initiatedName?:i.legalName
		def tokens = name.tokenize()
		def numTokens = tokens.size()
		if(numTokens>1)
			{
				tokens.each{
					if(it.size()>=3)
						login += it.substring(0,3)
				}
			}
		else
			{
			login = name.substring(0,7)
			}
		login+=new Random().nextInt(8)+1
		
		login = login.toLowerCase()
	}

	//genererate the login id string
	def genloginFromName(String name)
	{
		def login = ""
		def tokens = name.tokenize()
		def numTokens = tokens.size()
		if(numTokens>1)
			{
				tokens.each{
					if(it.size()>=3)
						login += it.substring(0,3)
				}
			}
		else
			{
			if(name.size()>=7)
				login = name.substring(0,7)
			else
				login = name
			}
		def unique = false
		while(!unique) {
			login+=new Random().nextInt(8)+1
			login = login.toLowerCase()
			unique = checkUniqueLogin(login)
		}
		return login
	}
	
	def checkUniqueLogin(String loginid) {
		def ind = Individual.findByLoginid(loginid)
		if(ind)
			return false
		else
			return true
	}
	
	def eventRegistrationComms() {
	}
	
	def idList(String entityName) {
		
	}
	
	def mergeRecords(String idList) {
		def ids = idList.tokenize(',')
		ids = ids?.unique() //remove duplicate ids if supplied by mistake
		def childList = []
		def ind,master
		ids.each
			{
			ind = Individual.get(it)
			if(ind?.category=='NVCC')	//todo: hardcoding
				master = ind
			else
				childList.add(ind)
			}
		if(!master)
			{
			def masterPos=-1
			 childList.eachWithIndex{it,idx->
				if(it?.category=='RGMYatra')	//todo: hardcoding
					{
					master = it
					masterPos=idx
					}
			 	}
			 //if master is still not found then make the first record as the master
			 if(!master && childList.size()>0)
			 	{
			 	master = childList[0]
			 	masterPos = 0
			 	}
			 if(master)
			 	{
			 	log.debug("size before removing: "+childList.size())
			 	childList.remove(masterPos)
			 	log.debug("size after removing: "+childList.size())
			 	}
			}
		log.debug("Found master record: "+master+" and child record count is: "+childList?.size())
		//now merge children into master, one by one
		def message = "SUCCESS"
		if(!master)
			return "Error!!None of the supplied records from NVCC or RGMYatra database, cannot merge!!"
		childList.each{child->
			message+=merge(master,child)
			child.status='MERGED'
			child.nvccId=master.id
			if(!child.save())
				    child.errors.allErrors.each {
					log.debug("In mergeRecords: error in updating child record:"+ it)
					}
				
		}
		//remove duplicate counsellor roles
		def clorRole = Role.findByName('Councellor')
		def irList = IndividualRole.findAllWhere(individual:master,role:clorRole,status:'VALID',[sort: "id"])
		//now preserve the first one and delete the others
		log.debug("Found IR instances: "+irList.size())
		irList.eachWithIndex{it,idx->
			if(idx>0) {
				it.status='DELETED'
				if(!it.save())
				    it.errors.allErrors.each {
					log.debug("In removing duplicate irs: error in updating record:"+ it)
					}				
				}
			}
		//remove duplicate counselle relations
		def cleeRelation = Relation.findByName('Councellee of')
		def rshipList = Relationship.findAllWhere(individual1:master,relation:cleeRelation,status:'ACTIVE',[sort: "id",order:"desc"])
		//now preserve the most recent one and delete the others
		log.debug("Found rship instances: "+rshipList.size())
		rshipList.eachWithIndex{it,idx->
			if(idx>0) {
				it.status='DELETED'
				if(!it.save())
				    it.errors.allErrors.each {
					log.debug("In removing duplicate rshipList: error in updating record:"+ it)
					}				
				}
			}
		return message
	}
	
	def merge(Individual master, Individual child) {
		def verror = false
		def message = ""

		//merge primitive attrs
		if(!master.initiatedName && child?.initiatedName)
			master.initiatedName = child.initiatedName
		master.profession	 = createUniqueString(master.profession , child.profession)
		master.designation	 = createUniqueString(master.designation , child.designation)
		master.motherTongue	 = createUniqueString(master.motherTongue , child.motherTongue)
		master.membershipNo	 = createUniqueString(master.membershipNo , child.membershipNo)
		master.membershipPlace	 = createUniqueString(master.membershipPlace , child.membershipPlace)
		master.businessRemarks	 = createUniqueString(master.businessRemarks , child.businessRemarks)
		master.remarks	 = createUniqueString(master.remarks , child.remarks)
		master.panNo	 = createUniqueString(master.panNo , child.panNo)
		master.firstInitiationPlace	 = createUniqueString(master.firstInitiationPlace , child.firstInitiationPlace)
		master.secondInitiationPlace	 = createUniqueString(master.secondInitiationPlace , child.secondInitiationPlace)
		


		if(child.category=='RGMYatra')//todo: hardcoding
			{
			log.debug("Picking fields from RGMYatra db")
			master.isMale = child.isMale
			//copy the image
			if(child.avatar)
				{
				master.avatar = child.avatar.clone()
				master.avatarType = child.avatarType
				}
			if(child.dob)
				master.dob = child.dob
			if(child.chantingSinceDate)
				master.chantingSinceDate = child.chantingSinceDate
			if(child.numRounds)
				master.numRounds = child.numRounds
			if(child.sixteenRoundsDate)
				master.sixteenRoundsDate = child.sixteenRoundsDate
			if(child.firstInitiation)
				master.firstInitiation = child.firstInitiation
			if(child.secondInitiation)
				master.secondInitiation = child.secondInitiation
			if(child.ashram)
				master.ashram = child.ashram
			if(child.bloodGroup)
				master.bloodGroup = child.bloodGroup
			if(child.marriageAnniversary)
				master.marriageAnniversary = child.marriageAnniversary
			if(child.eduCat)
				master.eduCat = child.eduCat
			if(child.eduQual)
				master.eduQual = child.eduQual
			if(child.profession)
				master.profession = child.profession
			if(child.designation)
				master.designation = child.designation
			if(child.merits)
				master.merits = child.merits
			if(child.skills)
				master.skills = child.skills
			if(child.companyName)
				master.companyName = child.companyName
			}

		if (master.marriageAnniversary!=null && child.marriageAnniversary!=null)
			if (master.marriageAnniversary==child.marriageAnniversary)
				master.marriageAnniversary	=master.marriageAnniversary
			else
				{
				verror=true
				message += "marriageAnniversary different!"
				}
		else
			master.marriageAnniversary = (master.marriageAnniversary==null)?child.marriageAnniversary:master.marriageAnniversary

		if (master.firstInitiation!=null && child.firstInitiation!=null)
			if (master.firstInitiation==child.firstInitiation)
				master.firstInitiation	=master.firstInitiation
			else
				{
				verror=true
				message += "firstInitiation different!"
				}
		else
			master.firstInitiation = (master.firstInitiation==null)?child.firstInitiation:master.firstInitiation

		if (master.secondInitiation!=null && child.secondInitiation!=null)
			if (master.secondInitiation==child.secondInitiation)
				master.secondInitiation	=master.secondInitiation
			else
				{
				verror=true
				message += "secondInitiation different!"
				}
		else
			master.secondInitiation = (master.secondInitiation==null)?child.secondInitiation:master.secondInitiation


		if (master.title!=null && child.title!=null)
			if (master.title.id==child.title.id)
				master.title	=master.title
			else
				{
				verror=true
				message += "title different!"
				}
		else
			master.title = (master.title==null)?child.title:master.title
			master.title = child.title


		//primary attributes have been set, now try to save this
		def saveFlag
		if(verror)
				log.debug("Conflicts while merging.."+message)
		//master.updator=springSecurityService.principal.username
		saveFlag = master.save()
		if(!saveFlag)
			    master.errors.allErrors.each {
				log.debug("In mergeRecords: error in updating master record:"+ it)
				}

		if(saveFlag)
		{
		   def sql = new Sql(dataSource);
		   def query,records,idlist,ids

		   def cid = child.id
		   
		   //check if child is already a scheme member
		   def sm = SchemeMember.findAllByMember(child)
		   if(sm?.size()>0)
		   	{
		   	//update all to point to master now
		   	sm.each{
		   		it.member = master
		   		if(!it.save())
					it.errors.allErrors.each {
                      				println it
                      				}		   			
		   		}
		   	}

		   if (child.address!=null)
			{
			//sql.executeUpdate("update address set individual_id = ? where individual_id=?", [master.id, cid])
			records = sql.rows("select id from address vc where vc.individual_id=? and not exists (select 1 from address vm where vm.individual_id=? and vm.address_line1=vc.address_line1)",[cid,master.id])
			idlist=""
			records.each{idlist+=(it.id+",")}
			if(idlist.size()>1)
				{
				//trim the trailing ,
				idlist = idlist.substring(0,(idlist.size()-1))
				sql.executeUpdate("update address set individual_id=? where id in("+idlist+")", [master.id])
				}
			}
		   if (child.emailContact!=null)
			{			
			//sql.executeUpdate("update email_contact set individual_id = ? where individual_id=?", [master.id, cid])
			records = sql.rows("select id from email_contact vc where vc.individual_id=? and not exists (select 1 from email_contact vm where vm.individual_id=? and vm.email_address=vc.email_address)",[cid,master.id])
			idlist=""
			records.each{idlist+=(it.id+",")}
			if(idlist.size()>1)
				{
				//trim the trailing ,
				idlist = idlist.substring(0,(idlist.size()-1))
				sql.executeUpdate("update email_contact set individual_id=? where id in("+idlist+")", [master.id])
				}
			}
		   if (child.voiceContact!=null)
			{			
			//sql.executeUpdate("update voice_contact set individual_id = ? where individual_id=?", [master.id, cid])
			records = sql.rows("select id from voice_contact vc where vc.individual_id=? and not exists (select 1 from voice_contact vm where vm.individual_id=? and vm.number=vc.number)",[cid,master.id])
			idlist=""
			records.each{idlist+=(it.id+",")}
			if(idlist.size()>1)
				{
				//trim the trailing ,
				idlist = idlist.substring(0,(idlist.size()-1))
				sql.executeUpdate("update voice_contact set individual_id=? where id in("+idlist+")", [master.id])
				}
			}
		   if (child.otheContact!=null)
			{
			
			sql.executeUpdate("update other_contact set individual_id = ? where individual_id=?", [master.id, cid])
			}
		   if (child.events!=null)
			{
			
			sql.executeUpdate("update event_participant set individual_id = ? where individual_id=?", [master.id, cid])
			}
		   if (child.individualRoles!=null)
			{			
			//sql.executeUpdate("update individual_role set individual_id = ? where individual_id=?", [master.id, cid])
			records = sql.rows("select id from individual_role vc where vc.individual_id=? and not exists (select 1 from individual_role vm where vm.individual_id=? and vm.role_id=vc.role_id)",[cid,master.id])
			idlist=""
			records.each{idlist+=(it.id+",")}
			if(idlist.size()>1)
				{
				//trim the trailing ,
				idlist = idlist.substring(0,(idlist.size()-1))
				sql.executeUpdate("update individual_role set individual_id=? where id in("+idlist+")", [master.id])
				}
			}
		   if (child.donations!=null)
			{			
			sql.executeUpdate("update donation set donated_by_id = ? where donated_by_id=?", [master.id, cid])
			}
		   if (child.fundCollections!=null)
			{			
			sql.executeUpdate("update donation set collected_by_id = ? where collected_by_id=?", [master.id, cid])
			}
		   if (child.fundsReceived!=null)
			{			
			sql.executeUpdate("update donation set received_by_id = ? where received_by_id=?", [master.id, cid])
			}
		   if (child.followupsWith!=null)
			{			
			sql.executeUpdate("update followup set followup_with_id = ? where followup_with_id=?", [master.id, cid])
			}
		   if (child.followupsBy!=null)
			{			
			sql.executeUpdate("update followup set followup_by_id = ? where followup_by_id	=?", [master.id, cid])
			}
		   if (child.giftIssuedBy!=null)
			{			
			sql.executeUpdate("update gift_issued set issued_by_id = ? where issued_by_id=?", [master.id, cid])
			}
		   if (child.giftIssuedTo!=null)
			{			
			sql.executeUpdate("update gift_issued set issued_to_id = ? where issued_to_id=?", [master.id, cid])
			}
		   if (child.relative1!=null)
			{			
			//sql.executeUpdate("update relationship set individual1_id = ? where individual1_id=?", [master.id, cid])
			records = sql.rows("select id from relationship vc where vc.individual1_id=? and status='ACTIVE' and not exists (select 1 from relationship vm where vm.individual1_id=? and vm.individual2_id=vc.individual2_id)",[cid,master.id])
			idlist=""
			records.each{idlist+=(it.id+",")}
			if(idlist.size()>1)
				{
				//trim the trailing ,
				idlist = idlist.substring(0,(idlist.size()-1))
				sql.executeUpdate("update relationship set individual1_id=? where id in("+idlist+")", [master.id])
				}

			}
		   if (child.relative2!=null)
			{			
			//sql.executeUpdate("update relationship set individual2_id = ? where individual2_id=?", [master.id, cid])
			records = sql.rows("select id from relationship vc where vc.individual2_id=? and status='ACTIVE' and not exists (select 1 from relationship vm where vm.individual2_id=? and vm.individual1_id=vc.individual1_id)",[cid,master.id])
			idlist=""
			records.each{idlist+=(it.id+",")}
			if(idlist.size()>1)
				{
				//trim the trailing ,
				idlist = idlist.substring(0,(idlist.size()-1))
				sql.executeUpdate("update relationship set individual2_id=? where id in("+idlist+")", [master.id])
				}
			}
		   if (child.objectives!=null)
			{			
			sql.executeUpdate("update objective set individual_id = ? where individual_id=?", [master.id, cid])
			}
		   //now take care od schemeMembership
		   def smList = SchemeMember.findAllByMember(child)
		   if(smList?.size()>0)
		   	{
		   	//replace child with master
		   	smList.each{
		   		log.debug("Swapping schemeMember"+it)
		   		it.member=master
		   		if(!it.save())
					it.errors.allErrors.each {
						log.debug("In mergeRecords: error in updating master record for schemeMember:"+ it)
					}		   			
		   		}
		   	}
		}
		return message
	}
	
	def isSuperior(String indid) {
		def ind1 = Individual.get(indid)
		def ind2 = Individual.get(session.individualid)
		def result
		if(ind1 && ind2)
			{
			if(ind1.id==ind2.id)
				return true
			result = Relationship.findAllWhere(individual1:ind1,individual2:ind2,status:'ACTIVE')
			if(result.size()>1)
				log.debug("Multiple mappings between ind1:"+indid+" ind2:"+session.individual2)
			if(result.size()>0)
				return true
			else
				return false
			}
		return false
	}
	


	def isDonationCoordinator(String indid) {
		def ind1 = Individual.get(indid)
		def result
		def ir

		//first get the relevant role        	
		def donationRole = Role.findByAuthority('ROLE_DONATION_COORDINATOR')
		if(donationRole)
			ir = IndividualRole.findWhere('individual.id':session.individualid,role:donationRole,status:'VALID')
		if(ir)
			{
			result = SchemeMember.findAllWhere(centre:ir.centre,member:ind1)
			if(result?.size()>0)
				return true
			}

		return false
	}
	
	def isCultivator(String indid) {
		def ind1 = Individual.get(indid)
		def ind2 = Individual.get(session.individualid)
		def rln = Relation.findByName('Cultivated by')
		def result
		result = Relationship.findWhere(individual1:ind1,individual2:ind2,relation:rln,status:'ACTIVE')
			if(result)
				return true
			else
				return false
	}

	def isCultivatorGroup(String indid) {
		def pcgroup = getPCGroup()
		log.debug("Inside isCultivatorGroup with pcgroup":pcgroup)
		def ind1 = Individual.get(indid)
		def ind2 = Individual.get(session.individualid)
		def rln = Relation.findByName('Cultivated by')
		def result
		result = Relationship.createCriteria().list{
			eq('status','ACTIVE')
			eq('relation',rln)
			eq('individual1',ind1)
			individual2{
			'in'('id',pcgroup)
			}
		
		}
		if(result?.size()>0)
			return true
		else
			return false
	}

	def onlyDonationSummary(Long indId)
	{
	   //log.debug("Inside onlyDonationSummary for id: "+indId)
	   def sql = new Sql(dataSource);
	   def queryInd = "select sum(amount) amt from donation where donated_by_id="+indId
	   //def queryFam = "select sum(amount) amt from donation where donated_by_id in (select "+indId+" from dual union select distinct individual1_id from relationship r , relationship_group rg where r.status='ACTIVE' and r.relationship_group_id=rg.id and rg.refid="+indId+" union select distinct individual1_id from relationship where status='ACTIVE' and relationship_group_id in (select distinct rg.id from relationship r , relationship_group rg where r.status='ACTIVE' and r.relationship_group_id=rg.id and rg.group_name like 'Family%' and r.individual1_id="+indId+") union select distinct rg.refid from relationship r , relationship_group rg where r.status='ACTIVE' and r.relationship_group_id=rg.id and rg.group_name like 'Family%' and r.individual1_id="+indId+")"
	   def queryFam = "select sum(amount) amt from donation d  where exists (select 1 from (select "+indId+" as individual_id from dual union select distinct individual1_id as individual_id from relationship r , relationship_group rg where r.status='ACTIVE' and r.relationship_group_id=rg.id and rg.refid="+indId+" union select distinct individual1_id as individual_id from relationship where status='ACTIVE' and relationship_group_id in (select distinct rg.id from relationship r , relationship_group rg where r.status='ACTIVE' and r.relationship_group_id=rg.id and rg.group_name like 'Family%' and r.individual1_id="+indId+") union select distinct rg.refid from relationship r , relationship_group rg where r.status='ACTIVE' and r.relationship_group_id=rg.id and rg.group_name like 'Family%' and r.individual1_id="+indId+") t where t.individual_id=d.donated_by_id)"
	   
 	   def amtInd = sql.firstRow(queryInd).amt
 	   def amtFam = sql.firstRow(queryFam).amt

	   sql.close()

 	   return [amtInd: amtInd, amtFam: amtFam]
	}
	
	def findOrCreateIndividual(String name, String pan, String phone, String email, String address)
	{
		def individual = null
		//first try to find else create
		individual = findIndividual( name,  pan,  phone,  email,  address)
		if(individual)
			{
			return individual
			}
		//need to create a new one
		individual = new Individual()
		individual.legalName = name
		if(pan)
			{individual.panNo = pan}
		individual.status = "AUTOCREATED"
		individual.updator = individual.creator = springSecurityService.principal.username
		if(!individual.save(flush:true))
			{individual.errors.allErrors.each {log.debug(it)}}
		else
			{
			//create the icsid for the newly created individual
			individual.icsid = 100000+individual.id
			individual.save()
			
			//create various contacts
			//voice contact
			def voiceContact = new VoiceContact()
			voiceContact.number = phone
			voiceContact.category = "CellPhone"
			voiceContact.individual = individual
			voiceContact.updator = voiceContact.creator = springSecurityService.principal.username
			if(!voiceContact.save(flush:true))
				{voiceContact.errors.allErrors.each {log.debug(it)}}
			//email contact
			def emailContact = new EmailContact()
			emailContact.emailAddress = email
			emailContact.category = "Personal"
			emailContact.individual = individual
			emailContact.updator = emailContact.creator = springSecurityService.principal.username
			if(!emailContact.save(flush:true))
				{emailContact.errors.allErrors.each {log.debug(it)}}
			//address
			def addr = new Address()
			addr.addressLine1 = address
			addr.category = "Correspondence"
			addr.individual = individual
			//@TODO: some address realted hardcoding, use default city/state/country from config file
			addr.city = City.findByName('Pune')?:City.findByName('Other')
			addr.state = State.findByName('Maharashtra')?:City.findByName('Other')
			addr.country = Country.findByName('India')?:City.findByName('Other')
			addr.updator = addr.creator = springSecurityService.principal.username
			if(!addr.save(flush:true))
				{addr.errors.allErrors.each {log.debug(it)}}
			
			//all done
			log.debug("Created new individual: "+individual)
			return individual				
			}
		//some error occurred
		return null		
	}

	def findIndividual(String name, String pan, String phone, String email, String address)
	{
		def matchingIndividuals
		if(name)
			{
			matchingIndividuals = Individual.findAllByLegalNameOrInitiatedName(name,name)
			if(matchingIndividuals?.size()==1 )
				{
				log.debug("found on name"+name)
				return matchingIndividuals[0]
				}
			}
		else
			{
				return null	//cant do anything is name is not specified
			}
		if(pan)
			{
			matchingIndividuals = Individual.findAllByPanNo(pan)
			if(matchingIndividuals?.size()>0)
				log.debug("found on pan"+matchingIndividuals)
			if(matchingIndividuals?.size()==1 && (matchingIndividuals[0].legalName==name || matchingIndividuals[0].initiatedName==name))
				{
				
				return matchingIndividuals[0]
				}
			}
		if(phone)
			{
			matchingIndividuals = VoiceContact.findAllByNumber(phone)
			if(matchingIndividuals?.size()>0)
				log.debug("found on phone"+matchingIndividuals)
			if(matchingIndividuals?.size()==1 && (matchingIndividuals[0].individual?.legalName==name || matchingIndividuals[0].individual?.initiatedName==name))
				{
				return matchingIndividuals[0]
				}			
			}
		if(email)
			{
			matchingIndividuals = EmailContact.findAllByEmailAddress(email)
			if(matchingIndividuals?.size()>0)
				log.debug("found on email"+matchingIndividuals)
			if(matchingIndividuals?.size()==1 && (matchingIndividuals[0].individual?.legalName==name || matchingIndividuals[0].individual?.initiatedName==name))
				{
				return matchingIndividuals[0]
				}			
			}
		return null
	}
	
	def getFY() {
		//@TODO: hardcoded for 1-Apr 31-Mar FY
		def now = new Date()
		//get day and month
		def day = now.format('dd')
		def month = new Integer(now.format('MM'))
		def year = new Integer(now.format('yy'))
		
		def fy = "FY"
		
		if(month<=3)
			fy+=(year-1)+""+year
		else
			fy+=year+""+(year+1)
			
		return fy	
	}
	
	def getFamily(Long indId) {
		//first check if head of family
		def headRG = RelationshipGroup.findByRefid(indId)
		if(headRG)
			return headRG?.id
		def reln = Relationship.createCriteria().list() {
				eq('status','ACTIVE')
				relation{eq('category','Family')}
				individual1{eq('id',indId)}
			}
		if(!reln)
			return 0
		def rg = reln.collect{it.relationshipGroup}?.unique()
		
		if(rg.size()==1)
			return rg?.id
		//more than 1 family found
		//check if 'Wife' relation exits
		def wifereln = Relationship.createCriteria().list() {
				eq('status','ACTIVE')
				relation{eq('name','Wife')}
				individual1{eq('id',indId)}
			}
		if(wifereln)
			return wifereln?.relationshipGroup?.id
		else
			return -1	//@TODO: need to figure out..discuss with DCP
		
		

	}

	def changeRelation(Map params) {
		String idList = params.idList
		def ids = idList.tokenize(',')
		ids = ids?.unique() //remove duplicate ids if supplied by mistake
		def ind,cleeReln,wwReln,motd
		def clor = Individual.get(session.individualid)
		def crel = Relation.findByName("Councellee of")
		def wrel = Relation.findByName("Cultivated by")
		def rg = RelationshipGroup.findByGroupName("dummy")
		def cnt = 0
		ids.each
			{
			ind = Individual.get(it)
			switch(params.type)
			{
				case 'Counsellee':
					wwReln = Relationship.findWhere(individual1:ind,individual2:clor,relation:wrel,status:'ACTIVE')
					if(wwReln)
						{
						//first delete existing ww reln
						wwReln.status = "DELETED"
						wwReln.updator = springSecurityService.principal.username
						if(!wwReln.save())
						    wwReln.errors.allErrors.each {
							println it
							}
						else
						{
						//then create cleeReln
						//check if not already being counselled by someone else
						cleeReln = Relationship.findWhere(individual1:ind,relation:crel,status:'ACTIVE')
						if(cleeReln && cleeReln?.individual2!=clor)
							{
								motd = new Motd()
								motd.quote = "Counsellor conflict for ind1: "+ind +" Existing counsellor: "+cleeReln.individual2
								motd.reference = "MarkAsCounsellee"
								motd.updator = motd.creator = springSecurityService.principal.username
								motd.save()					
							}
						else	//new well wisher
							{
							cleeReln = new Relationship()
							cleeReln.individual1 = ind
							cleeReln.individual2 = clor
							cleeReln.relation = crel
							cleeReln.relationshipGroup = rg
							cleeReln.status = 'ACTIVE'
							cleeReln.updator = cleeReln.creator = springSecurityService.principal.username
							if(!cleeReln.save())
							    cleeReln.errors.allErrors.each {
								println it
								}
							else
								cnt++
							}
						}
						}
						break
				case 'Wellwisher':
					cleeReln = Relationship.findWhere(individual1:ind,individual2:clor,relation:crel,status:'ACTIVE')
					if(cleeReln)
						{
						//first delete existing clee reln
						cleeReln.status = "DELETED"
						cleeReln.updator = springSecurityService.principal.username
						if(!cleeReln.save())
						    cleeReln.errors.allErrors.each {
							println it
							}
						else
						{
						//then create well wisher reln
						//check if not already being cultivated by someone else
						wwReln = Relationship.findWhere(individual1:ind,relation:wrel,status:'ACTIVE')
						if(wwReln && wwReln?.individual2!=clor)
							{
								motd = new Motd()
								motd.quote = "Cultivator conflict for ind1: "+ind +" Existing cultivator: "+wwReln.individual2
								motd.reference = "MarkAsWellwisher"
								motd.updator = motd.creator = springSecurityService.principal.username
								motd.save()					
							}
						else	//new well wisher
							{
							wwReln = new Relationship()
							wwReln.individual1 = ind
							wwReln.individual2 = clor
							wwReln.relation = wrel
							wwReln.relationshipGroup = rg
							wwReln.status = 'ACTIVE'
							wwReln.updator = wwReln.creator = springSecurityService.principal.username
							if(!wwReln.save())
							    wwReln.errors.allErrors.each {
								println it
								}
							else
								cnt++
							}
						}
						}
						break
				default:
					break
			}
			}
		return "Converted to " +params.type+" "+ cnt +" out of "+ids.size()
	}
	
	def isIndividualUnderKitchen(Individual individualInstance) {
		if (individualInstance.category=="VENDOR")
			return true
		//check whether belongs to Kitchen department
		def indDep = IndividualDepartment.createCriteria().list{
				department{ilike('name','%KITCHEN%')}
				eq('individual',individualInstance)
				eq('status','ACTIVE')
				}
		if(indDep.size()>0)
			return true
		return false
	}
	


}

