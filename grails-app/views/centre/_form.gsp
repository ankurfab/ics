<%@ page import="ics.Centre" %>



<div class="fieldcontain ${hasErrors(bean: centreInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="centre.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${centreInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: centreInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="centre.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${centreInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: centreInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="centre.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${centreInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: centreInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="centre.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${centreInstance?.updator}"/>
</div>

