
<%@ page import="ics.InstructionSequence" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'instructionSequence.label', default: 'InstructionSequence')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-instructionSequence" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-instructionSequence" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list instructionSequence">
			
				<g:if test="${instructionSequenceInstance?.instruction}">
				<li class="fieldcontain">
					<span id="instruction-label" class="property-label"><g:message code="instructionSequence.instruction.label" default="Instruction" /></span>
					
						<span class="property-value" aria-labelledby="instruction-label"><g:link controller="instruction" action="show" id="${instructionSequenceInstance?.instruction?.id}">${instructionSequenceInstance?.instruction?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${instructionSequenceInstance?.from}">
				<li class="fieldcontain">
					<span id="from-label" class="property-label"><g:message code="instructionSequence.from.label" default="From" /></span>
					
						<span class="property-value" aria-labelledby="from-label"><g:fieldValue bean="${instructionSequenceInstance}" field="from"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${instructionSequenceInstance?.to}">
				<li class="fieldcontain">
					<span id="to-label" class="property-label"><g:message code="instructionSequence.to.label" default="To" /></span>
					
						<span class="property-value" aria-labelledby="to-label"><g:fieldValue bean="${instructionSequenceInstance}" field="to"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${instructionSequenceInstance?.sequence}">
				<li class="fieldcontain">
					<span id="sequence-label" class="property-label"><g:message code="instructionSequence.sequence.label" default="Sequence" /></span>
					
						<span class="property-value" aria-labelledby="sequence-label"><g:fieldValue bean="${instructionSequenceInstance}" field="sequence"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${instructionSequenceInstance?.id}" />
					<g:link class="edit" action="edit" id="${instructionSequenceInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
