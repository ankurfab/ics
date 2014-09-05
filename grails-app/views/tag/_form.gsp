<%@ page import="ics.Tag" %>



<div class="fieldcontain ${hasErrors(bean: tagInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="tag.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: tagInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: tagInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="tag.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${fieldValue(bean: tagInstance, field: 'category')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: tagInstance, field: 'department', 'error')} ">
	<label for="department">
		<g:message code="tag.department.label" default="Department" />
		
	</label>
	<g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${tagInstance?.department?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: tagInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="tag.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: tagInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: tagInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="tag.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: tagInstance, field: 'updator')}" />

</div>

