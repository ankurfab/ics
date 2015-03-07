package ics

import grails.converters.JSON
import groovy.sql.Sql;

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
      def sortIndex = "name"
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = CostCenter.createCriteria().list(max:maxRows, offset:rowOffset) {
		if (params.vertical)
			costCategory{ilike('name',params.vertical)}

		if (params.department)
			ilike('name',params.department)

		costCategory{order("name")}
		order(sortIndex, sortOrder)
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            if(!it.budget)
            	it.budget = 0
            [cell: [
            	    it.costCategory.name,
            	    it.name,
            	    it.budget*12,
            	    it.budget,
            	    it.budget,
            	    it.budget,
            	    it.budget,
            	    it.budget,
            	    it.budget,
            	    it.budget,
            	    it.budget,
            	    it.budget,
            	    it.budget,
            	    it.budget,
            	    it.budget
                ], id: it.id]
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
	
	def summary(){
		[year:params.year]
	}
	
	def budgetchart()  {
		render(template: "budget", model: [book: ''])
	}

}
