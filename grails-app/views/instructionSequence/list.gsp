
<%@ page import="ics.InstructionSequence" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'instructionSequence.label', default: 'InstructionSequence')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-instructionSequence" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-instructionSequence" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="instructionSequence.instruction.label" default="Instruction" /></th>
					
						<g:sortableColumn property="from" title="${message(code: 'instructionSequence.from.label', default: 'From')}" />
					
						<g:sortableColumn property="to" title="${message(code: 'instructionSequence.to.label', default: 'To')}" />
					
						<g:sortableColumn property="sequence" title="${message(code: 'instructionSequence.sequence.label', default: 'Sequence')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${instructionSequenceInstanceList}" status="i" var="instructionSequenceInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${instructionSequenceInstance.id}">${fieldValue(bean: instructionSequenceInstance, field: "instruction")}</g:link></td>
					
						<td>${fieldValue(bean: instructionSequenceInstance, field: "from")}</td>
					
						<td>${fieldValue(bean: instructionSequenceInstance, field: "to")}</td>
					
						<td>${fieldValue(bean: instructionSequenceInstance, field: "sequence")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${instructionSequenceInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
