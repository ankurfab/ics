<%@ page import="ics.SchemeMember" %>



<div class="fieldcontain ${hasErrors(bean: schemeMemberInstance, field: 'scheme', 'error')} required">
	<label for="scheme">
		<g:message code="schemeMember.scheme.label" default="Scheme" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="scheme.id" from="${ics.Scheme.list()}" optionKey="id" value="${schemeMemberInstance?.scheme?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: schemeMemberInstance, field: 'member', 'error')} required">
	<label for="member">
		<g:message code="schemeMember.member.label" default="Member" />
		<span class="required-indicator">*</span>
	</label>
	${schemeMemberInstance?.member?.encodeAsHTML()}<g:hiddenField name="member.id" value="${schemeMemberInstance?.member?.id}" />
	

</div>

<div class="fieldcontain ${hasErrors(bean: schemeMemberInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="schemeMember.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${fieldValue(bean: schemeMemberInstance, field: 'status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: schemeMemberInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="schemeMember.comments.label" default="Comments" />
		
	</label>
	<g:textArea name="comments" rows="5" cols="40" value="${fieldValue(bean: schemeMemberInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: schemeMemberInstance, field: 'startComments', 'error')} ">
	<label for="startComments">
		<g:message code="schemeMember.startComments.label" default="Start Comments" />
		
	</label>
	<g:textArea name="startComments" rows="5" cols="40" value="${fieldValue(bean: schemeMemberInstance, field: 'startComments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: schemeMemberInstance, field: 'stopComments', 'error')} ">
	<label for="stopComments">
		<g:message code="schemeMember.stopComments.label" default="Stop Comments" />
		
	</label>
	<g:textArea name="stopComments" rows="5" cols="40" value="${fieldValue(bean: schemeMemberInstance, field: 'stopComments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: schemeMemberInstance, field: 'startDate', 'error')} required">
	<label for="startDate">
		<g:message code="schemeMember.startDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="startDate" value="${schemeMemberInstance?.startDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: schemeMemberInstance, field: 'stopDate', 'error')} ">
	<label for="stopDate">
		<g:message code="schemeMember.stopDate.label" default="Stop Date" />
		
	</label>
	<g:datePicker name="stopDate" value="${schemeMemberInstance?.stopDate}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: schemeMemberInstance, field: 'committedFrequency', 'error')} ">
	<label for="committedFrequency">
		<g:message code="schemeMember.committedFrequency.label" default="Committed Frequency" />
		
	</label>
	<g:textField name="committedFrequency" value="${fieldValue(bean: schemeMemberInstance, field: 'committedFrequency')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: schemeMemberInstance, field: 'committedAmount', 'error')} ">
	<label for="committedAmount">
		<g:message code="schemeMember.committedAmount.label" default="Committed Amount" />
		
	</label>
	<g:textField name="committedAmount" value="${fieldValue(bean: schemeMemberInstance, field: 'committedAmount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: schemeMemberInstance, field: 'committedMode', 'error')} ">
	<label for="committedMode">
		<g:message code="schemeMember.committedMode.label" default="Committed Mode" />
		
	</label>
	<g:textField name="committedMode" value="${fieldValue(bean: schemeMemberInstance, field: 'committedMode')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: schemeMemberInstance, field: 'committedModeDetails', 'error')} ">
	<label for="committedModeDetails">
		<g:message code="schemeMember.committedModeDetails.label" default="Committed Mode Details" />
		
	</label>
	<g:textField name="committedModeDetails" value="${fieldValue(bean: schemeMemberInstance, field: 'committedModeDetails')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: schemeMemberInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="schemeMember.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: schemeMemberInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: schemeMemberInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="schemeMember.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: schemeMemberInstance, field: 'updator')}" />

</div>

