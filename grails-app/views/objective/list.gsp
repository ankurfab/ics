
<%@ page import="ics.Objective" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'objective.label', default: 'Objective')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-objective" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<g:if test="${LoggedInUserRole == 'PatronCare'}">
					<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				</g:if>
			</ul>
		</div>
		<div id="list-objective" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="objective.assignedBy.label" default="Assigned By" /></th>
					
						<th><g:message code="objective.assignedTo.label" default="Assigned To" /></th>
					
						<g:sortableColumn property="category" title="${message(code: 'objective.category.label', default: 'Category')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'objective.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'objective.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="objFrom" title="${message(code: 'objective.objFrom.label', default: 'Obj From')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${objectiveInstanceList}" status="i" var="objectiveInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${objectiveInstance.id}">${fieldValue(bean: objectiveInstance, field: "assignedBy")}</g:link></td>
					
						<td>${fieldValue(bean: objectiveInstance, field: "assignedTo")}</td>
					
						<td>${fieldValue(bean: objectiveInstance, field: "category")}</td>
					
						<td>${fieldValue(bean: objectiveInstance, field: "name")}</td>
					
						<td>${fieldValue(bean: objectiveInstance, field: "description")}</td>
					
						<td><g:formatDate date="${objectiveInstance.objFrom}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${objectiveInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
