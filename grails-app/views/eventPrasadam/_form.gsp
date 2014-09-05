<%@ page import="ics.EventPrasadam" %>



<div class="fieldcontain ${hasErrors(bean: eventPrasadamInstance, field: 'event', 'error')} required">
	<label for="event">
		<g:message code="eventPrasadam.event.label" default="Event" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="event.id" from="${ics.Event.list()}" optionKey="id" value="${eventPrasadamInstance?.event?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: eventPrasadamInstance, field: 'meal', 'error')} ">
	<label for="meal">
		<g:message code="eventPrasadam.meal.label" default="Meal" />
		
	</label>
	<g:textField name="meal" value="${fieldValue(bean: eventPrasadamInstance, field: 'meal')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventPrasadamInstance, field: 'mealDate', 'error')} required">
	<label for="mealDate">
		<g:message code="eventPrasadam.mealDate.label" default="Meal Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="mealDate" value="${eventPrasadamInstance?.mealDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: eventPrasadamInstance, field: 'numPrji', 'error')} required">
	<label for="numPrji">
		<g:message code="eventPrasadam.numPrji.label" default="Num Prji" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numPrji" value="${fieldValue(bean: eventPrasadamInstance, field: 'numPrji')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventPrasadamInstance, field: 'numMataji', 'error')} required">
	<label for="numMataji">
		<g:message code="eventPrasadam.numMataji.label" default="Num Mataji" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numMataji" value="${fieldValue(bean: eventPrasadamInstance, field: 'numMataji')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventPrasadamInstance, field: 'numChildren', 'error')} required">
	<label for="numChildren">
		<g:message code="eventPrasadam.numChildren.label" default="Num Children" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numChildren" value="${fieldValue(bean: eventPrasadamInstance, field: 'numChildren')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventPrasadamInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="eventPrasadam.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${fieldValue(bean: eventPrasadamInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventPrasadamInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="eventPrasadam.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: eventPrasadamInstance, field: 'updator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventPrasadamInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="eventPrasadam.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: eventPrasadamInstance, field: 'creator')}" />

</div>

