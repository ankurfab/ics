<%@ page import="ics.Attribute" %>



<div class="fieldcontain ${hasErrors(bean: attributeInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="attribute.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: attributeInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: attributeInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="attribute.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${fieldValue(bean: attributeInstance, field: 'type')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: attributeInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="attribute.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${fieldValue(bean: attributeInstance, field: 'category')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: attributeInstance, field: 'department', 'error')} ">
	<label for="department">
		<g:message code="attribute.department.label" default="Department" />
		
	</label>
	<g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${attributeInstance?.department?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: attributeInstance, field: 'centre', 'error')} ">
	<label for="centre">
		<g:message code="attribute.centre.label" default="Centre" />
		
	</label>
	<g:select name="centre.id" from="${ics.Centre.list()}" optionKey="id" value="${attributeInstance?.centre?.id}" noSelection="['null': '']" />

</div>

