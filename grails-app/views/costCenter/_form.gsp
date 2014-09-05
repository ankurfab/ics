<%@ page import="ics.CostCenter" %>



<div class="fieldcontain ${hasErrors(bean: costCenterInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="costCenter.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: costCenterInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: costCenterInstance, field: 'alias', 'error')} ">
	<label for="alias">
		<g:message code="costCenter.alias.label" default="Alias" />
		
	</label>
	<g:textField name="alias" value="${fieldValue(bean: costCenterInstance, field: 'alias')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: costCenterInstance, field: 'budget', 'error')} ">
	<label for="budget">
		<g:message code="costCenter.budget.label" default="Budget" />
		
	</label>
	<g:textField name="budget" value="${fieldValue(bean: costCenterInstance, field: 'budget')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: costCenterInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="costCenter.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: costCenterInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: costCenterInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="costCenter.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: costCenterInstance, field: 'updator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: costCenterInstance, field: 'costCategory', 'error')} required">
	<label for="costCategory">
		<g:message code="costCenter.costCategory.label" default="Cost Category" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="costCategory.id" from="${ics.CostCategory.list()}" optionKey="id" value="${costCenterInstance?.costCategory?.id}"  />

</div>

