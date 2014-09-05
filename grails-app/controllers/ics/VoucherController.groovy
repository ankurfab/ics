package ics

import org.codehaus.groovy.grails.plugins.springsecurity.*

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
}
