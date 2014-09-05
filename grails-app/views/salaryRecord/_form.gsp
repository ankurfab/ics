<%@ page import="ics.SalaryRecord" %>



<div class="fieldcontain ${hasErrors(bean: salaryRecordInstance, field: 'datePaid', 'error')} required">
	<label for="datePaid">
		<g:message code="salaryRecord.datePaid.label" default="Date Paid" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="datePaid" value="${salaryRecordInstance?.datePaid}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: salaryRecordInstance, field: 'amountPaid', 'error')} required">
	<label for="amountPaid">
		<g:message code="salaryRecord.amountPaid.label" default="Amount Paid" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="amountPaid" value="${fieldValue(bean: salaryRecordInstance, field: 'amountPaid')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: salaryRecordInstance, field: 'paymentDetails', 'error')} ">
	<label for="paymentDetails">
		<g:message code="salaryRecord.paymentDetails.label" default="Payment Details" />
		
	</label>
	<g:textField name="paymentDetails" value="${fieldValue(bean: salaryRecordInstance, field: 'paymentDetails')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: salaryRecordInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="salaryRecord.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${fieldValue(bean: salaryRecordInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: salaryRecordInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="salaryRecord.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: salaryRecordInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: salaryRecordInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="salaryRecord.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: salaryRecordInstance, field: 'updator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: salaryRecordInstance, field: 'indDep', 'error')} required">
	<label for="indDep">
		<g:message code="salaryRecord.indDep.label" default="Ind Dep" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="indDep.id" from="${ics.IndividualDepartment.list()}" optionKey="id" value="${salaryRecordInstance?.indDep?.id}"  />

</div>

