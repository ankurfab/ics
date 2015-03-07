<%@ page import="ics.Project" %>


<g:hiddenField name="id" value="${projectInstance?.id}" />
<g:hiddenField name="version" value="${projectInstance?.version}" />

<div class="allbody"> 

   
  <h1>Expense Advance for Amount:${projectInstance?.amount} Date:${projectInstance?.expectedStartDate?.format('dd-MM-yyyy')}</h1>
			
			
<fieldset class="form">

<sec:ifAnyGranted roles="ROLE_ACC_USER">

<div>
	<label for="advanceAmount">Advance Amount</label>
	${projectInstance?.advanceAmount}
</div>

<div>
	<label for="advanceAmountIssued">Advance Amount Issued</label>
	<g:field name="advanceAmountIssued" value="${fieldValue(bean: projectInstance, field: 'advanceAmountIssued')}"/>
</div>


<div>
	<label for="advanceIssued">
		Advance Issued		
	</label>
	<g:checkBox name="advanceIssued" value="${addressInstance?.advanceIssued}" />
</div>

</sec:ifAnyGranted>


<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="project.name.label" default="Name" />
		
	</label>
	${projectInstance?.name}
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="project.description.label" default="Description" />
		
	</label>
	${projectInstance?.description}
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="project.category.label" default="Category" />
		
	</label>
	${projectInstance?.category}
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="project.type.label" default="Type" />
		
	</label>
	${projectInstance?.type}
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'amount', 'error')} ">
	<label for="amount">
		<g:message code="project.amount.label" default="Amount" />
		
	</label>
	${projectInstance?.amount}
</div>

<div class="fieldcontain  ">
	<label for="expectedStartDate">
		Expected Start Date
		
	</label>
	${projectInstance?.expectedStartDate?.format('dd-MM-yyyy')}
   
</div>

<div class="fieldcontain  ">
	<label for="expectedEndDate">
		Expected End Date
		
	</label>
	${projectInstance?.expectedEndDate?.format('dd-MM-yyyy')}
   
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'priority', 'error')} ">
	<label for="priority">
		Priority
		
	</label>
	${projectInstance?.priority}
</div>

</fieldset>

</div>