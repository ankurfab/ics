
<%@ page import="ics.Objective" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'objective.label', default: 'Objective')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-objective" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-objective" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list objective">
			
				<g:if test="${objectiveInstance?.assignedBy}">
				<li class="fieldcontain">
					<span id="assignedBy-label" class="property-label"><g:message code="objective.assignedBy.label" default="Assigned By" /></span>
					
						<span class="property-value" aria-labelledby="assignedBy-label"><g:link controller="individual" action="show" id="${objectiveInstance?.assignedBy?.id}">${objectiveInstance?.assignedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${objectiveInstance?.assignedTo}">
				<li class="fieldcontain">
					<span id="assignedTo-label" class="property-label"><g:message code="objective.assignedTo.label" default="Assigned To" /></span>
					
						<span class="property-value" aria-labelledby="assignedTo-label"><g:link controller="individual" action="show" id="${objectiveInstance?.assignedTo?.id}">${objectiveInstance?.assignedTo?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${objectiveInstance?.category}">
				<li class="fieldcontain">
					<span id="category-label" class="property-label"><g:message code="objective.category.label" default="Category" /></span>
					
						<span class="property-value" aria-labelledby="category-label"><g:fieldValue bean="${objectiveInstance}" field="category"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${objectiveInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="objective.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${objectiveInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${objectiveInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="objective.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${objectiveInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${objectiveInstance?.objFrom}">
				<li class="fieldcontain">
					<span id="objFrom-label" class="property-label"><g:message code="objective.objFrom.label" default="Obj From" /></span>
					
						<span class="property-value" aria-labelledby="objFrom-label"><g:formatDate date="${objectiveInstance?.objFrom}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${objectiveInstance?.objTo}">
				<li class="fieldcontain">
					<span id="objTo-label" class="property-label"><g:message code="objective.objTo.label" default="Obj To" /></span>
					
						<span class="property-value" aria-labelledby="objTo-label"><g:formatDate date="${objectiveInstance?.objTo}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${objectiveInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="objective.comments.label" default="Comments" /></span>
					
						<span class="property-value" aria-labelledby="comments-label"><g:fieldValue bean="${objectiveInstance}" field="comments"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${objectiveInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="objective.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${objectiveInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${objectiveInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="objective.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${objectiveInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${objectiveInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="objective.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${objectiveInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${objectiveInstance?.updator}">
				<li class="fieldcontain">
					<span id="updator-label" class="property-label"><g:message code="objective.updator.label" default="Updator" /></span>
					
						<span class="property-value" aria-labelledby="updator-label"><g:fieldValue bean="${objectiveInstance}" field="updator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${objectiveInstance?.isComplete}">
				<li class="fieldcontain">
					<span id="isComplete-label" class="property-label"><g:message code="objective.isComplete.label" default="Is Complete" /></span>
					
						<span class="property-value" aria-labelledby="isComplete-label"><g:formatBoolean boolean="${objectiveInstance?.isComplete}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${objectiveInstance?.id}" />
					<g:link class="edit" action="edit" id="${objectiveInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
