<%@ page import="ics.Course" %>



<div class="fieldcontain ${hasErrors(bean: courseInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="course.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${courseInstance?.category}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: courseInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="course.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${courseInstance?.type}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: courseInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="course.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${courseInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: courseInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="course.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${courseInstance?.description}"/>
</div>
