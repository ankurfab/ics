<%@ page import="ics.Project" %>

<g:form name="addprojectForm" controller="project" action="save" method="POST">

<div class="allbody"> 

   
<h1>Expense Approval Form</h1>
			
						
<fieldset class="form">

<div>
	<label for="name">Name:</label>
	<g:textField name="name" value="${projectInstance?.name}" placeholder="Expense name in brief." required="required" pattern=".{3,}"/>
</div>

<div>
	<label for="name">Description:</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="500" value="${projectInstance?.description}" placeholder="Expense description."/>
</div>

<div>
	<label for="amount">Amount:</label>
	<g:field name="amount" value="${projectInstance?.amount}" placeholder="Expense amount" type="number" required="required" min= "1"/>
</div>

<div>
	<label for="advanceAmount">Advance Amount:</label>
	<g:field name="advanceAmount" value="${projectInstance?.advanceAmount}" placeholder="Advance(if needed, <= amount)" type="number"/>
</div>

<div data-role="controlgroup" data-type="horizontal">

<div>
    <fieldset data-role="controlgroup" data-type="horizontal">
        <legend>Priority:</legend>
        <input name="priority" id="priority-p1" value="P1(URGENT)" type="radio">
        <label for="priority-p1">P1(URGENT)</label>
        <input name="priority" id="priority-p2" value="P2(HIGH)" type="radio">
        <label for="priority-p2">P2(HIGH)</label>
        <input name="priority" id="priority-p3" value="P3(MEDIUM)" checked="checked" type="radio">
        <label for="priority-p3">P3(MEDIUM)</label>
        <input name="priority" id="priority-p4" value="P4(LOW)" type="radio">
        <label for="priority-p4">P4(LOW)</label>
    </fieldset>
</div>

<div>
    <fieldset data-role="controlgroup" data-type="horizontal">
        <legend>Category:</legend>
        <input name="category" id="category-1" value="REVENUE" checked="checked" type="radio">
        <label for="category-1">REVENUE</label>
        <input name="category" id="category-2" value="CAPITAL" type="radio">
        <label for="category-2">CAPITAL</label>
    </fieldset>
</div>

<div>
    <fieldset data-role="controlgroup" data-type="horizontal">
        <legend>Status:</legend>
        <input name="submitStatus" id="submitStatus-1" value="SUBMITTED_REQUEST" checked="checked" type="radio">
        <label for="submitStatus-1">SUBMIT</label>
        <input name="submitStatus" id="submitStatus-2" value="DRAFT_REQUEST" type="radio">
        <label for="submitStatus-2">DRAFT</label>
    </fieldset>
</div>

</div>

<div>
<g:actionSubmit value="Save" />
</div>

</fieldset>

</div>

</g:form>
