
<%@ page import="ics.Seva" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'seva.label', default: 'Seva')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-seva" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="category" title="${message(code: 'seva.category.label', default: 'Category')}" />
					
						<g:sortableColumn property="type" title="${message(code: 'seva.type.label', default: 'Type')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'seva.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'seva.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="creator" title="${message(code: 'seva.creator.label', default: 'Creator')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'seva.dateCreated.label', default: 'Date Created')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${sevaInstanceList}" status="i" var="sevaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${sevaInstance.id}">${fieldValue(bean: sevaInstance, field: "category")}</g:link></td>
					
						<td>${fieldValue(bean: sevaInstance, field: "type")}</td>
					
						<td>${fieldValue(bean: sevaInstance, field: "name")}</td>
					
						<td>${fieldValue(bean: sevaInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: sevaInstance, field: "creator")}</td>
					
						<td><g:formatDate date="${sevaInstance.dateCreated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${sevaInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
