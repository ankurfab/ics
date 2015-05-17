package ics
import org.codehaus.groovy.grails.plugins.springsecurity.*
import org.springframework.web.context.request.RequestContextHolder
import groovy.sql.Sql;

class DonationService {

    def springSecurityService
    def individualService
    def receiptSequenceService
    def housekeepingService
    def dataSource
    def financeService
    
    def serviceMethod() {

    }
    
    def createFromRecord(String idList) {
    	log.debug("Inside DonationService:createFromRecord"+idList)
	def ids = idList.tokenize(',')
	def dr
	def retText=""
	def numrec = 0
	def donation
	ids.each
	{
		dr = DonationRecord.get(it)
		if(dr)
			{
			donation = createDonationFromRecord(dr)
			if(donation)
				{
				dr.receiptReceivedStatus = 'GENERATED'
				dr.updator = springSecurityService.principal.username
				if(!dr.save())
					dr.errors.each {
                            				println it
                        				}
                        	else
                        		numrec++
                        		retText += "<br>Created <b>"+donation.toString()+"</b> for "+dr.toString()+" collector: "+donation.collectedBy?.toString()
                        	}
                        }
	}
	return retText+"<br>Total <b>"+numrec+"</b> created by <b>"+springSecurityService.principal.username+"</b>!!"
    }
    
    def createDonationFromRecord(DonationRecord dr) {
    	def retVal = null
    	if(dr.receiptReceivedStatus=='NOTGENERATED')
    		{
    		retVal = createDonation(dr, "DONATION", "", false, false)
		}
	return retVal
    }

    
    def createDonation(DonationRecord dr, String receiptSequenceKey, String receiptBookKey, Boolean backDated, Boolean collectionByCreator) {
	def retVal = null
    	def receipt = null
    	def receiptBook = null
    	def otherDonation = null
	def donation = new Donation()
	donation.donatedBy = dr.donatedBy
	donation.donorName = dr.donatedBy.toString()
	donation.donorAddress = Address.findByIndividualAndCategory(dr.donatedBy,'Correspondence')?.toString()?:''
	donation.donorContact = VoiceContact.findByIndividualAndCategory(dr.donatedBy,'CellPhone')?.number?:''
	donation.collectionType = 'Donation'
	//@TODO: hardcoding for EASY
	if(dr.scheme?.name!='EASY')
		donation.scheme = dr.scheme
	else {
		//get appropriate scheme from centre
		def scheme
		try{
		scheme = Scheme.findByStatusIsNullAndCc(Department.findByCentreAndName(dr.schemeMember?.centre,'ECS-DONATION')?.costCenter)
		}
		catch(Exception e){log.debug('Exception in createDonation:get scheme for EASY:'+e)}
		if(!scheme)
			scheme = Scheme.findByStatusIsNullAndName('CENTRAL FUND (IYF)')	//@TODO: hardcoded default scheme for EASY
		if(scheme)
			donation.scheme = scheme
		else
			donation.scheme = dr.scheme		
	}
	
	donation.mode = dr.mode
	donation.donationDate = dr.donationDate
	if(backDated)
		donation.fundReceiptDate = dr.donationDate
	else
		donation.fundReceiptDate = new Date()
	donation.amount = dr.amount
	donation.currency = 'INR'
	donation.bankName = dr.paymentDetails
	donation.bankBranch = dr.transactionDetails
	donation.chequeNo = dr.transactionId
	donation.chequeDate = dr.donationDate
	if(dr.rbno && dr.rno)
		{
		//receiptBook = ReceiptBook.findBy
		receipt = Receipt.findByReceiptNumber(dr.rno)
		otherDonation = Donation.findByDonationReceipt(receipt)
		if(otherDonation)
			{
			log.debug("Duplicate receipt used by : "+springSecurityService.principal.username+" dr: "+dr+" otherDonation : "+otherDonation)
			receipt = null
			}
		//@TODO: rbno should match also verify rb issued to etc
		}
	if(receipt)
		{
		donation.donationReceipt = receipt //todo: hardcoding for dummy receipt
		donation.nvccReceiptNo = dr.rno
		donation.nvccReceiptBookNo = dr.rbno
		}
	else
		{
		donation.donationReceipt = Receipt.get(1) //todo: hardcoding for dummy receipt
		def rno = receiptSequenceService.getNext(receiptSequenceKey)
		donation.nvccReceiptNo = rno
		if(backDated)
			donation.nvccReceiptBookNo = getRBNo(donation.donationDate)
		else
			donation.nvccReceiptBookNo = getRBNo()		
		}
		donation.nvccReceiptBookNo =  receiptBookKey+donation.nvccReceiptBookNo
		
	//@TODO: this is wrong..collector could be someone else as well
	if(collectionByCreator)
		donation.collectedBy = Individual.findByLoginid(dr.creator)
	else
		donation.collectedBy = dr.donatedBy

	if(dr.collectedBy)
		donation.collectedBy = dr.collectedBy

	donation.receivedBy = Individual.findByLoginid(springSecurityService.principal.username)
	donation.updator=donation.creator=springSecurityService.principal.username
	if(!donation.save())
		donation.errors.each {
			       println it
				}
	else
		{
		log.debug("Autocreated donation.."+donation)
		
		financeService.updateProfitCenterBudget(donation)
		
		retVal = donation
		//update the dr with the linked donation
		dr.donation=donation
		dr.save()
		//send SMS to the donor, if it is a recent donation
		def recent = false
		use(groovy.time.TimeCategory) {
		   def duration = new Date() - donation.donationDate
		   //log.debug "days: ${duration.days}, Hours: ${duration.hours}"
		   if(duration.days<=30)
		   	recent = true
		}
		try{
			if(donation.donorContact && donation.donorName && recent && dr.scheme?.name!='EASY') {	//@TODO: harcoded, whether sms to be sent or not should be picked up from profile
				def donorNameForSMS = donation.donorName.replace(" ","%20")
				housekeepingService.sendSMS(donation.donorContact,'Dear%20'+donorNameForSMS+',%20Hare%20Krishna!%20Thank%20you%20for%20the%20donation%20of%20Rs'+donation.amount+'.%20May%20Lord%20Krishna%20shower%20His%20choicest%20blessings%20upon%20you.%20ISKCON%20Pune')			
			}
		}
		catch(Exception e){}
		}
	return retVal
    }

