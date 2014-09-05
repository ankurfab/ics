<%@ page import="ics.IndividualAssessmentQA" %>



<div class="fieldcontain ${hasErrors(bean: individualAssessmentQAInstance, field: 'individualAssessment', 'error')} required">
	<label for="individualAssessment">
		<g:message code="individualAssessmentQA.individualAssessment.label" default="Individual Assessment" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="individualAssessment.id" from="${ics.IndividualAssessment.list()}" optionKey="id" value="${individualAssessmentQAInstance?.individualAssessment?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentQAInstance, field: 'question', 'error')} required">
	<label for="question">
		<g:message code="individualAssessmentQA.question.label" default="Question" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="question.id" from="${ics.Question.list()}" optionKey="id" value="${individualAssessmentQAInstance?.question?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentQAInstance, field: 'selectedChoice1', 'error')} ">
	<label for="selectedChoice1">
		<g:message code="individualAssessmentQA.selectedChoice1.label" default="Selected Choice1" />
		
	</label>
	<g:checkBox name="selectedChoice1" value="${individualAssessmentQAInstance?.selectedChoice1}" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentQAInstance, field: 'selectedChoice2', 'error')} ">
	<label for="selectedChoice2">
		<g:message code="individualAssessmentQA.selectedChoice2.label" default="Selected Choice2" />
		
	</label>
	<g:checkBox name="selectedChoice2" value="${individualAssessmentQAInstance?.selectedChoice2}" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentQAInstance, field: 'selectedChoice3', 'error')} ">
	<label for="selectedChoice3">
		<g:message code="individualAssessmentQA.selectedChoice3.label" default="Selected Choice3" />
		
	</label>
	<g:checkBox name="selectedChoice3" value="${individualAssessmentQAInstance?.selectedChoice3}" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentQAInstance, field: 'selectedChoice4', 'error')} ">
	<label for="selectedChoice4">
		<g:message code="individualAssessmentQA.selectedChoice4.label" default="Selected Choice4" />
		
	</label>
	<g:checkBox name="selectedChoice4" value="${individualAssessmentQAInstance?.selectedChoice4}" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentQAInstance, field: 'correctAnswer', 'error')} ">
	<label for="correctAnswer">
		<g:message code="individualAssessmentQA.correctAnswer.label" default="Correct Answer" />
		
	</label>
	<g:checkBox name="correctAnswer" value="${individualAssessmentQAInstance?.correctAnswer}" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentQAInstance, field: 'score', 'error')} required">
	<label for="score">
		<g:message code="individualAssessmentQA.score.label" default="Score" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="score" value="${fieldValue(bean: individualAssessmentQAInstance, field: 'score')}" />

</div>

