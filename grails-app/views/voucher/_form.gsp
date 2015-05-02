<%@ page import="ics.Voucher" %>



<div class="fieldcontain ${hasErrors(bean: voucherInstance, field: 'voucherDate', 'error')} required">
	<label for="voucherDate">
		<g:message code="voucher.voucherDate.label" default="Voucher Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="voucherDate" value="${voucherInstance?.voucherDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: voucherInstance, field: 'departmentCode', 'error')} required">
	<label for="departmentCode">
		<g:message code="voucher.departmentCode.label" default="Department Code" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="departmentCode.id" from="${ics.CostCenter.findAllByStatusIsNull()}" optionKey="id" value="${voucherInstance?.departmentCode?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: voucherInstance, field: 'voucherNo', 'error')} ">
	<label for="voucherNo">
		<g:message code="voucher.voucherNo.label" default="Voucher No" />
		
	</label>
	<g:textField name="voucherNo" value="${fieldValue(bean: voucherInstance, field: 'voucherNo')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: voucherInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="voucher.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="amount" value="${fieldValue(bean: voucherInstance, field: 'amount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: voucherInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="voucher.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${fieldValue(bean: voucherInstance, field: 'description')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: voucherInstance, field: 'amountSettled', 'error')} ">
	<label for="amountSettled">
		<g:message code="voucher.amountSettled.label" default="Amount Settled" />
		
	</label>
	<g:textField name="amountSettled" value="${fieldValue(bean: voucherInstance, field: 'amountSettled')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: voucherInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="voucher.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: voucherInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: voucherInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="voucher.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: voucherInstance, field: 'updator')}" />

</div>

