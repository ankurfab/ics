<%@ page import="ics.IndividualAssessment" %>



<div class="fieldcontain ${hasErrors(bean: individualAssessmentInstance, field: 'assessmentCode', 'error')} ">
	<label for="assessmentCode">
		<g:message code="individualAssessment.assessmentCode.label" default="Assessment Code" />
		
	</label>
	<g:textField name="assessmentCode" value="${fieldValue(bean: individualAssessmentInstance, field: 'assessmentCode')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentInstance, field: 'individual', 'error')} required">
	<label for="individual">
		<g:message code="individualAssessment.individual.label" default="Individual" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="individual.id" from="${ics.Individual.list()}" optionKey="id" value="${individualAssessmentInstance?.individual?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentInstance, field: 'assessment', 'error')} required">
	<label for="assessment">
		<g:message code="individualAssessment.assessment.label" default="Assessment" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="assessment.id" from="${ics.Assessment.list()}" optionKey="id" value="${individualAssessmentInstance?.assessment?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentInstance, field: 'questionPaper', 'error')} required">
	<label for="questionPaper">
		<g:message code="individualAssessment.questionPaper.label" default="Question Paper" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="questionPaper.id" from="${ics.QuestionPaper.list()}" optionKey="id" value="${individualAssessmentInstance?.questionPaper?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentInstance, field: 'assessmentDate', 'error')} required">
	<label for="assessmentDate">
		<g:message code="individualAssessment.assessmentDate.label" default="Assessment Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="assessmentDate" value="${individualAssessmentInstance?.assessmentDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="individualAssessment.status.label" default="Status" />
		
	</label>
	<g:select name="status" from="${individualAssessmentInstance.constraints.status.inList}" value="${individualAssessmentInstance.status}" valueMessagePrefix="individualAssessment.status"  />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="individualAssessment.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${fieldValue(bean: individualAssessmentInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentInstance, field: 'score', 'error')} required">
	<label for="score">
		<g:message code="individualAssessment.score.label" default="Score" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="score" value="${fieldValue(bean: individualAssessmentInstance, field: 'score')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentInstance, field: 'timeTaken', 'error')} ">
	<label for="timeTaken">
		<g:message code="individualAssessment.timeTaken.label" default="Time Taken" />
		
	</label>
	<g:textField name="timeTaken" value="${fieldValue(bean: individualAssessmentInstance, field: 'timeTaken')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentInstance, field: 'certificateIssued', 'error')} ">
	<label for="certificateIssued">
		<g:message code="individualAssessment.certificateIssued.label" default="Certificate Issued" />
		
	</label>
	<g:checkBox name="certificateIssued" value="${individualAssessmentInstance?.certificateIssued}" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentInstance, field: 'answers', 'error')} ">
	<label for="answers">
		<g:message code="individualAssessment.answers.label" default="Answers" />
		
	</label>
	
<ul>
<g:each in="${individualAssessmentInstance?.answers}" var="individualAssessmentQAInstance">
    <li><g:link controller="individualAssessmentQA" action="show" id="${individualAssessmentQAInstance.id}">${individualAssessmentQAInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="individualAssessmentQA" params="['individualAssessment.id': individualAssessmentInstance?.id]" action="create"><g:message code="individualAssessmentQA.new" default="New IndividualAssessmentQA" /></g:link>


</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="individualAssessment.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: individualAssessmentInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: individualAssessmentInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="individualAssessment.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: individualAssessmentInstance, field: 'updator')}" />

</div>

