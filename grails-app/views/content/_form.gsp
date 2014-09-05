<%@ page import="ics.Content" %>



<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="content.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: contentInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="content.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${fieldValue(bean: contentInstance, field: 'description')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'htmlContent', 'error')} ">
	<label for="htmlContent">
		<g:message code="content.htmlContent.label" default="Html Content" />
		
	</label>
	<g:textArea name="htmlContent" value="${fieldValue(bean: contentInstance, field: 'htmlContent')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="content.category.label" default="Category" />
		
	</label>
	<g:select name="category" from="${contentInstance.constraints.category.inList}" value="${contentInstance.category}" valueMessagePrefix="content.category"  />

</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="content.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${fieldValue(bean: contentInstance, field: 'type')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'language', 'error')} ">
	<label for="language">
		<g:message code="content.language.label" default="Language" />
		
	</label>
	<g:select name="language" from="${contentInstance.constraints.language.inList}" value="${contentInstance.language}" valueMessagePrefix="content.language"  />

</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="content.status.label" default="Status" />
		
	</label>
	<g:select name="status" from="${contentInstance.constraints.status.inList}" value="${contentInstance.status}" valueMessagePrefix="content.status"  />

</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'department', 'error')} ">
	<label for="department">
		<g:message code="content.department.label" default="Department" />
		
	</label>
	<g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${contentInstance?.department?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'course', 'error')} ">
	<label for="course">
		<g:message code="content.course.label" default="Course" />
		
	</label>
	<g:select name="course.id" from="${ics.Course.list()}" optionKey="id" value="${contentInstance?.course?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'assessment', 'error')} ">
	<label for="assessment">
		<g:message code="content.assessment.label" default="Assessment" />
		
	</label>
	<g:select name="assessment.id" from="${ics.Assessment.list()}" optionKey="id" value="${contentInstance?.assessment?.id}" noSelection="['null': '']" />

</div>
