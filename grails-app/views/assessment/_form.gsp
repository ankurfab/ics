<%@ page import="ics.Assessment" %>



<div class="fieldcontain ${hasErrors(bean: assessmentInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="assessment.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: assessmentInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: assessmentInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="assessment.status.label" default="Status" />
		
	</label>
	<g:select name="status" from="${assessmentInstance.constraints.status.inList}" value="${assessmentInstance.status}" valueMessagePrefix="assessment.status"  />

</div>

<div class="fieldcontain ${hasErrors(bean: assessmentInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="assessment.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${fieldValue(bean: assessmentInstance, field: 'description')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: assessmentInstance, field: 'incharge', 'error')} ">
	<label for="incharge">
		<g:message code="assessment.incharge.label" default="Incharge" />
		
	</label>
	<g:select name="incharge.id" from="${ics.Individual.list()}" optionKey="id" value="${assessmentInstance?.incharge?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: assessmentInstance, field: 'course', 'error')} ">
	<label for="course">
		<g:message code="assessment.course.label" default="Course" />
		
	</label>
	<g:select name="course.id" from="${ics.Course.list()}" optionKey="id" value="${assessmentInstance?.course?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: assessmentInstance, field: 'department', 'error')} ">
	<label for="department">
		<g:message code="assessment.department.label" default="Department" />
		
	</label>
	<g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${assessmentInstance?.department?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: assessmentInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="assessment.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: assessmentInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: assessmentInstance, field: 'questionPapers', 'error')} ">
	<label for="questionPapers">
		<g:message code="assessment.questionPapers.label" default="Question Papers" />
		
	</label>
	
<ul>
<g:each in="${assessmentInstance?.questionPapers}" var="questionPaperInstance">
    <li><g:link controller="questionPaper" action="show" id="${questionPaperInstance.id}">${questionPaperInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="questionPaper" params="['assessment.id': assessmentInstance?.id]" action="create"><g:message code="questionPaper.new" default="New QuestionPaper" /></g:link>


</div>

<div class="fieldcontain ${hasErrors(bean: assessmentInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="assessment.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: assessmentInstance, field: 'updator')}" />

</div>

