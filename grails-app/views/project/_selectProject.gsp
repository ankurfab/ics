<%@ page import="ics.Project" %>

<div class="allbody"> 

   
  <h1>Approved Expenses</h1>
			
			 
			
<fieldset class="form">

<div>
	<label for="name">
		Expense
		
	</label>
<g:set var="username" value="<sec:username/>" />
<g:set var="cc" value="${ics.CostCenter.findByOwner(ics.Individul.findByLoginid(username))}" />
	<g:select name="project.id"
	          from="${Project.findAllByStatusAndCostCenter('APPROVED_REQUEST',cc)}"
	          optionKey="id" noSelection="['':'-Choose Expense-']"/>
</div>


<div>
<g:actionSubmit value="Start" />
</div>

</fieldset>

</div>