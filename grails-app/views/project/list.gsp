<%@ page import="ics.Project" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main-jqm-landing">
        <title>ICS: Expense Management Module</title>        
    </head>
<body>

    <div role="main" class="ui-content">

	        <g:each in="${projectInstanceList}" status="i" var="projectInstance">
	        
	        <fieldset data-role="collapsible" data-theme="a" data-content-theme="d"  class="collaps">
	                    <legend>${projectInstance.amount+" by "+projectInstance.costCenter?.name+"/"+projectInstance.submitDate?.format('dd-MM-yyyy')+"/"+projectInstance.priority}</legend>
	                    <table>
	                    	<tr>
	                    		<td>Reference</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "ref")}</td>
	                    		<td>Name</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "name")}</td>
	                    	</tr>
	                    	<tr>
	                    		<td>Description</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "description")}</td>
	                    		<td>SubmitDate</td>
	                    		<td>${projectInstance?.submitDate?.format('dd-MM-yyyy')}</td>
	                    	</tr>
	                    	<tr>
	                    		<td>Amount</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "amount")}</td>
	                    		<td>AdvanceAmount</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "advanceAmount")}</td>
	                    	</tr>
	                    	<tr>
	                    		<td>Priority</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "priority")}</td>
	                    		<td>Category</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "category")}</td>
	                    	</tr>
	                    </table>
	                <g:set var="expenses" value="${ics.Expense.findAllByProject(projectInstance)}" />
	                <g:if test="${expenses.size()>0}">
	                <div>
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
					<g:each in="${expenses}" var="expense">
						<tr>
							<td>
								${expense.expenseDate?.format('dd-MM-yyyy')}
							</td>
							<td>
								${expense.description}
							</td>
							<td>
								${expense.type}
							</td>
							<td>
								${expense.amount}
								<g:set var="totalExp" value="${totalExp+expense.amount}" />
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
								<g:set var="balance" value="${totalExp-advance}" />
								<div id="balance">${balance}</div>
							</td>
						</tr>
				</table>
			</div>
			</g:if>
	                
		        <sec:ifAnyGranted roles="ROLE_CCAT_OWNER">
				<g:if test="${projectInstance.status=='SUBMITTED_REQUEST' || projectInstance.status=='SUBMITTED_REPORT'}">
				    <div data-role="rangeslider">
					<label for="month-a">Month:</label>
					<input name="month-a" id="month-a" disabled="disabled" min="0" max="${projectInstance.costCenter.budget?:0}" value="${projectInstance.costCenter.balance?:0}" type="range">
					<label for="month-b">Rangeslider:</label>
					<input name="month-b" id="month-b" disabled="disabled" min="0" max="${projectInstance.costCenter.budget?:0}" value="${projectInstance.costCenter.budget?:0}" type="range">
				    </div>
				    <div data-role="rangeslider">
					<label for="quarter-a">Quarter:</label>
					<input name="quarter-a" id="quarter-a" disabled="disabled" min="0" max="${projectInstance.costCenter.quarterBudget?:0}" value="${projectInstance.costCenter.quarterBalance?:0}" type="range">
					<label for="quarter-b">Rangeslider:</label>
					<input name="quarter-b" id="quarter-b" disabled="disabled" min="0" max="${projectInstance.costCenter.quarterBudget?:0}" value="${projectInstance.costCenter.quarterBudget?:0}" type="range">
				    </div>
				    <div data-role="rangeslider">
					<label for="year-a">Year:</label>
					<input name="year-a" id="year-a" disabled="disabled" min="0" max="${projectInstance.costCenter.yearBudget?:0}" value="${projectInstance.costCenter.yearBalance?:0}" type="range">
					<label for="year-b">Rangeslider:</label>
					<input name="year-b" id="year-b" disabled="disabled" min="0" max="${projectInstance.costCenter.yearBudget?:0}" value="${projectInstance.costCenter.yearBudget?:0}" type="range">
				    </div>
				<form name=${'formCCAT_'+projectInstance.id} id="${'formCCAT_'+projectInstance.id}" method="post" action="${createLink(controller:'Project',action:'changeState')}">
				  <g:hiddenField name="projectid" value="${projectInstance?.id}" />
				  <g:hiddenField name="approver" value="ROLE_CCAT_OWNER" />
				    <div>
					    <fieldset data-role="controlgroup" data-type="horizontal">
						<legend>Status:</legend>
						<input name="approvestatus" id="approvestatus-1" value="APPROVE" checked="checked" type="radio">
						<label for="approvestatus-1">APPROVE</label>
						<input name="approvestatus" id="approvestatus-2" value="REJECT" type="radio">
						<label for="approvestatus-2">REJECT</label>
						<input name="approvestatus" id="approvestatus-3" value="ESCALATE" type="radio">
						<label for="approvestatus-3">ESCALATE</label>
					    </fieldset>

				    </div>
				    <input type="submit" value="Submit">
				</form>
				</g:if>
			</sec:ifAnyGranted>         
		        <sec:ifAnyGranted roles="ROLE_FINANCE">
				<g:if test="${projectInstance.status=='ESCALATED_REQUEST' || projectInstance.status=='ESCALATED_REPORT'}">
				    <div data-role="rangeslider">
					<label for="month-a">Month:</label>
					<input name="month-a" id="month-a" disabled="disabled" min="0" max="${projectInstance.costCenter.budget?:0}" value="${projectInstance.costCenter.balance?:0}" type="range">
					<label for="month-b">Rangeslider:</label>
					<input name="month-b" id="month-b" disabled="disabled" min="0" max="${projectInstance.costCenter.budget?:0}" value="${projectInstance.costCenter.budget?:0}" type="range">
				    </div>
				    <div data-role="rangeslider">
					<label for="quarter-a">Quarter:</label>
					<input name="quarter-a" id="quarter-a" disabled="disabled" min="0" max="${projectInstance.costCenter.quarterBudget?:0}" value="${projectInstance.costCenter.quarterBalance?:0}" type="range">
					<label for="quarter-b">Rangeslider:</label>
					<input name="quarter-b" id="quarter-b" disabled="disabled" min="0" max="${projectInstance.costCenter.quarterBudget?:0}" value="${projectInstance.costCenter.quarterBudget?:0}" type="range">
				    </div>
				    <div data-role="rangeslider">
					<label for="year-a">Year:</label>
					<input name="year-a" id="year-a" disabled="disabled" min="0" max="${projectInstance.costCenter.yearBudget?:0}" value="${projectInstance.costCenter.yearBalance?:0}" type="range">
					<label for="year-b">Rangeslider:</label>
					<input name="year-b" id="year-b" disabled="disabled" min="0" max="${projectInstance.costCenter.yearBudget?:0}" value="${projectInstance.costCenter.yearBudget?:0}" type="range">
				    </div>
				<form name=${'formCCAT_'+projectInstance.id} id="${'formCCAT_'+projectInstance.id}" method="post" action="${createLink(controller:'Project',action:'changeState')}">
				  <g:hiddenField name="projectid" value="${projectInstance?.id}" />
				  <g:hiddenField name="approver" value="ROLE_FINANCE" />
				    <div>
					    <fieldset data-role="controlgroup" data-type="horizontal">
						<legend>Status:</legend>
						<input name="approvestatus" id="approvestatus-1" value="APPROVE" checked="checked" type="radio">
						<label for="approvestatus-1">APPROVE</label>
						<input name="approvestatus" id="approvestatus-2" value="REJECT" type="radio">
						<label for="approvestatus-2">REJECT</label>
					    </fieldset>

				    </div>
				    <input type="submit" value="Submit">
				</form>
				</g:if>
			</sec:ifAnyGranted>         
			
	     </fieldset>
	                            
	       </g:each>                
	
    </div><!-- /content -->

           
</body>
</html>