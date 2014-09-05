<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>NVCC Sevak Report</title>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_page.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_table.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'TableTools.css')}" type="text/css" media="print, projection, screen"/>

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
			    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">NVCC Sevak Report</a></span>
        	</div><br>
	
	<g:set var="totalCommitment" value="${0}" />
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
                            <th>Committed Amount</th>
                            <th>Commitment From</th>
                            <th>Commitment Till</th>
                            <th>Total Collection</th>
			    <th>Total Donation</th>
			    <th>Total Advance Donation</th>
			    <th>Total Contribution</th>
			    <th>Commitment Due</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${commitmentQueryResult}" status="i" var="individualInstance">
                    
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <g:set var="total" value="${0}" />
                            
                            <td><b><g:link controller="individual" action="show" id="${individualInstance.councellorid}">${individualInstance.councellorname}</g:link></b></td>
                            <td><b><g:link controller="individual" action="show" id="${individualInstance.councelleeid}">${individualInstance.councellee_legal_name}</g:link></b></td>
                            <td><b><g:link controller="individual" action="show" id="${individualInstance.councelleeid}">${individualInstance.councellee_initiated_name}</g:link></b></td>
                            <td><b>${individualInstance?.committed_amount}</b></td>
                            <td><b>${individualInstance?.commitment_on?.format("dd-MM-yyyy")}</b></td>
                            <td><b>${individualInstance?.commitment_till?.format("dd-MM-yyyy")}</b></td>
	                    <td><b>${collectionQueryResult[i]?.Collection ? collectionQueryResult[i]?.Collection:0.00}</b></td>
		 	    <td><b>${donationQueryResult[i]?.Donation ? donationQueryResult[i]?.Donation:0.00}</b></td>
			    <td><b>${advanceDonationQueryResult[i]?.AdvanceDonation ? advanceDonationQueryResult[i]?.AdvanceDonation:0.00}</b></td>
			    <g:set var="total" value="${total + (collectionQueryResult[i]?.Collection ? collectionQueryResult[i]?.Collection:0) + (donationQueryResult[i]?.Donation ? donationQueryResult[i]?.Donation:0) + (advanceDonationQueryResult[i]?.AdvanceDonation ? advanceDonationQueryResult[i]?.AdvanceDonation:0)}" />
			    <td><b>${total}</b></td>
			    <g:set var="totalCommitment" value="${totalCommitment + (individualInstance?.committed_amount ? individualInstance?.committed_amount:0) }" />
			    <g:set var="totalCollection" value="${totalCollection + (collectionQueryResult[i]?.Collection ? collectionQueryResult[i]?.Collection:0) }" />
			    <g:set var="totalDonation" value="${totalDonation + (donationQueryResult[i]?.Donation ? donationQueryResult[i]?.Donation:0)}" />
			    <g:set var="totalAdvanceDonation" value="${totalAdvanceDonation + (advanceDonationQueryResult[i]?.AdvanceDonation ? advanceDonationQueryResult[i]?.AdvanceDonation:0)}" />
			    <g:set var="grandTotal" value="${grandTotal + total}" />
			    <td><b>${individualInstance?.committed_amount - total}</b></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <table>
                       <tr class="none"}">
                            <td colspan="2"><b>Summary of Commitment and Contribution from Councellees from ${fd?.format("dd-MM-yyyy")} to ${td?.format("dd-MM-yyyy")}</b></td>
                       </tr>
                       <tr class="none"}">
                            <td width="15%"><b>Total Commitment</b></td>
                            <td width="85%"><b>${totalCommitment}</b></td>
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
                            <td width="15%"><b>Contribution Total</b></td>
                            <td width="85%"><b>${grandTotal}</b></td>
                        </tr>
                </table>
                
            </div>
	


        </div>
    </body>
</html>