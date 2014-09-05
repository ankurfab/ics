
<%@ page import="ics.BookRead" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'bookRead.label', default: 'BookRead')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-bookRead" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-bookRead" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list bookRead">
			
				<g:if test="${bookReadInstance?.individual}">
				<li class="fieldcontain">
					<span id="individual-label" class="property-label"><g:message code="bookRead.individual.label" default="Individual" /></span>
					
						<span class="property-value" aria-labelledby="individual-label"><g:link controller="individual" action="show" id="${bookReadInstance?.individual?.id}">${bookReadInstance?.individual?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${bookReadInstance?.book}">
				<li class="fieldcontain">
					<span id="book-label" class="property-label"><g:message code="bookRead.book.label" default="Book" /></span>
					
						<span class="property-value" aria-labelledby="book-label"><g:link controller="book" action="show" id="${bookReadInstance?.book?.id}">${bookReadInstance?.book?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${bookReadInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="bookRead.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${bookReadInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bookReadInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="bookRead.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${bookReadInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${bookReadInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="bookRead.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${bookReadInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${bookReadInstance?.updator}">
				<li class="fieldcontain">
					<span id="updator-label" class="property-label"><g:message code="bookRead.updator.label" default="Updator" /></span>
					
						<span class="property-value" aria-labelledby="updator-label"><g:fieldValue bean="${bookReadInstance}" field="updator"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${bookReadInstance?.id}" />
					<g:link class="edit" action="edit" id="${bookReadInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
