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
        [costCenterInstanceList: CostCenter.list(params), costCenterInstanceTotal: CostCenter.count()]
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
		      def costCenter = CostCenter.findByCostCategoryAndAlias(costCategory,costCenterCode)
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
                costCenterInstance.delete()
                flash.message = "costCenter.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "CostCenter ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
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
	
	if(ccat)
		result = reportService.costCategoryStatement(ccat,fd,td)
	else
		result = reportService.ccStatement(cc,fd,td)
    	[ccat:ccat, cc: cc,fd:fd, td: td, balance:cc?.budget?:0, records: result]
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
                def ownerid = CostCenter.get(params.id)?.owner?.id
                redirect(controller:"individual",action: "show", id: ownerid)    	
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
	    //@TODO: should be created in more effiecient way and elsewhere
	    //financeService.createStatsAttributes([year:year])
	    
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

}
