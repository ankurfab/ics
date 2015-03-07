package ics
import groovy.sql.Sql;
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class FinanceService {

    def springSecurityService
    def dataSource
    def helperService
    def housekeepingService
    def receiptSequenceService
    
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
    	
    	def month = 4	//starting month i.e  April
    	
    	def start,end,ts='-01 00:00:00'
    	
    	//periods
    	def q1start = year+'-04-01 00:00:00'
    	def q1end = year+'-07-01 00:00:00'
    	def q2start = year+'-07-01 00:00:00'
    	def q2end = year+'-10-01 00:00:00'
    	def q3start = year+'-10-01 00:00:00'
    	def q3end = (year+1)+'-01-01 00:00:00'
    	def q4start = (year+1)+'-01-01 00:00:00'
    	def q4end = (year+1)+'-04-01 00:00:00'
    	
    	//for 4 qtrs
    	def quarter,stryear=''+year
    	for(int i=0;i<4;i++) {
		quarter = new Integer(i+1)
		switch(i) {
			case 0:
				populateStats(stryear,quarter,q1start,q1end)
				break
			case 1:
				populateStats(stryear,quarter,q2start,q2end)
				break
			case 2:
				populateStats(stryear,quarter,q3start,q3end)
				break
			case 3:
				populateStats(stryear,quarter,q4start,q4end)
				break
			default:
				break
		}
    	}
    	
    	return "OK"
    }
    
    def populateStats(String year, Integer quarter, String start,String end) {
	def sql = new Sql(dataSource)

	def queryIncome="select cc.id ccid,sum(amount) amount from donation d, scheme s, cost_center cc where d.scheme_id=s.id and s.cc_id=cc.id and d.fund_receipt_date>='"+start+"' and d.fund_receipt_date<'"+end+"' group by cc.id"
	log.debug(queryIncome)
	def queryIncomeResults = sql.rows(queryIncome)
	log.debug(queryIncomeResults)
	storeStats(queryIncomeResults, 'INCOME', year, quarter)

	def queryExpense="SELECT department_code_id ccid,(sum(amount) - sum(amount_settled)) amount FROM voucher v where voucher_date>='"+start+"' and voucher_date<'"+end+"' group by department_code_id"
	log.debug(queryExpense)
	def queryExpenseResults = sql.rows(queryExpense)
	log.debug(queryExpenseResults)
	storeStats(queryExpenseResults, 'EXPENSE', year, quarter)

	sql.close()

	return "OK"
    }
    
    def createStatsAttributesForCostCenter(CostCenter cc, String year) {
    	def attribute
	for(int q=1;q<5;q++) {	//for 4 qtrs
		for(int i=0;i<2;i++) {	//for income and expense
			attribute = new Attribute()
			attribute.domainClassName='CostCenter'
			attribute.domainClassAttributeName=cc.id	//id of the object
			attribute.category=year	//financial year
			attribute.type=(i==0?'INCOME':'EXPENSE')
			attribute.name='amount'
			attribute.displayName='Amount'
			attribute.position=q	//quarter
			if(!attribute.save()) {
			    attribute.errors.allErrors.each {
					log.debug("createStatsAttributesForCostCenter:Exception in saving attr"+it)
				    }
			}
		}
	}
	return true    	
    }
    
    def createStatsAttributes(Map params) {
    	if(params.cc)
    		createStatsAttributesForCostCenter(params.cc,params.year)
    	else
		CostCenter.list().each{
			createStatsAttributesForCostCenter(it,params.year)
		}
    }

    def storeStats(Object results, String type, String year, Integer quarter) {
    	def attr,attributeValue
    	results.each{result->
    		log.debug("storing for:"+result)
    		attr = Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:result.ccid?.toString(),category:year,type:type,position:quarter)
		if(attr && result.amount) {
			attributeValue = new AttributeValue()
			attributeValue.attribute  = attr
			attributeValue.objectClassName = attr.domainClassName
			attributeValue.objectId = new Long(attr.domainClassAttributeName)
			attributeValue.value = result.amount
			attributeValue.creator = attributeValue.updator = 'system'
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
        
        params.submittedBy = Individual.findByLoginid(username)
        params.submitDate = new Date()

        def message,state
        
        params.status = params.submitStatus
        
        def projectInstance = new Project(params)
        
        //adjust advance amount to be upto expense amount only
        if(projectInstance.advanceAmount) {
        	if(projectInstance.advanceAmount>projectInstance.amount)
        		projectInstance.advanceAmount = projectInstance.amount
        	}
        
        //apply rules
        def balCheck = checkBalance(params.costCenter, params.amount, params.category)
        log.debug(balCheck)
        
        //set ref
        if(!projectInstance.hasErrors() && balCheck.allow && !params.ref) {
        	def key = 'EXP-'+housekeepingService?.getFY()+'-'+params.costCenter?.alias
        	projectInstance.ref = key+'-'+receiptSequenceService.getNext(key)
        	}
        

        if (!projectInstance.hasErrors() && balCheck.allow && projectInstance.save()) {
            message="Successfully saved!!"
            state = "OK"
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
         else  if (SpringSecurityUtils.ifAnyGranted('ROLE_CCAT_OWNER') ){
            return ccatownerStats(user)
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
 
     def ccatownerStats(String user) {
    	def result = Project.createCriteria().list(){
			costCenter{
				costCategory{owner{eq('loginid',user)}}
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
     	
     	if(category=="REVENUE")  {
		def msg=[]
		def pb = (cc.balance?:0)+amt
		def pqb = (cc.quarterBalance?:0)+amt
		def pyb = (cc.yearBalance?:0)+amt
		if(pb>(cc.budget?:0)) {
			allow = false
			msg.add("Projected monthly balance: "+pb+" exceeds allocated monthly budget: "+(cc.budget?:0))
			}
		if(pb>(cc.quarterBudget?:0))
			msg.add("Projected quaterly balance: "+pb+" exceeds allocated quaterly budget: "+(cc.quarterBudget?:0))
		if(pb>(cc.yearBudget?:0))
			msg.add("Projected yearly balance: "+pb+" exceeds allocated yearly budget: "+(cc.yearBudget?:0))
		response.put('msg',msg)
     	}
     	else if(category=="CAPITAL")  {
		//@TODO: domain model changes for cost center capital budget
		/*def pb = (cc.balance?:0)+amt
		def pqb = (cc.quarterBalance?:0)+amt
		def pyb = (cc.yearBalance?:0)+amt
		if(pb>(cc.budget?:0)) {
			allow = false
			msg.put('pb',"Projected monthly balance: "+pb+" exceeds allocated monthly budget: "+(cc.budget?:0))
			}
		if(pb>(cc.quarterBudget?:0))
			msg.put('pq',"Projected quaterly balance: "+pb+" exceeds allocated quaterly budget: "+(cc.quarterBudget?:0))
		if(pb>(cc.yearBudget?:0))
			msg.put('py',"Projected yearly balance: "+pb+" exceeds allocated yearly budget: "+(cc.yearBudget?:0))*/
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
			case 'ROLE_CCAT_OWNER':
				projectInstance.reviewer1 = Individual.findByLoginid(username)
				projectInstance.review1Date = new Date()
				break
			case 'ROLE_FINANCE':
				projectInstance.reviewer2 = Individual.findByLoginid(username)
				projectInstance.review2Date = new Date()
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
			if(projectInstance.status == 'APPROVED_REQUEST') {
				def cc = projectInstance.costCenter
				cc.balance += projectInstance.amount
				cc.quarterBalance += projectInstance.amount
				cc.yearBalance += projectInstance.amount
				if(!cc.save())
				    cc.errors.allErrors.each {
						log.debug("changeState:Exception in updating cc"+it)
					    }
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
    				expense.type = params.('type_'+i)
    				expense.category = "EMS"
    				expense.description = params.('part_'+i)
    				expense.amount = amount    				 
    				expense.status = 'SUBMITTED'
    				try{
    					expense.expenseDate = Date.parse('dd-MM-yyyy', params.('expdate_'+i))
    				}
    				catch (Exception e) {}
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
	if(!project.save()) 
	    project.errors.allErrors.each {
			log.debug("saveReport:Exception in updating project"+it)
		    }
    	
    	return project.ref+" expense report submitted!"
    	
    }

}
