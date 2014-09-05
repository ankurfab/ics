
<%@ page import="ics.RecipeVersion" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'recipeVersion.label', default: 'RecipeVersion')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-recipeVersion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-recipeVersion" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'recipeVersion.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="rating" title="${message(code: 'recipeVersion.rating.label', default: 'Rating')}" />
					
						<g:sortableColumn property="feedback" title="${message(code: 'recipeVersion.feedback.label', default: 'Feedback')}" />
					
						<th><g:message code="recipeVersion.chef.label" default="Chef" /></th>
					
						<g:sortableColumn property="recipeStatus" title="${message(code: 'recipeVersion.recipeStatus.label', default: 'Recipe Status')}" />
					
						<g:sortableColumn property="comments" title="${message(code: 'recipeVersion.comments.label', default: 'Comments')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${recipeVersionInstanceList}" status="i" var="recipeVersionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${recipeVersionInstance.id}">${fieldValue(bean: recipeVersionInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: recipeVersionInstance, field: "rating")}</td>
					
						<td>${fieldValue(bean: recipeVersionInstance, field: "feedback")}</td>
					
						<td>${fieldValue(bean: recipeVersionInstance, field: "chef")}</td>
					
						<td>${fieldValue(bean: recipeVersionInstance, field: "recipeStatus")}</td>
					
						<td>${fieldValue(bean: recipeVersionInstance, field: "comments")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${recipeVersionInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
