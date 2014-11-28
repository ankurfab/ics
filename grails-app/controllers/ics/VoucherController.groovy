package ics

import org.codehaus.groovy.grails.plugins.springsecurity.*
import grails.converters.JSON

class VoucherController {
    def springSecurityService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        if(!params.sort)
        	params.sort='lastUpdated'
        if(!params.order)
        	params.order='desc'
        [voucherInstanceList: Voucher.list(params), voucherInstanceTotal: Voucher.count()]
    }

    def create = {
        def voucherInstance = new Voucher()
        voucherInstance.properties = params
        return [voucherInstance: voucherInstance]
    }

    def save = {
        params.creator=springSecurityService.principal.username
        params.updator=params.creator
	if(params.voucherDate)
		params.voucherDate = Date.parse('dd-MM-yyyy', params.voucherDate)
        def voucherInstance = new Voucher(params)
        if (!voucherInstance.hasErrors() && voucherInstance.save()) {
            flash.message = "voucher.created"
            flash.args = [voucherInstance.id]
            flash.defaultMessage = "Voucher ${voucherInstance.voucherNo} entered!"
            if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_ACC_VE'))
            	render(view: "create", model: [voucherInstance: new Voucher()])
            else
            	redirect(action: "show", id: voucherInstance.id)
        }
        else {
            render(view: "create", model: [voucherInstance: voucherInstance])
        }
    }

    def show = {
        def voucherInstance = Voucher.get(params.id)
        if (!voucherInstance) {
            flash.message = "voucher.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Voucher not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [voucherInstance: voucherInstance]
        }
    }

    def edit = {
        def voucherInstance = Voucher.get(params.id)
        if (!voucherInstance) {
            flash.message = "voucher.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Voucher not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [voucherInstance: voucherInstance]
        }
    }

    def update = {
        def voucherInstance = Voucher.get(params.id)
        if (voucherInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (voucherInstance.version > version) {
                    
                    voucherInstance.errors.rejectValue("version", "voucher.optimistic.locking.failure", "Another user has updated this Voucher while you were editing")
                    render(view: "edit", model: [voucherInstance: voucherInstance])
                    return
                }
            }
	params.updator=springSecurityService.principal.username
	if(params.voucherDate)
		params.voucherDate = Date.parse('dd-MM-yyyy', params.voucherDate)
            voucherInstance.properties = params
            if (!voucherInstance.hasErrors() && voucherInstance.save()) {
                flash.message = "voucher.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Voucher ${params.id} updated"
                redirect(action: "show", id: voucherInstance.id)
            }
            else {
                render(view: "edit", model: [voucherInstance: voucherInstance])
            }
        }
        else {
            flash.message = "voucher.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Voucher not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def voucherInstance = Voucher.get(params.id)
        if (voucherInstance) {
            try {
                voucherInstance.delete()
                flash.message = "voucher.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Voucher ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "voucher.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Voucher ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "voucher.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Voucher not found with id ${params.id}"
            redirect(action: "list")
        }
    }

    def jq_voucher_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows


	def result = Voucher.createCriteria().list(max:maxRows, offset:rowOffset) {
				
	if(params.voucherDate)
		eq('voucherDate',Date.parse('dd-MM-yyyy',params.voucherDate))

	if(params.departmentCode)
		departmentCode{ilike('name',params.departmentCode)}

	if(params.voucherNo)
		ilike('voucherNo',params.voucherNo)

	if(params.description)
		ilike('description',params.description)

	if(params.amount)
		eq('amount',new Integer(params.amount))

	if(params.amountSettled)
		eq('amountSettled',new Integer(params.amountSettled))

	if(params.updator)
		eq('updator',params.updator)

	order(sortIndex, sortOrder)
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells
      jsonCells = result.collect {
            [cell: [
            	    it.voucherDate?.format("dd-MM-yyyy"),
            	    it.departmentCode?.toString(),
            	    it.voucherNo,
            	    it.description,
            	    it.amount,
            	    it.amountSettled,
            	    it.updator,
            	    it.lastUpdated?.format("dd-MM-yyyy HH:mm:ss"),
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }


}
