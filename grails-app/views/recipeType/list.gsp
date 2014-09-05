
<%@ page import="ics.RecipeType" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'recipeType.label', default: 'RecipeType')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-recipeType" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-recipeType" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'recipeType.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="creator" title="${message(code: 'recipeType.creator.label', default: 'Creator')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'recipeType.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="updator" title="${message(code: 'recipeType.updator.label', default: 'Updator')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'recipeType.lastUpdated.label', default: 'Last Updated')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${recipeTypeInstanceList}" status="i" var="recipeTypeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${recipeTypeInstance.id}">${fieldValue(bean: recipeTypeInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: recipeTypeInstance, field: "creator")}</td>
					
						<td><g:formatDate date="${recipeTypeInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: recipeTypeInstance, field: "updator")}</td>
					
						<td><g:formatDate date="${recipeTypeInstance.lastUpdated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${recipeTypeInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
