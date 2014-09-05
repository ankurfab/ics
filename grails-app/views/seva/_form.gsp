<%@ page import="ics.Seva" %>



<div class="fieldcontain ${hasErrors(bean: sevaInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="seva.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${sevaInstance?.category}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sevaInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="seva.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${sevaInstance?.type}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sevaInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="seva.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${sevaInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sevaInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="seva.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${sevaInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sevaInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="seva.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${sevaInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sevaInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="seva.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${sevaInstance?.updator}"/>
</div>

