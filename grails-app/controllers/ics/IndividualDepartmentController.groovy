package ics

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import grails.converters.JSON

class IndividualDepartmentController {

    def individualService
    def springSecurityService
    
    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [individualDepartmentInstanceList: IndividualDepartment.list(params), individualDepartmentInstanceTotal: IndividualDepartment.count()]
    }

    def create = {
        def individualDepartmentInstance = new IndividualDepartment()
        individualDepartmentInstance.properties = params
        return [individualDepartmentInstance: individualDepartmentInstance]
    }

    def save = {
        def individualDepartmentInstance = new IndividualDepartment(params)
        if (!individualDepartmentInstance.hasErrors() && individualDepartmentInstance.save()) {
            flash.message = "individualDepartment.created"
            flash.args = [individualDepartmentInstance.id]
            flash.defaultMessage = "IndividualDepartment ${individualDepartmentInstance.id} created"
            redirect(action: "show", id: individualDepartmentInstance.id)
        }
        else {
            render(view: "create", model: [individualDepartmentInstance: individualDepartmentInstance])
        }
    }

    def show = {
        def individualDepartmentInstance = IndividualDepartment.get(params.id)
        if (!individualDepartmentInstance) {
            flash.message = "individualDepartment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "IndividualDepartment not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [individualDepartmentInstance: individualDepartmentInstance]
        }
    }

    def edit = {
        def individualDepartmentInstance = IndividualDepartment.get(params.id)
        if (!individualDepartmentInstance) {
            flash.message = "individualDepartment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "IndividualDepartment not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [individualDepartmentInstance: individualDepartmentInstance]
        }
    }

    def update = {
        def individualDepartmentInstance = IndividualDepartment.get(params.id)
        if (individualDepartmentInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (individualDepartmentInstance.version > version) {
                    
                    individualDepartmentInstance.errors.rejectValue("version", "individualDepartment.optimistic.locking.failure", "Another user has updated this IndividualDepartment while you were editing")
                    render(view: "edit", model: [individualDepartmentInstance: individualDepartmentInstance])
                    return
                }
            }
            individualDepartmentInstance.properties = params
            if (!individualDepartmentInstance.hasErrors() && individualDepartmentInstance.save()) {
                flash.message = "individualDepartment.updated"
                flash.args = [params.id]
                flash.defaultMessage = "IndividualDepartment ${params.id} updated"
                redirect(action: "show", id: individualDepartmentInstance.id)
            }
            else {
                render(view: "edit", model: [individualDepartmentInstance: individualDepartmentInstance])
            }
        }
        else {
            flash.message = "individualDepartment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "IndividualDepartment not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def individualDepartmentInstance = IndividualDepartment.get(params.id)
        if (individualDepartmentInstance) {
            try {
                individualDepartmentInstance.delete()
                flash.message = "individualDepartment.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "IndividualDepartment ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "individualDepartment.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "IndividualDepartment ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "individualDepartment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "IndividualDepartment not found with id ${params.id}"
            redirect(action: "list")
        }
    }
    
    def gridlist() {}

    def jq_individualDepartment_list = {
      log.debug("Inside jq_individualDepartment_list with params : "+params)
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = IndividualDepartment.createCriteria().list(max:maxRows, offset:rowOffset) {

		if (params.name)
			individual{or{ilike('legalName','%'+params.name + '%') ilike('initiatedName','%'+params.name + '%')}}
		if (params.since)
			ge('since',Date.parse('dd-MM-yyyy',params.since))
		if (params.till)
			le('till',Date.parse('dd-MM-yyyy',params.till))
		if (params.status)
			eq('status',params.status)
		if (params.comments)
			ilike('comments','%'+params.comments + '%')
		if (params.salary)
			ge('salary',new Integer(params.salary))
		if (params.'department.id')
			department{eq('id',new Long(params.'department.id'))}

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.individual.toString(),
            	    it.since?.format('dd-MM-yyyy'),
            	    it.till?.format('dd-MM-yyyy'),
            	    it.status,
            	    it.comments,
            	    it.salary,
            	    it.department.toString(),
            	    it.individual.id
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_individualDepartment = {
	      log.debug('In jq_individualDepartment_edit:'+params)
	      def individualDepartment = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add individualDepartment sent
		  //format the dates
		  if(params.since)
		  	params.since = Date.parse('dd-MM-yyyy',params.since)
		  if(params.till)
		  	params.till = Date.parse('dd-MM-yyyy',params.till)

		  params.'individual.id' = individualService.createBasicIndividual(params)?.id
		  
		  individualDepartment = new IndividualDepartment(params)
		  individualDepartment.updator=individualDepartment.creator=springSecurityService.principal.username
		  if (! individualDepartment.hasErrors() && individualDepartment.save()) {
		    message = "IndividualDepartment Saved.."
		    id = individualDepartment.id
		    state = "OK"
		  } else {
		    individualDepartment.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save IndividualDepartment"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check individualDepartment exists
			  individualDepartment  = IndividualDepartment.get(it)
			  if (individualDepartment) {
			    // delete individualDepartment
			    if(!individualDepartment.delete())
			    	{
				    individualDepartment.errors.allErrors.each {
					log.debug("In jq_individualDepartment_edit: error in deleting individualDepartment:"+ it)
					}
			    	}
			    else {
				    message = "Deleted!!"
				    state = "OK"
			    }
			  }
		  	}
		  break;
		 default :
		  // edit action
		  // first retrieve the individualDepartment by its ID
		  individualDepartment = IndividualDepartment.get(params.id)
		  if (individualDepartment) {
		    // set the properties according to passed in parameters
		    individualDepartment.properties = params
			  individualDepartment.updator = springSecurityService.principal.username
		    if (! individualDepartment.hasErrors() && individualDepartment.save()) {
		      message = "IndividualDepartment  ${individualDepartment.toString()} Updated"
		      id = individualDepartment.id
		      state = "OK"
		    } else {
			    individualDepartment.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update IndividualDepartment"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def jq_leave_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def individualDepartment = null
	if(params.individualDepartmentid)
		individualDepartment=IndividualDepartment.get(params.individualDepartmentid)
		
	def result = LeaveRecord.createCriteria().list(max:maxRows, offset:rowOffset) {
		if(individualDepartment)
			eq('individualDepartment',individualDepartment)

		if (params.name)
			individualDepartment{individual{or{ilike('legalName','%'+params.name + '%') ilike('initiatedName','%'+params.name + '%')}}}
		if (params.dateFrom)
			ge('dateFrom',Date.parse('dd-MM-yyyy HH:mm',params.dateFrom))

		if (params.dateTill)
			le('dateTill',Date.parse('dd-MM-yyyy HH:mm',params.dateTill))

		if (params.status)
			eq('status',params.status)

		if (params.comments)//service
			ilike('comments','%'+params.comments + '%')

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.individualDepartment.individual?.toString(),
            	    it.dateFrom?.format('dd-MM-yyyy HH:mm'),
            	    it.dateTill?.format('dd-MM-yyyy HH:mm'),
            	    it.status,
            	    it.comments
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_leave = {
	      def leaveRecord = null
	      def message = ""
	      def state = "FAIL"
	      def id

	  //format the dates
	  if(params.dateFrom)
		  params.dateFrom = Date.parse('dd-MM-yyyy HH:mm',params.dateFrom)
	  if(params.dateTill)
		params.dateTill = Date.parse('dd-MM-yyyy HH:mm',params.dateTill)

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add leaveRecord sent
		  
		  leaveRecord = new LeaveRecord(params)
		  leaveRecord.updator=leaveRecord.creator=springSecurityService.principal.username
		  if (! leaveRecord.hasErrors() && leaveRecord.save()) {
		    message = "LeaveRecord Saved.."
		    id = leaveRecord.id
		    state = "OK"
		  } else {
		    leaveRecord.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save LeaveRecord"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check leaveRecord exists
			  leaveRecord  = LeaveRecord.get(it)
			  if (leaveRecord) {
			    // delete leaveRecord
			    if(!leaveRecord.delete())
			    	{
				    leaveRecord.errors.allErrors.each {
					log.debug("In jq_leaveRecord_edit: error in deleting leaveRecord:"+ it)
					}
			    	}
			    else {
				    message = "Deleted!!"
				    state = "OK"
			    }
			  }
		  	}
		  break;
		 default :
		  // edit action
		  // first retrieve the leaveRecord by its ID
		  leaveRecord = LeaveRecord.get(params.id)
		  if (leaveRecord) {
		    // set the properties according to passed in parameters
		    leaveRecord.properties = params
			  leaveRecord.updator = springSecurityService.principal.username
		    if (! leaveRecord.hasErrors() && leaveRecord.save()) {
		      message = "LeaveRecord  ${leaveRecord.toString()} Updated"
		      id = leaveRecord.id
		      state = "OK"
		    } else {
			    leaveRecord.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update LeaveRecord"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def jq_salary_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def individualDepartment = null
	if(params.individualDepartmentid)
		individualDepartment=IndividualDepartment.get(params.individualDepartmentid)
		
	def result = SalaryRecord.createCriteria().list(max:maxRows, offset:rowOffset) {
		if(individualDepartment)
			eq('individualDepartment',individualDepartment)

		if (params.name)
			individualDepartment{individual{or{ilike('legalName','%'+params.name + '%') ilike('initiatedName','%'+params.name + '%')}}}
		if (params.datePaid)
			ge('datePaid',Date.parse('dd-MM-yyyy',params.datePaid))

		if (params.amountPaid)
			ge('amountPaid',new Integer(params.amountPaid))

		if (params.paymentDetails)
			ilike('paymentDetails','%'+params.paymentDetails + '%')

		if (params.comments)//service
			ilike('comments','%'+params.comments + '%')

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.individualDepartment.individual?.toString(),
            	    it.datePaid?.format('dd-MM-yyyy'),
            	    it.amountPaid,
            	    it.paymentDetails,
            	    it.comments
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_salary = {
	      def salaryRecord = null
	      def message = ""
	      def state = "FAIL"
	      def id
	      
	  //format the dates
	  params.datePaid = Date.parse('dd-MM-yyyy',params.datePaid)

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add 
		  
		  salaryRecord = new SalaryRecord(params)
		  salaryRecord.updator=salaryRecord.creator=springSecurityService.principal.username
		  if (! salaryRecord.hasErrors() && salaryRecord.save()) {
		    message = "SalaryRecord Saved.."
		    id = salaryRecord.id
		    state = "OK"
		  } else {
		    salaryRecord.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save SalaryRecord"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check salaryRecord exists
			  salaryRecord  = SalaryRecord.get(it)
			  if (salaryRecord) {
			    // delete salaryRecord
			    if(!salaryRecord.delete())
			    	{
				    salaryRecord.errors.allErrors.each {
					log.debug("In jq_salaryRecord_edit: error in deleting salaryRecord:"+ it)
					}
			    	}
			    else {
				    message = "Deleted!!"
				    state = "OK"
			    }
			  }
		  	}
		  break;
		 default :
		  // edit action
		  // first retrieve the salaryRecord by its ID
		  salaryRecord = SalaryRecord.get(params.id)
		  if (salaryRecord) {
		    // set the properties according to passed in parameters
		    salaryRecord.properties = params
			  salaryRecord.updator = springSecurityService.principal.username
		    if (! salaryRecord.hasErrors() && salaryRecord.save()) {
		      message = "SalaryRecord  ${salaryRecord.toString()} Updated"
		      id = salaryRecord.id
		      state = "OK"
		    } else {
			    salaryRecord.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update SalaryRecord"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }        
    
}
