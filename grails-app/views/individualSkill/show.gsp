
<%@ page import="ics.IndividualSkill" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'individualSkill.label', default: 'IndividualSkill')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-individualSkill" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-individualSkill" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list individualSkill">
			
				<g:if test="${individualSkillInstance?.individual}">
				<li class="fieldcontain">
					<span id="individual-label" class="property-label"><g:message code="individualSkill.individual.label" default="Individual" /></span>
					
						<span class="property-value" aria-labelledby="individual-label"><g:link controller="individual" action="show" id="${individualSkillInstance?.individual?.id}">${individualSkillInstance?.individual?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualSkillInstance?.skill}">
				<li class="fieldcontain">
					<span id="skill-label" class="property-label"><g:message code="individualSkill.skill.label" default="Skill" /></span>
					
						<span class="property-value" aria-labelledby="skill-label"><g:link controller="skill" action="show" id="${individualSkillInstance?.skill?.id}">${individualSkillInstance?.skill?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualSkillInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="individualSkill.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${individualSkillInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualSkillInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="individualSkill.comments.label" default="Comments" /></span>
					
						<span class="property-value" aria-labelledby="comments-label"><g:fieldValue bean="${individualSkillInstance}" field="comments"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${individualSkillInstance?.id}" />
					<g:link class="edit" action="edit" id="${individualSkillInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
