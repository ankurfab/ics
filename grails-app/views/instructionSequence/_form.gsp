<%@ page import="ics.InstructionSequence" %>



<div class="fieldcontain ${hasErrors(bean: instructionSequenceInstance, field: 'instruction', 'error')} required">
	<label for="instruction">
		<g:message code="instructionSequence.instruction.label" default="Instruction" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="instruction" name="instruction.id" from="${ics.Instruction.list()}" optionKey="id" required="" value="${instructionSequenceInstance?.instruction?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: instructionSequenceInstance, field: 'from', 'error')} required">
	<label for="from">
		<g:message code="instructionSequence.from.label" default="From" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="from" required="" value="${fieldValue(bean: instructionSequenceInstance, field: 'from')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: instructionSequenceInstance, field: 'to', 'error')} required">
	<label for="to">
		<g:message code="instructionSequence.to.label" default="To" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="to" required="" value="${fieldValue(bean: instructionSequenceInstance, field: 'to')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: instructionSequenceInstance, field: 'sequence', 'error')} required">
	<label for="sequence">
		<g:message code="instructionSequence.sequence.label" default="Sequence" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sequence" required="" value="${fieldValue(bean: instructionSequenceInstance, field: 'sequence')}"/>
</div>

