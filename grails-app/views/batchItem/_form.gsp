<%@ page import="ics.BatchItem" %>



<div class="fieldcontain ${hasErrors(bean: batchItemInstance, field: 'postingDate', 'error')} required">
	<label for="postingDate">
		<g:message code="batchItem.postingDate.label" default="Posting Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="postingDate" value="${batchItemInstance?.postingDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: batchItemInstance, field: 'effectiveDate', 'error')} ">
	<label for="effectiveDate">
		<g:message code="batchItem.effectiveDate.label" default="Effective Date" />
		
	</label>
	<g:datePicker name="effectiveDate" value="${batchItemInstance?.effectiveDate}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchItemInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="batchItem.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${fieldValue(bean: batchItemInstance, field: 'description')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchItemInstance, field: 'ref', 'error')} ">
	<label for="ref">
		<g:message code="batchItem.ref.label" default="Ref" />
		
	</label>
	<g:textField name="ref" value="${fieldValue(bean: batchItemInstance, field: 'ref')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchItemInstance, field: 'debit', 'error')} ">
	<label for="debit">
		<g:message code="batchItem.debit.label" default="Debit" />
		
	</label>
	<g:checkBox name="debit" value="${batchItemInstance?.debit}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchItemInstance, field: 'grossAmount', 'error')} required">
	<label for="grossAmount">
		<g:message code="batchItem.grossAmount.label" default="Gross Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="grossAmount" value="${fieldValue(bean: batchItemInstance, field: 'grossAmount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchItemInstance, field: 'netAmount', 'error')} ">
	<label for="netAmount">
		<g:message code="batchItem.netAmount.label" default="Net Amount" />
		
	</label>
	<g:textField name="netAmount" value="${fieldValue(bean: batchItemInstance, field: 'netAmount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchItemInstance, field: 'linkedEntityName', 'error')} ">
	<label for="linkedEntityName">
		<g:message code="batchItem.linkedEntityName.label" default="Linked Entity Name" />
		
	</label>
	<g:textField name="linkedEntityName" value="${fieldValue(bean: batchItemInstance, field: 'linkedEntityName')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchItemInstance, field: 'linkedEntityRef', 'error')} ">
	<label for="linkedEntityRef">
		<g:message code="batchItem.linkedEntityRef.label" default="Linked Entity Ref" />
		
	</label>
	<g:textField name="linkedEntityRef" value="${fieldValue(bean: batchItemInstance, field: 'linkedEntityRef')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchItemInstance, field: 'linkedEntityId', 'error')} ">
	<label for="linkedEntityId">
		<g:message code="batchItem.linkedEntityId.label" default="Linked Entity Id" />
		
	</label>
	<g:textField name="linkedEntityId" value="${fieldValue(bean: batchItemInstance, field: 'linkedEntityId')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchItemInstance, field: 'linkedBatchRef', 'error')} ">
	<label for="linkedBatchRef">
		<g:message code="batchItem.linkedBatchRef.label" default="Linked Batch Ref" />
		
	</label>
	<g:textField name="linkedBatchRef" value="${fieldValue(bean: batchItemInstance, field: 'linkedBatchRef')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchItemInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="batchItem.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${fieldValue(bean: batchItemInstance, field: 'status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchItemInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="batchItem.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: batchItemInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchItemInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="batchItem.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: batchItemInstance, field: 'updator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchItemInstance, field: 'batch', 'error')} required">
	<label for="batch">
		<g:message code="batchItem.batch.label" default="Batch" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="batch.id" from="${ics.Batch.list()}" optionKey="id" value="${batchItemInstance?.batch?.id}"  />

</div>

