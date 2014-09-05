
<%@ page import="ics.IndividualSkill" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'individualSkill.label', default: 'IndividualSkill')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-individualSkill" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-individualSkill" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="individualSkill.individual.label" default="Individual" /></th>
					
						<th><g:message code="individualSkill.skill.label" default="Skill" /></th>
					
						<g:sortableColumn property="status" title="${message(code: 'individualSkill.status.label', default: 'Status')}" />
					
						<g:sortableColumn property="comments" title="${message(code: 'individualSkill.comments.label', default: 'Comments')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${individualSkillInstanceList}" status="i" var="individualSkillInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${individualSkillInstance.id}">${fieldValue(bean: individualSkillInstance, field: "individual")}</g:link></td>
					
						<td>${fieldValue(bean: individualSkillInstance, field: "skill")}</td>
					
						<td>${fieldValue(bean: individualSkillInstance, field: "status")}</td>
					
						<td>${fieldValue(bean: individualSkillInstance, field: "comments")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${individualSkillInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
