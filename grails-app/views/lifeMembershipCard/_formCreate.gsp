<%@ page import="ics.LifeMembershipCard" %>



<table>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'lifeMember', 'error')} required">
	<td width="25%">
	<label for="lifeMember">
		<b><g:message code="lifeMembershipCard.lifeMember.label" default="Life Patron" />
		<span class="required-indicator">*</span></b>
	</label>
	</td>
	<td width="75%">
	<g:hiddenField name="lifeMember" value="" />	
	   <div style="width: 300px">
		<gui:autoComplete
			id="acLifeMember"
			width="200px"
			controller="individual"
			action="allIndividualsAsJSON"
			useShadow="true"
			queryDelay="0.2"

		/>
		</div>
	</td>
</div>
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'nameOnCard', 'error')} ">
	<td>
	<label for="nameOnCard">
		<b><g:message code="lifeMembershipCard.nameOnCard.label" default="Name on Card" /></b>
		
	</label>
	</td>
	<td>
	<g:textField name="nameOnCard" value="${lifeMembershipCardInstance?.nameOnCard}" size="55"/>
	</td>
</div>
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'originatingDeptCollector', 'error')} required">
	<td>
	<label for="originatingDeptCollector">
		<!--<g:message code="lifeMembershipCard.originatingDeptCollector.label" default="Originating Dept Collector" />-->
		<b>Patron Care Collector
		<span class="required-indicator">*</span><b>
	</label>
	</td>


	<sec:ifNotGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
	<td>
	<g:hiddenField name="originatingDeptCollector" value="" />
	   <div style="width: 300px">
		<gui:autoComplete
			id="acOriginatingDeptCollector"
			width="200px"
			controller="individual"
			action="findPatronCareAsJSON"
			useShadow="true"
			queryDelay="0.2"

		/>
		</div>
	</td>
	</sec:ifNotGranted>
	<sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
	<td>
		${session.individualname}
	</td>
	</sec:ifAnyGranted> 	
</div>
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'forwardingDeptRepresentative', 'error')} required">
	<td>
	<label for="forwardingDeptRepresentative">
		<!--<g:message code="lifeMembershipCard.forwardingDeptRepresentative.label" default="Forwarding Dept Representative" />-->
		<b>NVCC Representative
		<span class="required-indicator">*</span></b>
	</label>
	</td>
	<td>
	<g:hiddenField name="forwardingDeptRepresentative" value="" />
	   <div style="width: 300px">
		<gui:autoComplete
			id="acForwardingDeptRepresentative"
			width="200px"
			controller="individual"
			action="allIndividualsAsJSON"
			useShadow="true"
			queryDelay="0.2"

		/>
		</div>
	</td>
</div>
</tr>


<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'dateFormSubmissionOriginatingDeptToForwardingDept', 'error')} ">
	<td>
	<label for="dateFormSubmissionOriginatingDeptToForwardingDept">
		<!--<g:message code="lifeMembershipCard.dateFormSubmissionOriginatingDeptToForwardingDept.label" default="Date Form Submission Originating Dept To Forwarding Dept" />-->
		<b>Date Form Submission Patron Care Dept To NVCC
		<span class="required-indicator">*</span></b>
	</label>
	</td>
	<td>
	<!--<g:datePicker name="dateFormSubmissionOriginatingDeptToForwardingDept" precision="day"  value="${lifeMembershipCardInstance?.dateFormSubmissionOriginatingDeptToForwardingDept}" default="none" noSelection="['': '']" />-->
	<g:textField name="dateFormSubmissionOriginatingDeptToForwardingDept" value="${new Date().format('dd-MM-yyyy')}" size="8" />
	</td>
</div>
</tr>


<!--<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'duplicate', 'error')} ">
	<td>
	<label for="duplicate">
		<b><g:message code="lifeMembershipCard.duplicate.label" default="Duplicate" /></b>
		
	</label>
	</td>
	<td>
	<g:checkBox name="duplicate" value="${lifeMembershipCardInstance?.duplicate}" />
	</td>
</div>
</tr>-->

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'cardStatus', 'error')} ">
	<td>
	<label for="cardStatus">
		<b><g:message code="lifeMembershipCard.cardStatus.label" default="Card Status" /></b>
		
	</label>
	</td>
	<td>
	<!--<g:textField name="cardStatus" value="${lifeMembershipCardInstance?.cardStatus}"/>-->
	<!--<g:select name="acategory" from="${['Form Submitted by Patron Care Dept To NVCC','Form Submitted by NVCC To Life Membership Dept','Form Sent To Juhu','Card Arrived','Card Delivered']}" value="${lifeMembershipCardInstance?.cardStatus}" tabindex="16"/>-->
	Form Submitted by Patron Care Dept To NVCC
	</td>
</div>
</tr>



<!--<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'creator', 'error')} ">
	<td>
	<label for="creator">
		<g:message code="lifeMembershipCard.creator.label" default="Creator" />
		
	</label>
	</td>
	<td>
	<g:textField name="creator" value="${lifeMembershipCardInstance?.creator}"/>
	</td>
</div>
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'updator', 'error')} ">
	<td>
	<label for="updator">
		<g:message code="lifeMembershipCard.updator.label" default="Updator" />
		
	</label>
	</td>
	<td>
	<g:textField name="updator" value="${lifeMembershipCardInstance?.updator}"/>
	</td>
</div>
</tr>-->
</table>
