<%@ page import="ics.Department" %>



<div class="fieldcontain ${hasErrors(bean: departmentInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="department.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${departmentInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: departmentInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="department.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${departmentInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: departmentInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="department.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${departmentInstance?.updator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: departmentInstance, field: 'centre', 'error')} required">
	<label for="centre">
		<g:message code="department.centre.label" default="Centre" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="centre" name="centre.id" from="${ics.Centre.list()}" optionKey="id" required="" value="${departmentInstance?.centre?.id}" class="many-to-one"/>
</div>

