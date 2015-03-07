package ics
import java.text.DateFormatSymbols
import static java.util.Calendar.*
import groovy.sql.Sql;

class ReportService {

    def dataSource

    def serviceMethod() {
    }
    
    def commitmentSummary(Map params) {
    	log.debug("Inside commitmentSummary with params: "+params)
    	
    	//get the 12 month date range
    	def dateRanges = getDateRanges(params)

    	def summaryRows = [], indDonation = [], indCollection = [], indDonationRec = [], clorList = [], cleeList = []
    	def clorSummaryList = [], cleeSummaryList = []

    	//get the clor list first
    	if(params.clorid)
    		clorList.add(Individual.get(params.clorid))
    	else
    		clorList = getClorList()

	clorList.each{clor->
		//first get clor data
		summaryRows = []
		def indCommits = committedSchemes(clor)
		indCommits.each{
			indDonation = new BigDecimal[12]
			indDonationRec = new BigDecimal[12]
			indCollection = new BigDecimal[12]
			for(i in 0..11) {
				indDonation[i] = individualDonationSummary(it.scheme,dateRanges[i],dateRanges[i+1],clor)
				indDonationRec[i] = individualDonationRecSummary(it.scheme,dateRanges[i],dateRanges[i+1],clor)
				indCollection[i] = individualCollectionSummary(it.scheme,dateRanges[i],dateRanges[i+1],clor)
				}
			summaryRows.add([scheme:it.scheme?.name,commitment:it.committedAmount,indDonation:indDonation, indDonationRec:indDonationRec, indCollection:indCollection])
			}
		//finally check for any other donations besides the commitment
		def committedSchemesList = indCommits.collect{it.scheme}
		indDonation = new BigDecimal[12]
		indDonationRec = new BigDecimal[12]
		indCollection = new BigDecimal[12]
		for(i in 0..11) {
			indDonation[i] = individualDonationSummary(committedSchemesList,dateRanges[i],dateRanges[i+1],clor)
			indDonationRec[i] = individualDonationRecSummary(committedSchemesList,dateRanges[i],dateRanges[i+1],clor)
			indCollection[i] = individualCollectionSummary(committedSchemesList,dateRanges[i],dateRanges[i+1],clor)
			}
		summaryRows.add([scheme:'Others',commitment:0,indDonation:indDonation,indDonationRec:indDonationRec,indCollection:indCollection])

		cleeSummaryList.add([cleeid:clor.id,clee:clor.toString(),summaryRows:summaryRows])
		
		//now get councelee list
		cleeList = getCleeList(clor)
		
		//get the donation summary for each
		cleeList.each{clee->
			summaryRows = []
			indCommits = committedSchemes(clee)
			indCommits.each{
				indDonation = new BigDecimal[12]
				indDonationRec = new BigDecimal[12]
				indCollection = new BigDecimal[12]
				for(i in 0..11) {
					indDonation[i] = individualDonationSummary(it.scheme,dateRanges[i],dateRanges[i+1],clee)
					indDonationRec[i] = individualDonationRecSummary(it.scheme,dateRanges[i],dateRanges[i+1],clee)
					indCollection[i] = individualCollectionSummary(it.scheme,dateRanges[i],dateRanges[i+1],clee)
					}
				summaryRows.add([scheme:it.scheme?.name,commitment:it.committedAmount,indDonation:indDonation,indDonationRec:indDonationRec,indCollection:indCollection])
				}
			//finally check for any other donations besides the commitment
			committedSchemesList = indCommits.collect{it.scheme}
			indDonation = new BigDecimal[12]
			indDonationRec = new BigDecimal[12]
			indCollection = new BigDecimal[12]
			for(i in 0..11) {
				indDonation[i] = individualDonationSummary(committedSchemesList,dateRanges[i],dateRanges[i+1],clee)
				indDonationRec[i] = individualDonationRecSummary(committedSchemesList,dateRanges[i],dateRanges[i+1],clee)
				indCollection[i] = individualCollectionSummary(committedSchemesList,dateRanges[i],dateRanges[i+1],clee)
				}
			summaryRows.add([scheme:'Others',commitment:0,indDonation:indDonation,indDonationRec:indDonationRec,indCollection:indCollection])
			
			cleeSummaryList.add([cleeid:clee.id,clee:clee.toString(),summaryRows:summaryRows])
		}
		clorSummaryList.add([clorid:clor.id,clor:clor.toString(),cleeSummaryList:cleeSummaryList])
    	}
    	return [dateRanges:dateRanges, clorSummaryList: clorSummaryList]  	
    }
    
