
<%@ page import="ics.ItemCount" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'itemCount.label', default: 'ItemCount')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-itemCount" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-itemCount" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="itemCount.item.label" default="Item" /></th>
					
						<g:sortableColumn property="qty" title="${message(code: 'itemCount.qty.label', default: 'Qty')}" />
					
						<g:sortableColumn property="unit" title="${message(code: 'itemCount.unit.label', default: 'Unit')}" />
					
						<g:sortableColumn property="rate" title="${message(code: 'itemCount.rate.label', default: 'Rate')}" />
					
						<g:sortableColumn property="nqty" title="${message(code: 'itemCount.nqty.label', default: 'Nqty')}" />
					
						<g:sortableColumn property="nunit" title="${message(code: 'itemCount.nunit.label', default: 'Nunit')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${itemCountInstanceList}" status="i" var="itemCountInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${itemCountInstance.id}">${fieldValue(bean: itemCountInstance, field: "item")}</g:link></td>
					
						<td>${fieldValue(bean: itemCountInstance, field: "qty")}</td>
					
						<td>${fieldValue(bean: itemCountInstance, field: "unit")}</td>
					
						<td>${fieldValue(bean: itemCountInstance, field: "rate")}</td>
					
						<td>${fieldValue(bean: itemCountInstance, field: "nqty")}</td>
					
						<td>${fieldValue(bean: itemCountInstance, field: "nunit")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${itemCountInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
