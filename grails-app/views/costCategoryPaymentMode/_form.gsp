<%@ page import="ics.CostCategoryPaymentMode" %>



<div class="fieldcontain ${hasErrors(bean: costCategoryPaymentModeInstance, field: 'costCategory', 'error')} required">
	<label for="costCategory">
		<g:message code="costCategoryPaymentMode.costCategory.label" default="Cost Category" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="costCategory.id" from="${ics.CostCategory.list()}" optionKey="id" value="${costCategoryPaymentModeInstance?.costCategory?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: costCategoryPaymentModeInstance, field: 'paymentMode', 'error')} required">
	<label for="paymentMode">
		<g:message code="costCategoryPaymentMode.paymentMode.label" default="Payment Mode" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="paymentMode.id" from="${ics.PaymentMode.list()}" optionKey="id" value="${costCategoryPaymentModeInstance?.paymentMode?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: costCategoryPaymentModeInstance, field: 'bankCode', 'error')} ">
	<label for="bankCode">
		<g:message code="costCategoryPaymentMode.bankCode.label" default="Bank Code" />
		
	</label>
	<g:textField name="bankCode" value="${fieldValue(bean: costCategoryPaymentModeInstance, field: 'bankCode')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: costCategoryPaymentModeInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="costCategoryPaymentMode.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: costCategoryPaymentModeInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: costCategoryPaymentModeInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="costCategoryPaymentMode.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: costCategoryPaymentModeInstance, field: 'updator')}" />

</div>