    def individualDonationSummary(Scheme scheme, Date from, Date till, Individual ind) {
	def result = Donation.createCriteria().list() {
				eq("scheme", scheme)
				if(from)
					ge("fundReceiptDate",from)
				if(till)
					lt("fundReceiptDate",till)
				eq("donatedBy", ind)
				or{
					ne("status",'BOUNCED')
					isNull("status")
				}
			    projections {
				sum "amount"
			    	}
			}
	//println("individualDonationSummary : "+from.toString()+" : "+till.toString()+" : "+result[0])		
	return result[0]    	
    }
    
    def individualDonationSummary(List schemeList, Date from, Date till, Individual ind) {
    	def schemeIds = schemeList.collect{it.id}
    	//log.debug("Scheme ids:"+schemeIds)
	def result = Donation.createCriteria().list() {
				if(schemeIds)
					scheme{not { 'in'("id",schemeIds) }}
				if(from)
					ge("fundReceiptDate",from)
				if(till)
					lt("fundReceiptDate",till)
				eq("donatedBy", ind)
				or{
					ne("status",'BOUNCED')
					isNull("status")
				}
			    projections {
				sum "amount"
			    	}
			}
	//println("individualDonationSummary List : "+from.toString()+" : "+till.toString()+" : "+result[0])		
	return result[0]    	
    }
    
    def individualCollectionSummary(Scheme scheme, Date from, Date till, Individual ind) {
	def result = Donation.createCriteria().list() {
				eq("scheme", scheme)
				if(from)
					ge("fundReceiptDate",from)
				if(till)
					lt("fundReceiptDate",till)
				eq("collectedBy", ind)
				ne("donatedBy", ind)
				or{
					ne("status",'BOUNCED')
					isNull("status")
				}
			    projections {
				sum "amount"
			    	}
			}
	//println("individualCollectionSummary : "+from.toString()+" : "+till.toString()+" : "+result[0])		
	return result[0]    	
    }
    
    def individualCollectionSummary(List schemeList, Date from, Date till, Individual ind) {
    	def schemeIds = schemeList.collect{it.id}
    	//log.debug("Scheme ids:"+schemeIds)
	def result = Donation.createCriteria().list() {
				if(schemeIds)
					scheme{not { 'in'("id",schemeIds) }}
				if(from)
					ge("fundReceiptDate",from)
				if(till)
					lt("fundReceiptDate",till)
				eq("collectedBy", ind)
				ne("donatedBy", ind)
				or{
					ne("status",'BOUNCED')
					isNull("status")
				}
			    projections {
				sum "amount"
			    	}
			}
	//println("individualCollectionSummary List : "+from.toString()+" : "+till.toString()+" : "+result[0])		
	return result[0]    	
    }
    
    def individualDonationRecSummary(Scheme scheme, Date from, Date till, Individual ind) {
	def result = DonationRecord.createCriteria().list() {
				eq("scheme", scheme)
				if(from)
					ge("donationDate",from)
				if(till)
					lt("donationDate",till)
				eq("donatedBy", ind)
				isNull("receiptReceivedStatus")
			    	projections {
					sum "amount"
			    		}
			}
	//println("individualDonationRecSummary : "+from.toString()+" : "+till.toString()+" : "+result[0])		
	return result[0]    	
    }
    
    def individualDonationRecSummary(List schemeList, Date from, Date till, Individual ind) {
    	def schemeIds = schemeList.collect{it.id}
    	//log.debug("Scheme ids:"+schemeIds)
	def result = DonationRecord.createCriteria().list() {
				if(schemeIds)
					scheme{not { 'in'("id",schemeIds) }}
				if(from)
					ge("donationDate",from)
				if(till)
					lt("donationDate",till)
				eq("donatedBy", ind)
				isNull("receiptReceivedStatus")
			    	projections {
					sum "amount"
			    		}
			}
	//println("individualDonationRecSummary List : "+from.toString()+" : "+till.toString()+" : "+result[0])		
	return result[0]    	
    }
    
    def donationSummary(List dateRanges, List indList) {
    	individualDonationSummary(dateRanges[0],dateRanges[1],Individual.get(54703))
    }
    
