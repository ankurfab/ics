package ics

import org.springframework.dao.DataIntegrityViolationException

class InstructionSequenceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [instructionSequenceInstanceList: InstructionSequence.list(params), instructionSequenceInstanceTotal: InstructionSequence.count()]
    }

    def create() {
        [instructionSequenceInstance: new InstructionSequence(params)]
    }

    def save() {
        def instructionSequenceInstance = new InstructionSequence(params)
        if (!instructionSequenceInstance.save(flush: true)) {
            render(view: "create", model: [instructionSequenceInstance: instructionSequenceInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'instructionSequence.label', default: 'InstructionSequence'), instructionSequenceInstance.id])
        redirect(action: "show", id: instructionSequenceInstance.id)
    }

    def show() {
        def instructionSequenceInstance = InstructionSequence.get(params.id)
        if (!instructionSequenceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'instructionSequence.label', default: 'InstructionSequence'), params.id])
            redirect(action: "list")
            return
        }

        [instructionSequenceInstance: instructionSequenceInstance]
    }

    def edit() {
        def instructionSequenceInstance = InstructionSequence.get(params.id)
        if (!instructionSequenceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'instructionSequence.label', default: 'InstructionSequence'), params.id])
            redirect(action: "list")
            return
        }

        [instructionSequenceInstance: instructionSequenceInstance]
    }

    def update() {
        def instructionSequenceInstance = InstructionSequence.get(params.id)
        if (!instructionSequenceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'instructionSequence.label', default: 'InstructionSequence'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (instructionSequenceInstance.version > version) {
                instructionSequenceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'instructionSequence.label', default: 'InstructionSequence')] as Object[],
                          "Another user has updated this InstructionSequence while you were editing")
                render(view: "edit", model: [instructionSequenceInstance: instructionSequenceInstance])
                return
            }
        }

        instructionSequenceInstance.properties = params

        if (!instructionSequenceInstance.save(flush: true)) {
            render(view: "edit", model: [instructionSequenceInstance: instructionSequenceInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'instructionSequence.label', default: 'InstructionSequence'), instructionSequenceInstance.id])
        redirect(action: "show", id: instructionSequenceInstance.id)
    }

    def delete() {
        def instructionSequenceInstance = InstructionSequence.get(params.id)
        if (!instructionSequenceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'instructionSequence.label', default: 'InstructionSequence'), params.id])
            redirect(action: "list")
            return
        }

        try {
            instructionSequenceInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'instructionSequence.label', default: 'InstructionSequence'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'instructionSequence.label', default: 'InstructionSequence'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
