
<%@ page import="ics.Seva" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'seva.label', default: 'Seva')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-seva" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-seva" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list seva">
			
				<g:if test="${sevaInstance?.category}">
				<li class="fieldcontain">
					<span id="category-label" class="property-label"><g:message code="seva.category.label" default="Category" /></span>
					
						<span class="property-value" aria-labelledby="category-label"><g:fieldValue bean="${sevaInstance}" field="category"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sevaInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="seva.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${sevaInstance}" field="type"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sevaInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="seva.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${sevaInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sevaInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="seva.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${sevaInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sevaInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="seva.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${sevaInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sevaInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="seva.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${sevaInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${sevaInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="seva.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${sevaInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${sevaInstance?.updator}">
				<li class="fieldcontain">
					<span id="updator-label" class="property-label"><g:message code="seva.updator.label" default="Updator" /></span>
					
						<span class="property-value" aria-labelledby="updator-label"><g:fieldValue bean="${sevaInstance}" field="updator"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${sevaInstance?.id}" />
					<g:link class="edit" action="edit" id="${sevaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