    def createDonationRecord(Map params) {
    	def retVal = null
	def dr = new DonationRecord()

	if(params.acCollector_id)
		dr.collectedBy = Individual.get(params.acCollector_id)

    	if(params.icsid)    		
		dr.donatedBy = Individual.findByIcsid(params.icsid)
	else
		dr.donatedBy = individualService.createIndividual(params)
	dr.donorName = params.donorName
	dr.scheme = Scheme.get(params.'scheme.id')
	if(params.chequeDate)
		dr.donationDate = Date.parse('dd-MM-yyyy', params.chequeDate)
	else
		dr.donationDate = new Date()
	dr.comments = params.comments
	dr.mode = PaymentMode.get(params.'mode.id')
	dr.amount = new BigDecimal(params.amount)
	dr.transactionId = params.chequeNo
	dr.paymentDetails = params.bankName
	dr.transactionDetails = params.branchName
	
	if(params.rbno)
		dr.rbno = params.rbno
	else
		dr.rbno = housekeepingService.getFY()
	if(params.rno)
		dr.rno = params.rno
	else
		dr.rno = receiptSequenceService.getNext("TEMPDONATION_"+params.'scheme.id')
	
	dr.centre = IndividualCentre.findByIndividualAndStatus(Individual.findByLoginid(springSecurityService.principal.username),'ACTIVE')?.centre
	try{
	//if indcentre is null then try from scheme's centre
	if(!dr.centre)
		dr.centre = dr.scheme?.department?.centre
	}
	catch(Exception e){
		log.debug(e)
	}
	dr.receiptReceivedStatus = "NOTGENERATED"
	dr.updator=dr.creator=springSecurityService.principal.username    
    	if(!dr.save())
    		dr.errors.each {
		               println it
                        	}
        else
        	{
        	log.debug("donation record created.."+dr)
        	retVal = dr
        	}
    	return retVal
	
    }
    
    def saveDonationWithAutoReceiptNo(Donation donationInstance) {
	def rno = receiptSequenceService.getNext("DONATION")
	donationInstance.nvccReceiptNo = rno
	donationInstance.nvccReceiptBookNo = getRBNo()

	log.debug("AutoSaving donation : "+donationInstance)
	if(!donationInstance.save())
		{
		donationInstance.errors.allErrors.each {println it}
		return null
		}
	else
		{
		return donationInstance
		}
	return donationInstance
    }
    
