<%@ page import="ics.Project" %>

<div class="allbody"> 

   
<h1>Expense Approval Form</h1>
			
			 
<g:form name="addprojectReport" controller="project" action="saveReport" method="POST">
			
<fieldset class="form">

<div>
	<label for="name">
		Approved Expenses
		
	</label>
	<g:select name="project.id"
	          from="${projects}"
	          optionKey="id" noSelection="['':'-Choose Expense-']"/>

	<table>
		<thead>
			<th>Particulars</th>
			<th>Type</th>
			<th>Amount</th>
		</thead>
		<g:set var="total" value="${new BigDecimal(0)}" />
		<g:each in="${[0..9]}" var="i">
			<tr>
				<td>
				</td>
			</tr>
		</g:each>
	</table>
</div>


<div>
<g:actionSubmit value="Save" />
</div>

</fieldset>

</g:form>

</div>