
<%@ page import="ics.MenuOrder" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'menuOrder.label', default: 'MenuOrder')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-menuOrder" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-menuOrder" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list menuOrder">
			
				<g:if test="${menuOrderInstance?.orderDate}">
				<li class="fieldcontain">
					<span id="orderDate-label" class="property-label"><g:message code="menuOrder.orderDate.label" default="Order Date" /></span>
					
						<span class="property-value" aria-labelledby="orderDate-label"><g:formatDate date="${menuOrderInstance?.orderDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuOrderInstance?.requestedBy}">
				<li class="fieldcontain">
					<span id="requestedBy-label" class="property-label"><g:message code="menuOrder.requestedBy.label" default="Requested By" /></span>
					
						<span class="property-value" aria-labelledby="requestedBy-label"><g:link controller="person" action="show" id="${menuOrderInstance?.requestedBy?.id}">${menuOrderInstance?.requestedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuOrderInstance?.acceptedBy}">
				<li class="fieldcontain">
					<span id="acceptedBy-label" class="property-label"><g:message code="menuOrder.acceptedBy.label" default="Accepted By" /></span>
					
						<span class="property-value" aria-labelledby="acceptedBy-label"><g:link controller="person" action="show" id="${menuOrderInstance?.acceptedBy?.id}">${menuOrderInstance?.acceptedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuOrderInstance?.menuChart}">
				<li class="fieldcontain">
					<span id="menuChart-label" class="property-label"><g:message code="menuOrder.menuChart.label" default="Menu Chart" /></span>
					
						<span class="property-value" aria-labelledby="menuChart-label"><g:link controller="menuChart" action="show" id="${menuOrderInstance?.menuChart?.id}">${menuOrderInstance?.menuChart?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuOrderInstance?.estimatedOrderValue}">
				<li class="fieldcontain">
					<span id="estimatedOrderValue-label" class="property-label"><g:message code="menuOrder.estimatedOrderValue.label" default="Estimated Order Value" /></span>
					
						<span class="property-value" aria-labelledby="estimatedOrderValue-label"><g:fieldValue bean="${menuOrderInstance}" field="estimatedOrderValue"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuOrderInstance?.actualOrderValue}">
				<li class="fieldcontain">
					<span id="actualOrderValue-label" class="property-label"><g:message code="menuOrder.actualOrderValue.label" default="Actual Order Value" /></span>
					
						<span class="property-value" aria-labelledby="actualOrderValue-label"><g:fieldValue bean="${menuOrderInstance}" field="actualOrderValue"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuOrderInstance?.invoicedOrderValue}">
				<li class="fieldcontain">
					<span id="invoicedOrderValue-label" class="property-label"><g:message code="menuOrder.invoicedOrderValue.label" default="Invoiced Order Value" /></span>
					
						<span class="property-value" aria-labelledby="invoicedOrderValue-label"><g:fieldValue bean="${menuOrderInstance}" field="invoicedOrderValue"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuOrderInstance?.advance}">
				<li class="fieldcontain">
					<span id="advance-label" class="property-label"><g:message code="menuOrder.advance.label" default="Advance" /></span>
					
						<span class="property-value" aria-labelledby="advance-label"><g:fieldValue bean="${menuOrderInstance}" field="advance"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuOrderInstance?.invoiceRef}">
				<li class="fieldcontain">
					<span id="invoiceRef-label" class="property-label"><g:message code="menuOrder.invoiceRef.label" default="Invoice Ref" /></span>
					
						<span class="property-value" aria-labelledby="invoiceRef-label"><g:fieldValue bean="${menuOrderInstance}" field="invoiceRef"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuOrderInstance?.invoiceDate}">
				<li class="fieldcontain">
					<span id="invoiceDate-label" class="property-label"><g:message code="menuOrder.invoiceDate.label" default="Invoice Date" /></span>
					
						<span class="property-value" aria-labelledby="invoiceDate-label"><g:formatDate date="${menuOrderInstance?.invoiceDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuOrderInstance?.settled}">
				<li class="fieldcontain">
					<span id="settled-label" class="property-label"><g:message code="menuOrder.settled.label" default="Settled" /></span>
					
						<span class="property-value" aria-labelledby="settled-label"><g:formatBoolean boolean="${menuOrderInstance?.settled}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuOrderInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="menuOrder.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${menuOrderInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuOrderInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="menuOrder.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${menuOrderInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuOrderInstance?.updator}">
				<li class="fieldcontain">
					<span id="updator-label" class="property-label"><g:message code="menuOrder.updator.label" default="Updator" /></span>
					
						<span class="property-value" aria-labelledby="updator-label"><g:fieldValue bean="${menuOrderInstance}" field="updator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuOrderInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="menuOrder.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${menuOrderInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${menuOrderInstance?.id}" />
					<g:link class="edit" action="edit" id="${menuOrderInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
