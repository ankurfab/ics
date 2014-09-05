package com.krishna
import groovy.sql.Sql;
import ics.Individual;
import grails.converters.JSON

class IcsUserController {
	
	def springSecurityService
	def dataSource 


    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 100, 1000)
        if(!params.sort)
        	params.sort = 'username'
        [icsUserInstanceList: IcsUser.list(params), icsUserInstanceTotal: IcsUser.count()]
    }

    def create = {
        def icsUserInstance = new IcsUser()
        icsUserInstance.properties = params
        return [icsUserInstance: icsUserInstance]
    }

    def save = {
    	println "Inside IcsUser.save(): "+params
    	/*if (params.password!=null)
    		params.password = springSecurityService.encodePassword(params.password)*/
        //params."linkedid"= params."acLinkedIndividual_id"
        //if linkedid is not supplied, then create the new Individual and use its id
        if(!params.linkedid && params.indname)
        	{
        	def ind = new Individual(legalName:params.indname)
        	if(!ind.save()) {
            		ind.errors.allErrors.each {
				println it
		    	}
		    }
        	params.linkedid = ind?.id	
        	}
        println 'params.linkedid='+params.linkedid
        def icsUserInstance = new IcsUser(params)
        
        if (icsUserInstance.save(flush: true)) {
        
        //save role mapping
        def roles = params.list('roles')
        roles.each{r->
		println "adding role for user.."+r
		def icsUsericsRoleInstance = new IcsUserIcsRole()
		icsUsericsRoleInstance.icsUser = icsUserInstance
		icsUsericsRoleInstance.icsRole = IcsRole.get(r)
		icsUsericsRoleInstance.save(flush:true)
        }
        
        //save individual id mapping
        def sql = new Sql(dataSource);
	sql.executeUpdate('UPDATE individual set loginid=? WHERE id=?', [icsUserInstance.username,params.linkedid])
	sql.close()

	springSecurityService.clearCachedRequestmaps()
	
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'icsUser.label', default: 'IcsUser'), icsUserInstance.id])}"
            redirect(action: "show", id: icsUserInstance.id)
        }
        else {
            render(view: "create", model: [icsUserInstance: icsUserInstance])
        }
    }

    def show = {
        def icsUserInstance
        if(params.username)
        	icsUserInstance = IcsUser.findByUsername(params.username)
        else
        	icsUserInstance = IcsUser.get(params.id)
        if (!icsUserInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'icsUser.label', default: 'IcsUser'), params.id])}"
            redirect(action: "list")
        }
        else {
        	def individualInstance = Individual.findByLoginid(icsUserInstance.username)
            [icsUserInstance: icsUserInstance,linkedIndividual:individualInstance]
        }
    }

    def edit = {
        def icsUserInstance = IcsUser.get(params.id)
		
        if (!icsUserInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'icsUser.label', default: 'IcsUser'), params.id])}"
            redirect(action: "list")
        }
        else {
	        def linkedIndividual = Individual.findByLoginid(icsUserInstance?.username)
	        println 'linkedIndividual='+linkedIndividual
	        def iuirInstanceList = IcsUserIcsRole.findAllByIcsUser(icsUserInstance)
	        def roleidList = []
	        iuirInstanceList.each{ i ->
	        	roleidList.add(i.icsRole.id)
	        }
            return [icsUserInstance: icsUserInstance, linkedid: linkedIndividual?.id,roleidList:roleidList,linkedIndividual:linkedIndividual]
        }
    }

    def update = {
        def icsUserInstance = IcsUser.get(params.id)
        if (icsUserInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (icsUserInstance.version > version) {
                    
                    icsUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'icsUser.label', default: 'IcsUser')] as Object[], "Another user has updated this IcsUser while you were editing")
                    render(view: "edit", model: [icsUserInstance: icsUserInstance])
                    return
                }
            }
            
            /*if (params.password!=null)
	    	params.password = springSecurityService.encodePassword(params.password)*/

            icsUserInstance.properties = params
            if (!icsUserInstance.hasErrors() && icsUserInstance.save(flush: true)) {

		
		//save role mapping
		//first delete old entries
		IcsUserIcsRole.removeAll(icsUserInstance)
		//save role mapping
		def roles = params.list('roles')
		roles.each{r->
			println "adding role for user.."+r
			def icsUsericsRoleInstance = new IcsUserIcsRole()
			icsUsericsRoleInstance.icsUser = icsUserInstance
			icsUsericsRoleInstance.icsRole = IcsRole.get(r)
			icsUsericsRoleInstance.save(flush:true)
		}

		springSecurityService.clearCachedRequestmaps()

                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'icsUser.label', default: 'IcsUser'), icsUserInstance.id])}"
                redirect(action: "show", id: icsUserInstance.id)
            }
            else {
                render(view: "edit", model: [icsUserInstance: icsUserInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'icsUser.label', default: 'IcsUser'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def icsUserInstance = IcsUser.get(params.id)
        def loginid = icsUserInstance.username
        if (icsUserInstance) {
            try {
                //delete the user roles first
                IcsUserIcsRole.removeAll(icsUserInstance)
                //delete the user now
                icsUserInstance.delete(flush: true)
		//nullify individual id mapping
		def sql = new Sql(dataSource)
		sql.executeUpdate('UPDATE individual set loginid=null WHERE loginid=?', [loginid])
		sql.close()
		
		springSecurityService.clearCachedRequestmaps()
		
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'icsUser.label', default: 'IcsUser'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'icsUser.label', default: 'IcsUser'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'icsUser.label', default: 'IcsUser'), params.id])}"
            redirect(action: "list")
        }
    }

    def jq_user_list = {
      def sortIndex = params.sidx ?: 'username'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
      
      def result
      def sql = new Sql(dataSource);
      String query = "select iu.id iuid,i.id iid, i.legal_name,i.initiated_name, iu.username,group_concat(ir.authority) authority from ics_user iu , ics_user_ics_role iuir , ics_role ir, individual i where iu.id=iuir.ics_user_id and ir.id=iuir.ics_role_id and iu.username=i.loginid"

	
	      //add conditions
	      
	      if (params.legal_name)
	      {
	      	query += " and i.legal_name like '%"+params.legal_name+"%'"
	      }
	      
	      if (params.initiated_name)
	      {
	      		query += " and i.initiated_name like '%"+params.initiated_name+"%'"
	      }
	      
	      if (params.username)
	      {
	      		query += " and iu.username like '%"+params.username+"%'"
	      }
	      
	      if (params.authority)
	      {
	      		query += " and ir.authority like '%"+params.authority+"%'"
	      }
	      

      //add grouping
      query += "  group by iu.username"
      
      //add sorting,ordering
      query += " order by "+sortIndex+" "+sortOrder
      
      //println query
      result = sql.rows(query,rowOffset,maxRows)

	//println 'result='+result
      String countQuery = "select count(1) cnt from ("+query+") q"
      //println countQuery
      
      def totalRows = sql.firstRow(countQuery)?.cnt
      def numberOfPages = Math.ceil(totalRows / maxRows)
      
      sql.close()

      def jsonCells = result.collect {
            [cell: [
                    it.legal_name,
                    it.initiated_name,
                    it.username,
                    it.authority
                ], id: it.iuid]
        }
        
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }
    
    def status(String status) {
    	log.debug("Inside disable:"+params)
    	def iu
    	int count = 0
	def idList = params.idlist.tokenize(',')
	idList.each
	{
	  //log.debug("User:"+it)
	  iu = IcsUser.get(it)
	  if (iu) {
	    iu.enabled = (status=="false"?false:true)
	    //log.debug("Changing status for IU:"+iu)
	    if(!iu.save())
		    iu.errors.allErrors.each {
			println it
			}
	    else
	    	count++
	    	
	  }
	}
	def message = count + " user(s) "+(status=="false"?"disabled":"enabled")+" !!"
        def response = [message:message]
        render response as JSON
    }


}
