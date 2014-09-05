package ics

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class InstructionGroupController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [instructionGroupInstanceList: InstructionGroup.list(params), instructionGroupInstanceTotal: InstructionGroup.count()]
    }

    def create() {
        [instructionGroupInstance: new InstructionGroup(params)]
    }

    def save() {
        def instructionGroupInstance = new InstructionGroup(params)
        if (!instructionGroupInstance.save(flush: true)) {
            render(view: "create", model: [instructionGroupInstance: instructionGroupInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'instructionGroup.label', default: 'InstructionGroup'), instructionGroupInstance.id])
        redirect(action: "show", id: instructionGroupInstance.id)
    }

    def show() {
        def instructionGroupInstance = InstructionGroup.get(params.id)
        if (!instructionGroupInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'instructionGroup.label', default: 'InstructionGroup'), params.id])
            redirect(action: "list")
            return
        }

        [instructionGroupInstance: instructionGroupInstance]
    }

    def edit() {
        def instructionGroupInstance = InstructionGroup.get(params.id)
        if (!instructionGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'instructionGroup.label', default: 'InstructionGroup'), params.id])
            redirect(action: "list")
            return
        }

        [instructionGroupInstance: instructionGroupInstance]
    }

    def update() {
        def instructionGroupInstance = InstructionGroup.get(params.id)
        if (!instructionGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'instructionGroup.label', default: 'InstructionGroup'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (instructionGroupInstance.version > version) {
                instructionGroupInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'instructionGroup.label', default: 'InstructionGroup')] as Object[],
                          "Another user has updated this InstructionGroup while you were editing")
                render(view: "edit", model: [instructionGroupInstance: instructionGroupInstance])
                return
            }
        }

        instructionGroupInstance.properties = params

        if (!instructionGroupInstance.save(flush: true)) {
            render(view: "edit", model: [instructionGroupInstance: instructionGroupInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'instructionGroup.label', default: 'InstructionGroup'), instructionGroupInstance.id])
        redirect(action: "show", id: instructionGroupInstance.id)
    }

    def delete() {
        def instructionGroupInstance = InstructionGroup.get(params.id)
        if (!instructionGroupInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'instructionGroup.label', default: 'InstructionGroup'), params.id])
            redirect(action: "list")
            return
        }

        try {
            instructionGroupInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'instructionGroup.label', default: 'InstructionGroup'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'instructionGroup.label', default: 'InstructionGroup'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jq_ig_list = {
      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

      //first get the relevant instruction groups
      def rv = RecipeVersion.get(params.'recipeVersion.id')
      //println "RV in jq_ig_list: "+  rv
      def ig
      def is           
      
      if(rv)	      
      {
	      ig = InstructionGroup.findBySequenceAndRecipeVersion(1,rv)
	      
	      if(ig)
	      	is = ig.instructionSeq
	      else
	      	is = []
	}
      else
	      is = []	
      
      
      def iSeq= is.sort{it.sequence}
      
      def totalRows = is.size()      
      
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def count = 1	
      def jsonCells = iSeq.collect {
            [cell: [count++,
                    it.instruction.id,
            	    it.instruction.instructionString,                    
                ], id: it.id]                	                 
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }
    
    def jq_ig_edit_list = {
	      def inst = null
	      def instruction = null
	      def instseq = null
	      def instgrp = null
	      def message = ""
	      def state = "FAIL"
	      def id

	println "in jq_ig_edit_list" + params 
	    
	    // determine our action
	      switch (params.oper) {
		case 'add':
		
		  def rv= RecipeVersion.get(params.'recipeVersion.id')
		  instgrp = InstructionGroup.findBySequenceAndRecipeVersion(1,rv)
		  def max = 0
		  
		  if(!instgrp)
		  {
			  println "HARE KRISSHNA" + params.'recipeVersion.id'
			  instgrp = new InstructionGroup()
			  instgrp.recipeVersion = rv
			  instgrp.sequence=1
			  instgrp.instructionSeq = []
			  instgrp.save()
			  
			  rv.instructionGroup.add(instgrp)
			  rv.save()
		  }
		  
		  instseq = new InstructionSequence()		  
		  
		  instgrp?.instructionSeq?.each{			
		     if(max < it?.sequence)							
			     max=it.sequence																
		   }
     	          
         	  if(max)
			instseq.sequence=max + 1
		  else
			instseq.sequence=1
			
		// add instruction sent
		  inst = new Instruction()
		  inst.instructionString = params.instruction
		  
		  if (! inst.hasErrors() && inst.save(flush:true)) {
		    message = "Instruction ${inst.id} Added"
		    id = inst.id
		    state = "OK"
		  } else {
		    inst.errors.allErrors.each {
			println it
		    }
		    message = "Could Not Save this Instruction"
		  }
		  	
		  instseq.instruction = inst
		  
		  if(!instseq.save())
			instseq.errors.allErrors.each {
						println it
			}

		  instgrp.instructionSeq.add(instseq)
		  
		  if(!instgrp.save())
			instgrp.errors.allErrors.each {
						println it
			}	  		 
		  		  			  	
		  break;
		  
		case 'del':
		  def rv= RecipeVersion.get(params.'recipeVersion.id')
		  instgrp = InstructionGroup.findBySequenceAndRecipeVersion(1,rv)
		  
		  instseq = InstructionSequence.get(params.id)   
		 		  		  		  		 		 	
		  if (instseq) {
		    // delete Instruction		    
		    instgrp.instructionSeq.remove(instseq)  
		    
		    instseq.delete()
		    
		    message = "Instruction Deleted"
		    state = "OK"
		  }
		  		  
		  break;
		 
		 default :
		  // edit action
		  		  
		  instseq = InstructionSequence.get(params.id)   
		  		  
		  if (instseq) {
		    // set the properties according to passed in parameters
		    instseq.instruction.instructionString = params.instruction
			  //instruction.updator = springSecurityService.principal.username
		    if (! instseq.hasErrors() && instseq.save()) {
		      message = "Instruction  Updated"
		      id = params.id
		      state = "OK"
		    } else {
			    instseq.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Instruction"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	}



	def jq_item_list = {
	      def maxRows = Integer.valueOf(params.rows)
	      def currentPage = Integer.valueOf(params.page) ?: 1
	
	      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
	
	      //first get the relevant instruction groups
	      def instr = Instruction.get(params.instid)
	      
	      def ic= instr.ingredients
	      def totalRows = ic.size()
	      def numberOfPages = Math.ceil(totalRows / maxRows)
	
	      def jsonCells = ic.collect {
	            [cell: [it.item.name,
			    it.qty,	            
	                    it.unit?.toString(),
	                ], id: it.id]
	        }
	        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
	        render jsonData as JSON
    }
    
    
    def jq_item_edit_list = {
    	      def ic = null
    	      
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
    		  	it=new Item()
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
    			}
    		  }
    		  
    		  ic = new ItemCount()
    		  ic.item= it
    		  ic.qty= new BigDecimal(params.quantity)
    		  ic.unit=params.unit
    		  ic.rate=1
    		  ic.nqty=5
    		  ic.nunit='KG'
    		  ic.nrate=1
    		  
    		  ic.creator='Sujit'
    		  ic.updator='Sujith'
    		  
    		  
    		  ic.instruction = Instruction.get(params.instid)
    		  
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
    		  if (ic) {
    		    // set the properties according to passed in parameters
    		    ic.properties = params
    			  ic.updator = springSecurityService.principal.username
    		    if (! ic.hasErrors() && ic.save()) {
    		      message = "Item Count  ${ic.name} Updated"
    		      id = ic.id
    		      state = "OK"
    		    } else {
    			    ic.errors.allErrors.each {
    				println it
    				}
    		      message = "Could Not Update Instruction"
    		    }
    		  }
    		  break;
     	 }
    
    	      def response = [message:message,state:state,id:id]
    
    	      render response as JSON
    	    }
    


}
