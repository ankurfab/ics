package ics

class DonationCategoryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [donationCategoryInstanceList: DonationCategory.list(params), donationCategoryInstanceTotal: DonationCategory.count()]
    }

    def create = {
        def donationCategoryInstance = new DonationCategory()
        donationCategoryInstance.properties = params
        return [donationCategoryInstance: donationCategoryInstance]
    }

    def save = {
        def donationCategoryInstance = new DonationCategory(params)
        if (donationCategoryInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'donationCategory.label', default: 'DonationCategory'), donationCategoryInstance.id])}"
            redirect(action: "show", id: donationCategoryInstance.id)
        }
        else {
            render(view: "create", model: [donationCategoryInstance: donationCategoryInstance])
        }
    }

    def show = {
        def donationCategoryInstance = DonationCategory.get(params.id)
        if (!donationCategoryInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'donationCategory.label', default: 'DonationCategory'), params.id])}"
            redirect(action: "list")
        }
        else {
            [donationCategoryInstance: donationCategoryInstance]
        }
    }

    def edit = {
        def donationCategoryInstance = DonationCategory.get(params.id)
        if (!donationCategoryInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'donationCategory.label', default: 'DonationCategory'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [donationCategoryInstance: donationCategoryInstance]
        }
    }

    def update = {
        def donationCategoryInstance = DonationCategory.get(params.id)
        if (donationCategoryInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (donationCategoryInstance.version > version) {
                    
                    donationCategoryInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'donationCategory.label', default: 'DonationCategory')] as Object[], "Another user has updated this DonationCategory while you were editing")
                    render(view: "edit", model: [donationCategoryInstance: donationCategoryInstance])
                    return
                }
            }
            donationCategoryInstance.properties = params
            if (!donationCategoryInstance.hasErrors() && donationCategoryInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'donationCategory.label', default: 'DonationCategory'), donationCategoryInstance.id])}"
                redirect(action: "show", id: donationCategoryInstance.id)
            }
            else {
                render(view: "edit", model: [donationCategoryInstance: donationCategoryInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'donationCategory.label', default: 'DonationCategory'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def donationCategoryInstance = DonationCategory.get(params.id)
        if (donationCategoryInstance) {
            try {
                donationCategoryInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'donationCategory.label', default: 'DonationCategory'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'donationCategory.label', default: 'DonationCategory'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'donationCategory.label', default: 'DonationCategory'), params.id])}"
            redirect(action: "list")
        }
    }
}
