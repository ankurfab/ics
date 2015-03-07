
<%@ page import="ics.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main-jqm-landing" />
        <title>File Expense Report</title>
    </head>
    <body>
    <div role="main" class="ui-content">
    
<div class="allbody"> 

   
<h1>Expense Reimbursement Form</h1>
			
			 
<g:form name="expenseReimbursementForm" controller="project" action="saveReport" method="POST">
			
<fieldset class="form">

<g:hiddenField name="projectid" value="${projectInstance.id}" />

<div>
	<h3>${projectInstance.ref+"/"+projectInstance.name+"/"+projectInstance.submitDate+"/"+projectInstance.amount}</h3>
	<table>
		<thead>
			<th>Date</th>
			<th>Particulars</th>
			<th>Type</th>
			<th>Amount</th>
		</thead>
		<g:set var="totalExp" value="${new BigDecimal(0)}" />
		<g:set var="advance" value="${projectInstance.advanceIssued?projectInstance.advanceAmountIssued:new BigDecimal(0)}" />
		<g:set var="balance" value="${totalExp-advance}" />
		<g:each in="${0..9}" var="i">
			<tr>
				<td>
					<g:textField name="${'expdate_'+i}" value="" placeholder="Date of the expense (dd-MM-yyyy)"/>
				</td>
				<td>
					<g:textField name="${'part_'+i}" value="" placeholder="Particulars of the expense"/>
				</td>
				<td>
					<g:textField name="${'type_'+i}" value="" placeholder="Type of the expense"/>
				</td>
				<td>
					<g:textField name="${'amount_'+i}" value="" placeholder="Amount of the expense"/>
				</td>
			</tr>
		</g:each>
			<tr>
				<td>
				</td>
				<td>
				</td>
				<td>
					Less: Advance Taken
				</td>
				<td>
					<div id="advance">${advance}</div>
				</td>
			</tr>
			<tr>
				<td>
				</td>
				<td>
				</td>
				<td>
					Balance returned/payable
				</td>
				<td>
					<div id="balance">${balance}</div>
				</td>
			</tr>
	</table>
</div>

<div>
    <fieldset data-role="controlgroup" data-type="horizontal">
	<legend>Status:</legend>
	<input name="reportstatus" id="reportstatus-1" value="DRAFT" type="radio">
	<label for="reportstatus-1">DRAFT</label>
	<input name="reportstatus" id="reportstatus-2" value="SUBMIT" type="radio" checked="checked">
	<label for="reportstatus-2">SUBMIT</label>
    </fieldset>
</div>

<div>
		<g:submitButton name="save" value="Save" />
</div>

</fieldset>

</g:form>

</div>

    </body>
</html>
