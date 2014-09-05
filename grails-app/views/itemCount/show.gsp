
<%@ page import="ics.ItemCount" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'itemCount.label', default: 'ItemCount')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-itemCount" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-itemCount" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list itemCount">
			
				<g:if test="${itemCountInstance?.item}">
				<li class="fieldcontain">
					<span id="item-label" class="property-label"><g:message code="itemCount.item.label" default="Item" /></span>
					
						<span class="property-value" aria-labelledby="item-label"><g:link controller="item" action="show" id="${itemCountInstance?.item?.id}">${itemCountInstance?.item?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemCountInstance?.qty}">
				<li class="fieldcontain">
					<span id="qty-label" class="property-label"><g:message code="itemCount.qty.label" default="Qty" /></span>
					
						<span class="property-value" aria-labelledby="qty-label"><g:fieldValue bean="${itemCountInstance}" field="qty"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemCountInstance?.unit}">
				<li class="fieldcontain">
					<span id="unit-label" class="property-label"><g:message code="itemCount.unit.label" default="Unit" /></span>
					
						<span class="property-value" aria-labelledby="unit-label"><g:fieldValue bean="${itemCountInstance}" field="unit"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemCountInstance?.rate}">
				<li class="fieldcontain">
					<span id="rate-label" class="property-label"><g:message code="itemCount.rate.label" default="Rate" /></span>
					
						<span class="property-value" aria-labelledby="rate-label"><g:fieldValue bean="${itemCountInstance}" field="rate"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemCountInstance?.nqty}">
				<li class="fieldcontain">
					<span id="nqty-label" class="property-label"><g:message code="itemCount.nqty.label" default="Nqty" /></span>
					
						<span class="property-value" aria-labelledby="nqty-label"><g:fieldValue bean="${itemCountInstance}" field="nqty"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemCountInstance?.nunit}">
				<li class="fieldcontain">
					<span id="nunit-label" class="property-label"><g:message code="itemCount.nunit.label" default="Nunit" /></span>
					
						<span class="property-value" aria-labelledby="nunit-label"><g:fieldValue bean="${itemCountInstance}" field="nunit"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemCountInstance?.nrate}">
				<li class="fieldcontain">
					<span id="nrate-label" class="property-label"><g:message code="itemCount.nrate.label" default="Nrate" /></span>
					
						<span class="property-value" aria-labelledby="nrate-label"><g:fieldValue bean="${itemCountInstance}" field="nrate"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemCountInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="itemCount.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${itemCountInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemCountInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="itemCount.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${itemCountInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemCountInstance?.updator}">
				<li class="fieldcontain">
					<span id="updator-label" class="property-label"><g:message code="itemCount.updator.label" default="Updator" /></span>
					
						<span class="property-value" aria-labelledby="updator-label"><g:fieldValue bean="${itemCountInstance}" field="updator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemCountInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="itemCount.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${itemCountInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemCountInstance?.instruction}">
				<li class="fieldcontain">
					<span id="instruction-label" class="property-label"><g:message code="itemCount.instruction.label" default="Instruction" /></span>
					
						<span class="property-value" aria-labelledby="instruction-label"><g:link controller="instruction" action="show" id="${itemCountInstance?.instruction?.id}">${itemCountInstance?.instruction?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${itemCountInstance?.id}" />
					<g:link class="edit" action="edit" id="${itemCountInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
