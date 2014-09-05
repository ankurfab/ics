
<%@ page import="ics.ItemCategory" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'itemCategory.label', default: 'ItemCategory')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-itemCategory" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-itemCategory" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list itemCategory">
			
				<g:if test="${itemCategoryInstance?.category}">
				<li class="fieldcontain">
					<span id="category-label" class="property-label"><g:message code="itemCategory.category.label" default="Category" /></span>
					
						<span class="property-value" aria-labelledby="category-label"><g:fieldValue bean="${itemCategoryInstance}" field="category"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemCategoryInstance?.items}">
				<li class="fieldcontain">
					<span id="items-label" class="property-label"><g:message code="itemCategory.items.label" default="Items" /></span>
					
						<g:each in="${itemCategoryInstance.items}" var="i">
						<span class="property-value" aria-labelledby="items-label"><g:link controller="item" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${itemCategoryInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="itemCategory.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${itemCategoryInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemCategoryInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="itemCategory.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${itemCategoryInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemCategoryInstance?.updator}">
				<li class="fieldcontain">
					<span id="updator-label" class="property-label"><g:message code="itemCategory.updator.label" default="Updator" /></span>
					
						<span class="property-value" aria-labelledby="updator-label"><g:fieldValue bean="${itemCategoryInstance}" field="updator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemCategoryInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="itemCategory.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${itemCategoryInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemCategoryInstance?.itemType}">
				<li class="fieldcontain">
					<span id="itemType-label" class="property-label"><g:message code="itemCategory.itemType.label" default="Item Type" /></span>
					
						<span class="property-value" aria-labelledby="itemType-label"><g:link controller="itemType" action="show" id="${itemCategoryInstance?.itemType?.id}">${itemCategoryInstance?.itemType?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${itemCategoryInstance?.id}" />
					<g:link class="edit" action="edit" id="${itemCategoryInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
