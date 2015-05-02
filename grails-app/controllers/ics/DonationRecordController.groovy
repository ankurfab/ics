package ics
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import grails.converters.JSON

class DonationRecordController {
    def springSecurityService
    def housekeepingService 
    def receiptSequenceService
    def helperService 
    def exportService
    def grailsApplication  //inject GrailsApplication
    def donationService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE,ROLE_NVCC_ADMIN,ROLE_PATRONCARE,ROLE_PATRONCARE_USER,ROLE_DUMMY')){
           render "The record is not available for viewing!!"
           return
        }
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [donationRecordInstanceList: DonationRecord.list(params), donationRecordInstanceTotal: DonationRecord.count()]
    }

    def create = {
        if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "The record is not available for viewing!!"
           return
        }
        def donationRecordInstance = new DonationRecord()
        donationRecordInstance.properties = params           
        def donationExecRole = Role.findByAuthority('ROLE_DONATION_EXECUTIVE')
        def dep = IndividualRole.findWhere('individual.id':session.individualid,role:donationExecRole,status:'VALID')?.department
        def schemes
        if(dep)
            schemes = Scheme.findAllByDepartment(dep,[sort:'name'])
        
        return [donationRecordInstance: donationRecordInstance,schemes:schemes]
    }

    def quickCreate = {
        if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE,ROLE_PATRONCARE,ROLE_PATRONCARE_USER')){
           render "The record is not available for viewing!!"
           return
        }
        def donationRecordInstance = new DonationRecord()
        donationRecordInstance.properties = params       
        if(params.icsid)
        	{
        	donationRecordInstance.donatedBy = Individual.findByIcsid(params.icsid)
        	}
        def schemes
        if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
        def donationExecRole = Role.findByAuthority('ROLE_DONATION_EXECUTIVE')
        def dep = IndividualRole.findWhere('individual.id':session.individualid,role:donationExecRole,status:'VALID')?.department
        if(dep)
            schemes = Scheme.findAllByDepartment(dep,[sort:'name'])
        }
	else if (SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER')){
		schemes = Scheme.createCriteria().list{
						and {
							le("effectiveFrom", new Date())
							ge("effectiveTill", new Date())
						    }
						    order("name", "asc")
					}
		//also set the default scheme, hardcoded with name 'PATRON CARE'
		 def defaultSchemes = Scheme.createCriteria().list{
							cc{
							 eq("name","PATRON CARE")
							 }
						}
		if(defaultSchemes.size()>0)
			donationRecordInstance.scheme = defaultSchemes[0]
		}
        
        return [donationRecordInstance: donationRecordInstance,schemes:schemes]
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

       def donationRecordInstance = DonationRecord.get(params.id)
       donationRecordInstance.comments=params.updatedcomments
       if (!donationRecordInstance.hasErrors() && donationRecordInstance.save()) {
                      flash.message = "donationRecord.updated"
                      flash.args = [params.id]
                      flash.defaultMessage = "DonationRecord ${params.id} updated"
                      redirect(action: "show", id: donationRecordInstance.id)
                  }
        
    }
    def save = {
    if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "The record is not available for viewing!!"
           return
        }
        def schemes = helperService.getSchemesForRole(helperService.getDonationUserRole(),session.individualid)

	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator
         if(params.donationDate)
        params.donationDate = Date.parse('dd-MM-yyyy', params.donationDate)

        def donationRecordInstance = new DonationRecord(params)
        if (!donationRecordInstance.hasErrors() && donationRecordInstance.save()) {
            flash.message = "donationRecord.created"
            flash.args = [donationRecordInstance.id]
            flash.defaultMessage = "DonationRecord ${donationRecordInstance.id} created"
            redirect(action: "show", id: donationRecordInstance.id)
        }
        else {
            render(view: "create", model: [donationRecordInstance: donationRecordInstance,schemes:schemes])
        }
    }

    def show = {
        def donationRecordInstance = DonationRecord.get(params.id)
	    if (request.xhr && donationRecordInstance) {
		render(template: "/individual/gist", model: [individualInstance:donationRecordInstance.donatedBy])
		return
	    }
        if (!donationRecordInstance) {
            flash.message = "donationRecord.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DonationRecord not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
          /*if (!(SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE') || SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_COORDINATOR'))){
           render "The record is not available for viewing!!"
           return
        }*/
        def schemes = helperService.getSchemesForRole(helperService.getDonationUserRole(),session.individualid)
        def drscheme=donationRecordInstance.scheme
        def disableedit=true
        schemes.each{scheme->
          if(scheme?.name==drscheme?.name){
            disableedit=false
          }
        }

        
        //if does not belong to your scheme ,then can not edit or delete the record

                 if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_COORDINATOR')){
                    def membercentre= donationRecordInstance.centre
                    def usercenter = helperService.getCenterForIndividualRole(helperService.getDonationUserRole(),session.individualid)
                    
                    if(membercentre != usercenter){
                         render "The record is not available for viewing!!" 
                        return
                    }
                 }

            return [donationRecordInstance: donationRecordInstance, disableedit:disableedit]
        }
    }

    def edit = {
        if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE,ROLE_PATRONCARE,ROLE_PATRONCARE_USER')){
           render "The record is not available for viewing!!"
           return
        }
        
        def donationExecRole = Role.findByAuthority('ROLE_DONATION_EXECUTIVE')
        def dep = IndividualRole.findWhere('individual.id':session.individualid,role:donationExecRole,status:'VALID')?.department
        def schemes
        if(dep)
            schemes = Scheme.findAllByDepartment(dep,[sort:'name'])


        def donationRecordInstance = DonationRecord.get(params.id)        
        if (!donationRecordInstance) {
            flash.message = "donationRecord.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DonationRecord not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [donationRecordInstance: donationRecordInstance,schemes:schemes]
        }
    }

    def update = {
         if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE,ROLE_PATRONCARE,ROLE_PATRONCARE_USER')){
           render "The record is not available for viewing!!"
           return
        }

        if(params.donationDate)
        params.donationDate = Date.parse('dd-MM-yyyy', params.donationDate)
        def donationRecordInstance = DonationRecord.get(params.id)
        if (donationRecordInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (donationRecordInstance.version > version) {
                    
                    donationRecordInstance.errors.rejectValue("version", "donationRecord.optimistic.locking.failure", "Another user has updated this DonationRecord while you were editing")
                    render(view: "edit", model: [donationRecordInstance: donationRecordInstance])
                    return
                }
            }

		if (springSecurityService.isLoggedIn()) {
			params.updator=springSecurityService.principal.username
		}
		else
			params.updator=""

            donationRecordInstance.properties = params
            if (!donationRecordInstance.hasErrors() && donationRecordInstance.save()) {
                flash.message = "donationRecord.updated"
                flash.args = [params.id]
                flash.defaultMessage = "DonationRecord ${params.id} updated"
                redirect(action: "show", id: donationRecordInstance.id)
            }
            else {
                render(view: "edit", model: [donationRecordInstance: donationRecordInstance])
            }
        }
        else {
            flash.message = "donationRecord.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DonationRecord not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def setNewIndividualIdForRecord={
      if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "The record is not available for viewing!!"
           return
        }
        def newschemeMemberId = params.newchemememberid
        def donationRecordId = params.donationrecordid

        if (springSecurityService.isLoggedIn()) {
        params.updator=springSecurityService.principal.username
        }
       
         def donationRecordInstance = DonationRecord.get(donationRecordId)
         donationRecordInstance.updator = params.updator

         def newschemeMember = SchemeMember.get(newschemeMemberId)
         def newindividualId = newschemeMember.member.id


         donationRecordInstance.donatedBy =  Individual.get(newindividualId)
         donationRecordInstance.centre = newschemeMember.centre

         if (!donationRecordInstance.hasErrors() && donationRecordInstance.save()) {
          render "The Record is updated successfully."
         }
    }

    def delete = {
         if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE,ROLE_PATRONCARE,ROLE_PATRONCARE_USER,ROLE_NVCC_ADMIN')){
           render "The record is not available for viewing!!"
           return
        }
        def donationRecordInstance = DonationRecord.get(params.id)
        if (donationRecordInstance) {
            try {
            	def donation = donationRecordInstance.donation
                donationRecordInstance.delete()
	         if (SpringSecurityUtils.ifAnyGranted('ROLE_NVCC_ADMIN')){
	         	//need to delete the donation also
	         	donation.delete()
	         }
                
                flash.message = "donationRecord.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "DonationRecord ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "donationRecord.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "DonationRecord ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "donationRecord.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DonationRecord not found with id ${params.id}"
            redirect(action: "list")
        }
    }

    def uploadpaymentdata={
          if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_ECS')){
           render "The record is not available for viewing!!"
           return
        }
        session.data = null
         
        /*def donationExecRole = Role.findByAuthority('ROLE_DONATION_EXECUTIVE')
        def dep = IndividualRole.findWhere('individual.id':session.individualid,role:donationExecRole,status:'VALID')?.department
        def schemes
        if(dep)
            schemes = Scheme.findAllByDepartment(dep,[sort:'name'])

        return [schemes:schemes]*/
        
        return
    }

    def dispalyfiledata={

          if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_ECS')){
           render "The record is not available for viewing!!"
           return
        }
        session.data = null
     def webRootDir = servletContext.getRealPath("/")
     println "webRootDir is "+webRootDir

     def uploadedFile = request.getFile('paymentfile')
    if (uploadedFile.empty) {
        flash.message = 'file cannot be empty'
        render(view: 'uploadpaymentdata')
        return
    }
     println "Class: ${uploadedFile.class}"
     println "Name: ${uploadedFile.name}"
     println "OriginalFileName:          ${uploadedFile.originalFilename}"
     println "Size: ${uploadedFile.size}"
     println "ContentType: ${uploadedFile.contentType}"
     
    if(!(uploadedFile.contentType?.toString()=="application/vnd.ms-excel")){
        flash.message = 'please upload a CVS file only.'
        redirect(action: "uploadpaymentdata")
        return
    }
     if(!(uploadedFile.originalFilename?.toString().contains(".csv"))){
        flash.message = 'please upload a CVS file only.'
        redirect(action: "uploadpaymentdata")
        return
    }

    def usememberdetails = false
     if(params.usememberdetails != null){
        usememberdetails = true        
      } 
    def usepercentagededuction = false
    if(params.usepercentagededuction != null){
      usepercentagededuction = true
    }
    def updatedonorid= false
    if(params.updatedonorid != null){
      updatedonorid = true
    }
    //def now = new Date()  
    def firstdate //= now - (now.date-1) 
    def lastdate     
    def errorflag = null
    def duplicaterecordfound = null
    def record
    def recordlist = []
    def count = 0
    def schemeMember
    def scheme = null
    def uploadtype = params.uploadtype
    def paymentmode
    def donorId
    def arecord
    def samemonthdonations

      def amountIndex
      def modeIndex
      def donornameIndex
      def donorIdIndex
      def txnIdIndex
      def bankNameIndex
      def donationDateIndex
      def skipcreation
      def memberdetails_1_Index
      def memberdetails_2_Index
      def paymentdetails_Index

      def amountColumnName
      def modeColumnName
      def donornameColumnName
      def donorIdColumnName
      def txnIdColumnName
      def bankNameColumnName
      def donationDateColumnName
      def skipPaymentMode // mode name for which we have to skip 
      def defaultModeName
      def donationDateFormat
      def memberdetails_1_ColumnName
      def memberdetails_2_ColumnName
      def paymentdetails_ColumnName

      def amountColumnValue
      def modeColumnValue
      def donorNameColumnValue
      def donorIdColumnValue
      def txnIdColumnValue
      def bankNameColumnValue
      def donationDateColumnValue
      def memberdetails_1_ColumnValue
      def memberdetails_2_ColumnValue
      def paymentdetails_ColumnValue

    // amount , donor name and donation date and donation date format should not be null
    // if modecolumnaname is null ,then there must be a default mode name
    if(uploadtype=='ecs'){
        amountColumnName = 'Amount'
        modeColumnName = null // all have mode as ECS
        donornameColumnName = 'Customer Name'
        donorIdColumnName= 'Consumer code'
        txnIdColumnName= 'TPSL Transaction ID'
        bankNameColumnName=null
        donationDateColumnName='Date'
        skipPaymentMode = null
        defaultModeName = 'ECS'
        donationDateFormat = 'yyyyMMdd'
        memberdetails_1_ColumnName = 'Reason Code'
        memberdetails_2_ColumnName = 'Reason description'
        paymentdetails_ColumnName='TxnDetails'
    }
    else if(uploadtype=='account'){
        amountColumnName = 'Credit Amount'
        modeColumnName = 'Transaction Type' 
        donornameColumnName = 'Donor'
        donorIdColumnName= 'DonorAccountId'
        txnIdColumnName= 'Receipt No'
        bankNameColumnName='Bank Name'
        donationDateColumnName='Date'
        skipPaymentMode = 'ECS'
        defaultModeName = null
        donationDateFormat = 'dd.MM.yyyy'
        memberdetails_1_ColumnName = 'MobileNo'
        memberdetails_2_ColumnName = 'Email'
        paymentdetails_ColumnName  = 'Narration'

    } 

   
  if (uploadtype=='account' || uploadtype == 'ecs'){  
          
         uploadedFile.inputStream.toCsvReader(['skipLines':'0']).eachLine{ tokens ->
       // println "printing a row"
        for(token in tokens) {
            //print token
        }
        if(count ==0){
            // for headers  
            println "=========READING HEADERS============"          
            amountIndex = helperService.findColumnIndex(tokens,amountColumnName)
            if(modeColumnName!= null){
                modeIndex = helperService.findColumnIndex(tokens,modeColumnName)
            }

            donornameIndex = helperService.findColumnIndex(tokens,donornameColumnName)
            if(donorIdColumnName != null){
                donorIdIndex = helperService.findColumnIndex(tokens,donorIdColumnName)
            }

            if(txnIdColumnName!= null){
                txnIdIndex = helperService.findColumnIndex(tokens,txnIdColumnName)
            }

            if(bankNameColumnName!= null){
                bankNameIndex = helperService.findColumnIndex(tokens,bankNameColumnName)
            }

            if(memberdetails_1_ColumnName!= null){
              memberdetails_1_Index = helperService.findColumnIndex(tokens,memberdetails_1_ColumnName)
            }
            if(memberdetails_2_ColumnName!= null){
              memberdetails_2_Index = helperService.findColumnIndex(tokens,memberdetails_2_ColumnName)
            }

            if(paymentdetails_ColumnName != null){
              paymentdetails_Index = helperService.findColumnIndex(tokens,paymentdetails_ColumnName)
            }


            donationDateIndex = helperService.findColumnIndex(tokens,donationDateColumnName)
            count++
        }
        else{
            println "===========READING ROW NUMBER "+count+"============="
             amountColumnValue = tokens[amountIndex]
             modeColumnValue =  modeIndex!=null?tokens[modeIndex]:null
             donorNameColumnValue = donornameIndex!=null?tokens[donornameIndex]:null
             donorIdColumnValue = donorIdIndex!=null?tokens[donorIdIndex]:null
             txnIdColumnValue =  txnIdIndex!=null?tokens[txnIdIndex]:null
             bankNameColumnValue = bankNameIndex!=null?tokens[bankNameIndex]:null
             donationDateColumnValue=donationDateIndex!=null?tokens[donationDateIndex]:null
             memberdetails_1_ColumnValue = memberdetails_1_ColumnName!=null?tokens[memberdetails_1_Index]:null
             memberdetails_2_ColumnValue = memberdetails_2_ColumnName!=null?tokens[memberdetails_2_Index]:null
             paymentdetails_ColumnValue = paymentdetails_ColumnName!=null?tokens[paymentdetails_Index]:null
             


             skipcreation = false
             if(modeIndex != null){
                paymentmode = modeColumnValue
            }
            else {
                paymentmode = defaultModeName
            }

            if(skipPaymentMode != null){
               if(params.excludeecsdata != null){
                    if(paymentmode== skipPaymentMode){
                        skipcreation = true
                    }
                } 
            }
            
        if(!skipcreation){
              record = new DonationRecord()
            try{
            	record.amount= amountColumnValue?.toBigDecimal()
            }
            catch(Exception e) {
            log.debug(amountColumnValue+"->"+e.printStackTrace())
            record.amount=0
            }
            record.paymentDetails = ''
            if(record.amount==0){
              record.comments = 'PLEASE UPDATE REASON HERE'
              record.paymentDetails = 'BOUNCED::'
            }
            //ecs errors
            def ecsErrorCode=-1
            try{
            	ecsErrorCode = new Integer(memberdetails_1_ColumnValue?:0)
            }
            catch(Exception e) {
            }
            if(ecsErrorCode>0)
            	{
            	record.expectedamount=record.amount
            	record.amount=0
              record.comments = 'PLEASE UPDATE REASON HERE'
            	record.paymentDetails = "BOUNCED::ECS Failure Code: "+memberdetails_1_ColumnValue+" ECS Failure Reason: "+memberdetails_2_ColumnValue
            	}
            	
            record.mode = PaymentMode.findByName(paymentmode)
            if(record.mode==null){
                errorflag = true
            }
            
             if(paymentdetails_ColumnValue != null){
              record.paymentDetails = record.paymentDetails +paymentdetails_ColumnValue +'::'
            }
            record.paymentDetails = record.paymentDetails + "Details::"+donorNameColumnValue+",Amount="+ amountColumnValue + ",payment mode="+ paymentmode+",donorid="+donorIdColumnValue+",txn="+txnIdColumnValue+",bank="+bankNameColumnValue+",date="+donationDateColumnValue
            record.transactionId = "Receipt No:"+ txnIdColumnValue
            record.reference= bankNameColumnValue
            
            record.donationDate = Date.parse(donationDateFormat,donationDateColumnValue)

            if(memberdetails_1_ColumnName!= null || memberdetails_2_ColumnName!= null)
              {
                   record.memberdetails = ''
                  if(memberdetails_1_ColumnValue!='' )
                      record.memberdetails = memberdetails_1_ColumnValue

                    if(memberdetails_2_ColumnValue!='')
                      record.memberdetails =  record.memberdetails +"  "+memberdetails_2_ColumnValue
              }

            donorId = donorIdColumnValue.replace("'","")

            record.transactionDetails = donorId

            def commitment = Commitment.findByEcsMandate(donorId)

            println "################################commitment"
            println commitment

            if(commitment != null)record.donatedBy  = commitment.committedBy
            
            arecord = DonationRecord.findByTransactionId(record.transactionId)
            if(arecord){
                // already this record is created
                record.alreadyExist = 'found'
                duplicaterecordfound = true  
            }

           /*find all other donations by the member in the same month*/
        
        firstdate = record.donationDate - record.donationDate.getAt(Calendar.DAY_OF_MONTH)
        lastdate = firstdate +31

        if(record.donatedBy != null){
            samemonthdonations = DonationRecord.createCriteria().list(){   
                                 
                    eq('donatedBy',record.donatedBy)                                                    
                    gt('donationDate',firstdate)
                    lt('donationDate',lastdate)
                        
            } 
            record.samemonthdonations = samemonthdonations   
        }
        

            recordlist.add(record)
            count++  
            }
        
        }

       
        
     }

    }
    
     count--
     session.data = recordlist
     flash.message = 'File contains '+ count + ' records.'
     return [recordlist:recordlist,errorflag:errorflag,duplicaterecordfound:duplicaterecordfound,usepercentagededuction:usepercentagededuction]
    /*File upload code on grails*/
    def userDir = new File(webRootDir, "/paymentdata/")
     userDir.mkdirs()
     uploadedFile.transferTo( new File( userDir, uploadedFile.originalFilename))

    }
     
     def savefiledata={
          if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_ECS')){
           render "The record is not available for viewing!!"
           return
        }
        if(session.data){
            def recordlist = session.data
            def count = recordlist?.size()
            def scount = 0
            def secondcentrecount =0
            for(record in recordlist){
                if(record.donatedBy != null && record.alreadyExist==null){
                    
                    scount++
                    record.updator=springSecurityService.principal.username
                    record.creator=springSecurityService.principal.username

                    
                
                //  try splitting the record into multiple records on the basis of commitment
		            donationService.split(record)                
                }
                //println record
            }
            session.data = null
            flash.message = count +'  Records were in File  '
        }
        
    }
    
    //create formal Donation entries from DonationRecords which don't have the corresponding donation in the first place
    def createDonationFromDR() {
    	render donationService.createDonationFromDR(params)
    }

