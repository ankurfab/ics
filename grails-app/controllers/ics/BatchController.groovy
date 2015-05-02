package ics

import grails.converters.JSON

class BatchController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [batchInstanceList: Batch.list(params), batchInstanceTotal: Batch.count()]
    }

    def create = {
        def batchInstance = new Batch()
        batchInstance.properties = params
        return [batchInstance: batchInstance]
    }

    def save = {
        def batchInstance = new Batch(params)
        if (!batchInstance.hasErrors() && batchInstance.save()) {
            flash.message = "batch.created"
            flash.args = [batchInstance.id]
            flash.defaultMessage = "Batch ${batchInstance.id} created"
            redirect(action: "show", id: batchInstance.id)
        }
        else {
            render(view: "create", model: [batchInstance: batchInstance])
        }
    }

    def show = {
        def batchInstance = Batch.get(params.id)
        if (!batchInstance) {
            flash.message = "batch.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Batch not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [batchInstance: batchInstance]
        }
    }

    def edit = {
        def batchInstance = Batch.get(params.id)
        if (!batchInstance) {
            flash.message = "batch.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Batch not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [batchInstance: batchInstance]
        }
    }

    def update = {
        def batchInstance = Batch.get(params.id)
        if (batchInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (batchInstance.version > version) {
                    
                    batchInstance.errors.rejectValue("version", "batch.optimistic.locking.failure", "Another user has updated this Batch while you were editing")
                    render(view: "edit", model: [batchInstance: batchInstance])
                    return
                }
            }
            batchInstance.properties = params
            if (!batchInstance.hasErrors() && batchInstance.save()) {
                flash.message = "batch.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Batch ${params.id} updated"
                redirect(action: "show", id: batchInstance.id)
            }
            else {
                render(view: "edit", model: [batchInstance: batchInstance])
            }
        }
        else {
            flash.message = "batch.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Batch not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def batchInstance = Batch.get(params.id)
        if (batchInstance) {
            try {
                batchInstance.delete()
                flash.message = "batch.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Batch ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "batch.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Batch ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "batch.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Batch not found with id ${params.id}"
            redirect(action: "list")
        }
    }
    
    def gridlist() {
    }
    
    def jq_batch_list = {
      log.debug("Inside jq_batch_list with params : "+params)
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'
      
      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
      
	def result = Batch.createCriteria().list(max:maxRows, offset:rowOffset) {
		if(params.category)
			eq('category',params.category)
		if(params.type)
			eq('type',params.type)
		if (params.name)
			ilike('name',params.name)
		if (params.description)
			ilike('description',params.description)
		if(params.ref)
			eq('ref',params.ref)
		if (params.fromDate)
			eq('fromDate',Date.parse('dd-MM-yyyy',params.fromDate))
		if (params.toDate)
			eq('toDate',Date.parse('dd-MM-yyyy',params.toDate))
		if(params.status)
			eq('status',params.status)

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.ref,
           	    it.name,
           	    it.description,
           	    it.category,
           	    it.type,
           	    it.fromDate?.format('dd-MM-yyyy HH:mm:ss'),
           	    it.toDate?.format('dd-MM-yyyy HH:mm:ss'),
           	    it.status,
                ], id: it.id]
        }

        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def jq_batchitem_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
	def result = BatchItem.createCriteria().list(max:maxRows, offset:rowOffset) {
		if(params.'batch.id')
			batch{eq('id',new Long(params.'batch.id'))}
		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.postingDate?.format('dd-MM-yyyy'),
           	    it.effectiveDate?.format('dd-MM-yyyy'),
           	    it.description,
           	    it.ref,
           	    it.debit,
           	    it.grossAmount,
           	    it.netAmount,
           	    it.status,
           	    it.linkedEntityName,
           	    it.linkedEntityRef,
           	    it.linkedEntityId,
           	    it.linkedBatchRef,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }
        
        
}
