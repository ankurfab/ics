<%@ page import="ics.GiftRecord" %>



<div class="fieldcontain ${hasErrors(bean: giftRecordInstance, field: 'giftedTo', 'error')} required">
	<label for="giftedTo">
		<g:message code="giftRecord.giftedTo.label" default="Gifted To" />
		<span class="required-indicator">*</span>
	</label>
	<g:link controller="individual" action="show" params="['id':giftRecordInstance?.giftedTo?.id,'profile':'true']">${donationRecordInstance?.donatedBy?.encodeAsHTML()}</g:link>

</div>

<div class="fieldcontain ${hasErrors(bean: giftRecordInstance, field: 'gift', 'error')} required">
	<label for="gift">
		<g:message code="giftRecord.gift.label" default="Gift" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="gift.id" from="${ics.Gift.list()}" optionKey="id" value="${giftRecordInstance?.gift?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: giftRecordInstance, field: 'giftDate', 'error')} required">
	<label for="giftDate">
		<g:message code="giftRecord.giftDate.label" default="Gift Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="giftDate" value="${giftRecordInstance?.giftDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: giftRecordInstance, field: 'quantity', 'error')} required">
	<label for="quantity">
		<g:message code="giftRecord.quantity.label" default="Quantity" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="quantity" value="${fieldValue(bean: giftRecordInstance, field: 'quantity')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: giftRecordInstance, field: 'reference', 'error')} ">
	<label for="reference">
		<g:message code="giftRecord.reference.label" default="Reference" />
		
	</label>
	<g:textField name="reference" value="${fieldValue(bean: giftRecordInstance, field: 'reference')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: giftRecordInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="giftRecord.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${fieldValue(bean: giftRecordInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: giftRecordInstance, field: 'giftReceivedStatus', 'error')} ">
	<label for="giftReceivedStatus">
		<g:message code="giftRecord.giftReceivedStatus.label" default="Gift Received Status" />
		
	</label>
	<g:textField name="giftReceivedStatus" value="${fieldValue(bean: giftRecordInstance, field: 'giftReceivedStatus')}" />

</div>
