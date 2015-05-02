package ics

import grails.converters.JSON
import java.util.zip.ZipOutputStream  
import java.util.zip.ZipEntry  
import org.grails.plugins.csv.CSVWriter
import org.apache.commons.lang.StringEscapeUtils.*


class IndividualRoleController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [individualRoleInstanceList: IndividualRole.list(params), individualRoleInstanceTotal: IndividualRole.count()]
    }

    def create = {
        def individualRoleInstance = new IndividualRole()
        individualRoleInstance.properties = params
        return [individualRoleInstance: individualRoleInstance]
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator
	
	params."individual.id"= params."acIndividual_id"
	println '-------------IndividualRole save--------------'
	println 'params='+params
		
	
        def individualRoleInstance = new IndividualRole(params)
        individualRoleInstance.status = "VALID"
        
        //before saving check if a valid mapping already exists
        def ir = IndividualRole.findAllByIndividualAndRole(Individual.get(params."individual.id"),Role.get(params."role.id"))
        def flag = true
	ir?.each {item-> 
		if (item.status=="VALID")
			flag=false
		}
        if(!flag)
        	{
        	flash.message = "Role already exists for the individual !!"
        	render(view: "create", model: [individualRoleInstance: individualRoleInstance])
        	return
        	}
        
		/*def selectedRole = Role.findById(params.role.id)
		println 'selectedRole='+selectedRole
		if(selectedRole == "Collector")
		{
			
		}*/

        
        if (individualRoleInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'individualRole.label', default: 'IndividualRole'), individualRoleInstance.id])}"
            redirect(action: "show", id: individualRoleInstance.id)
        }
        else {
            render(view: "create", model: [individualRoleInstance: individualRoleInstance])
        }
    }

    def show = {
        def individualRoleInstance = IndividualRole.get(params.id)
        if (!individualRoleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'individualRole.label', default: 'IndividualRole'), params.id])}"
            redirect(action: "list")
        }
        else {
            [individualRoleInstance: individualRoleInstance]
        }
    }

    def edit = {
        def individualRoleInstance = IndividualRole.get(params.id)
        if (!individualRoleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'individualRole.label', default: 'IndividualRole'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [individualRoleInstance: individualRoleInstance]
        }
    }

    def update = {
        def individualRoleInstance = IndividualRole.get(params.id)
        if (individualRoleInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (individualRoleInstance.version > version) {
                    
                    individualRoleInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'individualRole.label', default: 'IndividualRole')] as Object[], "Another user has updated this IndividualRole while you were editing")
                    render(view: "edit", model: [individualRoleInstance: individualRoleInstance])
                    return
                }
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            individualRoleInstance.properties = params
            if (!individualRoleInstance.hasErrors() && individualRoleInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'individualRole.label', default: 'IndividualRole'), individualRoleInstance.id])}"
                redirect(action: "show", id: individualRoleInstance.id)
            }
            else {
                render(view: "edit", model: [individualRoleInstance: individualRoleInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'individualRole.label', default: 'IndividualRole'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def individualRoleInstance = IndividualRole.get(params.id)
        if (individualRoleInstance) {
            try {
                individualRoleInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'individualRole.label', default: 'IndividualRole'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'individualRole.label', default: 'IndividualRole'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'individualRole.label', default: 'IndividualRole'), params.id])}"
            redirect(action: "list")
        }
    }

    def searchByRole = {
    	List individualRoleInstanceList =[]
    	def tempList
    	def role = Role.get(params.roleid)
    	/*def individuals = Individual.findAllByLegalNameLike("%"+params.individualname+"%")
    	individuals.each{
    	    		tempList = IndividualRole.findByRoleAndIndividual(role,it)
	    		if (tempList !=null)
	    			individualRoleInstanceList.push(tempList)
	}*/
	individualRoleInstanceList = IndividualRole.findAllByRoleAndStatus(role,'VALID',[sort:"individual"])
	//render(view: "list", model: [individualRoleInstanceList: individualRoleInstanceList,individualRoleInstanceTotal: individualRoleInstanceList.count()])
	render(view: "searchresult", model: [individualRoleInstanceList: individualRoleInstanceList,individualRoleInstanceTotal: individualRoleInstanceList.size()])
	}


