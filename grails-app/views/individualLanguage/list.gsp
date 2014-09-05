
<%@ page import="ics.IndividualLanguage" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'individualLanguage.label', default: 'IndividualLanguage')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-individualLanguage" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-individualLanguage" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="creator" title="${message(code: 'individualLanguage.creator.label', default: 'Creator')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'individualLanguage.dateCreated.label', default: 'Date Created')}" />
					
						<th><g:message code="individualLanguage.individual.label" default="Individual" /></th>
					
						<th><g:message code="individualLanguage.language.label" default="Language" /></th>
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'individualLanguage.lastUpdated.label', default: 'Last Updated')}" />
					
						<g:sortableColumn property="motherTongue" title="${message(code: 'individualLanguage.motherTongue.label', default: 'Mother Tongue')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${individualLanguageInstanceList}" status="i" var="individualLanguageInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${individualLanguageInstance.id}">${fieldValue(bean: individualLanguageInstance, field: "creator")}</g:link></td>
					
						<td><g:formatDate date="${individualLanguageInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: individualLanguageInstance, field: "individual")}</td>
					
						<td>${fieldValue(bean: individualLanguageInstance, field: "language")}</td>
					
						<td><g:formatDate date="${individualLanguageInstance.lastUpdated}" /></td>
					
						<td><g:formatBoolean boolean="${individualLanguageInstance.motherTongue}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${individualLanguageInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
