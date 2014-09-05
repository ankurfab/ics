package ics
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class GiftRecordController {
    def springSecurityService

    def helperService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "The record is not available for viewing!!"
           return
        }
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [giftRecordInstanceList: GiftRecord.list(params), giftRecordInstanceTotal: GiftRecord.count()]
    }

    def create = {
         if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "The record is not available for viewing!!"
           return
        }
        def copiedgiftid = params.giftid
        def giftRecordInstance 
        if(copiedgiftid == null || copiedgiftid == 'undefined')
            giftRecordInstance = new GiftRecord()
        else
        {
            giftRecordInstance = GiftRecord.get(copiedgiftid)
            if(giftRecordInstance == null) giftRecordInstance = new GiftRecord() // if not found
        }
        def today = new Date()
        giftRecordInstance.properties = params
        giftRecordInstance.giftDate= today
        giftRecordInstance.quantity =1
        giftRecordInstance.comments = "English : "+ today.format("MMMM") + " : " +today.format("YYYY")
        giftRecordInstance.giftReceivedStatus = "Received"
        giftRecordInstance.giftChannel = "In Person"
          
        def donationExecRole = Role.findByAuthority('ROLE_DONATION_EXECUTIVE')
        def dep = IndividualRole.findWhere('individual.id':session.individualid,role:donationExecRole,status:'VALID')?.department
        def schemes
        if(dep)
            schemes = Scheme.findAllByDepartment(dep,[sort:'name'])

        def gifts
        if(dep)
            gifts = Gift.findAllByDepartment(dep,[sort:'effectiveFrom',order:'desc'])

        return [giftRecordInstance: giftRecordInstance,schemes:schemes,gifts:gifts]
    }
     def updatecomments={
     if (!(SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')  || SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_COORDINATOR') ) ){
           render "The record is not available for viewing!!"
           return
        }

        if (springSecurityService.isLoggedIn()) {
        params.updator=springSecurityService.principal.username
    }
    else
        params.updator=""

             def giftRecordInstance = GiftRecord.get(params.id)
         giftRecordInstance.comments=params.updatedcomments
         if (!giftRecordInstance.hasErrors() && giftRecordInstance.save()) {
                        flash.message = "giftRecord.updated"
                        flash.args = [params.id]
                        flash.defaultMessage = "GiftRecord ${params.id} updated"
                        redirect(action: "show", id: giftRecordInstance.id)
                    }
        
    }

    def save = {
         if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "The record is not available for viewing!!"
           return
        }
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator
     if(params.giftDate)
        params.giftDate = Date.parse('dd-MM-yyyy', params.giftDate)


        def giftRecordInstance = new GiftRecord(params)

        if (!giftRecordInstance.hasErrors() && giftRecordInstance.save()) {
            flash.message = "giftRecord.created"
            flash.args = [giftRecordInstance.id]
            flash.defaultMessage = "GiftRecord ${giftRecordInstance.id} created"
            //saving centre
            def schemeMember = SchemeMember.findByMemberAndScheme(giftRecordInstance.giftedTo,giftRecordInstance.scheme)
            if(schemeMember != null){
                giftRecordInstance.centre = schemeMember.centre
                giftRecordInstance.save()
            }
            redirect(action: "show", id: giftRecordInstance.id)
        }
        else {
            render(view: "create", model: [giftRecordInstance: giftRecordInstance])
        }
    }

    def updateGiftRecordCentres={
        //this action will update Gift records with the centre field
        if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
        render "The record is not available for viewing!!"
           return
        }   
        def role = helperService.getDonationUserRole()
        def schemes = helperService.getSchemesForRole(role, session.individualid)
        def giftRecordSummary = GiftRecord.createCriteria().list(){
                                    'in'('scheme',schemes)
                                }
        def schemeMember
        giftRecordSummary.each{            
            schemeMember = SchemeMember.findByMemberAndScheme(it.giftedTo,it.scheme)
            if(schemeMember != null){
            it.centre = schemeMember.centre
            it.save()    
            }            
        }
    }
    def show = {
        def giftRecordInstance = GiftRecord.get(params.id)
        if (!giftRecordInstance) {
            flash.message = "giftRecord.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "GiftRecord not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
              if (!(SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') || SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_COORDINATOR'))){
               render "The record is not available for viewing!!"
               return
                 }

             if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_COORDINATOR')){
               
                def schemeMember = SchemeMember.findByMemberAndScheme(giftRecordInstance.giftedTo,giftRecordInstance.scheme)
                def membercentre= schemeMember.centre
                def usercenter = helperService.getCenterForIndividualRole(helperService.getDonationUserRole(),session.individualid)
                
                if(membercentre != usercenter){
                     render "The record is not available for viewing!!" 
                    return
                }
             }

            return [giftRecordInstance: giftRecordInstance]
        }
    }

    def edit = {
         if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "The record is not available for viewing!!"
           return
        }
        def giftRecordInstance = GiftRecord.get(params.id)
        if (!giftRecordInstance) {
            flash.message = "giftRecord.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "GiftRecord not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
              
        def donationExecRole = Role.findByAuthority('ROLE_DONATION_EXECUTIVE')
        def dep =IndividualRole.findWhere('individual.id':session.individualid,role:donationExecRole,status:'VALID')?.department
        def schemes
        if(dep)
            schemes = Scheme.findAllByDepartment(dep,[sort:'name'])
        def gifts
        if(dep)
            gifts = Gift.findAllByDepartment(dep,[sort:'effectiveFrom',order:'desc'])

            return [giftRecordInstance: giftRecordInstance,schemes:schemes,gifts:gifts]
        }
    }

    def update = {
         if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "The record is not available for viewing!!"
           return
        }
        def giftRecordInstance = GiftRecord.get(params.id)
        if (giftRecordInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (giftRecordInstance.version > version) {
                    
                    giftRecordInstance.errors.rejectValue("version", "giftRecord.optimistic.locking.failure", "Another user has updated this GiftRecord while you were editing")
                    render(view: "edit", model: [giftRecordInstance: giftRecordInstance])
                    return
                }
            }

		if (springSecurityService.isLoggedIn()) {
			params.updator=springSecurityService.principal.username
		}
		else
			params.updator=""
            if(params.giftDate)
        params.giftDate = Date.parse('dd-MM-yyyy', params.giftDate)
            giftRecordInstance.properties = params
            if (!giftRecordInstance.hasErrors() && giftRecordInstance.save()) {
                flash.message = "giftRecord.updated"
                flash.args = [params.id]
                flash.defaultMessage = "GiftRecord ${params.id} updated"
                redirect(action: "show", id: giftRecordInstance.id)
            }
            else {
                render(view: "edit", model: [giftRecordInstance: giftRecordInstance])
            }
        }
        else {
            flash.message = "giftRecord.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "GiftRecord not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
         if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "The record is not available for viewing!!"
           return
        }
        def giftRecordInstance = GiftRecord.get(params.id)
        if (giftRecordInstance) {
            try {
                giftRecordInstance.delete()
                flash.message = "giftRecord.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "GiftRecord ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "giftRecord.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "GiftRecord ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "giftRecord.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "GiftRecord not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
