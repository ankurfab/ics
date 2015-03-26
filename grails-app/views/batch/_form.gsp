<%@ page import="ics.Batch" %>



<div class="fieldcontain ${hasErrors(bean: batchInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="batch.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${fieldValue(bean: batchInstance, field: 'category')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="batch.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${fieldValue(bean: batchInstance, field: 'type')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="batch.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: batchInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="batch.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${fieldValue(bean: batchInstance, field: 'description')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchInstance, field: 'ref', 'error')} ">
	<label for="ref">
		<g:message code="batch.ref.label" default="Ref" />
		
	</label>
	<g:textField name="ref" value="${fieldValue(bean: batchInstance, field: 'ref')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchInstance, field: 'fromDate', 'error')} required">
	<label for="fromDate">
		<g:message code="batch.fromDate.label" default="From Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="fromDate" value="${batchInstance?.fromDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: batchInstance, field: 'toDate', 'error')} required">
	<label for="toDate">
		<g:message code="batch.toDate.label" default="To Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="toDate" value="${batchInstance?.toDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: batchInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="batch.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${fieldValue(bean: batchInstance, field: 'status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="batch.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: batchInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="batch.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: batchInstance, field: 'updator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: batchInstance, field: 'items', 'error')} ">
	<label for="items">
		<g:message code="batch.items.label" default="Items" />
		
	</label>
	
<ul>
<g:each in="${batchInstance?.items}" var="batchItemInstance">
    <li><g:link controller="batchItem" action="show" id="${batchItemInstance.id}">${batchItemInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="batchItem" params="['batch.id': batchInstance?.id]" action="create"><g:message code="batchItem.new" default="New BatchItem" /></g:link>


</div>