    def committedSchemes(Individual ind) {
	def result = Commitment.createCriteria().list() {
				eq("committedBy", ind)
				eq("status",'ACTIVE')
				scheme{order("name")}
			}
	//println("committedSchemes: "+result)		
	return result   
    }
    
    def getDateRanges(Map params) {
    	def startMonth = params.fromDate[Calendar.MONTH]
    	def startYear = params.fromDate[Calendar.YEAR]
    	def endYear = startYear    	
    	
    	def cal = new GregorianCalendar(startYear, startMonth, 1)
    	
    	def dateRanges = new Date[13]
    	int j
    	for(i in 0..12) {
    		j = startMonth+i
    		if (j>11)
    			{
    			j = j-12
    			if(j==0)
    				endYear++
    			}
    		cal.set(endYear,j,1)
    		dateRanges[i] = cal.time
    		}
    	return dateRanges
    }
    
    def getPeriods(Map params) {
    	def periods = []
    	def periodList = Period.list([sort:'id'])
    	periodList.each{it->
		periods.add(it.fromDate)
		periods.add(it.toDate)    	
    	}
    	//log.debug("Got periods : "+periods)
    	return periods
    }

    def getCleeList(Individual clor) {
	def result = Relationship.createCriteria().list() {
				relation{eq("name","Councellee of")}
				eq("individual2",clor)
				eq("status",'ACTIVE')
				individual1{order("legalName")}
			}
	//println("cleeList: "+result)		
	return result?.collect{it.individual1}        
    }

    def getClorList() {
	def result = IndividualRole.createCriteria().list() {
				role{eq("name","Councellor")}
				eq("status",'VALID')
				individual{order("legalName")}
			}
	//println("clorList: "+result)		
	return result?.collect{it.individual}       
    }
    
    def getDonationByScheme(List schemeIdList,Long donorId){
	def result = Donation.createCriteria().list() {
				scheme{'in'("id",schemeIdList)}
				donatedBy{eq("id",donorId)}
			    projections {
				sum "amount"
			    	}				
			}
	return result[0]           
    }
    
    def getDonation(Long donorId){
	def result = Donation.createCriteria().list() {
				donatedBy{eq("id",donorId)}
			    projections {
				sum "amount"
			    	}				
			}
	return result[0]           
    }

    def getFamilyDonation(Long donorId){
	return 0           
    }
    
    // all transactions in cc
    def ccStatement(CostCenter cc, Date fd, Date td) {
	def sql = new Sql(dataSource)
	//def query = "select * from (SELECT date_format(d.fund_receipt_date,'%d-%m-%y') date,concat(ifnull(d.collection_type,''),' by ',IFNULL(i.initiated_name,i.legal_name)) details, d.amount income, 0 expense, 0 balance FROM donation d, scheme s, individual i where d.donated_by_id=i.id and d.scheme_id=s.id and s.cc_id="+cc.id+" and d.fund_receipt_date >= '"+String.format('%tF',fd)+"'  and d.fund_receipt_date <= '"+String.format('%tF',td)+"' union SELECT date_format(v.voucher_date,'%d-%m-%y') date,v.description details, v.amount_settled income, v.amount expense, 0 balance FROM voucher v, cost_center c where v.department_code_id=c.id and c.id="+cc.id+" and v.voucher_date >= '"+String.format('%tF',fd)+"' and v.voucher_date <= '"+String.format('%tF',td)+"') q  order by date"
	def query = "select * from (SELECT d.fund_receipt_date date,concat(d.nvcc_receipt_book_no,'/',d.nvcc_receipt_no) ref, concat(ifnull(d.collection_type,''),' by ',IFNULL(i.initiated_name,i.legal_name)) details, d.amount income, 0 expense, 0 balance, d.updator entryby FROM donation d, scheme s, individual i where d.donated_by_id=i.id and d.scheme_id=s.id and s.cc_id="+cc.id+" and d.fund_receipt_date >= '"+String.format('%tF',fd)+"'  and d.fund_receipt_date <= '"+String.format('%tF',td)+"' union SELECT v.voucher_date date,v.voucher_no ref, v.description details, v.amount_settled income, v.amount expense, 0 balance, v.updator entryby FROM voucher v, cost_center c where v.department_code_id=c.id and c.id="+cc.id+" and v.voucher_date >= '"+String.format('%tF',fd)+"' and v.voucher_date <= '"+String.format('%tF',td)+"') q  order by date"
	//log.debug(query)
	def result = sql.rows(query)
	sql.close() 
	return result
    }

