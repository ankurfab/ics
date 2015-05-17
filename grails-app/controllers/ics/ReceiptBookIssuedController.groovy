package ics

import grails.converters.*
import groovy.sql.Sql;
import java.util.zip.ZipOutputStream  
import java.util.zip.ZipEntry  
import org.grails.plugins.csv.CSVWriter
import org.apache.commons.lang.StringEscapeUtils.*

class ReceiptBookIssuedController {
def housekeepingService
def springSecurityService
def dataSource

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 20, 100)
        if(!params.sort)
        	params.sort = "lastUpdated" 
        if(!params.order)
        	params.order = "desc"
        
        [receiptBookIssuedInstanceList: ReceiptBookIssued.list(params), receiptBookIssuedInstanceTotal: ReceiptBookIssued.count()]
    }

    def create = {
    
    def catc = ReceiptBook.createCriteria()
 
		//def category = ReceiptBook.findAllByStatus("valid").category
		def category = ReceiptBook.executeQuery("Select distinct category from ReceiptBook where status = 'Blank'")
    	def role = Role.findByName("Collector")
    	def c = Individual.createCriteria()
    	def collectors = c.list
    		{
    		individualRoles
    			{
    			eq("role",role)
    			}
    			order("legalName", "asc")
    		}
       def receiptBookIssuedInstance = new ReceiptBookIssued()
        receiptBookIssuedInstance.properties = params
        return [receiptBookIssuedInstance: receiptBookIssuedInstance, collectors: collectors, category: category]
    }

    def save = {
    	println 'save params='+params
    	/*if (params.receiptBook)
    	{
    		def sql = new Sql(dataSource)
    		def rBook = "select id from receipt_book where book_series = " + (params.receiptBook).substring(0,1) + " and book_serial_number ="+(params.receiptBook).substring(1,(params.receiptBook).length()-1)
		params."receiptBook.id" = sql.firstRow(rBook).id
    		sql.close()
    		//params."receiptBook.id" = ReceiptBook.findByBookSeriesAndBookSerialNumber((params.receiptBook).substring(0,1),(params.receiptBook).substring(1,(params.receiptBook).length()-1)).id
    		println 'params."receiptBook.id"='+params."receiptBook.id"
    	}*/
    	
    	if(params.id)
    	{
    		def idArr = params.list('id')
    		params.id = idArr
    		println 'idArr='+idArr
    		println 'params.id='+params.id
    		
    		def newInd
		if (springSecurityService.isLoggedIn()) {
			params.creator=springSecurityService.principal.username
		}
		else
			params.creator=""
		params.updator=params.creator
		if(params."acIssuedTo_id"==null||params."acIssuedTo_id".length()==0)
			newInd = true
		if (!newInd)
			params."issuedTo.id"= params."acIssuedTo_id"
		else
			{
			//create new individual first (as collector)
			params."issuedTo.id" = housekeepingService.createCollector(params.acIssuedTo)
			}

		if(params.issueDate)
			params.issueDate = Date.parse('dd-MM-yyyy', params.issueDate)

		def nextBatchId = housekeepingService.getMaxBatchId()


			    //params.batchId = nextBatchId


		def receiptBookIssuedInstance	
		def rbIssueList=[], flgErr = 0

		params.status = "Issued"
		//params.numBooks = params.id.size()    	
    		for(int i=0; i<params.id.size(); i++)
    		{
    			params."receiptBook.id" = params.id[i]
    			println 'params."receiptBook.id"='+ params."receiptBook.id"
    			params.batchId = nextBatchId
    			ReceiptBook.findById(params.id[i]).status = "Issued"
    			receiptBookIssuedInstance = new ReceiptBookIssued(params)
    			println 'receiptBookIssuedInstance='+receiptBookIssuedInstance
			if (receiptBookIssuedInstance.save(flush: true)) { 
				rbIssueList.add(receiptBookIssuedInstance.id)

			}
			else {
				flgErr = 1
			}
    			
    		}
		if(flgErr == 0)
			{
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued'), rbIssueList])}"
			redirect(action: "issueacknowledgement", id: nextBatchId)
			}
		else
			render(view: "create", model: [receiptBookIssuedInstance: receiptBookIssuedInstance])

		
    		
    	}
    	

    	
    	
    	/*def newInd = false
    	if(params."acIssuedTo_id"==null||params."acIssuedTo_id".length()==0)
    		newInd = true
    	if (!newInd)
    		params."issuedTo.id"= params."acIssuedTo_id"
    	else
    		{
    		//create new individual first (as collector)
    		params."issuedTo.id" = housekeepingService.createCollector(params.acIssuedTo)
    		}

	if(params.issueDate)
		params.issueDate = Date.parse('dd-MM-yyyy', params.issueDate)
    	
    	def nextBatchId = housekeepingService.getMaxBatchId()
    	
		   
		    //params.batchId = nextBatchId
    
    	
        def receiptBookIssuedInstance = new ReceiptBookIssued(params)
        //def ok = receiptBookIssuedInstance.save(flush: true)
        def rangeFrom = ReceiptBook.get(params.receiptBook.id).bookSerialNumber

        //ReceiptBook.findById(params.receiptBook.id).status = "Issued"
        
        def numBooks =  new Integer(params.numBooks).intValue()
        def rbMultiIssue = ReceiptBook.executeQuery("Select id from ReceiptBook where category ='"+ params.receiptBook.category +"' and status = 'Blank'")
        def rangeFromId = params.receiptBook.id.toInteger()
        def rbIssueList = []
        
	for(int i=0; i<rbMultiIssue.size; i++)
	{
		if (rbMultiIssue[i] == rangeFromId)
		{
			for(int j=i; j<i+numBooks; j++)
			{
				params."receiptBook.id" = rbMultiIssue[j]
				ReceiptBook.findById(rbMultiIssue[j]).status = "Issued"
				params.batchId = nextBatchId

				receiptBookIssuedInstance = new ReceiptBookIssued(params)

				println 'receiptBookIssuedInstance='+receiptBookIssuedInstance
				if (receiptBookIssuedInstance.save(flush: true)) { 
					rbIssueList.add(receiptBookIssuedInstance.id)

				}
				else {
					render(view: "create", model: [receiptBookIssuedInstance: receiptBookIssuedInstance])
				}
			}
		}
	}
	if(rbIssueList.size() > 0)
        	flash.message = "${message(code: 'default.created.message', args: [message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued'), rbIssueList])}"
        redirect(action: "list", id: receiptBookIssuedInstance.id)*/
        
    }

    def show = {
        def receiptBookIssuedInstance = ReceiptBookIssued.get(params.id)
        if (!receiptBookIssuedInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued'), params.id])}"
            redirect(action: "list")
        }
        else {
        	println '--------------------show---------------------'
    		println 'show params='+params
    		println 'receiptBookIssuedInstance='+receiptBookIssuedInstance
    		println 'receiptBookIssuedInstance.id='+receiptBookIssuedInstance.id
    		
    		
            [id: receiptBookIssuedInstance.id, receiptBookIssuedInstance: receiptBookIssuedInstance]
        }
    }
    
    def issueacknowledgement = {
    		println 'issueacknowledgement params='+params
    		
    		//def ids = ReceiptBookIssued.executeQuery("Select id from ReceiptBookIssued where batch_id = "+params.id)
    		def ids = ReceiptBookIssued.findAllByBatchId(params.id)
    		println 'ids='+ids
    		def receiptBookIssuedInstance = ReceiptBookIssued.findByBatchId(params.id)
		println 'receiptBookIssuedInstance='+receiptBookIssuedInstance
		println 'IssuedTo='+receiptBookIssuedInstance.issuedTo.id

		def IssuerRoles = []
		def IssuerRole1, IssuerRole2
		IssuerRoles = IndividualRole.findAllByIndividualAndStatus(receiptBookIssuedInstance.issuedTo,"VALID")
		println 'IssuerRoles='+IssuerRoles


		for (int i=0; i<IssuerRoles.size(); i++)
		{

			println 'IssuerRoles[i]='+IssuerRoles[i]
			IssuerRole1 = IssuerRoles[i].toString().substring(IssuerRoles[i].toString().length()-4,IssuerRoles[i].toString().length())
			if (IssuerRole1 == "Guru")
				break
			println 'IssuerRole1='+IssuerRole1
			IssuerRole2 = IssuerRoles[i].toString().substring(IssuerRoles[i].toString().length()-10,IssuerRoles[i].toString().length())
			if (IssuerRole2 == "Councellor")
				break

			println 'IssuerRole2='+IssuerRole2
		}

		println 'receiptBookIssuedInstance.updator='+receiptBookIssuedInstance.updator
		def issuer = Individual.findByLoginid(receiptBookIssuedInstance.updator)
		println 'issuer='+ issuer
		def individual1Instance = Individual.get(receiptBookIssuedInstance.issuedTo.id)
		def relation = Relation.findByName("Councellee of")
		//println 'relation='+relation
		def councellorInstance 
		def councellorRelList = Relationship.findAllByIndividual1AndRelation(individual1Instance,relation)
		//println 'councellorRelList='+councellorRelList
		councellorRelList.each {i->
		if (!i.status || i.status =="ACTIVE")
		councellorInstance= i.individual2}
		println 'councellorInstance='+	councellorInstance		

		if (!receiptBookIssuedInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued'), params.batchId])}"
			redirect(action: "list")
		}
		else 
			[receiptBookIssuedInstance: receiptBookIssuedInstance, ids: ids, issuer: issuer, councellorInstance: councellorInstance, IssuerRole1: IssuerRole1, IssuerRole2: IssuerRole2]


		///[receiptBookIssuedInstance: receiptBookIssuedInstance, ids: ids]

    		//receiptBookIssuedInstance = ReceiptBookIssued.findById(ids[i])
    		
    		/*for (int i=0; i<ids.size; i++)
    		{

			//receiptBookIssuedInstance = ReceiptBookIssued.findById(ids[i])
			println 'receiptBookIssuedInstance='+receiptBookIssuedInstance
			println 'receiptBookIssuedInstance.creator='+receiptBookIssuedInstance.creator
			println 'receiptBookIssuedInstance.batchId='+receiptBookIssuedInstance.batchId
			println 'receiptBookIssuedInstance.issuedTo='+receiptBookIssuedInstance.issuedTo
			if (!receiptBookIssuedInstance) {
				flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued'), params.batchId])}"
				redirect(action: "list")
			}
			else {
				[receiptBookIssuedInstance: receiptBookIssuedInstance]
			}
		}*/
    }

    def returnacknowledgement = {
    	def receiptBookIssuedInstance = ReceiptBookIssued.findById(params.id)
    	[receiptBookIssuedInstance: receiptBookIssuedInstance]
    }


    def oldreturnacknowledgement = {
    		println '--------------------returnacknowledgement---------------------'
    		println 'returnacknowledgement params='+params
    		//println 'ReceiptBookIssued.id='+receiptBookIssuedInstance.ReceiptBookIssued
    		println 'params.id='+params.id
    		def receiptBookIssuedInstance = ReceiptBookIssued.findById(params.id)
			println 'receiptBookIssuedInstance='+receiptBookIssuedInstance
			println 'IssuedTo='+receiptBookIssuedInstance?.issuedTo?.id
			println 'receiptBookIssuedInstance.updator='+receiptBookIssuedInstance.updator
			def updator = Individual.findByLoginid(receiptBookIssuedInstance.updator)
			println 'updator='+ updator
		
    		def ReceiptBooksReturned = []
    		ReceiptBooksReturned = ReceiptBookIssued.findAllByIssuedToAndStatusNotEqual(receiptBookIssuedInstance.issuedTo, "Issued")
    		println '===ReceiptBooksReturned='+ReceiptBooksReturned
    		
    		//def rbNo = []
    		def AmountCollected = []
    		def SumAmountCollected = []
    		//def SumAmountCollected1
    		def amt = 0
    		def sumAmt = 0
    		def totalCollection = 0
    		
    		for(int i=0; i<ReceiptBooksReturned.size(); i++)
    		{
    			println 'ReceiptBooksReturned.receiptBook='+ReceiptBooksReturned[i].receiptBook
    			//rbNo[i] = ReceiptBooksReturned[i].receiptBook.bookSeries + ReceiptBooksReturned[i].receiptBook.bookSerialNumber
    			//println 'rbNo='+rbNo[i]
    			AmountCollected[i] = Donation.findAllByNvccReceiptBookNo(ReceiptBooksReturned[i].receiptBook.bookSeries + ReceiptBooksReturned[i].receiptBook.bookSerialNumber).amount
    			println 'AmountCollected='+AmountCollected[i]
    			SumAmountCollected[i] = 0.0
    			println 'AmountCollected[i].size()='+AmountCollected[i].size()
    			sumAmt = 0
    			for(int j=0; j<AmountCollected[i].size(); j++)
    			{
    				println 'FOR J'
    				amt = AmountCollected[i][j]
    				println 'amt='+amt
    				sumAmt = sumAmt.toLong() + amt.toLong()
    				println 'sumAmt='+sumAmt
    				SumAmountCollected[i] = sumAmt.toLong()
    			}
    			//SumAmountCollected1 = Donation.executeQyery("Select sum(amount) from Donation where nvcc_receipt_book_no = '"+rbNo[i]+"'")
    			println 'SumAmountCollected='+SumAmountCollected[i]
    			//println 'SumAmountCollected1='+SumAmountCollected1[i]
    			totalCollection = totalCollection + SumAmountCollected[i]
    			println 'totalCollection='+totalCollection
    		}
    		
		def IssuerRoles = []
		def IssuerRole1, IssuerRole2
		IssuerRoles = IndividualRole.findAllByIndividualAndStatus(receiptBookIssuedInstance.issuedTo,"VALID")
		println 'IssuerRoles='+IssuerRoles


		for (int i=0; i<IssuerRoles.size(); i++)
		{

			println 'IssuerRoles[i]='+IssuerRoles[i]
			IssuerRole1 = IssuerRoles[i].toString().substring(IssuerRoles[i].toString().length()-4,IssuerRoles[i].toString().length())
			if (IssuerRole1 == "Guru")
				break
			println 'IssuerRole1='+IssuerRole1
			IssuerRole2 = IssuerRoles[i].toString().substring(IssuerRoles[i].toString().length()-10,IssuerRoles[i].toString().length())
			if (IssuerRole2 == "Councellor")
				break

			println 'IssuerRole2='+IssuerRole2
		}


		def individual1Instance = Individual.get(receiptBookIssuedInstance.issuedTo.id)
		def relation = Relation.findByName("Councellee of")

		def councellorInstance 
		def councellorRelList = Relationship.findAllByIndividual1AndRelation(individual1Instance,relation)

		councellorRelList.each {i->
		if (!i.status || i.status =="ACTIVE")
		councellorInstance= i.individual2}

		def summaryCollection = housekeepingService.donationSummary((receiptBookIssuedInstance.issuedTo.id).toString())
		println 'amtCol='+summaryCollection.amtCol
		println 'amtColExclOwn='+summaryCollection.amtColExclOwn


		if (!receiptBookIssuedInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued'), params.batchId])}"
			redirect(action: "list")
		}
		else 
			[receiptBookIssuedInstance: receiptBookIssuedInstance, updator: updator, councellorInstance: councellorInstance, IssuerRole1: IssuerRole1, IssuerRole2: IssuerRole2, ReceiptBooksReturned: ReceiptBooksReturned, amtCol: summaryCollection.amtCol, amtColExclOwn: summaryCollection.amtColExclOwn, SumAmountCollected: SumAmountCollected, totalCollection: totalCollection]
			

    }


    def edit = {

        def receiptBookIssuedInstance = ReceiptBookIssued.get(params.id)
        if (!receiptBookIssuedInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [receiptBookIssuedInstance: receiptBookIssuedInstance]
        }
    }

    def update = {
        def receiptBookIssuedInstance = ReceiptBookIssued.get(params.id)
        if (receiptBookIssuedInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (receiptBookIssuedInstance.version > version) {
                    
                    receiptBookIssuedInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued')] as Object[], "Another user has updated this ReceiptBookIssued while you were editing")
                    render(view: "edit", model: [receiptBookIssuedInstance: receiptBookIssuedInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

		//if(params.issueDate)
		//	params.issueDate = Date.parse('dd-MM-yyyy', params.issueDate)

		if(params.returnDate)
			params.returnDate = Date.parse('dd-MM-yyyy', params.returnDate)
		println '--------------------update---------------------'
		println 'params='+params

		if(params.status == "Lost")
			receiptBookIssuedInstance.receiptBook.status = "Lost"
		if(params.status == "Filled" || params.status == "Partly Filled" || params.status == "Damaged" || params.status == "Faulty")
			receiptBookIssuedInstance.receiptBook.status = "Returned"
		if(params.status == "Blank")
			receiptBookIssuedInstance.receiptBook.status = "Blank"

		println '---------receiptBookIssuedInstance.receiptBook='+receiptBookIssuedInstance.receiptBook
		println 'receiptBookIssuedInstance.receiptBook.id='+receiptBookIssuedInstance.receiptBook.id
		println 'receiptBookIssuedInstance.receiptBook.status='+receiptBookIssuedInstance.receiptBook.status
			
            receiptBookIssuedInstance.properties = params
            println 'receiptBookIssuedInstance============'+receiptBookIssuedInstance
            if (!receiptBookIssuedInstance.hasErrors() && receiptBookIssuedInstance.save(flush: true)) {
                //flash.message = "${message(code: 'default.updated.message', args: [message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued'), receiptBookIssuedInstance.id])}"
                redirect(action: "returnacknowledgement", id: receiptBookIssuedInstance.id)
            }
            else {
                render(view: "edit", model: [receiptBookIssuedInstance: receiptBookIssuedInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued'), params.id])}"
            redirect(action: "list")
        }
    }

    def editCollectors = {
	println 'editCollectors params='+params

	//def ids = ReceiptBookIssued.executeQuery("Select id from ReceiptBookIssued where batch_id = "+params.id)
	def ids = ReceiptBookIssued.findAllByBatchId(params.id)
	println 'ids='+ids
        if (!ids) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [batchId: params.id, ids: ids]
        }
    }

    def updateCollectors = {
    	
    	println '-----------updateCollectors params='+params
    	def cnt = params."h_issuedTo.id".size() //params.cnt_i //
    	println 'cnt='+cnt
    	println 'params.cnt_i='+params.cnt_i
    	def flgsSavedArr = [0], flgSaved = 1, flgNewCollector = 0
    	def receiptBookIssuedInstance
    	println 'params.batchId='+params.batchId
	def ids = ReceiptBookIssued.findAllByBatchId(params.batchId)
	println 'ids.size()='+ids.size()
	cnt = ids.size()
	
    	def hasErrors = false
    	
    	for(int j=0; j<cnt; j++)
    	{
		if (params.("issuedToChkBox"+j))
		{
			if ((params.("issuedToChkBox"+j)).value.toString()=="on")
			{
				params.("issuedTo") = params.("h_issuedTo.id")[j]
			}
			else
			{
				if(!params.("acCollector"+j+"_id"))
				{
					flash.message = "Collector Name Not Entered!"
					//return [receiptBookIssuedInstance: receiptBookIssuedInstance]
				}
				else
				{
					params.issuedTo = Individual.get(params.("acCollector"+j+"_id"))
					println "params.issuedTo="+params.issuedTo
					flgNewCollector = 1
					println "flgNewCollector="+flgNewCollector
					
				}
			}
		}
		else
		{
			//println 'NO CHECKBOX'
			if(!params.("acCollector"+j+"_id"))
			{
				flash.message = "Collector Name Not Entered!"
				//render(view: "bulkdonation1")
				//return [receiptBookIssuedInstance: receiptBookIssuedInstance]
			}
			else
			{
				params.issuedTo = Individual.get(params.("acCollector"+j+"_id"))
				println "params.issuedTo="+params.issuedTo
				flgNewCollector = 1
				println "flgNewCollector="+flgNewCollector
			}
		}
		println "j="+j
		println "params.id+j="+params.("id"+j)
		println "params.issuedTo="+j+ " " +params.issuedTo
		
		
		
		if (flgNewCollector == 1)
		{
			receiptBookIssuedInstance = ReceiptBookIssued.get(params.("id"+j))
			println "receiptBookIssuedInstance="+receiptBookIssuedInstance
			receiptBookIssuedInstance.issuedTo = params.issuedTo

			if (springSecurityService.isLoggedIn()) {
				receiptBookIssuedInstance.updator=springSecurityService.principal.username
			}
			else
				receiptBookIssuedInstance.updator="unknown"

			receiptBookIssuedInstance.issueDate = new Date()

			println "receiptBookIssuedInstance="+receiptBookIssuedInstance

			if (receiptBookIssuedInstance.save(flush: true)) 
				flgsSavedArr[j] = 1
			else
			{	
				hasErrors = true
				errArr[j] = "Error in saving receiptBookIssuedInstance"
				receiptBookIssuedInstance.errors.allErrors.each {
					println "Error in saving receiptBookIssuedInstance Instance :"+it
					errArr[j] += it
				}
				if(hasErrors)
				{
					flash.message =  errArr
					println "errArr="+errArr
					//render(view: "editCollectors", model: [receiptBookIssuedInstance: receiptBookIssuedInstance])
				}
			}
			flgNewCollector = 0
        	}
    	}
    	for(int j=0; j<cnt; j++)
    		flgSaved = flgSaved && flgsSavedArr[j]
    	
    	//if (flgSaved == 1) 
    		redirect(action: "list")
        /*else 
        {	
		render(view: "editCollectors", model: [receiptBookIssuedInstance: receiptBookIssuedInstance])
        }*/
    }
    
    def delete = {
        def receiptBookIssuedInstance = ReceiptBookIssued.get(params.id)
        if (receiptBookIssuedInstance) {
            try {
                receiptBookIssuedInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued'), params.id])}"
            redirect(action: "list")
        }
    }
    
    def search = {
	println 'search params'+params
    def criteria = ReceiptBookIssued.createCriteria()
    def receiptBookIssuedList = criteria {
		and {
			if (params.sBatchId)
				eq('batchId',new Integer(params.sBatchId))
			if (params.sComments!=null && params.sComments.trim().length()>0)
				like("comments", "%"+params.sComments+"%")
			if (params.sBookNumber!=null && params.sBookNumber.trim().length()>0)
			{
				receiptBook {
				    eq('bookSerialNumber',new Integer(params.sBookNumber))
				    //like("receiptBook", "%"+params.sReceiptBook+"%")
				}
			}
			if (params.sBookSeries)
			{
				receiptBook {
				    eq('bookSeries',params.sBookSeries)
				    //like("receiptBook", "%"+params.sReceiptBook+"%")
				}
			}
			/*if (params.sReceiptBook!=null && params.sReceiptBook.trim().length()>0)
			{
			receiptBook {
				def RB = []
				def i,j,k,l
				RB = (params.sReceiptBook).toString()
				def BS = ""
				def BSN = ""
				for(i=RB.size()-1; i > -1; i--)
				{

					if((RB[i]).isNumber())
					{}
					else
						break;
				}
				for(j=0; j<=i; j++)
					BS += RB[j]

				for(k=(i+1); k<RB.size(); k++)
					BSN += RB[k]

				def rblist =  ReceiptBook.findAllByBookSeriesAndBookSerialNumber(BS,BSN)

				}
			}*/

			/*if (params.sCollector!=null && params.sCollector.trim().length()>0)
			{
			issuedTo {
			    like('legalName','%'+params.sCollector+'%')
			}
			}*/

			if (params.acCollector!=null && params.acCollector.trim().length()>0)
			{
			  or{
				    issuedTo {
					like('legalName','%'+params.acCollector+'%')
				    }
				    issuedTo {
					like('initiatedName','%'+params.acCollector+'%')
				    }

			    }


			}			    
			}
		}
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
       		 	
	render(view: "list", model: [receiptBookIssuedInstanceList: receiptBookIssuedList, receiptBookIssuedInstanceTotal: receiptBookIssuedList.size()])

    }
    
    def ajaxGetCollector = {
	def rb = ReceiptBook.get(params.id)
	def rbis = ReceiptBookIssued.findByReceiptBook(rb,[sort:"issueDate",order:"desc"])
	render rbis as JSON
    }
    
    def status() {}
    
    def jq_status_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = ReceiptBook.createCriteria().list(max:maxRows, offset:rowOffset) {
		if (params.bookSeries)
			eq('bookSeries',params.bookSeries)
		if (params.bookSerialNumber)
			eq('bookSerialNumber',new Integer(params.bookSerialNumber))
		if (params.status)
			eq('status',params.status)

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

	def donations = []
      def jsonCells = result.collect {
      		donations = Donation.createCriteria().list{donationReceipt{eq('receiptBook',it)}}
      		
            [cell: [
            	    it.bookSeries,
            	    it.bookSerialNumber,
            	    ReceiptBookIssued.findByReceiptBook(it)?.issuedTo?.toString(),
			donations.size(),
			donations.collect{it.amount}.sum(),
			it.status,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def downloadRBIssuedData() {
    	response.contentType = 'application/zip'
    	def query = "select clorid,counsellor,familyof,indid cleeid,name clee,rb.book_series,book_serial_number,date_format(rbi.issue_date,'%d-%m-%Y') issue_date from individual_summary isum,receipt_book_issued rbi,receipt_book rb where rbi.receipt_book_id=rb.id and isum.indid=rbi.issued_to_id and rbi.status='Issued' and isum.clorid is not null and clorid in (select distinct individual_id from individual_role where status='VALID' and role_id in (select id from role where name in ('PuneEnglishCouncellors','PuneHindiCouncellors'))) order by counsellor,familyof,name"
    	def sql = new Sql(dataSource)
    	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		def fileName = "rbissued_"+new Date().format('ddMMyyyyHHmmss')+".csv"
		zipOutputStream.putNextEntry(new ZipEntry(fileName))
		//header
		def headers = null;

		sql.rows(query).each{ row ->
			   if (headers == null) {
				headers = row.keySet()
				zipOutputStream << headers
			        zipOutputStream << "\n"
			   }
			//with escaping for excel
			zipOutputStream << row.values().collect{it.toString()}
			zipOutputStream << "\n"
		}
	}    	    	
    }
}