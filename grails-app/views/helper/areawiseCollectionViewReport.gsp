<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Areawise Collections Report</title>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_page.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_table.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'TableTools.css')}" type="text/css" media="print, projection, screen"/>
        
    </head>
    <body>
        <div class="body">
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
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Areawise Collections Report</a></span>
        </div> 
	<g:if test="${uniqueDonations?.size()>0}">
	<g:set var="sum" value="${0}" />

            <div class="list">
		<table>
		<tr>
		<td width="15%"><b>Location</b></td>
		<td width="85%"><b>${locationName}</b></td>
		</tr>
		</table>
 
                <table id="example">
                    <thead>
                        <tr>
                        
                            <!--<th>DonationId</th>-->
                            
                            <th>Name</th>
                            <th>Address</th>
                            <th>Phone</th>
                            <th>EmailId</th>
                            <th>DonationAmount</th>
                            <th>RecptBookNo/ReceiptNo/Amount/ReceiptDate/SubmissionDate</th>
                            <!--<th>BookNo</th>
                            <th>ReceiptNo</th>
                            <th>SubmissionDate</th>
                            <th>ReceiptDate</th>
                            <th>ReceiverName</th>-->

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${uniqueDonations}" status="i" var="donationInstance">
                    <g:if test="${donationInstance}">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                           
                            <td><g:link controller="individual" action="show" id="${donationInstance?.id}">${ics.Individual.get(donationInstance?.id)}</g:link></td>
			    <td><b>${ics.Individual.get(donationInstance?.id)?.address}</b></td>
			    <td><b>${ics.Individual.get(donationInstance?.id)?.voiceContact}</b></td>
			    <td><b>${ics.Individual.get(donationInstance?.id)?.emailContact}</b></td>
                            <td><b>${donationInstance?.amt}</b></td>
                            <td><b>${donationInstance?.details}</b></td>
                            
                            	<g:set var="sum" value="${sum + donationInstance?.amt}" />
                            
                         </tr>
                     </g:if>
                    </g:each>

                    </tbody>
                </table>
                <table>
                <tr>
                <td>
                <b>Total</b>
                </td>
                <td>
                <b>${sum}</b>
                </td>
                </tr>
                </table>
            </div>
	</g:if>


        </div>
    </body>
</html>