def jq_individualRole_list = {
                       def sortIndex = params.sidx ?: 'role'
                       def sortOrder  = params.sord ?: 'asc'
                 
                       def maxRows = Integer.valueOf(params.rows)
                       def currentPage = Integer.valueOf(params.page) ?: 1
                 
                       def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
                 
                 	def result = IndividualRole.createCriteria().list(max:maxRows, offset:rowOffset) {
                 		
                 		if (params.'individual.id')
             		    			individual{
             		    			eq('id',new Long(params.'individual.id'))
             		    			}
             
                 		
                 		if (params.'role.name')
                 			ilike('name','%'+params.'role.name' + '%')

                                if (params.status)
                 			ilike('status','%'+params.status + '%')
                 
                 		
                 		
                 		order(sortIndex, sortOrder)
                 
                 	}
                       
                       def totalRows = result.totalCount
                       def numberOfPages = Math.ceil(totalRows / maxRows)
                 
                       def jsonCells = result.collect {
                             [cell: [
                                        
                             	    it.role.name,
                             	    it.status
                             	    
                                 ], id: it.id]
                         }
                         def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
                         render jsonData as JSON
                         }
                 
                 	def jq_edit_individualRole = {
                 	      log.debug('In jq_individualRole_edit:'+params)
                 	      
                 	      def message = ""
                 	      def state = "FAIL"
                 	      def id
                 	      def individualRole
                 
                 	      // determine our action
                 	      switch (params.oper) {
                 		case 'add':
                 		
                 		 		
                 		  individualRole = new IndividualRole(params)
                 		
                 		individualRole.creator=springSecurityService.principal.username
                 		individualRole.updator = individualRole.creator
                 		
                 		  if (! individualRole.hasErrors() && individualRole.save()) {
                 		    message = "Course Saved.."
                 		    id = individualRole.id
                 		    state = "OK"
                 		  } else {
                 		    individualRole.errors.allErrors.each {
                 			log.debug(it)
                 			}
                 		    message = "Could Not Save Role"
                 		  }
                 		  break;
                 		case 'del':
                 		  	def idList = params.id.tokenize(',')
                 		  	idList.each
                 		  	{
                 			  // check 
                 			  individualRole  = IndividualRole.get(it)
                 			  if (individualRole) {
                 			    
                 			    if(!individualRole.delete())
                 			    	{
                 				    individualRole.errors.allErrors.each {
                 					log.debug("In jq_individualRole_edit: error in deleting email:"+ it)
                 					}
                 			    	}
                 			    else {
                 				    message = "Deleted!!"
                 				    state = "OK"
                 			    }
                 			  }
                 		  	}
                 		  break;
                 		 default :
                 		  // edit action
                 		  // first retrieve  by its ID
                 		  individualRole = IndividualRole.get(params.id)
                 		  if (individualRole) {
                 		    // set the properties according to passed in parameters
                 		    individualRole.properties = params
                 			  
                 		    if (! individualRole.hasErrors() && individualRole.save()) {
                 		      message = "Course  ${individualRole.course} Updated"
                 		      id = individualRole.id
                 		      state = "OK"
                 		    } else {
                 			    individualRole.errors.allErrors.each {
                 				println it
                 				}
                 		      message = "Could Not Update Role"
                 		    }
                 		  }
                 		  break;
                  	 }
                 
                 	      def response = [message:message,state:state,id:id]
                 
                 	      render response as JSON
                 	    }
                 	    
        def indroleList = {
			    	    if (request.xhr) {
			    		render(template: "individualRole", model: [individualid:params.'individual.id'])
			    		//render "Hare Krishna!!"
			    		return
			    	    }
	   }

