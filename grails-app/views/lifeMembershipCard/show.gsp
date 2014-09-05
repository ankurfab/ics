
<%@ page import="ics.LifeMembershipCard" %>
<!doctype html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'lifeMembershipCard.label', default: 'LifePatronCard')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
	</head>
	<body>
		<!--<a href="#show-lifeMembershipCard" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>-->
		<div class="nav" role="navigation">
			<span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            		<span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>		
            		<sec:ifNotGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
				<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
			</sec:ifNotGranted>
			<!--<span class="menuButton"><g:link class="edit" action="edit" id="${lifeMembershipCardInstance?.id}"><g:message code="default.edit.label" args="[entityName]" /></g:link></span>-->
		
			<!--<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>-->
		</div>
		<div id="show-lifeMembershipCard" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<!--<ol class="property-list lifeMembershipCard">-->
			<table cellspacing="0" cellpadding="0" border="0" width="60%">
				<tbody bgcolor="lavender">
				<g:if test="${lifeMembershipCardInstance?.lifeMembershipCardNumber}">
				<!--<li class="fieldcontain">-->
				<tr>
					<td width="25%">
					<b><span id="lifeMembershipCardNumber-label" class="property-label"><g:message code="lifeMembershipCard.lifeMembershipCardNumber.label" default="Life Membership Card Number" /></span></b>
					</td>
					<td width="75%">
						<span class="property-value" aria-labelledby="lifeMembershipCardNumber-label"><g:fieldValue bean="${lifeMembershipCardInstance}" field="lifeMembershipCardNumber"/></span>
					</td>
				</tr>
				<!--</li>-->
				</g:if>
			
				<g:if test="${lifeMembershipCardInstance?.lifeMember}">
				<!--<li class="fieldcontain">-->
				<tr>
					<td width="25%">
					<b><span id="lifeMember-label" class="property-label"><g:message code="lifeMembershipCard.lifeMember.label" default="Life Member" /></span></b>
					</td>
					<td width="75%">
						<span class="property-value" aria-labelledby="lifeMember-label"><g:link controller="individual" action="show" id="${lifeMembershipCardInstance?.lifeMember?.id}">${lifeMembershipCardInstance?.lifeMember?.encodeAsHTML()}</g:link></span>
					</td>
				</tr>	
				<!--</li>-->
				</g:if>
				
				
				<g:if test="${lifeMembershipCardInstance?.nameOnCard}">
				<tr>
				<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'nameOnCard', 'error')} ">
					<td width="25%">
					<b><span id="lifeMember-label" class="property-label"><g:message code="lifeMembershipCard.nameOnCard.label" default="Name on Card" /></span></b>
					</td>
					<td width="75%">
						<span class="property-value" aria-labelledby="nameOnCard-label"><g:fieldValue bean="${lifeMembershipCardInstance}" field="nameOnCard"/></span>
					</td>
				</div>
				</tr>
				</g:if>
				
				<g:if test="${lifeMembershipCardInstance?.originatingDeptCollector}">
				<!--<li class="fieldcontain">-->
				<tr>
					<td width="25%">
					<b><span id="originatingDeptCollector-label" class="property-label"><g:message code="lifeMembershipCard.originatingDeptCollector.label" default="Patron Care Collector" /></span></b>
					
					</td>
					<td width="75%">
						<span class="property-value" aria-labelledby="originatingDeptCollector-label"><g:link controller="individual" action="show" id="${lifeMembershipCardInstance?.originatingDeptCollector?.id}">${lifeMembershipCardInstance?.originatingDeptCollector?.encodeAsHTML()}</g:link></span>
					</td>
				</tr>	
				<!--</li>-->
				</g:if>
			
				<g:if test="${lifeMembershipCardInstance?.forwardingDeptRepresentative}">
				<!--<li class="fieldcontain">-->
				<tr>
					<td width="25%">
					<b><span id="forwardingDeptRepresentative-label" class="property-label"><g:message code="lifeMembershipCard.forwardingDeptRepresentative.label" default="NVCC Representative" /></span></b>
					</td>
					<td width="75%">
						<span class="property-value" aria-labelledby="forwardingDeptRepresentative-label"><g:link controller="individual" action="show" id="${lifeMembershipCardInstance?.forwardingDeptRepresentative?.id}">${lifeMembershipCardInstance?.forwardingDeptRepresentative?.encodeAsHTML()}</g:link></span>
					</td>
				</tr>	
				<!--</li>-->
				</g:if>
			
				<g:if test="${lifeMembershipCardInstance?.acceptedByOriginatingDept}">
				<!--<li class="fieldcontain">-->
				<tr>
					<td width="25%">
					<b><span id="acceptedByOriginatingDept-label" class="property-label"><g:message code="lifeMembershipCard.acceptedByOriginatingDept.label" default="Accepted By Originating Dept" /></span></b>
					</td>
					<td width="75%">
						<span class="property-value" aria-labelledby="acceptedByOriginatingDept-label"><g:formatBoolean boolean="${lifeMembershipCardInstance?.acceptedByOriginatingDept}" /></span>
					</td>
				</tr>	
				<!--</li>-->
				</g:if>
			
				<g:if test="${lifeMembershipCardInstance?.dateFormSubmissionOriginatingDeptToForwardingDept}">
				<!--<li class="fieldcontain">-->
				<tr>
					<td width="25%">
					<b><span id="dateFormSubmissionOriginatingDeptToForwardingDept-label" class="property-label"><g:message code="lifeMembershipCard.dateFormSubmissionOriginatingDeptToForwardingDept.label" default="Date Form Submission Patron Care Dept To NVCC" /></span></b>
					</td>
					<td width="75%">
						<span class="property-value" aria-labelledby="dateFormSubmissionOriginatingDeptToForwardingDept-label"><g:formatDate date="${lifeMembershipCardInstance?.dateFormSubmissionOriginatingDeptToForwardingDept}" format="dd-MM-yyyy"/></span>
					</td>
				</tr>	
				<!--</li>-->
				</g:if>
			
				<g:if test="${lifeMembershipCardInstance?.dateFormSentToProcessingDept}">
				<!--<li class="fieldcontain">-->
				<tr>
					<td width="25%">
					<b><span id="dateFormSentToProcessingDept-label" class="property-label"><g:message code="lifeMembershipCard.dateFormSentToProcessingDept.label" default="Date Form Sent To Juhu" /></span></b>
					</td>
					<td width="75%">
						<span class="property-value" aria-labelledby="dateFormSentToProcessingDept-label"><g:formatDate date="${lifeMembershipCardInstance?.dateFormSentToProcessingDept}" format="dd-MM-yyyy"/></span>
					</td>
				</tr>	
				<!--</li>-->
				</g:if>
			
				<g:if test="${lifeMembershipCardInstance?.dateCardArrival}">
				<!--<li class="fieldcontain">-->
				<tr>
					<td width="25%">
					<b><span id="dateCardArrival-label" class="property-label"><g:message code="lifeMembershipCard.dateCardArrival.label" default="Date Card Arrival" /></span></b>
					</td>
					<td width="75%">
						<span class="property-value" aria-labelledby="dateCardArrival-label"><g:formatDate date="${lifeMembershipCardInstance?.dateCardArrival}" format="dd-MM-yyyy"/></span>
					</td>
				</tr>	
				<!--</li>-->
				</g:if>
			
				<g:if test="${lifeMembershipCardInstance?.dateCardDelivery}">
				<!--<li class="fieldcontain">-->
				<tr>
					<td width="25%">
					<b><span id="dateCardDelivery-label" class="property-label"><g:message code="lifeMembershipCard.dateCardDelivery.label" default="Date Card Delivery" /></span></b>
					</td>
					<td width="75%">
						<span class="property-value" aria-labelledby="dateCardDelivery-label"><g:formatDate date="${lifeMembershipCardInstance?.dateCardDelivery}" format="dd-MM-yyyy"/></span>
					</td>
				</tr>	
				<!--</li>-->
				</g:if>
			
				<g:if test="${lifeMembershipCardInstance?.duplicate}">
				<!--<li class="fieldcontain">-->
				<tr>
					<td width="25%">
					<b><span id="duplicate-label" class="property-label"><g:message code="lifeMembershipCard.duplicate.label" default="Duplicate" /></span></b>
					</td>
					<td width="75%">
						<span class="property-value" aria-labelledby="duplicate-label"><g:formatBoolean boolean="${lifeMembershipCardInstance?.duplicate}" /></span>
					</td>
				</tr>	
				<!--</li>-->
				</g:if>
			
				<g:if test="${lifeMembershipCardInstance?.cardStatus}">
				<!--<li class="fieldcontain">-->
				<tr>
					<td width="25%">
					<b><span id="cardStatus-label" class="property-label"><g:message code="lifeMembershipCard.cardStatus.label" default="Card Status" /></span></b>
					</td>
					<td width="75%">
						<span class="property-value" aria-labelledby="cardStatus-label"><g:fieldValue bean="${lifeMembershipCardInstance}" field="cardStatus"/></span>
					</td>
				</tr>	
				<!--</li>-->
				</g:if>
			
				<g:if test="${lifeMembershipCardInstance?.creator}">
				<!--<li class="fieldcontain">-->
				<tr>
					<td width="25%">
					<b><span id="creator-label" class="property-label"><g:message code="lifeMembershipCard.creator.label" default="Creator" /></span></b>
					</td>
					<td width="75%">
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${lifeMembershipCardInstance}" field="creator"/></span>
					</td>
				</tr>	
				<!--</li>-->
				</g:if>
			
				<g:if test="${lifeMembershipCardInstance?.dateCreated}">
				<!--<li class="fieldcontain">-->
				<tr>
					<td width="25%">
					<b><span id="dateCreated-label" class="property-label"><g:message code="lifeMembershipCard.dateCreated.label" default="Date Created" /></span></b>
					</td>
					<td width="75%">
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${lifeMembershipCardInstance?.dateCreated}" format="dd-MM-yyyy"/></span>
					</td>
				</tr>	
				<!--</li>-->
				</g:if>
			
				<g:if test="${lifeMembershipCardInstance?.lastUpdated}">
				<!--<li class="fieldcontain">-->
				<tr>
					<td width="25%">
					<b><span id="lastUpdated-label" class="property-label"><g:message code="lifeMembershipCard.lastUpdated.label" default="Last Updated" /></span></b>
					</td>				
					<td width="75%">
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${lifeMembershipCardInstance?.lastUpdated}" format="dd-MM-yyyy"/></span>
					</td>					
				</tr>	
				<!--</li>-->
				</g:if>
			
				<g:if test="${lifeMembershipCardInstance?.updator}">
				<!--<li class="fieldcontain">-->
				<tr>
					<td width="25%">
					<b><span id="updator-label" class="property-label"><g:message code="lifeMembershipCard.updator.label" default="Updator" /></span></b>
					</td>				
					<td width="75%">
						<span class="property-value" aria-labelledby="updator-label"><g:fieldValue bean="${lifeMembershipCardInstance}" field="updator"/></span>
					</td>
				</tr>	
				<!--</li>-->
				</g:if>
			</tbody>
			</table>

			<!--</ol>-->
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${lifeMembershipCardInstance?.id}" />
					<!--<g:link class="edit" action="edit" id="${lifeMembershipCardInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>-->
					<sec:ifNotGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
						<g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
						<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</sec:ifNotGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