/*
this method will first fetch all those donation records which have center as null
then loop on such records then find corresponding scheme member and copy the center from there
*/
    def updateDonationRecordWithEmptyCenterBySchemeMemberCenter={
      if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "you not authorized to do this action!!"
           return
        }
        def schemes= helperService.getSchemesForRole('ROLE_DONATION_EXECUTIVE',session.individualid)

        def recordsWithEmptyCenter = DonationRecord.createCriteria().list(){                     
            'in'("scheme",schemes)
            isNull("centre")
        }  

        for(record in recordsWithEmptyCenter){
          def schemeMemberInstance = SchemeMember.findBySchemeAndMember(record.scheme, record.donatedBy)
          if(schemeMemberInstance != null){
            record.centre = schemeMemberInstance.centre
             if (!record.save()) {
                    record.errors.each {
                        println it
                      }
              }
          }
        }  

        render "All Records (having no center) have been updated with centers."

    }

/*
this will update all scheme members with their commitent mode
first fetch all scheme members
iterate over all of them ,find for each last made donation and update commitment mode based on that
this is expensive operation
*/
    def updateSchemeMembersCommitmentMode={
        if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
        render "you can not perform this action!!"
           return
        }
        def role = helperService.getDonationUserRole()
        def schemes = helperService.getSchemesForRole(role, session.individualid)  
        def members = SchemeMember.createCriteria().list(){
           'in'("scheme",schemes)
        }
        members.each{member->
            //fetch the last payment done by this member
            member.committedMode = null
            def individual = member.member
            if(individual != null){
              def latestdonationrecord = DonationRecord.createCriteria().list(){              
                eq('donatedBy', individual)
                isNotNull("mode")
                order("donationDate","desc")
                maxResults(1)
              }

              latestdonationrecord.each{record->
                //there will be only one record
                if(record.mode.name.contains("ECS")){
                  member.committedMode="ECS"
                }
                if(record.mode.name.contains("Cash") || record.mode.name.contains("Card") || record.mode.name.contains("Cheque")){
                  member.committedMode="CASH"
                }
                if(record.mode.name.contains("NEFT") || record.mode.name.contains("RTGS") || record.mode.name.contains("Transfer")){
                  member.committedMode="E-PAYMENT"
                }

              }

            }

            //record.save()
              if (!member.save()) {
              member.errors.each {
                  println it
              }
            }
        } 

         render "All Scheme Members are update with Commitment mode based on their last payment"
    }

