

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
			<li><g:link controller="Project" action="list" params="['status':'APPROVED_REQUEST']" data-ajax="false">Approved Requests<span class="ui-li-count">${stats['APPROVED_REQUEST']?:'0'}</span></g:link></li>
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
		</ul>
		<div data-role="collapsible" data-inset="true">
		    <h3>Configurations</h3>
		    <ul data-role="listview">
			<li><g:link controller="costCenter" action="budget" data-ajax="false">Budget</g:link></li>
			<li><g:link controller="project" action="costCategoryGridlist" data-ajax="false">CostCategory/CostCenter</g:link></li>
			<li><g:link controller="project" action="costCenterGroupGridList" data-ajax="false">VerticalHead/Department</g:link></li>
			<li><g:link controller="project" action="ledgerHeadGridList" data-ajax="false">LedgerHead</g:link></li>
		    </ul>
		</div><!-- /collapsible -->
	</sec:ifAnyGranted>         

        <sec:ifAnyGranted roles="ROLE_CC_OWNER,ROLE_CG_OWNER,ROLE_FINANCE">
		<div data-role="collapsible" data-inset="true">
		    <h3>Dashboard</h3>
		    <ul data-role="listview">
		        <li><g:link controller="costCenter" action="summary" data-ajax="false">Summary</g:link></li>
			<li><a href="#">Monthly</a></li>
			<li><a href="#">Quarterly</a></li>
			<li><a href="#">Yearly</a></li>
		    </ul>
		</div><!-- /collapsible -->
	</sec:ifAnyGranted>         


        <sec:ifAnyGranted roles="ROLE_ACC_USER">
		<ul data-role="listview" data-count-theme="b" data-inset="true">
		    <li><g:link controller="Project" action="gridlist" params="['status':'APPROVED_REQUEST']" data-ajax="false">Advance <span class="ui-li-count">${stats['APPROVED_REQUEST']?:'0'}</span></g:link></li>
		    <li><g:link controller="Project" action="gridlist" params="['status':'APPROVED_REPORT']" data-ajax="false">Settle <span class="ui-li-count">${stats['APPROVED_REPORT']?:'0'}</span></g:link></li>
		</ul>
		<div data-role="collapsible" data-inset="true">
		    <h3>Reconcilliations</h3>
		    <ul data-role="listview">
			<li><g:link controller="batch" action="gridlist" data-ajax="false">BRS</g:link></li>
			<li><g:link controller="batch" action="gridlist" data-ajax="false">TRS</g:link></li>
			<li><g:link controller="batch" action="gridlist" data-ajax="false">DRS</g:link></li>
		    </ul>
		</div><!-- /collapsible -->
	</sec:ifAnyGranted>  
	
    </div><!-- /content -->

</body>
</html>