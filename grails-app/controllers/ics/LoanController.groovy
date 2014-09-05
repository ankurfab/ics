package ics
import groovy.time.*

class LoanController {

    def springSecurityService
	def housekeepingService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        println '----- Loan list-----'
        println "Params: "+params
		def loanInstanceTotal
		if (params.status)
		{
			if (params.status == "PENDING")
			{
				def pendingLoanList = []
				pendingLoanList = Loan.findAllByStatus('PENDING')
				def totalAmt = 0
				for(int i=0; i<pendingLoanList.size(); i++)
					totalAmt = totalAmt + pendingLoanList.amount[i]
				params.max = Math.min(params.max ? params.int('max') : 100, 100)
				println "loanInstanceTotal: "+pendingLoanList.size()
				println "pendingLoanList: "+pendingLoanList
				return [loanInstanceList: Loan.list(params), loanInstanceTotal: pendingLoanList.size(), pendingLoanList: pendingLoanList, totalAmt: totalAmt]
				
			}
			if (params.status == "SUBMITTED")
			{
				def submittedLoanList = []
				submittedLoanList = Loan.findAllByStatus('SUBMITTED')
				def totalAmt = 0
				for(int i=0; i<submittedLoanList.size(); i++)
					totalAmt = totalAmt + submittedLoanList.amount[i]
				params.max = Math.min(params.max ? params.int('max') : 100, 100)
				println "loanInstanceTotal: "+submittedLoanList.size()
				println "submittedLoanList: "+submittedLoanList
				return [loanInstanceList: Loan.list(params), loanInstanceTotal: submittedLoanList.size(), submittedLoanList: submittedLoanList, totalAmt: totalAmt]
				
			}
			if (params.status == "ACCEPTED")
			{
				def acceptedLoanList = []
				acceptedLoanList = Loan.findAllByStatus('ACCEPTED')
				def totalAmt = 0
				def totalFDAmt = 0
				for(int i=0; i<acceptedLoanList.size(); i++)
				{
					totalAmt = totalAmt + acceptedLoanList.amount[i]
					if(acceptedLoanList.fdNumber[i]!=null)
						totalFDAmt = totalFDAmt + acceptedLoanList.amount[i].toInteger() / 2
				}
				params.max = Math.min(params.max ? params.int('max') : 100, 100)
				println "loanInstanceTotal: "+acceptedLoanList.size()
				println "acceptedLoanList: "+acceptedLoanList
				
				return [loanInstanceList: Loan.list(params), loanInstanceTotal: acceptedLoanList.size(), acceptedLoanList: acceptedLoanList, totalAmt: totalAmt, totalFDAmt: totalFDAmt]
				
			}
			
		}
		else
		{
						
			params.max = Math.min(params.max ? params.int('max') : 100, 100)
			println "loanInstanceTotal: "+Loan.count()
			def allList = "allList"
			def totalAmt = Loan.executeQuery("Select sum(amount) from Loan")
			def totalAmtFD = Loan.executeQuery("Select sum(amount) from Loan where fd_number is not null")
			def totalFDAmt
			if(totalAmtFD[0]!=0 && totalAmtFD[0]!=null)
				totalFDAmt = totalAmtFD[0]/2
			println "totalAmt="+totalAmt
			return [loanInstanceList: Loan.list(params), loanInstanceTotal: Loan.count(), allList: allList, totalAmt: totalAmt[0], totalFDAmt: totalFDAmt]
        }
    }



    def create0 = {
        //def loanInstance = new Loan()
        //loanInstance.properties = params
        println '-------- Loan create0 --------'
        println "Params: "+params
        return
        //return [loanInstance: loanInstance]
    }

    def create1 = {
        //def loanInstance = new Loan()
        //loanInstance.properties = params
        println '-------- Loan create1 --------'
        println "Params: "+params
        //println "loanInstance="+loanInstance
        println 'params."acIndividual_id"='+params."acIndividual_id"
        def councellor, councellorId
		if (params.acIndividual)
		{
			def ind = Individual.get(params."acIndividual_id")
			if (!ind)
				render(controller:"individual", view:"create", model:[indivdual:new Individual(legalName:params."acIndividual")])
			else
			{
				def rel = Relation.findByName("Councellee of")
				println 'rel='+rel
				def reln = []
				reln = Relationship.findAllByIndividual1AndRelation(ind,rel)
				println 'reln='+reln
				println 'reln.status='+reln.status
				println 'reln.individual2 ='+reln.individual2.toString()
				for(int i=0; i<reln.size(); i++)
				{
					println 'reln.status='+reln.status
					if (reln.status[i] == "ACTIVE")
					{
						println 'reln.individual2 ='+reln.individual2[i].toString()
						councellor = reln.individual2[i].toString()
						councellorId = reln.individual2[i].id
						break
					}
				}
			}
			if(councellor == '' || councellor ==null)
			{
				def IndRoles = []
				def IndRole
				IndRoles = IndividualRole.findAllByIndividualAndStatus(ind,"VALID")
				println 'IndRoles='+IndRoles


				for (int i=0; i<IndRoles.size(); i++)
				{
					println 'IndRoles[i]='+IndRoles[i]
					IndRole = IndRoles[i].toString().substring(IndRoles[i].toString().length()-4,IndRoles[i].toString().length())
					if (IndRole == "Guru")
					{
						councellor = ind
						councellorId = ind.id
						break
					}
					else
					{
						IndRole = IndRoles[i].toString().substring(IndRoles[i].toString().length()-10,IndRoles[i].toString().length())
						if (IndRole == "Councellor")
						{
							councellor = ind
							councellorId = ind.id
							break
						}
					}
					println 'IndRole='+IndRole
				}
			}
			
			println 'councellor='+councellor
			println 'councellorId='+councellorId
		}

		//	render(view:"create1",model:[loanedById: params."acIndividual_id"])
        return [loanedBy: params."acIndividual", loanedById: params."acIndividual_id", councellor: councellor, councellorId: councellorId]
    }
    
    def create2 = {
        //def loanInstance = new Loan()
        //loanInstance.properties = params
        println '-------- Loan create2 --------'
        println "Params: "+params
        def councellor, councellorId
        councellor = params.councellor
        councellorId = params.councellorId
        def reference2 = Individual.get((params.reference2_id).toInteger())
        if(councellor == '' || councellor == null)
        {
        	councellor = params.acWitness1
        	councellorId = params."acWitness1_id"
        }
        def individualInstance = Individual.get(params.loanedById)
        println 'individualInstance.relative1='+individualInstance.relative1
        println 'individualInstance.relative2='+individualInstance.relative2
        println 'individualInstance.nvccRelation='+individualInstance.nvccRelation
        def familyHead
        if (individualInstance.relative2.size() == 0 && individualInstance.nvccRelation != "" && individualInstance.nvccRelation != null) //individual has family but is not head of family
        {
        	familyHead = (Relationship.findAllByRelationAndIndividual1(Relation.findByName(individualInstance.nvccRelation), individualInstance)).individual2
        	
        	println 'familyHead='+familyHead
        	familyHead = familyHead[0]
        }
        
        return [individualInstance:individualInstance, loanedBy: params.loanedBy, loanedById: params.loanedById, familyHead: familyHead, councellor: councellor, councellorId: councellorId, reference2Id: params.reference2_id, reference2: reference2, selection:params.selection]
        
    }
    
    def create3 = {

        println '-------- Loan create3 --------'
        println "Params: "+params
        
        def councellor = params.councellor
        def councellorId = params.councellorId
        if(councellor == '' || councellor == null)
        {
        	councellor = params.acWitness1
        	councellorId = params."acWitness1_id"
        }
        
        def reference2 = Individual.get(params.reference2.id)
        def paymentModeList = PaymentMode.findAllByNameNotEqualAndNameNotEqual('Direct-Kind','Direct-Complementary')
        def panNo = Individual.get(params.loanedById).panNo
        println "paymentModeList: "+paymentModeList
        return [loanedBy: params.loanedBy, loanedById: params.loanedById, councellorId: councellorId, councellor: councellor, reference2Id: params.reference2.id, nomineeId: params.nomineeId, reference2: reference2, nominee: params.nominee, fatherOrSpouse:params.fatherOrSpouse, nomineeRelation:params.nomineeRelation, panNo: panNo, paymentModeList: paymentModeList]
    }
    
    

    def save = {
        println '-------- Loan save --------'
        params.loanedBy = Individual.get(params.loanedById)
        params.reference1= Individual.get(params.councellorId)
        params.reference2= Individual.get(params.reference2Id)
        //params.nominee = Individual.get(params.nomineeId)
        
	if(params.loanDate)
		params.loanDate = Date.parse('dd-MM-yyyy', params.loanDate)
	if(params.chequeDate)
		params.chequeDate = Date.parse('dd-MM-yyyy', params.chequeDate)
	/*if(params.loanStartDate)
	{

		params.loanStartDate = Date.parse('dd-MM-yyyy', params.loanStartDate)
		def startDate = new Date()
		startDate = params.loanStartDate
		println 'startDate='+startDate
		def endDate = new Date()
		endDate = startDate + 1825 // for 5 years -> 365 * 5 = 1825
		println 'endDate='+endDate
		params.loanEndDate = endDate

	}*/
	/*if(params.loanEndDate)
		params.loanEndDate = Date.parse('dd-MM-yyyy', params.loanEndDate)*/
		
	//println 'end date='+Date.parse('dd-MM-yyyy', params.loanStartDate.year+5)
	params.status = "PENDING"
	println 'params.status='+params.status
	println 'params.mode.id='+params.mode.id
	def modeId = PaymentMode.executeQuery("Select distinct id from PaymentMode where name = '"+params.mode.id+"'") //(PaymentMode.FindByName(params.mode.id)).id
	println 'modeId='+modeId[0]
	params."mode.id" = modeId[0].toInteger()
	println 'params.mode.id='+params.mode.id
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

	println 'params = '+params
	//Individual.executeUpdate("Update Individual set pan_no = '"+params.panNo+"' where id='"+ params.loanedById +"'")
        def loanInstance = new Loan(params)
        println 'loanInstance='+loanInstance
        if (loanInstance.save(flush: true)) {
        	Individual.executeUpdate("Update Individual set pan_no = '"+params.panNo+"' where id='"+ params.loanedById +"'")
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'loan.label', default: 'Loan'), loanInstance.id])}"
            redirect(action: "show", id: loanInstance.id)
        }
        else {
            render(view: "create3", model: [loanInstance: loanInstance])
        }
    }

    def show = {
        def loanInstance = Loan.get(params.id)
        if (!loanInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'loan.label', default: 'Loan'), params.id])}"
            redirect(action: "list")
        }
        else {
            [loanInstance: loanInstance]
        }
    }

    def edit = {
        def loanInstance = Loan.get(params.id)
        println '-------- Loan edit --------'
        println "Params: "+params
        def toBeSubmitted = params.toBeSubmitted
        if (!loanInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'loan.label', default: 'Loan'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [loanInstance: loanInstance, toBeSubmitted: toBeSubmitted]
        }
    }

    def update = {
        def loanInstance = Loan.get(params.id)
        if (loanInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (loanInstance.version > version) {
                    
                    loanInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'loan.label', default: 'Loan')] as Object[], "Another user has updated this Loan while you were editing")
                    render(view: "edit", model: [loanInstance: loanInstance])
                    return
                }
            }
	if(params.loanDate)
		params.loanDate = Date.parse('dd-MM-yyyy', params.loanDate)
	if(params.chequeDate)
		params.chequeDate = Date.parse('dd-MM-yyyy', params.chequeDate)
	if(params.loanStartDate)
		params.loanStartDate = Date.parse('dd-MM-yyyy', params.loanStartDate)
	if(params.loanEndDate)
		params.loanEndDate = Date.parse('dd-MM-yyyy', params.loanEndDate)
		
	if (params.toSubmit == '1')
		params.status = "SUBMITTED"
		
        println '-------- Loan update --------'
        println "params.status: "+params.status
        println "Params: "+params            
            loanInstance.properties = params
            if (!loanInstance.hasErrors() && loanInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'loan.label', default: 'Loan'), loanInstance.id])}"
                redirect(action: "show", id: loanInstance.id)
            }
            else {
                render(view: "edit", model: [loanInstance: loanInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'loan.label', default: 'Loan'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def loanInstance = Loan.get(params.id)
        if (loanInstance) {
            try {
                //loanInstance.delete(flush: true)
                Loan.executeUpdate("Update Loan set status = 'INVALID' where id = '"+params.id+"'")
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'loan.label', default: 'Loan'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'loan.label', default: 'Loan'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'loan.label', default: 'Loan'), params.id])}"
            redirect(action: "list")
        }
    }
    
    def submitselectedloans = {
    	//def ret=Loan.executeUpdate("Update Loan set status = 'SUBMITTED' where status = 'PENDING'")
    	println '-------- Loan submitselectedloans --------'
        println "Params: "+params
        println 'params.loanIds='+params.loanIds.size() 
        println 'params.toSubmit='+params.toSubmit 
        if(params.toSubmit==null)
        //if(params.loanIds.size()==0)
        {
			def pendingLoanList = []
			pendingLoanList = Loan.findAllByStatus('PENDING')
			params.max = Math.min(params.max ? params.int('max') : 200, 100)
			println "loanInstanceTotal: "+pendingLoanList.size()
			println "pendingLoanList: "+pendingLoanList   

			redirect(action: "list", params: [loanInstanceList: Loan.list(params),loanInstanceTotal: pendingLoanList.size(),pendingLoanList: pendingLoanList] )
        	
        }
        
        else
        {
        	for(int i=0; i<params.toSubmit.size(); i++)
        	{
        		Loan.executeUpdate("Update Loan set status = 'SUBMITTED' where id = '"+params.toSubmit[i]+"'")
        	}
	    	redirect(action: "list")
	    	
	    }
    }
    
    def acceptselectedloans = {
    	//def ret=Loan.executeUpdate("Update Loan set status = 'SUBMITTED' where status = 'PENDING'")
    	println '-------- Loan acceptselectedloans --------'
        println "Params: "+params
        /*println 'params.loanIds='+params.loanIds.size() 
        println 'params.toAccept='+params.toAccept 
        if(params.toAccept==null)
        if(params.loanIds.size()==0)
        {
			def submittedLoanList = []
			submittedLoanList = Loan.findAllByStatus('SUBMITTED')
			params.max = Math.min(params.max ? params.int('max') : 200, 100)
			println "loanInstanceTotal: "+submittedLoanList.size()
			println "submittedLoanList: "+submittedLoanList   
			
			redirect(action: "list", params: [loanInstanceList: Loan.list(params),loanInstanceTotal: submittedLoanList.size(),submittedLoanList: submittedLoanList] )
        	
        }
        
        else
        {*/
        	def nextLotId = housekeepingService.getNextLotIdForLoan()
        	
        	//for(int i=0; i<params.toAccept.size(); i++)
        	//{
        		Loan.executeUpdate("Update Loan set status = 'ACCEPTED', lot_id= "+ nextLotId +" where status = 'SUBMITTED'")
        	//}
	    	redirect(action: "list")
	    	
	    //}
    }
    
    def assignfdnumber = {
    
    	def lotForFD = Loan.executeQuery("Select distinct lotId from Loan where fd_number is null and status = 'ACCEPTED' order by lotId")
    	println '-------- Loan assignfdnumber --------'
    	println 'lotForFD='+lotForFD
    	return [lotForFD: lotForFD]
    }
    
    def assignfdnumbertolot = {
    
    	println '-------- Loan assignfdnumbertolot --------'
    	println 'params='+params
    
    	def loan = Loan.findAllByLotId(params.lotId)
    	println 'loan='+loan
	    /*def loan = Loan.get(params.id)*/
    	
		if(params.loanStartDate)
			params.loanStartDate = Date.parse('dd-MM-yyyy', params.loanStartDate)
		if(params.loanEndDate)
			params.loanEndDate = Date.parse('dd-MM-yyyy', params.loanEndDate)
		println 'params='+params			
		for(int i=0; i<loan.size(); i++)
		{
			loan[i].fdNumber = params.fdNumber	
			println 'loan[i].fdNumber='+loan[i].fdNumber
			loan[i].loanStartDate = params.loanStartDate	
			loan[i].loanEndDate = params.loanEndDate	
			println 'loan[i]='+loan[i]
			
			println 'loan[i].loanStartDate='+loan[i].loanStartDate
			println 'loan[i].loanEndDate='+loan[i].loanEndDate
			//loan[i].save(flush: true)
			println 'err='+loan[i].hasErrors()
			println 'loan[i].id='+loan[i].id
			def loanInstance = Loan.get(loan[i].id)
			loanInstance.properties = params
			println 'loanInstance='+loanInstance
			loanInstance.fdNumber = params.fdNumber	
			loanInstance.loanStartDate = params.loanStartDate	
			loanInstance.loanEndDate = params.loanEndDate
			println 'loanInstance.fdNumber='+loanInstance.fdNumber
			println 'loanInstance.loanStartDate='+loanInstance.loanStartDate
			println 'loanInstance.loanEndDate='+loanInstance.loanEndDate
			println 'save= '+loanInstance.save(flush: true)
			if (!loanInstance.hasErrors() && loanInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'loan.label', default: 'Loan'), loanInstance.id])}"
				//println loanInstance+' saved successfully'
				//redirect(action: "list")
			}
				
		}
		redirect(action: "list")
		/*else {
			render(view: "edit", model: [loanInstance: loanInstance])
		}*/
    	
    	/*Loan.executeUpdate("Update Loan set fd_number = '"+params.fdNumber+"', loan_start_date='"+ params.loanStartDate +"', loan_end_date='"+ params.loanEndDate +"' where lotId="+params.lotId)
    	redirect(action: "list")*/
    }
}
