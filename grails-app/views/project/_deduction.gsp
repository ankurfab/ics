<%@ page import="ics.Expense" %>


<g:hiddenField name="expidForDeduction" value="${expenseInstance?.id}" />
<g:hiddenField name="expidsForDeduction" value="" />

<div class="allbody"> 

   
<fieldset class="form">

<div>
	<label for="deductionType">Deduction Type</label>
	<g:select id="deductionType" name='deductionType' value="${expenseInstance?.deductionType}" from='${['TDS','Other']}'></g:select>
</div>

<div>
	<label for="deductionPercentage">Deduction Percentage</label>
	<g:select id="deductionPercentage" name='deductionPercentage' value="${expenseInstance?.deductionPercentage}" from='${[1,2,5,10]}' noSelection="['':'-Choose Perctentage-']"></g:select>
</div>

<!--
<div>
	<label for="deductionAmount">Deduction Amount</label>
	<g:textField name="deductionAmount" value="${expenseInstance?.deductionAmount}" type="number" placeholder="Please choose % value or enter amount"/>
</div>

<div>
	<label for="deductionDescription">Deduction Description</label>
	<g:textArea name="deductionDescription" value="${expenseInstance?.deductionDescription}" rows="5" cols="40"/>
</div>
-->

</fieldset>

</div>