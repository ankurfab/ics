
<%@ page import="ics.ItemCategory" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'itemCategory.label', default: 'ItemCategory')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-itemCategory" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-itemCategory" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="category" title="${message(code: 'itemCategory.category.label', default: 'Category')}" />
					
						<g:sortableColumn property="creator" title="${message(code: 'itemCategory.creator.label', default: 'Creator')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'itemCategory.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="updator" title="${message(code: 'itemCategory.updator.label', default: 'Updator')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'itemCategory.lastUpdated.label', default: 'Last Updated')}" />
					
						<th><g:message code="itemCategory.itemType.label" default="Item Type" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${itemCategoryInstanceList}" status="i" var="itemCategoryInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${itemCategoryInstance.id}">${fieldValue(bean: itemCategoryInstance, field: "category")}</g:link></td>
					
						<td>${fieldValue(bean: itemCategoryInstance, field: "creator")}</td>
					
						<td><g:formatDate date="${itemCategoryInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: itemCategoryInstance, field: "updator")}</td>
					
						<td><g:formatDate date="${itemCategoryInstance.lastUpdated}" /></td>
					
						<td>${fieldValue(bean: itemCategoryInstance, field: "itemType")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${itemCategoryInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
