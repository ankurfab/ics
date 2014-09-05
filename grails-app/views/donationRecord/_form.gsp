<%@ page import="ics.DonationRecord" %>



<div class="fieldcontain ${hasErrors(bean: donationRecordInstance, field: 'donatedBy', 'error')} required">
	<label for="donatedBy">
		<g:message code="donationRecord.donatedBy.label" default="Donated By" />
		<span class="required-indicator">*</span>
	</label>
	<g:link controller="individual" action="show" params="['id':donationRecordInstance?.donatedBy?.id,'profile':'true']">${donationRecordInstance?.donatedBy?.encodeAsHTML()}</g:link>
</div>

<div class="fieldcontain ${hasErrors(bean: donationRecordInstance, field: 'donationDate', 'error')} required">
	<label for="donationDate">
		<g:message code="donationRecord.donationDate.label" default="Donation Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="donationDate" value="${donationRecordInstance?.donationDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: donationRecordInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="donationRecord.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="amount" value="${fieldValue(bean: donationRecordInstance, field: 'amount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: donationRecordInstance, field: 'scheme', 'error')} ">
	<label for="scheme">
		<g:message code="donationRecord.scheme.label" default="Scheme" />
		
	</label>
	<g:select name="scheme.id" from="${ics.Scheme.list()}" optionKey="id" value="${donationRecordInstance?.scheme?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: donationRecordInstance, field: 'centre', 'error')} ">
	<label for="center">
		<g:message code="donationRecord.scheme.label" default="Centre" />
		
	</label>
	<g:select name="centre.id" from="${ics.Centre.list()}" optionKey="id" value="${donationRecordInstance?.centre?.id}" noSelection="['null': '']" />

</div>


<div class="fieldcontain ${hasErrors(bean: donationRecordInstance, field: 'reference', 'error')} ">
	<label for="reference">
		<g:message code="donationRecord.reference.label" default="Reference" />
		
	</label>
	<g:textField name="reference" value="${fieldValue(bean: donationRecordInstance, field: 'reference')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: donationRecordInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="donationRecord.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${fieldValue(bean: donationRecordInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: donationRecordInstance, field: 'mode', 'error')} ">
	<label for="mode">
		<g:message code="donationRecord.mode.label" default="Mode" />
		
	</label>
	<g:select name="mode.id" from="${ics.PaymentMode.list()}" optionKey="id" value="${donationRecordInstance?.mode?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: donationRecordInstance, field: 'paymentDetails', 'error')} ">
	<label for="paymentDetails">
		<g:message code="donationRecord.paymentDetails.label" default="Payment Details" />
		
	</label>
	<g:textField name="paymentDetails" value="${fieldValue(bean: donationRecordInstance, field: 'paymentDetails')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: donationRecordInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="donationRecord.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: donationRecordInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: donationRecordInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="donationRecord.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: donationRecordInstance, field: 'updator')}" />

</div>