// return JSON list of roles
    def jq_deprole_list = {
      log.debug("In jq_deprole_list with params: "+params)
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      def deps = IndividualRole.createCriteria().list(max:maxRows, offset:rowOffset) {
            // name case insensitive where the field contains with the search term
            if (params.name)
                individual{
                	or{
                	ilike('legalName',params.name)
                	ilike('initiatedName',params.name)
                	}
                	}

            if (params.department)
                department{
                	ilike('name',params.department)
                	}

            if (params.centre)
                centre{
                	ilike('name',params.centre)
                	}

            if (params.remarks)
                ilike('remarks',params.remarks)

            if (params.status)
                ilike('status',params.status)

            if (params.'role.id')
                eq('role.id',new Long(params."role.id"))

           switch(sortIndex) {
           	case 'name': 
			individual{
				 order('initiatedName', sortOrder)
				 order('legalName', sortOrder)           	
			}
			break
		case 'department':
			department{order('name', sortOrder)}
			break
		case 'centre':
			centre{order('name', sortOrder)}
			break
		default:
			order(sortIndex, sortOrder)
			break
           }
      }
      def totalRows = deps.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = deps.collect {
            [cell: [it.individual?.id,it.individual?.toString(),
            	VoiceContact.findByIndividualAndCategory(it.individual,'CellPhone')?.number,
            	EmailContact.findByIndividualAndCategory(it.individual,'Personal')?.emailAddress,
            	it.individual?.description?:'',
            	it.department?.toString(),
            	it.centre?.toString(),
            	it.remarks,
            	it.status
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }

	def jq_edit_deprole = {
	      def role = null
	      if(params."role.id")
	      	role = Role.get(params."role.id")
	       
	      def department = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add instruction sent
		  params.creator = springSecurityService.principal.username
		  params.updator = params.creator
		  department = new Department(params)
		  if (! department.hasErrors() && department.save()) {
		    message = "Department ${department.name} Added"
		    id = department.id
		    state = "OK"
		  } else {
		    department.errors.allErrors.each {
			println it
		    }		    
		    message = "Could Not Save Department"
		  }
		  break;
		case 'del':
		  // check department exists
		  department = Department.get(params.id)
		  if (department) {
		    // delete department
		    department.delete()
		    message = "Department  ${department.name} Deleted"
		    state = "OK"
		  }
		  break;
		 default :
		  // edit action
		  // first retrieve the department by its ID
		  department = Department.get(params.id)
		  if (department) {
		    // set the properties according to passed in parameters
		  	params.updator = springSecurityService.principal.username
		    department.properties = params
		    if (! department.hasErrors() && department.save()) {
		      message = "Department  ${department.name} Updated"
		      id = department.id
		      state = "OK"
		    } else {
		    department.errors.allErrors.each {
			println it
		    }		    
		      message = "Could Not Update Department"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def jq_indrole_list_export = {
      log.debug("Inside jq_indrole_list_export with params: "+params)
            
      def sortIndex = 'id'
      def sortOrder = 'asc'
      
      def idlist = []
      if(params.roleids)
      	idlist = params.roleids?.tokenize(",")?.collect{new Long(it)}

	def result = IndividualRole.createCriteria().list() {
		eq('status','VALID')
		role{'in'('id',idlist)}
		order(sortIndex, sortOrder)	
	}
	
	log.debug("jq_indrole_list_export result size:"+result?.size())
      
	if(params.oper=="excel")
	 {
		response.contentType = 'application/zip'
		def today = new Date().format("dd-MM-yyyy-HH-mm-SS")
		def fileName = "IndividualRole-"+today+".csv"
		new ZipOutputStream(response.outputStream).withStream { zipOutputStream ->
			zipOutputStream.putNextEntry(new ZipEntry(fileName))
			//header
			zipOutputStream << "ICSid,Name,Phone,Email,Address,Role,Department,Centre" 

			def name="",phone="",email="",address=""
			result.each{ row ->
				name = row.individual?.toString()?.tr(', \n\r\t',' ')?:''
            			phone = VoiceContact.findByIndividualAndCategory(row.individual,'CellPhone')?.number?.tr(', \n\r\t',' ')?:''
            			email = EmailContact.findByIndividualAndCategory(row.individual,'Personal')?.emailAddress?.tr(', \n\r\t',' ')?:''
            			address = Address.findByIndividualAndCategory(row.individual,'Correspondence')?.toString()?.tr(', \n\r\t',' ')?:''
				zipOutputStream << "\n"
				zipOutputStream <<   row.individual.icsid +","+
					  name +","+
					  phone +","+
					  email +","+
					  address +","+
					  (row.role?:'') +","+
					  (row.department?:'') +","+
					  (row.centre?:'')
			}
		}    		
		return
	 }
        }

}
