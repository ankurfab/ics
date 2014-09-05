
<%@ page import="ics.IndividualCentre" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'individualCentre.label', default: 'IndividualCentre')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-individualCentre" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-individualCentre" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list individualCentre">
			
				<g:if test="${individualCentreInstance?.individual}">
				<li class="fieldcontain">
					<span id="individual-label" class="property-label"><g:message code="individualCentre.individual.label" default="Individual" /></span>
					
						<span class="property-value" aria-labelledby="individual-label"><g:link controller="individual" action="show" id="${individualCentreInstance?.individual?.id}">${individualCentreInstance?.individual?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualCentreInstance?.centre}">
				<li class="fieldcontain">
					<span id="centre-label" class="property-label"><g:message code="individualCentre.centre.label" default="Centre" /></span>
					
						<span class="property-value" aria-labelledby="centre-label"><g:link controller="centre" action="show" id="${individualCentreInstance?.centre?.id}">${individualCentreInstance?.centre?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualCentreInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="individualCentre.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${individualCentreInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualCentreInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="individualCentre.comments.label" default="Comments" /></span>
					
						<span class="property-value" aria-labelledby="comments-label"><g:fieldValue bean="${individualCentreInstance}" field="comments"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualCentreInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="individualCentre.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${individualCentreInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualCentreInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="individualCentre.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${individualCentreInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualCentreInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="individualCentre.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${individualCentreInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualCentreInstance?.updator}">
				<li class="fieldcontain">
					<span id="updator-label" class="property-label"><g:message code="individualCentre.updator.label" default="Updator" /></span>
					
						<span class="property-value" aria-labelledby="updator-label"><g:fieldValue bean="${individualCentreInstance}" field="updator"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${individualCentreInstance?.id}" />
					<g:link class="edit" action="edit" id="${individualCentreInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