    // all transactions in costCategory
    def costCategoryStatement(CostCategory ccat, Date fd, Date td) {
	def sql = new Sql(dataSource)
	def query = "select * from (SELECT d.fund_receipt_date date,concat(d.nvcc_receipt_book_no,'/',d.nvcc_receipt_no) ref, concat(ifnull(d.collection_type,''),' by ',IFNULL(i.initiated_name,i.legal_name)) details, d.amount income, 0 expense, 0 balance, d.updator entryby FROM donation d, scheme s, individual i, cost_center cc, cost_category ccat where d.donated_by_id=i.id and d.scheme_id=s.id and s.cc_id=cc.id and cc.cost_category_id="+ccat.id+" and d.fund_receipt_date >= '"+String.format('%tF',fd)+"'  and d.fund_receipt_date <= '"+String.format('%tF',td)+"' union SELECT v.voucher_date date,v.voucher_no ref, v.description details, v.amount_settled income, v.amount expense, 0 balance, v.updator entryby FROM voucher v, cost_center c, cost_category ccat where v.department_code_id=c.id and c.cost_category_id=ccat.id and ccat.id="+ccat.id+" and v.voucher_date >= '"+String.format('%tF',fd)+"' and v.voucher_date <= '"+String.format('%tF',td)+"') q  order by date"
	log.debug(query)
	def result = sql.rows(query)
	sql.close() 
	return result
    }


    //poor performance, new one refers to the cache table..
    def olddonationSummary(Map params) {
    	log.debug("Inside donationSummary with params: "+params)
    	
    	//get all the periods
    	def numPeriods = Period.count()
    	if(numPeriods<1)
    		return	//erroneous case
    	def periods = getPeriods(params)
    	def nump = periods.size()
    	//log.debug("Num periods: "+numPeriods +" arr size: "+nump)

    	def summaryRows = [], indDonation = [], indDonationRec = [], indCollection = [], clorList = [], cleeList = []
    	def clorSummaryList = [], cleeSummaryList = []

    	//get the clor list first
    	if(params.clorid)
    		clorList.add(Individual.get(params.clorid))
    	else
    		clorList = getClorList()

	clorList.each{clor->
		//first get clor data
		summaryRows = []
		def indCommits = committedSchemes(clor)
		indCommits.each{
			indDonation = new BigDecimal[numPeriods]
			indDonationRec = new BigDecimal[numPeriods]
			indCollection = new BigDecimal[numPeriods]
			for(i in 0..(numPeriods-1)) {
				indDonation[i] = individualDonationSummary(it.scheme,periods[i*2],periods[i*2+1],clor)
				indDonationRec[i] = individualDonationRecSummary(it.scheme,periods[i*2],periods[i*2+1],clor)
				indCollection[i] = individualCollectionSummary(it.scheme,periods[i*2],periods[i*2+1],clor)
				}
			summaryRows.add([scheme:it.scheme?.name,commitment:it.committedAmount,indDonation:indDonation, indDonationRec:indDonationRec,indCollection:indCollection])
			}
		//finally check for any other donations besides the commitment
		def committedSchemesList = indCommits.collect{it.scheme}
		indDonation = new BigDecimal[numPeriods]
		indDonationRec = new BigDecimal[numPeriods]
		indCollection = new BigDecimal[numPeriods]
		for(i in 0..(numPeriods-1)) {
			indDonation[i] = individualDonationSummary(committedSchemesList,periods[i*2],periods[i*2+1],clor)
			indDonationRec[i] = individualDonationRecSummary(committedSchemesList,periods[i*2],periods[i*2+1],clor)
			indCollection[i] = individualCollectionSummary(committedSchemesList,periods[i*2],periods[i*2+1],clor)
			}
		summaryRows.add([scheme:'Others',commitment:0,indDonation:indDonation,indDonationRec:indDonationRec,indCollection:indCollection])

		cleeSummaryList.add([cleeid:clor.id,clee:clor.toString(),summaryRows:summaryRows])
		
		//now get councelee list
		cleeList = getCleeList(clor)
		
		//get the donation summary for each
		cleeList.each{clee->
			//log.debug("Calculating for "+clee)
			summaryRows = []
			indCommits = committedSchemes(clee)
			indCommits.each{
				indDonation = new BigDecimal[numPeriods]
				indDonationRec = new BigDecimal[numPeriods]
				indCollection = new BigDecimal[numPeriods]
				for(i in 0..(numPeriods-1)) {
					indDonation[i] = individualDonationSummary(it.scheme,periods[i*2],periods[i*2+1],clee)
					indDonationRec[i] = individualDonationRecSummary(it.scheme,periods[i*2],periods[i*2+1],clee)
					indCollection[i] = individualCollectionSummary(it.scheme,periods[i*2],periods[i*2+1],clee)
					}
				summaryRows.add([scheme:it.scheme?.name,commitment:it.committedAmount,indDonation:indDonation,indDonationRec:indDonationRec,indCollection:indCollection])
				}
			//finally check for any other donations besides the commitment
			committedSchemesList = indCommits.collect{it.scheme}
			indDonation = new BigDecimal[numPeriods]
			indDonationRec = new BigDecimal[numPeriods]
			indCollection = new BigDecimal[numPeriods]
			for(i in 0..(numPeriods-1)) {
				indDonation[i] = individualDonationSummary(committedSchemesList,periods[i*2],periods[i*2+1],clee)
				indDonationRec[i] = individualDonationRecSummary(committedSchemesList,periods[i*2],periods[i*2+1],clee)
				indCollection[i] = individualCollectionSummary(committedSchemesList,periods[i*2],periods[i*2+1],clee)
				}
			summaryRows.add([scheme:'Others',commitment:0,indDonation:indDonation,indDonationRec:indDonationRec,indCollection:indCollection])
			
			cleeSummaryList.add([cleeid:clee.id,clee:clee.toString(),summaryRows:summaryRows])
		}
		clorSummaryList.add([clorid:clor.id,clor:clor.toString(),cleeSummaryList:cleeSummaryList])
    	}
    	return [periods:periods, clorSummaryList: clorSummaryList]  	
    }
    
