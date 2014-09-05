
<%@ page import="ics.Person" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-person" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-person" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list person">
			
				<g:if test="${personInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="person.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${personInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.spouse}">
				<li class="fieldcontain">
					<span id="spouse-label" class="property-label"><g:message code="person.spouse.label" default="Spouse" /></span>
					
						<span class="property-value" aria-labelledby="spouse-label"><g:fieldValue bean="${personInstance}" field="spouse"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.father}">
				<li class="fieldcontain">
					<span id="father-label" class="property-label"><g:message code="person.father.label" default="Father" /></span>
					
						<span class="property-value" aria-labelledby="father-label"><g:fieldValue bean="${personInstance}" field="father"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.address}">
				<li class="fieldcontain">
					<span id="address-label" class="property-label"><g:message code="person.address.label" default="Address" /></span>
					
						<span class="property-value" aria-labelledby="address-label"><g:fieldValue bean="${personInstance}" field="address"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.officeAddress}">
				<li class="fieldcontain">
					<span id="officeAddress-label" class="property-label"><g:message code="person.officeAddress.label" default="Office Address" /></span>
					
						<span class="property-value" aria-labelledby="officeAddress-label"><g:fieldValue bean="${personInstance}" field="officeAddress"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.locality}">
				<li class="fieldcontain">
					<span id="locality-label" class="property-label"><g:message code="person.locality.label" default="Locality" /></span>
					
						<span class="property-value" aria-labelledby="locality-label"><g:fieldValue bean="${personInstance}" field="locality"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.phone}">
				<li class="fieldcontain">
					<span id="phone-label" class="property-label"><g:message code="person.phone.label" default="Phone" /></span>
					
						<span class="property-value" aria-labelledby="phone-label"><g:fieldValue bean="${personInstance}" field="phone"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.email}">
				<li class="fieldcontain">
					<span id="email-label" class="property-label"><g:message code="person.email.label" default="Email" /></span>
					
						<span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${personInstance}" field="email"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.lmno}">
				<li class="fieldcontain">
					<span id="lmno-label" class="property-label"><g:message code="person.lmno.label" default="Lmno" /></span>
					
						<span class="property-value" aria-labelledby="lmno-label"><g:fieldValue bean="${personInstance}" field="lmno"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.panno}">
				<li class="fieldcontain">
					<span id="panno-label" class="property-label"><g:message code="person.panno.label" default="Panno" /></span>
					
						<span class="property-value" aria-labelledby="panno-label"><g:fieldValue bean="${personInstance}" field="panno"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.dob}">
				<li class="fieldcontain">
					<span id="dob-label" class="property-label"><g:message code="person.dob.label" default="Dob" /></span>
					
						<span class="property-value" aria-labelledby="dob-label"><g:formatDate date="${personInstance?.dob}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.dom}">
				<li class="fieldcontain">
					<span id="dom-label" class="property-label"><g:message code="person.dom.label" default="Dom" /></span>
					
						<span class="property-value" aria-labelledby="dom-label"><g:formatDate date="${personInstance?.dom}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.isPrimary}">
				<li class="fieldcontain">
					<span id="isPrimary-label" class="property-label"><g:message code="person.isPrimary.label" default="Is Primary" /></span>
					
						<span class="property-value" aria-labelledby="isPrimary-label"><g:formatBoolean boolean="${personInstance?.isPrimary}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.isDonor}">
				<li class="fieldcontain">
					<span id="isDonor-label" class="property-label"><g:message code="person.isDonor.label" default="Is Donor" /></span>
					
						<span class="property-value" aria-labelledby="isDonor-label"><g:formatBoolean boolean="${personInstance?.isDonor}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.primaryMember}">
				<li class="fieldcontain">
					<span id="primaryMember-label" class="property-label"><g:message code="person.primaryMember.label" default="Primary Member" /></span>
					
						<span class="property-value" aria-labelledby="primaryMember-label"><g:fieldValue bean="${personInstance}" field="primaryMember"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.relation}">
				<li class="fieldcontain">
					<span id="relation-label" class="property-label"><g:message code="person.relation.label" default="Relation" /></span>
					
						<span class="property-value" aria-labelledby="relation-label"><g:fieldValue bean="${personInstance}" field="relation"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.reference}">
				<li class="fieldcontain">
					<span id="reference-label" class="property-label"><g:message code="person.reference.label" default="Reference" /></span>
					
						<span class="property-value" aria-labelledby="reference-label"><g:fieldValue bean="${personInstance}" field="reference"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.matchedIndividual}">
				<li class="fieldcontain">
					<span id="matchedIndividual-label" class="property-label"><g:message code="person.matchedIndividual.label" default="Matched Individual" /></span>
					
						<span class="property-value" aria-labelledby="matchedIndividual-label"><g:link controller="individual" action="show" id="${personInstance?.matchedIndividual?.id}">${personInstance?.matchedIndividual?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="person.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${personInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="person.comments.label" default="Comments" /></span>
					
						<span class="property-value" aria-labelledby="comments-label"><g:fieldValue bean="${personInstance}" field="comments"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${personInstance?.id}" />
					<g:link class="edit" action="edit" id="${personInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
