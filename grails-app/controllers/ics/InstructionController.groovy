package ics

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class InstructionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [instructionInstanceList: Instruction.list(params), instructionInstanceTotal: Instruction.count()]
    }

    def create() {
        [instructionInstance: new Instruction(params)]
    }

    def save() {
        def instructionInstance = new Instruction(params)
        if (!instructionInstance.save(flush: true)) {
            render(view: "create", model: [instructionInstance: instructionInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'instruction.label', default: 'Instruction'), instructionInstance.id])
        redirect(action: "show", id: instructionInstance.id)
    }

    def show() {
        def instructionInstance = Instruction.get(params.id)
        if (!instructionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'instruction.label', default: 'Instruction'), params.id])
            redirect(action: "list")
            return
        }

        [instructionInstance: instructionInstance]
    }

    def edit() {
        def instructionInstance = Instruction.get(params.id)
        if (!instructionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'instruction.label', default: 'Instruction'), params.id])
            redirect(action: "list")
            return
        }

        [instructionInstance: instructionInstance]
    }

    def update() {
        def instructionInstance = Instruction.get(params.id)
        if (!instructionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'instruction.label', default: 'Instruction'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (instructionInstance.version > version) {
                instructionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'instruction.label', default: 'Instruction')] as Object[],
                          "Another user has updated this Instruction while you were editing")
                render(view: "edit", model: [instructionInstance: instructionInstance])
                return
            }
        }

        instructionInstance.properties = params

        if (!instructionInstance.save(flush: true)) {
            render(view: "edit", model: [instructionInstance: instructionInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'instruction.label', default: 'Instruction'), instructionInstance.id])
        redirect(action: "show", id: instructionInstance.id)
    }

    def delete() {
        def instructionInstance = Instruction.get(params.id)
        if (!instructionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'instruction.label', default: 'Instruction'), params.id])
            redirect(action: "list")
            return
        }

        try {
            instructionInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'instruction.label', default: 'Instruction'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'instruction.label', default: 'Instruction'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
    
    def jq_instruction_list ={
    
    println "in jq_instruction_list" + params 

	def rv = RecipeVersion.get(params.'recipeVersion.id')    	
    	
    	def maxRows = Integer.valueOf(params.rows)
	def currentPage = Integer.valueOf(params.page) ?: 1
	def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
	
	def ig
        def is           

        if(rv)	      
        {
	      ig = InstructionGroup.findBySequenceAndRecipeVersion(99,rv)

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
		    it.instruction.instructionString                    
		], id: it.id]                	                 
	}
	def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
	render jsonData as JSON
    }       
    
        
    def jq_instruction_edit_list = {
    	      def inst = null
    	      def instruction = null
    	      def instseq = null
    	      def instgrp = null
    	      def message = ""
    	      def state = "FAIL"
    	      def id        
    	    
    	    println "in jq_instruction_edit_list" + params 
    	    
    	    // determine our action
    	      switch (params.oper) {
	      		case 'add':
	      		
	      		  def rv= RecipeVersion.get(params.'recipeVersion.id')
	      		  instgrp = InstructionGroup.findBySequenceAndRecipeVersion(99,rv)
	      		  def max = 0
	      		  
	      		  if(!instgrp)
	      		  {	      			  
	      			  instgrp = new InstructionGroup()
	      			  instgrp.recipeVersion = rv
	      			  instgrp.sequence=99
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
	      		  instgrp = InstructionGroup.findBySequenceAndRecipeVersion(99,rv)
	      		  
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

}
