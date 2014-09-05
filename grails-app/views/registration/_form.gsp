<%@ page import="ics.Registration" %>



<div class="fieldcontain ${hasErrors(bean: registrationInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="registration.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${registrationInstance?.comments}"/>
</div>

