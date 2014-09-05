
<%@ page import="ics.Journey" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'journey.label', default: 'Journey')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-journey" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-journey" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list journey">
			
				<g:if test="${journeyInstance?.arrival}">
				<li class="fieldcontain">
					<span id="arrival-label" class="property-label"><g:message code="journey.arrival.label" default="Arrival" /></span>
					
						<span class="property-value" aria-labelledby="arrival-label"><g:formatBoolean boolean="${journeyInstance?.arrival}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${journeyInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="journey.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${journeyInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${journeyInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="journey.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${journeyInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${journeyInstance?.eventRegistration}">
				<li class="fieldcontain">
					<span id="eventRegistration-label" class="property-label"><g:message code="journey.eventRegistration.label" default="Event Registration" /></span>
					
						<span class="property-value" aria-labelledby="eventRegistration-label"><g:link controller="eventRegistration" action="show" id="${journeyInstance?.eventRegistration?.id}">${journeyInstance?.eventRegistration?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${journeyInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="journey.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${journeyInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${journeyInstance?.location}">
				<li class="fieldcontain">
					<span id="location-label" class="property-label"><g:message code="journey.location.label" default="Location" /></span>
					
						<span class="property-value" aria-labelledby="location-label"><g:fieldValue bean="${journeyInstance}" field="location"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${journeyInstance?.mode}">
				<li class="fieldcontain">
					<span id="mode-label" class="property-label"><g:message code="journey.mode.label" default="Mode" /></span>
					
						<span class="property-value" aria-labelledby="mode-label"><g:fieldValue bean="${journeyInstance}" field="mode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${journeyInstance?.modeComments}">
				<li class="fieldcontain">
					<span id="modeComments-label" class="property-label"><g:message code="journey.modeComments.label" default="Mode Comments" /></span>
					
						<span class="property-value" aria-labelledby="modeComments-label"><g:fieldValue bean="${journeyInstance}" field="modeComments"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${journeyInstance?.modeDateTime}">
				<li class="fieldcontain">
					<span id="modeDateTime-label" class="property-label"><g:message code="journey.modeDateTime.label" default="Mode Date Time" /></span>
					
						<span class="property-value" aria-labelledby="modeDateTime-label"><g:formatDate date="${journeyInstance?.modeDateTime}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${journeyInstance?.modeDetail}">
				<li class="fieldcontain">
					<span id="modeDetail-label" class="property-label"><g:message code="journey.modeDetail.label" default="Mode Detail" /></span>
					
						<span class="property-value" aria-labelledby="modeDetail-label"><g:fieldValue bean="${journeyInstance}" field="modeDetail"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${journeyInstance?.numChildGuest}">
				<li class="fieldcontain">
					<span id="numChildGuest-label" class="property-label"><g:message code="journey.numChildGuest.label" default="Num Child Guest" /></span>
					
						<span class="property-value" aria-labelledby="numChildGuest-label"><g:fieldValue bean="${journeyInstance}" field="numChildGuest"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${journeyInstance?.numChildPrasadam}">
				<li class="fieldcontain">
					<span id="numChildPrasadam-label" class="property-label"><g:message code="journey.numChildPrasadam.label" default="Num Child Prasadam" /></span>
					
						<span class="property-value" aria-labelledby="numChildPrasadam-label"><g:fieldValue bean="${journeyInstance}" field="numChildPrasadam"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${journeyInstance?.numMatajiGuest}">
				<li class="fieldcontain">
					<span id="numMatajiGuest-label" class="property-label"><g:message code="journey.numMatajiGuest.label" default="Num Mataji Guest" /></span>
					
						<span class="property-value" aria-labelledby="numMatajiGuest-label"><g:fieldValue bean="${journeyInstance}" field="numMatajiGuest"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${journeyInstance?.numMatajiPrasadam}">
				<li class="fieldcontain">
					<span id="numMatajiPrasadam-label" class="property-label"><g:message code="journey.numMatajiPrasadam.label" default="Num Mataji Prasadam" /></span>
					
						<span class="property-value" aria-labelledby="numMatajiPrasadam-label"><g:fieldValue bean="${journeyInstance}" field="numMatajiPrasadam"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${journeyInstance?.numPrjiGuest}">
				<li class="fieldcontain">
					<span id="numPrjiGuest-label" class="property-label"><g:message code="journey.numPrjiGuest.label" default="Num Prji Guest" /></span>
					
						<span class="property-value" aria-labelledby="numPrjiGuest-label"><g:fieldValue bean="${journeyInstance}" field="numPrjiGuest"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${journeyInstance?.numPrjiPrasadam}">
				<li class="fieldcontain">
					<span id="numPrjiPrasadam-label" class="property-label"><g:message code="journey.numPrjiPrasadam.label" default="Num Prji Prasadam" /></span>
					
						<span class="property-value" aria-labelledby="numPrjiPrasadam-label"><g:fieldValue bean="${journeyInstance}" field="numPrjiPrasadam"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${journeyInstance?.updator}">
				<li class="fieldcontain">
					<span id="updator-label" class="property-label"><g:message code="journey.updator.label" default="Updator" /></span>
					
						<span class="property-value" aria-labelledby="updator-label"><g:fieldValue bean="${journeyInstance}" field="updator"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${journeyInstance?.id}" />
					<g:link class="edit" action="edit" id="${journeyInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
