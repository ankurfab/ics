
<%@ page import="ics.MenuChart" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'menuChart.label', default: 'MenuChart')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-menuChart" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-menuChart" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="id" title="${message(code: 'menuChart.id.label', default: 'id')}" />
					
						<g:sortableColumn property="creator" title="${message(code: 'menuChart.creator.label', default: 'Creator')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'menuChart.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="updator" title="${message(code: 'menuChart.updator.label', default: 'Updator')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'menuChart.lastUpdated.label', default: 'Last Updated')}" />
					
						<g:sortableColumn property="chartName" title="${message(code: 'menuChart.chartName.label', default: 'Chart Name')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${menuChartInstanceList}" status="i" var="menuChartInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${menuChartInstance.id}">${fieldValue(bean: menuChartInstance, field: "creator")}</g:link></td>
					
						<td>${fieldValue(bean: menuChartInstance, field: "creator")}</td>

						<td><g:formatDate date="${menuChartInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: menuChartInstance, field: "updator")}</td>
					
						<td><g:formatDate date="${menuChartInstance.lastUpdated}" /></td>
					
						<td>${fieldValue(bean: menuChartInstance, field: "chartName")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${menuChartInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
