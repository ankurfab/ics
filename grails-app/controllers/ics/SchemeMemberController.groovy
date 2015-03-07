package ics

import com.krishna.*
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import grails.converters.JSON
import groovy.sql.Sql;

class SchemeMemberController {
	def springSecurityService

    def helperService 
    def exportService
    def grailsApplication  //inject GrailsApplication

    def dataSource 

	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def setExternalName={
         if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "The record is not available for viewing!!"
           return
        }
        def schemememberid = params.schemememberid
        def externalName= params.externalname
        def counsumerNumber= params.consumernumber

        def schemeMember = SchemeMember.findById(schemememberid)

        schemeMember.externalName = externalName
        schemeMember.counsumerNumber = counsumerNumber
        schemeMember.save()
         if (!schemeMember.save()) {

                    schemeMember.errors.each {
                        println it}
            render "Scheme Member failed to get updated"
           return
         }
          render "Scheme Member is updated"
           return

    }


    def getRole(){
         def role
         if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') ){
            role = 'ROLE_DONATION_EXECUTIVE'
         }
         else  if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_COORDINATOR') ){
            role = 'ROLE_DONATION_COORDINATOR'
         }
         else  if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') ){
            role = 'ROLE_DONATION_HOD'
         }
         println "ROLE is ---"+role
         return role
    }

    def getschemes(){
         if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') ||
          SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_COORDINATOR')||
          SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_HOD')){
            def ir 
            def donationRole = Role.findByAuthority(getRole())
            println "donation  Role is ==="+donationRole
            if(donationRole)
                ir = IndividualRole.findWhere('individual.id':session.individualid,role:donationRole,status:'VALID')

            println "Individual Role is "+ir
            if(ir){
                def department= ir.department
                def schemes = Scheme.createCriteria().list(){
                    eq("department",department)
                }
                return [schemes:schemes]
            }

         }

    }

    def list = {
	    if (request.xhr) {
		render(template: "schemeMemberGrid", model: [individualid:params.'individual.id'])
		//render "Hare Krishna!!"
		return
	    }
      def showpopup = false
      if(getSession().isFirstTimeSchemeMemberClicked == null){
          showpopup = true
          getSession().isFirstTimeSchemeMemberClicked = "No"
      }
        def totalSummary;
        def schemes = helperService.getSchemesForRole(helperService.getDonationUserRole(),session.individualid)
        //def schemes = getschemes()
        println '****************'+schemes
        if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') || SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_COORDINATOR')){
            totalSummary = SchemeMember.createCriteria().list{
                projections{                                        
                    groupProperty("status")
                    count("member")                     
                    isNotNull("status")
                }
                'in'('scheme',schemes)
                
            }

        }
        return [summary:totalSummary,showpopup:showpopup]
    }
    

    def create = {
        def schemeMemberInstance = new SchemeMember()
        schemeMemberInstance.properties = params
        return [schemeMemberInstance: schemeMemberInstance]
    }

    def save = {
        if(params.startDate)
        params.startDate = Date.parse('dd-MM-yyyy', params.startDate)
        if(params.stopDate)
        params.stopDate = Date.parse('dd-MM-yyyy', params.stopDate)
        if(params.recentResumeDate)
        params.recentResumeDate = Date.parse('dd-MM-yyyy', params.recentResumeDate)
        if(params.futureStartDate)
        params.futureStartDate = Date.parse('dd-MM-yyyy', params.futureStartDate)
        
        if (springSecurityService.isLoggedIn()) {
          params.updator=springSecurityService.principal.username
        }
        else
          params.updator="unknown"
          
        def schemeMemberInstance = new SchemeMember(params)
		schemeMemberInstance.creator = springSecurityService.principal.username
		schemeMemberInstance.updator = springSecurityService.principal.username

        
        if (schemeMemberInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'schemeMember.label', default: 'SchemeMember'), schemeMemberInstance.id])}"
            redirect(action: "show", id: schemeMemberInstance.id)
        }
        else {
            render(view: "create", model: [schemeMemberInstance: schemeMemberInstance])
        }
    }
    
    def createfromindividual = {
        def schemeMemberInstance = new SchemeMember()
        def member = Individual.findById((params.individualid).toInteger())
        schemeMemberInstance.properties = params
        //get applicable schemes
        //1. get the department for the logged-in user
        //TODO: need fixing (if dep is null that means default case)
        
	def donationExecRole = Role.findByAuthority('ROLE_DONATION_EXECUTIVE')
        def dep = IndividualRole.findWhere('individual.id':session.individualid,role:donationExecRole,status:'VALID')?.department
        def schemes
        if(dep)
        	schemes = Scheme.findAllByDepartment(dep,[sort:'name'])
        return [schemeMemberInstance: schemeMemberInstance, member: member, individualid: params.individualid, schemes: schemes]
    }

    def savefromindividual = {
    	println "params="+params
    	
         if(params.startDate)
        params.startDate = Date.parse('dd-MM-yyyy', params.startDate)
        if(params.stopDate)
        params.stopDate = Date.parse('dd-MM-yyyy', params.stopDate)
        if(params.recentResumeDate)
        params.recentResumeDate = Date.parse('dd-MM-yyyy', params.recentResumeDate)
        if(params.futureStartDate)
        params.futureStartDate = Date.parse('dd-MM-yyyy', params.futureStartDate)

        def schemeMemberInstance = new SchemeMember(params)
        schemeMemberInstance.member = Individual.get(params.individualid)
		schemeMemberInstance.creator = springSecurityService.principal.username
		schemeMemberInstance.updator = springSecurityService.principal.username
        
       
        if (schemeMemberInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'schemeMember.label', default: 'SchemeMember'), schemeMemberInstance.id])}"
            redirect(action: "show", id: schemeMemberInstance.id)
        }
        else {
            render(view: "create", model: [schemeMemberInstance: schemeMemberInstance])
        }
    }

    def actions={
       if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "The record is not available for viewing!!"
           return
        }
        
    }

    def show = {
          if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_HOD')){
           render "The record is not available for viewing!!"
           return
        }
        def schemeMemberInstance = SchemeMember.get(params.id)
        if (!schemeMemberInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schemeMember.label', default: 'SchemeMember'), params.id])}"
            redirect(action: "list")
        }
        else {
             if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') || SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_COORDINATOR')){

                 if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_COORDINATOR')){
                    def membercentre= schemeMemberInstance.centre
                    def membersecondcentre= schemeMemberInstance.secondcentre
                    def usercenter = helperService.getCenterForIndividualRole(helperService.getDonationUserRole(),session.individualid)
                    println "member center ="+ membercentre
                    println "user center ="+ usercenter
                    if(membercentre != usercenter && membersecondcentre != usercenter){
                         render "The record is not available for viewing!!" 
                        return
                    }
                 }

                [schemeMemberInstance: schemeMemberInstance]
            }
        }
    }

   def edit = {
        def schemeMemberInstance = SchemeMember.get(params.id)
        if (!schemeMemberInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schemeMember.label', default: 'SchemeMember'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [schemeMemberInstance: schemeMemberInstance]
        }
    }

    def find = {
        def schemeInstance = Scheme.get(params.schemeid)
        def memberInstance = Individual.get(params.individualid)
        def schemeMemberInstance = SchemeMember.findBySchemeAndMember(schemeInstance,memberInstance)
        if (!schemeMemberInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schemeMember.label', default: 'SchemeMember'), params.id])}"
            redirect(action: "list")
        }
        else {
             render(view: "show", model: [schemeMemberInstance: schemeMemberInstance])
        }
    }

    def update = {
         if(params.startDate)
        params.startDate = Date.parse('dd-MM-yyyy', params.startDate)
        if(params.stopDate)
        params.stopDate = Date.parse('dd-MM-yyyy', params.stopDate)
        if(params.recentResumeDate)
        params.recentResumeDate = Date.parse('dd-MM-yyyy', params.recentResumeDate)
        if(params.futureStartDate)
        params.futureStartDate = Date.parse('dd-MM-yyyy', params.futureStartDate)
        
        def schemeMemberInstance = SchemeMember.get(params.id)

        if (springSecurityService.isLoggedIn()) {
          params.updator=springSecurityService.principal.username
        }
        else
          params.updator="unknown"
       
        if(params.isProfileComplete != 'undefined' && params.isProfileComplete =='on')
        {
          if(schemeMemberInstance.isProfileComplete == false)
          {
            //means we are marking this profile complete
            schemeMemberInstance.profileCompleteDate = new Date()
          }
        }
        if (schemeMemberInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (schemeMemberInstance.version > version) {
                    
                    schemeMemberInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'schemeMember.label', default: 'SchemeMember')] as Object[], "Another user has updated this SchemeMember while you were editing")
                    render(view: "edit", model: [schemeMemberInstance: schemeMemberInstance])
                    return
                }
            }
            schemeMemberInstance.properties = params
            if (!schemeMemberInstance.hasErrors() && schemeMemberInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'schemeMember.label', default: 'SchemeMember'), schemeMemberInstance.id])}"
                redirect(action: "show", id: schemeMemberInstance.id)
            }
            else {
                render(view: "edit", model: [schemeMemberInstance: schemeMemberInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schemeMember.label', default: 'SchemeMember'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def schemeMemberInstance = SchemeMember.get(params.id)
        if (schemeMemberInstance) {
            try {
                schemeMemberInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'schemeMember.label', default: 'SchemeMember'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'schemeMember.label', default: 'SchemeMember'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schemeMember.label', default: 'SchemeMember'), params.id])}"
            redirect(action: "list")
        }
    }

    def jq_schemeMember_list = {
      log.debug("Inside jq_schemeMember_list..."+params)
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = SchemeMember.createCriteria().list(max:maxRows, offset:rowOffset) {
		member{
			eq('id',new Long(params.'individual.id'))
			}
       
		order(sortIndex, sortOrder)
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.scheme?.name,
            	    it.scheme?.department?.name,
            	    it.scheme?.category,
            	    it.membershipLevel,
            	    it.status,
            	    it.centre?.name
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }



    def jq_allschemeMember_list = {
    //  log.debug("Inside jq_allschemeMember_list..."+params)
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def selectedcenter = null
      if(params.selectedCenter != null && params.selectedCenter != '0' && params.selectedCenter !='undefined') {
        selectedcenter = Centre.findById(params.selectedCenter.toLong())
        println "selectedcenter is "+selectedcenter
      } 

      def toBeCommunicated= null;
      if(params.toBeCommunicated != 'undefined' && params.toBeCommunicated=='Yes'){
        toBeCommunicated = 'Yes'
      }

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def selectedperiod = params.selectedperiod

      def selectedDate = new Date()
      def firstDate = selectedDate - selectedDate.getAt(Calendar.DAY_OF_MONTH) // beginning date of the month

      if(selectedperiod=='ALL'){
        firstDate = null
      }
      else if(selectedperiod=='This_Month'){
        firstDate = firstDate
      }
      else if(selectedperiod=='Six_Month'){
        firstDate = firstDate - 6*30 // date within six month
      }
     else if(selectedperiod=='One_Year'){
      firstDate = firstDate - 12*30 // date within a year
     }

     def giftchannel = params.giftchannel
     if(giftchannel =='ALL'){
        giftchannel = null
     }
      def memberstatus = params.memberstatus
      if(memberstatus=='ALL') memberstatus= null

      def isProfileComplete = params.isProfileComplete
      def profileCompleteFlag  = true
      if(isProfileComplete=='ALL') isProfileComplete = null
      else if(isProfileComplete =='Yes')profileCompleteFlag = true
      else if(isProfileComplete =='No')profileCompleteFlag = false
      
      def giftPrefferedLanguage = null
      if(params.giftPrefferedLanguage != null && params.giftPrefferedLanguage != '0' && params.giftPrefferedLanguage !='undefined') {

        giftPrefferedLanguage = Language.findById(params.giftPrefferedLanguage.toLong())
        
      } 

       def committedmode = null
      if(params.committedmode != null && params.committedmode != '0' && params.committedmode !='undefined') {

        committedmode = params.committedmode
        
      } 

      def toBeSMS = null
      if(params.toBeSMS != null && params.toBeSMS != 'ALL' && params.toBeSMS !='undefined') {

        toBeSMS = params.toBeSMS
        
      }

       def rankvalue = null
      if(params.rankvalue != null && params.rankvalue != 'ALL' && params.rankvalue !='undefined') {

        rankvalue = params.int("rankvalue")
        
      } 

      def PercentageDeduction=null
      if(params.PercentageDeduction != null && params.PercentageDeduction != '' && params.PercentageDeduction !='undefined') {

        PercentageDeduction = params.PercentageDeduction
        
      } 

	def result
	def ir
        if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_COORDINATOR'))
        	{
        	//first get the relevant role        	
		def donationRole = Role.findByAuthority('ROLE_DONATION_COORDINATOR')
        	if(donationRole)
        		ir = IndividualRole.findWhere('individual.id':session.individualid,role:donationRole,status:'VALID')
        	if(ir)
        		{
			result = SchemeMember.createCriteria().list(max:maxRows, offset:rowOffset) {
        or{
          eq('centre',ir.centre)
          eq('secondcentre',ir.centre)  
        }
				
				if(params.member) {
					member{
					or{
					  ilike('legalName','%'+params.member+'%')
					  ilike('initiatedName','%'+params.member+'%')
					  }
					if(params.sidx=='member')
						{
						order('legalName', sortOrder)
						}
						
					 }
					}
          if(firstDate!= null)gt('dateCreated',firstDate)
          if(giftchannel != null) eq('giftchannel',giftchannel)
          if(memberstatus != null) eq('status',memberstatus)
          if(isProfileComplete != null)eq('isProfileComplete',profileCompleteFlag)
          if(toBeCommunicated != null) eq('toBeCommunicated',toBeCommunicated)
          if(toBeSMS!= null) eq('toBeSMS',toBeSMS)
          if(rankvalue != null){
              if(rankvalue < 4){
                eq('star',rankvalue)
              }
              else{
                ge('star',rankvalue)
              }
          }
          if(PercentageDeduction!= null){
            and{
              isNotNull("percentageDeductionSecondCentreUpper")
              gt("percentageDeductionSecondCentreUpper",0)
              isNotNull("percentageDeductionSecondCentreLower")
              gt("percentageDeductionSecondCentreLower",0)
            }
          }
				}
			}
        	}
        else if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE'))
        	{

			def names=[]
      if(params.member){
        if(params.member.contains(";")){
          names = params.member.split(/;/)
        }
        else{
          names.add(params.member)
        }
      }
      else{
        names = null
      }
			def schemes = helperService.getSchemesForRole(helperService.getDonationUserRole(),session.individualid)
      def i=0
      def j = (names != null)?names.size():1
      while(i<j){
            def newresult = SchemeMember.createCriteria().list(max:maxRows, offset:rowOffset) {
            if(firstDate!= null)gt('dateCreated',firstDate)
            if(giftchannel != null) eq('giftchannel',giftchannel)
            if(memberstatus != null) eq('status',memberstatus)
            if(isProfileComplete != null)eq('isProfileComplete',profileCompleteFlag)
            if(giftPrefferedLanguage != null )eq('giftPrefferedLanguage',giftPrefferedLanguage)
            if(committedmode != null )eq('committedMode',committedmode)
            if(toBeCommunicated != null) eq('toBeCommunicated',toBeCommunicated)
             if(toBeSMS!= null) eq('toBeSMS',toBeSMS)
          if(rankvalue != null){
              if(rankvalue < 4){
                eq('star',rankvalue)
              }
              else{
                ge('star',rankvalue)
              }
          }
          if(PercentageDeduction!= null){
            and{
              isNotNull("percentageDeductionSecondCentreUpper")
              gt("percentageDeductionSecondCentreUpper",0)
              isNotNull("percentageDeductionSecondCentreLower")
              gt("percentageDeductionSecondCentreLower",0)
            }
          }
            if(names != null) {
              member{
              or{
                ilike('legalName','%'+names[i]+'%')
                ilike('initiatedName','%'+ names[i]+'%')
                }
              if(params.sidx=='member')
                {
                order('legalName', sortOrder)
                }
               }
              }
                if(selectedcenter != null) {
                  or{
                    eq('centre', selectedcenter)
                    eq('secondcentre', selectedcenter)                        
                  }
                           
                }
                'in'('scheme',schemes)         
          }
          if(result == null){
            result = newresult
          }
          else{
            result.addAll(newresult)  
          }
          
          i++
      }
			   result = result.unique()     		
   	}

      def totalRows = (result?.totalCount)?:0
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.scheme?.name,
            	    it.member?.toString(),
                  it.member?.legalName,
                  it.star,
            	    it.status,
                  it.committedMode,
            	    it.comments,
            	    it.recentCommunication,
                    it.addressTheConcern,
                    (it.secondcentre == null)? (it.centre?.name):(it.centre?.name +" / "+ it.secondcentre?.name) ,
                  (it.percentageDeductionSecondCentreUpper != null && it.percentageDeductionSecondCentreLower!= null)? (it.percentageDeductionSecondCentreUpper +" Out of "+it.percentageDeductionSecondCentreLower):"",
                    it.isProfileComplete,
                    it.toBeCommunicated
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

 

 def jq_allschemeMember_by_externalname={
     if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "The record is not available for viewing!!"
           return
        }

      //       log.debug("Inside jq_allschemeMember_list..."+params)
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def selectedcenter = params.selectedCenter
      def sname = params.sname

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
      def searchfor= null
      if(params.member){
            searchfor = params.member
      }
      else{
        searchfor =  sname
      }
      
        def result
        def ir
       
         if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE'))
            {
            //todo: show the list only for the relevant schemes
            
            result = SchemeMember.createCriteria().list(max:maxRows, offset:rowOffset) {   
                    if(searchfor){
                        or{
                            member{
                                or{
                                    ilike('legalName','%'+searchfor+'%')                    
                                    ilike('initiatedName','%'+searchfor+'%')  
                                                                           
                                }    
                            }
                            ilike('externalName','%'+searchfor+'%')  
                        }
                        
                    }            
                    
                   
                    
            }               
            }
      
      def totalRows = (result?.totalCount)?:0
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
                    it.scheme?.name,
                    it.member?.legalName,
                    it.externalName?.toString(),
                    it.counsumerNumber?.toString(),
                    it.status,
                    it.comments,
                    it.centre?.name
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON

        }

def schemeMemberDataExportAsCVS={
    if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
        render "The record is not available for viewing!!"
           return
    }
    def schemes = helperService.getSchemesForRole(helperService.getDonationUserRole(),session.individualid)

    def memberstatus = params.memberstatus
    def selectedcenter = params.selectedcenter
    def giftchannel= params.giftchannel
    def exportType= params.exportType

    println "##############"+ params.member
    if(memberstatus == 'ALL') memberstatus = null
    if(giftchannel=='ALL') giftchannel= null
    def memberRecordSummary
     def isProfileCompleteFlag = (params.isProfileComplete=='Yes')?true:false
    def giftPrefferedLanguage = null
      if(params.giftPrefferedLanguage != null && params.giftPrefferedLanguage != '0' && params.giftPrefferedLanguage !='undefined') {

        giftPrefferedLanguage = Language.findById(params.giftPrefferedLanguage.toLong())
        
      } 
    def toBeCommunicated= null;
      if(params.toBeCommunicated != 'undefined' && params.toBeCommunicated=='Yes'){
        toBeCommunicated = 'Yes'
      }

    def committedmode = null
    if(params.committedmode != null && params.committedmode != '0' && params.committedmode !='undefined') {
       committedmode = params.committedmode
    }

    def toBeSMS = null
      if(params.toBeSMS != null && params.toBeSMS != 'ALL' && params.toBeSMS !='undefined') {

        toBeSMS = params.toBeSMS
        
      }

       def rankvalue = null
      if(params.rankvalue != null && params.rankvalue != 'ALL' && params.rankvalue !='undefined') {

        rankvalue = params.int("rankvalue")
        
      } 

    memberRecordSummary = SchemeMember.createCriteria().list(){
      'in'('scheme',schemes)
      if(memberstatus!= null) eq('status',memberstatus)
      if(giftchannel!= null) eq('giftchannel',giftchannel)
      if(toBeCommunicated != null) eq('toBeCommunicated',toBeCommunicated)
      if(params.isProfileComplete!='ALL'){
        eq('isProfileComplete',isProfileCompleteFlag)
      }
       if(params.member != '') {
          member{
          or{          
            ilike('legalName','%'+params.member+'%')
            ilike('initiatedName','%'+params.member+'%')                     
          }
        }
      }
      if(params.selectedcenter != '0') {
            centre{
                eq('id', params.selectedcenter.toLong())
            }       
      }
      if(giftPrefferedLanguage != null){
      	eq('giftPrefferedLanguage',giftPrefferedLanguage)
      }

      if(committedmode != null){
         eq('committedMode',committedmode)
      }

       if(toBeSMS!= null) eq('toBeSMS',toBeSMS)
          if(rankvalue != null){
              if(rankvalue < 4){
                eq('star',rankvalue)
              }
              else{
                ge('star',rankvalue)
              }
          }
      
    }

    println "========exporting scheme member data into CVS=========="
      
      def filename = "schemeMemberData"+".${params.extension}"
      response.contentType = grailsApplication.config.grails.mime.types[params.formats]
      response.setHeader("Content-disposition", "attachment; filename="+filename) 
      List fields
      if(exportType =='Full Data')fields = ["Member","Status","Scheme","Centre",
                                            "Contact Number","Email Id",
                                            "Mailing Address","Gift Channel",
                                            "Profile Complete"]
      else if(exportType =='Only Address')fields = ["Member","Mailing Address","Contact Number"]

      else if(exportType=='Only Contact Data') fields= ["Member","Email Address","Contact Number","To Be Communicated"]

      else {
        render "The record is not available for viewing!!"
           return
      }

      Map labels = [:]
      def data=new ArrayList()
      def total= new BigDecimal("0")
      for(record in memberRecordSummary){
        def row= new HashMap()
        if(exportType =='Full Data'){
          row[fields[0]]=record.member?.legalName
          row[fields[1]] = record.status
          row[fields[2]]=record.scheme?.name
          row[fields[3]] = record.centre
          row[fields[4]] = helperService.getIndividualVOICEContact(record.member, record.prefferedContactType)
          row[fields[5]] =helperService.getIndividualEmailContact(record.member, record.prefferedEmailType)
          row[fields[6]] = helperService.getIndividualAddress(record.member,record.giftPrefferedAddress)
          row[fields[7]] = record.giftchannel
          row[fields[8]] = (record.isProfileComplete==true)?"Yes":"No"
        }
        else if(exportType =='Only Address'){
          row[fields[0]]=record.member?.legalName          
          row[fields[1]] = helperService.getIndividualAddress(record.member,record.giftPrefferedAddress)
          row[fields[2]] = helperService.getIndividualVOICEContact(record.member, record.prefferedContactType)
        }
         else if(exportType=='Only Contact Data'){
          row[fields[0]]=record.member?.legalName          
          row[fields[1]] = helperService.getIndividualEmailContact(record.member, record.prefferedEmailType)
          row[fields[2]] = helperService.getIndividualVOICEContact(record.member, record.prefferedContactType)
          row[fields[3]]=record.toBeCommunicated
         }
        total = total + 1
        data.add(row) 
      }
      def row= new HashMap()
      row[fields[0]]="TOTAL"
      row[fields[1]]= total
      data.add(row)
      
      exportService.export(params.format, response.outputStream,data, fields,labels, [:], [:])


}

def listreminders={

}

def notcompleteprofiles_list={

      println "DEBUG=================notcompleteprofiles_list=============="
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def role = helperService.getDonationUserRole()
      def schemes = helperService.getSchemesForRole(role, session.individualid)
      def centre = helperService.getCenterForIndividualRole(role, session.individualid)
      if(role =='ROLE_DONATION_EXECUTIVE') centre = null // list data from all centers
      def memberRecordSummary = SchemeMember.createCriteria().list(max:maxRows, offset:rowOffset){
                          'in'('scheme',schemes)                          
                           eq('isProfileComplete',false)                          
                            if(centre != null) {                                
                                      eq('centre', centre)                                       
                            } 
                            order('centre','asc')                         
                     }
      def totalRows = (memberRecordSummary?.totalCount)?:0
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = memberRecordSummary.collect {
            [cell: [                    
                    it.member?.legalName,                    
                    it.status,
                    it.recentCommunication,
                    it.centre?.name,
                    it.isProfileComplete
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON

      
}

def concernToAddress_list={
    println "DEBUG=================concernToAddress_list=============="
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def role = helperService.getDonationUserRole()
      def schemes = helperService.getSchemesForRole(role, session.individualid)
      def centre = helperService.getCenterForIndividualRole(role, session.individualid)
      if(role =='ROLE_DONATION_EXECUTIVE') centre = null // list data from all centers
      def memberRecordSummary = SchemeMember.createCriteria().list(max:maxRows, offset:rowOffset){
                          'in'('scheme',schemes)                          
                           ne('addressTheConcern','NONE')                          
                            if(centre != null) {                                
                                      eq('centre', centre)                                       
                            } 
                            order('addressTheConcern','asc')                        
                     }
      def totalRows = (memberRecordSummary?.totalCount)?:0
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = memberRecordSummary.collect {
            [cell: [                    
                    it.member?.legalName,                    
                    it.status,
                    it.recentCommunication,
                    it.centre?.name,
                    it.addressTheConcern
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON

}

def prospects_list={
  println "DEBUG=================prospects_list=============="
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def role = helperService.getDonationUserRole()
      def schemes = helperService.getSchemesForRole(role, session.individualid)
      def centre = helperService.getCenterForIndividualRole(role, session.individualid)
      if(role =='ROLE_DONATION_EXECUTIVE') centre = null // list data from all centers
      def memberRecordSummary = SchemeMember.createCriteria().list(max:maxRows, offset:rowOffset){
                          'in'('scheme',schemes)                          
                           'in'('status',['PROSPECT','SUSPENDED'])                          
                            if(centre != null) {                                
                                      eq('centre', centre)                                       
                            } 
                            order('futureStartDate','asc')                         
                     }
      def totalRows = (memberRecordSummary?.totalCount)?:0
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = memberRecordSummary.collect {
            [cell: [                    
                    it.member?.legalName,                    
                    it.status,
                    it.recentCommunication,
                    it.centre?.name,
                    it.futureStartDate?.format('dd-MMM-yyyy')?.toString()
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON

}

def recentbirthday_list={
  println "DEBUG=================recentbirthday_list=============="
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def role = helperService.getDonationUserRole()
      def schemes = helperService.getSchemesForRole(role, session.individualid)
      def centre = helperService.getCenterForIndividualRole(role, session.individualid)
      if(role =='ROLE_DONATION_EXECUTIVE') centre = null // list data from all centers

      def now = new Date()
      println "month is " + now.month
      def memberRecordSummary = SchemeMember.createCriteria().list(max:maxRows, offset:rowOffset){
                          'in'('scheme',schemes)                          
                           'in'('status',['ACTIVE','RESUMED','IRREGULAR','PROSPECT','SUSPENDED'])                          
                            if(centre != null) {                                
                                      eq('centre', centre)                                       
                            } 
                            member{
                              order('dob','asc')                              
                              sqlRestriction "month(dob) < "+((now.month).toInteger() +'3'.toInteger())*1 + "  AND month(dob) > "+((now.month).toInteger())                        
                              //sqlRestriction " order by month(dob) asc"                                
                            }
                            
                     }
      def totalRows = (memberRecordSummary?.totalCount)?:0
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = memberRecordSummary.collect {
            [cell: [                    
                    it.member?.legalName,                    
                    it.status,
                    it.recentCommunication,
                    it.centre?.name,
                    it.member?.dob?.format('dd-MMM-yyyy')?.toString()
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
}

//to make to be communicated to No for the scheme
def updateToBeCommunicatedOfMembers={
    //this action will update Gift records with the centre field
        if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
        render "you can not perform this action!!"
           return
        }   
        def role = helperService.getDonationUserRole()
        def schemes = helperService.getSchemesForRole(role, session.individualid)
        def sql = new Sql(dataSource);
        sql.executeUpdate("UPDATE scheme_member set to_be_communicated='No' WHERE scheme_id = " + schemes[0].id)
        sql.close()
        render "All members have been updated with No for To Be Communicated."
}

//ONLY FOR ECS ACTIVE MEMBERS
//this method copies ECS mandate values to corresponding scheme member ,make them Active etc.
def checkECSMandateFromCommitment={
// copying ecs mandate to scheme members
   if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
        render "you can not perform this action!!"
           return
        }  
    def role = helperService.getDonationUserRole()
    def schemes = helperService.getSchemesForRole(role, session.individualid)
    def result = Commitment.createCriteria().list{
                'in'('scheme',schemes)
                eq('status','ACTIVE')
                isNotNull("ecsMandate")
              }
    //for each commitment ,find scheme member then update consumer number

    //println result
    def notfound=0
    def noLinkedIndividuals=[]//all those individual which does not scheme member
    result.each{
      println it.ecsMandate
      //find scheme member
      def schemeMemberInstance = SchemeMember.findBySchemeAndMember(it.scheme,it.committedBy)
      if(schemeMemberInstance != null){
        schemeMemberInstance.counsumerNumber = it.ecsMandate
      schemeMemberInstance.status= 'ACTIVE'
      schemeMemberInstance.committedMode='ECS'
      if(it.committedAmount != null)schemeMemberInstance.actualCurrentAmount= it.committedAmount /12
      if (!schemeMemberInstance.save()) {

                    schemeMemberInstance.errors.each {
                        println it}
            render "Scheme Member failed to get updated"
           return
         }  
      }
      else{
        notfound = notfound +1
        noLinkedIndividuals.add([it.scheme,it.committedBy])
      }
      
    }
    return [schemes:schemes , size:result.size(), notfound:notfound, noLinkedIndividuals:noLinkedIndividuals]

}
/*
this method find all those donation records which have no center set ,and if there is no scheme member then it sets to default center
pass as parameter
*/
def updateDonationRecordWithDefaultCenter={
   if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "you not authorized to do this action!!"
           return
        }

        println "running updateDonationRecordWithDefaultCenter"
        def schemes= helperService.getSchemesForRole('ROLE_DONATION_EXECUTIVE',session.individualid)

        def centre= Centre.findById(params."centre.id")

        def recordsWithEmptyCenter = DonationRecord.createCriteria().list(){                     
            'in'("scheme",schemes)
            isNull("centre")
        }  

        for(record in recordsWithEmptyCenter){
          def schemeMemberInstance = SchemeMember.findBySchemeAndMember(record.scheme, record.donatedBy)
          if(schemeMemberInstance == null){
            record.centre = centre
             if (!record.save()) {
                    record.errors.each {
                        println it
                      }
              }
          }
        }  

        render "All Records (having no center and no scheme member) have been updated with center " + centre.name

}

/*
active ,-all members having commitment and ecs mandate not null and active commitment are marked active for that scheme
iregular --all such members ,which commitment mode is not ECS , and number of donation given in previous one year is less then 10 are marked irregular.
in-active --those not marked as prospect ,and suspended and not given any donation or the last donation given by them is more than 1 year oldm then mark them in-active 
  or if there donation frequency is yearly or half yearly then mark them irregular , but not given more than 2 years then mark them also in-active
*/
 def updateSchemeMembersStatus={

    if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "you not authorized to do this action!!"
           return
        }

        println "running updateSchemeMembersStatus"
        def schemes= helperService.getSchemesForRole('ROLE_DONATION_EXECUTIVE',session.individualid)
        //first making ECS members active
        def schemeCommitments = Commitment.createCriteria().list{             
               eq('status','ACTIVE')
               isNotNull("ecsMandate")
               'in'('scheme',schemes)
          }
          schemeCommitments.each{commitment->
            def schemeMember = SchemeMember.findBySchemeAndMember(commitment.scheme, commitment.committedBy)
            if(schemeMember != null){
              schemeMember.status = "ACTIVE"
              if (!schemeMember.save()) {
                    schemeMember.errors.each {
                        println it
                      }
              }
            }
          }
          //now making members irregular
          def individualGivingViaECS = Commitment.createCriteria().list{   
              projections{
                property("committedBy")
              }          
               eq('status','ACTIVE')
               isNotNull("ecsMandate")
               'in'('scheme',schemes)
          }

          def nonECSSchemeMembers = SchemeMember.createCriteria().list(){               
              'in'('scheme',schemes)
              not{ 'in' ("member", individualGivingViaECS)}
              not{'in'("status",["PROSPECT","NOTINTERESTED","SUSPENDED"])}
              not{'in'("committedFrequency", ["HALFYEARLY","YEARLY"])}
          }

          def today = new Date()
          def oneyearbackdate = today - 365
          nonECSSchemeMembers.each{member->
              member.status="INACTIVE"
              //find donation from such members within last one year
              def noOfdonations = DonationRecord.createCriteria().list(){
                  projections{
                    rowCount()
                  }
                'in'('scheme',schemes)
                eq("donatedBy", member.member)
                ge("donationDate",oneyearbackdate)
              }
              //if no of donations are more than 10 then make active ,
              //if less then 10 but greater than 0 ,then make them irregular
              if(noOfdonations[0] > 10) member.status="ACTIVE"
              if(noOfdonations[0] > 0 && noOfdonations[0] <=10) member.status="IRREGULAR"
              if (!member.save()) {
                    member.errors.each {
                        println it
                      }
              }
          }
          // if such members which have yearly or half yearly set ,but not given for more than two year will be marked inactive
           def twoyearbackdate = today - 730
           def nonECSSchemeMembersYearly = SchemeMember.createCriteria().list(){               
              'in'('scheme',schemes)
              not{ 'in' ("member", individualGivingViaECS)}
              not{'in'("status",["PROSPECT","NOTINTERESTED","SUSPENDED"])}
              'in'("committedFrequency", ["HALFYEARLY","YEARLY"])
          }
          nonECSSchemeMembersYearly.each{member->
               member.status="INACTIVE"
              //find donation from such members within last two year
              def noOfdonations = DonationRecord.createCriteria().list(){
                  projections{
                    rowCount()
                  }
                'in'('scheme',schemes)
                eq("donatedBy", member.member)
                ge("donationDate",twoyearbackdate)
              }
              //if no of donations are more than 10 then make active ,
              //if less then 10 but greater than 0 ,then make them irregular
              if(noOfdonations[0] > 0) member.status="IRREGULAR"
              
              if (!member.save()) {
                    member.errors.each {
                        println it
                      }
              }
          }

          // if any propspect member has given donation within one month ,make him also irregular status
            def onemonthbackdate = today - 30
           def nonECSSchemeMembersProspects = SchemeMember.createCriteria().list(){               
              'in'('scheme',schemes)
              not{ 'in' ("member", individualGivingViaECS)}
              'in'("status",["PROSPECT","NOTINTERESTED","SUSPENDED"])
          }
          nonECSSchemeMembersProspects.each{member->
               
              //find donation from such members within last two year
              def noOfdonations = DonationRecord.createCriteria().list(){
                  projections{
                    rowCount()
                  }
                'in'('scheme',schemes)
                eq("donatedBy", member.member)
                ge("donationDate",onemonthbackdate)
              }
              //if no of donations are more than 10 then make active ,
              //if less then 10 but greater than 0 ,then make them irregular
              if(noOfdonations[0] > 0) member.status="IRREGULAR"
              
              if (!member.save()) {
                    member.errors.each {
                        println it
                      }
              }
          }


          render "Status of All Scheme Members of your scheme is updated "

 }

 def updateSchemeMembersStars={
     if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "you not authorized to do this action!!"
           return
        }

        println "running updateSchemeMembersStars"
        def schemes= helperService.getSchemesForRole('ROLE_DONATION_EXECUTIVE',session.individualid)

         def schemeMembers = SchemeMember.createCriteria().list(){               
              'in'('scheme',schemes)              
          }

          def today = new Date()
          def oneyearbackdate = today - 400

          schemeMembers.each{schemeMember->
              schemeMember.star= 0
              def individual = schemeMember.member
              if(individual != null){
                //find all the donatiions sum for this member within one year
                 def totaldonations = DonationRecord.createCriteria().list(){
                      projections{
                        sum("amount")
                      }
                    'in'('scheme',schemes)
                    eq("donatedBy", schemeMember.member)
                    ge("donationDate",oneyearbackdate)
               }
               if(totaldonations != null && totaldonations[0] != null )
               {
                  if(totaldonations[0] ==0){
                  schemeMember.star= 0
                 }
                 else{
                  //divide by 12
                  schemeMember.star = Math.floor(totaldonations[0]/12000f)
                  
                 } 
               }
               

                if (!schemeMember.save()) {
                    schemeMember.errors.each {
                        println it
                      }
              }
              }
          }

          render "All Scheme Members are given Stars "

 }

	def syncdonation() {
		def query="insert into donation_record (version,amount,creator,date_created,donated_by_id,donation_date,last_updated,mode_id,scheme_id,updator,donation_id,payment_details) select 0,amount,creator,date_created,donated_by_id,donation_date,last_updated,mode_id,scheme_id,updator,id,comments from donation d where scheme_id=(select id from scheme where name='EASY') and not exists (select 1 from donation_record dr where dr.donation_id=d.id);"
		def sql = new Sql(dataSource);
		sql.execute(query)
		sql.close()
		render "OK"
	}
}
