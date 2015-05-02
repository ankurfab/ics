<%@ page import="ics.Expense" %>

<div class="allbody"> 

   
  <h1>Create Expense</h1>
<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'department', 'error')} required">
	<label for="department">
		<g:message code="expense.department.label" default="Department" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="department" name="department.id" from="${ics.Department.list()}" optionKey="id" required="" value="${expenseInstance?.department?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="expense.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${expenseInstance?.type}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="expense.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${expenseInstance?.category}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="expense.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${expenseInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="expense.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="amount" value="${fieldValue(bean: expenseInstance, field: 'amount')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'expenseDate', 'error')} required">
	<label for="expenseDate">
		<g:message code="expense.expenseDate.label" default="Expense Date" />
		<span class="required-indicator">*</span>
	</label>
<g:datePicker name="expenseDate" precision="day"  value="${expenseInstance?.expenseDate}"  />
	
</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'raisedOn', 'error')} required">
	<label for="raisedOn">
		<g:message code="expense.raisedOn.label" default="Raised On" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="raisedOn" precision="day"  value="${expenseInstance?.raisedOn}"  />
   
</div>


<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="expense.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${expenseInstance?.status}"/>
</div>


<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="expense.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${expenseInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="expense.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${expenseInstance?.updator}"/>
</div>

</div>