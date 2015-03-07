<%@ page import="ics.Project" %>



<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'centre', 'error')} ">
	<label for="centre">
		<g:message code="project.centre.label" default="Centre" />
		
	</label>
	<g:select name="centre.id" from="${ics.Centre.list()}" optionKey="id" value="${projectInstance?.centre?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'department', 'error')} ">
	<label for="department">
		<g:message code="project.department.label" default="Department" />
		
	</label>
	<g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${projectInstance?.department?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'costCenter', 'error')} ">
	<label for="costCenter">
		<g:message code="project.costCenter.label" default="Cost Center" />
		
	</label>
	<g:select name="costCenter.id" from="${ics.CostCenter.list()}" optionKey="id" value="${projectInstance?.costCenter?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="project.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${fieldValue(bean: projectInstance, field: 'category')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="project.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${fieldValue(bean: projectInstance, field: 'type')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="project.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: projectInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="project.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" rows="5" cols="40" value="${fieldValue(bean: projectInstance, field: 'description')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="project.comments.label" default="Comments" />
		
	</label>
	<g:textArea name="comments" rows="5" cols="40" value="${fieldValue(bean: projectInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="project.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${fieldValue(bean: projectInstance, field: 'status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'amount', 'error')} ">
	<label for="amount">
		<g:message code="project.amount.label" default="Amount" />
		
	</label>
	<g:textField name="amount" value="${fieldValue(bean: projectInstance, field: 'amount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'ref', 'error')} ">
	<label for="ref">
		<g:message code="project.ref.label" default="Ref" />
		
	</label>
	<g:textField name="ref" value="${fieldValue(bean: projectInstance, field: 'ref')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'submitter', 'error')} ">
	<label for="submitter">
		<g:message code="project.submitter.label" default="Submitter" />
		
	</label>
	<g:select name="submitter.id" from="${ics.Individual.findAllByCategory('ACCPILOT')}" optionKey="id" value="${projectInstance?.submitter?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'submitDate', 'error')} ">
	<label for="submitDate">
		<g:message code="project.submitDate.label" default="Submit Date" />
		
	</label>
	<g:datePicker name="submitDate" value="${projectInstance?.submitDate}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'submitComments', 'error')} ">
	<label for="submitComments">
		<g:message code="project.submitComments.label" default="Submit Comments" />
		
	</label>
	<g:textArea name="submitComments" rows="5" cols="40" value="${fieldValue(bean: projectInstance, field: 'submitComments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'submitStatus', 'error')} ">
	<label for="submitStatus">
		<g:message code="project.submitStatus.label" default="Submit Status" />
		
	</label>
	<g:textField name="submitStatus" value="${fieldValue(bean: projectInstance, field: 'submitStatus')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'submittedAmount', 'error')} ">
	<label for="submittedAmount">
		<g:message code="project.submittedAmount.label" default="Submitted Amount" />
		
	</label>
	<g:textField name="submittedAmount" value="${fieldValue(bean: projectInstance, field: 'submittedAmount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'reviewer1', 'error')} ">
	<label for="reviewer1">
		<g:message code="project.reviewer1.label" default="Reviewer1" />
		
	</label>
	<g:select name="reviewer1.id" from="${ics.Individual.findAllByCategory('ACCPILOT')}" optionKey="id" value="${projectInstance?.reviewer1?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'review1Date', 'error')} ">
	<label for="review1Date">
		<g:message code="project.review1Date.label" default="Review1 Date" />
		
	</label>
	<g:datePicker name="review1Date" value="${projectInstance?.review1Date}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'review1Comments', 'error')} ">
	<label for="review1Comments">
		<g:message code="project.review1Comments.label" default="Review1 Comments" />
		
	</label>
	<g:textArea name="review1Comments" rows="5" cols="40" value="${fieldValue(bean: projectInstance, field: 'review1Comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'review1Status', 'error')} ">
	<label for="review1Status">
		<g:message code="project.review1Status.label" default="Review1 Status" />
		
	</label>
	<g:textField name="review1Status" value="${fieldValue(bean: projectInstance, field: 'review1Status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'reviewer1Amount', 'error')} ">
	<label for="reviewer1Amount">
		<g:message code="project.reviewer1Amount.label" default="Reviewer1 Amount" />
		
	</label>
	<g:textField name="reviewer1Amount" value="${fieldValue(bean: projectInstance, field: 'reviewer1Amount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'reviewer2', 'error')} ">
	<label for="reviewer2">
		<g:message code="project.reviewer2.label" default="Reviewer2" />
		
	</label>
	<g:select name="reviewer2.id" from="${ics.Individual.findAllByCategory('ACCPILOT')}" optionKey="id" value="${projectInstance?.reviewer2?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'review2Date', 'error')} ">
	<label for="review2Date">
		<g:message code="project.review2Date.label" default="Review2 Date" />
		
	</label>
	<g:datePicker name="review2Date" value="${projectInstance?.review2Date}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'review2Comments', 'error')} ">
	<label for="review2Comments">
		<g:message code="project.review2Comments.label" default="Review2 Comments" />
		
	</label>
	<g:textArea name="review2Comments" rows="5" cols="40" value="${fieldValue(bean: projectInstance, field: 'review2Comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'review2Status', 'error')} ">
	<label for="review2Status">
		<g:message code="project.review2Status.label" default="Review2 Status" />
		
	</label>
	<g:textField name="review2Status" value="${fieldValue(bean: projectInstance, field: 'review2Status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'reviewer2Amount', 'error')} ">
	<label for="reviewer2Amount">
		<g:message code="project.reviewer2Amount.label" default="Reviewer2 Amount" />
		
	</label>
	<g:textField name="reviewer2Amount" value="${fieldValue(bean: projectInstance, field: 'reviewer2Amount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'reviewer3', 'error')} ">
	<label for="reviewer3">
		<g:message code="project.reviewer3.label" default="Reviewer3" />
		
	</label>
	<g:select name="reviewer3.id" from="${ics.Individual.findAllByCategory('ACCPILOT')}" optionKey="id" value="${projectInstance?.reviewer3?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'review3Date', 'error')} ">
	<label for="review3Date">
		<g:message code="project.review3Date.label" default="Review3 Date" />
		
	</label>
	<g:datePicker name="review3Date" value="${projectInstance?.review3Date}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'review3Comments', 'error')} ">
	<label for="review3Comments">
		<g:message code="project.review3Comments.label" default="Review3 Comments" />
		
	</label>
	<g:textArea name="review3Comments" rows="5" cols="40" value="${fieldValue(bean: projectInstance, field: 'review3Comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'review3Status', 'error')} ">
	<label for="review3Status">
		<g:message code="project.review3Status.label" default="Review3 Status" />
		
	</label>
	<g:textField name="review3Status" value="${fieldValue(bean: projectInstance, field: 'review3Status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'reviewer3Amount', 'error')} ">
	<label for="reviewer3Amount">
		<g:message code="project.reviewer3Amount.label" default="Reviewer3 Amount" />
		
	</label>
	<g:textField name="reviewer3Amount" value="${fieldValue(bean: projectInstance, field: 'reviewer3Amount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="project.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: projectInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="project.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: projectInstance, field: 'updator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'subProjects', 'error')} ">
	<label for="subProjects">
		<g:message code="project.subProjects.label" default="Sub Projects" />
		
	</label>
	

</div>