    def saveDonationWithAutoReceiptNo(Donation donationInstance, String sequenceType) {
	def rno = receiptSequenceService.getNext(sequenceType)
	donationInstance.nvccReceiptNo = rno
	donationInstance.nvccReceiptBookNo = sequenceType+"-"+getRBNo()

	log.debug("saveDonationWithAutoReceiptNo:AutoSaving donation : "+donationInstance)
	if(!donationInstance.save())
		{
		donationInstance.errors.allErrors.each {println it}
		return null
		}
	else
		{
		return donationInstance
		}
	return donationInstance
    }

    def getRBNo() {
	def rbno=""
	def depAlias = RequestContextHolder.currentRequestAttributes().getSession()?.receiverDepAlias
	if(depAlias)
		rbno = depAlias+"/"+housekeepingService.getFY()
	else
		rbno = housekeepingService.getFY()
    }
    
    def getRBNo(Date date) {
	def rbno=""
	def depAlias = RequestContextHolder.currentRequestAttributes().getSession()?.receiverDepAlias
	if(depAlias)
		rbno = depAlias+"/"+housekeepingService.getFY(date)
	else
		rbno = housekeepingService.getFY(date)
    }
    
    def listDonorsInLocality(Map params) {
		 def cultivatorRel = Relation.findByName('Cultivated by')
		 def counsellorRel = Relation.findByName('Councellee of')                   
	def query=params.locality
	/*def tokens = params.locality.split()
	tokens.each
		{
			query += it +"~0.8"
		}*/
	def numMatchingAddresses = Address.countHits(query)
	//log.debug("numMatchingAddresses:"+query+":"+numMatchingAddresses)
	//@TODO: hardcoded
	def addrSearch = Address.search(query,[max:100000])
      def mAddrs = addrSearch.results.collect{it.id}
      mAddrs = mAddrs.unique()
      log.debug("mAddrs size"+mAddrs.size())
      //log.debug("scores"+addrSearch.scores.collect{it})
      
      //log.debug("finding inds*******************")

      //def matchedIndividuals = Address.executeQuery("select distinct a.individual from address a where a.id in (:aids)",[aids: mAddrs])
	def matchedIndividuals = []
	if(mAddrs.size()>0) {
	matchedIndividuals = Individual.createCriteria().list{
				address{'in'('id',mAddrs)}
			projections{
				id()
				}
			}
	}
	matchedIndividuals = matchedIndividuals.unique()

      //log.debug("matchedIndividuals size"+matchedIndividuals.size())

      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	/*def result = Donation.createCriteria().list() {

		if(mAddrs.size()>0)
			donatedBy{address{'in'('id',mAddrs)}}
		else
			{
			donatedBy{eq('id',new Long(-1))}
			//Address.reindex()
			}

                projections{                                        
                    groupProperty("donatedBy")
                    sum("amount")                     
                }		
		
		order(sortIndex, sortOrder)

	}*/

	/*def result = Donation.createCriteria().list(max:maxRows, offset:rowOffset) {
                projections{                                        
                    groupProperty("donatedBy")
                    sum("amount")                     
                }
               }*/

	//log.debug("execquery++++++++++++++:")
	
	def fromDate=null,toDate=null, qryParams=[indids: matchedIndividuals,minamt:new BigDecimal((params.minAmt?:0)),maxamt:new BigDecimal((params.maxAmt?:100000000))]
	def dateRangeCond = ""
	  if(params.fromDate)
	  	{
		fromDate = Date.parse('dd-MM-yyyy',params.fromDate)
		dateRangeCond = " and d.fundReceiptDate >= :fromDate "
		qryParams.put('fromDate',fromDate)
		}
	  if(params.toDate)
	  	{
		toDate = Date.parse('dd-MM-yyyy',params.toDate)
		dateRangeCond += " and d.fundReceiptDate <= :toDate "
		qryParams.put('toDate',toDate)
		}

	
	def dquery = "select d.donatedBy,sum(d.amount) from Donation d where d.donatedBy.id in(:indids) "+dateRangeCond+" group by d.donatedBy having sum(d.amount)>=:minamt and sum(d.amount)<=:maxamt order by sum(d.amount) desc"
	def totalQuery = "select count(distinct d.donatedBy) from Donation d where d.donatedBy.id in(:indids) "+dateRangeCond+"  group by d.donatedBy having sum(d.amount)>=:minamt and sum(d.amount)<=:maxamt"
	/*log.debug("dquery "+dquery)
	log.debug("totalQuery "+totalQuery)
	log.debug("qryParams "+qryParams)*/
	
	def result = Donation.executeQuery(dquery,qryParams, [max: maxRows, offset: rowOffset])
	def allRows = Donation.executeQuery(totalQuery,qryParams)
	def totalRows = 0
	allRows.each{totalRows+=it}
	//log.debug("totalrows:"+totalRows)
	
      //def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)
	def donor
      def jsonCells = result.collect {
            donor = it[0]
            [cell: [
		    donor.toString(),
		    it[1],
		    '',
		    /*'',
		    '',
		    '',
		    '',
		    '',
		    '',
		    '',*/
		    Address.findAllByIndividual(donor)?.toString(),
		    VoiceContact.findAllByIndividual(donor)?.toString(),
		    EmailContact.findAllByIndividual(donor)?.toString(),
		    Relationship.findAllWhere(individual1:donor,relation:cultivatorRel,status:'ACTIVE')?.collect{it.individual2?.toString()},
		    Donation.findAllByDonatedBy(donor,[sort: "donationDate", order: "desc"])?.collect{it.collectedBy?.toString()}?.unique(),
		    Relationship.findAllWhere(individual1:donor,relation:counsellorRel,status:'ACTIVE')?.collect{it.individual2?.toString()},
                ], id: donor.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
      
    return jsonData
    }
    
    //get collection summary
    def donationSummary(Map params) {
	    def retMessage=""
	    def from
	    
	    if(!params.from)
	    	from = new Date().clearTime()
	    else
	    	from = Date.parse('dd-MM-yyyy', params.from)
	    	
	    def till = new Date()
	    if(params.till)
	    	{
	    	params.till += ' 23:59:59'
		till = Date.parse('dd-MM-yyyy HH:mm:ss', params.till)
		}
	    log.debug("Inside donationSummary"+from+"->"+till)
	    
	    //get donations by scheme in the provided date range
	    def sql = new Sql(dataSource);
	    def query = "select s.name scheme,sum(amount) amount from donation d, scheme s where d.scheme_id=s.id and d.fund_receipt_Date>='"+from.format('yyyy-MM-dd HH:mm:ss')+"' and d.fund_receipt_Date<='"+till.format('yyyy-MM-dd HH:mm:ss')+"' group by s.name order by s.name"
	    def sList = sql.rows(query)
	    
	    //scheme wise summary
	    def total = 0
	    retMessage="<table border='1'><tr><td><table border='1'><tr><td>Scheme Summary From: "+from.format('dd-MM-yyyy HH:mm:ss')+"</td><td>Till: "+till.format('dd-MM-yyyy HH:mm:ss')+"</td></tr>"	    
	    sList.each{
	    	retMessage+="<tr><td>"+it.scheme+"</td><td>"+it.amount+"</td></tr>"
	    	total += it.amount
	    }
	    retMessage+="<tr><td>Total:</td><td>"+total+"</td></tr></table></td>"
	    
	    //mode wise summary
	    query = "select m.name mode,sum(amount) amount from donation d, payment_mode m where d.mode_id=m.id and d.fund_receipt_Date>='"+from.format('yyyy-MM-dd HH:mm:ss')+"' and d.fund_receipt_Date<='"+till.format('yyyy-MM-dd HH:mm:ss')+"' group by m.name order by m.name"
	    sList = sql.rows(query)
	    
	    total = 0
	    retMessage+="<td><table border='1'><tr><td>Payment Mode Summary From: "+from.format('dd-MM-yyyy HH:mm:ss')+"</td><td>Till: "+till.format('dd-MM-yyyy HH:mm:ss')+"</td></tr>"	    
	    sList.each{
	    	retMessage+="<tr><td>"+it.mode+"</td><td>"+it.amount+"</td></tr>"
	    	total += it.amount
	    }
	    retMessage+="<tr><td>Total:</td><td>"+total+"</td></tr></table></td></tr></table>"
	    
	    //receiver-mode wise summary
	    query = "select if(initiated_name is not null and trim(initiated_name)!='',initiated_name,legal_name) receiver, m.name mode,sum(amount) amount from donation d, payment_mode m, individual i where d.received_by_id=i.id and d.mode_id=m.id and d.fund_receipt_Date>='"+from.format('yyyy-MM-dd HH:mm:ss')+"' and d.fund_receipt_Date<='"+till.format('yyyy-MM-dd HH:mm:ss')+"' group by receiver, m.name order by receiver,m.name"
	    sList = sql.rows(query)
	    
	    total = 0
	    retMessage+="<table border='1'><tr><td>Payment Mode Summary From: "+from.format('dd-MM-yyyy HH:mm:ss')+"</td><td>Till: "+till.format('dd-MM-yyyy HH:mm:ss')+"</td></tr>"	    
	    sList.each{
	    	retMessage+="<tr><td>"+it.receiver+"</td><td>"+it.mode+"</td><td>"+it.amount+"</td></tr>"
	    	total += it.amount
	    }
	    retMessage+="<tr><td/><td>Total:</td><td>"+total+"</td></tr></table>"
	    
	    retMessage = retMessage.replaceAll("-General Donations","")
	    
	    sql.close()

 	    return retMessage
	    


	    //get collection by PC for construction summary
	    
	    //get collections by PC for maintenance summary
	    
	    //get donation by devotees summary
	    
	    //get collections by devotees summary
    }
    
    //split the main donation record, ie the result of ecs into many as per commitments
    def split(DonationRecord dr) {
    	//first check if this was a valid debit
    	//if(dr.amount==0 && dr.expectedamount>0)
    	//	return false
    	//even for records with amount zero ,we need to make entry for this bounced record for each scheme in commitment
    	//now check if there were many commitments
    	def commitments = Commitment.findAllByStatusAndEcsMandate('ACTIVE',dr.transactionDetails)
    	switch(commitments.size()) {
		case 0:
			break
    		case 1:
    			//just update the scheme as per commitment
    			dr.scheme = commitments[0].scheme
    			def secondrecord = null
                def schemeMember = SchemeMember.findBySchemeAndMember(dr.scheme, dr.donatedBy)

                if(schemeMember != null && schemeMember?.centre != null){
                	dr.centre = schemeMember?.centre
                }

    			
				/*
                        	logic for creating donation record for second center                        	
                        	*/
                        	//logic for creating donation for second centre

				                    if(schemeMember != null && schemeMember?.secondcentre!=null){
				                        if(schemeMember.percentageDeductionSecondCentreUpper !=null && schemeMember.percentageDeductionSecondCentreUpper > 0
				                           && schemeMember.percentageDeductionSecondCentreLower!= null && schemeMember.percentageDeductionSecondCentreLower > 0){
				                          // creating new record
				                         secondrecord = new DonationRecord()
				                         secondrecord.donatedBy = dr.donatedBy
				                         secondrecord.scheme = dr.scheme
				                         secondrecord.centre= schemeMember.secondcentre
				                         secondrecord.donationDate = dr.donationDate
				                         secondrecord.comments = dr.comments
				                         secondrecord.mode = dr.mode
				                         secondrecord.paymentDetails = dr.paymentDetails
				                         secondrecord.transactionDetails = dr.transactionDetails
				                         secondrecord.updator=springSecurityService.principal.username
				                        secondrecord.creator=springSecurityService.principal.username
				                        secondrecord.transactionId = dr.transactionId
				                        secondrecord.reference = dr.reference

				                         secondrecord.amount = new Double((dr.amount *schemeMember.percentageDeductionSecondCentreUpper)/ schemeMember.percentageDeductionSecondCentreLower).round(2)
				                         dr.amount = dr.amount - secondrecord.amount

				                         if(secondrecord.amount ==0){
				                         	secondrecord.expectedamount = new Double((dr.expectedamount *schemeMember.percentageDeductionSecondCentreUpper)/ schemeMember.percentageDeductionSecondCentreLower).round(2)
				                         	dr.expectedamount = dr.expectedamount - secondrecord.expectedamount
				                         }
				                         println "creating second donation record for "+ schemeMember?.externalName
				                         println "first record of amount "+ dr.amount
				                         println "second record of amount "+ secondrecord.amount 
				                      }
				                    }

				        if (!dr.save()) {
				                    dr.errors.each {
				                        println it
				                    }
				                  }
				                  if(secondrecord != null){
				                     if (!secondrecord.save()) {
				                        secondrecord.errors.each {
				                            println it
				                        }
				                    }
				                    
				                  }


			break
		default:
			//split for multiple schemes
			def newDR
			def donatedAmount = dr.amount
			def totalCommittedAmount = commitments.sum{it.committedAmount}/12
			commitments.each{
                         newDR = new DonationRecord()
                         newDR.donatedBy = dr.donatedBy
                         newDR.scheme = it.scheme
                         newDR.donationDate = dr.donationDate
                         newDR.comments = dr.comments
                         newDR.mode = dr.mode
                         newDR.paymentDetails = dr.paymentDetails
                         newDR.transactionDetails = dr.transactionDetails
                         newDR.updator=springSecurityService.principal.username
                        newDR.creator=springSecurityService.principal.username
                        newDR.transactionId = dr.transactionId
                        newDR.reference = dr.reference

                         newDR.amount = new Double(((it.committedAmount/12)/totalCommittedAmount)*donatedAmount).round(2)	//commitments are annual; also split as per ratio
                         if(newDR.amount ==0){
                         	newDR.expectedamount = new Double(((it.committedAmount/12)/totalCommittedAmount) * dr.expectedamount).round(2)
                         }
                         dr.amount = dr.amount - newDR.amount
                         
                       log.debug("Splitted rec : "+newDR)

                    
	                    def secondrecord = null
	                    def schemeMember = SchemeMember.findBySchemeAndMember(it.scheme, dr.donatedBy)

	                    if(schemeMember != null && schemeMember?.centre != null){
                        	newDR.centre = schemeMember?.centre
                        }

	                    if (!newDR.save())
                        newDR.errors.each {println it}	                    


                        	/*
                        	logic for creating donation record for second center                        	
                        	*/
                        	//logic for creating donation for second centre

				                    if(schemeMember != null && schemeMember?.secondcentre!=null){
				                        if(schemeMember.percentageDeductionSecondCentreUpper !=null && schemeMember.percentageDeductionSecondCentreUpper > 0
				                           && schemeMember.percentageDeductionSecondCentreLower!= null && schemeMember.percentageDeductionSecondCentreLower > 0){
				                          // creating new record
				                         secondrecord = new DonationRecord()
				                         secondrecord.donatedBy = newDR.donatedBy
				                         secondrecord.scheme = newDR.scheme
				                         secondrecord.centre= schemeMember.secondcentre
				                         secondrecord.donationDate = newDR.donationDate
				                         secondrecord.comments = newDR.comments
				                         secondrecord.mode = newDR.mode
				                         secondrecord.paymentDetails = newDR.paymentDetails
				                         secondrecord.transactionDetails = newDR.transactionDetails
				                         secondrecord.updator=springSecurityService.principal.username
				                        secondrecord.creator=springSecurityService.principal.username
				                        secondrecord.transactionId = newDR.transactionId
				                        secondrecord.reference = newDR.reference

				                         secondrecord.amount = new Double((newDR.amount *schemeMember.percentageDeductionSecondCentreUpper)/ schemeMember.percentageDeductionSecondCentreLower).round(2)
				                         newDR.amount = newDR.amount - secondrecord.amount

				                         if(secondrecord.amount ==0){
				                         	secondrecord.expectedamount = new Double((newDR.expectedamount *schemeMember.percentageDeductionSecondCentreUpper)/ schemeMember.percentageDeductionSecondCentreLower).round(2)
				                         	newDR.expectedamount = newDR.expectedamount - secondrecord.expectedamount
				                         }
				                         println "creating second donation record for "+ schemeMember?.externalName
				                         println "first record of amount "+ newDR.amount
				                         println "second record of amount "+ secondrecord.amount 
				                      }
				                    }

				                    
				                    if (!newDR.save()) {
				                    newDR.errors.each {
				                        println it
				                    }
				                  }
				                  if(secondrecord != null){
				                     if (!secondrecord.save()) {
				                        secondrecord.errors.each {
				                            println it
				                        }
				                    }
				                    
				                  }
				               /*
				               end of logic for second center
				               */				    			               
                     
			}
			 if(dr.amount != null && dr.amount >0){				     	
				     	if (!dr.save())
                        dr.errors.each {println it}	
			}	
			break
    	}
    return true
    }

    def createDonationFromDR(Map params) {
    	log.debug("Inside createDonationFromDR with params:"+params)
    	//1. get all drs which dont have corresponding donation
    	def drList = DonationRecord.createCriteria().list(){
    				isNull('receiptReceivedStatus')
    				isNull('donation')
    				gt('amount',new BigDecimal(0))
    				if(params.fromDate)
    					ge('donationDate',Date.parse('dd-MM-yyyy', params.fromDate))
    				if(params.tillDate)
    					le('donationDate',Date.parse('dd-MM-yyyy', params.tillDate))
    				order("donationDate", "asc")
    			}
    	log.debug("createDonationFromDR found unmapped drs count:"+drList.size())
    	//2. create donation entries for them with same data but use different receipt sequence
    	def count=0
    	def fy="",rbStr=""
    	def donation
    	drList.each{
    		fy = housekeepingService.getFY(it.donationDate)
    		rbStr = "ED-"+it.donationDate?.format('MMMyy')+"-"
    		donation = createDonation(it, rbStr+fy, rbStr,true, false)
    		if(donation) {
    			count++
    			//update the dr with the corresponding donation
    			it.donation = donation
    			if(!it.save(flush:true))
    				it.errors.each {log.debug(it)}
    		}
    	}
    	
    	return "created "+count+" donations from "+drList.size()+" donationRecords!!"
    }
    
    //for autocreating ONLINE or NEFT donations in bulk
    def autoCreateDonation(Object tokens) {
    	log.debug("In autoCreateDonation with tokens:"+tokens)
    	Individual collector,receiver
    	String loggedinUser = springSecurityService.principal.username
    	collector = receiver = Individual.findByLoginid(loggedinUser)
    	
    	Map  params = [:]
    	params.put('donorName',tokens[1]?.trim()?:'')
    	params.put('donorAddress',tokens[2]?.trim()?:'')
    	params.put('donorContact',tokens[3]?.trim()?:'')
    	params.put('donorEmail',tokens[4]?.trim()?:'')
    	params.put('amount',tokens[5])
    	params.put('comments',tokens[6]?.trim()?:'')
    	params.put('bankName',tokens[7])
    	params.put('bankBranch',tokens[8])	//ICS or Online order no..maybe null for NEFT etc
    	params.put('chequeNo',tokens[9])	//bank specific transaction no
    	params.put('fundReceiptDate',Date.parse('dd-MM-yyyy', tokens[10]))
    	params.put('donationDate',Date.parse('dd-MM-yyyy', tokens[10]))
    	params.put('mode',PaymentMode.findByName('tokens[11]')?:PaymentMode.findByName('ONLINE'))
    	params.put('collectedBy',collector)
    	params.put('receivedBy',receiver)
    	params.put('currency','INR')	//@TODO : hardcoded
    	
    	
    	//first check if donation already created
    	def oldDonation = Donation.findByBankNameAndChequeNo(params.bankName,params.chequeNo)
    	if(oldDonation) {
    		log.debug("autoCreateDonation found oldDonation:"+oldDonation)
    		return null
    	}
    	//get the donor now
    	Individual donor
    	EventRegistration er
    	Scheme scheme
    	def erId = ''
    	if(params.bankBranch?.startsWith('ICS')) {
    		erId = params.bankBranch.substring(16)
    		log.debug("autoCreateDonation:Found ICS created donation..erid:"+erId)
    		er = EventRegistration.findById(new Long(erId))
    		donor = er?.individual
    		if(donor)
    			log.debug("autoCreateDonation:Found individual from er:"+donor)
    		//@TODO: how to get the scheme/cost center??
    		scheme = Scheme.findByDepartment(er?.event?.department)
    	}
    	if(!donor)
    		//donor = individualService.createIndividual(params)
    		donor = Individual.findByLegalName('Dummy Donor for daily transactions')	//@TODO-matching to be done by backoffice

    	params.put('donatedBy',donor)
    	
    	if(!scheme)
    		scheme = Scheme.findByName('MAINTENANCE-General Donations')	//@TODO: hardocoded for now
    		
    	params.put('scheme',scheme)


	log.debug("autoCreateDonation:params before saving donation :"+params)
	def donationInstance = new Donation(params)

	donationInstance.donationReceipt = Receipt.get(1) //todo: hardcoding for dummy receipt
	donationInstance.updator = donationInstance.creator = loggedinUser
	
	if(!saveDonationWithAutoReceiptNo(donationInstance,'ACD'))
		return null
	else
		return donationInstance
    	    		
    }
    
}
