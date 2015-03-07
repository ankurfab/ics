
<%@ page import="ics.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main-jqm-landing" />
        <title>File Expense Report</title>
    </head>
    <body>
    <div role="main" class="ui-content">
	<g:form name="projectForm" controller="Project" action="createReport" method="POST" data-ajax="false">
		<label for="projectid">
			Expense		
		</label>
		<g:select name="projectid"
			  from="${projects}"
			  optionKey="id" noSelection="['':'-Choose Expense-']" required="required"/>	
		<g:submitButton name="start" value="Start" />
	</g:form>
    </div>
    
    </body>
</html>
