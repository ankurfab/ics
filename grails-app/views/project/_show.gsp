<%@ page import="ics.Project" %>


<g:hiddenField name="id" value="${projectInstance?.id}" />
<g:hiddenField name="version" value="${projectInstance?.version}" />

<div class="allbody"> 

   
  <h1>Expense Approval Form for Amount:${projectInstance?.amount} Date:${projectInstance?.submitDate?.format('dd-MM-yyyy')}</h1>
			
			
<fieldset class="form">

<sec:ifAnyGranted roles="ROLE_CG_OWNER">

<div>
<g:render template="/costCenter/budget" model="['costCenterInstance':projectInstance?.costCenter,'year':'2014']" />
</div>

<div>
	<label for="review1Status">
		Review Status		
	</label>
	<g:select name="review1Status" from="${['APPROVED','REJECTED','HOLD']}" value="${projectInstance?.review1Status?:'HOLD'}"/>
</div>

<div>
	<label for="review1Comments">
		Review Comments		
	</label>
	<g:textArea name="review1Comments" cols="40" rows="5" maxlength="500" value="${projectInstance?.review1Comments}"/>
</div>
</sec:ifAnyGranted>


<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="project.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${projectInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="project.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="500" value="${projectInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="project.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${projectInstance?.category}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="project.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${projectInstance?.type}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'amount', 'error')} ">
	<label for="amount">
		<g:message code="project.amount.label" default="Amount" />
		
	</label>
	<g:field name="amount" value="${fieldValue(bean: projectInstance, field: 'amount')}"/>
</div>

<div class="fieldcontain  ">
	<label for="expectedStartDate">
		Expected Start Date
		
	</label>
	<g:datePicker name="expectedStartDate" precision="day"  value="${projectInstance?.expectedStartDate?:(new Date()+5)}" default="none"  />
   
</div>

<div class="fieldcontain  ">
	<label for="expectedEndDate">
		Expected End Date
		
	</label>
	<g:datePicker name="expectedEndDate" precision="day"  value="${projectInstance?.expectedEndDate?:(new Date()+15)}" default="none"  />
   
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'priority', 'error')} ">
	<label for="priority">
		Priority
		
	</label>
	<g:select name="priority" from="${['P1(URGENT)','P2(HIGH)','P3(MEDIUM)','P4(LOW)']}" value="${projectInstance?.priority?:'P3(MEDIUM)'}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'submitStatus', 'error')} ">
	<label for="submitStatus">
		Submit Status
		
	</label>
	<g:select name="submitStatus" from="${['DRAFT','SUBMITTED']}" value="${projectInstance?.submitStatus?:'DRAFT'}"/>
</div>

</fieldset>

</div>