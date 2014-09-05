<%@ page import="ics.LeaveRecord" %>



<div class="fieldcontain ${hasErrors(bean: leaveRecordInstance, field: 'dateFrom', 'error')} required">
	<label for="dateFrom">
		<g:message code="leaveRecord.dateFrom.label" default="Date From" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dateFrom" value="${leaveRecordInstance?.dateFrom}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: leaveRecordInstance, field: 'dateTill', 'error')} required">
	<label for="dateTill">
		<g:message code="leaveRecord.dateTill.label" default="Date Till" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dateTill" value="${leaveRecordInstance?.dateTill}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: leaveRecordInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="leaveRecord.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${fieldValue(bean: leaveRecordInstance, field: 'status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: leaveRecordInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="leaveRecord.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${fieldValue(bean: leaveRecordInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: leaveRecordInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="leaveRecord.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: leaveRecordInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: leaveRecordInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="leaveRecord.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: leaveRecordInstance, field: 'updator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: leaveRecordInstance, field: 'indDep', 'error')} required">
	<label for="indDep">
		<g:message code="leaveRecord.indDep.label" default="Ind Dep" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="indDep.id" from="${ics.IndividualDepartment.list()}" optionKey="id" value="${leaveRecordInstance?.indDep?.id}"  />

</div>

