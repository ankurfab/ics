
<%@ page import="ics.MenuItem" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'menuItem.label', default: 'MenuItem')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-menuItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-menuItem" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="menuItem.recipe.label" default="Recipe" /></th>
					
						<g:sortableColumn property="oqty" title="${message(code: 'menuItem.oqty.label', default: 'Oqty')}" />
					
						<g:sortableColumn property="ounit" title="${message(code: 'menuItem.ounit.label', default: 'Ounit')}" />
					
						<g:sortableColumn property="yqty" title="${message(code: 'menuItem.yqty.label', default: 'Yqty')}" />
					
						<g:sortableColumn property="yunit" title="${message(code: 'menuItem.yunit.label', default: 'Yunit')}" />
					
						<g:sortableColumn property="sqty" title="${message(code: 'menuItem.sqty.label', default: 'Sqty')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${menuItemInstanceList}" status="i" var="menuItemInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${menuItemInstance.id}">${fieldValue(bean: menuItemInstance, field: "recipe")}</g:link></td>
					
						<td>${fieldValue(bean: menuItemInstance, field: "oqty")}</td>
					
						<td>${fieldValue(bean: menuItemInstance, field: "ounit")}</td>
					
						<td>${fieldValue(bean: menuItemInstance, field: "yqty")}</td>
					
						<td>${fieldValue(bean: menuItemInstance, field: "yunit")}</td>
					
						<td>${fieldValue(bean: menuItemInstance, field: "sqty")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${menuItemInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
