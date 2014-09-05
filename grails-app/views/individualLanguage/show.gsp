
<%@ page import="ics.IndividualLanguage" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'individualLanguage.label', default: 'IndividualLanguage')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-individualLanguage" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-individualLanguage" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list individualLanguage">
			
				<g:if test="${individualLanguageInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="individualLanguage.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${individualLanguageInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualLanguageInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="individualLanguage.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${individualLanguageInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualLanguageInstance?.individual}">
				<li class="fieldcontain">
					<span id="individual-label" class="property-label"><g:message code="individualLanguage.individual.label" default="Individual" /></span>
					
						<span class="property-value" aria-labelledby="individual-label"><g:link controller="individual" action="show" id="${individualLanguageInstance?.individual?.id}">${individualLanguageInstance?.individual?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualLanguageInstance?.language}">
				<li class="fieldcontain">
					<span id="language-label" class="property-label"><g:message code="individualLanguage.language.label" default="Language" /></span>
					
						<span class="property-value" aria-labelledby="language-label"><g:link controller="language" action="show" id="${individualLanguageInstance?.language?.id}">${individualLanguageInstance?.language?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualLanguageInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="individualLanguage.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${individualLanguageInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualLanguageInstance?.motherTongue}">
				<li class="fieldcontain">
					<span id="motherTongue-label" class="property-label"><g:message code="individualLanguage.motherTongue.label" default="Mother Tongue" /></span>
					
						<span class="property-value" aria-labelledby="motherTongue-label"><g:formatBoolean boolean="${individualLanguageInstance?.motherTongue}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualLanguageInstance?.readFluency}">
				<li class="fieldcontain">
					<span id="readFluency-label" class="property-label"><g:message code="individualLanguage.readFluency.label" default="Read Fluency" /></span>
					
						<span class="property-value" aria-labelledby="readFluency-label"><g:fieldValue bean="${individualLanguageInstance}" field="readFluency"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualLanguageInstance?.updator}">
				<li class="fieldcontain">
					<span id="updator-label" class="property-label"><g:message code="individualLanguage.updator.label" default="Updator" /></span>
					
						<span class="property-value" aria-labelledby="updator-label"><g:fieldValue bean="${individualLanguageInstance}" field="updator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${individualLanguageInstance?.writeFluency}">
				<li class="fieldcontain">
					<span id="writeFluency-label" class="property-label"><g:message code="individualLanguage.writeFluency.label" default="Write Fluency" /></span>
					
						<span class="property-value" aria-labelledby="writeFluency-label"><g:fieldValue bean="${individualLanguageInstance}" field="writeFluency"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${individualLanguageInstance?.id}" />
					<g:link class="edit" action="edit" id="${individualLanguageInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