    //method to populate the Counsellor-Counsellee donation-collection report for the specified period
    def populatePeriodReport(Map params) {
    	def period
    	
    	try{
    		period = Period.get(params.'period.id')
    	}
    	catch(Exception e){}
    	
    	if(!period)
    		return "Invalid period!!"
    		
    	//got a valid period
    	//1. create suitable table
    	//2. populate table
    	//it is assumed that other cache tables are already populated
    	
    	def sql = new Sql(dataSource)
    	//1. table creation
    	//@TODO: table name should not have spaces, dependent on period name
    	def tableName = 'ccreport_'+period.name
    	sql.execute("DROP TABLE IF EXISTS "+tableName)
    	def tblCreateQuery = "CREATE TABLE  "+tableName+'''
		 (
		  id bigint(20) NOT NULL AUTO_INCREMENT,
		  costcategory varchar(255) DEFAULT NULL,
		  costcenter varchar(255) DEFAULT NULL,
		  scheme varchar(255) DEFAULT NULL,
		  collector varchar(255) DEFAULT NULL,
		  collectorsCounsellor varchar(255) DEFAULT NULL,
		  donor varchar(255) DEFAULT NULL,
		  donorsCounsellor varchar(255) DEFAULT NULL,
		  donorsFamily varchar(255) DEFAULT NULL,
		  amount decimal(19,2) DEFAULT NULL,
		  pc varchar(255) DEFAULT NULL,
		  pchead varchar(255) DEFAULT NULL,
		  counsellor varchar(255) DEFAULT NULL,
		  counsellee varchar(255) DEFAULT NULL,
		  donation decimal(19,2) DEFAULT NULL,
		  collection decimal(19,2) DEFAULT NULL,
		  contribution decimal(19,2) DEFAULT NULL,
		  PRIMARY KEY (id),
		  KEY Index_counsellor (counsellor),
		  KEY Index_counsellee (counsellee)  
		) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8    	
    		'''
    	log.debug(tblCreateQuery)
    	sql.execute tblCreateQuery
    	
    	def fromDate
    	if(period.fromDate)
    		fromDate = period.fromDate?.format('yyyy-MM-dd HH:mm:ss')
    	else
    		fromDate = '2000-01-01 00:00:00'
    	def toDate
    	if(period.toDate)
    		toDate = period.toDate?.format('yyyy-MM-dd HH:mm:ss')
    	else
    		toDate = '2999-01-01 00:00:00'
    	
    	def insertQuery = "insert into "+tableName+" (costcategory,costcenter,scheme,collector,collectorsCounsellor,donor,donorsCounsellor,donorsFamily,amount,pc,pchead) select ccat.name costcategory, cc.name costcenter, s.name scheme, ilcoll.name collector, ilcoll.counsellor collectorsCounsellor, ildonor.name donor, ildonor.counsellor donorsCounsellor,ildonor.familyof donorsFamily, sum(amount) amount,'','' from donation d left join scheme s on d.scheme_id=s.id left join cost_center cc on s.cc_id=cc.id left join cost_category ccat on cc.cost_category_id=ccat.id left join individuallist ildonor on d.donated_by_id=ildonor.indid left join individuallist ilcoll  on d.collected_by_id=ilcoll.indid where fund_receipt_date>='"+fromDate+"' and fund_receipt_date<'"+toDate+"' group by s.name,collected_by_id,donated_by_id union all select ccat.name costcategory, cc.name costcenter,s.name scheme, 'ECS', 'ECS', ildonor.name donor, ildonor.counsellor donorsCounsellor,'', sum(amount) amount,'','' from donation_record d, scheme s, cost_center cc, cost_category ccat, individuallist ildonor  where d.scheme_id=s.id and s.cc_id=cc.id and cc.cost_category_id=ccat.id and d.donated_by_id=ildonor.indid  and (d.receipt_received_status is null or (receipt_received_status!='GENERATED' and receipt_received_status!='NOTGENERATED')) and donation_date>='"+fromDate+"' and donation_date<'"+toDate+"' group by s.name,donated_by_id"
    	log.debug(insertQuery)
    	sql.execute insertQuery
    	
    	//insert any spill over records
    	if(params.schemeid)
    		{
		def spillQuery = "insert into "+tableName+" (costcategory,costcenter,scheme,collector,collectorsCounsellor,donor,donorsCounsellor,donorsFamily,amount,pc,pchead) select ccat.name costcategory, cc.name costcenter, s.name scheme, ilcoll.name collector, ilcoll.counsellor collectorsCounsellor, ildonor.name donor, ildonor.counsellor donorsCounsellor,ildonor.familyof donorsFamily, sum(amount) amount,'','' from donation d left join scheme s on d.scheme_id=s.id left join cost_center cc on s.cc_id=cc.id left join cost_category ccat on cc.cost_category_id=ccat.id left join individuallist ildonor on d.donated_by_id=ildonor.indid left join individuallist ilcoll  on d.collected_by_id=ilcoll.indid where fund_receipt_date>='"+toDate+"' and scheme_id="+params.schemeid+" group by s.name,collected_by_id,donated_by_id union all select ccat.name costcategory, cc.name costcenter,s.name scheme, 'ECS', 'ECS', ildonor.name donor, ildonor.counsellor donorsCounsellor,'', sum(amount) amount,'','' from donation_record d, scheme s, cost_center cc, cost_category ccat, individuallist ildonor  where d.scheme_id=s.id and s.cc_id=cc.id and cc.cost_category_id=ccat.id and d.donated_by_id=ildonor.indid  and (d.receipt_received_status is null or (receipt_received_status!='GENERATED' and receipt_received_status!='NOTGENERATED')) and donation_date>='"+toDate+"' and d.scheme_id="+params.schemeid+" group by s.name,donated_by_id"
		log.debug(spillQuery)
		sql.execute spillQuery
    		}
    	
    	
    	sql.executeUpdate "update "+tableName+" c,pclist p set c.pc=p.pc,c.pchead=p.pchead where c.donorsCounsellor is null and c.collector=p.pc"
    	sql.executeUpdate "update "+tableName+" set counsellor=donorsCounsellor,counsellee=donor,donation=amount where donorsCounsellor is not null"
    	sql.executeUpdate "update "+tableName+" set counsellor=collectorsCounsellor,counsellee=collector,collection=amount where donorsCounsellor is null"
    	sql.executeUpdate "update "+tableName+" set contribution=ifnull(donation,0)+ifnull(collection,0)"
    	
    	sql.close()
    	
    	return "DONE"
    	
    }
    
