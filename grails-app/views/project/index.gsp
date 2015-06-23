

<%@ page import="ics.Project" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main-jqm-landing">
        <title>ICS: Expense Management Module</title>
    </head>
<body>

    <div role="main" class="ui-content">

	<g:if test="${flash.message}">
	<div class="message" role="status">${flash.message}</div>
	</g:if>

        <sec:ifAnyGranted roles="ROLE_CC_OWNER">
		<div data-role="collapsible" data-inset="true">
		    <h3>Expense Approval</h3>
		    <ul data-role="listview">
			<li><g:link controller="Project" action="create" data-ajax="false">Raise New Request</g:link></li>			
			<li><g:link controller="Project" action="list" params="['status':'DRAFT_REQUEST']" data-ajax="false">Draft Requests<span class="ui-li-count">${stats['DRAFT_REQUEST']?:'0'}</span></g:link></li>
			<li><g:link controller="Project" action="list" params="['status':'SUBMITTED_REQUEST']" data-ajax="false">Submitted Requests<span class="ui-li-count">${stats['SUBMITTED_REQUEST']?:'0'}</span></g:link></li>
			<li><g:link controller="Project" action="list" params="['status':'APPROVED_REQUEST']" data-ajax="false">Approved Requests<span class="ui-li-count">${stats['APPROVED_REQUEST']?:'0'}</span></g:link></li>
			<li><g:link controller="Project" action="list" params="['status':'REJECTED_REQUEST']" data-ajax="false">Rejected Requests<span class="ui-li-count">${stats['REJECTED_REQUEST']?:'0'}</span></g:link></li>
			<li><g:link controller="Project" action="list" params="['status':'ESCALATED_REQUEST']" data-ajax="false">Escalated Requests<span class="ui-li-count">${stats['ESCALATED_REQUEST']?:'0'}</span></g:link></li>
		    </ul>
		</div><!-- /collapsible -->
		<div data-role="collapsible" data-inset="true">
		    <h3>Expense Reimbursement</h3>
		    <ul data-role="listview">
			<li><g:link controller="Project" action="selectProject" data-ajax="false">File Report<span class="ui-li-count">${stats['APPROVED_REQUEST']?:'0'}</span></g:link></li>			
			<li><g:link controller="Project" action="list" params="['status':'DRAFT_REPORT']" data-ajax="false">Draft Reports<span class="ui-li-count">${stats['DRAFT_REPORT']?:'0'}</span></g:link></li>
			<li><g:link controller="Project" action="list" params="['status':'SUBMITTED_REPORT']" data-ajax="false">Submitted Reports<span class="ui-li-count">${stats['SUBMITTED_REPORT']?:'0'}</span></g:link></li>
			<li><g:link controller="Project" action="list" params="['status':'APPROVED_REPORT']" data-ajax="false">Approved Reports<span class="ui-li-count">${stats['APPROVED_REPORT']?:'0'}</span></g:link></li>
			<li><g:link controller="Project" action="list" params="['status':'REJECTED_REPORT']" data-ajax="false">Rejected Reports<span class="ui-li-count">${stats['REJECTED_REPORT']?:'0'}</span></g:link></li>
			<li><g:link controller="Project" action="list" params="['status':'ESCALATED_REPORT']" data-ajax="false">Escalated Reports<span class="ui-li-count">${stats['ESCALATED_REPORT']?:'0'}</span></g:link></li>
			<li><g:link controller="Project" action="list" params="['status':'SETTLED_REPORT']" data-ajax="false">Settled Reports<span class="ui-li-count">${stats['SETTLED_REPORT']?:'0'}</span></g:link></li>
		    </ul>
		</div><!-- /collapsible -->
	</sec:ifAnyGranted>         
        <sec:ifAnyGranted roles="ROLE_CG_OWNER">
		<div data-role="collapsible" data-inset="true">
		    <h3>Expense Approval</h3>
		    <ul data-role="listview">
			<li><g:link controller="Project" action="list" params="['status':'SUBMITTED_REQUEST']" data-ajax="false">Submitted Requests<span class="ui-li-count">${stats['SUBMITTED_REQUEST']?:'0'}</span></g:link></li>
			<li><g:link controller="Project" action="list" params="['status':'APPROVED_REQUEST']" data-ajax="false">Approved Requests<span class="ui-li-count">${(stats['APPROVED_REQUEST']?:0)+(stats['DRAFT_REPORT']?:0)}</span></g:link></li>
			<li><g:link controller="Project" action="list" params="['status':'REJECTED_REQUEST']" data-ajax="false">Rejected Requests<span class="ui-li-count">${stats['REJECTED_REQUEST']?:'0'}</span></g:link></li>
			<li><g:link controller="Project" action="list" params="['status':'ESCALATED_REQUEST']" data-ajax="false">Escalated Requests<span class="ui-li-count">${stats['ESCALATED_REQUEST']?:'0'}</span></g:link></li>
		    </ul>
		</div><!-- /collapsible -->
		<div data-role="collapsible" data-inset="true">
		    <h3>Expense Reimbursement</h3>
		    <ul data-role="listview">
			<li><g:link controller="Project" action="list" params="['status':'SUBMITTED_REPORT']" data-ajax="false">Submitted Reports<span class="ui-li-count">${stats['SUBMITTED_REPORT']?:'0'}</span></g:link></li>
			<li><g:link controller="Project" action="list" params="['status':'APPROVED_REPORT']" data-ajax="false">Approved Reports<span class="ui-li-count">${stats['APPROVED_REPORT']?:'0'}</span></g:link></li>
			<li><g:link controller="Project" action="list" params="['status':'REJECTED_REPORT']" data-ajax="false">Rejected Reports<span class="ui-li-count">${stats['REJECTED_REPORT']?:'0'}</span></g:link></li>
			<li><g:link controller="Project" action="list" params="['status':'ESCALATED_REPORT']" data-ajax="false">Escalated Reports<span class="ui-li-count">${stats['ESCALATED_REPORT']?:'0'}</span></g:link></li>
			<li><g:link controller="Project" action="list" params="['status':'SETTLED_REPORT']" data-ajax="false">Settled Reports<span class="ui-li-count">${stats['SETTLED_REPORT']?:'0'}</span></g:link></li>
		    </ul>
		</div><!-- /collapsible -->
	</sec:ifAnyGranted>         

        <sec:ifAnyGranted roles="ROLE_FINANCE">
		<ul data-role="listview" data-count-theme="b" data-inset="true">
		    <li><g:link controller="Project" action="list" params="['status':'ESCALATED_REQUEST']" data-ajax="false">Escalated  Approval Requests<span class="ui-li-count">${stats['ESCALATED_REQUEST']?:'0'}</span></g:link></li>
		    <li><g:link controller="Project" action="list" params="['status':'ESCALATED_REPORT']" data-ajax="false">Escalated Reimbursement Reports<span class="ui-li-count">${stats['ESCALATED_REPORT']?:'0'}</span></g:link></li>
		    <li><g:link controller="Project" action="gridlist" params="['s_status':'SU']" data-ajax="false">All Expenses (SuperUser Mode)</g:link></li>
		</ul>
		<div data-role="collapsible" data-inset="true">
		    <h3>Configurations</h3>
		    <ul data-role="listview">
			<li><g:link controller="costCenter" action="budget" data-ajax="false">Budget</g:link></li>
			<li><g:link controller="project" action="costCategoryGridlist" data-ajax="false">CostCategory/CostCenter</g:link></li>
			<li><g:link controller="project" action="costCenterGroupGridList" data-ajax="false">VerticalHead/Department</g:link></li>
			<li><g:link controller="project" action="ledgerHeadGridList" data-ajax="false">LedgerHead</g:link></li>
			<li><g:link controller="project" action="locks" data-ajax="false">Locks</g:link></li>
		    </ul>
		</div><!-- /collapsible -->
	</sec:ifAnyGranted>         

        <sec:ifAnyGranted roles="ROLE_CC_OWNER,ROLE_CG_OWNER">
		<div data-role="collapsible" data-inset="true">
		    <h3>Dashboard</h3>
		    <ul data-role="listview">
		        <li><g:link controller="project" action="expenseSummary" data-ajax="false">ExpenseSummary</g:link></li>
		        <li><g:link controller="project" action="reportCurrentMonthBudgetSummary" data-ajax="false">BudgetSummary</g:link></li>
		        <li><g:link controller="costCenter" action="statement" data-ajax="false">Statement</g:link></li>
		    </ul>
		</div><!-- /collapsible -->
	</sec:ifAnyGranted>         


        <sec:ifAnyGranted roles="ROLE_FINANCE">
		<div data-role="collapsible" data-inset="true">
		    <h3>Dashboard</h3>
		    <ul data-role="listview">
		        <li><g:link controller="costCenter" action="summary" data-ajax="false">Summary</g:link></li>
		        <li><g:link controller="costCenter" action="monthSummary" data-ajax="false">CurrentMonthSummary</g:link></li>
		        <li><g:link controller="costCenter" action="incomeSummary" data-ajax="false">IncomeSummary</g:link></li>
		        <li><g:link controller="costCenter" action="incomeSheet" data-ajax="false">Income Sheet</g:link></li>
		    </ul>
		</div><!-- /collapsible -->
	</sec:ifAnyGranted>         


        <sec:ifAnyGranted roles="ROLE_ACC_USER">
		<ul data-role="listview" data-count-theme="b" data-inset="true">
		    <li><g:link controller="Project" action="gridlist" params="['s_status':'APPROVED_REQUEST','onlyAdv':'onlyAdv','advAmtIssued':'NO','OVERDUE_CHEQUEVOUCHER':stats['OVERDUE_CHEQUEVOUCHER']?:0,'INCOMPLETE_SETTLEMENT':stats['INCOMPLETE_SETTLEMENT']?:0]" data-ajax="false">Advance <span class="ui-li-count">${stats['APPROVED_REQUEST']?:'0'}</span></g:link></li>
		    <li><g:link controller="Project" action="gridlist" params="['s_status':'APPROVED_REPORT','OVERDUE_CHEQUEVOUCHER':stats['OVERDUE_CHEQUEVOUCHER']?:0,'INCOMPLETE_SETTLEMENT':stats['INCOMPLETE_SETTLEMENT']?:0]" data-ajax="false">Settle <span class="ui-li-count">${stats['APPROVED_REPORT']?:'0'}</span></g:link></li>
		    <li><g:link controller="Voucher" action="list" params="['overdue':'overdue']" data-ajax="false">Overdue Cheque Vouchers <span class="ui-li-count">${stats['OVERDUE_CHEQUEVOUCHER']?:0}</span></g:link></li>
		    <li><g:link controller="Project" action="gridlist" params="['s_status':'APPROVED_REPORT','pids':stats['INCOMPLETE_SETTLEMENT_PIDS']]" data-ajax="false">Incomplete Settlement <span class="ui-li-count">${stats['INCOMPLETE_SETTLEMENT']?:0}</span></g:link></li>
		</ul>
		<div data-role="collapsible" data-inset="true">
		    <h3>Configurations</h3>
		    <ul data-role="listview">
			<li><g:link controller="project" action="ledgerHeadGridList" data-ajax="false">LedgerHead</g:link></li>
		    </ul>
		</div><!-- /collapsible -->
		<div data-role="collapsible" data-inset="true">
		    <h3>Reconcilliations</h3>
		    <ul data-role="listview">
			<li><g:link controller="batch" action="gridlist" data-ajax="false">BRS</g:link></li>
			<li><g:link controller="batch" action="gridlist" data-ajax="false">TRS</g:link></li>
			<li><g:link controller="batch" action="gridlist" data-ajax="false">DRS</g:link></li>
		    </ul>
		</div><!-- /collapsible -->
	</sec:ifAnyGranted>  

        <sec:ifAnyGranted roles="ROLE_CC_OWNER">
		<div data-role="collapsible" data-inset="true">
		    <h3>HR (beta version)</h3>
		    <ul data-role="listview">
			<li><g:link controller="IndividualDepartment" action="gridlist" data-ajax="false">HR Management</g:link></li>
		    </ul>
		</div><!-- /collapsible -->
	</sec:ifAnyGranted>         
	
    </div><!-- /content -->

</body>
</html>