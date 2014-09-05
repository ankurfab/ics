
<%@ page import="ics.Recipe" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'recipe.label', default: 'Recipe')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-recipe" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-recipe" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list recipe">
			
				<g:if test="${recipeInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="recipe.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${recipeInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeInstance?.recipeVersions}">
				<li class="fieldcontain">
					<span id="recipeVersions-label" class="property-label"><g:message code="recipe.recipeVersions.label" default="Recipe Versions" /></span>
					
						<g:each in="${recipeInstance.recipeVersions}" var="r">
						<span class="property-value" aria-labelledby="recipeVersions-label"><g:link controller="recipeVersion" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${recipeInstance?.cuisine}">
				<li class="fieldcontain">
					<span id="cuisine-label" class="property-label"><g:message code="recipe.cuisine.label" default="Cuisine" /></span>
					
						<span class="property-value" aria-labelledby="cuisine-label"><g:fieldValue bean="${recipeInstance}" field="cuisine"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeInstance?.category}">
				<li class="fieldcontain">
					<span id="category-label" class="property-label"><g:message code="recipe.category.label" default="Category" /></span>
					
						<span class="property-value" aria-labelledby="category-label"><g:fieldValue bean="${recipeInstance}" field="category"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeInstance?.spicy}">
				<li class="fieldcontain">
					<span id="spicy-label" class="property-label"><g:message code="recipe.spicy.label" default="Spicy" /></span>
					
						<span class="property-value" aria-labelledby="spicy-label"><g:fieldValue bean="${recipeInstance}" field="spicy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeInstance?.healthy}">
				<li class="fieldcontain">
					<span id="healthy-label" class="property-label"><g:message code="recipe.healthy.label" default="Healthy" /></span>
					
						<span class="property-value" aria-labelledby="healthy-label"><g:fieldValue bean="${recipeInstance}" field="healthy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeInstance?.economical}">
				<li class="fieldcontain">
					<span id="economical-label" class="property-label"><g:message code="recipe.economical.label" default="Economical" /></span>
					
						<span class="property-value" aria-labelledby="economical-label"><g:fieldValue bean="${recipeInstance}" field="economical"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeInstance?.preprationtime}">
				<li class="fieldcontain">
					<span id="preprationtime-label" class="property-label"><g:message code="recipe.preprationtime.label" default="Preprationtime" /></span>
					
						<span class="property-value" aria-labelledby="preprationtime-label"><g:fieldValue bean="${recipeInstance}" field="preprationtime"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeInstance?.shelflife}">
				<li class="fieldcontain">
					<span id="shelflife-label" class="property-label"><g:message code="recipe.shelflife.label" default="Shelflife" /></span>
					
						<span class="property-value" aria-labelledby="shelflife-label"><g:fieldValue bean="${recipeInstance}" field="shelflife"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeInstance?.rating}">
				<li class="fieldcontain">
					<span id="rating-label" class="property-label"><g:message code="recipe.rating.label" default="Rating" /></span>
					
						<span class="property-value" aria-labelledby="rating-label"><g:fieldValue bean="${recipeInstance}" field="rating"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeInstance?.feedback}">
				<li class="fieldcontain">
					<span id="feedback-label" class="property-label"><g:message code="recipe.feedback.label" default="Feedback" /></span>
					
						<span class="property-value" aria-labelledby="feedback-label"><g:fieldValue bean="${recipeInstance}" field="feedback"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="recipe.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${recipeInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="recipe.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${recipeInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeInstance?.updator}">
				<li class="fieldcontain">
					<span id="updator-label" class="property-label"><g:message code="recipe.updator.label" default="Updator" /></span>
					
						<span class="property-value" aria-labelledby="updator-label"><g:fieldValue bean="${recipeInstance}" field="updator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="recipe.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${recipeInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${recipeInstance?.id}" />
					<g:link class="edit" action="edit" id="${recipeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
