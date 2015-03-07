
<%@ page import="ics.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main-jqm-landing" />
        <title>New Expense Request</title>
    </head>
    <body>
    <div role="main" class="ui-content">

	<g:if test="${balCheck && !(balCheck?.allow)}">
	<div class="errors" role="status">
		<ul>
		<g:each in="${balCheck.msg}">
		    <li>${it}</li>
		</g:each>
		</ul>
	</div>
	</g:if>

    	<g:if test="${!unsettledExpensesBeyondCutoff}">
    		<g:render template="addproject" />
    	</g:if>
    	<g:else>
    		<div class="errors" role="status">Sorry! You can not raise new request as you have un-settled expense for more than 30 days. Please settle it first. Thank you.</div>
    	</g:else>
    </div>
    
<script>
$(document).ready(function () {
	<g:if test="${unsettledExpenses}">
	alert("Gentle reminder! You have the following unsettled expenses. Please settle them in time (max 30 days). Thank you.\n${unsettledExpenses?.collect{it.name+'/'+it.submitDate?.format('dd-MM-yyyy')+'/'+it.amount}}");
	</g:if>
});
</script>
    </body>
</html>
