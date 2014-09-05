<%@ page import="ics.EventSevaAllotment" %>



<div class="fieldcontain ${hasErrors(bean: eventSevaAllotmentInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="eventSevaAllotment.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: eventSevaAllotmentInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaAllotmentInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="eventSevaAllotment.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: eventSevaAllotmentInstance, field: 'updator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaAllotmentInstance, field: 'eventSeva', 'error')} required">
	<label for="eventSeva">
		<g:message code="eventSevaAllotment.eventSeva.label" default="Event Seva" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="eventSeva.id" from="${ics.EventSeva.list()}" optionKey="id" value="${eventSevaAllotmentInstance?.eventSeva?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaAllotmentInstance, field: 'person', 'error')} required">
	<label for="person">
		<g:message code="eventSevaAllotment.person.label" default="Person" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="person.id" from="${ics.Person.list()}" optionKey="id" value="${eventSevaAllotmentInstance?.person?.id}"  />

</div>

