<%@ page import="ics.Question" %>



<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'questionText', 'error')} ">
	<label for="questionText">
		<g:message code="question.questionText.label" default="Question Text" />
		
	</label>
	<g:textArea name="questionText" rows="5" cols="40" value="${fieldValue(bean: questionInstance, field: 'questionText')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'choice1', 'error')} ">
	<label for="choice1">
		<g:message code="question.choice1.label" default="Choice1" />
		
	</label>
	<g:textArea name="choice1" rows="5" cols="40" value="${fieldValue(bean: questionInstance, field: 'choice1')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'choice2', 'error')} ">
	<label for="choice2">
		<g:message code="question.choice2.label" default="Choice2" />
		
	</label>
	<g:textArea name="choice2" rows="5" cols="40" value="${fieldValue(bean: questionInstance, field: 'choice2')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'choice3', 'error')} ">
	<label for="choice3">
		<g:message code="question.choice3.label" default="Choice3" />
		
	</label>
	<g:textArea name="choice3" rows="5" cols="40" value="${fieldValue(bean: questionInstance, field: 'choice3')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'choice4', 'error')} ">
	<label for="choice4">
		<g:message code="question.choice4.label" default="Choice4" />
		
	</label>
	<g:textArea name="choice4" rows="5" cols="40" value="${fieldValue(bean: questionInstance, field: 'choice4')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'isChoice1Correct', 'error')} ">
	<label for="isChoice1Correct">
		<g:message code="question.isChoice1Correct.label" default="Is Choice1 Correct" />
		
	</label>
	<g:checkBox name="isChoice1Correct" value="${questionInstance?.isChoice1Correct}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'isChoice2Correct', 'error')} ">
	<label for="isChoice2Correct">
		<g:message code="question.isChoice2Correct.label" default="Is Choice2 Correct" />
		
	</label>
	<g:checkBox name="isChoice2Correct" value="${questionInstance?.isChoice2Correct}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'isChoice3Correct', 'error')} ">
	<label for="isChoice3Correct">
		<g:message code="question.isChoice3Correct.label" default="Is Choice3 Correct" />
		
	</label>
	<g:checkBox name="isChoice3Correct" value="${questionInstance?.isChoice3Correct}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'isChoice4Correct', 'error')} ">
	<label for="isChoice4Correct">
		<g:message code="question.isChoice4Correct.label" default="Is Choice4 Correct" />
		
	</label>
	<g:checkBox name="isChoice4Correct" value="${questionInstance?.isChoice4Correct}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'marks', 'error')} required">
	<label for="marks">
		<g:message code="question.marks.label" default="Marks" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="marks" value="${fieldValue(bean: questionInstance, field: 'marks')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'hint', 'error')} ">
	<label for="hint">
		<g:message code="question.hint.label" default="Hint" />
		
	</label>
	<g:textArea name="hint" rows="5" cols="40" value="${fieldValue(bean: questionInstance, field: 'hint')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'info', 'error')} ">
	<label for="info">
		<g:message code="question.info.label" default="Info" />
		
	</label>
	<g:textArea name="info" rows="5" cols="40" value="${fieldValue(bean: questionInstance, field: 'info')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="question.status.label" default="Status" />
		
	</label>
	<g:select name="status" from="${questionInstance.constraints.status.inList}" value="${questionInstance.status}" valueMessagePrefix="question.status"  />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="question.type.label" default="Type" />
		
	</label>
	<g:select name="type" from="${questionInstance.constraints.type.inList}" value="${questionInstance.type}" valueMessagePrefix="question.type"  />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'level', 'error')} ">
	<label for="level">
		<g:message code="question.level.label" default="Level" />
		
	</label>
	<g:select name="level" from="${questionInstance.constraints.level.inList}" value="${questionInstance.level}" valueMessagePrefix="question.level"  />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="question.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${fieldValue(bean: questionInstance, field: 'category')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'course', 'error')} ">
	<label for="course">
		<g:message code="question.course.label" default="Course" />
		
	</label>
	<g:select name="course.id" from="${ics.Course.list()}" optionKey="id" value="${questionInstance?.course?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="question.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: questionInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'tags', 'error')} ">
	<label for="tags">
		<g:message code="question.tags.label" default="Tags" />
		
	</label>
	<g:select name="tags"
from="${ics.Tag.list()}"
size="5" multiple="yes" optionKey="id"
value="${questionInstance?.tags}" />


</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="question.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: questionInstance, field: 'updator')}" />

</div>

