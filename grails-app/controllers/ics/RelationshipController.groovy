package ics
import grails.converters.JSON

class RelationshipController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def housekeepingService
	
    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
	    if (request.xhr) {
		render(template: "relationshipGrid", model: ['individualid':params.'individualid'])
		return
	    }
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [relationshipInstanceList: Relationship.list(params), relationshipInstanceTotal: Relationship.count()]
    }

    def create = {
    
    	println "Params in create relationship:" + params
    	
    	def relationInstance
    	if(params.relationName)
    		{
    		//spiritual relation
    		relationInstance = Relation.findByName(params.relationName)
    		params."relation.id"= relationInstance?.id
    		
    		//get the dummy relationship group
    		def dummyRG = RelationshipGroup.findByGroupName('dummy')
    		params."relationshipGroup.id" = dummyRG?.id
    		}
    	else if(!params."relationshipGroup.id")
    		{
    		//family relation
    		def rg = RelationshipGroup.findByRefid(params."individual2.id")
    		if(!rg)
    			{
		    	//for new family, create new relationship group
    			rg = new RelationshipGroup()
    			def i2 = Individual.get(params."individual2.id")
    			rg.groupName = "Family of "+ (i2?.legalName?:params."individual2.id")
    			rg.category='FAMILY'
    			rg.refid = params."individual2.id".toInteger()
    			rg.creator = springSecurityService.principal.username
    			rg.updator = springSecurityService.principal.username
		        if (!rg.save(flush: true)) 
		        	{
		        		println "Some error occurred in saving family relationship group : "+rg
		        	}
    			}
    		params."relationshipGroup.id" = rg?.id

    		}


        def relationshipInstance = new Relationship()
        relationshipInstance.properties = params
        return [relationshipInstance: relationshipInstance, family: params.family?:false]
    }

    def save = {

	println "Inside save relationship: " + params
    	if(params."acRelation_id")
    		params."relation.id"= params."acRelation_id"
    	if(params."acIndividual1_id")
    		params."individual1.id"= params."acIndividual1_id"
    	if(params."acIndividual2_id")
    		params."individual2.id"= params."acIndividual2_id"
    		
    	if (params."individual1.id" == params."individual2.id")
    		{
		    flash.message = "Can not create relationship to self!!"
		    redirect(controller: "relationship", action: "create", params:['individual2.id':params."individual2.id"])
		    return
    		}
    		
    	println "Saving relationship with params: " + params

	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator
    
        def relationshipInstance = new Relationship(params)
        relationshipInstance.status = "ACTIVE"
        
        if (relationshipInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'relationship.label', default: 'Relationship'), relationshipInstance.id])}"
            if(params.family=="true")
	            redirect(controller: "individual",action: "edit", id: relationshipInstance?.individual2?.id)
	    else if(relationshipInstance?.relationshipGroup?.groupName=="dummy")
	            redirect(controller: "individual",action: "edit", id: relationshipInstance?.individual1?.id)
	    else
	    	redirect(action: "show", id: relationshipInstance?.id)
	    
        }
        else {
            render(view: "create", model: [relationshipInstance: relationshipInstance])
        }
    }

    def show = {
        def relationshipInstance = Relationship.get(params.id)
        if (!relationshipInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'relationship.label', default: 'Relationship'), params.id])}"
            redirect(action: "list")
        }
        else {
            [relationshipInstance: relationshipInstance]
        }
    }

    def edit = {
        def relationshipInstance = Relationship.get(params.id)
        if (!relationshipInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'relationship.label', default: 'Relationship'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [relationshipInstance: relationshipInstance]
        }
    }

    def update = {
        def relationshipInstance = Relationship.get(params.id)
        if (relationshipInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (relationshipInstance.version > version) {
                    
                    relationshipInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'relationship.label', default: 'Relationship')] as Object[], "Another user has updated this Relationship while you were editing")
                    render(view: "edit", model: [relationshipInstance: relationshipInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            relationshipInstance.properties = params
            if (!relationshipInstance.hasErrors() && relationshipInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'relationship.label', default: 'Relationship'), relationshipInstance.id])}"
                redirect(action: "show", id: relationshipInstance.id)
            }
            else {
                render(view: "edit", model: [relationshipInstance: relationshipInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'relationship.label', default: 'Relationship'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def relationshipInstance = Relationship.get(params.id)
        def flag = false
        if (relationshipInstance) {
            try {
            	flag = relationshipInstance.relationshipGroup?.groupName=="dummy"?true:false
            	def indid 
                if(flag)
                	indid = relationshipInstance.individual1?.id
                else
                	indid = relationshipInstance.individual2?.id
                relationshipInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'relationship.label', default: 'Relationship'), params.id])}"
                redirect(controller:"individual", action: "edit", id:indid)
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'relationship.label', default: 'Relationship'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'relationship.label', default: 'Relationship'), params.id])}"
            redirect(action: "list")
        }
    }

    def search = {
    def criteria = Relationship.createCriteria()
    def relationshipList = criteria {
			and {
				if (params.sComments!=null && params.sComments.trim().length()>0)
			    		like("comment", "%"+params.sComments+"%")
				if (params.sRelationshipGroup!=null && params.sRelationshipGroup.trim().length()>0)
				{
					relationshipGroup {
					    like('groupName','%'+params.sRelationshipGroup+'%')
					}
				}
				if (params.sIndividual1!=null && params.sIndividual1.trim().length()>0)
				{
				individual1 {
				    like('legalName','%'+params.sIndividual1+'%')
				}
				}
				if (params.sRelation!=null && params.sRelation.trim().length()>0)
				{
					relation {
					    like('name','%'+params.sRelation+'%')
					}
				}
				if (params.sIndividual2!=null && params.sIndividual2.trim().length()>0)
				{
				individual2 {
				    like('legalName','%'+params.sIndividual2+'%')
				}
				}
				if (params.sStatus!=null && params.sStatus.trim().length()>0)
				
				    eq('status', params.sStatus)
				
			    
				}
       		 	}
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
       		 	
                render(view: "list", model: [relationshipInstanceList: relationshipList, relationshipInstanceTotal: relationshipList.size()])

    }

    def jq_guidedBy_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = Relationship.createCriteria().list(max:maxRows, offset:rowOffset) {
			eq('status','ACTIVE')
			individual1{
				eq('id',new Long(params.individualid))
				}
		relation{
			order(sortIndex, sortOrder)
			}


	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.relation?.name,
            	    it.individual2?.toString()
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

    def jq_guiding_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = Relationship.createCriteria().list(max:maxRows, offset:rowOffset) {
			eq('status','ACTIVE')
			individual2{
				eq('id',new Long(params.individualid))
				}
			if(sortIndex!='name')
				individual1{order(sortIndex, sortOrder)}
			if(sortIndex=='name')
				relation{order(sortIndex, sortOrder)}
	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.individual1?.legalName,
            	    it.individual1?.initiatedName,
            	    it.relation?.name
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }


}
