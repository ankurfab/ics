<%@ page import="ics.Expense" %>



<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'centre', 'error')} ">
	<label for="centre">
		<g:message code="expense.centre.label" default="Centre" />
		
	</label>
	<g:select name="centre.id" from="${ics.Centre.list()}" optionKey="id" value="${expenseInstance?.centre?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'department', 'error')} required">
	<label for="department">
		<g:message code="expense.department.label" default="Department" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${expenseInstance?.department?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'costCenter', 'error')} ">
	<label for="costCenter">
		<g:message code="expense.costCenter.label" default="Cost Center" />
		
	</label>
	<g:select name="costCenter.id" from="${ics.CostCenter.list()}" optionKey="id" value="${expenseInstance?.costCenter?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'raisedBy', 'error')} required">
	<label for="raisedBy">
		<g:message code="expense.raisedBy.label" default="Raised By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="raisedBy.id" from="${ics.Individual.list()}" optionKey="id" value="${expenseInstance?.raisedBy?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="expense.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${fieldValue(bean: expenseInstance, field: 'type')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="expense.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${fieldValue(bean: expenseInstance, field: 'category')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="expense.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${fieldValue(bean: expenseInstance, field: 'description')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="expense.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="amount" value="${fieldValue(bean: expenseInstance, field: 'amount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'expenseDate', 'error')} required">
	<label for="expenseDate">
		<g:message code="expense.expenseDate.label" default="Expense Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="expenseDate" value="${expenseInstance?.expenseDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'raisedOn', 'error')} required">
	<label for="raisedOn">
		<g:message code="expense.raisedOn.label" default="Raised On" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="raisedOn" value="${expenseInstance?.raisedOn}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="expense.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${fieldValue(bean: expenseInstance, field: 'status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'approvedBy', 'error')} ">
	<label for="approvedBy">
		<g:message code="expense.approvedBy.label" default="Approved By" />
		
	</label>
	<g:select name="approvedBy.id" from="${ics.Individual.list()}" optionKey="id" value="${expenseInstance?.approvedBy?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'approvedAmount', 'error')} ">
	<label for="approvedAmount">
		<g:message code="expense.approvedAmount.label" default="Approved Amount" />
		
	</label>
	<g:textField name="approvedAmount" value="${fieldValue(bean: expenseInstance, field: 'approvedAmount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'approvalDate', 'error')} ">
	<label for="approvalDate">
		<g:message code="expense.approvalDate.label" default="Approval Date" />
		
	</label>
	<g:datePicker name="approvalDate" value="${expenseInstance?.approvalDate}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'approvalComments', 'error')} ">
	<label for="approvalComments">
		<g:message code="expense.approvalComments.label" default="Approval Comments" />
		
	</label>
	<g:textField name="approvalComments" value="${fieldValue(bean: expenseInstance, field: 'approvalComments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'reviewer1', 'error')} ">
	<label for="reviewer1">
		<g:message code="expense.reviewer1.label" default="Reviewer1" />
		
	</label>
	<g:select name="reviewer1.id" from="${ics.Individual.list()}" optionKey="id" value="${expenseInstance?.reviewer1?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'review1Date', 'error')} ">
	<label for="review1Date">
		<g:message code="expense.review1Date.label" default="Review1 Date" />
		
	</label>
	<g:datePicker name="review1Date" value="${expenseInstance?.review1Date}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'review1Comments', 'error')} ">
	<label for="review1Comments">
		<g:message code="expense.review1Comments.label" default="Review1 Comments" />
		
	</label>
	<g:textArea name="review1Comments" rows="5" cols="40" value="${fieldValue(bean: expenseInstance, field: 'review1Comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'review1Status', 'error')} ">
	<label for="review1Status">
		<g:message code="expense.review1Status.label" default="Review1 Status" />
		
	</label>
	<g:textField name="review1Status" value="${fieldValue(bean: expenseInstance, field: 'review1Status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'reviewer1Amount', 'error')} ">
	<label for="reviewer1Amount">
		<g:message code="expense.reviewer1Amount.label" default="Reviewer1 Amount" />
		
	</label>
	<g:textField name="reviewer1Amount" value="${fieldValue(bean: expenseInstance, field: 'reviewer1Amount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'reviewer2', 'error')} ">
	<label for="reviewer2">
		<g:message code="expense.reviewer2.label" default="Reviewer2" />
		
	</label>
	<g:select name="reviewer2.id" from="${ics.Individual.list()}" optionKey="id" value="${expenseInstance?.reviewer2?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'review2Date', 'error')} ">
	<label for="review2Date">
		<g:message code="expense.review2Date.label" default="Review2 Date" />
		
	</label>
	<g:datePicker name="review2Date" value="${expenseInstance?.review2Date}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'review2Comments', 'error')} ">
	<label for="review2Comments">
		<g:message code="expense.review2Comments.label" default="Review2 Comments" />
		
	</label>
	<g:textArea name="review2Comments" rows="5" cols="40" value="${fieldValue(bean: expenseInstance, field: 'review2Comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'review2Status', 'error')} ">
	<label for="review2Status">
		<g:message code="expense.review2Status.label" default="Review2 Status" />
		
	</label>
	<g:textField name="review2Status" value="${fieldValue(bean: expenseInstance, field: 'review2Status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'reviewer2Amount', 'error')} ">
	<label for="reviewer2Amount">
		<g:message code="expense.reviewer2Amount.label" default="Reviewer2 Amount" />
		
	</label>
	<g:textField name="reviewer2Amount" value="${fieldValue(bean: expenseInstance, field: 'reviewer2Amount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'reviewer3', 'error')} ">
	<label for="reviewer3">
		<g:message code="expense.reviewer3.label" default="Reviewer3" />
		
	</label>
	<g:select name="reviewer3.id" from="${ics.Individual.list()}" optionKey="id" value="${expenseInstance?.reviewer3?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'review3Date', 'error')} ">
	<label for="review3Date">
		<g:message code="expense.review3Date.label" default="Review3 Date" />
		
	</label>
	<g:datePicker name="review3Date" value="${expenseInstance?.review3Date}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'review3Comments', 'error')} ">
	<label for="review3Comments">
		<g:message code="expense.review3Comments.label" default="Review3 Comments" />
		
	</label>
	<g:textArea name="review3Comments" rows="5" cols="40" value="${fieldValue(bean: expenseInstance, field: 'review3Comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'review3Status', 'error')} ">
	<label for="review3Status">
		<g:message code="expense.review3Status.label" default="Review3 Status" />
		
	</label>
	<g:textField name="review3Status" value="${fieldValue(bean: expenseInstance, field: 'review3Status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'reviewer3Amount', 'error')} ">
	<label for="reviewer3Amount">
		<g:message code="expense.reviewer3Amount.label" default="Reviewer3 Amount" />
		
	</label>
	<g:textField name="reviewer3Amount" value="${fieldValue(bean: expenseInstance, field: 'reviewer3Amount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'project', 'error')} ">
	<label for="project">
		<g:message code="expense.project.label" default="Project" />
		
	</label>
	<g:select name="project.id" from="${ics.Project.list()}" optionKey="id" value="${expenseInstance?.project?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="expense.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: expenseInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="expense.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: expenseInstance, field: 'updator')}" />

</div>

