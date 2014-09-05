
<%@ page import="ics.ItemType" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'itemType.label', default: 'ItemType')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-itemType" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-itemType" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="type" title="${message(code: 'itemType.type.label', default: 'Type')}" />
					
						<g:sortableColumn property="creator" title="${message(code: 'itemType.creator.label', default: 'Creator')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'itemType.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="updator" title="${message(code: 'itemType.updator.label', default: 'Updator')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'itemType.lastUpdated.label', default: 'Last Updated')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${itemTypeInstanceList}" status="i" var="itemTypeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${itemTypeInstance.id}">${fieldValue(bean: itemTypeInstance, field: "type")}</g:link></td>
					
						<td>${fieldValue(bean: itemTypeInstance, field: "creator")}</td>
					
						<td><g:formatDate date="${itemTypeInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: itemTypeInstance, field: "updator")}</td>
					
						<td><g:formatDate date="${itemTypeInstance.lastUpdated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${itemTypeInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
