<%@ page import="ics.Challan" %>



<div class="fieldcontain ${hasErrors(bean: challanInstance, field: 'refNo', 'error')} ">
	<label for="refNo">
		<g:message code="challan.refNo.label" default="Ref No" />
		
	</label>
	<g:textField name="refNo" value="${fieldValue(bean: challanInstance, field: 'refNo')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: challanInstance, field: 'issuedTo', 'error')} required">
	<label for="issuedTo">
		<g:message code="challan.issuedTo.label" default="Issued To" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="issuedTo.id" from="${ics.Individual.list()}" optionKey="id" value="${challanInstance?.issuedTo?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: challanInstance, field: 'issuedBy', 'error')} required">
	<label for="issuedBy">
		<g:message code="challan.issuedBy.label" default="Issued By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="issuedBy.id" from="${ics.Individual.list()}" optionKey="id" value="${challanInstance?.issuedBy?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: challanInstance, field: 'settleBy', 'error')} ">
	<label for="settleBy">
		<g:message code="challan.settleBy.label" default="Settle By" />
		
	</label>
	<g:select name="settleBy.id" from="${ics.Individual.list()}" optionKey="id" value="${challanInstance?.settleBy?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: challanInstance, field: 'issueDate', 'error')} required">
	<label for="issueDate">
		<g:message code="challan.issueDate.label" default="Issue Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="issueDate" value="${challanInstance?.issueDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: challanInstance, field: 'settleDate', 'error')} ">
	<label for="settleDate">
		<g:message code="challan.settleDate.label" default="Settle Date" />
		
	</label>
	<g:datePicker name="settleDate" value="${challanInstance?.settleDate}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: challanInstance, field: 'advanceAmount', 'error')} ">
	<label for="advanceAmount">
		<g:message code="challan.advanceAmount.label" default="Advance Amount" />
		
	</label>
	<g:textField name="advanceAmount" value="${fieldValue(bean: challanInstance, field: 'advanceAmount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: challanInstance, field: 'totalAmount', 'error')} ">
	<label for="totalAmount">
		<g:message code="challan.totalAmount.label" default="Total Amount" />
		
	</label>
	<g:textField name="totalAmount" value="${fieldValue(bean: challanInstance, field: 'totalAmount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: challanInstance, field: 'settleAmount', 'error')} ">
	<label for="settleAmount">
		<g:message code="challan.settleAmount.label" default="Settle Amount" />
		
	</label>
	<g:textField name="settleAmount" value="${fieldValue(bean: challanInstance, field: 'settleAmount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: challanInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="challan.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${fieldValue(bean: challanInstance, field: 'type')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: challanInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="challan.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${fieldValue(bean: challanInstance, field: 'status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: challanInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="challan.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${fieldValue(bean: challanInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: challanInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="challan.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: challanInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: challanInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="challan.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: challanInstance, field: 'updator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: challanInstance, field: 'lineItems', 'error')} ">
	<label for="lineItems">
		<g:message code="challan.lineItems.label" default="Line Items" />
		
	</label>
	
<ul>
<g:each in="${challanInstance?.lineItems}" var="challanLineItemInstance">
    <li><g:link controller="challanLineItem" action="show" id="${challanLineItemInstance.id}">${challanLineItemInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="challanLineItem" params="['challan.id': challanInstance?.id]" action="create"><g:message code="challanLineItem.new" default="New ChallanLineItem" /></g:link>


</div>

<div class="fieldcontain ${hasErrors(bean: challanInstance, field: 'paymentReferences', 'error')} ">
	<label for="paymentReferences">
		<g:message code="challan.paymentReferences.label" default="Payment References" />
		
	</label>
	<g:select name="paymentReferences"
from="${ics.PaymentReference.list()}"
size="5" multiple="yes" optionKey="id"
value="${challanInstance?.paymentReferences}" />


</div>

