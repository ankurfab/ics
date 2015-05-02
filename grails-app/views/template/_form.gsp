<%@ page import="ics.Template" %>



<div class="fieldcontain ${hasErrors(bean: templateInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="template.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: templateInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: templateInstance, field: 'code', 'error')} ">
	<label for="code">
		<g:message code="template.code.label" default="Code" />
		
	</label>
	<g:textField name="code" value="${fieldValue(bean: templateInstance, field: 'code')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: templateInstance, field: 'body', 'error')} ">
	<label for="body">
		<g:message code="template.body.label" default="Body" />
		
	</label>
	<g:textArea name="body" rows="5" cols="40" value="${fieldValue(bean: templateInstance, field: 'body')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: templateInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="template.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${fieldValue(bean: templateInstance, field: 'category')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: templateInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="template.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${fieldValue(bean: templateInstance, field: 'type')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: templateInstance, field: 'department', 'error')} ">
	<label for="department">
		<g:message code="template.department.label" default="Department" />
		
	</label>
	<g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${templateInstance?.department?.id}" noSelection="['null': '']" />

</div>

