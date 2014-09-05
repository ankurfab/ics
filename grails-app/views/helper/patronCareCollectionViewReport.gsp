<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Collector Report</title>
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
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Collector Report</a></span>
        </div> 

	<g:if test="${donationList?.size()>0}">
	<g:set var="sum" value="${0}" />

	      <sec:ifNotGranted roles="ROLE_NVCC_ADMIN">
            <div class="list">
            
            	<table>
                	<tr>
                	<td>
                	<b>CollectorName: <g:link controller="individual" action="show" id="${collector?.id}">${collector}</b></g:link>
                	</td>
                	</tr>
                </table>
                </div>
               </sec:ifNotGranted>
            <div class="list">
                <table id="example">
                    <thead>
                        <tr>
                        
                            <th>Collector</th>
                            <th>Cultivator</th>
                            <th>DonationId</th>
                            <th>Name</th>
                            <th>Address</th>
                            <th>Phone</th>
                            <th>EmailId</th>
                            <th>DonationAmount</th>
                            <th>BookNo</th>
                            <th>ReceiptNo</th>
                            <th>SubmissionDate</th>
                            <th>ReceiptDate</th>
                            <th>ReceiverName</th>

                        </tr>
                    </thead>
                    <tbody>
                    <g:set var="cultivatorRelation" value="${ics.Relation.findByName('Cultivated by')}" />
                    <g:each in="${donationList}" status="i" var="donationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td  style="word-wrap: break-word"><g:link controller="individual" action="show" id="${donationInstance?.collectedBy.id}">${donationInstance?.collectedBy}</g:link></td>
                            <td  style="word-wrap: break-word">${ics.Relationship.findWhere(status:'ACTIVE',relation:cultivatorRelation,individual1:donationInstance?.donatedBy)?.individual2}</td>
                            <td  style="word-wrap: break-word"><g:link controller="donation" action="show" id="${donationInstance?.id}">${donationInstance?.id}</g:link></td>
                            <td  style="word-wrap: break-word"><g:link controller="individual" action="show" id="${donationInstance?.donatedBy?.id}">${donationInstance?.donatedBy}</g:link></td>
                            <td  style="word-wrap: break-word"><b>${donationInstance?.donatedBy?.address?.toString()}</b></td>
                            <td  style="word-wrap: break-word"><b>${donationInstance?.donatedBy?.voiceContact?.toString()}</b></td>
                            <td  style="word-wrap: break-word"><b>${donationInstance?.donatedBy?.emailContact?.toString()}</b></td>
                            <td  style="word-wrap: break-word"><b>${donationInstance?.amount}</b></td>
                            <g:set var="sum" value="${sum + donationInstance?.amount}" />
                            <td  style="word-wrap: break-word"><b>${donationInstance?.nvccReceiptBookNo}</b></td>
                            <td  style="word-wrap: break-word"><b>${donationInstance?.nvccReceiptNo}</b></td>
                            <td  style="word-wrap: break-word"><b>${donationInstance?.fundReceiptDate?.format('dd-MM-yy')}</b></td>
                            <td  style="word-wrap: break-word"><b>${donationInstance?.donationDate?.format('dd-MM-yy')}</b></td>
                            <td  style="word-wrap: break-word"><g:link controller="individual" action="show" id="${donationInstance?.receivedBy?.id}">${donationInstance?.receivedBy}</g:link></td>
                        </tr>
                    </g:each>
                    </tbody>
                    </table>
                    <table>
                        <tr class="none"}">
                            <td width="7%"><b>Total</b></td>
                            <td width="93%"><b>${sum}</b></td>
                        </tr>
                    
                </table>
            </div>
	</g:if>


        </div>
    </body>
</html>