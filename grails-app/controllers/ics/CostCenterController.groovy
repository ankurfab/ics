package ics

import grails.converters.JSON
import groovy.sql.Sql;
import java.util.zip.ZipOutputStream  
import java.util.zip.ZipEntry  
import org.grails.plugins.csv.CSVWriter
import org.apache.commons.lang.StringEscapeUtils.*

class CostCenterController {
    def springSecurityService
    def dataSource
    def reportService
    def commsService
    def financeService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = 200
        [costCenterInstanceList: CostCenter.findAllByStatusIsNull(params), costCenterInstanceTotal: CostCenter.count()]
    }

    def create = {
        def costCenterInstance = new CostCenter()
        costCenterInstance.properties = params
        return [costCenterInstance: costCenterInstance]
    }

    def save = {
	log.debug("CostCenter save:"+params)
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        def costCenterInstance = new CostCenter(params)
        if(!costCenterInstance.budget)
        	costCenterInstance.budget = 0
        if(!costCenterInstance.balance)
        	costCenterInstance.balance = 0
        if (!costCenterInstance.hasErrors() && costCenterInstance.save()) {
            //also create the corresponding default scheme
            def scheme = new Scheme()
            scheme.name = costCenterInstance.name
            scheme.minAmount = 1
            scheme.description = "For default donations"
            scheme.effectiveFrom = new Date()
            scheme.effectiveTill = scheme.effectiveFrom + 5*365	//for 5 years
            scheme.category = "Linked"
            scheme.benefits = "General"
            scheme.cc = costCenterInstance
            scheme.updator=scheme.creator=springSecurityService.principal.username
            if(!scheme.save())
            	scheme.errors.allErrors.each { println it   }
            else
            	log.debug("Created default scheme for costcenter.."+scheme)
            
            flash.message = "costCenter.created"
            flash.args = [costCenterInstance.id]
            flash.defaultMessage = "CostCenter ${costCenterInstance.id} created"
            redirect(action: "show", id: costCenterInstance.id)
        }
        else {
            render(view: "create", model: [costCenterInstance: costCenterInstance])
        }
    }

    def show = {
	    if (request.xhr) {
		      def costCategoryCode = params.cc[0..1]
		      def costCenterCode = params.cc[-3..-1]
		      log.debug("Inside ajax costcenter show :"+costCategoryCode+":"+costCenterCode)
		      def costCategory = CostCategory.findByAlias(costCategoryCode)
		      def costCenter = CostCenter.findByCostCategoryAndAliasAndStatusIsNull(costCategory,costCenterCode)
		      //also check count of schemes associated
		      //if only one scheme then return the schemeid as well
		      def schemes = Scheme.findAllByCc(costCenter)
		      def response = [cctext:costCenter?.toString(),schemes:schemes?.collect{[id:it.id,name:it.name]}]
		      render response as JSON
		      return
	    }
        def costCenterInstance = CostCenter.get(params.id)
        if (!costCenterInstance) {
            flash.message = "costCenter.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CostCenter not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [costCenterInstance: costCenterInstance]
        }
    }

    def edit = {
        def costCenterInstance = CostCenter.get(params.id)
        if (!costCenterInstance) {
            flash.message = "costCenter.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CostCenter not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [costCenterInstance: costCenterInstance]
        }
    }

    def update = {
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator=""

        def costCenterInstance = CostCenter.get(params.id)
        if (costCenterInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (costCenterInstance.version > version) {
                    
                    costCenterInstance.errors.rejectValue("version", "costCenter.optimistic.locking.failure", "Another user has updated this CostCenter while you were editing")
                    render(view: "edit", model: [costCenterInstance: costCenterInstance])
                    return
                }
            }
            costCenterInstance.properties = params
            if (!costCenterInstance.hasErrors() && costCenterInstance.save()) {
                flash.message = "costCenter.updated"
                flash.args = [params.id]
                flash.defaultMessage = "CostCenter ${params.id} updated"
                redirect(action: "show", id: costCenterInstance.id)
            }
            else {
                render(view: "edit", model: [costCenterInstance: costCenterInstance])
            }
        }
        else {
            flash.message = "costCenter.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CostCenter not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def costCenterInstance = CostCenter.get(params.id)
        if (costCenterInstance) {
            try {
                //first delete the scheme
                def scheme = Scheme.findByCc(costCenterInstance)
                //check if any donations on this scheme
                def donationCount = Donation.countByScheme(scheme)
                if(!donationCount || donationCount==0)
                	scheme?.delete()
                
                costCenterInstance.delete()
                flash.message = "costCenter.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "CostCenter ${params.id} deleted"
                redirect(action: "list")
            }
            catch (Exception e) {
                flash.message = "costCenter.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "CostCenter ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "costCenter.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "CostCenter not found with id ${params.id}"
            redirect(action: "list")
        }
    }
    
    def statement() {
    }
    
    def statementReport() {
    	log.debug("In statementReport with params: "+params)
    	
    	def cc = CostCenter.get(params.'costCenter.id')
    	def ccat
    	if(params.'costCategory.id')
    		ccat = CostCategory.get(params.'costCategory.id')
    		
     	def fd='',td=''
    	if(params.fromDate)
    		fd = Date.parse('dd-MM-yyyy', params.fromDate)
    	else
    		fd = new Date()
    	
 	fd.clearTime()

    	if(params.toDate)
    		td = Date.parse('dd-MM-yyyy', params.toDate)
    	else
    		td = fd+1
    	
 	td.clearTime()

	
	def result
	def initialBalance = 0
	def totalIncome = 0
	def totalExpense = 0
	
	if(ccat){
		result = reportService.costCategoryStatement(ccat,fd,td)
		initialBalance = result.first()?.balance?:0
	}
	else
	{
		result = reportService.ccStatement(cc,fd,td)
		if(result.size() > 0){
			initialBalance = result.first()?.balance?:0
			result.each {
				totalIncome += it.income?:0
				totalExpense += it.expense?:0
			}
		}
		def finalBalance = initialBalance + totalIncome - totalExpense
	}
    [ccat:ccat, cc: cc,fd:fd, td: td, balance:initialBalance, records: result, totalIncome:totalIncome, totalExpense:totalExpense]
    }

    def budget(){}
    
    def jq_budget_list = {
      log.debug("jq_budget_list:"+params)
      def sortIndex = "name"
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = CostCenter.createCriteria().list(max:maxRows, offset:rowOffset) {
		if (params.searchField=='ccatname')
			costCategory{ilike('name',params.searchString)}

		if (params.searchField=='ccname')
			ilike('name',params.searchString)

		if (params.ccname)
			ilike('name',params.ccname)

		if (params.cgname)
			costCenterGroup{ilike('name',params.cgname)}

		if (params.isProfitCenter=='Yes')
			eq('isProfitCenter',true)

		if (params.isProfitCenter=='No')
			eq('isProfitCenter',false)

		if (params.isServiceCenter=='Yes')
			eq('isServiceCenter',true)

		if (params.isServiceCenter=='No')
			eq('isServiceCenter',false)


		costCategory{order("name")}
		order(sortIndex, sortOrder)
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)
      
      def categoryList = []
      def typeList = []
      
      if(params.category)
      	categoryList.add(params.category)
      else
      	categoryList = ['Income','Expense']
     
      if(params.type)
      	typeList.add(params.type)
      else
      	typeList = ['Projected','Actual']

      def jsonCells=[]
      result.each {
            if(!it.budget)
            	it.budget = 0
            categoryList.each{category->
            	typeList.each{type->            	            
            	jsonCells.add([cell: [
            	    it.costCategory?.name,
            	    it.name,
            	    it.costCenterGroup?.name,
            	    it.isProfitCenter?'Yes':'No',
            	    it.isServiceCenter?'Yes':'No',
            	    category,
            	    type,
            	    AttributeValue.findByAttribute(Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:it.id.toString(),category:'2014',type:category+'_'+type,position:1))?.value?:0,
            	    AttributeValue.findByAttribute(Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:it.id.toString(),category:'2014',type:category+'_'+type,position:2))?.value?:0,
            	    AttributeValue.findByAttribute(Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:it.id.toString(),category:'2014',type:category+'_'+type,position:3))?.value?:0,
            	    AttributeValue.findByAttribute(Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:it.id.toString(),category:'2014',type:category+'_'+type,position:4))?.value?:0,
            	    AttributeValue.findByAttribute(Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:it.id.toString(),category:'2014',type:category+'_'+type,position:5))?.value?:0,
            	    AttributeValue.findByAttribute(Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:it.id.toString(),category:'2014',type:category+'_'+type,position:6))?.value?:0,
            	    AttributeValue.findByAttribute(Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:it.id.toString(),category:'2014',type:category+'_'+type,position:7))?.value?:0,
            	    AttributeValue.findByAttribute(Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:it.id.toString(),category:'2014',type:category+'_'+type,position:8))?.value?:0,
            	    AttributeValue.findByAttribute(Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:it.id.toString(),category:'2014',type:category+'_'+type,position:9))?.value?:0,
            	    AttributeValue.findByAttribute(Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:it.id.toString(),category:'2014',type:category+'_'+type,position:10))?.value?:0,
            	    AttributeValue.findByAttribute(Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:it.id.toString(),category:'2014',type:category+'_'+type,position:11))?.value?:0,
            	    AttributeValue.findByAttribute(Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:it.id.toString(),category:'2014',type:category+'_'+type,position:12))?.value?:0,
                ], id: it.id])
                }
                }
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_budget = {
	      log.debug('In jq_budget_edit:'+params)
	      def cc = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  break;
		case 'del':
		  break;
		 default :
		  // edit action
		  // first retrieve the cc by its ID
		  cc = CostCenter.get(params.id)
		  if (cc) {
		    // set the properties according to passed in parameters
		    try{
		    	cc.budget = new Long(params.budget)/12
		    }
		    catch(Exception e){
		    	log.debug(e)
		    	cc.budget = 0
		    	}
		    cc.updator = springSecurityService.principal.username
		    if (! cc.hasErrors() && cc.save()) {
		      message = "Budget Updated"
		      id = cc.id
		      state = "OK"
		    } else {
			    cc.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Budget"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }    
	
	//http://localhost:8080/ics/costCenter/populateStats?year=2014
	def populateStats() {
		def result = financeService.populateStats(params)
		render result
	}
	
	//http://localhost:8080/ics/costCenter/createStatsAttributes?year=2014
	def createStatsAttributes() {
		def result = financeService.createStatsAttributes(params)
		render result
	}
	
	//http://localhost:8080/ics/costCenter/resetStatsAttributes?year=2014
	def resetStatsAttributes() {
		def result = financeService.resetStatsAttributes(params)
		render ([message:result] as JSON)
	}

	def summary(){
		[year:params.year?:new Date().format('yyyy')]
	}
	
	def budgetchart()  {
		def costCenterInstance = CostCenter.get(params.id)
		render(template: "budget", model: [costCenterInstance: costCenterInstance,year:params.year])
	}

    def showOwner() {
                def ownerid = CostCenter.get(params.id)?.owner1?.id
                redirect(controller:"individual",action: "show", id: ownerid)    	
                return
    }

    def downloadCurrentBudget() {
    	log.debug("Inside downloadCurrentBudget with params:"+params)

    	def cclist = CostCenter.findAllByStatusIsNull()
    	
    	response.contentType = 'application/zip'

    	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		def now = new Date()
		def ts = now.format('dd-MM-yyyy HH:mm:ss')
		def fileName = "budget_"+now.format('ddMMyyHHmmss')+".csv"
		zipOutputStream.putNextEntry(new ZipEntry(fileName))
		//header
		zipOutputStream << "Date,ccId,ccCode,costcategory,costcenter,vertical,isProfitCenter,isServiceCenter,assigned,consumed,available" 
		cclist.each{ cc ->
			zipOutputStream << "\n"
			zipOutputStream <<ts+","+cc.id +","+cc.alias +","+
				cc.costCategory?.name +","+
				cc.name +","+
				cc.costCenterGroup?.name +","+
				(cc.isProfitCenter?'Y':'N') +","+
				(cc.isServiceCenter?'Y':'N') +","+
				(cc.budget?:'') +","+
				(cc.balance?:'') +","+
				((cc.budget?:0)-(cc.balance?:0))
		}
	}    	    	
    }
    
    def uploadCurrentBudget() {
    	log.debug("Inside uploadCurrentBudget with params:"+params)
	    def f = request.getFile('myFile')
	    if (f.empty) {
		flash.message = 'file cannot be empty'
		render flash.message
		return
	    }

	    def numRecords = 0, numCreated=0

	    //lock expense creation first
	    financeService.lockExpenseCreation()
	    
	    f.inputStream.toCsvReader(['skipLines':'1']).eachLine{ tokens ->
	    	numRecords++
	    	if(financeService.uploadCurrentBudget(tokens))
	    		numCreated++
	    }
	    
	    //unlock expense creation
	    financeService.unlockExpenseCreation()
	    
	    flash.message="Uploaded "+numCreated+"/"+numRecords+" records!!"
	    
	    render flash.message
	    return
    }


    def downloadBudget() {
    	log.debug("Inside downloadBudget with params:"+params)
	def year = params.dlyear
	    if(!year) {
		flash.message = "For DownloadBudget Please provide year!!"
		redirect (action: "budget")
		return	    	
	    }
	//create stats in case some thing was missing
	financeService.createStatsAttributes([year:year])

    	response.contentType = 'application/zip'
    	def query = "select c.id ccId,concat(ccat.alias,c.alias) ccCode,ccat.name costcategory,c.name costcenter,cg.name vertical,if(c.is_profit_center,'Yes','No') isProfitCenter,if(c.is_service_center,'Yes','No') isServiceCenter,a.type,if(a.position<10,a.position+3,a.position-9) month,av.value amount  from cost_center c left join cost_center_group cg on c.cost_center_group_id=cg.id, cost_category ccat, attribute a left join attribute_value av on av.attribute_id=a.id where c.cost_category_id=ccat.id and c.id=a.domain_class_attribute_name and a.domain_class_name='CostCenter' and a.category='"+year+"'"
    	def sql = new Sql(dataSource)

    	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		def fileName = "budget_fy"+year+"_"+new Date().format('ddMMyyHHmmss')+".csv"
		zipOutputStream.putNextEntry(new ZipEntry(fileName))
		//header
		zipOutputStream << "ccId,ccCode,costcategory,costcenter,vertical,isProfitCenter,isServiceCenter,type,month,amount" 
		sql.eachRow(query){ row ->
			zipOutputStream << "\n"
			zipOutputStream <<row.ccId +","+row.ccCode +","+
				row.costcategory +","+
				row.costcenter +","+
				row.vertical +","+
				row.isProfitCenter +","+
				row.isServiceCenter +","+
				row.type +","+
				row.month +","+
				row.amount
		}
	}    	    	
    }
    
    def uploadBudget() {
    	log.debug("Inside uploadBudget with params:"+params)
	    def f = request.getFile('myFile')
	    if (f.empty) {
		flash.message = 'file cannot be empty'
		render(view: 'budget')
		return
	    }

	    def numRecords = 0, numCreated=0
	    def year = params.ulyear
	    if(!year) {
	    	flash.message = "For UploadBudget Please provide year!!"
	    	redirect (action: "budget")
	    	return	    	
	    }

	    //create stats in case some thing was missing
	    financeService.createStatsAttributes([year:year])
	    
	    //lock expense creation first
	    financeService.lockExpenseCreation()
	    
	    f.inputStream.toCsvReader(['skipLines':'1']).eachLine{ tokens ->
	    	numRecords++
	    	if(financeService.uploadBudget(year,tokens))
	    		numCreated++
	    }
	    
	    //unlock expense creation
	    financeService.unlockExpenseCreation()
	    
	    flash.message="Uploaded "+numCreated+"/"+numRecords+" records!!"
	    
	    redirect (action: "budget")
	    return
    }
    
    def lockExpenseCreation() {
    	financeService.lockExpenseCreation();
    	render "OK"
    }

    def unlockExpenseCreation() {
    	financeService.unlockExpenseCreation();
    	render "OK"
    }

    def uploadForCC() {
	    log.debug("Inside uploadForCC")
	    
	    def f = request.getFile('myFile')
	    if (f.empty) {
		flash.message = 'file cannot be empty'
		render flash.message
		return
	    }

	    def numRecords = 0, numCreated=0
	    //format
	    //name,alias,cg_id,ccat_id,loginid,owner_icsid
	    f.inputStream.toCsvReader(['skipLines':'1']).eachLine{ tokens ->
	    	numRecords++
	    	if(financeService.createCC(tokens))
	    		numCreated++
	    }
	    
	    flash.message="Created "+numCreated+"/"+numRecords+" CCs!!"
	    render flash.message
	    
    }	

    def ccBackup() {
    	response.contentType = 'application/zip'
    	def query = "select ccat.id ccatid,ccat.alias ccat_alias, ccat.name ccatname,cg.id cgid,cg.name cgname,cc.id ccid,cc.alias cc_alias, cc.name ccname,cc.budget,cc.balance consumedbudget,cc.status, cc.last_updated,cc.updator from cost_center cc left join cost_category ccat on cc.cost_category_id=ccat.id left join cost_center_group cg on cc.cost_category_id=cg.id"
    	def sql = new Sql(dataSource)
    	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		def fileName = "cc_"+new Date().format('ddMMyyHHmmss')+".csv"
		zipOutputStream.putNextEntry(new ZipEntry(fileName))
		//header
		def headers = null; //["id","name"]

		sql.rows(query).each{ row ->
			   if (headers == null) {
				headers = row.keySet()
				log.debug("headers:"+headers)
				zipOutputStream << headers
			        zipOutputStream << "\n"
			   }
			//with escaping for excel
			log.debug("row:"+row)
			zipOutputStream << row.values().collect{it.toString()}
			zipOutputStream << "\n"
		}
	}    	
    }

    def createSchemes = {
	log.debug("createSchemes:"+params)
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator

        CostCenter.findAllByStatusIsNull().each{costCenterInstance->
        if(!costCenterInstance.budget)
        	costCenterInstance.budget = 0
        if(!costCenterInstance.balance)
        	costCenterInstance.balance = 0
        if (!Scheme.findByCc(costCenterInstance)) {
            //also create the corresponding default scheme
            def scheme = new Scheme()
            scheme.name = costCenterInstance.name
            scheme.minAmount = 1
            scheme.description = "For default donations"
            scheme.effectiveFrom = new Date()
            scheme.effectiveTill = scheme.effectiveFrom + 5*365	//for 5 years
            scheme.category = "Linked"
            scheme.benefits = "General"
            scheme.cc = costCenterInstance
            scheme.updator=scheme.creator=springSecurityService.principal.username
            if(!scheme.save())
            	scheme.errors.allErrors.each { println it   }
            else
            	log.debug("Created default scheme for costcenter.."+costCenterInstance+":"+scheme)            
        }
    }
    	render "done"
    }

    def orgStructureBackup() {
	response.contentType = 'application/zip'
	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
		def fileName = "orgstructure_"+new Date().format('ddMMyyHHmmss')+".csv"
		zipOutputStream.putNextEntry(new ZipEntry(fileName))
		//header
		zipOutputStream << "alias,costcenter,hod_name,hod_phone,hod_email,hod_login,vert_name,vert_phone,vert_email,vert_login" 

		CostCenter.findAllByStatusIsNull().each{cc->
			zipOutputStream << "\n"
			zipOutputStream <<   (cc.costCategory?.alias+cc.alias?:'')+","+(cc.name?:'')+","+
				  (cc.owner1?.toString()?:'') +","+
				  (VoiceContact.findByCategoryAndIndividual('CellPhone',cc.owner1)?.number?:'').replaceAll(',',';') +","+
				  (EmailContact.findByCategoryAndIndividual('Personal',cc.owner1)?.emailAddress?:'').replaceAll(',',';') +","+
				  (cc.owner?.loginid?:'') +","+
				  (cc.costCenterGroup?.owner1?.toString()?:'') +","+
				  (VoiceContact.findByCategoryAndIndividual('CellPhone',cc.costCenterGroup?.owner1)?.number?:'').replaceAll(',',';') +","+
				  (EmailContact.findByCategoryAndIndividual('Personal',cc.costCenterGroup?.owner1)?.emailAddress?:'').replaceAll(',',';') +","+
				  (cc.costCenterGroup?.owner?.loginid?:'')
		}
	}
	}

	def monthSummary() {}

    def jq_monthSummary_list = {
      log.debug("jq_monthSummary_list:"+params)
      def sortIndex = "name"
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = CostCenter.createCriteria().list(max:maxRows, offset:rowOffset) {
		isNull('status')
		if(params.ccat)
			costCategory{ilike('name',params.ccat)}
		if(params.name)
			ilike('name',params.name)
		if(params.alias)
			eq('alias',params.alias)
		
		order(sortIndex, sortOrder)
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)
      
      def totalBudget=0,totalAvailableBudget=0,totalBalance=0,s_totalExpense=0,s_submittedExpense=0,s_approvedExpense=0,s_draftSettlement=0
      def s_rejectedSettlement=0,s_submittedSettlement=0,s_approvedSettlement=0,s_settledExpense=0,s_advanceIssued=0
      
          def jsonCells = result.collect {
                def stats = financeService.getMonthSummaryStats(it)
                totalBudget += (it.budget?:0)
                totalAvailableBudget += ((it.budget?:0)-(it.balance?:0))
                totalBalance += (it.balance?:0)
                s_totalExpense += stats.totalExpense?:0
                s_submittedExpense += stats.submittedExpense?:0
                s_approvedExpense += stats.approvedExpense?:0
                s_draftSettlement += stats.draftSettlement?:0
                s_rejectedSettlement += stats.rejectedSettlement?:0
                s_submittedSettlement += stats.submittedSettlement?:0
                s_approvedSettlement += stats.approvedSettlement?:0
                s_settledExpense += stats.settledExpense?:0
                s_advanceIssued += stats.advanceIssued?:0
                [cell: [
                	it.id,
                	it.costCategory?.name,
                	it.name,
                	it.alias,
                	it.budget,
                	(it.budget?:0)-(it.balance?:0),
                	it.balance,
                	stats.submittedExpense,
                	stats.approvedExpense,
                	stats.draftSettlement,
                	stats.rejectedSettlement,
                	stats.submittedSettlement,
                	stats.approvedSettlement,
                	stats.settledExpense,
                	stats.advanceIssued,
                	(it.balance==stats.totalExpense)?'ok':'notok'
                    ], id: it.id]
            }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages,userdata:[alias:'Total',budget:totalBudget,remainingbudget:totalAvailableBudget,balance:totalBalance,submittedExpense:s_submittedExpense,approvedExpense:s_approvedExpense,draftSettlement:s_draftSettlement,rejectedSettlement:s_rejectedSettlement,submittedSettlement:s_submittedSettlement,approvedSettlement:s_approvedSettlement,settledExpense:s_settledExpense,advanceIssued:s_advanceIssued]]
        render jsonData as JSON
        }	

	def incomeSummary() {}

    def jq_incomeSummary_list = {
      log.debug("jq_incomeSummary_list:"+params)
      def sortIndex = "name"
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = CostCenter.createCriteria().list(max:maxRows, offset:rowOffset) {
		isNull('status')
		if(params.ccat)
			costCategory{ilike('name',params.ccat)}
		if(params.name)
			ilike('name',params.name)
		if(params.alias)
			eq('alias',params.alias)
		
		order(sortIndex, sortOrder)
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)
      
      def totalApr=0,totalMay=0,totalJune=0,totalJuly=0,totalAug=0,totalSep=0,totalOct=0,totalNov=0,totalDec=0,totalJan=0,totalFeb=0,totalMar=0
      
          def jsonCells = result.collect {
                def stats = financeService.getIncomeSummaryStats(it)
		totalApr += stats.month_4
		totalMay += stats.month_5
		totalJune += stats.month_6
		totalJuly += stats.month_7
		totalAug += stats.month_8
		totalSep += stats.month_9
		totalOct += stats.month_10
		totalNov += stats.month_11
		totalDec += stats.month_12
		totalJan += stats.month_1
		totalFeb += stats.month_2
		totalMar += stats.month_3
                [cell: [
                	it.costCategory?.name,
                	it.name,
                	it.alias,
			stats.month_4,
			stats.month_5,
			stats.month_6,
			stats.month_7,
			stats.month_8,
			stats.month_9,
			stats.month_10,
			stats.month_11,
			stats.month_12,
			stats.month_1,
			stats.month_2,
			stats.month_3,
                    ], id: it.id]
            }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages,userdata:[alias:'Total',apr:totalApr,may:totalMay,june:totalJune,july:totalJuly,aug:totalAug,sep:totalSep,oct:totalOct,nov:totalNov,dec:totalDec,jan:totalJan,feb:totalFeb,mar:totalMar]]
        render jsonData as JSON
        }
        
        def updateBudget() {
        	log.debug("Inside updateBudget with params:"+params)
        	financeService.updateBudget(params)
        	render "OK"
        }

    def jq_audit_list = {
      log.debug("jq_audit_list:"+params)
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = AttributeValue.createCriteria().list(max:maxRows, offset:rowOffset) {
		eq('objectClassName','CostCenter')
		eq('objectId',new Long(params.ccid?:0))
		attribute{eq('name','BudgetAuditTrail')}		
		order(sortIndex, sortOrder)
	}
      
      
	  def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)
            
          def jsonCells = result.collect {
                [cell: [
                	it.dateCreated.format('dd-MM-yyyy HH:mm:ss'),
                	it.creator,
                	it.value,
                    ], id: it.id]
            }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }	

	def incomeSheet() {}

    def jq_incomeSheet_list = {
      log.debug("jq_incomeSheet_list:"+params)

	  def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'
	  def currentPage = Integer.valueOf(params.page) ?: 1
	  def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def maxRows = Integer.valueOf(params.rows)

      def jsonBMSRow = getDonationsByDonorName("Shri Chaitanya Shikshan Sanstha (BMS)", '1) BMS')
	  def jsonHundiRow = getDonationsByDonorName("Hundi%", '2) Hundi')
	  def jsonNityaRow = getDonationsBySchemeName("NITYA%", '3) Nitya Seva')
	  def jsonJanamashtamiRow = getDonationsBySchemeName("Janmastami%", '4) Janamashtami')
	  def jsonNVCCTempleRow = getDonationsByCostCategoryName("Temple", '6) NVCC Temple')
	  def jsonCampTempleRow = getDonationsByCostCategoryName("CAMP TEMPLE", '7) Camp Temple')
	  
		def totalAprFromSpecifics = jsonBMSRow.cell[1] + jsonHundiRow.cell[1] + jsonNityaRow.cell[1] + jsonJanamashtamiRow.cell[1]
		def totalMayFromSpecifics = jsonBMSRow.cell[2] + jsonHundiRow.cell[2] + jsonNityaRow.cell[2] + jsonJanamashtamiRow.cell[2]
		def totalJuneFromSpecifics = jsonBMSRow.cell[3] + jsonHundiRow.cell[3] + jsonNityaRow.cell[3] + jsonJanamashtamiRow.cell[3]
		def totalJulyFromSpecifics = jsonBMSRow.cell[4] + jsonHundiRow.cell[4] + jsonNityaRow.cell[4] + jsonJanamashtamiRow.cell[4]
		def totalAugFromSpecifics = jsonBMSRow.cell[5] + jsonHundiRow.cell[5] + jsonNityaRow.cell[5] + jsonJanamashtamiRow.cell[5]
		def totalSepFromSpecifics = jsonBMSRow.cell[6] + jsonHundiRow.cell[6] + jsonNityaRow.cell[6] + jsonJanamashtamiRow.cell[6]
		def totalOctFromSpecifics = jsonBMSRow.cell[7] + jsonHundiRow.cell[7] + jsonNityaRow.cell[7] + jsonJanamashtamiRow.cell[7]
		def totalNovFromSpecifics = jsonBMSRow.cell[8] + jsonHundiRow.cell[8] + jsonNityaRow.cell[8] + jsonJanamashtamiRow.cell[8]
		def totalDecFromSpecifics = jsonBMSRow.cell[9] + jsonHundiRow.cell[9] + jsonNityaRow.cell[9] + jsonJanamashtamiRow.cell[9]
		def totalJanFromSpecifics = jsonBMSRow.cell[10] + jsonHundiRow.cell[10] + jsonNityaRow.cell[10] + jsonJanamashtamiRow.cell[10]
		def totalFebFromSpecifics = jsonBMSRow.cell[11] + jsonHundiRow.cell[11] + jsonNityaRow.cell[11] + jsonJanamashtamiRow.cell[11]
		def totalMarFromSpecifics = jsonBMSRow.cell[12] + jsonHundiRow.cell[12] + jsonNityaRow.cell[12] + jsonJanamashtamiRow.cell[12]

		def jsonIncomeFromSpecifics = [cell: [
					'5) Total of specific donations',
					totalAprFromSpecifics,
					totalMayFromSpecifics,
					totalJuneFromSpecifics,
					totalJulyFromSpecifics,
					totalAugFromSpecifics,
					totalSepFromSpecifics,
					totalOctFromSpecifics,
					totalNovFromSpecifics,
					totalDecFromSpecifics,
					totalJanFromSpecifics,
					totalFebFromSpecifics,
					totalMarFromSpecifics,
					], 
					id: ""]
	  
	  def totalAprFromTemples = jsonNVCCTempleRow.cell[1] + jsonCampTempleRow.cell[1]
	  def totalMayFromTemples = jsonNVCCTempleRow.cell[2] + jsonCampTempleRow.cell[2]
	  def totalJuneFromTemples = jsonNVCCTempleRow.cell[3] + jsonCampTempleRow.cell[3]
	  def totalJulyFromTemples = jsonNVCCTempleRow.cell[4] + jsonCampTempleRow.cell[4]
	  def totalAugFromTemples = jsonNVCCTempleRow.cell[5] + jsonCampTempleRow.cell[5]
	  def totalSepFromTemples = jsonNVCCTempleRow.cell[6] + jsonCampTempleRow.cell[6]
	  def totalOctFromTemples = jsonNVCCTempleRow.cell[7] + jsonCampTempleRow.cell[7]
	  def totalNovFromTemples = jsonNVCCTempleRow.cell[8] + jsonCampTempleRow.cell[8]
	  def totalDecFromTemples = jsonNVCCTempleRow.cell[9] + jsonCampTempleRow.cell[9]
	  def totalJanFromTemples = jsonNVCCTempleRow.cell[10] + jsonCampTempleRow.cell[10]
	  def totalFebFromTemples = jsonNVCCTempleRow.cell[11] + jsonCampTempleRow.cell[11]
	  def totalMarFromTemples = jsonNVCCTempleRow.cell[12] + jsonCampTempleRow.cell[12]

	  def jsonData= [rows: [jsonBMSRow, jsonHundiRow, jsonNityaRow, jsonJanamashtamiRow, jsonIncomeFromSpecifics, jsonNVCCTempleRow, jsonCampTempleRow], page:currentPage, records:1, total:1, userdata:[name:'Total', apr:totalAprFromTemples, may:totalMayFromTemples, june:totalJuneFromTemples, july:totalJulyFromTemples, aug:totalAugFromTemples, sep:totalSepFromTemples, oct:totalOctFromTemples, nov:totalNovFromTemples, dec:totalDecFromTemples, jan:totalJanFromTemples, feb:totalFebFromTemples, mar:totalMarFromTemples]]

      render jsonData as JSON
    }

	def getDonationsByCostCategoryName (String nameUsedForSearch, String nameUsedForDisplay)
	{
		def stats = financeService.getAllDonationByCostCategoryNameIncomeSummaryStats(nameUsedForSearch)
		def jsonCells = [cell: [
					nameUsedForDisplay,
					stats.month_4,
					stats.month_5,
					stats.month_6,
					stats.month_7,
					stats.month_8,
					stats.month_9,
					stats.month_10,
					stats.month_11,
					stats.month_12,
					stats.month_1,
					stats.month_2,
					stats.month_3,
                    ], 
					id: "testID"]
        return jsonCells
	}

	def getDonationsBySchemeName (String nameUsedForSearch, String nameUsedForDisplay)
	{
		def stats = financeService.getAllDonationBySchemeNameIncomeSummaryStats(nameUsedForSearch)
		def jsonCells = [cell: [
					nameUsedForDisplay,
					stats.month_4,
					stats.month_5,
					stats.month_6,
					stats.month_7,
					stats.month_8,
					stats.month_9,
					stats.month_10,
					stats.month_11,
					stats.month_12,
					stats.month_1,
					stats.month_2,
					stats.month_3,
                    ], 
					id: "testID"]
        return jsonCells
	}
		
	def getDonationsByDonorName (String nameUsedForSearch, String nameUsedForDisplay)
	{
		def stats = financeService.getAllDonationByDonorNameIncomeSummaryStats(nameUsedForSearch)
		def jsonCells = [cell: [
					nameUsedForDisplay,
					stats.month_4,
					stats.month_5,
					stats.month_6,
					stats.month_7,
					stats.month_8,
					stats.month_9,
					stats.month_10,
					stats.month_11,
					stats.month_12,
					stats.month_1,
					stats.month_2,
					stats.month_3,
                    ], 
					id: "testID"]
        return jsonCells
	}

	def exportIncomeSheetEntries() {
		def jsonBMSRow = getDonationsByDonorName("Shri Chaitanya Shikshan Sanstha (BMS)", '1) BMS')
		def jsonHundiRow = getDonationsByDonorName("Hundi%", '2) Hundi')
		def jsonNityaRow = getDonationsBySchemeName("NITYA%", '3) Nitya Seva')
		def jsonJanamashtamiRow = getDonationsBySchemeName("Janmastami%", '4) Janamashtami')
		def jsonNVCCTempleRow = getDonationsByCostCategoryName("Temple", '6) NVCC Temple')
		def jsonCampTempleRow = getDonationsByCostCategoryName("CAMP TEMPLE", '7) Camp Temple')
		def totalAprFromTemples = jsonNVCCTempleRow.cell[1] + jsonCampTempleRow.cell[1]

		def totalMayFromTemples = jsonNVCCTempleRow.cell[2] + jsonCampTempleRow.cell[2]
		def totalJuneFromTemples = jsonNVCCTempleRow.cell[3] + jsonCampTempleRow.cell[3]
		def totalJulyFromTemples = jsonNVCCTempleRow.cell[4] + jsonCampTempleRow.cell[4]
		def totalAugFromTemples = jsonNVCCTempleRow.cell[5] + jsonCampTempleRow.cell[5]
		def totalSepFromTemples = jsonNVCCTempleRow.cell[6] + jsonCampTempleRow.cell[6]
		def totalOctFromTemples = jsonNVCCTempleRow.cell[7] + jsonCampTempleRow.cell[7]
		def totalNovFromTemples = jsonNVCCTempleRow.cell[8] + jsonCampTempleRow.cell[8]
		def totalDecFromTemples = jsonNVCCTempleRow.cell[9] + jsonCampTempleRow.cell[9]
		def totalJanFromTemples = jsonNVCCTempleRow.cell[10] + jsonCampTempleRow.cell[10]
		def totalFebFromTemples = jsonNVCCTempleRow.cell[11] + jsonCampTempleRow.cell[11]
		def totalMarFromTemples = jsonNVCCTempleRow.cell[12] + jsonCampTempleRow.cell[12]

		def totalAprFromSpecifics = jsonBMSRow.cell[1] + jsonHundiRow.cell[1] + jsonNityaRow.cell[1] + jsonJanamashtamiRow.cell[1]
		def totalMayFromSpecifics = jsonBMSRow.cell[2] + jsonHundiRow.cell[2] + jsonNityaRow.cell[2] + jsonJanamashtamiRow.cell[2]
		def totalJuneFromSpecifics = jsonBMSRow.cell[3] + jsonHundiRow.cell[3] + jsonNityaRow.cell[3] + jsonJanamashtamiRow.cell[3]
		def totalJulyFromSpecifics = jsonBMSRow.cell[4] + jsonHundiRow.cell[4] + jsonNityaRow.cell[4] + jsonJanamashtamiRow.cell[4]
		def totalAugFromSpecifics = jsonBMSRow.cell[5] + jsonHundiRow.cell[5] + jsonNityaRow.cell[5] + jsonJanamashtamiRow.cell[5]
		def totalSepFromSpecifics = jsonBMSRow.cell[6] + jsonHundiRow.cell[6] + jsonNityaRow.cell[6] + jsonJanamashtamiRow.cell[6]
		def totalOctFromSpecifics = jsonBMSRow.cell[7] + jsonHundiRow.cell[7] + jsonNityaRow.cell[7] + jsonJanamashtamiRow.cell[7]
		def totalNovFromSpecifics = jsonBMSRow.cell[8] + jsonHundiRow.cell[8] + jsonNityaRow.cell[8] + jsonJanamashtamiRow.cell[8]
		def totalDecFromSpecifics = jsonBMSRow.cell[9] + jsonHundiRow.cell[9] + jsonNityaRow.cell[9] + jsonJanamashtamiRow.cell[9]
		def totalJanFromSpecifics = jsonBMSRow.cell[10] + jsonHundiRow.cell[10] + jsonNityaRow.cell[10] + jsonJanamashtamiRow.cell[10]
		def totalFebFromSpecifics = jsonBMSRow.cell[11] + jsonHundiRow.cell[11] + jsonNityaRow.cell[11] + jsonJanamashtamiRow.cell[11]
		def totalMarFromSpecifics = jsonBMSRow.cell[12] + jsonHundiRow.cell[12] + jsonNityaRow.cell[12] + jsonJanamashtamiRow.cell[12]

    	response.contentType = 'application/zip'
    	new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
			zipOutputStream.putNextEntry(new ZipEntry("incomeSheet.csv"))
			zipOutputStream << "Name,April,May,June,July,August,September,October,November,December,January,February,March"

			zipOutputStream << "\n"
			zipOutputStream << "BMS"+","+jsonBMSRow.cell[1]+","+jsonBMSRow.cell[2]+","+jsonBMSRow.cell[3]+","+jsonBMSRow.cell[4]+","+jsonBMSRow.cell[5]+","+jsonBMSRow.cell[6]+","+jsonBMSRow.cell[7]+","+jsonBMSRow.cell[8]+","+jsonBMSRow.cell[9]+","+jsonBMSRow.cell[10]+","+jsonBMSRow.cell[11]+","+jsonBMSRow.cell[12]

			zipOutputStream << "\n"
			zipOutputStream << "Hundi"+","+jsonHundiRow.cell[1]+","+jsonHundiRow.cell[2]+","+jsonHundiRow.cell[3]+","+jsonHundiRow.cell[4]+","+jsonHundiRow.cell[5]+","+jsonHundiRow.cell[6]+","+jsonHundiRow.cell[7]+","+jsonHundiRow.cell[8]+","+jsonHundiRow.cell[9]+","+jsonHundiRow.cell[10]+","+jsonHundiRow.cell[11]+","+jsonHundiRow.cell[12]

			zipOutputStream << "\n"
			zipOutputStream << "Nitya Seva"+","+jsonNityaRow.cell[1]+","+jsonNityaRow.cell[2]+","+jsonNityaRow.cell[3]+","+jsonNityaRow.cell[4]+","+jsonNityaRow.cell[5]+","+jsonNityaRow.cell[6]+","+jsonNityaRow.cell[7]+","+jsonNityaRow.cell[8]+","+jsonNityaRow.cell[9]+","+jsonNityaRow.cell[10]+","+jsonNityaRow.cell[11]+","+jsonNityaRow.cell[12]

			zipOutputStream << "\n"
			zipOutputStream << "Janamashtami"+","+jsonJanamashtamiRow.cell[1]+","+jsonJanamashtamiRow.cell[2]+","+jsonJanamashtamiRow.cell[3]+","+jsonJanamashtamiRow.cell[4]+","+jsonJanamashtamiRow.cell[5]+","+jsonJanamashtamiRow.cell[6]+","+jsonJanamashtamiRow.cell[7]+","+jsonJanamashtamiRow.cell[8]+","+jsonJanamashtamiRow.cell[9]+","+jsonJanamashtamiRow.cell[10]+","+jsonJanamashtamiRow.cell[11]+","+jsonJanamashtamiRow.cell[12]

			zipOutputStream << "\n"
			zipOutputStream << "Total from Specifics"+","+totalAprFromTemples+","+totalMayFromTemples+","+totalJuneFromTemples+","+totalJulyFromTemples+","+totalAugFromTemples+","+totalSepFromTemples+","+totalOctFromTemples+","+totalNovFromTemples+","+totalDecFromTemples+","+totalJanFromTemples+","+totalFebFromTemples+","+totalMarFromTemples

			zipOutputStream << "\n"
			zipOutputStream << "NVCC Temple"+","+jsonNVCCTempleRow.cell[1]+","+jsonNVCCTempleRow.cell[2]+","+jsonNVCCTempleRow.cell[3]+","+jsonNVCCTempleRow.cell[4]+","+jsonNVCCTempleRow.cell[5]+","+jsonNVCCTempleRow.cell[6]+","+jsonNVCCTempleRow.cell[7]+","+jsonNVCCTempleRow.cell[8]+","+jsonNVCCTempleRow.cell[9]+","+jsonNVCCTempleRow.cell[10]+","+jsonNVCCTempleRow.cell[11]+","+jsonNVCCTempleRow.cell[12]

			zipOutputStream << "\n"
			zipOutputStream << "Camp Temple"+","+jsonCampTempleRow.cell[1]+","+jsonCampTempleRow.cell[2]+","+jsonCampTempleRow.cell[3]+","+jsonCampTempleRow.cell[4]+","+jsonCampTempleRow.cell[5]+","+jsonCampTempleRow.cell[6]+","+jsonCampTempleRow.cell[7]+","+jsonCampTempleRow.cell[8]+","+jsonCampTempleRow.cell[9]+","+jsonCampTempleRow.cell[10]+","+jsonCampTempleRow.cell[11]+","+jsonCampTempleRow.cell[12]

			zipOutputStream << "\n"
			zipOutputStream << "Total"+","+totalAprFromSpecifics+","+totalMayFromSpecifics+","+totalJuneFromSpecifics+","+totalJulyFromSpecifics+","+totalAugFromSpecifics+","+totalSepFromSpecifics+","+totalOctFromSpecifics+","+totalNovFromSpecifics+","+totalDecFromSpecifics+","+totalJanFromSpecifics+","+totalFebFromSpecifics+","+totalMarFromTemples
		}
    }
	
	def exportIncomeSummaryEntries() {
		log.debug("from within exportIncomeSummaryEntries")
		response.contentType = 'application/zip'
		def maxRows = 1000000
		def rowOffset = 0
		def result = CostCenter.createCriteria().list(max:maxRows, offset:rowOffset) {
			isNull('status')
			if(params.ccat)
				costCategory{ilike('name',params.ccat)}
			if(params.name)
				ilike('name',params.name)
			if(params.alias)
				eq('alias',params.alias)
			order(params.sidx, params.sord)
		}

		def totalRows = result.totalCount

		new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
			zipOutputStream.putNextEntry(new ZipEntry("incomeSummary.csv"))
			zipOutputStream << "CostCategory,Name,Alias,April,May,June,July,August,September,October,November,December,January,February,March"

			result.each{ row ->
			def stats = financeService.getIncomeSummaryStats(row)
			zipOutputStream << "\n"
			zipOutputStream << row.costCategory?.name+","+row.name+","+row.alias+","+stats.month_4+","+stats.month_5+","+stats.month_6+","+stats.month_7+","+stats.month_8+","+stats.month_9+","+stats.month_10+","+stats.month_11+","+stats.month_12+","+stats.month_1+","+stats.month_2+","+stats.month_3
			}
		}
    }

	def exportMonthlySummaryEntries() {
		log.debug("from within exportMonthlySummaryEntries")
		response.contentType = 'application/zip'
		def maxRows = 1000000
		def rowOffset = 0
		def result = CostCenter.createCriteria().list(max:maxRows, offset:rowOffset) {
			isNull('status')
			if(params.ccat)
				costCategory{ilike('name',params.ccat)}
			if(params.name)
				ilike('name',params.name)
			if(params.alias)
				eq('alias',params.alias)
			order(params.sidx, params.sord)
		}

		def totalRows = result.totalCount

		new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
			zipOutputStream.putNextEntry(new ZipEntry("monthlySummary.csv"))
			zipOutputStream << "CostCategory,Name,Alias,April,May,June,July,August,September,October,November,December,January,February,March"

			result.each{ row ->
			def stats = financeService.getMonthSummaryStats(row)
			zipOutputStream << "\n"
			zipOutputStream << row.costCategory?.name+","+row.name+","+row.alias+","+stats.month_4+","+stats.month_5+","+stats.month_6+","+stats.month_7+","+stats.month_8+","+stats.month_9+","+stats.month_10+","+stats.month_11+","+stats.month_12+","+stats.month_1+","+stats.month_2+","+stats.month_3
			}
		}
    }
}
