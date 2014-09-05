<%@ page import="ics.Period" %>



<div class="fieldcontain ${hasErrors(bean: periodInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="period.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: periodInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: periodInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="period.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${fieldValue(bean: periodInstance, field: 'category')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: periodInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="period.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${fieldValue(bean: periodInstance, field: 'type')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: periodInstance, field: 'fromDate', 'error')} ">
	<label for="fromDate">
		<g:message code="period.fromDate.label" default="From Date" />
		
	</label>
	<g:datePicker name="fromDate" value="${periodInstance?.fromDate}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: periodInstance, field: 'toDate', 'error')} ">
	<label for="toDate">
		<g:message code="period.toDate.label" default="To Date" />
		
	</label>
	<g:datePicker name="toDate" value="${periodInstance?.toDate}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: periodInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="period.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: periodInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: periodInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="period.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: periodInstance, field: 'updator')}" />

</div>

