package ics
import com.krishna.*;
import groovy.sql.Sql;
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class FinanceService {

    def springSecurityService
    def dataSource
    def helperService
    def housekeepingService
    def receiptSequenceService
    def commsService
    def individualService
    
    def serviceMethod() {

    }

    def expenseSummaryData() 
    {
    		def result
    		def numUsers=0
    		result = Expense.createCriteria().list {
    						projections {
    							count('raisedBy')
    						}
    					}
    		log.debug("expenseSummaryData: "+result)
    
    		
    		return [['Count',result[0]?:0]]
	}
    
    //find out quaterly income/expenses for cost centers and store in AV
    //params->year=2014
    def populateStats(Map params) {
    	def year = params.year?:(new Date().format('yyyy'))
    	year = new Integer(year)
    	def start,end,ts='-01 00:00:00'
    	
    	//for 1st 8 months, Apr-Nov
    	for(Integer month=4;month<12;month++) {
		if(month<10)
			start = year+'-0'+month+'-01 00:00:00'
		else
			start = year+'-'+month+'-01 00:00:00'
		if((month+1)<10)
			end = year+'-0'+(month+1)+'-01 00:00:00'
		else
			end = year+'-'+(month+1)+'-01 00:00:00'
		populateStats((''+year),(month-3),start,end)
    	}
    	
    	//for Dec
    	start = year+'-12-01 00:00:00'
    	end = (year+1)+'-01-01 00:00:00'
    	populateStats((''+year),9,start,end)
    	

    	//for last 3 months, Jan-Mar
    	for(Integer month=1;month<4;month++) {
		start = (year+1)+'-0'+month+'-01 00:00:00'
		end = (year+1)+'-0'+(month+1)+'-01 00:00:00'
		populateStats((''+year),(month+9),start,end)
    	}
    	
    	return "OK"
    }
    
    def populateStats(String year, Integer pos, String start,String end) {
	def sql = new Sql(dataSource)

	def queryIncome="select cc.id ccid,sum(amount) amount from donation d, scheme s, cost_center cc where d.scheme_id=s.id and s.cc_id=cc.id and d.fund_receipt_date>='"+start+"' and d.fund_receipt_date<'"+end+"' group by cc.id"
	log.debug(queryIncome)
	def queryIncomeResults = sql.rows(queryIncome)
	log.debug(queryIncomeResults)
	storeStats(queryIncomeResults, 'Income_Actual', year, pos)

	def queryExpense="SELECT department_code_id ccid,(sum(amount) - sum(amount_settled)) amount FROM voucher v where voucher_date>='"+start+"' and voucher_date<'"+end+"' group by department_code_id"
	log.debug(queryExpense)
	def queryExpenseResults = sql.rows(queryExpense)
	log.debug(queryExpenseResults)
	storeStats(queryExpenseResults, 'Expense_Actual', year, pos)

	sql.close()

	return "OK"
    }
    
    def createStatsAttributesForCostCenter(CostCenter cc, String year) {
    	//first check whether already created??
    	def numAttr = Attribute.countByDomainClassNameAndDomainClassAttributeNameAndCategory('CostCenter',cc.id.toString(),year)
    	log.debug("createStatsAttributesForCostCenter found "+numAttr+" "+cc+" "+year);
    	if(numAttr && numAttr>0) {
    		log.debug("createStatsAttributesForCostCenter skipping creation for "+cc);
    		return;
    	}
    	
    	def attribute
    	def typeList = ['Income_Actual','Expense_Actual','Income_Projected','Expense_Projected']
	for(int q=1;q<13;q++) {	//for 12 months
		typeList.each { type->
			//for income and expense
			attribute = new Attribute()
			attribute.domainClassName='CostCenter'
			attribute.domainClassAttributeName=cc.id	//id of the object
			attribute.category=year	//financial year
			attribute.type=type
			attribute.name='amount'
			attribute.displayName='Amount'
			attribute.position=q	//month
			if(!attribute.save()) {
			    attribute.errors.allErrors.each {
					log.debug("createStatsAttributesForCostCenter:Exception in saving attr"+it)
				    }
			}
		}
	}
	return true    	
    }
    
    def lockExpenseCreation() {
    	def lockAttr = null, attributeValue = null
    	lockAttr = Attribute.findByDomainClassNameAndDomainClassAttributeNameAndCategory('CostCenter','ExpenseCreation','Lock')
    	if(!lockAttr) {
		lockAttr = new Attribute()
		lockAttr.domainClassName='CostCenter'
		lockAttr.domainClassAttributeName='ExpenseCreation'
		lockAttr.name='ExpenseCreation'
		lockAttr.category='Lock'
		if(!lockAttr.save()) {
		    lockAttr.errors.allErrors.each {
				log.debug("lockAttr:Exception in saving attr"+it)
			    }
		}
		else {
			//create the av
			attributeValue = new AttributeValue()			
			attributeValue.attribute  = lockAttr
			attributeValue.objectClassName = lockAttr.domainClassName
			attributeValue.objectId = lockAttr.id
			attributeValue.value = ''
			attributeValue.creator = 'system'
			attributeValue.updator = 'system'
			if(!attributeValue.save())
			    attributeValue.errors.allErrors.each {
					log.debug("lockExpenseCreation:Exception in saving attrv"+it)
				    }			
		}
    	}
    	else
		attributeValue = AttributeValue.findByObjectClassNameAndAttribute(lockAttr.domainClassName,lockAttr)

	attributeValue.value = 'LOCKED'
	attributeValue.updator = 'system'
	if(!attributeValue.save())
	    attributeValue.errors.allErrors.each {
			log.debug("lockExpenseCreation:Exception in saving attrv"+it)
		    }
    	
    	return true    	
    }

    def unlockExpenseCreation() {
    	def attr = Attribute.findByDomainClassNameAndDomainClassAttributeNameAndCategory('CostCenter','ExpenseCreation','Lock')
	def attributeValue = AttributeValue.findByObjectClassNameAndAttribute(attr.domainClassName,attr)
	attributeValue.value = 'UNLOCKED'
	if(!attributeValue.save())
	    attributeValue.errors.allErrors.each {
			log.debug("unlockExpenseCreation:Exception in saving attrv"+it)
		    }
    	
    	return true    	
    }
    
    def checkExpenseCreationLock() {
    	def attr = Attribute.findByDomainClassNameAndDomainClassAttributeNameAndCategory('CostCenter','ExpenseCreation','Lock')
	def attributeValue = AttributeValue.findByObjectClassNameAndAttribute(attr?.domainClassName,attr)
	if(attributeValue)
		return attributeValue.value
	else
		return ''
    }

    def createStatsAttributes(Map params) {
    	if(params.cc)
    		createStatsAttributesForCostCenter(params.cc,params.year)
    	else
		CostCenter.findAllByStatusIsNull().each{
			createStatsAttributesForCostCenter(it,params.year)
		}
    }

    def resetStatsAttributes(Map params) {
    	//1st remove every thing
    	/*def attrs = Attribute.findAllByDomainClassNameAndCategory('CostCenter',params.year)
    	attrs.each{
    		//1st delete all the AV
    		AttributeValue.findByAttribute(it)?.delete()
    		
    		//then delete Attribute
    		it.delete()
    	}*/
	def sql = new Sql(dataSource)

	def queryDeleteAV="delete from attribute_value where attribute_id in (select id from attribute where domain_class_name='CostCenter' and category='"+params.year+"')"
	sql.execute(queryDeleteAV)
    	
	def queryDeleteA="delete from attribute where domain_class_name='CostCenter' and category='"+params.year+"'"
	sql.execute(queryDeleteA)
	
	sql.close()


	//then create afresh
    	createStatsAttributes(params)
    	populateStats(params)
    	return "Stats reset for year "+params.year+" !!"
    }
	
	def checkUploadValidityOfCC (String ccId) {
		Boolean bRet = false
		def result = AttributeValue.createCriteria().list() {
			eq('objectClassName','CostCenter')
			eq('objectId',new Long(ccId))
			attribute{eq('name','BudgetAuditTrail')}
			attribute{eq('type','InitialBudgetUploadAuditTrail')}
			order('id', 'desc')
		}
		if (0 == result.size())
			bRet = true
		return bRet
	}

    def uploadCurrentBudget(Object tokens) {
    	//tokens as per download csv format
    	//ccId,amount
		try{
    		log.debug("uploadCurrentBudget..processing ccid:"+tokens[0])
    		def cc = CostCenter.get(tokens[0])
    		if(!cc || !tokens[1]) {
    			log.debug("uploadCurrentBudget..got null ccid:"+tokens[0])
    			return false
    		}
    		if(cc.isProfitCenter) {
    			log.debug("uploadCurrentBudget..got profit centre ccid:"+tokens[0])
    			return false
    		}
			def bValidToUpload = checkUploadValidityOfCC(tokens[0])
    		if(true == bValidToUpload) {
				def amount = new BigDecimal(tokens[1])

				def oldBalance = cc.balance?:0
				cc.balance = (Project.findAllByCostCenterAndStatusInList(cc,['APPROVED_REPORT','SUBMITTED_REPORT','DRAFT_REPORT','APPROVED_REQUEST','SUBMITTED_REQUEST','ESCALATED_REQUEST'])?.sum{it.amount})?:0

				def oldBudget = cc.budget?:0
				cc.budget = amount + cc.balance	//carry forward from last month
				
				if(!cc.save())
					cc.errors.allErrors.each {log.debug("uploadCurrentBudget:exception in setting budget:"+it)}    	
				else {
					def curDate = new Date()
					curDate.format('dd-MM-yyyy')
					def value = "Old budget was = "+oldBudget+" , new budget is = "+cc.budget+" , upload date is "+curDate
					addBudgetAuditTrail(cc.id, 'BudgetAuditTrail', 'InitialBudgetUploadAuditTrail', value)
				}
			}
			else {
				log.debug("Budget has already been uploaded once for this cost center!!!")
				return false
			}
		}
    	catch(Exception e){
    		log.debug("Exception in uploadCurrentBudget:"+tokens[0]+":"+e)
    		return false
    	}
    	
    	return true

    }
    
    def uploadBudget(String year, Object tokens) {
    	//tokens as per download csv format
    	//ccId,ccCode,costcategory,costcenter,vertical,isProfitCenter,isServiceCenter,type,month,amount
    	def results = []
    	def result = [:]
    	result.ccid = tokens[0]
    	def type = tokens[7]
    	def month = new Integer(tokens[8])    	
    	def pos = 0
    	if(month<4)
    		pos = month + 9
    	else
    		pos = month -3
    	result.amount = new BigDecimal(tokens[9])
    	results.add(result)
    	
    	storeStats(results,type,year,pos)

    	//update budget for current month
    	def currMonth = new Integer(new Date().format('MM'))    	
    	if(type=="Expense_Projected" && currMonth==month) {
    		def cc = CostCenter.get(result.ccid)
    		if(cc) {
    			log.debug("Updating budget for cc:"+cc+" Old budget:"+cc.budget+" New budget:"+result.amount)
    			cc.budget = result.amount
    			if(!cc.save())
			    cc.errors.allErrors.each {
					log.debug("Exception in updating cc budget"+it)
				    }
    				
    		}
    	}
    	
    	return true

    }
    
    
    
    def storeStats(Object results, String type, String year, Integer pos) {
    	def attr,attributeValue
    	results.each{result->
    		log.debug("storing for:"+result)
    		attr = Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:result.ccid?.toString(),category:year,type:type,position:pos)
    		log.debug("got attr:"+(attr?:'')+" year"+year+" type:"+type+" pos:"+pos)
		if(attr && result.amount) {
			attributeValue = AttributeValue.findByObjectClassNameAndObjectIdAndAttribute(attr.domainClassName,new Long(attr.domainClassAttributeName),attr)
			if(!attributeValue) {				
				attributeValue = new AttributeValue()			
				attributeValue.attribute  = attr
				attributeValue.objectClassName = attr.domainClassName
				attributeValue.objectId = new Long(attr.domainClassAttributeName)
				attributeValue.creator = 'system'
				}
			attributeValue.value = result.amount
			attributeValue.updator = 'system'
			if(!attributeValue.save()) {
			    attributeValue.errors.allErrors.each {
					log.debug("storeStats:Exception in saving attrv"+it)
				    }
			}
		}
		else
			log.debug(attr?"Amount null!!":"Attribute not found")
    	}
    }
    
    def saveProject(Map params) {
        log.debug("saveProject:"+params)
        
        def username = ''
        try{
        username = springSecurityService.principal.username
        }
        catch(Exception e){username='unknown'}
        params.updator = params.creator = username
        
        if(!params.submitter)
	        params.submitter = CostCenter.findByOwnerAndStatusIsNull(Individual.findByLoginid(username))?.owner1
        if(!params.submitter)
        	return [message:"INVALID USER",state:"INVALID",projectInstance:null,balCheck:[]]
        	
        params.submitDate = new Date()

        def message,state
        
        params.status = params.submitStatus
        
        if(params.billDate) {
        		try { params.billDate = Date.parse('dd-MM-yyyy', params.billDate) } catch(Exception e){log.debug(e)}
        	}
        
        //massage the advance details params
        
        
        if(params.advanceIssuedToName) {
        	def vendor
        	if(params.vendorid)
        		vendor = Individual.get(params.vendorid)
        	else
        		vendor = Individual.findByCategoryAndLegalName('EMS_VENDOR',params.advanceIssuedToName)
        	if(!vendor)
        		vendor = individualService.createBasicIndividual([name:params.advanceIssuedToName,category:'EMS_VENDOR'])
        	params.advanceIssuedTo = vendor
        }
        
        if(params.advancePaymentModeName) {
        	params.advancePaymentMode = PaymentMode.get(params.advancePaymentModeName)
        }

        def projectInstance
        if (!params.id)
        	projectInstance = new Project(params)
        else {
        	try{
        		projectInstance = Project.get(params.id)
        		if(projectInstance.status!='DRAFT_REQUEST') {
				message = "Invalid project state Exception"
				return [message:message]        		
        			}
        		projectInstance.properties = params
        	}
        	catch(Exception e){
        		log.debug("saveProject:"+e)
        		message = "Invalid project id Exception"
        		return [message:message]
        	}
        }
        	
        
        
        
        //adjust advance amount to be upto expense amount only
        if(projectInstance.advanceAmount) {
        	if(projectInstance.advanceAmount>projectInstance.amount)
        		projectInstance.advanceAmount = projectInstance.amount
        	}
        
        //apply rules
        def balCheck = checkBalance(params.costCenter, params.amount, params.category)
        if(projectInstance.type=='CREDIT' || params.auto)
        	balCheck.allow = true
        
        //set ref
        if(!projectInstance.hasErrors() && balCheck.allow && !(projectInstance.status=="DRAFT_REQUEST") && !params.ref) {
        	def key = 'EXP-'+housekeepingService?.getFY()+'-'+params.costCenter?.costCategory?.alias+params.costCenter?.alias
        	projectInstance.ref = key+'-'+receiptSequenceService.getNext(key)
        	}
        

        //adjust balance accordingly
        //@TODO: type (revenue or credit) not handled
        if(balCheck.allow && !(projectInstance.status=="DRAFT_REQUEST") ) {
        	try{
        	projectInstance.costCenter.balance += projectInstance.amount
        	if(!projectInstance.costCenter.save())
        		log.debug("saveProject:Exception in updating cc balance:"+projectInstance.costCenter)
        	log.debug("saveProject:updated cc balance:"+projectInstance+":"+projectInstance.amount+":"+projectInstance.costCenter.balance)
        	}
        	catch(Exception e){
        		log.debug("saveProject:FATAL Exception in updating cc balance:"+projectInstance+":"+e)
        	}
        }
        
        if (!projectInstance.hasErrors() && balCheck.allow && projectInstance.save()) {
            message="Successfully saved!!"
            state = "OK"
            //send comms
            if(!params.auto && projectInstance.status=="SUBMITTED_REQUEST") {
            	try{
            	sendComms(projectInstance,"ProjectSubmission")
            	}
            	catch(Exception e){log.debug(e)}
            }
        }
        else {
	    projectInstance.errors.allErrors.each {
		log.debug(it)
		}
        }
                
        return [message:message,state:state,projectInstance:projectInstance,balCheck:balCheck]
    }
    
    def getCostCenter(Long indid) {
	return CostCenter.findByOwnerAndStatusIsNull(Individual.get(indid))
    }
    
    def stats(String user) {
         if (SpringSecurityUtils.ifAnyGranted('ROLE_CC_OWNER') ){
            return ccownerStats(user)
         }
         else  if (SpringSecurityUtils.ifAnyGranted('ROLE_CG_OWNER') ){
            return cgownerStats(user)
         }
         else  if (SpringSecurityUtils.ifAnyGranted('ROLE_FINANCE') ){
            return finStats()
         }
         else  if (SpringSecurityUtils.ifAnyGranted('ROLE_ACC_USER') ){
            return accStats()
         }
         else
         	return []
    }
    
    def ccownerStats(String user) {
    	def result = Project.createCriteria().list(){
			costCenter{
				owner{eq('loginid',user)}
			}
			projections {
				groupProperty('status')
				rowCount('id')
			}
    		}
    	def map = [:]
    	result.each{map.put(it[0],it[1])}
    	return map
    }
 
     def cgownerStats(String user) {
    	def result = Project.createCriteria().list(){
			costCenter{
				costCenterGroup{owner{eq('loginid',user)}}
			}
			projections {
				groupProperty('status')
				rowCount('id')
			}
    		}
    	def map = [:]
    	result.each{map.put(it[0],it[1])}
    	return map
     }

     def finStats() {
    	def result = Project.createCriteria().list(){
			like('status','ESCALATED%')
			projections {
				groupProperty('status')
				rowCount('id')
			}
    		}
    	def map = [:]
    	result.each{map.put(it[0],it[1])}
    	return map
     }

     def accStats() {
    	def numForAdvance = Project.createCriteria().get(){
			eq('status','APPROVED_REQUEST')
			isNotNull('advanceAmount')
			gt('advanceAmount',new BigDecimal(0))
			isNull('advanceAmountIssued')			
			projections {
				rowCount('id')
			}
    		}
    	def numForSettle = Project.createCriteria().get(){
			eq('status','APPROVED_REPORT')
			projections {
				rowCount('id')
			}
    		}
    	return ['APPROVED_REQUEST':numForAdvance,'APPROVED_REPORT':numForSettle]
     }
     
     def checkBalance(CostCenter cc, String amount, String category) {
     	def response = [:]
     	def allow = true
     	def amt = new BigDecimal(amount)     	
	def msg=[]
	def ignoreCategory = true

     	if(ignoreCategory || category=="REVENUE")  {
		def pb = (cc.balance?:0)+amt
		def pqb = (cc.quarterBalance?:0)+amt
		def pyb = (cc.yearBalance?:0)+amt
		if(pb>(cc.budget?:0)) {
			allow = false
			msg.add("Projected monthly balance: "+pb+" exceeds allocated monthly budget: "+(cc.budget?:0))
			}
		/*if(pqb>(cc.quarterBudget?:0))
			msg.add("Projected quaterly balance: "+pqb+" exceeds allocated quaterly budget: "+(cc.quarterBudget?:0))
		if(pyb>(cc.yearBudget?:0))
			msg.add("Projected yearly balance: "+pyb+" exceeds allocated yearly budget: "+(cc.yearBudget?:0))*/
		response.put('msg',msg)
     	}
     	else if(category=="CAPITAL")  {
		def pcb = (cc.capitalBalance?:0)+amt
		def pcqb = (cc.capitalQuarterBalance?:0)+amt
		def pcyb = (cc.capitalYearBalance?:0)+amt
		if(pcb>(cc.capitalBudget?:0)) {
			allow = false
			msg.add("Projected monthly capital balance: "+pcb+" exceeds allocated monthly capital budget: "+(cc.capitalBudget?:0))
			}
		/*if(pcqb>(cc.capitalQuarterBudget?:0))
			msg.add("Projected capital quaterly balance: "+pcqb+" exceeds allocated capital quaterly budget: "+(cc.capitalQuarterBudget?:0))
		if(pcyb>(cc.capitalYearBudget?:0))
			msg.add("Projected capital yearly balance: "+pcyb+" exceeds allocated capital yearly budget: "+(cc.capitalYearBudget?:0))*/
		response.put('msg',msg)
     	}
     	
     	response.put('allow',allow)
     	return response
     }
    
     def checkFrequency(CostCenter cc) {
     	def num
     	return ""
     }

     def checkSettlement(CostCenter cc) {
    	def msg=""
    	def result = Project.createCriteria().get(){
			eq('costCenter',cc)
			'in'('status',['APPROVED_REQUEST','DRAFT_REPORT','SUBMITTED_REPORT'])
			projections {
				count('id')
			}
    		}
    	log.debug("checkSettlement:"+cc+":count="+result)
    	if(result>1)
    		msg = result+" unsettled expenses!!"
    		
    	return msg
     }
     
     //checks before allowing new expense to be created
     def check(CostCenter cc) {
     	//find all unsettled expenses
     	def unsettledExpenses = Project.createCriteria().list{
     						eq('costCenter',cc)
     						not {'in'("status",['SETTLED_REPORT','REJECTED_REQUEST'])}
     						ne('type','PARTPAYMENT')
     						ne('type','CREDIT')
     						order('submitDate')
     						}
     	
     	//find all unsettled part payments
     	def unsettledPartPaymentExpenses = Project.createCriteria().list{
     						eq('costCenter',cc)
     						not {'in'("status",['SETTLED_REPORT','REJECTED_REQUEST'])}
     						inList('type',['PARTPAYMENT','CREDIT'])
     						order('submitDate')
     						}

     	//find all unsettled expenses for more than a month
     	def cutoffDate = new Date()-30
     	log.debug("check:cutoffdate:"+cutoffDate)
     	def unsettledExpensesBeyondCutoff = Project.createCriteria().list{
     						eq('costCenter',cc)
     						not {'in'("status",['SETTLED_REPORT','REJECTED_REQUEST'])}
     						le('submitDate',cutoffDate)     						
     						ne('type','PARTPAYMENT')
     						order('submitDate')
     						}
     	
     	def limit75pc = false
     	if(cc.budget && cc.balance && ((cc.budget-cc.balance)/cc.budget<0.25))
     		limit75pc = true
     	log.debug("unsettledExpenses:"+unsettledExpenses)
     	log.debug("unsettledExpensesBeyondCutoff:"+unsettledExpensesBeyondCutoff)
     	log.debug("limit75pc:"+limit75pc)
     	return [cc:cc,unsettledExpenses:unsettledExpenses,unsettledExpensesBeyondCutoff:unsettledExpensesBeyondCutoff,limit75pc:limit75pc,unsettledPartPaymentExpenses:unsettledPartPaymentExpenses]
     }

    def changeState(Map params) {
  	def ignoreCategory = true
  	def message = ""
  	def projectInstance = Project.get(params.projectid)
  	if(!projectInstance) {
  		log.debug("changeState:Got null project:params:"+params+":username:"+springSecurityService?.principal?.username)
  		return message
  	}
  	def oldStatus = projectInstance.status
  	if(projectInstance) {
		if(projectInstance.submitStatus=="REPORTED") {
			switch(params.approvestatus) {
				case 'APPROVE':
					projectInstance.status = 'APPROVED_REPORT'
					break
				case 'REJECT':
					projectInstance.status = 'REJECTED_REPORT'
					break
				case 'ESCALATE':
					projectInstance.status = 'ESCALATED_REPORT'
					break
				default:
					message = "Invalid state received!"
					return				
			}
		}
		else {
			switch(params.approvestatus) {
				case 'APPROVE':
					projectInstance.status = 'APPROVED_REQUEST'
					break
				case 'REJECT':
					projectInstance.status = 'REJECTED_REQUEST'
					break
				case 'ESCALATE':
					projectInstance.status = 'ESCALATED_REQUEST'
					break
				default:
					message = "Invalid state received!"
					return				
			}
		}
		
		//check whether the same request has been received again
		if(oldStatus==projectInstance.status) {
			log.debug("changeState:duplicate request:oldStatus:"+oldStatus+":params:"+params)
			message = projectInstance?.ref+" duplicate submit request ignored!"
			return
		}
		
		log.debug("changestate for projectid:"+projectInstance.id+":oldstatus:"+oldStatus+":newstatus:"+projectInstance.status)
			

		//set reviewer1 fields
		def username = ''
		try{
		username = springSecurityService.principal.username
		}
		catch(Exception e){username='unknown'}

		projectInstance.updator = username
		
		switch(params.approver) {
			case 'ROLE_CG_OWNER':
				projectInstance.reviewer1 = CostCenterGroup.findByOwner(Individual.findByLoginid(username))?.owner1
				projectInstance.review1Date = new Date()
				projectInstance.review1Comments = params.review1Comments
				break
			case 'ROLE_FINANCE':
				projectInstance.reviewer2 = Individual.findByLoginid(username)
				projectInstance.review2Date = new Date()
				projectInstance.review2Comments = params.review2Comments
				break
			default:
				break				
		}
		
		if(!projectInstance.save())
		    projectInstance.errors.allErrors.each {
				log.debug("changeState:Exception in saving project"+it)
			    }
		else {
			//change state for child projects as well
			try{
			updateChildProjects(projectInstance,projectInstance.status)
			}
			catch(Exception e)  {log.debug("Exception in updateChildProjects"+e)}
			
			//update cost center balance
			if(!(projectInstance.type && projectInstance.type=='CREDIT')) {
				if(projectInstance.status == 'REJECTED_REQUEST') {
					def cc = projectInstance.costCenter
					if(ignoreCategory || projectInstance.category=='REVENUE') {
						cc.balance = (cc.balance?:0) -projectInstance.amount
						cc.quarterBalance = (cc.quarterBalance?:0) - projectInstance.amount
						cc.yearBalance = (cc.yearBalance?:0) - projectInstance.amount
					}
					if(projectInstance.category=='CAPITAL') {
						cc.capitalBalance = (cc.capitalBalance?:0) - projectInstance.amount
						cc.capitalQuarterBalance = (cc.capitalQuarterBalance?:0) - projectInstance.amount
						cc.capitalYearBalance = (cc.capitalYearBalance?:0) - projectInstance.amount
					}
					if(!cc.save())
					    cc.errors.allErrors.each {
							log.debug("changeState:Exception in updating cc"+it)
						    }
				}				
			}

		    //send comms
		    def stage=''
		    switch(projectInstance.status) {
		    	case "APPROVED_REQUEST":
		    		stage = 'ProjectApproval'
		    		break
		    	case "APPROVED_REPORT":
		    		stage = 'ExpenseApproval'
		    		break
		    	case "REJECTED_REQUEST":
		    		stage = 'ProjectRejection'
		    		break
		    	case "REJECTED_REPORT":
		    		stage = 'ExpenseRejection'
		    		break
		    	default:
		    		break
		    		
		    }
		    
		    if(stage) {
			try{
			sendComms(projectInstance,stage)
			}
			catch(Exception e){log.debug(e)}
		    }
					
		}
	}
	message = projectInstance?.ref+" updated!"
    	return message
    }
    
    def getProjects(CostCenter cc, String status) {
    	Project.findAllByCostCenterAndStatus(cc,status)
    }
    
    def saveReport(params) {
    	def project = Project.get(params.projectid)
    	if(!project)
    		return "EAR not found!!"
    		
    	def expense,amount
 
         def username = ''
         try{
         username = springSecurityService.principal.username
         }
         catch(Exception e){username='unknown'}
         
	def totalExpenseAmount = 0;
	def numItems = 10
	if(params.numRows)
		numItems = new Integer(params.numRows)
    	for(int i=0;i<numItems;i++) {
    			try{
    		def existingExpense = false
    		if(params.('part_'+i)) {
    				amount = new BigDecimal(params.('amount_'+i))
    				totalExpenseAmount += amount
    				if(params.('expid_'+i)) {
    					expense = Expense.get(params.('expid_'+i))
    					existingExpense = true
    				}
    				else
    					expense = new Expense()
    				if(!existingExpense) {
					expense.department = Department.findByCostCenter(project.costCenter)?:Department.findByName("Finance")//@TODO: hardcoded
					expense.project = project
					expense.costCenter = project.costCenter
					expense.raisedBy = project.submitter
					expense.raisedOn = new Date()
	    				expense.category = "EMS"
					try{
					def key = 'EXI-'+housekeepingService?.getFY()+'-'+project.costCenter?.costCategory?.alias+project.costCenter?.alias
					expense.ref = key+'-'+receiptSequenceService.getNext(key)
					}
					catch(Exception e){log.debug(e)}
					expense.creator = username
    				}
    				expense.type = params.('type_'+i)?:''
    				expense.description = params.('part_'+i)
    				expense.amount = amount
    				if(params.('invoiceAvailable_'+i))
    					expense.invoiceAvailable = params.('invoiceAvailable_'+i)
    				expense.invoiceRaisedBy = params.('invoiceRaisedBy_'+i)
    				expense.invoiceNo = params.('invoiceNo_'+i)
    				try{
    					expense.invoiceDate = params.('invoiceDate_'+i)?(Date.parse('dd-MM-yyyy', params.('invoiceDate_'+i))):null
    				}
    				catch(Exception e){log.debug(e)}
    				expense.invoicePaymentMode = params.('mode.id_'+i)?PaymentMode.get(params.('mode.id_'+i)):null
    				if(params.reportstatus=='SUBMIT')
    					expense.status = 'SUBMITTED'
    				else
    					expense.status = 'DRAFTED'
    				try{
    					expense.expenseDate = Date.parse('dd-MM-yyyy', params.('expdate_'+i))
    				}
    				catch (Exception e) {expense.expenseDate = new Date()}
    				expense.updator = username
    				if(!expense.save()) 
				    expense.errors.allErrors.each {
						log.debug("saveReport:Exception in saving expense"+it)
					    }
    		}
	}
	catch(Exception e) {
		log.debug("saveReport:Exception"+e)
	}
    		
    	}
    	
    	//now update overall project status
    	switch(params.reportstatus) {
    		case 'SUBMIT':
    			project.status = 'SUBMITTED_REPORT'

    			try{
    			if(params.settlementAmount) {
    				project.settleAmount = new BigDecimal(params.settlementAmount)
    				log.debug("pid:"+project.id+":settleAmount:"+project.settleAmount+" totalexp:"+totalExpenseAmount)
    			}
    			else
    				project.settleAmount = totalExpenseAmount
    			}
    			catch(Exception e){log.debug(e)}
    			project.settleDate = new Date()
    			break
    		case 'DRAFT':
    		default:
    			project.status = 'DRAFT_REPORT'
    			break
    	}
    	project.submitStatus = "REPORTED"
	if(!project.save()) {
	    project.errors.allErrors.each {
			log.debug("saveReport:Exception in updating project"+it)
		    }
	} else {
            //update part payment projects in case of credit
            if(params.ppProjectIds) {
            	try{
            		submitPartPaymentProjects(project,params.ppProjectIds)
            	}
            	catch(Exception e){log.debug("submitPartPaymentProjects:"+e)}
            }
            	
            //send comms
            if(project.status=="SUBMITTED_REPORT") {
            	try{
            	sendComms(project,"ExpenseSubmission")
            	}
            	catch(Exception e){log.debug(e)}
            }
	}
    	
    	return project.ref+" expense report submitted!"
    	
    }
    
    def submitPartPaymentProjects(Project mainProject, String ppProjectIds) {
    	ppProjectIds?.tokenize(',').each{ppid->
    		def ppProject = Project.get(ppid)
    		ppProject.status  = "SUBMITTED_REPORT"
    		ppProject.mainProject = mainProject
    		if(!ppProject.save())
    			ppProject.errors.allErrors.each {log.debug("submitPartPaymentProjects.Exception in updating"+e)}
    	}
    }

    def updateChildProjects(Project mainProject, String status) {
    	def childProjects = Project.findAllByMainProject(mainProject)
    	childProjects.each{ppProject->
    		ppProject.status  = status
	if(!ppProject.save())
		ppProject.errors.allErrors.each {log.debug("updateChildProjects.Exception in updating"+e)}
    	}
    }
    
    
    def sendComms(Project project, String stage) {
	    def individual,number,toemail,subject,templateCode
	    def contentParams = []

	    
	    switch(stage) {
	    	case "ProjectSubmission" :
			individual = project.costCenter.costCenterGroup.owner1
			number = VoiceContact.findByCategoryAndIndividual('CellPhone',individual)?.number
			toemail = EmailContact.findByCategoryAndIndividual('Personal',individual)?.emailAddress
			templateCode = "EMS_PROJ_SUB"
			def hodName = (project.costCenter.owner1?.toString()?:'')+'('+ project.costCenter.name+')'
			log.debug("sendComms:ProjectSubmission:"+hodName)
			contentParams = [hodName,project.amount?.toString(),project.priority.substring(0,2),project.submitDate.format('dd-MM-yyyy HH:mm:ss')]
			subject = project.ref+" Amount:"+project.amount+" Priority:"+project.priority+" by:"+project.costCenter.name+" submitted for approval."
	    		break
	    	case "ProjectApproval" :
			individual = project.submitter
			number = VoiceContact.findByCategoryAndIndividual('CellPhone',individual)?.number
			toemail = EmailContact.findByCategoryAndIndividual('Personal',individual)?.emailAddress
			templateCode = "EMS_PROJ_APP"
			contentParams = [project.costCenter?.name,project.ref,project.amount?.toString(),project.priority.substring(0,2),project.submitDate.format('dd-MM-yyyy HH:mm:ss')]
			subject = project.costCenter?.name+" "+project.ref+" Amount:"+project.amount+" Priority:"+project.priority+" approved."
	    		break
	    	case "ProjectRejection" :
			individual = project.submitter
			number = VoiceContact.findByCategoryAndIndividual('CellPhone',individual)?.number
			toemail = EmailContact.findByCategoryAndIndividual('Personal',individual)?.emailAddress
			templateCode = "EMS_PROJ_REJ"
			contentParams = [project.ref,project.amount?.toString(),project.priority.substring(0,2),project.submitDate.format('dd-MM-yyyy HH:mm:ss')]
			subject = project.ref+" Amount:"+project.amount+" Priority:"+project.priority+" rejected."
	    		break
	    	case "ExpenseSubmission" :
			individual = project.costCenter.costCenterGroup.owner1
			number = VoiceContact.findByCategoryAndIndividual('CellPhone',individual)?.number
			toemail = EmailContact.findByCategoryAndIndividual('Personal',individual)?.emailAddress
			templateCode = "EMS_EXP_SUB"
			def hodName = (project.costCenter.owner1?.toString()?:'')+'('+ project.costCenter.name+')'
			log.debug("sendComms:ExpenseSubmission:"+hodName)
			contentParams = [hodName,project.amount?.toString(),project.priority.substring(0,2),project.submitDate.format('dd-MM-yyyy HH:mm:ss')]
			subject = project.ref+" Amount:"+project.amount+" Priority:"+project.priority+" by:"+project.costCenter.name+" submitted for settlement."
	    		break
	    	case "ExpenseApproval" :
			individual = project.submitter
			number = VoiceContact.findByCategoryAndIndividual('CellPhone',individual)?.number
			toemail = EmailContact.findByCategoryAndIndividual('Personal',individual)?.emailAddress
			templateCode = "EMS_EXP_APP"
			contentParams = [project.costCenter?.name,project.ref,project.amount?.toString(),project.priority.substring(0,2),project.submitDate.format('dd-MM-yyyy HH:mm:ss')]
			subject = project.costCenter?.name+" "+project.ref+" Amount:"+project.amount+" Priority:"+project.priority+" settlement approved."
	    		break
	    	case "ExpenseRejection" :
			individual = project.submitter
			number = VoiceContact.findByCategoryAndIndividual('CellPhone',individual)?.number
			toemail = EmailContact.findByCategoryAndIndividual('Personal',individual)?.emailAddress
			templateCode = "EMS_EXP_REJ"
			contentParams = [project.ref,project.amount?.toString(),project.priority.substring(0,2),project.submitDate.format('dd-MM-yyyy HH:mm:ss')]
			subject = project.ref+" Amount:"+project.amount+" Priority:"+project.priority+" settlement rejected."
	    		break
	    	case "Ready" :
			individual = project.submitter
			number = VoiceContact.findByCategoryAndIndividual('CellPhone',individual)?.number
			toemail = EmailContact.findByCategoryAndIndividual('Personal',individual)?.emailAddress
			templateCode = "EMS_INS_READY"
			contentParams = [project.ref,project.amount?.toString(),project.priority.substring(0,2),project.submitDate.format('dd-MM-yyyy HH:mm:ss')]
			subject = project.ref+" Amount:"+project.amount+" Priority:"+project.priority+" instrument ready."
	    		break
	    	case "Collected" :
			individual = project.submitter
			number = VoiceContact.findByCategoryAndIndividual('CellPhone',individual)?.number
			toemail = EmailContact.findByCategoryAndIndividual('Personal',individual)?.emailAddress
			templateCode = "EMS_INS_COLLECTED"
			contentParams = [project.ref,project.amount?.toString(),project.priority.substring(0,2),project.submitDate.format('dd-MM-yyyy HH:mm:ss')]
			subject = project.ref+" Amount:"+project.amount+" Priority:"+project.priority+" instrument collected."
	    		break
	    	default:
	    		break
	    }
	    
	    //SMS
	    try{
		//send sms
		def depcp_sms = DepartmentCP.createCriteria().get{
				department{eq('name','Finance')}	//@TODO: handle multi-center scenario
				cp{eq('type','SMS')}
				}
		if(depcp_sms)
			{
			if(number) {
				def template = Template.findByCodeAndCategory(templateCode,"SMS")
				if(template) {
					def body = commsService.fillTemplate(template,contentParams)
					commsService.sendSms(depcp_sms.cp,number,body)
				}
			}
			}
	    }
	    catch(Exception e){log.debug("sendcomms sms stage:"+stage+" exception:"+e)}

	    //EMAIL
	    try{
		//send the email to participant with userid
		def depcp = DepartmentCP.createCriteria().get{
				department{eq('name','Finance')}	//@TODO: handle multi-center scenario
				cp{eq('type','Mandrill')}
				}
		if(depcp)
			{
			if(toemail) {
				def template = Template.findByCodeAndCategory(templateCode,"EMAIL")
				if(template) {
					def body = commsService.fillTemplate(template,contentParams)
					commsService.sendMandrill([key:depcp?.cp?.apikey,sender:depcp.sender,toName:individual.toString(),toEmail:toemail,emailsub:subject,emailbody:body,type:template.type])
				}
			}
			}
	    }
	    catch(Exception e){log.debug("sendcomms email stage:"+stage+" exception:"+e)}
    }
    
    def addCostCenterGroup(Map params) {
    	//first create the cg and then try to map the supplied cc's to it

         def username = ''
         try{
         username = springSecurityService.principal.username
         }
         catch(Exception e){username='unknown'}

    	def cg = new CostCenterGroup(params)
    	cg.creator=cg.updator=username
    	if(!cg.save())
    		cg.errors.allErrors.each {log.debug("addCostCenterGroup:"+it)}
    	else {
    		//now map the cc's if any
    		params.list('ccids').each{ccid->
    			def cc = CostCenter.get(ccid)
    			cc.costCenterGroup = cg
    			if(!cc.save())
    				cc.errors.allErrors.each {log.debug("addCostCenterGroup upd cc:"+it)}
    		}
    	}
    	
    	return true
    }
    
    def createDonationBatch(Map params) {
    	//first check if the basic params are present
    	if(!(params.receiverid && params.donationids && params.donationids.size()>0))
    		return "INVALID"
    	
    	def receiver = Individual.get(params.receiverid)
         def username = ''
         try{
         username = springSecurityService.principal.username
         }
         catch(Exception e){username='unknown'}
    	
    	//create the batch first and then assign the batch items
    	def batch = new Batch()
    	batch.category = "DONATION"
    	batch.type = "INWARD"
    	batch.name = 'Donation batch of '+receiver+' on '+new Date().format('dd-MM-yyyy HH:mm:ss')
	//def key = 'ACB-D-'+params.receiverid
	def key = 'ACB-D-'+username
	batch.ref = key+'-'+receiptSequenceService.getNext(key)
	batch.fromDate = Date.parse('dd-MM-yyyy HH:mm:ss', params.fromDate)
	batch.toDate = Date.parse('dd-MM-yyyy HH:mm:ss', params.toDate)
	batch.status='CREATED'
	batch.creator = batch.updator = username
	if(!batch.save())
		batch.errors.allErrors.each {log.debug("createDonationBatch :"+it)}
	else {
		//now create the batch items
		def batchItem
		params.donationids.tokenize(',').each{did->
			batchItem = new BatchItem()
			batchItem.batch = batch
			batchItem.postingDate = new Date()
			batchItem.ref = did
			batchItem.debit = true
			batchItem.grossAmount = 0
			batchItem.status = 'CREATED'
			batchItem.creator = batchItem.updator = username
			if(!batchItem.save())
				batchItem.errors.allErrors.each {log.debug("createDonationBatch batchitem:"+it)}
		}
	}
	return "OK"
    }
    
    def payExpenseSave(Map params) {
         def username = ''
         try{
         username = springSecurityService.principal.username
         }
         catch(Exception e){username='unknown'}

    	def flag=false
    	def expidList = params.expids?.tokenize(',').collect{new Long(it)}
    	log.debug("expidList:"+expidList)
    	def expenseInstanceList = []
    	if(expidList.size()>0) 
		expenseInstanceList = Expense.createCriteria().list(){'in'("id",expidList)}
	def voucher
    	if(expenseInstanceList.size()>0) {
    		voucher = new Voucher()
    		voucher.type=params.type//@TODO: derive from this
    		voucher.voucherDate=new Date()
    		voucher.departmentCode = expenseInstanceList[0].costCenter    		
    		voucher.ledger=expenseInstanceList[0].costCenter?.costCategory?.alias+expenseInstanceList[0].costCenter?.alias
    		if(voucher.type=="Journal")
	    		voucher.anotherLedger=params.anotherLedger
	    	else
	    		voucher.anotherLedger=expenseInstanceList[0].invoiceRaisedBy
    		voucher.amount=expenseInstanceList.sum{it.amount}
    		voucher.debit=false
    		voucher.refNo='expense/show/'+params.expids
    		voucher.description=params.description
    		voucher.status="CREATED"
    		voucher.creator = voucher.updator = username
		try{
			def voucherCode = voucherKeyCode(voucher,false,expenseInstanceList[0].invoicePaymentMode?.name)
			def key = housekeepingService?.getFY() +'-'+ voucherCode
			voucher.voucherNo = key+'-'+receiptSequenceService.getNext(key)
		}
		catch(Exception e){log.debug("payExpenseSave:CANT GET VOUCHER NO:"+e)}
		if(!voucher.save())
			voucher.errors.allErrors.each {log.debug("payExpenseSave save voucher:"+it)}
		else
			flag=true
    	}
    	if(flag) {
		expenseInstanceList.each { expenseInstance->
			//now back link the expense
			expenseInstance.paymentVoucher = voucher
			expenseInstance.status = "VOUCHER_CREATED"
			if(!expenseInstance.save())
				expenseInstance.errors.allErrors.each {log.debug("payExpenseSave save expenseInstance:"+it)}			
		}
    	}
    }
    
    def saveRejectProject(Map params) {
         def reviewer2 = null
         def username=''
         try{
		 username = springSecurityService.principal.username
		 reviewer2 = Individual.findByLoginid(username)
         }
         catch(Exception e){username='unknown'}
    	def project = Project.get(params.projectId)
    	if(project && project.status=='APPROVED_REQUEST' && !project.advancePaymentVoucher) {
    		project.reviewer2 = reviewer2
    		project.review2Date = new Date()
    		project.review2Comments = params.review2Comments
    		project.status = 'REJECTED_REQUEST'
		if(!project.save())
			project.errors.allErrors.each {log.debug("saveRejectProject:"+it)}
		else {
			//update cost center balance accordingly
			def cc = project.costCenter
			if(project.category=='REVENUE') {
				cc.balance = (cc.balance?:0) - project.amount
				cc.quarterBalance = (cc.quarterBalance?:0) - project.amount
				cc.yearBalance = (cc.yearBalance?:0) - project.amount
			}
			if(project.category=='CAPITAL') {
				cc.capitalBalance = (cc.capitalBalance?:0) - project.amount
				cc.capitalQuarterBalance = (cc.capitalQuarterBalance?:0) - project.amount
				cc.capitalYearBalance = (cc.capitalYearBalance?:0) - project.amount
			}
			if(!cc.save())
			    cc.errors.allErrors.each {
					log.debug("saveRejectProject:Exception in updating cc"+it)
				    }
			else
					log.debug("saveRejectProject:Updated balance for cc:"+cc)			
		}
    	}
    	return "DONE"
    }

    def saveRejectExpense(Map params) {
         def reviewer2 = null
         def username=''
         try{
		 username = springSecurityService.principal.username
		 reviewer2 = Individual.findByLoginid(username)
         }
         catch(Exception e){username='unknown'}
    	def project = Project.get(params.err_projectId)
    	def expensesWithVouchers = Expense.findAllByProjectAndPaymentVoucherIsNotNull(project)
    	if(project && project.status=='APPROVED_REPORT' && !(expensesWithVouchers.size()>0)) {
    		project.reviewer2 = reviewer2
    		project.review2Date = new Date()
    		project.review2Comments = params.review2Comments
    		project.status = 'REJECTED_REPORT'
		if(!project.save())
			project.errors.allErrors.each {log.debug("saveRejectExpense:"+it)}			    		
    	}
    	return "DONE"
    }
    
    //this would delete the ERR and EAR both..and release the budget..handle with care
    def saveCompleteReject(Map params) {
    	def msg = "Error"
    	def project = Project.get(params.projectid)

    	if(!project || project.advancePaymentVoucher) {
    		msg = "Invalid expense!!"
    		return msg
    	}
    		
    	def expensesWithVouchers = Expense.findAllByProjectAndPaymentVoucherIsNotNull(project)
    	if(expensesWithVouchers.size()>0) {
    		msg = "Invalid expense..has lineitems with vouchers!!"
    		return msg
    	}

    	//delete all expenses first
    	Expense.findAllByProject(project).each{it.delete()}

         def reviewer2 = null
         def username=''
         try{
		 username = springSecurityService.principal.username
		 reviewer2 = Individual.findByLoginid(username)
         }
         catch(Exception e){username='unknown'}

    	//now reject the project
    	def returnBudget = false
	if(project.status=='APPROVED_REQUEST' || project.status.endsWith('_REPORT'))
		returnBudget = true    	
	project.reviewer2 = reviewer2
	project.review2Date = new Date()
	project.review2Comments = params.review2Comments
	project.status = 'REJECTED_REQUEST'
	if(!project.save())
		project.errors.allErrors.each {log.debug("saveCompleteReject:excep in upd project:"+it)}
	else {    	
		//return back the budget
		if(returnBudget)  {
			//update cost center balance accordingly
			def cc = project.costCenter
			if(project.category=='REVENUE') {
				cc.balance = (cc.balance?:0) - project.amount
				cc.quarterBalance = (cc.quarterBalance?:0) - project.amount
				cc.yearBalance = (cc.yearBalance?:0) - project.amount
			}
			if(project.category=='CAPITAL') {
				cc.capitalBalance = (cc.capitalBalance?:0) - project.amount
				cc.capitalQuarterBalance = (cc.capitalQuarterBalance?:0) - project.amount
				cc.capitalYearBalance = (cc.capitalYearBalance?:0) - project.amount
			}
			if(!cc.save())
			    cc.errors.allErrors.each {
					log.debug("saveCompleteReject:Exception in updating cc"+it)
				    }
		}
    	}
    	
    	
    	msg = "Rejected completely"
    	
    	return msg
    }
    
    def generateLoginId(Individual ind, String role) {	
	if(!ind)
		return "No individual found!!"
		
	if(ind.loginid)
		return ind.loginid
		
	def icsRole = com.krishna.IcsRole.findByAuthority(role)

	def login=''
	login=housekeepingService.createLogin(ind,icsRole)
	
	return login
    }
    
    def updateProfitCenterBudget(Donation donation) {
    	try{
		if(donation?.scheme?.cc?.isProfitCenter) {
			def cc = donation.scheme.cc
			log.debug("Updating budget for "+cc+" from "+(cc.budget?:0)+" adding"+(donation.amount?:0))
			if(donation.amount>0) {
				cc.budget = (cc.budget?:0) + donation.amount
				if(!cc.save())
					cc.errors.allErrors.each {log.debug("updateProfitCenterBudget:"+it)}
				else
					return true
			}
		}
    	}
    	catch(Exception e) { log.debug("updateProfitCenterBudget"+e) } 
    	return false
    }
    
    def calculateDeduction(Map params) {
    	def message=""
    	def count = 0
    	def expense
	params.expidsForDeduction?.tokenize(',').each{eid->
		expense = Expense.get(eid)
		if(expense && !expense.paymentVoucher) {
			expense.deductionType = params.deductionType
			expense.deductionDescription = params.deductionDescription
			if(params.deductionPercentage)
				try{expense.deductionPercentage = new BigDecimal(params.deductionPercentage)} catch(Exception e){log.debug(e)}
			if(params.deductionAmount)
				try{expense.deductionAmount = new BigDecimal(params.deductionAmount)} catch(Exception e){log.debug(e)}
			if(!expense.save())
				expense.errors.allErrors.each {log.debug("calculateDeduction:"+it)}
			else
				count++
		}
    	}

    	return "Deductions applied for "+count+" expense items!!"
    }
    
    def issueAdvance(Map params) {
    	def message=""
        def username = ''
        try{
        username = springSecurityService.principal.username
        }
        catch(Exception e){username='unknown'}

    	def flag = false
    	def project = Project.get(params.id)
    	if(project && params.advanceAmountIssued && !project.advancePaymentVoucher) {
    		//create payment voucher
    		def voucher = new Voucher()
    		voucher.type='Payment'
    		voucher.voucherDate=new Date()
    		voucher.departmentCode = project.costCenter
    		voucher.ledger=project.costCenter?.costCategory?.alias+project.costCenter?.alias
    		voucher.anotherLedger=project.advanceIssuedTo?.toString()?:'CASH'
    		voucher.amount=new BigDecimal(params.advanceAmountIssued)
    		voucher.debit=false
    		voucher.refNo='project/show/'+project.id
    		voucher.description="Advance payment to "+(project.advanceIssuedTo?:project.submitter)+" for Expense Ref:"+project.ref
    		voucher.instrumentCollectedComments = params.comments
    		voucher.status="CREATED"
    		voucher.creator = voucher.updator = username

		try{
			def voucherCode = voucherKeyCode(voucher,true,project?.advancePaymentMode?.name)
			def key = housekeepingService?.getFY() +'-'+ voucherCode
			voucher.voucherNo = key+'-'+receiptSequenceService.getNext(key)
		}
		catch(Exception e){log.debug("issueAdvance:CANT GET VOUCHER NO:"+e)}

		if(!voucher.save())
			voucher.errors.allErrors.each {log.debug("issueAdvance save voucher:"+it)}
		else
			flag=true
    		
    		//update project for cash since its issued across counter
    		if(flag) {
    		 if (!project.advancePaymentMode || project.advancePaymentMode.name.toUpperCase()=='CASH') {
			project.advanceIssued = true
			project.advanceAmountIssued = new BigDecimal(params.advanceAmountIssued)
    			}

		project.advancePaymentVoucher = voucher
		project.updator = springSecurityService.principal.username
		if(project.save()) {
			message = "Expense updated!!"
		}
		else {
			project.errors.allErrors.each {log.debug("Exception in updating project"+e)}
			message = "Some exception occurred!"
		}
		}
    		
    	}
    	else
    		message = "Expense not found!!"
    }
    
    def ready(Map params) {
        def username = ''
        try{
        username = springSecurityService.principal.username
        }
        catch(Exception e){username='unknown'}

    	def voucher = Voucher.get(params.voucheridForReady)
    	if(voucher && !voucher.instrumentReady) {
    		def project
    		
    		//update voucher
    		voucher.instrumentReady = true
    		voucher.instrumentReadyDate = new Date()
    		voucher.instrumentReadyBy = Individual.findByLoginid(username)
    		voucher.instrumentReadyStatus = 'READY'
    		voucher.instrumentReadyComments = params.instrumentReadyComments
    		if(params.instrumentNo && !voucher.instrumentNo)
    			voucher.instrumentNo = params.instrumentNo
    		if(params.instrumentDate && !voucher.instrumentDate) {    			
    			try { voucher.instrumentDate = Date.parse('dd-MM-yyyy', params.instrumentDate) } catch(Exception e){log.debug(e)}
    			}
    		if(params.bankName && !voucher.bankName)
    			voucher.bankName = params.bankName
    		if(params.bankBranch && !voucher.bankBranch)
    			voucher.bankBranch = params.bankBranch
    		voucher.updator = username
    		if(!voucher.save())
    			voucher.errors.allErrors.each {log.debug("Exception in updating voucher"+e)}
    		
    		
    		//update Project with details if required
    		def pid=''
    		if(voucher.refNo?.startsWith('project'))
    			pid = voucher.refNo?.substring(13)
    		else if(voucher.refNo?.startsWith('expense')) {
    			def eid = voucher.refNo?.substring(13)
    			try{ pid = Expense.get(eid)?.project?.id}catch(Exception e){log.debug(e)}
    			}

    		log.debug("ready:pid:"+pid)
    		try{project = Project.get(pid)}catch(Exception e){log.debug(e)}
    		log.debug("ready:projct:"+project)
    		if (project && project.advancePaymentMode && project.advancePaymentMode.name.toUpperCase()!='CASH') {
			project.advanceIssued = true
			project.advanceAmountIssued = voucher.amount
			if(!project.save())
				project.errors.allErrors.each {log.debug("Exception in updating project"+e)}
    		}
    		
    		//now send the comms
    		if(project)
	    		sendComms(project,'Ready')
    	}
    }
    
    def collected(Map params) {
        def username = ''
        try{
        username = springSecurityService.principal.username
        }
        catch(Exception e){username='unknown'}

    	def voucher = Voucher.get(params.voucheridForCollected)
    	if(voucher && !voucher.instrumentCollected) {
    		//update voucher
    		voucher.instrumentCollected = true
    		voucher.instrumentCollectedDate = new Date()
    		voucher.instrumentCollectedBy = Individual.findByLoginid(username)
    		voucher.instrumentCollectedStatus = 'COLLECTED'
    		voucher.instrumentCollectedComments = params.instrumentCollectedComments
    		voucher.updator = username
    		if(!voucher.save())
    			voucher.errors.allErrors.each {log.debug("Collected.Exception in updating voucher"+e)}
    		    		    		
    		//now send the comms
    		def pid='',project
    		if(voucher.refNo?.startsWith('project'))
    			pid = voucher.refNo?.substring(13)
    		else if(voucher.refNo?.startsWith('expense')) {
    			def eid = voucher.refNo?.substring(13)
    			try{ pid = Expense.get(eid)?.project?.id}catch(Exception e){log.debug(e)}
    			}

    		log.debug("ready:pid:"+pid)
    		try{project = Project.get(pid)}catch(Exception e){log.debug(e)}
    		if(project)
    			sendComms(project,'Collected')
    	}
    }
    
    def dataEntered(Map params) {
        def username = ''
        try{
        username = springSecurityService.principal.username
        }
        catch(Exception e){username='unknown'}

    	def voucher = Voucher.get(params.id)
    	if(voucher && !voucher.dataCaptured) {
    		//update voucher
    		voucher.dataCaptured = true
    		voucher.dataCaptureDate = new Date()
    		voucher.dataCapturedBy = Individual.findByLoginid(username)
    		voucher.dataCaptureStatus = 'ENTERED'
    		voucher.updator = username
    		if(!voucher.save())
    			voucher.errors.allErrors.each {log.debug("dataEntered.Exception in updating voucher"+e)}    		    		    		
    	}
    }

    def checkVoucherStatus(String expids) {
    	def flag=true
    	def expidList = expids.tokenize(',').collect{new Long(it)}
    	def expenseInstanceList = []
    	if(expidList.size()>0) 
		expenseInstanceList = Expense.createCriteria().list(){'in'("id",expidList)}

	def modeMap = [:]
	expenseInstanceList.each { expenseInstance->
		if(expenseInstance.paymentVoucher || !expenseInstance.ledgerHead)
			flag = false
		try{
		modeMap.put(expenseInstance.invoicePaymentMode?.name,(modeMap.get(expenseInstance.invoicePaymentMode?.name)?:0)+1)
		}
		catch(Exception e) {log.debug("checkVoucherStatus:"+e)}
		}
	//check if all expense of the same type
	if(modeMap.keySet()?.size()>1 ) {
		flag = false
	}
	//@TODO: vendor name check for non-cash payment
	return flag
    }
    
    //name,description,loginid,owner_icsid
    def createCG(Object tokens) {
    	//first check for duplicate
    	def cg = CostCenterGroup.findByName(tokens[0])
    	if(cg || !tokens[0])
    		return null

        def username = ''
        try{
        username = springSecurityService.principal.username
        }
        catch(Exception e){username='unknown'}

    	
    	//new cg to be created
    	cg = new CostCenterGroup()
	try{
		cg.name = tokens[0]
		if(tokens[1])
			cg.description = tokens[1]
		if(tokens[2]) {
			//create the owner individual with proper role
			helperService.createLogin(['',IcsRole.findByAuthority('ROLE_CG_OWNER')?.id,tokens[2],'EMS',cg.name])
			cg.owner = Individual.findByLoginid(tokens[2])
		}
		if(tokens[3])
			cg.owner1 = Individual.findByIcsid(new Integer(tokens[3]))
		cg.creator = cg.updator = username
		if(!cg.save())
			cg.errors.allErrors.each {log.debug("Exception in creating cg"+e)}
    	}
    	catch(Exception e) {log.debug("createCG:Exception:"+e)}
    	
    	return cg
    
    }
        
    //name,alias,cg_id,ccat_id,loginid,owner_icsid
    def createCC(Object tokens) {
    	//first check for duplicate
    	def cc = CostCenter.findByNameAndStatusIsNull(tokens[0])
    	if(cc || !(tokens[0] && tokens[1]))
    		return null

        def username = ''
        try{
        username = springSecurityService.principal.username
        }
        catch(Exception e){username='unknown'}

    	
    	//new cc to be created
    	cc = new CostCenter()
	try{
		cc.name = tokens[0]
		if(tokens[1])
			cc.alias = tokens[1]
		if(tokens[2])
			cc.costCenterGroup = CostCenterGroup.get(tokens[2])
		if(tokens[3])
			cc.costCategory = CostCategory.get(tokens[3])
		if(tokens[4]) {
			//create the owner individual with proper role
			helperService.createLogin(['',IcsRole.findByAuthority('ROLE_CC_OWNER')?.id,tokens[4],'EMS',cc.name])
			cc.owner = Individual.findByLoginid(tokens[4])
		}
		if(tokens[5])
			cc.owner1 = Individual.findByIcsid(new Integer(tokens[5]))
		cc.creator = cc.updator = username
		if(!cc.save())
			cc.errors.allErrors.each {log.debug("Exception in creating cc"+e)}
    	}
    	catch(Exception e) {log.debug("createCC:Exception:"+e)}
    	return cc
    }
    
    def voucherKeyCode(Voucher voucher, Boolean advance, String vmode) {
	def voucherCode = ""
	def modeCode = ""
	def typeCode = ""
	def ccatCode = ""
	if(voucher?.departmentCode?.costCategory?.name?.size()>1) {
		ccatCode = "-"+voucher?.departmentCode?.costCategory?.name?.substring(0,2)
		ccatCode = ccatCode.toUpperCase()
		}
		

	vmode = vmode?.toUpperCase()
	switch(vmode) {
		case "CHEQUE":
			modeCode = "CQ"
			break
		case "RTGS":
			modeCode = "RT"
			break
		case "TRANSFER":
			modeCode = "XF"
			break
		case "CASH":
		default:
			modeCode = "CS"
			break
	}
	
	switch(voucher.type?.toUpperCase()) {
		case "PAYMENT":
			typeCode = "PMT"
			break
		case "RECEIPT":
			typeCode = "RPT"
			break
		default:
			typeCode = "TYP"
			break		
	}

	if(advance)
		voucherCode = "ADV-"+modeCode+ccatCode
	else if(voucher.type=="Journal")
		voucherCode = "JV"
	else if(voucher.type=="Payment")
		voucherCode = modeCode+ccatCode
	else
		voucherCode = typeCode+"-"+modeCode+ccatCode
	log.debug("got voucherCode:"+voucherCode)
	return voucherCode
    }

    def unlockAndResetVH(Map params) {
	def idList = params.idlist.tokenize(',')
	idList.each{
		def iuser  = IcsUser.findByUsername(CostCenterGroup.get(it)?.owner?.loginid)
		iuser?.accountLocked = false
		iuser?.setPassword('harekrishna')
    		}
    	return true
    }

    def unlockAndResetHOD(Map params) {
	def idList = params.idlist.tokenize(',')
	idList.each{
		def iuser  = IcsUser.findByUsername(CostCenter.get(it)?.owner?.loginid)
		iuser?.accountLocked = false
		iuser?.setPassword('harekrishna')
    		}
    	return true
    }
    
    def getMonthSummaryStats(CostCenter cc) {
	def stats = [:]
	def totalExpense
	def submittedExpense
	def approvedExpense
	def underSettlementExpense
	def draftSettlement
	def rejectedSettlement
	def submittedSettlement
	def approvedSettlement
	def settledExpense
	def advanceIssued
	
	def now = new Date()
	
	submittedExpense = Project.createCriteria().get{
			    eq('costCenter',cc)
			    eq('status','SUBMITTED_REQUEST')
			    projections {
				sum "amount"
			    }
			}

	approvedExpense = Project.createCriteria().get{
			    eq('costCenter',cc)
			    eq('status','APPROVED_REQUEST')
			    projections {
				sum "amount"
			    }
			}

	underSettlementExpense = Project.createCriteria().get{
			    eq('costCenter',cc)
			    inList('status',['DRAFT_REPORT','SUBMITTED_REPORT','REJECTED_REPORT'])
			    projections {
				sum "amount"
			    }
			}

	draftSettlement = Project.createCriteria().get{
			    eq('costCenter',cc)
			    eq('status','DRAFT_REPORT')
			    projections {
				sum "amount"
			    }
			}

	rejectedSettlement = Project.createCriteria().get{
			    eq('costCenter',cc)
			    eq('status','REJECTED_REPORT')
			    projections {
				sum "amount"
			    }
			}

	submittedSettlement = Project.createCriteria().get{
			    eq('costCenter',cc)
			    eq('status','SUBMITTED_REPORT')
			    projections {
				sum "amount"
			    }
			}

	approvedSettlement = Project.createCriteria().get{
			    eq('costCenter',cc)
			    eq('status','APPROVED_REPORT')
			    projections {
				sum "amount"
			    }
			}

	settledExpense = Project.createCriteria().get{
			    eq('costCenter',cc)
			    eq('status','SETTLED_REPORT')
			    projections {
				sum "settleAmount"
			    }
			    sqlRestriction "month(review3date) = "+((now.month).toInteger()+(1*1).toInteger())*1
			}
		
	advanceIssued = Project.createCriteria().get{
			    eq('costCenter',cc)
			    isNotNull('advanceAmountIssued')
			    ne('status','SETTLED_REPORT')
			    projections {
				sum "advanceAmountIssued"
			    }
			}

	//totalExpense = (approvedExpense?:0) + (underSettlementExpense?:0) + (approvedSettlement?:0) + (settledExpense?:0)
	totalExpense = (submittedExpense?:0) + (approvedExpense?:0) + (draftSettlement?:0) + (rejectedSettlement?:0) + (submittedSettlement?:0) + (approvedSettlement?:0) + (settledExpense?:0)
	
	stats.put('totalExpense',totalExpense)
	stats.put('submittedExpense',submittedExpense)
	stats.put('approvedExpense',approvedExpense)
	stats.put('underSettlementExpense',underSettlementExpense)
	stats.put('draftSettlement',draftSettlement)
	stats.put('rejectedSettlement',rejectedSettlement)
	stats.put('submittedSettlement',submittedSettlement)
	stats.put('approvedSettlement',approvedSettlement)
	stats.put('settledExpense',settledExpense)
	stats.put('advanceIssued',advanceIssued)
	
	return stats    	
    }
    
    def getIncomeSummaryStats(CostCenter cc) {
    	def stats=[:]

    	//@TODO: This will be problematic in jan-mar..will show for new fy
    	def year = new Date().format('yyyy')
    	year = new Integer(year)
    	def start,end,ts='-01 00:00:00'
    	
    	//for 1st 8 months, Apr-Nov
    	for(Integer month=4;month<12;month++) {
		if(month<10)
			start = year+'-0'+month+'-01 00:00:00'
		else
			start = year+'-'+month+'-01 00:00:00'
		if((month+1)<10)
			end = year+'-0'+(month+1)+'-01 00:00:00'
		else
			end = year+'-'+(month+1)+'-01 00:00:00'
		stats.put('month_'+month,getIncomeStatsForMonth(cc,start,end))
    	}
    	
    	//for Dec
    	start = year+'-12-01 00:00:00'
    	end = (year+1)+'-01-01 00:00:00'
    	stats.put('month_12',getIncomeStatsForMonth(cc,start,end))
    	

    	//for last 3 months, Jan-Mar
    	for(Integer month=1;month<4;month++) {
		start = (year+1)+'-0'+month+'-01 00:00:00'
		end = (year+1)+'-0'+(month+1)+'-01 00:00:00'
		stats.put('month_'+month,getIncomeStatsForMonth(cc,start,end))
    	}

    	return stats
    }
    
    def getIncomeStatsForMonth(CostCenter cc,String start, String end) {
    	def donationTotal = Donation.createCriteria().get{
			    scheme{eq('cc',cc)}
			    ge('fundReceiptDate',Date.parse('yyyy-MM-dd HH:mm:ss', start))
			    lt('fundReceiptDate',Date.parse('yyyy-MM-dd HH:mm:ss', end))
			    projections {
				sum "amount"
			    }
			   }			  
    	def receiptVoucherTotal = Voucher.createCriteria().get{
			    eq('type','Receipt')
			    eq('departmentCode',cc)
			    ge('voucherDate',Date.parse('yyyy-MM-dd HH:mm:ss', start))
			    lt('voucherDate',Date.parse('yyyy-MM-dd HH:mm:ss', end))
			    projections {
				sum "amount"
			    }
			   }
	return (donationTotal?:0)+(receiptVoucherTotal?:0)
    }
    
    //CC_Id	Cost center	Debit	Comment
    def uploadOldAdvance(Object tokens) {    	
    	def cc = CostCenter.get(tokens[0])
    	if(cc) {

		def advanceAmount = new BigDecimal(tokens[2])

		//first update cc budget
		cc.budget += advanceAmount
		cc.balance += advanceAmount
		if(!cc.save())
			cc.errors.allErrors.each {log.debug("Exception uploadOldAdvances updating cc:"+e)}
		else {
			//auto create project in approved stage
			def spretMap = saveProject([name:'Old Advance by '+(tokens[3]?:''),description:'Advance taken in last FY by '+(tokens[3]?:''),type:'NORMAL',amount:tokens[2],advanceAmount:tokens[2],priority:'P4(LOW)',category:'REVENUE',submitStatus:'SUBMITTED_REQUEST',submitter:cc.owner1,auto:'true',costCenter:cc])
			def project = spretMap?.projectInstance
			log.debug("Auto created project:"+project)
			if(project) {
				//auto approve it and also issue the advance
				project.status = 'APPROVED_REQUEST'
				project.reviewer1 = cc.costCenterGroup.owner1
				project.advanceIssued = true
				project.advanceAmountIssued = project.advanceAmount
				if(!project.save())
					project.errors.allErrors.each {log.debug("Exception uploadOldAdvances auto approving:"+e)}
				else   		
					return true
			}
    		}
    	}
    	return false        	
    }
    
    def deleteExpense(String id) {
	  // check if exists
	  def expense  = Expense.get(id)
	  def voucher = expense.paymentVoucher
	  def project = expense.project
	  if (expense && (!expense.paymentVoucher || !expense.paymentVoucher.dataCaptured)) {
	    def expDetails = "Expid:"+expense.id+" ref:"+(expense.ref?:'')
	    log.debug("deleteExpense:"+expDetails)
	    // delete
	    def expAmt = expense.amount
	    try{
	    	expense.delete()
	    }
	    catch(Exception e) {
	    	log.debug("In deleteExpense: exception in deleting exp:"+ e)
	    	return false
	    	}

	    log.debug("deleteExpense deleted.."+expDetails)
	    // release back the budget
	    if(project.status == 'APPROVED_REPORT') {
		def cc = project.costCenter
		def oldbalance = cc.balance?:0
		cc.balance = oldbalance - expAmt
		if(!cc.save())
			cc.errors.allErrors.each {log.debug("deleteExpense:exception in releasing budget:"+it)}
		else
			log.debug("deleteExpense:budget released for cc:"+expAmt+":oldbalance:"+oldbalance+" :newbalance:"+cc.balance)

	    }

	    //soft-delete paymentVoucher, if exists
	    if(voucher) {
		voucher.status='DELETED'
		if(!voucher.save())
			voucher.errors.allErrors.each {log.debug("deleteExpense:excp in sofdel voucher:"+it)}
		else {
			log.debug("deleteExpense voucher soft deleted.."+voucher)
			//remove from other expenses
			try{
				def otherExpenses = Expense.findAllByPaymentVoucher(voucher)
				otherExpenses.each{otherExpense ->
					otherExpense.paymentVoucher = null
					if(!otherExpense.save())
						otherExpense.errors.allErrors.each {log.debug("deleteExpense:exception in removing payment voucher:"+it)}
					else
						log.debug("deleteExpense removed payment voucher from.."+otherExpense)

				}
			}
			catch(Exception e){log.debug("Exception in remove from other expenses:"+e )}
			return true
		}					    
	    }
	  }
	  return false
    }

	def updateBudget(Map params) {
		def cc = CostCenter.get(params.ccid_updatebudget)
		def oldBudget = cc.budget
		cc.budget = new BigDecimal(params.amount)
		if(!cc.save())
			cc.errors.allErrors.each {log.debug("updateBudget:exception:"+it)}
		else {
			def details = 'old='+oldBudget+' new='+cc.budget+' details = '+params.details
			addBudgetAuditTrail(cc.id, 'BudgetAuditTrail', 'BudgetUpdateAuditTrail', details)
		}
	}

	def addBudgetAuditTrail (Long ccId, String attrName, String attrType, String value) {
		log.debug("ccId:"+ccId)
		//now record for audit
		//1st create attribute , if not exists
		def attr = Attribute.findByDomainClassNameAndDomainClassAttributeNameAndNameAndType('CostCenter',ccId.toString(),attrName,attrType)
		if(!attr) {
			attr = new Attribute()
			attr.domainClassName = 'CostCenter'
			attr.domainClassAttributeName = ccId.toString()
			attr.name = attrName
			attr.type = attrType
			if(!attr.save())
			attr.errors.allErrors.each {log.debug("updateBudget:create attr:exception:"+it)}
		}
		//now store the change
		def username = ''
		try{
			username = springSecurityService.principal.username
		}
		catch(Exception e){username='unknown'}
		def av = new AttributeValue()
		if (!attr.type) {
			attr.type = attrType
			if(!attr.save()){
				attr.errors.allErrors.each{log.debug("attr.type save exception:"+it)}
			}
		}
		av.attribute = attr
		av.objectClassName  = 'CostCenter'
		av.objectId = ccId
		av.value = value
		av.updator = av.creator = username
		if(!av.save())
		av.errors.allErrors.each {log.debug("updateBudget:create av:exception:"+it)}
	}

	def getAllDonationByDonorNameIncomeSummaryStats(String donorName) {
		def stats=[:]

    	def year = new Date().format('yyyy')
    	year = new Integer(year)
    	def start,end,ts='-01 00:00:00'
    	
    	//for 1st 8 months, Apr-Nov
    	for(Integer month=4;month<12;month++) {
			if(month<10)
				start = year+'-0'+month+'-01 00:00:00'
			else
				start = year+'-'+month+'-01 00:00:00'
			if((month+1)<10)
				end = year+'-0'+(month+1)+'-01 00:00:00'
			else
				end = year+'-'+(month+1)+'-01 00:00:00'

			stats.put('month_'+month,getDonationIncomeStatsForMonthByDonor(donorName, start, end))
    	}
    	
    	//for Dec
    	start = year+'-12-01 00:00:00'
    	end = (year+1)+'-01-01 00:00:00'
    	stats.put('month_12',getDonationIncomeStatsForMonthByDonor(donorName, start, end))

    	//for last 3 months, Jan-Mar
    	for(Integer month=1;month<4;month++) {
			start = (year+1)+'-0'+month+'-01 00:00:00'
			end = (year+1)+'-0'+(month+1)+'-01 00:00:00'
			stats.put('month_'+month,getDonationIncomeStatsForMonthByDonor(donorName, start, end))
    	}

    	return stats
	}
	
	def getAllDonationBySchemeNameIncomeSummaryStats(String schemeName) {
		def stats=[:]

    	def year = new Date().format('yyyy')
    	year = new Integer(year)
    	def start,end,ts='-01 00:00:00'
    	
    	//for 1st 8 months, Apr-Nov
    	for(Integer month=4;month<12;month++) {
			if(month<10)
				start = year+'-0'+month+'-01 00:00:00'
			else
				start = year+'-'+month+'-01 00:00:00'
			if((month+1)<10)
				end = year+'-0'+(month+1)+'-01 00:00:00'
			else
				end = year+'-'+(month+1)+'-01 00:00:00'

			stats.put('month_'+month,getDonationIncomeStatsForMonthByScheme(schemeName, start, end))
    	}
    	
    	//for Dec
    	start = year+'-12-01 00:00:00'
    	end = (year+1)+'-01-01 00:00:00'
    	stats.put('month_12',getDonationIncomeStatsForMonthByScheme(schemeName, start, end))
    	
    	//for last 3 months, Jan-Mar
    	for(Integer month=1;month<4;month++) {
			start = (year+1)+'-0'+month+'-01 00:00:00'
			end = (year+1)+'-0'+(month+1)+'-01 00:00:00'
			stats.put('month_'+month,getDonationIncomeStatsForMonthByScheme(schemeName, start, end))
    	}

    	return stats
	}

    def getDonationIncomeStatsForMonthByDonor(String donorName, String start, String end) {
    	def donationTotal = Donation.createCriteria().get {
			ge('fundReceiptDate',Date.parse('yyyy-MM-dd HH:mm:ss', start))
			lt('fundReceiptDate',Date.parse('yyyy-MM-dd HH:mm:ss', end))
			donatedBy{ilike('legalName',donorName)}
			projections {
				sum "amount"
			}
		}

		return (donationTotal?:0)
    }
	
	def getDonationIncomeStatsForMonthByScheme(String schemeName, String start, String end) {
    	def donationTotal = Donation.createCriteria().get{
			ge('fundReceiptDate',Date.parse('yyyy-MM-dd HH:mm:ss', start))
			lt('fundReceiptDate',Date.parse('yyyy-MM-dd HH:mm:ss', end))
			scheme {
				cc {
					ilike('name',schemeName)
				}
			}
			projections {
				sum "amount"
			}
		}

		return (donationTotal?:0)
    }
    
	def getDonationIncomeStatsForMonthByCostCategory(String ccatName, String start, String end) {
    	def donationTotal = Donation.createCriteria().get{
			ge('fundReceiptDate',Date.parse('yyyy-MM-dd HH:mm:ss', start))
			lt('fundReceiptDate',Date.parse('yyyy-MM-dd HH:mm:ss', end))
			scheme {
				cc {
					costCategory{ilike('name',ccatName)}
				}
			}
			projections {
				sum "amount"
			}
		}

		return (donationTotal?:0)
    }

	def getAllDonationByCostCategoryNameIncomeSummaryStats(String ccatName) {
		def stats=[:]

    	def year = new Date().format('yyyy')
    	year = new Integer(year)
    	def start,end,ts='-01 00:00:00'
    	
    	//for 1st 8 months, Apr-Nov
    	for(Integer month=4;month<12;month++) {
			if(month<10)
				start = year+'-0'+month+'-01 00:00:00'
			else
				start = year+'-'+month+'-01 00:00:00'
			if((month+1)<10)
				end = year+'-0'+(month+1)+'-01 00:00:00'
			else
				end = year+'-'+(month+1)+'-01 00:00:00'

			stats.put('month_'+month,getDonationIncomeStatsForMonthByCostCategory(ccatName, start, end))
    	}
    	
    	//for Dec
    	start = year+'-12-01 00:00:00'
    	end = (year+1)+'-01-01 00:00:00'
    	stats.put('month_12',getDonationIncomeStatsForMonthByCostCategory(ccatName, start, end))
    	
    	//for last 3 months, Jan-Mar
    	for(Integer month=1;month<4;month++) {
			start = (year+1)+'-0'+month+'-01 00:00:00'
			end = (year+1)+'-0'+(month+1)+'-01 00:00:00'
			stats.put('month_'+month,getDonationIncomeStatsForMonthByCostCategory(ccatName, start, end))
    	}

    	return stats
	}
    
	def adjustBudgetAfterSettlement(Project projectInstance) {
		def ignoreCategory = true
		//normal scenario
		if(!(projectInstance.type && projectInstance.type=='CREDIT')) {
				def savingAmount
				//if expense is less than sanctioned amount, then release back
				if(projectInstance.settleAmount<projectInstance.amount) {
					savingAmount = projectInstance.amount - projectInstance.settleAmount
					log.debug("Returning back savings of:"+savingAmount+" for pid:"+projectInstance.id)
					def cc = projectInstance.costCenter
					if(ignoreCategory || projectInstance.category=='REVENUE') {
						cc.balance = (cc.balance?:0) - savingAmount
						cc.quarterBalance = (cc.quarterBalance?:0) - savingAmount
						cc.yearBalance = (cc.yearBalance?:0) - savingAmount
					}
					if(projectInstance.category=='CAPITAL') {
						cc.capitalBalance = (cc.capitalBalance?:0) - savingAmount
						cc.capitalQuarterBalance = (cc.capitalQuarterBalance?:0) - savingAmount
						cc.capitalYearBalance = (cc.capitalYearBalance?:0) - savingAmount
					}
					if(!cc.save())
					    cc.errors.allErrors.each {
							log.debug("adjustBudgetAfterSettlement:Exception in updating cc"+it)
						    }
				}
			}
		else {
		//CREDIT scenario
		//if settlement approved then, reduce budget appropriately
				//calculate correct amount 
				def childAmount = Project.findAllByMainProject(projectInstance)?.sum{it.amount}?:0
				log.debug("Credit balance adjustment..childAmount:"+childAmount+" for credit pid:"+projectInstance.id)
				def amount
				if(projectInstance.settleAmount!=null)	//&& (projectInstance.settleAmount<projectInstance.amount)
					amount = projectInstance.settleAmount - childAmount
				else
					amount = projectInstance.amount - childAmount

				/*wrong
				//when settle amount is returned back from UI
				def amount = projectInstance.settleAmount*/

				def cc = projectInstance.costCenter
				if(ignoreCategory || projectInstance.category=='REVENUE') {
					cc.balance = (cc.balance?:0) + amount
					cc.quarterBalance = (cc.quarterBalance?:0) + amount
					cc.yearBalance = (cc.yearBalance?:0) + amount
				}
				if(projectInstance.category=='CAPITAL') {
					cc.capitalBalance = (cc.capitalBalance?:0) + amount
					cc.capitalQuarterBalance = (cc.capitalQuarterBalance?:0) + amount
					cc.capitalYearBalance = (cc.capitalYearBalance?:0) + amount
				}
				if(!cc.save())
				    cc.errors.allErrors.each {
						log.debug("adjustBudgetAfterSettlement:Exception in updating cc"+it)
					    }
		}
	}
	
	//utility method to create departments for the cost centers
	//@TODO: take care of cc mods + manuals dep creation + fin year change related issues
	//@TODO: add multitenancy logic
	def createDepartments() {
		def dep
		def ccList = CostCenter.findAllByStatusIsNull()
		ccList.each{cc->
			//check if there is a corresponing dep
			dep = Department.findByCostCenterAndName(cc,cc.name)
			if(!dep) {
				//no associated dep found, create and associate
				dep = new Department()
				dep.name = cc.name	//@TODO: problematic when name changes
				dep.centre = cc.centre
				dep.costCenter = cc
				dep.description = "Autocreated for related cost center"
				dep.creator = dep.updator = "system"
				if(!dep.save())
				    dep.errors.allErrors.each {log.debug("createDepartments:Exception in saving dep"+it)}
					
			}
		}
	}
	
	def markSettleLinkedPP(Project project) {
   		if(project.type=='CREDIT') {
   			def linkedPPList = Project.findAllByMainProject(project)
   			linkedPPList.each{pp->
				 pp.status='SETTLED_REPORT'
				 pp.reviewer3 = project.reviewer3
				 pp.review3Date = new Date()
				 if(!pp.save()) {
				    pp.errors.allErrors.each {
					log.debug("Exception in markSettleLinkedPP:"+it)
					}
				}
   			}
   		}
	}
	
}
