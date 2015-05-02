<%@ page import="ics.EventDetail" %>



<div class="fieldcontain ${hasErrors(bean: eventDetailInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="eventDetail.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${fieldValue(bean: eventDetailInstance, field: 'category')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventDetailInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="eventDetail.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${fieldValue(bean: eventDetailInstance, field: 'type')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventDetailInstance, field: 'details', 'error')} ">
	<label for="details">
		<g:message code="eventDetail.details.label" default="Details" />
		
	</label>
	<g:textArea name="details" rows="5" cols="40" value="${fieldValue(bean: eventDetailInstance, field: 'details')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventDetailInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="eventDetail.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: eventDetailInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventDetailInstance, field: 'event', 'error')} required">
	<label for="event">
		<g:message code="eventDetail.event.label" default="Event" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="event.id" from="${ics.Event.list()}" optionKey="id" value="${eventDetailInstance?.event?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: eventDetailInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="eventDetail.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: eventDetailInstance, field: 'updator')}" />

</div>

