
<%@ page import="ics.Cuisine" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cuisine.label', default: 'Cuisine')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cuisine" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-cuisine" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'cuisine.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="creator" title="${message(code: 'cuisine.creator.label', default: 'Creator')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'cuisine.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="updator" title="${message(code: 'cuisine.updator.label', default: 'Updator')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'cuisine.lastUpdated.label', default: 'Last Updated')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${cuisineInstanceList}" status="i" var="cuisineInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${cuisineInstance.id}">${fieldValue(bean: cuisineInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: cuisineInstance, field: "creator")}</td>
					
						<td><g:formatDate date="${cuisineInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: cuisineInstance, field: "updator")}</td>
					
						<td><g:formatDate date="${cuisineInstance.lastUpdated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${cuisineInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
