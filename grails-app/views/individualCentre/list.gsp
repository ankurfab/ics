
<%@ page import="ics.IndividualCentre" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'individualCentre.label', default: 'IndividualCentre')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-individualCentre" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-individualCentre" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="individualCentre.individual.label" default="Individual" /></th>
					
						<th><g:message code="individualCentre.centre.label" default="Centre" /></th>
					
						<g:sortableColumn property="status" title="${message(code: 'individualCentre.status.label', default: 'Status')}" />
					
						<g:sortableColumn property="comments" title="${message(code: 'individualCentre.comments.label', default: 'Comments')}" />
					
						<g:sortableColumn property="creator" title="${message(code: 'individualCentre.creator.label', default: 'Creator')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'individualCentre.dateCreated.label', default: 'Date Created')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${individualCentreInstanceList}" status="i" var="individualCentreInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${individualCentreInstance.id}">${fieldValue(bean: individualCentreInstance, field: "individual")}</g:link></td>
					
						<td>${fieldValue(bean: individualCentreInstance, field: "centre")}</td>
					
						<td>${fieldValue(bean: individualCentreInstance, field: "status")}</td>
					
						<td>${fieldValue(bean: individualCentreInstance, field: "comments")}</td>
					
						<td>${fieldValue(bean: individualCentreInstance, field: "creator")}</td>
					
						<td><g:formatDate date="${individualCentreInstance.dateCreated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${individualCentreInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
