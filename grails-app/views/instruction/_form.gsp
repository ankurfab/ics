<%@ page import="ics.Instruction" %>



<div class="fieldcontain ${hasErrors(bean: instructionInstance, field: 'ingredients', 'error')} ">
	<label for="ingredients">
		<g:message code="instruction.ingredients.label" default="Ingredients" />
		
	</label>
	<g:select name="ingredients" from="${ics.ItemCount.list()}" multiple="multiple" optionKey="id" size="5" value="${instructionInstance?.ingredients*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: instructionInstance, field: 'instructionString', 'error')} ">
	<label for="instructionString">
		<g:message code="instruction.instructionString.label" default="Instruction String" />
		
	</label>
	<g:textField name="instructionString" value="${instructionInstance?.instructionString}"/>
</div>

