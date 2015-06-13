<html>
    <head>
        <title>Reports</title>
		<meta name="layout" content="main" />
		
	
    </head>
    <body>
    

	<div id="body">
	        <h1>Reports</h1>
	           <div id="reportList" class="dialog">
		      <table>
			<tbody bgcolor="lavender">
			      <sec:ifAnyGranted roles="ROLE_FINANCE">
				  <tr>
				    <td>
					<g:link class="list" action="reportFMA" controller="Project">FMA Report</g:link>
				    </td>
				  </tr>
				  <tr>
				    <td>
					<g:link class="list" action="reportMonthlyExpenses" controller="Project">Monthwise Expenses (Settled)</g:link>
				    </td>
				  </tr>
				  <tr>
				    <td>
					<g:link class="list" action="reportMonthlyExpensesVC" controller="Project">Monthwise Expenses (VoucherCreated)</g:link>
				    </td>
				  </tr>
			      </sec:ifAnyGranted>
		       </tbody>
		   </table>
		</div>
	</div>
	
    </body>
</html>