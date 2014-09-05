<%@ page import="ics.EventSevaGroupAllotment" %>



<div class="fieldcontain ${hasErrors(bean: eventSevaGroupAllotmentInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="eventSevaGroupAllotment.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: eventSevaGroupAllotmentInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaGroupAllotmentInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="eventSevaGroupAllotment.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: eventSevaGroupAllotmentInstance, field: 'updator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaGroupAllotmentInstance, field: 'eventSeva', 'error')} required">
	<label for="eventSeva">
		<g:message code="eventSevaGroupAllotment.eventSeva.label" default="Event Seva" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="eventSeva.id" from="${ics.EventSeva.list()}" optionKey="id" value="${eventSevaGroupAllotmentInstance?.eventSeva?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaGroupAllotmentInstance, field: 'eventRegistration', 'error')} required">
	<label for="eventRegistration">
		<g:message code="eventSevaGroupAllotment.eventRegistration.label" default="Event Registration" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="eventRegistration.id" from="${ics.EventRegistration.list()}" optionKey="id" value="${eventSevaGroupAllotmentInstance?.eventRegistration?.id}"  />

</div>

