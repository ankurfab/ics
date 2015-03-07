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
			      <sec:ifAnyGranted roles="ROLE_KITCHEN_ADMIN">
				  <tr>
				    <td>
					<g:link class="list" action="pricelist" controller="Item">Price List</g:link>
				    </td>
				  </tr>
				  <tr>
				    <td>
					<g:link class="list" action="vendorReport" controller="Invoice">Vendor Report</g:link>
				    </td>
				  </tr>
				  <tr>
				    <td>
					<g:link class="list" action="salesReport" controller="Invoice">Sales Report</g:link>
				    </td>
				  </tr>
				  <tr>
				    <td>
					<g:link class="list" action="stockReport" controller="Invoice">Stock Report</g:link>
				    </td>
				  </tr>
				  <tr>
				    <td>
					<g:link class="list" action="paymentReport" controller="Invoice">Payment Report</g:link>
				    </td>
				  </tr>

			      </sec:ifAnyGranted>
		       </tbody>
		   </table>
		</div>
	</div>
	
    </body>
</html>