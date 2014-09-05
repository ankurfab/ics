package ics

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class ItemCountController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def recipeService 

    def index() {
        redirect(action: "list", params: params)
    }

    
    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [itemCountInstanceList: ItemCount.list(params), itemCountInstanceTotal: ItemCount.count()]
    }

    def create() {
        [itemCountInstance: new ItemCount(params)]
    }

    def save() {
        def itemCountInstance = new ItemCount(params)
        if (!itemCountInstance.save(flush: true)) {
            render(view: "create", model: [itemCountInstance: itemCountInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'itemCount.label', default: 'ItemCount'), itemCountInstance.id])
        redirect(action: "show", id: itemCountInstance.id)
    }

    def show() {
        def itemCountInstance = ItemCount.get(params.id)
        if (!itemCountInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemCount.label', default: 'ItemCount'), params.id])
            redirect(action: "list")
            return
        }

        [itemCountInstance: itemCountInstance]
    }

    def edit() {
        def itemCountInstance = ItemCount.get(params.id)
        if (!itemCountInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemCount.label', default: 'ItemCount'), params.id])
            redirect(action: "list")
            return
        }

        [itemCountInstance: itemCountInstance]
    }

    def update() {
        def itemCountInstance = ItemCount.get(params.id)
        if (!itemCountInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemCount.label', default: 'ItemCount'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (itemCountInstance.version > version) {
                itemCountInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'itemCount.label', default: 'ItemCount')] as Object[],
                          "Another user has updated this ItemCount while you were editing")
                render(view: "edit", model: [itemCountInstance: itemCountInstance])
                return
            }
        }

        itemCountInstance.properties = params

        if (!itemCountInstance.save(flush: true)) {
            render(view: "edit", model: [itemCountInstance: itemCountInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'itemCount.label', default: 'ItemCount'), itemCountInstance.id])
        redirect(action: "show", id: itemCountInstance.id)
    }

    def delete() {
        def itemCountInstance = ItemCount.get(params.id)
        if (!itemCountInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemCount.label', default: 'ItemCount'), params.id])
            redirect(action: "list")
            return
        }

        try {
            itemCountInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'itemCount.label', default: 'ItemCount'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'itemCount.label', default: 'ItemCount'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
    
    def round(ItemCount ic) {
            
            //ic.qty = Math.round(ic.qty) 
            def base = Math.floor(ic.qty) 
            def deci = ic.qty - base 
            
            println "ic.unit:" + ic.unit
            
            if(ic.unit.toString() == "KG")
            {
            	println "ic.unit:" + ic.unit
            	
            	ic.subqty = Math.round(deci*1000)
            	
            	if(ic.subqty == 1000)
            	{
            		base = base + 1
            		ic.subqty = 0
            	}
            	ic.subunit = "GMS"
            }
            if(ic.unit.toString() == "L")
            {
            	println "ic.unit:" + ic.unit
            	
            	ic.subqty = Math.round(deci*1000)
            	
            	if(ic.subqty == 1000)
		{
			base = base + 1
			ic.subqty = 0
		}
            	ic.subunit = "ML"
            }            
		
	    if(ic.unit.toString() == "BUNCHES" || ic.unit.toString() == "GMS" || ic.unit.toString() == "ML")
	    {
	        base = Math.round(ic.qty) 
	    }
	    
            ic.qty = base
            
            return ic
    }
   
    def jq_item_list() {
    
    	     println "inside jq_item_list PARAMS:" + params
        	     
    	     def rv = RecipeVersion.get(params.'recipeVersion.id')
    	     def ig = InstructionGroup.findBySequenceAndRecipeVersion(0,rv)
   	     def instruc
   	     
   	     if(params.ic_no)
   	     {
		def ic_no = params.int('ic_no')
		def calQty
		
		ig.instructionSeq.each{is->
			is.instruction.ingredients.each{ic->
			
			if(ic.icNum==ic_no)
			{
				if(ic.unit.toString() == "KG")
				{
					calQty= ic.qty + (ic.subqty / 1000)									
					
					ic.qty = calQty/ic.item.densityFactor
					ic.unit="L"
					
					round(ic)			
				}
				else if(ic.unit.toString() == "L")
				{
					calQty= ic.qty + (ic.subqty / 1000)									

					ic.qty = calQty * ic.item.densityFactor
					ic.unit="KG"

					round(ic)			
				}
				
				ic.save() 
			}
		    }
        	}		
   	     }
   	     
   	     if(params.yield)
   	     {
	     	def yield = Double.valueOf(params.yield)
	     	def unit = params.unit
	     		
	        //recipeService.yieldtoIngredients(rv,yield,unit)
	        
	        def standardYield        	
		
		if(unit.equals(rv.yieldUnit1.toString()))
		{	
			standardYield = rv.yield1
		}
		else if(unit.equals(rv.yieldUnit2.toString()))
		{	
			standardYield = rv.yield2
		}
		else if(unit.equals(rv.yieldUnit3.toString()))
		{	
			standardYield = rv.yield3
		}				

		ig.instructionSeq.each{is->
			is.instruction.ingredients.each{ic->
			
			println ":::ic.nqty: " + ic.nqty + "::standardYield:" + standardYield + "::yield:" + yield + ""

			ic.qty= ic.nqty/standardYield * yield  
						
			ic = round(ic)
			
			ic.unit = ic.nunit	//Here we are dealing with the standard units only
			ic.save() 
		    }
        	}       
	     }
		
	     if(params.constant)	
	     {
		def ic, ic1 
		def c=params.int('constant')

		def seq1=params.int('seq1')  
		ic1 = ItemCount.get(params.int('id1'))    	         	        
		def is1 = InstructionSequence.findBySequenceAndInstruction(seq1,ic1.instruction)

		String[] ids = params.string.split(",");

		for(String t : ids) {		            

			   ic= ItemCount.get(t)    	     
			   ic.icNum=c

			   if(c==params.int('constant')) 
			   {	
				def seq2=params.int('seq2')				
				def is2 = InstructionSequence.findBySequenceAndInstruction(seq2,ic.instruction)

				if(ic.instruction.instructionString!=is1.instruction.instructionString)
				{		           
					is1.instruction.ingredients.add(ic)
					ic.instruction=is1.instruction		

					is2.instruction.ingredients.remove(ic)
				}
			   }

			   ic.save()

			   if(params.int('incr'))
				c++
			   else
				c--
		}
    	     }
 		
 	     //to do : place this logic in service method 	
	     if(params.instructionDialog)
	     {		     
		     def instr
		     def ic, max
		     def instrSeq
		     def edit = params.int('edit')
		     
		     if(edit != 1)
		     {
		     	     def idList = params.ids?.split(',').collect{it as int}	
			     instr= new Instruction()
			     instr.ingredients = []

			     max=0		     

			     idList?.each{id-> 

				ic=ItemCount.get(Integer.valueOf(id))				
				instruc = ic.instruction 

				println "IC:" + ic
				instr.ingredients.add(ic)
				ic.instruction=instr			
				ic.save()

				instruc.ingredients.remove(ic) 					
			     }
		     }
		     else
		     {
		     	     ig?.instructionSeq?.each { is-> 
		     	         if(is.sequence == params.int('seqno'))
		     	         {
		     	         	instrSeq = is		     	         	
		     	         }
		     	     }
		     	     
		     	     instr = instrSeq.instruction
	
		     }
		     
		     instr.instructionString = params.instructionDialog
		     instr.save(flush: true)		     
		     		     
		     
		     if(edit != 1)
		     {
			     ig?.instructionSeq?.each{			
					if(max < it?.sequence)							
						max=it.sequence																
			     }

			     instrSeq= new InstructionSequence()    

			     if(max)
				instrSeq.sequence=max + 1
			     else
				instrSeq.sequence=1
		     }
		     
		     instrSeq.instruction=instr
		     instrSeq.save(flush: true)
			
		     if(edit != 1)	
			     ig?.instructionSeq?.add(instrSeq)		     	   
    	     }
    	     
    	     def maxRows
    	     if(params.rows)
    	     	maxRows = Integer.valueOf(params.rows) ?:1
    	     else
    	     	maxRows = 1
    	     
    	     def currentPage
    	     if(params.page)
	     	currentPage = Integer.valueOf(params.page) ?: 1
	     else
	     	currentPage = 1

	      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
	      
	      def ing
	      def instrStr
	      def totalRows = 0
	      def numberOfPages
	      def jsonCells = []
	      def tmp = [:]
	      
	      //order the jsoncells on inst sequeunce
	      
	      println "BEFORE:" + ig?.instructionSeq
	      
	      def iSeq= ig?.instructionSeq?.sort{it.sequence}
	      	      
	      println "AFTER:" + iSeq

	      def subqty	
	      def subunit
	      //ig?.instructionSeq?.each is->
	      iSeq?.each{is->
		      ing = is.instruction?.ingredients.sort{it.icNum}
		      
		      instrStr = is.instruction?.instructionString
		      
		      println "Sorted Ingredient list: "+ing + "\n"
		      if(!ing)
		      	ing=[]
		      else			      
		      	totalRows = totalRows + ing.size()	 		      		      
	      		      
	      	     
	      jsonCells.add(ing.collect {
	       
	      if(it.subqty)
	      {
	      	subqty = it.subqty?.toBigInteger().toString()
	      	subunit = it.subunit?.toString()	            
	      }
	      else
	      {
	      	subqty = ''
	      	subunit = ''
	      }	      	     
	      		
		    [cell: [is.sequence,
		    	    it.icNum, 	
		            it.item.name,
			    it.qualifier,
			    it.nqty,	            
			    it.nunit?.toString(),			    
			    it.qty.toBigInteger().toString() + " " + it.unit?.toString() + " " + subqty + " " + subunit,
			    it.unit?.toString(),
			    it.subqty,	            
			    it.subunit?.toString(),			    
			    it.instruction.toString(),
			 it.id], id:it.id]
		}
		
		)
		//--------is.instruction.toString()-----changed to----- it.instruction.toString()----- above -----
		//println "it-icNum:::::::::::::" + it.icNum
		println "SORTED:::::::::::::" + jsonCells
	      }	      	     
	      
	      jsonCells = jsonCells.flatten()
	      
	      println jsonCells
	      if(totalRows)
		numberOfPages = Math.ceil(totalRows / maxRows)
		
		println "totalRows:" + totalRows + "maxRows:" + maxRows + "numberOfPages:" + numberOfPages +"\n"		      	     
		
		def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
	render jsonData as JSON
    }
    
    def jq_item_edit_list = {
        	      def ic = null
        	      def temp
        	      def message = ""
        	      def state = "FAIL"
        	      def id        	              	     
        
        	      // determine our action
        	      switch (params.oper) {
        		case 'add':
        		  // add item count sent
        		  it = Item.findByName(params.name)
        		  
        		  if(!it)
        		  {
        		  	/*it=new Item()
        		  	it.name=params.name
        		  	it.otherNames='xyz'
        		  	it.category='abc'
        		  	it.variety='pqr'
        		  	it.brand='lmn'
        		  	
        		  	it.creator='sujith'
        		  	it.updator='sujit'
        		  	
        		  	
        		  	if(!it.save(flush:true)){
        		  		it.errors.allErrors.each {
    			    			println it
        			}
        			}*/
        			
        			message = "New items cannot be added from here"
        			break;
        		  }
        		  
        		  ic = new ItemCount(params)
        		  ic.item= it  
        		  
        		  ic.qty = ic.nqty
        		  ic.unit = ic.nunit
			  
			  def max=0
			  
        		  //todo pls use each with sequence and refer to the 1st entry only
        		  def rv = RecipeVersion.get(params.'recipeVersion.id')
        		  rv.instructionGroup.each{
        		  //println "IG:" + it
        	        		  
				it.instructionSeq?.each{
					it.instruction?.ingredients?.each{
						if(max < it.icNum)							
							max=it.icNum													
					}						
				}

        		  	it.instructionSeq.each{
        		  		//println "IS:" + it
        		  		//it.instruction.each{
        		  		if(it.sequence==0)
        		  		{
        		  			//println "instruction"+it.instruction
						//println "ingredients"+it.instruction.ingredients
						ic.instruction = it.instruction
																				
						if(max)
							ic.icNum = max + 1
						else
							ic.icNum = 1
							
						max = ic.icNum
						
						if (! ic.hasErrors() && ic.save(flush:true)) {
						    message = "Item count ${ic.id} Added"
						    id = ic.id
						    state = "OK"
						   } else {
						    ic.errors.allErrors.each {
							println it
							}
						    message = "Could Not Save Item count"
  			  			}
  			  			
						it.instruction.ingredients.add(ic)
						if(!it.instruction.save(flush:true))
							it.instruction.errors.allErrors.each {
								println it.instruction
							}
					}
        		  		//}
        		  	}
        		  }
        		  
        		  
       		      		  
        		  break;
        		  
        		case 'del':
        		  // check ic exists
        		  ic = ItemCount.get(params.id)
        		  if (ic) {
        		    // delete Instruction
        		    ic.delete()
        		    message = "Item Count  ${ic.id} Deleted"
        		    state = "OK"
        		  }
        		  break;
        		 default :
        		  // edit action
        		  // first retrieve the itemcount by its ID
        		  ic = ItemCount.get(params.id)
        		  
        		  println "INSTRUCTION STRING :::::::::::::::: "+ ic.instruction.instructionString
        		  
        		  if (ic) {
        		    // set the properties according to passed in parameters
        		    ic.properties = params
        			 // ic.updator = springSecurityService.principal.username
        		    if (! ic.hasErrors() && ic.save()) {
        		      message = "Item Count Updated"
        		      id = ic.id
        		      state = "OK"
        		    } else {
        			    ic.errors.allErrors.each {
        				println it
        				}
        		      message = "Could Not Update"
        		    }
        		    
        		    
        		  }
        		  break;
         	 }
        
        	      def response = [message:message,state:state,id:id]
        
        	      render response as JSON
    	    }
    	    
    	    
    	    
    	    def jq_sequence_order = {
    	       	        
    	        def ic, ic1 
    	        def c=params.int('constant')
    	        
    	        def seq1=params.int('seq1')  
    	        ic1 = ItemCount.get(params.int('id1'))    	         	        
		def is1 = InstructionSequence.findBySequenceAndInstruction(seq1,ic1.instruction)
		
    	        String[] ids = params.string.split(",");
    	        
    	        for(String t : ids) {		            
		            
		           ic= ItemCount.get(t)    	     
		           ic.icNum=c
		           
		           if(c==params.int('constant')) 
		           {	
		           	def seq2=params.int('seq2')				
				def is2 = InstructionSequence.findBySequenceAndInstruction(seq2,ic.instruction)

		           	if(ic.instruction.instructionString!=is1.instruction.instructionString)
		           	{		           
		           		is1.instruction.ingredients.add(ic)
		           		ic.instruction=is1.instruction		
		           		
		           		is2.instruction.ingredients.remove(ic)
		           	}
		           }
		           
		           ic.save()
		           		           
		           if(params.int('incr'))
		           	c++
		           else
		           	c--
        	}
    	        
    	    	def message = ""
        	def state = "FAIL"
        	def id        	              	     
        	def response = [message:message,state:state,id:id]
        	
      		render response as JSON
    	    
    	    }
    	    
    	       	    
}