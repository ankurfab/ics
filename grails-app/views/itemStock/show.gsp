
<%@ page import="ics.ItemStock" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'itemStock.label', default: 'ItemStock')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-itemStock" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-itemStock" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list itemStock">
			
				<g:if test="${itemStockInstance?.supplementedBy}">
				<li class="fieldcontain">
					<span id="supplementedBy-label" class="property-label"><g:message code="itemStock.supplementedBy.label" default="Supplemented By" /></span>
					
						<span class="property-value" aria-labelledby="supplementedBy-label"><g:link controller="person" action="show" id="${itemStockInstance?.supplementedBy?.id}">${itemStockInstance?.supplementedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemStockInstance?.consumedBy}">
				<li class="fieldcontain">
					<span id="consumedBy-label" class="property-label"><g:message code="itemStock.consumedBy.label" default="Consumed By" /></span>
					
						<span class="property-value" aria-labelledby="consumedBy-label"><g:link controller="person" action="show" id="${itemStockInstance?.consumedBy?.id}">${itemStockInstance?.consumedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemStockInstance?.auditedBy}">
				<li class="fieldcontain">
					<span id="auditedBy-label" class="property-label"><g:message code="itemStock.auditedBy.label" default="Audited By" /></span>
					
						<span class="property-value" aria-labelledby="auditedBy-label"><g:link controller="person" action="show" id="${itemStockInstance?.auditedBy?.id}">${itemStockInstance?.auditedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemStockInstance?.itemCounts}">
				<li class="fieldcontain">
					<span id="itemCounts-label" class="property-label"><g:message code="itemStock.itemCounts.label" default="Item Counts" /></span>
					
						<g:each in="${itemStockInstance.itemCounts}" var="i">
						<span class="property-value" aria-labelledby="itemCounts-label"><g:link controller="itemCount" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${itemStockInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="itemStock.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${itemStockInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemStockInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="itemStock.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${itemStockInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemStockInstance?.updator}">
				<li class="fieldcontain">
					<span id="updator-label" class="property-label"><g:message code="itemStock.updator.label" default="Updator" /></span>
					
						<span class="property-value" aria-labelledby="updator-label"><g:fieldValue bean="${itemStockInstance}" field="updator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemStockInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="itemStock.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${itemStockInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemStockInstance?.department}">
				<li class="fieldcontain">
					<span id="department-label" class="property-label"><g:message code="itemStock.department.label" default="Department" /></span>
					
						<span class="property-value" aria-labelledby="department-label"><g:link controller="department" action="show" id="${itemStockInstance?.department?.id}">${itemStockInstance?.department?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${itemStockInstance?.id}" />
					<g:link class="edit" action="edit" id="${itemStockInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
