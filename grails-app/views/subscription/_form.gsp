<%@ page import="ics.Subscription" %>



<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="subscription.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="amount" value="${fieldValue(bean: subscriptionInstance, field: 'amount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="subscription.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: subscriptionInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'deliveryChannel', 'error')} ">
	<label for="deliveryChannel">
		<g:message code="subscription.deliveryChannel.label" default="Delivery Channel" />
		
	</label>
	<g:textField name="deliveryChannel" value="${fieldValue(bean: subscriptionInstance, field: 'deliveryChannel')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'frequency', 'error')} ">
	<label for="frequency">
		<g:message code="subscription.frequency.label" default="Frequency" />
		
	</label>
	<g:textField name="frequency" value="${fieldValue(bean: subscriptionInstance, field: 'frequency')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'paymentDate', 'error')} required">
	<label for="paymentDate">
		<g:message code="subscription.paymentDate.label" default="Payment Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="paymentDate" value="${subscriptionInstance?.paymentDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'paymentReference', 'error')} ">
	<label for="paymentReference">
		<g:message code="subscription.paymentReference.label" default="Payment Reference" />
		
	</label>
	<g:textField name="paymentReference" value="${fieldValue(bean: subscriptionInstance, field: 'paymentReference')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'periodical', 'error')} required">
	<label for="periodical">
		<g:message code="subscription.periodical.label" default="Periodical" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="periodical.id" from="${ics.Book.list()}" optionKey="id" value="${subscriptionInstance?.periodical?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'since', 'error')} required">
	<label for="since">
		<g:message code="subscription.since.label" default="Since" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="since" value="${subscriptionInstance?.since}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="subscription.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${fieldValue(bean: subscriptionInstance, field: 'status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'subscriber', 'error')} required">
	<label for="subscriber">
		<g:message code="subscription.subscriber.label" default="Subscriber" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="subscriber.id" from="${ics.Individual.list()}" optionKey="id" value="${subscriptionInstance?.subscriber?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'subscriptionNumber', 'error')} ">
	<label for="subscriptionNumber">
		<g:message code="subscription.subscriptionNumber.label" default="Subscription Number" />
		
	</label>
	<g:textField name="subscriptionNumber" value="${fieldValue(bean: subscriptionInstance, field: 'subscriptionNumber')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'till', 'error')} required">
	<label for="till">
		<g:message code="subscription.till.label" default="Till" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="till" value="${subscriptionInstance?.till}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="subscription.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: subscriptionInstance, field: 'updator')}" />

</div>

