<%@ page import="ics.MbProfile" %>



<div class="fieldcontain ${hasErrors(bean: mbProfileInstance, field: 'candidate', 'error')} required">
	<label for="candidate">
		<g:message code="mbProfile.candidate.label" default="Candidate" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="candidate.id" from="${ics.Individual.list()}" optionKey="id" value="${mbProfileInstance?.candidate?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: mbProfileInstance, field: 'referredBy', 'error')} required">
	<label for="referredBy">
		<g:message code="mbProfile.referredBy.label" default="Referred By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="referredBy.id" from="${ics.Individual.list()}" optionKey="id" value="${mbProfileInstance?.referredBy?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: mbProfileInstance, field: 'assignedTo', 'error')} required">
	<label for="assignedTo">
		<g:message code="mbProfile.assignedTo.label" default="Assigned To" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="assignedTo.id" from="${ics.Individual.list()}" optionKey="id" value="${mbProfileInstance?.assignedTo?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: mbProfileInstance, field: 'profileStatus', 'error')} ">
	<label for="profileStatus">
		<g:message code="mbProfile.profileStatus.label" default="Profile Status" />
		
	</label>
	<g:textField name="profileStatus" value="${fieldValue(bean: mbProfileInstance, field: 'profileStatus')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: mbProfileInstance, field: 'matchMakingStatus', 'error')} ">
	<label for="matchMakingStatus">
		<g:message code="mbProfile.matchMakingStatus.label" default="Match Making Status" />
		
	</label>
	<g:textField name="matchMakingStatus" value="${fieldValue(bean: mbProfileInstance, field: 'matchMakingStatus')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: mbProfileInstance, field: 'workflowStatus', 'error')} ">
	<label for="workflowStatus">
		<g:message code="mbProfile.workflowStatus.label" default="Workflow Status" />
		
	</label>
	<g:textField name="workflowStatus" value="${fieldValue(bean: mbProfileInstance, field: 'workflowStatus')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: mbProfileInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="mbProfile.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${fieldValue(bean: mbProfileInstance, field: 'category')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: mbProfileInstance, field: 'photo', 'error')} ">
	<label for="photo">
		<g:message code="mbProfile.photo.label" default="Photo" />
		
	</label>
	<input type="file" id="photo" name="photo" />

</div>

<div class="fieldcontain ${hasErrors(bean: mbProfileInstance, field: 'photoType', 'error')} ">
	<label for="photoType">
		<g:message code="mbProfile.photoType.label" default="Photo Type" />
		
	</label>
	<g:textField name="photoType" value="${fieldValue(bean: mbProfileInstance, field: 'photoType')}" />

</div>

