<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Schemewise Donations Report</title>
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
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Schemewise Donations Report</a></span>
        </div> 
		
	<g:if test="${donationInstanceList?.size()>0}">
	<g:set var="sum" value="${0}" />

            <div class="list">
 
            	<table>
                	<tr>
                	<td>
                	<b>Scheme: ${scheme}</b>
                	</td>
                	</tr>
                	<tr>
                	<td>
                	<b>Between Dates: ${fd.format("dd-MM-yy")} and ${td.format("dd-MM-yy")}</b>
                	</td>
                	</tr>
                	
                </table>
                <table id="example">
                    <thead>
                        <tr>
                        
                            <th>DonationId</th>
                            <th>Scheme</th>
                            <th>Category</th>
                            <th>Name</th>
                            <th>Address</th>
                            <th>Phone</th>
                            <th>EmailId</th>
                            <th>DonationAmount</th>
                            <th>BookNo</th>
                            <th>ReceiptNo</th>
                            <th>SubmissionDate</th>
                            <th>ReceiptDate</th>
                            <th>Collector</th>
                            <th>ReceiverName</th>

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${donationInstanceList}" status="i" var="donationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link controller="donation" action="show" id="${donationInstance?.id}">${donationInstance?.id}</g:link></td>
                            <td><b>${donationInstance?.scheme}</b></td>
                            <td><b>${donationInstance?.category}</b></td>
                            <td><g:link controller="individual" action="show" id="${donationInstance?.donatedBy?.id}">${donationInstance?.donatedBy}</g:link></td>
                            <td><b>${donationInstance?.donatedBy?.address?.toString()}</b></td>
                            <td><b>${donationInstance?.donatedBy?.voiceContact?.toString()}</b></td>
                            <td><b>${donationInstance?.donatedBy?.emailContact?.toString()}</b></td>
                            <td><b>${donationInstance?.amount}</b></td>
                            <g:set var="sum" value="${sum + donationInstance?.amount}" />
                            <td><b>${donationInstance?.nvccReceiptBookNo}</b></td>
                            <td><b>${donationInstance?.nvccReceiptNo}</b></td>
                            <td><b>${donationInstance?.fundReceiptDate?.format('dd-MM-yy')}</b></td>
                            <td><b>${donationInstance?.donationDate?.format('dd-MM-yy')}</b></td>
                            <td><g:link controller="individual" action="show" id="${donationInstance?.collectedBy?.id}">${donationInstance?.collectedBy}</g:link></td>
                            <td><g:link controller="individual" action="show" id="${donationInstance?.receivedBy?.id}">${donationInstance?.receivedBy}</g:link></td>
                        </tr>
                    </g:each>
                        <tr class="none"}">
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><b>Total</b></td>
                            <td><b>${sum}</b></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
	</g:if>


        </div>
    </body>
</html>