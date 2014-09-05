<%@ page import="ics.Skill" %>



<div class="fieldcontain ${hasErrors(bean: skillInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="skill.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${skillInstance?.category}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: skillInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="skill.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${skillInstance?.type}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: skillInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="skill.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${skillInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: skillInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="skill.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${skillInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: skillInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="skill.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${skillInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: skillInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="skill.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${skillInstance?.updator}"/>
</div>

