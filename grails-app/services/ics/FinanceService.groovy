package ics
import groovy.sql.Sql;
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class FinanceService {

    def springSecurityService
    def dataSource
    def helperService
    def housekeepingService
    def receiptSequenceService
    def commsService
    
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
		CostCenter.list().each{
			createStatsAttributesForCostCenter(it,params.year)
		}
    }

    def resetStatsAttributes(Map params) {
    	//1st remove every thing
    	def attrs = Attribute.findAllByDomainClassNameAndCategory('CostCenter',params.year)
    	attrs.each{
    		it.delete()
    	}
    	createStatsAttributes(params)
    	populateStats(params)
    	return "Stats reset for year "+params.year+" !!"
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
        
        params.submitter = Individual.findByLoginid(username)
        params.submitDate = new Date()

        def message,state
        
        params.status = params.submitStatus
        
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
        log.debug(balCheck)
        
        //set ref
        if(!projectInstance.hasErrors() && balCheck.allow && !(projectInstance.status=="DRAFT_REQUEST") && !params.ref) {
        	def key = 'EXP-'+housekeepingService?.getFY()+'-'+params.costCenter?.costCategory?.alias+params.costCenter?.alias
        	projectInstance.ref = key+'-'+receiptSequenceService.getNext(key)
        	}
        

        if (!projectInstance.hasErrors() && balCheck.allow && projectInstance.save()) {
            message="Successfully saved!!"
            state = "OK"
            //send comms
            if(projectInstance.status=="SUBMITTED_REQUEST") {
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
	return CostCenter.findByOwner(Individual.get(indid))
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
		if(pqb>(cc.quarterBudget?:0))
			msg.add("Projected quaterly balance: "+pqb+" exceeds allocated quaterly budget: "+(cc.quarterBudget?:0))
		if(pyb>(cc.yearBudget?:0))
			msg.add("Projected yearly balance: "+pyb+" exceeds allocated yearly budget: "+(cc.yearBudget?:0))
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
		if(pcqb>(cc.capitalQuarterBudget?:0))
			msg.add("Projected capital quaterly balance: "+pcqb+" exceeds allocated capital quaterly budget: "+(cc.capitalQuarterBudget?:0))
		if(pcyb>(cc.capitalYearBudget?:0))
			msg.add("Projected capital yearly balance: "+pcyb+" exceeds allocated capital yearly budget: "+(cc.capitalYearBudget?:0))
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
     	def unsettledExpenses = Project.findAllByCostCenterAndStatus(cc,'APPROVED_REQUEST')
     	//find all unsettled expenses for more than a month
     	def cutoffDate = new Date()-30
     	def unsettledExpensesBeyondCutoff = Project.createCriteria().list{
     						eq('costCenter',cc)
     						eq('status','APPROVED_REQUEST')
     						le('submitDate',cutoffDate)
     						order('submitDate')
     						}
     	return [unsettledExpenses:unsettledExpenses,unsettledExpensesBeyondCutoff:unsettledExpensesBeyondCutoff]
     }

    def changeState(Map params) {
  	def ignoreCategory = true
  	def message = ""
  	def projectInstance = Project.get(params.projectid)
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

		//set reviewer1 fields
		def username = ''
		try{
		username = springSecurityService.principal.username
		}
		catch(Exception e){username='unknown'}

		projectInstance.updator = username
		
		switch(params.approver) {
			case 'ROLE_CG_OWNER':
				projectInstance.reviewer1 = Individual.findByLoginid(username)
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
			//update cost center balance
			if(projectInstance.status == 'REJECTED_REQUEST') {
				def cc = projectInstance.costCenter
				if(ignoreCategory || projectInstance.category=='REVENUE') {
					cc.balance = (cc.balance?:0) - projectInstance.amount
					cc.quarterBalance =  (cc.quarterBalance?:0) - projectInstance.amount
					cc.yearBalance = (cc.yearBalance?:0) - projectInstance.amount
				}
				if(projectInstance.category=='CAPITAL') {
					cc.capitalBalance =  (cc.capitalBalance?:0) - projectInstance.amount
					cc.capitalQuarterBalance = (cc.capitalQuarterBalance?:0) - projectInstance.amount
					cc.capitalYearBalance = (cc.capitalYearBalance?:0)-projectInstance.amount
				}
				if(!cc.save())
				    cc.errors.allErrors.each {
						log.debug("changeState:Exception in updating cc"+it)
					    }
			}
			if(projectInstance.status == 'APPROVED_REQUEST') {
				def cc = projectInstance.costCenter
				if(ignoreCategory || projectInstance.category=='REVENUE') {
					cc.balance = (cc.balance?:0) +projectInstance.amount
					cc.quarterBalance = (cc.quarterBalance?:0) + projectInstance.amount
					cc.yearBalance = (cc.yearBalance?:0) + projectInstance.amount
				}
				if(projectInstance.category=='CAPITAL') {
					cc.capitalBalance = (cc.capitalBalance?:0) + projectInstance.amount
					cc.capitalQuarterBalance = (cc.capitalQuarterBalance?:0) + projectInstance.amount
					cc.capitalYearBalance = (cc.capitalYearBalance?:0) + projectInstance.amount
				}
				if(!cc.save())
				    cc.errors.allErrors.each {
						log.debug("changeState:Exception in updating cc"+it)
					    }
			}
		    //send comms
		    def stage=''
		    if(projectInstance.status=="APPROVED_REQUEST")
		    	stage = 'ProjectApproval'
		    else if(projectInstance.status=="APPROVED_REPORT")
		    	stage = 'ExpenseApproval'		    	
		    
		    if(stage) {
			try{
			sendComms(projectInstance,stage)
			}
			catch(Exception e){log.debug(e)}
		    }
					
		}
	}
	message = projectInstance.ref+" updated!"
    	return message
    }
    
    def getProjects(CostCenter cc, String status) {
    	Project.findAllByCostCenterAndStatus(cc,status)
    }
    
    def saveReport(params) {
    	def project = Project.get(params.projectid)
    	def expense,amount
 
         def username = ''
         try{
         username = springSecurityService.principal.username
         }
         catch(Exception e){username='unknown'}
         

    	for(int i=0;i<10;i++) {
    		if(params.('part_'+i)) {
    			try{
    				amount = new BigDecimal(params.('amount_'+i))
    			}
    			catch(Exception e) {
    				amount=0
    			}
    			if(amount>0) {
    				expense = new Expense()
    				expense.department = Department.findByCostCenter(project.costCenter)?:Department.findByName("Finance")//@TODO: hardcoded
    				expense.project = project
    				expense.costCenter = project.costCenter
    				expense.raisedBy = project.submitter
    				expense.raisedOn = new Date()
    				expense.type = params.('type_'+i)?:''
    				expense.category = "EMS"
    				expense.description = params.('part_'+i)
    				expense.amount = amount
    				if(params.('invoiceAvailable_'+i))
    					expense.invoiceAvailable = params.('invoiceAvailable_'+i)
    				expense.invoiceRaisedBy = params.('invoiceRaisedBy_'+i)
    				expense.invoiceNo = params.('invoiceNo_'+i)
    				expense.invoiceDate = params.('invoiceDate_'+i)?(Date.parse('dd-MM-yyyy', params.('invoiceDate_'+i))):null
    				expense.invoicePaymentMode = params.('mode.id_'+i)?PaymentMode.get(params.('mode.id_'+i)):null
				try{
				def key = 'EXI-'+housekeepingService?.getFY()+'-'+project.costCenter?.costCategory?.alias+project.costCenter?.alias
				expense.ref = key+'-'+receiptSequenceService.getNext(key)
				}
				catch(Exception e){log.debug(e)}
    				if(params.reportstatus=='SUBMIT')
    					expense.status = 'SUBMITTED'
    				else
    					expense.status = 'DRAFTED'
    				try{
    					expense.expenseDate = Date.parse('dd-MM-yyyy', params.('expdate_'+i))
    				}
    				catch (Exception e) {expense.expenseDate = new Date()}
    				expense.creator = expense.updator = username
    				if(!expense.save()) 
				    expense.errors.allErrors.each {
						log.debug("saveReport:Exception in saving expense"+it)
					    }
    			}
    		}
    	}
    	
    	//now update overall project status
    	switch(params.reportstatus) {
    		case 'SUBMIT':
    			project.status = 'SUBMITTED_REPORT'
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
    
    def sendComms(Project project, String stage) {
	    def individual,number,toemail,subject,templateCode
	    def contentParams = []

	    
	    switch(stage) {
	    	case "ProjectSubmission" :
			individual = project.costCenter.costCenterGroup.owner
			number = VoiceContact.findByCategoryAndIndividual('CellPhone',individual)?.number
			toemail = EmailContact.findByCategoryAndIndividual('Personal',individual)?.emailAddress
			templateCode = "EMS_PROJ_SUB"
			contentParams = [project.costCenter.name,project.amount?.toString(),project.priority.substring(0,2),project.submitDate.format('dd-MM-yyyy HH:mm:ss')]
			subject = project.ref+" Amount:"+project.amount+" Priority:"+project.priority+" by:"+project.costCenter.name+" submitted for approval."
	    		break
	    	case "ProjectApproval" :
			individual = project.submitter
			number = VoiceContact.findByCategoryAndIndividual('CellPhone',individual)?.number
			toemail = EmailContact.findByCategoryAndIndividual('Personal',individual)?.emailAddress
			templateCode = "EMS_PROJ_APP"
			contentParams = [project.ref,project.amount?.toString(),project.priority.substring(0,2),project.submitDate.format('dd-MM-yyyy HH:mm:ss')]
			subject = project.ref+" Amount:"+project.amount+" Priority:"+project.priority+" approved."
	    		break
	    	case "ExpenseSubmission" :
			individual = project.costCenter.costCenterGroup.owner
			number = VoiceContact.findByCategoryAndIndividual('CellPhone',individual)?.number
			toemail = EmailContact.findByCategoryAndIndividual('Personal',individual)?.emailAddress
			templateCode = "EMS_EXP_SUB"
			contentParams = [project.costCenter.name,project.amount?.toString(),project.priority.substring(0,2),project.submitDate.format('dd-MM-yyyy HH:mm:ss')]
			subject = project.ref+" Amount:"+project.amount+" Priority:"+project.priority+" by:"+project.costCenter.name+" submitted for settlement."
	    		break
	    	case "ExpenseApproval" :
			individual = project.submitter
			number = VoiceContact.findByCategoryAndIndividual('CellPhone',individual)?.number
			toemail = EmailContact.findByCategoryAndIndividual('Personal',individual)?.emailAddress
			templateCode = "EMS_EXP_APP"
			contentParams = [project.ref,project.amount?.toString(),project.priority.substring(0,2),project.submitDate.format('dd-MM-yyyy HH:mm:ss')]
			subject = project.ref+" Amount:"+project.amount+" Priority:"+project.priority+" settlement approved."
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
    	def expidList = params.expids.tokenize(',').collect{new Long(it)}
    	log.debug("expidList:"+expidList)
    	def expenseInstanceList = []
    	if(expidList.size()>0) 
		expenseInstanceList = Expense.createCriteria().list(){'in'("id",expidList)}
	def voucher
    	if(expenseInstanceList.size()>0) {
    		voucher = new Voucher()
    		voucher.type=params.type//@TODO: derive from this
    		voucher.voucherDate=new Date()
    		voucher.ledger=expenseInstanceList[0].costCenter?.costCategory?.alias+expenseInstanceList[0].costCenter?.alias
    		voucher.anotherLedger=params.anotherLedger?:expenseInstanceList[0].invoiceRaisedBy
    		voucher.amount=expenseInstanceList.sum{it.amount}
    		voucher.debit=false
    		voucher.refNo='expense/show/'+params.expids
    		voucher.description=params.description
    		voucher.status="CREATED"
    		voucher.creator = voucher.updator = username
		try{
		def key = 'EVP-'+housekeepingService?.getFY()+'-ACC'
		voucher.voucherNo = key+'-'+receiptSequenceService.getNext(key)
		}
		catch(Exception e){log.debug(e)}
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
         def reviewer3 = null
         def username=''
         try{
		 username = springSecurityService.principal.username
		 reviewer3 = Individual.findByLoginid(username)
         }
         catch(Exception e){username='unknown'}
    	def project = Project.get(params.projectId)
    	if(project) {
    		project.reviewer3 = reviewer3
    		project.review3Date = new Date()
    		project.review3Comments = params.review3Comments
    		project.status = 'REJECTED_REPORT'
		if(!project.save())
			project.errors.allErrors.each {log.debug("saveRejectProject:"+it)}			    		
    	}
    	return "DONE"
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
    	catch(Exception e) { log.debug("updateBudget"+e) } 
    	return false
    }
    
    
    
}
