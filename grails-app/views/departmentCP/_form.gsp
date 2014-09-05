<%@ page import="ics.DepartmentCP" %>



<div class="fieldcontain ${hasErrors(bean: departmentCPInstance, field: 'sender', 'error')} ">
	<label for="sender">
		<g:message code="departmentCP.sender.label" default="Sender" />
		
	</label>
	<g:textField name="sender" value="${fieldValue(bean: departmentCPInstance, field: 'sender')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: departmentCPInstance, field: 'cp', 'error')} required">
	<label for="cp">
		<g:message code="departmentCP.cp.label" default="Cp" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="cp.id" from="${ics.CommsProvider.list()}" optionKey="id" value="${departmentCPInstance?.cp?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: departmentCPInstance, field: 'department', 'error')} required">
	<label for="department">
		<g:message code="departmentCP.department.label" default="Department" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${departmentCPInstance?.department?.id}"  />

</div>

