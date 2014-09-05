<%@ page import="ics.IndividualSeva" %>



<div class="fieldcontain ${hasErrors(bean: individualSevaInstance, field: 'individual', 'error')} required">
	<label for="individual">
		<g:message code="individualSeva.individual.label" default="Individual" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="individual" name="individual.id" from="${ics.Individual.list()}" optionKey="id" required="" value="${individualSevaInstance?.individual?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualSevaInstance, field: 'seva', 'error')} required">
	<label for="seva">
		<g:message code="individualSeva.seva.label" default="Seva" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="seva" name="seva.id" from="${ics.Seva.list()}" optionKey="id" required="" value="${individualSevaInstance?.seva?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualSevaInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="individualSeva.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${individualSevaInstance?.status}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualSevaInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="individualSeva.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${individualSevaInstance?.comments}"/>
</div>

