
<%@ page import="ics.RecipeVersion" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'recipeVersion.label', default: 'RecipeVersion')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-recipeVersion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-recipeVersion" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list recipeVersion">
			
				<g:if test="${recipeVersionInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="recipeVersion.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${recipeVersionInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeVersionInstance?.rating}">
				<li class="fieldcontain">
					<span id="rating-label" class="property-label"><g:message code="recipeVersion.rating.label" default="Rating" /></span>
					
						<span class="property-value" aria-labelledby="rating-label"><g:fieldValue bean="${recipeVersionInstance}" field="rating"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeVersionInstance?.feedback}">
				<li class="fieldcontain">
					<span id="feedback-label" class="property-label"><g:message code="recipeVersion.feedback.label" default="Feedback" /></span>
					
						<span class="property-value" aria-labelledby="feedback-label"><g:fieldValue bean="${recipeVersionInstance}" field="feedback"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeVersionInstance?.chef}">
				<li class="fieldcontain">
					<span id="chef-label" class="property-label"><g:message code="recipeVersion.chef.label" default="Chef" /></span>
					
						<span class="property-value" aria-labelledby="chef-label"><g:link controller="person" action="show" id="${recipeVersionInstance?.chef?.id}">${recipeVersionInstance?.chef?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeVersionInstance?.recipeStatus}">
				<li class="fieldcontain">
					<span id="recipeStatus-label" class="property-label"><g:message code="recipeVersion.recipeStatus.label" default="Recipe Status" /></span>
					
						<span class="property-value" aria-labelledby="recipeStatus-label"><g:fieldValue bean="${recipeVersionInstance}" field="recipeStatus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeVersionInstance?.serves}">
				<li class="fieldcontain">
					<span id="serves-label" class="property-label"><g:message code="recipeVersion.serves.label" default="Serves" /></span>
					
						<g:each in="${recipeVersionInstance.serves}" var="s">
						<span class="property-value" aria-labelledby="serves-label"><g:link controller="personCount" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${recipeVersionInstance?.yield}">
				<li class="fieldcontain">
					<span id="yield-label" class="property-label"><g:message code="recipeVersion.yield.label" default="Yield" /></span>
					
						<span class="property-value" aria-labelledby="yield-label"><g:fieldValue bean="${recipeVersionInstance}" field="yield"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeVersionInstance?.yieldUnit}">
				<li class="fieldcontain">
					<span id="yieldUnit-label" class="property-label"><g:message code="recipeVersion.yieldUnit.label" default="Yield Unit" /></span>
					
						<span class="property-value" aria-labelledby="yieldUnit-label"><g:fieldValue bean="${recipeVersionInstance}" field="yieldUnit"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeVersionInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="recipeVersion.comments.label" default="Comments" /></span>
					
						<span class="property-value" aria-labelledby="comments-label"><g:fieldValue bean="${recipeVersionInstance}" field="comments"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeVersionInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="recipeVersion.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${recipeVersionInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeVersionInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="recipeVersion.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${recipeVersionInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeVersionInstance?.updator}">
				<li class="fieldcontain">
					<span id="updator-label" class="property-label"><g:message code="recipeVersion.updator.label" default="Updator" /></span>
					
						<span class="property-value" aria-labelledby="updator-label"><g:fieldValue bean="${recipeVersionInstance}" field="updator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeVersionInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="recipeVersion.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${recipeVersionInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${recipeVersionInstance?.instructionGroup}">
				<li class="fieldcontain">
					<span id="instructionGroup-label" class="property-label"><g:message code="recipeVersion.instructionGroup.label" default="Instruction Group" /></span>
					
						<g:each in="${recipeVersionInstance.instructionGroup}" var="i">
						<span class="property-value" aria-labelledby="instructionGroup-label"><g:link controller="instructionGroup" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${recipeVersionInstance?.recipe}">
				<li class="fieldcontain">
					<span id="recipe-label" class="property-label"><g:message code="recipeVersion.recipe.label" default="Recipe" /></span>
					
						<span class="property-value" aria-labelledby="recipe-label"><g:link controller="recipe" action="show" id="${recipeVersionInstance?.recipe?.id}">${recipeVersionInstance?.recipe?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${recipeVersionInstance?.id}" />
					<g:link class="edit" action="edit" id="${recipeVersionInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
