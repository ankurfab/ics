
<%@ page import="ics.IndividualSeva" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'individualSeva.label', default: 'IndividualSeva')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-individualSeva" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-individualSeva" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list individualSeva">
			
				<g:if test="${individualSevaInstance?.individual}">
				<li class="fieldcontain">
					<span id="individual-label" class="property-label"><g:message code="individualSeva.individual.label" default="Individual" /></span>
					
						<span class="property-value" aria-labelledby="individual-label"><g:link controller="individual" action="show" id="${individualSevaInstance?.individual?.id}">${individualSevaInstance?.individual?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualSevaInstance?.seva}">
				<li class="fieldcontain">
					<span id="seva-label" class="property-label"><g:message code="individualSeva.seva.label" default="Seva" /></span>
					
						<span class="property-value" aria-labelledby="seva-label"><g:link controller="seva" action="show" id="${individualSevaInstance?.seva?.id}">${individualSevaInstance?.seva?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualSevaInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="individualSeva.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${individualSevaInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualSevaInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="individualSeva.comments.label" default="Comments" /></span>
					
						<span class="property-value" aria-labelledby="comments-label"><g:fieldValue bean="${individualSevaInstance}" field="comments"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${individualSevaInstance?.id}" />
					<g:link class="edit" action="edit" id="${individualSevaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