    def donationSummary(Map params) {
    	log.debug("Inside donationSummary with params: "+params)
    	
    	//get all the periods
    	def numPeriods = Period.count()
    	if(numPeriods<1)
    		return	//erroneous case
    	def periods = getPeriods(params)
    	def nump = periods.size()
    	//log.debug("Num periods: "+numPeriods +" arr size: "+nump)

    	def summaryRows = [], indDonation = [], indDonationRec = [], indCollection = [], clorList = [], cleeList = []
    	def clorSummaryList = [], cleeSummaryList = []

    	//get the clor list first
    	if(params.clorid)
    		clorList.add(Individual.get(params.clorid))
    	else
    		clorList = getClorList()

	clorList.each{clor->
		//first get clor data
		summaryRows = []
		def indCommits = committedSchemes(clor)
		indCommits.each{
			indDonation = new BigDecimal[numPeriods]
			indDonationRec = new BigDecimal[numPeriods]
			indCollection = new BigDecimal[numPeriods]
			for(i in 0..(numPeriods-1)) {
				indDonation[i] = individualDonationSummary(it.scheme,periods[i*2],periods[i*2+1],clor)
				indDonationRec[i] = individualDonationRecSummary(it.scheme,periods[i*2],periods[i*2+1],clor)
				indCollection[i] = individualCollectionSummary(it.scheme,periods[i*2],periods[i*2+1],clor)
				}
			summaryRows.add([scheme:it.scheme?.name,commitment:it.committedAmount,indDonation:indDonation, indDonationRec:indDonationRec,indCollection:indCollection])
			}
		//finally check for any other donations besides the commitment
		def committedSchemesList = indCommits.collect{it.scheme}
		indDonation = new BigDecimal[numPeriods]
		indDonationRec = new BigDecimal[numPeriods]
		indCollection = new BigDecimal[numPeriods]
		for(i in 0..(numPeriods-1)) {
			indDonation[i] = individualDonationSummary(committedSchemesList,periods[i*2],periods[i*2+1],clor)
			indDonationRec[i] = individualDonationRecSummary(committedSchemesList,periods[i*2],periods[i*2+1],clor)
			indCollection[i] = individualCollectionSummary(committedSchemesList,periods[i*2],periods[i*2+1],clor)
			}
		summaryRows.add([scheme:'Others',commitment:0,indDonation:indDonation,indDonationRec:indDonationRec,indCollection:indCollection])

		cleeSummaryList.add([cleeid:clor.id,clee:clor.toString(),summaryRows:summaryRows])
		
		//now get councelee list
		cleeList = getCleeList(clor)
		
		//get the donation summary for each
		cleeList.each{clee->
			//log.debug("Calculating for "+clee)
			summaryRows = []
			indCommits = committedSchemes(clee)
			indCommits.each{
				indDonation = new BigDecimal[numPeriods]
				indDonationRec = new BigDecimal[numPeriods]
				indCollection = new BigDecimal[numPeriods]
				for(i in 0..(numPeriods-1)) {
					indDonation[i] = individualDonationSummary(it.scheme,periods[i*2],periods[i*2+1],clee)
					indDonationRec[i] = individualDonationRecSummary(it.scheme,periods[i*2],periods[i*2+1],clee)
					indCollection[i] = individualCollectionSummary(it.scheme,periods[i*2],periods[i*2+1],clee)
					}
				summaryRows.add([scheme:it.scheme?.name,commitment:it.committedAmount,indDonation:indDonation,indDonationRec:indDonationRec,indCollection:indCollection])
				}
			//finally check for any other donations besides the commitment
			committedSchemesList = indCommits.collect{it.scheme}
			indDonation = new BigDecimal[numPeriods]
			indDonationRec = new BigDecimal[numPeriods]
			indCollection = new BigDecimal[numPeriods]
			for(i in 0..(numPeriods-1)) {
				indDonation[i] = individualDonationSummary(committedSchemesList,periods[i*2],periods[i*2+1],clee)
				indDonationRec[i] = individualDonationRecSummary(committedSchemesList,periods[i*2],periods[i*2+1],clee)
				indCollection[i] = individualCollectionSummary(committedSchemesList,periods[i*2],periods[i*2+1],clee)
				}
			summaryRows.add([scheme:'Others',commitment:0,indDonation:indDonation,indDonationRec:indDonationRec,indCollection:indCollection])
			
			cleeSummaryList.add([cleeid:clee.id,clee:clee.toString(),summaryRows:summaryRows])
		}
		clorSummaryList.add([clorid:clor.id,clor:clor.toString(),cleeSummaryList:cleeSummaryList])
    	}
    	return [periods:periods, clorSummaryList: clorSummaryList]  	
    }    
    
}
