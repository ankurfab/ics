<%@ page import="ics.QuestionPaper" %>



<div class="fieldcontain ${hasErrors(bean: questionPaperInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="questionPaper.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: questionPaperInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionPaperInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="questionPaper.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${fieldValue(bean: questionPaperInstance, field: 'description')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionPaperInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="questionPaper.status.label" default="Status" />
		
	</label>
	<g:select name="status" from="${questionPaperInstance.constraints.status.inList}" value="${questionPaperInstance.status}" valueMessagePrefix="questionPaper.status"  />

</div>

<div class="fieldcontain ${hasErrors(bean: questionPaperInstance, field: 'randomize', 'error')} ">
	<label for="randomize">
		<g:message code="questionPaper.randomize.label" default="Randomize" />
		
	</label>
	<g:checkBox name="randomize" value="${questionPaperInstance?.randomize}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionPaperInstance, field: 'totalMarks', 'error')} required">
	<label for="totalMarks">
		<g:message code="questionPaper.totalMarks.label" default="Total Marks" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="totalMarks" value="${fieldValue(bean: questionPaperInstance, field: 'totalMarks')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionPaperInstance, field: 'compiledBy', 'error')} ">
	<label for="compiledBy">
		<g:message code="questionPaper.compiledBy.label" default="Compiled By" />
		
	</label>
	<g:select name="compiledBy.id" from="${ics.Individual.list()}" optionKey="id" value="${questionPaperInstance?.compiledBy?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionPaperInstance, field: 'verifiedBy', 'error')} ">
	<label for="verifiedBy">
		<g:message code="questionPaper.verifiedBy.label" default="Verified By" />
		
	</label>
	<g:select name="verifiedBy.id" from="${ics.Individual.list()}" optionKey="id" value="${questionPaperInstance?.verifiedBy?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionPaperInstance, field: 'course', 'error')} ">
	<label for="course">
		<g:message code="questionPaper.course.label" default="Course" />
		
	</label>
	<g:select name="course.id" from="${ics.Course.list()}" optionKey="id" value="${questionPaperInstance?.course?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionPaperInstance, field: 'department', 'error')} ">
	<label for="department">
		<g:message code="questionPaper.department.label" default="Department" />
		
	</label>
	<g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${questionPaperInstance?.department?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionPaperInstance, field: 'assessment', 'error')} required">
	<label for="assessment">
		<g:message code="questionPaper.assessment.label" default="Assessment" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="assessment.id" from="${ics.Assessment.list()}" optionKey="id" value="${questionPaperInstance?.assessment?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: questionPaperInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="questionPaper.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: questionPaperInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionPaperInstance, field: 'questions', 'error')} ">
	<label for="questions">
		<g:message code="questionPaper.questions.label" default="Questions" />
		
	</label>
	<g:select name="questions"
from="${ics.Question.list()}"
size="5" multiple="yes" optionKey="id"
value="${questionPaperInstance?.questions}" />


</div>

<div class="fieldcontain ${hasErrors(bean: questionPaperInstance, field: 'timeLimit', 'error')} required">
	<label for="timeLimit">
		<g:message code="questionPaper.timeLimit.label" default="Time Limit" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="timeLimit" value="${fieldValue(bean: questionPaperInstance, field: 'timeLimit')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionPaperInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="questionPaper.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: questionPaperInstance, field: 'updator')}" />

</div>

