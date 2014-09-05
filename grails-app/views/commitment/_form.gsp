<%@ page import="ics.Commitment" %>



<div class="fieldcontain ${hasErrors(bean: commitmentInstance, field: 'donatedAmount', 'error')} ">
	<label for="donatedAmount">
		<g:message code="commitment.donatedAmount.label" default="Donated Amount" />
		
	</label>
	<g:textField name="donatedAmount" value="${fieldValue(bean: commitmentInstance, field: 'donatedAmount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: commitmentInstance, field: 'collectedAmount', 'error')} ">
	<label for="collectedAmount">
		<g:message code="commitment.collectedAmount.label" default="Collected Amount" />
		
	</label>
	<g:textField name="collectedAmount" value="${fieldValue(bean: commitmentInstance, field: 'collectedAmount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: commitmentInstance, field: 'commitmentOn', 'error')} ">
	<label for="commitmentOn">
		<g:message code="commitment.commitmentOn.label" default="Commitment On" />
		
	</label>
	<g:datePicker name="commitmentOn" value="${commitmentInstance?.commitmentOn}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: commitmentInstance, field: 'commitmentTill', 'error')} ">
	<label for="commitmentTill">
		<g:message code="commitment.commitmentTill.label" default="Commitment Till" />
		
	</label>
	<g:datePicker name="commitmentTill" value="${commitmentInstance?.commitmentTill}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: commitmentInstance, field: 'scheme', 'error')} ">
	<label for="scheme">
		<g:message code="commitment.scheme.label" default="Scheme" />
		
	</label>
	<g:select name="scheme.id" from="${ics.Scheme.list()}" optionKey="id" value="${commitmentInstance?.scheme?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: commitmentInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="commitment.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${fieldValue(bean: commitmentInstance, field: 'status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: commitmentInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="commitment.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: commitmentInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: commitmentInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="commitment.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: commitmentInstance, field: 'updator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: commitmentInstance, field: 'committedAmount', 'error')} required">
	<label for="committedAmount">
		<g:message code="commitment.committedAmount.label" default="Committed Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="committedAmount" value="${fieldValue(bean: commitmentInstance, field: 'committedAmount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: commitmentInstance, field: 'committedBy', 'error')} required">
	<label for="committedBy">
		<g:message code="commitment.committedBy.label" default="Committed By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="committedBy.id" from="${ics.Individual.list()}" optionKey="id" value="${commitmentInstance?.committedBy?.id}"  />

</div>

