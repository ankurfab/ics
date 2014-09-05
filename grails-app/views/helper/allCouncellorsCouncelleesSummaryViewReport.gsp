<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>All Councellors Councellees Summary Report</title>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_page.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_table.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'TableTools.css')}" type="text/css" media="print, projection, screen"/>
	<r:require module="export"/>	

   </head>
    <body>
	<g:javascript src="datatable/jquery.dataTables.min.js" />    
	<g:javascript src="datatable/ZeroClipboard.js" />    
	<g:javascript src="datatable/TableTools.min.js" />    

	<script type="text/javascript" charset="utf-8">
		$(document).ready( function () {
		    $('#example').dataTable( {
			"sDom": 'T<"clear">lfrtip',
			"oTableTools": {
			    "sSwfPath": "${resource(dir: 'swf', file: 'copy_csv_xls_pdf.swf')}"			    
			}
		    } );
		} );

	</script>    
    
        <div class="body">
            <div class="nav">
			    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">All Councellors Councellees Summary Report</a></span>
        	</div><br>
	
	
	<g:set var="totalCollection" value="${0}" />
	<g:set var="totalDonation" value="${0}" />
	<g:set var="totalAdvanceDonation" value="${0}" />
	<g:set var="grandTotal" value="${0}" />
            <div id="demo">
                <table id="example">
                    <thead>


                        <tr>
                        
                            <th>Councellor</th>
                            <th>Councellee Legal Name</th>
                            <th>Councellee Initiated Name</th>
                            <th>Total Collection</th>
			    <th>Total Donation</th>
			    <th>Total Advance Donation</th>
			    <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${queryResult}" status="i" var="individualInstance">
                    
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <g:set var="total" value="${0}" />
                            
                            <td><b><g:link controller="individual" action="show" id="${individualInstance.councellor_id1}">${individualInstance.councellor_name1}</g:link></b></td>
                            <td><b><g:link controller="individual" action="show" id="${individualInstance.councellee_id1}">${individualInstance.councellee_legal_name1}</g:link></b></td>
                            <td><b><g:link controller="individual" action="show" id="${individualInstance.councellee_id1}">${individualInstance.councellee_initiated_name1}</g:link></b></td>
	                    <td><b>${individualInstance?.collection ? individualInstance?.collection:0.00}</b></td>
		 	    <td><b>${individualInstance?.donation ? individualInstance?.donation:0.00}</b></td>
			    <td><b>${individualInstance?.loanAmount ? individualInstance?.loanAmount:0.00}</b></td>
			    <g:set var="total" value="${total + (individualInstance?.collection ? individualInstance?.collection:0) + (individualInstance?.donation ? individualInstance?.donation:0) + (individualInstance?.loanAmount ? individualInstance?.loanAmount:0)}" />
			    <td><b>${total}</b></td>
			    <g:set var="totalCollection" value="${totalCollection + (individualInstance?.collection ? individualInstance?.collection:0) }" />
			    <g:set var="totalDonation" value="${totalDonation + (individualInstance?.donation ? individualInstance?.donation:0)}" />
			    <g:set var="totalAdvanceDonation" value="${totalAdvanceDonation + (individualInstance?.loanAmount ? individualInstance?.loanAmount:0)}" />
			    <g:set var="grandTotal" value="${grandTotal + total}" />
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <table>
                       <tr class="none"}">
                            <td colspan="2"><b>Summary of Contribution from Councellees from ${fd?.format("dd-MM-yyyy")} to ${td?.format("dd-MM-yyyy")}</b></td>
                       </tr>
                       <tr class="none"}">
                            <td width="15%"><b>Total Collection</b></td>
                            <td width="85%"><b>${totalCollection}</b></td>
                        </tr>
                        <tr class="none"}">
                            <td width="15%"><b>Total Donation</b></td>
                            <td width="85%"><b>${totalDonation}</b></td>
                        </tr>
                        <tr class="none"}">
                            <td width="15%"><b>Total Advance Donation</b></td>
                            <td width="85%"><b>${totalAdvanceDonation}</b></td>
                        </tr>
                        <tr class="none"}">
                            <td width="15%"><b>Grand Total</b></td>
                            <td width="85%"><b>${grandTotal}</b></td>
                        </tr>
                </table>
                
            </div>
		    <export:formats formats="['excel']" controller="helper" action="xlsallCouncellorsCouncelleesSummaryViewReport" params="['fromDate':fd?.format("dd-MM-yyyy"), 'toDate':td?.format("dd-MM-yyyy")]"/>
	


        </div>
    </body>
</html>