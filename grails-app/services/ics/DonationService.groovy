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
    	def receipt = null
    	def receiptBook = null
    	def otherDonation = null
    	if(dr.receiptReceivedStatus=='NOTGENERATED')
    		{   		
		def donation = new Donation()
		donation.donatedBy = dr.donatedBy
		donation.donorName = dr.donatedBy.toString()
		donation.donorAddress = Address.findByIndividualAndCategory(dr.donatedBy,'Correspondence')?.toString()?:''
		donation.donorContact = VoiceContact.findByIndividualAndCategory(dr.donatedBy,'CellPhone')?.number?:''
		donation.collectionType = 'Donation'
		donation.scheme = dr.scheme
		donation.mode = dr.mode
		donation.donationDate = dr.donationDate
		donation.fundReceiptDate = new Date()
		donation.amount = dr.amount
		donation.currency = 'INR'
		donation.bankName = dr.paymentDetails
		donation.bankBranch = dr.transactionDetails
		donation.chequeNo = dr.transactionId
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
			def rno = receiptSequenceService.getNext("DONATION")
			donation.nvccReceiptNo = rno
			donation.nvccReceiptBookNo = getRBNo()
			}
		donation.collectedBy = Individual.findByLoginid(dr.creator)
		donation.receivedBy = Individual.findByLoginid(springSecurityService.principal.username)
		donation.updator=donation.creator=springSecurityService.principal.username
		if(!donation.save())
			donation.errors.each {
				       println it
					}
		else
			{
			log.debug("Autocreated donation.."+donation)
			retVal = donation
			//update the dr with the linked donation
			dr.donation=donation
			dr.save()
			//send SMS to the donor
			if(donation.donorContact && donation.donorName) {
				def donorNameForSMS = donation.donorName.replace(" ","%20")
				housekeepingService.sendSMS(donation.donorContact,'Dear%20'+donorNameForSMS+',%20Hare%20Krishna!%20Thank%20you%20for%20the%20donation%20of%20Rs'+donation.amount+'.%20May%20Lord%20Krishna%20shower%20His%20choicest%20blessings%20upon%20you.%20ISKCON%20Pune')			
			}
			}
		}
	return retVal
    }
    
    def createDonationRecord(Map params) {
    	def retVal = null
	def dr = new DonationRecord()
    	if(params.icsid)    		
		dr.donatedBy = Individual.findByIcsid(params.icsid)
	else
		dr.donatedBy = individualService.createIndividual(params)
	dr.donorName = params.donorName
	dr.scheme = Scheme.get(params.'scheme.id')
	dr.donationDate = new Date()
	dr.comments = params.comments
	dr.mode = PaymentMode.get(params.'mode.id')
	dr.amount = new BigDecimal(params.amount)
	dr.transactionId = params.chequeNo
	dr.paymentDetails = params.bankName
	dr.transactionDetails = params.branchName
	dr.rbno = params.rbno
	dr.rno = params.rno
	dr.centre = IndividualCentre.findByIndividualAndStatus(Individual.findByLoginid(springSecurityService.principal.username),'ACTIVE')?.centre
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
    
    def getRBNo() {
	def rbno=""
	def depAlias = RequestContextHolder.currentRequestAttributes().getSession()?.receiverDepAlias
	if(depAlias)
		rbno = depAlias+"/"+housekeepingService.getFY()
	else
		rbno = housekeepingService.getFY()
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
	    
	    retMessage="<table><tr><td>Collection Summary From: "+from.format('dd-MM-yyyy HH:mm:ss')+"</td><td>Till: "+till.format('dd-MM-yyyy HH:mm:ss')+"</td></tr>"	    
	    sList.each{
	    retMessage+="<tr><td>"+it.scheme+"</td><td>"+it.amount+"</td>"
	    }
	    
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
    	if(dr.amount==0 && dr.expectedamount>0)
    		return false
    	//now check if there were many commitments
    	def commitments = Commitment.findAllByStatusAndEcsMandate('ACTIVE',dr.transactionDetails)
    	switch(commitments.size()) {
		case 0:
			break
    		case 1:
    			//just update the scheme as per commitment
    			dr.scheme = commitments[0].scheme
    			if(!dr.save())
				    dr.errors.allErrors.each {
					log.debug("In donationService.split: error "+ it)
					}
			break
		default:
			//split for multiple schemes
			def newDR
			commitments.each{
                         newDR = new DonationRecord()
                         newDR.donatedBy = dr.donatedBy
                         newDR.scheme = it.scheme
                         newDR.donationDate = dr.donationDate
                         newDR.comments = dr.comments
                         newDR.mode = dr.mode
                         newDR.paymentDetails = dr.paymentDetails
                         newDR.updator=springSecurityService.principal.username
                        newDR.creator=springSecurityService.principal.username
                        newDR.transactionId = dr.transactionId
                        newDR.reference = dr.reference

                         newDR.amount = it.committedAmount/12	//commitments are annual
                         dr.amount = dr.amount - newDR.amount
                         
                       log.debug("Splitted rec : "+newDR)

                     if (!newDR.save())
                        newDR.errors.each {println it}
                     if (!dr.save())
                        dr.errors.each {println it}
			}
			break
    	}
    return true
    }

}
