<%@ page import="ics.LifeMembershipCard" %>

<div class="body">
<div class="dialog">
<table cellspacing="0" cellpadding="0" border="0" width="100%">
<tbody bgcolor="lavender">
<tr>

<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'lifeMembershipCardNumber', 'error')} ">
	<td width="40%">
	<label for="lifeMembershipCardNumber">
		<b><g:message code="lifeMembershipCard.lifeMembershipCardNumber.label" default="Life Patron Card Number" /></b>
		
	</label>
	</td>
	<td width="60%">
	<!--${lifeMembershipCardInstance?.lifeMembershipCardNumber}-->
	<g:textField name="lifeMembershipCardNumber" value="${lifeMembershipCardInstance?.lifeMembershipCardNumber}"/>
	</td>
</div>
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'lifeMember', 'error')} required">
	<td>
	<label for="lifeMember">
		<b><g:message code="lifeMembershipCard.lifeMember.label" default="Life Patron" /></b>
		<span class="required-indicator">*</span>
	</label>
	</td>
	<td>
	</td>
</div>
</tr>

<tr>
<td>
       <g:hiddenField name="h_lifeMember.id" value="${lifeMembershipCardInstance?.lifeMember?.id}" />
        <b>Use This Name?</b>&nbsp;<g:checkBox name="LifeMemberChkBox" value="${true}"/>

</td>
<td>
	${lifeMembershipCardInstance?.lifeMember}
</td>
</tr>
<tr>
	<td>
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
		<b>Patron Care Collector</b>
		<span class="required-indicator">*</span>
	</label>
	</td>
	<td>
	</td>
</div>
</tr>
<tr>
<td>
       <g:hiddenField name="h_originatingDeptCollector.id" value="${lifeMembershipCardInstance?.originatingDeptCollector?.id}" />
        <b>Use This Name?</b>&nbsp;<g:checkBox name="OriginatingDeptCollectorChkBox" value="${true}"/>

</td>
<td>
	${lifeMembershipCardInstance?.originatingDeptCollector}
</td>
</tr>
<tr>
	<td>
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
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'forwardingDeptRepresentative', 'error')} required">
	<td>
	<label for="forwardingDeptRepresentative">
		<!--<g:message code="lifeMembershipCard.forwardingDeptRepresentative.label" default="Forwarding Dept Representative" />-->
		<b>NVCC Representative</b>
		<span class="required-indicator">*</span>
	</label>
	</td>
	<td>
	</td>
</div>
</tr>
<tr>
<td>
       <g:hiddenField name="h_forwardingDeptRepresentative.id" value="${lifeMembershipCardInstance?.forwardingDeptRepresentative?.id}" />
        <b>Use This Name?</b>&nbsp;<g:checkBox name="ForwardingDeptRepresentativeChkBox" value="${true}"/>

</td>
<td>
	${lifeMembershipCardInstance?.forwardingDeptRepresentative}
</td>
</tr>
	<td>
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

</tr>


<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'dateFormSubmissionOriginatingDeptToForwardingDept', 'error')} ">
	<td>
	<label for="dateFormSubmissionOriginatingDeptToForwardingDept">
		<!--<g:message code="lifeMembershipCard.dateFormSubmissionOriginatingDeptToForwardingDept.label" default="Date Form Submission Originating Dept To Forwarding Dept" />-->
		<b>Date Form Submission Patron Care Dept To NVCC</b>
		
	</label>
	</td>
	<td>
	<!--<g:datePicker name="dateFormSubmissionOriginatingDeptToForwardingDept" precision="day"  value="${lifeMembershipCardInstance?.dateFormSubmissionOriginatingDeptToForwardingDept}" default="none" noSelection="['': '']" />-->
	<g:textField name="dateFormSubmissionOriginatingDeptToForwardingDept" value="${lifeMembershipCardInstance?.dateFormSubmissionOriginatingDeptToForwardingDept?.format('dd-MM-yyyy')}" size="8" />
	</td>
</div>
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'dateFormSentToProcessingDept', 'error')} ">
	<td>
	<label for="dateFormSentToProcessingDept">
		<!--<g:message code="lifeMembershipCard.dateFormSentToProcessingDept.label" default="Date Form Sent To Processing Dept" />-->
		<b>Date Form Sent To Juhu</b>
		
	</label>
	</td>
	<td>
	<!--<g:datePicker name="dateFormSentToProcessingDept" precision="day"  value="${lifeMembershipCardInstance?.dateFormSentToProcessingDept}" default="none" noSelection="['': '']" />-->
	<g:textField name="dateFormSentToProcessingDept" value="${lifeMembershipCardInstance?.dateFormSentToProcessingDept?.format('dd-MM-yyyy')}" size="8" />
	</td>
</div>
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'dateCardArrival', 'error')} ">
	<td>
	<label for="dateCardArrival">
		<b><g:message code="lifeMembershipCard.dateCardArrival.label" default="Date Card Arrival" /></b>
		
	</label>
	</td>
	<td>
	<!--<g:datePicker name="dateCardArrival" precision="day"  value="${lifeMembershipCardInstance?.dateCardArrival}" default="none" noSelection="['': '']" />-->
	<g:textField name="dateCardArrival" value="${lifeMembershipCardInstance?.dateCardArrival?.format('dd-MM-yyyy')}" size="8" />
	</td>
</div>
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'dateCardDelivery', 'error')} ">
	<td>
	<label for="dateCardDelivery">
		<b><g:message code="lifeMembershipCard.dateCardDelivery.label" default="Date Card Delivery" /></b>
		
	</label>
	</td>
	<td>
	<!--<g:datePicker name="dateCardDelivery" precision="day"  value="${lifeMembershipCardInstance?.dateCardDelivery}" default="none" noSelection="['': '']" />-->
	<g:textField name="dateCardDelivery" value="${lifeMembershipCardInstance?.dateCardDelivery?.format('dd-MM-yyyy')}" size="8" />
	</td>
</div>
</tr>

<tr>
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
</tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: lifeMembershipCardInstance, field: 'cardStatus', 'error')} ">
	<td>
	<label for="cardStatus">
		<b><g:message code="lifeMembershipCard.cardStatus.label" default="Card Status" /></b>
		
	</label>
	</td>
	<td>
	<!--<g:textField name="cardStatus" value="${lifeMembershipCardInstance?.cardStatus}"/>-->
	<g:hiddenField name="h_cardStatus" value="${lifeMembershipCardInstance?.cardStatus}" />
	<g:select name="cardStatus" from="${['Form Submitted by Patron Care Dept To NVCC','Form Sent To Juhu','Card Arrived','Card Delivered']}" value="${lifeMembershipCardInstance?.cardStatus}"/>
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
</tbody>
</table>
</div>
</div>