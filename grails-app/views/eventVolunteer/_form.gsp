<%@ page import="ics.EventVolunteer" %>



<div class="fieldcontain ${hasErrors(bean: eventVolunteerInstance, field: 'event', 'error')} required">
	<label for="event">
		<g:message code="eventVolunteer.event.label" default="Event" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="event.id" from="${ics.Event.list()}" optionKey="id" value="${eventVolunteerInstance?.event?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: eventVolunteerInstance, field: 'department', 'error')} ">
	<label for="department">
		<g:message code="eventVolunteer.department.label" default="Department" />
		
	</label>
	<g:textField name="department" value="${fieldValue(bean: eventVolunteerInstance, field: 'department')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventVolunteerInstance, field: 'seva', 'error')} ">
	<label for="seva">
		<g:message code="eventVolunteer.seva.label" default="Seva" />
		
	</label>
	<g:textField name="seva" value="${fieldValue(bean: eventVolunteerInstance, field: 'seva')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventVolunteerInstance, field: 'requiredFrom', 'error')} required">
	<label for="requiredFrom">
		<g:message code="eventVolunteer.requiredFrom.label" default="Required From" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="requiredFrom" value="${eventVolunteerInstance?.requiredFrom}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: eventVolunteerInstance, field: 'requiredTill', 'error')} required">
	<label for="requiredTill">
		<g:message code="eventVolunteer.requiredTill.label" default="Required Till" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="requiredTill" value="${eventVolunteerInstance?.requiredTill}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: eventVolunteerInstance, field: 'numPrjiRequired', 'error')} required">
	<label for="numPrjiRequired">
		<g:message code="eventVolunteer.numPrjiRequired.label" default="Num Prji Required" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numPrjiRequired" value="${fieldValue(bean: eventVolunteerInstance, field: 'numPrjiRequired')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventVolunteerInstance, field: 'numMatajiRequired', 'error')} required">
	<label for="numMatajiRequired">
		<g:message code="eventVolunteer.numMatajiRequired.label" default="Num Mataji Required" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numMatajiRequired" value="${fieldValue(bean: eventVolunteerInstance, field: 'numMatajiRequired')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventVolunteerInstance, field: 'numPrjiAllotted', 'error')} required">
	<label for="numPrjiAllotted">
		<g:message code="eventVolunteer.numPrjiAllotted.label" default="Num Prji Allotted" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numPrjiAllotted" value="${fieldValue(bean: eventVolunteerInstance, field: 'numPrjiAllotted')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventVolunteerInstance, field: 'numMatajiAllotted', 'error')} required">
	<label for="numMatajiAllotted">
		<g:message code="eventVolunteer.numMatajiAllotted.label" default="Num Mataji Allotted" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numMatajiAllotted" value="${fieldValue(bean: eventVolunteerInstance, field: 'numMatajiAllotted')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventVolunteerInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="eventVolunteer.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${fieldValue(bean: eventVolunteerInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventVolunteerInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="eventVolunteer.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: eventVolunteerInstance, field: 'updator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventVolunteerInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="eventVolunteer.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: eventVolunteerInstance, field: 'creator')}" />

</div>

