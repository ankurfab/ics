
<%@ page import="ics.Journey" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'journey.label', default: 'Journey')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-journey" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-journey" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="arrival" title="${message(code: 'journey.arrival.label', default: 'Arrival')}" />
					
						<g:sortableColumn property="creator" title="${message(code: 'journey.creator.label', default: 'Creator')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'journey.dateCreated.label', default: 'Date Created')}" />
					
						<th><g:message code="journey.eventRegistration.label" default="Event Registration" /></th>
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'journey.lastUpdated.label', default: 'Last Updated')}" />
					
						<g:sortableColumn property="location" title="${message(code: 'journey.location.label', default: 'Location')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${journeyInstanceList}" status="i" var="journeyInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${journeyInstance.id}">${fieldValue(bean: journeyInstance, field: "arrival")}</g:link></td>
					
						<td>${fieldValue(bean: journeyInstance, field: "creator")}</td>
					
						<td><g:formatDate date="${journeyInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: journeyInstance, field: "eventRegistration")}</td>
					
						<td><g:formatDate date="${journeyInstance.lastUpdated}" /></td>
					
						<td>${fieldValue(bean: journeyInstance, field: "location")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${journeyInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
