<%@ page import="ics.IndividualDepartment" %>



<div class="fieldcontain ${hasErrors(bean: individualDepartmentInstance, field: 'individual', 'error')} required">
	<label for="individual">
		<g:message code="individualDepartment.individual.label" default="Individual" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="individual.id" from="${ics.Individual.list()}" optionKey="id" value="${individualDepartmentInstance?.individual?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: individualDepartmentInstance, field: 'department', 'error')} required">
	<label for="department">
		<g:message code="individualDepartment.department.label" default="Department" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${individualDepartmentInstance?.department?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: individualDepartmentInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="individualDepartment.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${fieldValue(bean: individualDepartmentInstance, field: 'status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualDepartmentInstance, field: 'salary', 'error')} ">
	<label for="salary">
		<g:message code="individualDepartment.salary.label" default="Salary" />
		
	</label>
	<g:textField name="salary" value="${fieldValue(bean: individualDepartmentInstance, field: 'salary')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualDepartmentInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="individualDepartment.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${fieldValue(bean: individualDepartmentInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualDepartmentInstance, field: 'since', 'error')} ">
	<label for="since">
		<g:message code="individualDepartment.since.label" default="Since" />
		
	</label>
	<g:datePicker name="since" value="${individualDepartmentInstance?.since}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualDepartmentInstance, field: 'till', 'error')} ">
	<label for="till">
		<g:message code="individualDepartment.till.label" default="Till" />
		
	</label>
	<g:datePicker name="till" value="${individualDepartmentInstance?.till}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualDepartmentInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="individualDepartment.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: individualDepartmentInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualDepartmentInstance, field: 'leaveRecords', 'error')} ">
	<label for="leaveRecords">
		<g:message code="individualDepartment.leaveRecords.label" default="Leave Records" />
		
	</label>
	
<ul>
<g:each in="${individualDepartmentInstance?.leaveRecords}" var="leaveRecordInstance">
    <li><g:link controller="leaveRecord" action="show" id="${leaveRecordInstance.id}">${leaveRecordInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="leaveRecord" params="['individualDepartment.id': individualDepartmentInstance?.id]" action="create"><g:message code="leaveRecord.new" default="New LeaveRecord" /></g:link>


</div>

<div class="fieldcontain ${hasErrors(bean: individualDepartmentInstance, field: 'salaryRecords', 'error')} ">
	<label for="salaryRecords">
		<g:message code="individualDepartment.salaryRecords.label" default="Salary Records" />
		
	</label>
	
<ul>
<g:each in="${individualDepartmentInstance?.salaryRecords}" var="salaryRecordInstance">
    <li><g:link controller="salaryRecord" action="show" id="${salaryRecordInstance.id}">${salaryRecordInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="salaryRecord" params="['individualDepartment.id': individualDepartmentInstance?.id]" action="create"><g:message code="salaryRecord.new" default="New SalaryRecord" /></g:link>


</div>

<div class="fieldcontain ${hasErrors(bean: individualDepartmentInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="individualDepartment.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: individualDepartmentInstance, field: 'updator')}" />

</div>

