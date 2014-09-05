package ics

import grails.converters.JSON
class FollowupController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def housekeepingService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
    	println 'params.cmd='+params.cmd
    	println 'params='+params
        if(!params.sort)
        	params.sort = "id"
        if(!params.order)
        	params.order = "desc"

	/*if(session.showall!=null && session.showall==false)
		{
		def followupInstanceList = housekeepingService.followupsBy()
		[followupInstanceList: followupInstanceList, followupInstanceTotal: followupInstanceList.size]

		}
	else
		{
        	params.max = Math.min(params.max ? params.int('max') : 10, 100)
	        [followupInstanceList: Followup.list(params), followupInstanceTotal: Followup.count()]
	        }*/
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		def model = []
		def followUpList = [], pcSevakFollowUpList = []
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE'))
		{
			def login = springSecurityService.principal.username
			println "Loggedin user: "+login
			def individual = Individual.findByLoginid(login)
			println "setSessionParams for: "+individual

			def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
			println 'pcRole='+pcRole
			def patronCareHead, patronCareSevaks = []

			for(int i=0; i<pcRole.size(); i++)
			{
				if(pcRole[i].toString() == "PatronCare")
				{
					followUpList = Followup.findAllByFollowupBy(individual)

					def sevakOfRelation = Relation.findByName("Sevak of")
					patronCareSevaks = Relationship.findAllWhere(individual2:individual, relation:sevakOfRelation, status:"ACTIVE").individual1		
					println 'patronCareSevaks='+patronCareSevaks
					for(int j=0; j<patronCareSevaks.size(); j++)
					{
						pcSevakFollowUpList = Followup.findAllByFollowupBy(patronCareSevaks[j])
						for(int k=0; k<pcSevakFollowUpList.size(); k++)
						{
							followUpList.add(pcSevakFollowUpList[k])
						}
					}
				}
				if(pcRole[i].toString() == "PatronCareSevak")
				{
					followUpList = Followup.findAllByFollowupBy(individual)
				}			
			}
		}	
		println 'followUpList='+followUpList
		println 'followUpList?.followupWith='+followUpList?.followupWith
		
		//def donationsList = Donation.find("from Donation sum(amount) where donated_by_id="+followUpList?.followupWith?.id)
		//println 'donationsList='+donationsList
	    if (request.xhr) {
		render(template: "followupGrid", model: ['cmd':params.cmd,'findwithid':params.findwithid,'findbyid':params.findbyid?:session.individualid])
	    }
	    else {
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE'))
			//todo hardcoding here..
			//render(template: "followupGrid", model: ['cmd':'fby','findbyid':session.individualid,'findwithid':params.'33972'])
			//model = ['followupInstanceList': followUpList, 'followupInstanceTotal': followUpList.size(),'cmd':'fby', 'findbyid':session.individualid]
			model = ['followupInstanceList': followUpList, 'followupInstanceTotal': followUpList.size(),'cmd':'fby', 'findbyid':followUpList?.followupBy?.id]
		else
			model = [followupInstanceList: Followup.list(params), followupInstanceTotal: Followup.count(),'cmd':params.cmd,'findwithid':params.findwithid,'findbyid':params.findbyid?:session.individualid]
	    }
    }
    def list1 = {
    	println 'params.cmd='+params.cmd
    	println 'params='+params
        if(!params.sort)
        	params.sort = "id"
        if(!params.order)
        	params.order = "desc"

	/*if(session.showall!=null && session.showall==false)
		{
		def followupInstanceList = housekeepingService.followupsBy()
		[followupInstanceList: followupInstanceList, followupInstanceTotal: followupInstanceList.size]

		}
	else
		{
        	params.max = Math.min(params.max ? params.int('max') : 10, 100)
	        [followupInstanceList: Followup.list(params), followupInstanceTotal: Followup.count()]
	        }*/
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		def model = []
		def followUpList = [], pcSevakFollowUpList = []
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE'))
		{
			def login = springSecurityService.principal.username
			println "Loggedin user: "+login
			def individual = Individual.findByLoginid(login)
			println "setSessionParams for: "+individual

			def pcRole = IndividualRole.findAllByIndividualAndStatus(individual,"VALID").role
			println 'pcRole='+pcRole
			def patronCareHead, patronCareSevaks = []

			for(int i=0; i<pcRole.size(); i++)
			{
				if(pcRole[i].toString() == "PatronCare")
				{
					followUpList = Followup.findAllByFollowupBy(individual)
					println 'followUpList='+followUpList
					
					def sevakOfRelation = Relation.findByName("Sevak of")
					patronCareSevaks = Relationship.findAllWhere(individual2:individual, relation:sevakOfRelation, status:"ACTIVE").individual1		
					println 'patronCareSevaks='+patronCareSevaks
					for(int j=0; j<patronCareSevaks.size(); j++)
					{
						pcSevakFollowUpList = Followup.findAllByFollowupBy(patronCareSevaks[j])
						for(int k=0; k<pcSevakFollowUpList.size(); k++)
						{
							followUpList.add(pcSevakFollowUpList[k])
						}
					}
				}
				if(pcRole[i].toString() == "PatronCareSevak")
				{
					followUpList = Followup.findAllByFollowupBy(individual)
				}			
			}
		}	
		println 'followUpList='+followUpList
		println 'followUpList.size()='+followUpList.size()
		println 'followUpList?.followupWith='+followUpList?.followupWith
		println 'followUpList?.followupBy='+followUpList?.followupBy
		
		//def donationsList = Donation.find("from Donation sum(amount) where donated_by_id="+followUpList?.followupWith?.id)
		//println 'donationsList='+donationsList
	    if (request.xhr) {
		render(template: "followupGrid", model: ['cmd':params.cmd,'findwithid':params.findwithid,'findbyid':params.findbyid?:session.individualid])
	    }
	    else {
		if(org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_PATRONCARE'))
			//todo hardcoding here..
			//render(template: "followupGrid", model: ['cmd':'fby','findbyid':session.individualid,'findwithid':params.'33972'])
			model = ['followupInstanceList': followUpList, 'followupInstanceTotal': followUpList.size(),'cmd':'fby', 'findbyid':followUpList?.followupBy?.id]
		else
			model = [followupInstanceList: Followup.list(params), followupInstanceTotal: Followup.count(),'cmd':params.cmd,'findwithid':params.findwithid,'findbyid':params.findbyid?:session.individualid]
	    }
    }

    def create = {
        def followupInstance = new Followup()
        followupInstance.properties = params
        def showAll = session.showall
        def iname
        def rilist
        def iid
        /*if(!session.showall)
        	{
        	iname = session.individualname
        	rilist = housekeepingService.filterIndividualList()
        	iid = session.individualid
        	}*/
        if(params.individualid)
        	{
        	followupInstance.followupWith = Individual.get(params.individualid)
        	followupInstance.followupBy = Individual.get(session.individualid)
        	}
        return [followupInstance: followupInstance,showAll: showAll, iname: iname,rilist: rilist,iid: iid, specific:(params.individualid)?true:false, ids: params.ids]
    }

    def createforbouncedcheque = {
    println '--------- Followup createforbouncedcheque---------'
    println 'params='+params
	//create a followup for bounced cheque
	def bc = BouncedCheque.get(params.'bouncedCheque.id')
	println 'bc='+bc
	if(!bc)
		{
		flash.message = 'Invalid Dishonoured Cheque Id supplied!!'
		redirect(controller: "bouncedCheque", action: 'list')
		return
		}
	    def f = new Followup()
	    
	    f.followupWith  = bc.donation.donatedBy
	    f.followupBy = params."acfollowupBy" //bc.donation.collectedBy
	    //f.followupBy.id  = params."followupBy.id"
	    //f.followupWith  = Followup.followupWith
	    f.startDate = new Date()
	    f.category = "Dishonoured Cheque"
	    f.status = "OPEN"
	    f.description = bc.toString()
	    f.ref= bc.donation?.nvccReceiptBookNo +":" + bc.donation?.nvccReceiptNo
	println 'f='+f
	println 'f.followupWith='+f.followupWith
	/*def role = Role.findByName("Follower")
	def c = Individual.createCriteria()
	def followers = c.list
		{
		individualRoles
			{
			eq("role",role)
			}
			order("initiatedName", "asc")
			order("legalName", "asc")
		}*/

        return [followupInstance: f]
    }

    def save = {
    	println '--------- Followup save---------'
    	//println 'params='+params
    	if(params.startDate)
		params.startDate = Date.parse('dd-MM-yyyy', params.startDate)
	else
		params.startDate = new Date()
	if(params.endDate)
		params.endDate = Date.parse('dd-MM-yyyy', params.endDate)
    	
    	if(params."acfollowupBy_id")
	    	params."followupBy.id"= params."acfollowupBy_id"
	else if(params.individualid)
		params."followupBy.id"= params.individualid
	else
		params."followupBy.id" = session.individualid
		
        println 'followupBy.id='+params."followupBy.id"
        if(params."acfollowupWith_id")
	    params."followupWith.id"= params."acfollowupWith_id"

        println 'followupWith.id='+params."followupWith.id"
	
	
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator
	params.description=""
	println 'params='+params
	println 'params.ids='+params.ids
	println "list printing"
	params.ids?.each{println "id:"+it}
	println "list printed"
        def followupInstance
        if(!params.ids)
        {
		followupInstance = new Followup(params)
		followupInstance.followupWith = Individual.get(params.ids)
		if (followupInstance.save(flush: true)) {
		
		    flash.message = "${message(code: 'default.created.message', args: [message(code: 'followup.label', default: 'Followup'), followupInstance.id])}"
		    redirect(action: "show", id: followupInstance.id)
		}
		else {
		    render(view: "create", model: [followupInstance: followupInstance])
		}
        }
        else
        	{
        	//create multiple followups
        	params.ids.tokenize(',').each{
        		followupInstance = new Followup(params)
			followupInstance.startDate = new Date()
			followupInstance.endDate = new Date()        		
        		followupInstance.followupWith = Individual.get(it)
        		followupInstance.description = ""
        		println 'followupInstance.followupWith ='+followupInstance.followupWith
        		
        		//followupInstance.followupWith = Individual.get(it)
        		if (!followupInstance.save(flush: true))
        			followupInstance.errors.each{println it}
        		}
		if (request.xhr) 
		{
			render "Followups created successfully!"
			return
		}
		else
			render followupInstance.errors.each{it}
			return
        	//redirect(action: "list")
        	}
    }

    def show = {
        def followupInstance = Followup.get(params.id)
        if (!followupInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'followup.label', default: 'Followup'), params.id])}"
            redirect(action: "list")
        }
        else {
            [followupInstance: followupInstance]
        }
    }

    def edit = {
        def followupInstance = Followup.get(params.id)
        if (!followupInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'followup.label', default: 'Followup'), params.id])}"
            redirect(action: "list")
        }
        else {

        	def role = Role.findByName("Follower")
        	def c = Individual.createCriteria()
		//show all followers
		def followers = c.list
			{
			individualRoles
				{
				eq("role",role)
				}
				order("initiatedName", "asc")
				order("legalName", "asc")
			}

		def showAll = session.showall
		def indByList = []
		def indWithList
		if(!session.showall)
			{
			indWithList = housekeepingService.filterIndividualList()
			indByList.push(housekeepingService.getIndividual((String) session.individualid))
			return [followupInstance: followupInstance,showAll: showAll,indWithList: indWithList, indByList: indByList]
			}
		else
	            return [followupInstance: followupInstance,showAll: showAll,followers: followers]
        }
    }

    def update = {
        params.comments = params.oldcomments + ":"+params.comments
        def followupInstance = Followup.get(params.id)
    	if(params.startDate)
			params.startDate = Date.parse('dd-MM-yyyy', params.startDate)
	if(params.endDate)
		params.endDate = Date.parse('dd-MM-yyyy', params.endDate)
        
        if (followupInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (followupInstance.version > version) {
                    
                    followupInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'followup.label', default: 'Followup')] as Object[], "Another user has updated this Followup while you were editing")
                    render(view: "edit", model: [followupInstance: followupInstance])
                    return
                }
            }
            if (followupInstance.status=="CLOSED" || followupInstance.status=="DELETED") {
                    flash.message = "Cannot edit a CLOSED or DELETED entry!!"
                    render(view: "show", model: [followupInstance: followupInstance])
                    return
            }
		if (springSecurityService.isLoggedIn()) {
			params.updator=springSecurityService.principal.username
		}
		else
			params.updator="unknown"
            
            followupInstance.properties = params
            if (!followupInstance.hasErrors() && followupInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'followup.label', default: 'Followup'), followupInstance.id])}"
                redirect(action: "show", id: followupInstance.id)
            }
            else {
                render(view: "edit", model: [followupInstance: followupInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'followup.label', default: 'Followup'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def followupInstance = Followup.get(params.id)
        if (followupInstance) {
            try {
                //soft delete only
                followupInstance.status="DELETED"
                followupInstance.save(flush:true)
                //followupInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'followup.label', default: 'Followup'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'followup.label', default: 'Followup'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'followup.label', default: 'Followup'), params.id])}"
            redirect(action: "list")
        }
    }
    
    def search ={
		/*def showAll = session.showall
		if(!session.showall)
			{
			def indWithList = housekeepingService.filterIndividualList()
			[rilist:indWithList]
			}
		else
			redirect(action: "list")*/
			
    	if(params.sstartDate)
    		params.startDate = Date.parse('dd-MM-yyyy', params.sstartDate)
    	if(params.sstartDate1)
    		params.startDate1 = Date.parse('dd-MM-yyyy', params.sstartDate1)
    	if(params.endDate)
    		params.endDate = Date.parse('dd-MM-yyyy', params.endDate)
    	if(params.endDate1)
    		params.endDate1 = Date.parse('dd-MM-yyyy', params.endDate1)
    
    
        def criteria = Followup.createCriteria()
        def followupList = criteria {
    			and {
    				if (params.Comments!=null && params.Comments.trim().length()>0)
    			    		like("comments", "%"+params.Comments+"%")
    
    			if(params.Rangeed=="NoRange")
    				{
    				
    				if (params.endDate)
    			    		eq("endDate", params.endDate)
    			    	}
    			else{
    			
    			if(params.Rangeed=="Range")
    				{
    				if (params.endDate)
    			    		ge("endDate", params.endDate)
    				if (params.endDate1)
    			    		le("endDate", params.endDate1)			    									
    				}			
    			}			    	
    
    			if(params.Rangesd=="NoRange")
    				{
    				
    				if (params.sstartDate){    			    //println " Rani Teststartd"+params."sstartDate"			    			    			    
    			    		eq("startDate", params.sstartDate)}
    			    	}
    			else{
    			
    			if(params.Rangesd=="Range")
    				{
    				if (params.startDate)
    			    		ge("startDate", params.sstartDate)
    				if (params.startDate1)
    			    		le("startDate", params.sstartDate1)			    									
    				}			
    			}			    	


    			    //println " Rani TestRgsd"+params."Rangesd"			    			    			    
    			    //println " Rani TestRged"+params."Rangeed"			    			    			    
    			    //println " Rani ExactFW"+params."ExactFW"			    			    			    
    			    //println " Rani ExactFB"+params."ExactFB"			    			    			    
    			    //println " Rani ExactREF"+params."ExactREF"			    			    			    
    			    //println " Rani ExactCAT"+params."ExactCAT"			    			    			    
    			    //println " Rani ExactDEC"+params."ExactDEC"	
			//println " Rani ExactCOMMENT"+params."Comments"	    			    
    			    
    			    if(params.ExactFW=="ExactFW")
    				{
    				if (params.followupwith)
    					{
    					followupWith {eq("followupWith", params.followupwith)}
    					}
    				}
    			else{
    			if(params.ExactFW=="LikeFW")
    				{
    				if (params.followupwith)
    				{
    				followupWith {
    					   like("followupWith", "%"+params.followupwith+"%")
    					   }																        								
    				}
    				}
    			}
    			
    			    if(params.ExactFB=="ExactFB")
    				{
    				if (params.followupby)
    					{
    					followupBy {eq("followupBy", params.followupby)}
    					}
    				}
    			else{
    			if(params.ExactFB=="LikeFB")
    				{
    				if (params.followupby)
    					{
    					followupBy {
    					        like("followupBy", "%"+params.followupby+"%")
    					    	  }																        								
    					 }
    				}
    			    }
    
    			    if(params.ExactCAT=="ExactCAT")
    				{
    				if (params.category)
    					{
    					category {eq("category", params.category)}
    					}
    				}
    			else{
    			if(params.ExactCAT=="LikeCAT")
    				{
    				if (params.category)
    				{
    				category {
    					   like("category", "%"+params.category+"%")
    					   }																        								
    				}
    				}
    			}
    			    if(params.ExactREF=="ExactREF")
    				{
    				if (params.ref)
    					{
    					ref {eq("ref", params.ref)}
    					}
    				}
    			else{
    			if(params.ExactREF=="LikeREF")
    				{
    				if (params.ref)
    				{
    				ref {
    					   like("ref", "%"+params.ref+"%")
    					   }																        								
    				}
    				}
    			}
    			    if(params.ExactDEC=="ExactDEC")
    				{
    				if (params.description)
    					{
    					description {eq("description", params.description)}
    					}
    				}
    			else{
    			if(params.ExactDEC=="LikeDEC")
    				{
    				if (params.description)
    				{
    				description {
    					   like("description", "%"+params.description+"%")
    					   }																        								
    				}
    				}
    			}

    				}
           		 	}
    
                    render(view: "list", model: [followupInstanceList: followupList, search: true])                    

    
    }
    
    def listforindividual(String indid){
    //def followups = Followup.findAllByFollowupWith(housekeepingService.getIndividual(params.followupWith.id))
    def followups = Followup.findAllByFollowupBy(Individual.get(indid))
    [followupInstanceList: followups, followupInstanceTotal: followups.size]
    }

// return JSON list of folowups
    def jq_followup_list = {
      def sortIndex = params.sidx ?: 'endDate'
      def sortOrder = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def followups = Followup.createCriteria().list(max:maxRows, offset:rowOffset) {
            switch (params.cmd) {
            	case 'fwith':
            		eq('followupWith.id',new Long(params.findwithid))
            		break
            	case 'fby':
            		eq('followupBy.id',new Long(params.findbyid))
            		break
            }
            order(sortIndex, sortOrder)
      }
      def totalRows = followups.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = followups.collect {
            [cell: [it.category,
                    it.startDate?.format('dd-MM-yyyy  HH:mm'),
                    it.endDate?.format('dd-MM-yyyy  HH:mm'),
                    it.description,
                    it.comments,
                    it.status,
                    it.ref,
                    it.followupBy.id,
                    it.followupWith.id
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }
    
// return JSON list of folowups
    def jq_followup_list1 = {
      println "Params in jq_followup_list1: "+params
      def findbyidList = []
      
      def catStr = "("
      def idlist = housekeepingService.getPCGroup()
      idlist.each{
      	catStr+="'"+it+"',"
      	}
      if(catStr.size()>1)
      	catStr=catStr.substring(0,catStr.size()-1)
      catStr += ")"
      
      log.debug("catStr.."+catStr)

      findbyidList = findbyidList.unique()

      def sortIndex = params.sidx ?: 'endDate'
      def sortOrder = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def followups = Followup.createCriteria().list(max:maxRows, offset:rowOffset) {
            /*if(params.cmd)
            {
		    switch (params.cmd) {
			case 'fwith':
				println 'switch params.findwithid='+params.findwithid
				eq('followupWith',Individual.get(new Long(params.findwithid)))
				break
			case 'fby':
					or{
						for(int i=0; i<(params.findbyid)?.size(); i++)
						{
							println 'switch params.findbyid='+params.findbyid[i]
							eq('followupBy',Individual.get(new Long(params.findbyid[i])))
						}
					}
				break
		    }
            }
            else
            {*/
		    // category case insensitive where the field contains with the search term
		    /*if (params.category)
			ilike('category','%'+params.category + '%')*/

			//'in'('category',catStr)
		
		eq('followupBy',Individual.get(session.individualid))

			
		    // startDate case insensitive where the field contains with the search term
		    if (params.startDate)
		    {
			def dt=Date.parse('dd-MM-yyyy', params.startDate)
			and{
			    ge('startDate',dt )
			    le('startDate',dt+1 )
			}
		    }

		    // endDate case insensitive where the field contains with the search term
		    if (params.endDate)
		    {
			def dt=Date.parse('dd-MM-yyyy', params.endDate)
			and{
			    ge('endDate',dt )
			    le('endDate',dt+1 )
			}
		    }

		    // description case insensitive where the field contains with the search term
		    if (params.description)
			ilike('description','%'+params.description + '%')

		    // comments case insensitive where the field contains with the search term
		    if (params.comments)
			ilike('comments','%'+params.comments + '%')

		    // status case insensitive where the field contains with the search term
		    if (params.status)
			ilike('status','%'+params.status + '%')

		    // ref case insensitive where the field contains with the search term
		    if (params.ref)
			ilike('ref','%'+params.ref + '%')

		    // followupBy case insensitive where the field contains with the search term
		    if (params.followupBy)
		    {
			println "params.followupBy: "+params.followupBy
			or{
				followupBy{
					or{
					ilike('legalName','%' + params.followupBy + '%')
					ilike('initiatedName','%' + params.followupBy + '%')
					}
				}

			}

		    }

		    // followupWith case insensitive where the field contains with the search term
		    if (params.followupWith)
		    {
			println "params.followupWith: "+params.followupWith

				followupWith{
					or{
					ilike('legalName','%' + params.followupWith + '%')
					ilike('initiatedName','%' + params.followupWith + '%')
					}
				}

		    }		
		//}
            order(sortIndex, sortOrder)
      }
      println "followups: "+followups
      def totalRows = followups.totalCount
      println "totalRows: "+totalRows
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = followups.collect {
            [cell: [it.category,
                    it.startDate?.format('dd-MM-yyyy  HH:mm'),
                    it.endDate?.format('dd-MM-yyyy  HH:mm'),
                    it.description,
                    it.comments,
                    it.status,
                    it.ref,
                    it.followupBy.toString(),
                    it.followupWith.toString(),
                    it.followupWith.id
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }

	def jq_edit_followup = {
	      println "Params in jq_edit_followup: "+params
	      def followup = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add instruction sent
		  params."followupBy.id"=params.findbyid
		  params."followupWith.id"=params.findwithid
		  params.creator= springSecurityService.principal.username
		  params.updator = params.creator
		  params.startDate = Date.parse('dd-MM-yyyy HH:mm', params.startDate)
		  params.endDate = Date.parse('dd-MM-yyyy HH:mm', params.endDate)
		  followup = new Followup(params)
		  if (! followup.hasErrors() && followup.save()) {
		    message = "Followup ${followup.id} Added"
		    id = followup.id
		    state = "OK"
		  } else {
		    followup.errors.allErrors.each {
			println it
		    }		    
		    message = "Could Not Save Followup"
		  }
		  break;
		case 'del':
		  // check followup exists
		  followup = Followup.get(params.id)
		  if (followup) {
		    // delete followup
		    followup.delete()
		    message = "Followup  ${followup.id} Deleted"
		    state = "OK"
		  }
		  break;
		 default :
		  // edit action
		  // first retrieve the followup by its ID
		  followup = Followup.get(params.id)
		  if (followup) {
		    // set the properties according to passed in parameters
		  params.startDate = Date.parse('dd-MM-yyyy HH:mm', params.startDate)
		  params.endDate = Date.parse('dd-MM-yyyy HH:mm', params.endDate)
		    followup.properties = params
		    if (! followup.hasErrors() && followup.save(flush:true)) {
		      message = "Followup  ${followup.id} Updated"
		      id = followup.id
		      state = "OK"
		    } else {
			    followup.errors.allErrors.each {
				println it
			    }		    
		      message = "Could Not Update Followup"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }
    
	def bulkMessage() {
		log.debug("In bulkMessage with params: "+params)
		def followup
		def ids = params.idList.tokenize(',')
		ids = ids?.unique() //remove duplicate ids if supplied by mistake
		ids.each
			{
			followup = new Followup()
			followup.followupWith = Individual.get(it)
			followup.followupBy = Individual.get(session.individualid)
			followup.startDate = new Date()
			followup.category = params.category
			followup.description = params.msg
			followup.updator = followup.creator = springSecurityService.principal.username
			if(!followup.save())
				{
					followup.errors.allErrors.each {
						println it
			    		}
				}
			}			
	     	def response = [message:"OK"]
	     	render response as JSON	
	}

}
