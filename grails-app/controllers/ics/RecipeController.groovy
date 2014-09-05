package ics

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class RecipeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def recipeService 
    def springSecurityService

    def index() {
    }

    def list() {
        /*params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [recipeInstanceList: Recipe.list(params), recipeInstanceTotal: Recipe.count()]*/
    }

    def create() {
        [recipeInstance: new Recipe(params)]
    }

    def save() {
        
        //handle JQ AC boxes
        //if(params.cuisineid)
        	
        def retVal = recipeService.createRecipe(params)
        
	if (retVal==0)
		{
		flash.message = "Some Error Occurred"
                redirect(controller: "RecipeVersion", action: "create", params: ['recipe.id': recipeInstance.id])
        	}
        else
        	//redirect(controller:"recipeVersion", action: "show", id: retVal)
        	render retVal
        
    }

    def show() {
        def recipeInstance = Recipe.get(params.id)
        if (!recipeInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'recipe.label', default: 'Recipe'), params.id])
			
           redirect(action: "list")
           return
        }
	def rv
						
	recipeInstance.recipeVersions.each{
	if(it.default)
	   rv = it			 		
			 	
			//if(rv!=null) 	
			 	//break // to do Logic  needs to be improved because the to find default recipe it it looping through all versions
	}
	         
         //redirect(controller: recipeVersion, action: "show", id: rv?.id)     
         //return
         [recipeInstance: recipeInstance]
    }

    def edit() {
        def recipeInstance = Recipe.get(params.id)
        if (!recipeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'recipe.label', default: 'Recipe'), params.id])
            redirect(action: "list")
            return
        }

        [recipeInstance: recipeInstance]
    }

    def update() {
        def recipeInstance = Recipe.get(params.id)
        if (!recipeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'recipe.label', default: 'Recipe'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (recipeInstance.version > version) {
                recipeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'recipe.label', default: 'Recipe')] as Object[],
                          "Another user has updated this Recipe while you were editing")
                render(view: "edit", model: [recipeInstance: recipeInstance])
                return
            }
        }

        recipeInstance.properties = params

        if (!recipeInstance.save(flush: true)) {
            render(view: "edit", model: [recipeInstance: recipeInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'recipe.label', default: 'Recipe'), recipeInstance.id])
        redirect(action: "show", id: recipeInstance.id)
    }

    def delete() {
        def recipeInstance = Recipe.get(params.id)
        if (!recipeInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'recipe.label', default: 'Recipe'), params.id])
            redirect(action: "list")
            return
        }

        try {
            recipeInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'recipe.label', default: 'Recipe'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'recipe.label', default: 'Recipe'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
    
    
    
    
    // return JSON list of recipes
    def jq_recipe_list = {

				        /*var search_name = jQuery("#search_name").val();
				        var search_cuisine = jQuery("#search_cuisine").val();
				        var search_chef = jQuery("#search_chef").val();
				        var search_item = jQuery("#search_item").val();
				        var search_instruction = jQuery("#search_instruction").val();*/
          println params 
          println "Recipe count" + Recipe.count()
          

          def sortIndex = params.sidx ?: 'name'
          def sortOrder  = params.sord ?: 'asc'
    
          def maxRows = Integer.valueOf(params.rows)          
          def currentPage = Integer.valueOf(params.page) ?: 1
    
          def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
    
          def recipes = Recipe.createCriteria().list(max:maxRows, offset:rowOffset) {
                // name case insensitive where the field contains with the search term
               if (params.name)
                    ilike('name','%'+params.name + '%')
                    
               if (params.category)
               category{
      	            	ilike('name','%'+params.category +'%')	       		 	            		
	        }     
    
                if (params.cuisine)
                    ilike('cuisine','%'+params.cuisine + '%')
                    
                recipeVersions{
                	if (params.search_chef)
				{
					chef{
					ilike('name','%'+params.search_chef + '%')
					}
				}
				
			if (params.search_instruction || params.search_item)
                	instructionGroup
                		{
                		instructionSeq
                			{
                			instruction
                				{
				                if (params.search_instruction)
	                				ilike('instructionString','%'+params.search_instruction + '%')
                				ingredients
                					{
                					item
                						{
								if (params.search_item)
									ilike('name','%'+params.search_item + '%')
                						
                						}
                					}
                				}
                			}
                		}
                	
                	
                	
                }
                

                order(sortIndex, sortOrder)
          }
          println "recipes:" + recipes
          def totalRows = recipes.totalCount
          
          println "totalCount:" + recipes.totalCount
          
          def numberOfPages = Math.ceil(totalRows / maxRows)
    
          def jsonCells = recipes.collect {
                [cell: [it.name,
                	it.cuisine,
                	it.category.toString()[1..-2],
                	it.spicy,
                	it.healthy,
                	it.economical,
                	it.preprationtime,
                	it.shelflife,
                	it.rating.toString(),
                	it.feedback
                    ], id: it.id]
            }
            def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
            render jsonData as JSON
        }
        
    	def jq_edit_recipe = {
    	      def recipe = null
    	      def message = ""
    	      def state = "FAIL"
    	      def id
    
    	      // determine our action
    	      switch (params.oper) {
    		case 'add':
    		  // add instruction sent
    		  params.creator = springSecurityService.principal.username
    		  params.updator = params.creator
    		  recipe = new Recipe(params)
    		  if (! recipe.hasErrors() && recipe.save()) {
    		    message = "Recipe ${recipe.name} Added"
    		    id = recipe.id
    		    state = "OK"
    		  } else {
    		    recipe.errors.allErrors.each {
    			println it
    		    }		    
    		    message = "Could Not Save Centre"
    		  }
    		  break;
    		case 'del':
    		  // check recipe exists
    		  recipe = Recipe.get(params.id)
    		  if (recipe) {
    		    // delete recipe
    		    recipe.delete()
    		    message = "Recipe  ${recipe.name} Deleted"
    		    state = "OK"
    		  }
    		  break;
    		 default :
    		  // edit action
    		  // first retrieve the recipe by its ID
    		  recipe = Recipe.get(params.id)
    		  if (recipe) {
    		    // set the properties according to passed in parameters
    		    params.updator = springSecurityService.principal.username
    		    recipe.properties = params
    		    if (! recipe.hasErrors() && recipe.save()) {
    		      message = "Recipe  ${recipe.name} Updated"
    		      id = recipe.id
    		      state = "OK"
    		    } else {
    		    recipe.errors.allErrors.each {
    			println it
    		    }		    
    		      message = "Could Not Update Recipe"
    		    }
    		  }
    		  break;
     	 }
    
    	      def response = [message:message,state:state,id:id]
    
    	      render response as JSON
    }

    def cuisineList_JQ = {
		def query = params.term
		//todo this is going to ineffecient; we have to get distinct cuisines easily
		def c = Recipe.createCriteria()
		def cuisines = c.list
			{
			ilike("cuisine", query+"%")
			projections {
				distinct("cuisine","cuisine")
			}
			order("cuisine", "asc")
		}
        response.setHeader("Cache-Control", "no-store")

        def results = cuisines.collect {it
            /*[  
               id: it.id,
               value: it.cuisine,
               label: it.cuisine ]*/
        }

        render results as JSON
    }
    
    def recipe(String cmd) {
        def recipeInstance
        switch(cmd) {
        	case "create":
        		recipeInstance = new Recipe()
        		break
        	case "edit":
        	case "show" :
        		recipeInstance = Recipe.get(params.id)
        		break
        	case "delete":
        		delete()
        		break
        	default:
        		println "Shouldn't have reached here"
        }
        [recipeInstance: recipeInstance, cmd: cmd]

        
    }

    def list_JQ = {
		def cat = ''
		def query = params.term
		def len = params.category.size()

		if (params.category.startsWith('Breakfast'))
			cat = 'Breakfast'
		else if (params.category.startsWith('Brunch'))
			cat = params.category.substring(6,len)
		else if (params.category.startsWith('Lunch'))
			cat = params.category.substring(5,len)
		else if (params.category.startsWith('Dinner'))
			cat = params.category.substring(6,len)
		else if (params.category.startsWith('OP'))
			cat = params.category.substring(2,len)
		else if (params.category.startsWith('FFL'))
			cat = params.category.substring(3,len)
		def c = Recipe.createCriteria()
		def recipes = c.list
			{
			ilike("name", query+"%")
			if(cat)
				ilike("category",cat+"%")
			order("name", "asc")
			}
        response.setHeader("Cache-Control", "no-store")

        def results = recipes.collect {
            [  
               id: it.id,
               value: it.name,
               label: it.name ]
        }

        render results as JSON
    }

    def jq_simple_recipe_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = Recipe.createCriteria().list(max:maxRows, offset:rowOffset) {
		if(SpringSecurityUtils.ifNotGranted('ROLE_KITCHEN_ADMIN'))
			eq('status','TESTED')

		if (params.name)
			ilike('name','%'+params.name + '%')

		if (params.cuisine)
			ilike('cuisine','%'+params.cuisine + '%')

		if (params.category)
				ilike('category','%'+params.category + '%')

		if (params.spicy)
			ilike('spicy','%'+params.spicy + '%')

		if (params.healthy)
			ilike('healthy','%'+params.healthy + '%')

		if (params.economical)
			ilike('economical','%'+params.economical + '%')

		if (params.preprationtime)
			ilike('preprationtime','%'+params.preprationtime + '%')

		if (params.shelflife)
			ilike('shelflife','%'+params.shelflife + '%')

		if (params.feedback)
			ilike('feedback','%'+params.feedback + '%')

		if (params.comments)//service
			ilike('comments','%'+params.comments + '%')

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.name,
            	    it.cuisine,
            	    it.category,
            	    it.spicy,
            	    it.healthy,
            	    it.economical,
            	    it.preprationtime,
            	    it.shelflife,
            	    it.rating,
            	    it.feedback,
            	    it.comments,
            	    it.status,
            	    it.updator,
            	    it.lastUpdated?.format('dd-MM-yyyy HH:mm'),
            	    it.creator,
            	    it.dateCreated?.format('dd-MM-yyyy HH:mm')
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }
  
 }
