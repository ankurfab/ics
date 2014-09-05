
<%@ page import="ics.Skill" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'skill.label', default: 'Skill')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-skill" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="category" title="${message(code: 'skill.category.label', default: 'Category')}" />
					
						<g:sortableColumn property="type" title="${message(code: 'skill.type.label', default: 'Type')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'skill.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'skill.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="creator" title="${message(code: 'skill.creator.label', default: 'Creator')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'skill.dateCreated.label', default: 'Date Created')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${skillInstanceList}" status="i" var="skillInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${skillInstance.id}">${fieldValue(bean: skillInstance, field: "category")}</g:link></td>
					
						<td>${fieldValue(bean: skillInstance, field: "type")}</td>
					
						<td>${fieldValue(bean: skillInstance, field: "name")}</td>
					
						<td>${fieldValue(bean: skillInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: skillInstance, field: "creator")}</td>
					
						<td><g:formatDate date="${skillInstance.dateCreated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${skillInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
