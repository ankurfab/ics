
<%@ page import="ics.MenuItem" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'menuItem.label', default: 'MenuItem')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-menuItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-menuItem" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list menuItem">
			
				<g:if test="${menuItemInstance?.recipe}">
				<li class="fieldcontain">
					<span id="recipe-label" class="property-label"><g:message code="menuItem.recipe.label" default="Recipe" /></span>
					
						<span class="property-value" aria-labelledby="recipe-label"><g:link controller="recipeVersion" action="show" id="${menuItemInstance?.recipe?.id}">${menuItemInstance?.recipe?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuItemInstance?.oqty}">
				<li class="fieldcontain">
					<span id="oqty-label" class="property-label"><g:message code="menuItem.oqty.label" default="Oqty" /></span>
					
						<span class="property-value" aria-labelledby="oqty-label"><g:fieldValue bean="${menuItemInstance}" field="oqty"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuItemInstance?.ounit}">
				<li class="fieldcontain">
					<span id="ounit-label" class="property-label"><g:message code="menuItem.ounit.label" default="Ounit" /></span>
					
						<span class="property-value" aria-labelledby="ounit-label"><g:fieldValue bean="${menuItemInstance}" field="ounit"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuItemInstance?.yqty}">
				<li class="fieldcontain">
					<span id="yqty-label" class="property-label"><g:message code="menuItem.yqty.label" default="Yqty" /></span>
					
						<span class="property-value" aria-labelledby="yqty-label"><g:fieldValue bean="${menuItemInstance}" field="yqty"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuItemInstance?.yunit}">
				<li class="fieldcontain">
					<span id="yunit-label" class="property-label"><g:message code="menuItem.yunit.label" default="Yunit" /></span>
					
						<span class="property-value" aria-labelledby="yunit-label"><g:fieldValue bean="${menuItemInstance}" field="yunit"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuItemInstance?.sqty}">
				<li class="fieldcontain">
					<span id="sqty-label" class="property-label"><g:message code="menuItem.sqty.label" default="Sqty" /></span>
					
						<span class="property-value" aria-labelledby="sqty-label"><g:fieldValue bean="${menuItemInstance}" field="sqty"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuItemInstance?.sunit}">
				<li class="fieldcontain">
					<span id="sunit-label" class="property-label"><g:message code="menuItem.sunit.label" default="Sunit" /></span>
					
						<span class="property-value" aria-labelledby="sunit-label"><g:fieldValue bean="${menuItemInstance}" field="sunit"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuItemInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="menuItem.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${menuItemInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuItemInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="menuItem.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${menuItemInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuItemInstance?.updator}">
				<li class="fieldcontain">
					<span id="updator-label" class="property-label"><g:message code="menuItem.updator.label" default="Updator" /></span>
					
						<span class="property-value" aria-labelledby="updator-label"><g:fieldValue bean="${menuItemInstance}" field="updator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuItemInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="menuItem.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${menuItemInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuItemInstance?.menu}">
				<li class="fieldcontain">
					<span id="menu-label" class="property-label"><g:message code="menuItem.menu.label" default="Menu" /></span>
					
						<span class="property-value" aria-labelledby="menu-label"><g:link controller="menu" action="show" id="${menuItemInstance?.menu?.id}">${menuItemInstance?.menu?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${menuItemInstance?.id}" />
					<g:link class="edit" action="edit" id="${menuItemInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
