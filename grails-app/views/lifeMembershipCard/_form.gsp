<%@ page import="ics.LifeMembershipCard" %>



<table>
<tr>

<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'lifeMembershipCardNumber', 'error')} ">
	<td width="25%">
	<label for="lifeMembershipCardNumber">
		<g:message code="lifeMembershipCard.lifeMembershipCardNumber.label" default="Life Patron Card Number" />
		
	</label>
	</td>
	<td width="75%">
	<g:textField name="lifeMembershipCardNumber" value="${lifeMembershipCardInstance?.lifeMembershipCardNumber}"/>
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
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'lifeMember', 'error')} required">
	<td>
	<label for="lifeMember">
		<g:message code="lifeMembershipCard.lifeMember.label" default="Life Patron" />
		<span class="required-indicator">*</span>
	</label>
	</td>
	<td>
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
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'originatingDeptCollector', 'error')} required">
	<td>
	<label for="originatingDeptCollector">
		<!--<g:message code="lifeMembershipCard.originatingDeptCollector.label" default="Originating Dept Collector" />-->
		Patron Care Collector
		<span class="required-indicator">*</span>
	</label>
	</td>
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
</div>
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'forwardingDeptRepresentative', 'error')} required">
	<td>
	<label for="forwardingDeptRepresentative">
		<!--<g:message code="lifeMembershipCard.forwardingDeptRepresentative.label" default="Forwarding Dept Representative" />-->
		NVCC Representative
		<span class="required-indicator">*</span>
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
		Date Form Submission Patron Care Dept To NVCC
		
	</label>
	</td>
	<td>
	<!--<g:datePicker name="dateFormSubmissionOriginatingDeptToForwardingDept" precision="day"  value="${lifeMembershipCardInstance?.dateFormSubmissionOriginatingDeptToForwardingDept}" default="none" noSelection="['': '']" />-->
	<g:textField name="dateFormSubmissionOriginatingDeptToForwardingDept" value="${new Date().format('dd-MM-yyyy')}" size="8" />
	</td>
</div>
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'dateFormSubmissionForwardingDeptToLMDept', 'error')} ">
	<td>
	<label for="dateFormSubmissionForwardingDeptToLMDept">
		<!--<g:message code="lifeMembershipCard.dateFormSubmissionForwardingDeptToLMDept.label" default="Date Form Submission Forwarding Dept To LMD ept" />-->
		Date Form Submission NVCC To Life Patron Dept
		
	</label>
	</td>
	<td>
	<!--<g:datePicker name="dateFormSubmissionForwardingDeptToLMDept" precision="day"  value="${lifeMembershipCardInstance?.dateFormSubmissionForwardingDeptToLMDept}" default="none" noSelection="['': '']" />-->
	<g:textField name="dateFormSubmissionForwardingDeptToLMDept" value="${new Date().format('dd-MM-yyyy')}" size="8" />
	</td>
</div>
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'dateFormSentToProcessingDept', 'error')} ">
	<td>
	<label for="dateFormSentToProcessingDept">
		<!--<g:message code="lifeMembershipCard.dateFormSentToProcessingDept.label" default="Date Form Sent To Processing Dept" />-->
		Date Form Sent To Juhu
		
	</label>
	</td>
	<td>
	<!--<g:datePicker name="dateFormSentToProcessingDept" precision="day"  value="${lifeMembershipCardInstance?.dateFormSentToProcessingDept}" default="none" noSelection="['': '']" />-->
	<g:textField name="dateFormSentToProcessingDept" value="${new Date().format('dd-MM-yyyy')}" size="8" />
	</td>
</div>
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'dateCardArrival', 'error')} ">
	<td>
	<label for="dateCardArrival">
		<g:message code="lifeMembershipCard.dateCardArrival.label" default="Date Card Arrival" />
		
	</label>
	</td>
	<td>
	<!--<g:datePicker name="dateCardArrival" precision="day"  value="${lifeMembershipCardInstance?.dateCardArrival}" default="none" noSelection="['': '']" />-->
	<g:textField name="dateCardArrival" value="${new Date().format('dd-MM-yyyy')}" size="8" />
	</td>
</div>
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'dateCardDelivery', 'error')} ">
	<td>
	<label for="dateCardDelivery">
		<g:message code="lifeMembershipCard.dateCardDelivery.label" default="Date Card Delivery" />
		
	</label>
	</td>
	<td>
	<!--<g:datePicker name="dateCardDelivery" precision="day"  value="${lifeMembershipCardInstance?.dateCardDelivery}" default="none" noSelection="['': '']" />-->
	<g:textField name="dateCardDelivery" value="${new Date().format('dd-MM-yyyy')}" size="8" />
	</td>
</div>
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'duplicate', 'error')} ">
	<td>
	<label for="duplicate">
		<g:message code="lifeMembershipCard.duplicate.label" default="Duplicate" />
		
	</label>
	</td>
	<td>
	<g:checkBox name="duplicate" value="${lifeMembershipCardInstance?.duplicate}" />
	</td>
</div>
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'cardStatus', 'error')} ">
	<td>
	<label for="cardStatus">
		<g:message code="lifeMembershipCard.cardStatus.label" default="Card Status" />
		
	</label>
	</td>
	<td>
	<!--<g:textField name="cardStatus" value="${lifeMembershipCardInstance?.cardStatus}"/>-->
	<g:select name="acategory" from="${['Form Submitted by Patron Care Dept To NVCC','Form Submitted by NVCC To Life Patron Dept','Form Sent To Juhu','Card Arrived','Card Delivered']}" value="${lifeMembershipCardInstance?.cardStatus}"/>
	</td>
</div>
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'acceptedByOriginatingDept', 'error')} ">
	<td>
	<label for="acceptedByOriginatingDept">
		<!--<g:message code="lifeMembershipCard.acceptedByOriginatingDept.label" default="Accepted By Originating Dept" />-->
		Accepted By Patron Care Collector?
		
	</label>
	</td>
	<td>
	<g:checkBox name="acceptedByOriginatingDept" value="${lifeMembershipCardInstance?.acceptedByOriginatingDept}" />
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