/*
it will list all those individuals who have given donation Record but not having scheme membership
*/
    def findDonationRecordsHavingNoSchemeMember={
      if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
        render "you can not perform this action!!"
           return
        }  
    def role = helperService.getDonationUserRole()
    def schemes = helperService.getSchemesForRole(role, session.individualid)

    def individualshavingscheme = SchemeMember.createCriteria().list(){
        projections{
          property("member")
        }
        'in'("scheme",schemes)
    }

    def fromDate = null

    println "fromdate ====" +params.fromDate
    
    if(params.fromDate != 'undefined' && params.fromDate !='' && params.fromDate != null){
      fromDate = Date.parse('dd-MM-yyyy', params.fromDate)
    }

    def individualsHavingNoScheme = DonationRecord.createCriteria().list(){
      projections{          
          groupProperty("donatedBy")
          sum("amount","sumamount")
        }
       not{ 'in' ("donatedBy", individualshavingscheme)}
       'in'("scheme",schemes)
       if(fromDate != null)ge("donationDate", fromDate)
       order("sumamount","desc")
    }
    
    return [schemes:schemes , size:individualsHavingNoScheme.size(), individuals:individualsHavingNoScheme, fromDate:params.fromDate]

    }

    def createzeropaymentrecords={
       if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "The record is not available for viewing!!"
           return
        }
        session.data= null

        def schemes= helperService.getSchemesForRole('ROLE_DONATION_EXECUTIVE',session.individualid)

        return [schemes:schemes]


    }

    /*
    fetch all those scheme members which have not paid during that month
    */

    def fetchrecordsforzeropayment={
       if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "The record is not available for viewing!!"
           return
        }
        session.data= null
         if(params.donationDate)
         params.donationDate = Date.parse('dd-MM-yyyy', params.donationDate)

        def scheme = Scheme.findById(params.scheme)
        def donationdate = params.donationDate
        def firstdate = donationdate - donationdate.getAt(Calendar.DAY_OF_MONTH)
        def lastDate = firstdate + 31

        

        def individualswhogave = DonationRecord.createCriteria().listDistinct(){
          projections{
            property('donatedBy')
          }
            gt('donationDate',firstdate)
            lt('donationDate',lastDate)
            eq('scheme',scheme)
        }       

        def members = SchemeMember.createCriteria().list(){
                eq('scheme',scheme)
                if(individualswhogave){
                  not{ 'in'('member',individualswhogave)}  
                }
                'in'('status',['ACTIVE','RESUMED','IRREGULAR'])
                
        }
        session.data= ['membersnotgiven':members,'donationDate':donationdate,'scheme':scheme]

        return [members:members]

        

    }

     def savezeropaymentrecords={
       if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "The record is not available for viewing!!"
           return
        }
        if(session.data != null){

          def membersnotgiven = session.data.membersnotgiven
          def donationDate = session.data.donationDate
          def scheme = session.data.scheme
          def record
          def month = donationDate.format('MMM')
          def year = donationDate.format('YYYY')
          for(member in membersnotgiven){
            record = new DonationRecord()
            record.donatedBy = member.member
            record.scheme = scheme
            record.donationDate = donationDate
            record.centre = member.centre
            record.amount = 0
            record.comments= 'NOT PAID IN MONTH OF ' + month +', YEAR OF '+ year
            record.paymentDetails =  'NOT PAID IN MONTH OF ' + month +', YEAR OF '+ year
            record.updator=springSecurityService.principal.username
             record.creator=springSecurityService.principal.username

              //record.save()
              if (!record.save()) {
              record.errors.each {
                  println it
              }
            }

          }
          session.data= null
        }

    }
