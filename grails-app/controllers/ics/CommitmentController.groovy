package ics
import grails.converters.JSON

class CommitmentController {
    def springSecurityService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
	    if (request.xhr) {
		render(template: "commitmentGrid", model: [committedByid : params.'committedBy.id'])
		return
	    }
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [commitmentInstanceList: Commitment.list(params), commitmentInstanceTotal: Commitment.count()]
    }

    def create = {
        def commitmentInstance = new Commitment()
        commitmentInstance.properties = params
        return [commitmentInstance: commitmentInstance]
    }

    def save = {
        def commitmentInstance = new Commitment(params)
        if (!commitmentInstance.hasErrors() && commitmentInstance.save()) {
            flash.message = "commitment.created"
            flash.args = [commitmentInstance.id]
            flash.defaultMessage = "Commitment ${commitmentInstance.id} created"
            redirect(action: "show", id: commitmentInstance.id)
        }
        else {
            render(view: "create", model: [commitmentInstance: commitmentInstance])
        }
    }

    def show = {
        def commitmentInstance = Commitment.get(params.id)
        if (!commitmentInstance) {
            flash.message = "commitment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Commitment not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [commitmentInstance: commitmentInstance]
        }
    }

    def edit = {
        def commitmentInstance = Commitment.get(params.id)
        if (!commitmentInstance) {
            flash.message = "commitment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Commitment not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [commitmentInstance: commitmentInstance]
        }
    }

    def update = {
        def commitmentInstance = Commitment.get(params.id)
        if (commitmentInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (commitmentInstance.version > version) {
                    
                    commitmentInstance.errors.rejectValue("version", "commitment.optimistic.locking.failure", "Another user has updated this Commitment while you were editing")
                    render(view: "edit", model: [commitmentInstance: commitmentInstance])
                    return
                }
            }
            commitmentInstance.properties = params
            if (!commitmentInstance.hasErrors() && commitmentInstance.save()) {
                flash.message = "commitment.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Commitment ${params.id} updated"
                redirect(action: "show", id: commitmentInstance.id)
            }
            else {
                render(view: "edit", model: [commitmentInstance: commitmentInstance])
            }
        }
        else {
            flash.message = "commitment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Commitment not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def commitmentInstance = Commitment.get(params.id)
        if (commitmentInstance) {
            try {
                commitmentInstance.delete()
                flash.message = "commitment.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Commitment ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "commitment.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Commitment ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "commitment.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Commitment not found with id ${params.id}"
            redirect(action: "list")
        }
    }

    def jq_commitment_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = Commitment.createCriteria().list(max:maxRows, offset:rowOffset) {
			eq('status','ACTIVE')
			if(params.'committedBy.id')
				{
				committedBy{
					eq('id',new Long(params.'committedBy.id'))
					}
				}
			if(params.'committedByName')
				{
				committedBy{
					or{
						ilike('legalName',params.'committedByName')
						ilike('initiatedName',params.'committedByName')
					}
					}
				}
			if(params.'schemeName')
				{
				scheme{
					ilike('name',params.'schemeName')
				}
				}
			if(params.ecsMandate)
				ilike('ecsMandate',params.ecsMandate)
				
			if(params.sidx=='committedByName')
				committedBy{order('legalName', sortOrder)}
			else if(params.sidx=='schemeName')
				scheme{order('name', sortOrder)}
			else
				order(sortIndex, sortOrder)
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells
      if(!params.'committedBy.id') {
      jsonCells = result.collect {
            [cell: [
		    it.committedBy?.toString(),
            	    it.scheme?.name,
            	    it.committedAmount,
            	    it.ccAmount,
            	    (it.committedAmount?:0) + (it.ccAmount?:0),
            	    it.ecsMandate?:'',
            	    it.commitmentOn?.format("dd-MM-yyyy"),
            	    it.commitmentTill?.format("dd-MM-yyyy")
                ], id: it.id]
        }
        }
       else {
      jsonCells = result.collect {
            [cell: [
            	    it.scheme?.name,
            	    it.committedAmount,
            	    it.ccAmount,
            	    (it.committedAmount?:0) + (it.ccAmount?:0),
            	    it.ecsMandate?:'',
            	    it.commitmentOn?.format("dd-MM-yyyy"),
            	    it.commitmentTill?.format("dd-MM-yyyy")
                ], id: it.id]
        }}
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_commitment = {
	      log.debug('In jq_commitment_edit:'+params)
	      def message = ""
	      def state = "FAIL"
	      def id
	      def comm

	  if(params.commitmentOn)
		  params.commitmentOn = Date.parse('dd-MM-yyyy',params.commitmentOn)
	  if(params.commitmentTill)
		  params.commitmentTill = Date.parse('dd-MM-yyyy',params.commitmentTill)

	      // determine our action
	      switch (params.oper) {
		case 'add':
		
		  comm = new Commitment(params)

		comm.updator = comm.creator=springSecurityService.principal.username
		comm.status = 'ACTIVE'

		  if (! comm.hasErrors() && comm.save()) {
		    message = "Commitment Saved.."
		    id = comm.id
		    state = "OK"
		  } else {
		    comm.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save Commitment"
		  }
		  break;
		case 'del':
			def idList = params.id.tokenize(',')
			idList.each
			{
			  // check comm exists
			  comm  = Commitment.get(it)
			  if (comm) {
				//comm.status='DELETED'
				//comm.updator = springSecurityService.principal.username
			    if(!comm.delete())
				{
				    comm.errors.allErrors.each {
					log.debug("In jq_commitment_edit: error in deleting commitment:"+ it)
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

		  comm = Commitment.get(params.id)
		  if (comm) {
		    // set the properties according to passed in parameters
		    comm.properties = params

		    if (!comm.hasErrors() && comm.save()) {
		      message = "Commitment  ${comm.id} Updated"
		      id = comm.id
		      state = "OK"
		    } else {
			    comm.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update commitment"
		    }
		  }
		  break;
	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
    }

	def commitmentSummary() {
		def ind = Individual.get(params.'committedBy.id')
		def clist = Commitment.findAllByCommittedByAndStatus(ind,'ACTIVE')
		def summaryCommitment = clist.collect{it.scheme?.name+":d-"+it.committedAmount+":c-"+it.ccAmount}
		render([name:ind?.toString(),summaryCommitment: summaryCommitment] as JSON)
	}
	
	def jq_commitmentsum_list() {
	      def sortIndex = params.sidx ?: 'id'
	      def sortOrder  = params.sord ?: 'asc'

	      def maxRows = Integer.valueOf(params.rows)
	      def currentPage = Integer.valueOf(params.page) ?: 1

	      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def result = IndividualRole.createCriteria().list(max:maxRows, offset:rowOffset) {
					role{eq("name", "Councellor")}
					eq("status",'VALID')
			order(sortIndex, sortOrder)
		}

	      def totalRows = result.totalCount
	      def numberOfPages = Math.ceil(totalRows / maxRows)

	      def jsonCells = result.collect {
		    [cell: [
			    it.individual.toString(),
			    it.individual.ashram,
			], id: it.id]
		}
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
		render jsonData as JSON
     	}
     	
     	def report() {
     	}

}