def donationRecordDataExportAsCVS={
   if (!SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE')){
           render "The record is not available for viewing!!"
           return
        }
      def donationDate  = null
      def firstDate = null
      def lastDate = null
      if(params.donationDate!= null && params.donationDate.trim() != ""){
          donationDate = Date.parse('dd-MM-yyyy', params.donationDate)
      }
      else {
        donationDate = new Date()
      }

      if(donationDate != null){
        firstDate = donationDate - donationDate.getAt(Calendar.DAY_OF_MONTH)
          lastDate = firstDate + 31
      }
    def exportType = params.exportType
    def role = helperService.getDonationUserRole()
    def schemes = helperService.getSchemesForRole(role, session.individualid)
    def result 
    def resultlist=[]
     def centredonationmap=[:]
     def numberofmonths = params.numberofmonths
  if(exportType =='Full Data'){

    result = DonationRecord.createCriteria().list() {
                'in'('scheme',schemes)
                 if(params.selectedcenter!= null && params.selectedcenter !='ALL'){
                  centre{
                    eq("name",params.selectedcenter)
                  }
                }
                centre{
                    order('name','asc')
                  }
                if(donationDate != null){
                   // gt('donationDate',firstDate)
                    //lt('donationDate',lastDate)
                    sqlRestriction "month(donation_date) = "+((donationDate.month).toInteger() +1) + "  AND year(donation_date) = "+((donationDate.getAt(Calendar.YEAR)).toInteger())                        
                } 
                if(params.member) {
                donatedBy{
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
                if(params.amount){
                  ge("amount",new BigDecimal(Integer.parseInt(params.amount))) 
                }
                if(params.mode){
                  mode{
                    eq("name",params.mode)
                  }
                }
                if(params.comments){
                  ilike("comments",'%'+params.comments+'%')
                }
                if(params.paymentDetails){
                  ilike("paymentDetails",'%'+params.paymentDetails+'%')
                }

                if(params.transactionId){
                  ilike("transactionId",'%'+params.transactionId+'%')
                }

                if(params.receiptReceivedStatus){
                  eq("receiptReceivedStatus",params.receiptReceivedStatus)
                }

              }
      }
          
      else if(exportType =='Summary Report'){
        
        

        def range = 1..4
        if(!range.contains(numberofmonths.toInteger())){
           render "Select Proper Value!!"
           return
        }
        def count =0
        def newdate = donationDate
        while(count < numberofmonths.toInteger()){
            
            println "fetching donation records for "+newdate
            result = DonationRecord.createCriteria().list() {
                projections{                                        
                    groupProperty("centre")
                    sum("amount")                     
                    isNotNull("centre")
                }
                'in'('scheme',schemes)
                 if(params.selectedcenter!= null && params.selectedcenter !='ALL'){
                  centre{
                    eq("name",params.selectedcenter)
                  }
                }
                if(donationDate != null){
                    //gt('donationDate',firstDate)
                    //lt('donationDate',lastDate)
                    sqlRestriction "month(donation_date) = "+((newdate.month).toInteger() +1) + "  AND year(donation_date) = "+((newdate.getAt(Calendar.YEAR)).toInteger())                        
                }
                  centre{
                    order('name','asc')
                  }
                } 
            resultlist.add([newdate,result])
            println result
            count = count +1
            for(row in result){
              //row[0] is centre , row[1] is amount
              //def dateamountmap =  new HashMap()
              //dateamountmap[newdate] = row[1]
              if(centredonationmap[row[0]] == null){
                centredonationmap[row[0]] = new HashMap()
                centredonationmap[row[0]][count] =row[1]
              }
              else{
                centredonationmap[row[0]][count] =row[1]
              }
            }
            newdate = newdate - 30
            }
        }
      
      println "========exporting donation record data into CVS=========="
      
      def filename = "donationRecordData_"+params.selectedcenter+".${params.extension}"
      response.contentType = grailsApplication.config.grails.mime.types[params.formats]
      response.setHeader("Content-disposition", "attachment; filename="+filename) 
      List fields
      if(exportType =='Full Data')fields = ["Member","Amount","Scheme","Centre",
                                            "Mode","Donation Date",
                                            "Comments","Payment Details",
                                            "Transaction Id","ReceiptBookNo","ReceiptNo","ReceiptStatus"]
      else if(exportType =='Summary Report'){
        fields = ["Centre"]
        resultlist.each{fields.add(it[0]?.format('MMM-yyyy')?.toString()+"-Total Amount") }
      }

      else {
        render "The record is not available for viewing!!"
           return
      }

      Map labels = [:]
      def data=new ArrayList()
      def total= new BigDecimal("0")
      if(exportType =='Full Data'){
          for(record in result){
            def row= new HashMap()
            
              row[fields[0]]=record.donatedBy?.legalName
              row[fields[1]] = record.amount
              row[fields[2]]=record.scheme?.name
              row[fields[3]] = record.centre?.name
              row[fields[4]] = record.mode
              row[fields[5]] = record.donationDate?.format('dd-MMM-yyyy')?.toString()
              row[fields[6]] = record.comments
              row[fields[7]] = record.paymentDetails
              row[fields[8]] = record.transactionId
              row[fields[9]] = record.rbno
              row[fields[10]] = record.rno
              row[fields[11]] = record.receiptReceivedStatus

              total = total + record.amount
            
            
             
            
            data.add(row) 
          }
           def row= new HashMap()
          row[fields[0]]="TOTAL"
          row[fields[1]]= total
          data.add(row)
      }
      if(exportType =='Summary Report'){
         println "-------printing centredonationmap---------"
         println centredonationmap
         centredonationmap.each{
          key,value->
          def row= new HashMap()
          row[fields[0]] = key.name
          def i =1
          while(i <= numberofmonths){
            row[fields[i]] = (value[i]==null)?0:value[i]
            i++
          }

          data.add(row)
         }
        }
     
      
      exportService.export(params.format, response.outputStream,data, fields,labels, [:], [:])
  }

def jq_alldonationrecord_list = {
    //  log.debug("Inside jq_alldonationrecord_list..."+params)
     
  def maxRows = Integer.valueOf(params.rows)
  def currentPage = Integer.valueOf(params.page) ?: 1
      println "---------------------jq_alldonationrecord_list-----------" 
      println "centre is "+params.centre
      def result
      
       
   if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE,ROLE_NVCC_ADMIN,ROLE_DUMMY'))
          {
               result = donationRecordDataWithFilters()
          }
   else if (SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE,ROLE_PATRONCARE_USER'))
          {
               result = donationRecordDataForPC()
          }
      
      def totalRows = (result?.totalCount)?:0
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
                  it.scheme?.name,
                  it.donatedBy?.toString(),
                  it.amount,
                  it.mode?.toString(),
                  it.donationDate.format("dd-MMM-yyyy")?.toString(),
                  it.comments,
                  it.paymentDetails,
                  it.transactionId,
                  it.centre?.name,
                  it.receiptReceivedStatus,
                  it.creator,
                  it.rbno?:'',
                  it.rno?:'',
                  it.donation?.toString()?:''
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }



def donationRecordDataWithFilters(){
      log.debug("In donationRecordDataWithFilters with params: "+params)
      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

       def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'

       def role = helperService.getDonationUserRole()
      def schemes = helperService.getSchemesForRole(role, session.individualid)

      def donationDate  = null
      def firstDate = null
      def lastDate = null
      if(params.donation_date!= null && params.donation_date.trim() != ""){
          donationDate = Date.parse('dd-MM-yyyy', params.donation_date)
          
          firstDate = donationDate - donationDate.getAt(Calendar.DAY_OF_MONTH)
          lastDate = firstDate + 31
          
      }      
     
      def result = DonationRecord.createCriteria().list(max:maxRows, offset:rowOffset) {
               if (SpringSecurityUtils.ifAnyGranted('ROLE_DONATION_EXECUTIVE'))
               	'in'('scheme',schemes)
                
              if(params.member) {
                donatedBy{
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
                if(params.amount){
                  ge("amount",new BigDecimal(Integer.parseInt(params.amount))) 
                }
                if(params.mode){
                  mode{
                    eq("name",params.mode)
                  }
                }
                if(params.comments){
                  ilike("comments",'%'+params.comments+'%')
                }
                if(params.paymentDetails){
                  ilike("paymentDetails",'%'+params.paymentDetails+'%')
                }

                if(params.transactionId){
                  ilike("transactionId",'%'+params.transactionId+'%')
                }
                if(params.selectedcenter!= null && params.selectedcenter !='ALL'){
                  centre{
                    eq("name",params.selectedcenter)
                  }
                }

               if(donationDate != null){

                    //gt('donationDate',firstDate)
                   // lt('donationDate',lastDate)                   
                    sqlRestriction "month(donation_date) = "+((donationDate.month).toInteger() +1) + "  AND year(donation_date) = "+((donationDate.getAt(Calendar.YEAR)).toInteger())                        
                } 
                
                if(params.receiptReceivedStatus!= null && params.receiptReceivedStatus !='ALL'){
                  ilike("receiptReceivedStatus",params.receiptReceivedStatus+'%')
                }

                if(params.creator){
                  ilike("creator",'%'+params.creator+'%')
                }
                if(params.rbno){
                  ilike("rbno",'%'+params.rbno+'%')
                }

                if(params.rno){
                  ilike("rno",'%'+params.rno+'%')
                }


                order(sortIndex,sortOrder)
              }
        return result  
}

def donationRecordDataForPC(){
      log.debug("In donationRecordDataForPC with params: "+params)

	/*def pcGroup, pcGroupStr	
	pcGroup = housekeepingService.getPCGroup()
	pcGroupStr = pcGroup.toString().replace("[","")
	pcGroupStr = pcGroupStr.toString().replace("]","")*/

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

       def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'

      def result = DonationRecord.createCriteria().list(max:maxRows, offset:rowOffset) {
               	eq('creator',springSecurityService.principal.username)
                
              if(params.member) {
                donatedBy{
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
                if(params.amount){
                  ge("amount",new BigDecimal(Integer.parseInt(params.amount))) 
                }
                if(params.mode){
                  mode{
                    eq("name",params.mode)
                  }
                }
                if(params.comments){
                  ilike("comments",'%'+params.comments+'%')
                }
                if(params.paymentDetails){
                  ilike("paymentDetails",'%'+params.paymentDetails+'%')
                }

                if(params.transactionId){
                  ilike("transactionId",'%'+params.transactionId+'%')
                }

                if(params.receiptReceivedStatus){
                  ilike("receiptReceivedStatus",params.receiptReceivedStatus+'%')
                }

                if(params.creator){
                  ilike("creator",'%'+params.creator+'%')
                }
                if(params.rbno){
                  ilike("rbno",'%'+params.rbno+'%')
                }

                if(params.rno){
                  ilike("rno",'%'+params.rno+'%')
                }
                
                order(sortIndex,sortOrder)
              }
        return result  
}

	def saveQuickCreate() {
		log.debug("Inside saveQuickCreate with params:"+params)
		def dr = donationService.createDonationRecord(params)
		if(dr)
			{
			redirect(action: "print", id: dr.id)
			return
			}
		else
			{
			render(view: "quickCreate", model: [donationRecordInstance: dr]) 
			return
			}
	}
	
	def print() {
		def dr = DonationRecord.get(params.id)
		render(template: "tempreceipt", model: [donationRecordInstance:dr])
	}

	def bulkPrintView() {
	      log.debug("Inside bulkPrintView with params: "+params)
	      if(params.fromDate)
		params.fromDate = Date.parse('dd-MM-yyyy', params.fromDate)
	      else
		params.fromDate = new Date()

	      params.fromDate.clearTime()

	      def fromDate = params.fromDate.format('yyyy-MM-dd HH:mm:ss')	//'2014-05-01 00:00:00'

	      if(params.toDate)
		params.toDate = Date.parse('dd-MM-yyyy', params.toDate)
	      else
		params.toDate = new Date()

	      params.toDate.clearTime()

	      
	      def toDate = params.toDate.format('yyyy-MM-dd')+' 23:59:59'	//'2014-05-01 00:00:00'
	      
	      
	      //first update any miised records with rbno/rno
	      def drs = DonationRecord.createCriteria().list{
	      	isNull('receiptReceivedStatus')
	      	isNull('comments')
	      	isNull('rbno')
	      	isNull('rno')
	      	isNull('donation')	//to prevent synced drs with donations
	      	gt('amount',new BigDecimal(0))
	      	ge('donationDate',params.fromDate)
	      	le('donationDate',params.toDate)
	      	donatedBy{
	      		order('legalName')
	      	}
	      	order('donationDate')
	      	}
	      	
	      log.debug("bulkPrintView: found #drs:"+drs.size())
	      	
	      drs.each{dr->
	      	dr.rbno = "ECS-"+housekeepingService.getFY()
	      	dr.rno = receiptSequenceService.getNext(dr.rbno)
	      	//dr.rno = receiptSequenceService.getNext("DONATION-ECS")
	      	if(!dr.save())
	      		dr.errors.allErrors.each {
			             			log.debug(it)
             			}
	      }
	      
	      //now get all the drs in the period
	      drs = DonationRecord.createCriteria().list{
	      	isNull('receiptReceivedStatus')
	      	isNull('comments')
	      	isNull('donation')	//to prevent synced drs with donations
	      	gt('amount',new BigDecimal(0))
	      	ge('donationDate',params.fromDate)
	      	le('donationDate',params.toDate)
	      	donatedBy{
	      		order('legalName')
	      	}
	      	order('donationDate')
	      	}
	      	
	      log.debug("bulkPrintView: found (with rbno,rno) #drs:"+drs.size())

	      def drList = []
	      	
	      drs.each{dr->
           		drList.add(dr)
	      }
	      
	      //log.debug("bulkreceipt: "+drList)
		render(template: "bulkreceipt", model: [drList:drList,printedBy:(params.authority?:'')])
	      
	}
	
	def bulkPrint() {
		if(params.idlist) {
	      		def drList = []
			params.idlist.tokenize(',').each {
				drList.add(DonationRecord.get(it))
			}
			render(template: "bulkreceipt", model: [drList:drList,printedBy:Individual.get(params.authorityid)])
			return
		}
	}


}

