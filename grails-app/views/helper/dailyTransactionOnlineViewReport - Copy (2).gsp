<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Daily Transactions Report</title>
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
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Daily Transaction Report</a></span>

            
        </div>


            <div class="list">
            	<table>
                	<tr>
                	<td>
                	<b>ReceiverName: <g:link controller="individual" action="show" id="${receiver?.id}">${receiver}</b></g:link>
                	</td>
                	</tr>
                	<tr>
                	<td>
                	<b>Between: ${fd.format("dd-MM-yy")} and ${td.format("dd-MM-yy")}</b>
                	</td>
                	</tr>
                </table>
                </div>
	    	    	    		
	<g:if test="${denominationInstanceList?.size()>0}">
	<b>Denominations</b>
            <div class="list">
            
                <table id="example">
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'denomination.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="collectionDate" title="${message(code: 'denomination.collectionDate.label', default: 'Collection Date')}" />
                        
                            <th><g:message code="denomination.collectedBy.label" default="Collected By" /></th>
                            
                            <th> Denomination </th>
                            
                            <g:sortableColumn property="status" title="${message(code: 'denomination.status.label', default: 'Status')}" />
                            <g:sortableColumn property="ackBy" title="${message(code: 'denomination.ackBy.label', default: 'Ack By')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${denominationInstanceList}" status="i" var="denominationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${denominationInstance.id}">${fieldValue(bean: denominationInstance, field: "id")}</g:link></td>
                        
                            <td><b><g:formatDate format="dd-MM-yyyy" date="${denominationInstance.collectionDate}" /></b></td>
                        
                            <td><b>${fieldValue(bean: denominationInstance, field: "collectedBy")}</b></td>
                            
                            <td> <b>${denominationInstance}</b> </td>
                        
                            <td> <b>${denominationInstance.status}</b> </td>
                        
                            <td> <b>${denominationInstance.ackBy}</b> </td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
         </g:if>


	<g:if test="${donationList?.size()>0}">
	<g:set var="sum" value="${0}" />
            <div class="list">
                <table id="example">
                    <thead>
                        <tr>
                        
                           <g:if test="${receiver == '' || receiver == null}">
                           	<th>Receiver</th>
                           </g:if>
                            <th>DonorName</th>
			    <th>CollectorName</th>                            
                            <!--<th>Address</th>
                            <th>Phone</th>
                            <th>EmailId</th>-->
                            <th>BookNo</th>
                            <th>ReceiptNo</th>
                            <th>DonationAmount</th>
                            <th>PaymentMode</th>
                            <th>ChequeNo</th>
                            <th>ChequeDate</th>
                            <th>BankName</th>
                            <th>BankBranch</th>
                            <th>DonationType</th>
                            <th>ReceiptDate</th>
							<th>Remarks</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${donationList}" status="i" var="donationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                           <g:if test="${receiver == '' || receiver == null}">
                           	<th>${donationInstance?.receivedBy}</th>
                           </g:if>                            
                            <td><g:link controller="individual" action="show" id="${donationInstance?.donatedBy?.id}">${donationInstance?.donatedBy}</g:link></td>
                            <td><g:link controller="individual" action="show" id="${donationInstance?.collectedBy?.id}">${donationInstance?.collectedBy}</g:link></td>                            
                            <!--<td>${donationInstance?.donatedBy?.address?.toString()}</td>
                            <td>${donationInstance?.donatedBy?.voiceContact?.toString()}</td>
                            <td>${donationInstance?.donatedBy?.emailContact?.toString()}</td>-->
                            <g:if test="${donationInstance?.nvccReceiptBookNo}">
                            	<td><b>${donationInstance?.nvccReceiptBookNo}</b></td>
                            </g:if>
                            <g:else>
                            	<td><b>${bulkDonationReceiptBookNo[i]}</b></td>
                            </g:else>
                            <g:if test="${donationInstance?.nvccReceiptNo}">
                            	<td><b>${donationInstance?.nvccReceiptNo}</b></td>
                            </g:if>
                            <g:else>
                            	<td><b>${bulkDonationReceiptNo[i]}</b></td>
                            </g:else>
                            <td><b>${donationInstance?.amount}</b></td>
                            <g:set var="sum" value="${sum + donationInstance?.amount}" />
                            <td><b>${donationInstance?.mode}</b></td>
                            <td><b>${donationInstance?.chequeNo}</b></td>
                            <td><b>${donationInstance?.chequeDate?.format('dd-MM-yy')}</b></td>
                            <g:if test="${donationInstance?.bank}">	
                            	<td><b>${donationInstance?.bank}</b></td>
                            </g:if>
                            <g:else>
                            	<td><b>${donationInstance?.bankName}</b></td>
                            </g:else>
                            <td><b>${donationInstance?.bankBranch}</b></td>
                            <td><b>${donationInstance?.scheme}</b></td>
                            <td><b>${donationInstance?.fundReceiptDate.format('dd-MM-yyyy')}</b></td>

                            <td><b>${donationInstance?.comments}</b></td>
                        </tr>
                        
                    </g:each>
                    </tbody>
                </table>
              
            </div>
            <br>
            <div>
            <g:each in="${totalsByMode}" status="i" var="tm">
            	<table>
            	<tr>
            		<td width="12%">
            			<b>${tm.pmode}</b>
            		</td>
            		<td>
            			<b>${tm.amount}</b>
            		</td>
            	</tr>
            	</table>
            </g:each>
            	<table>
            	<tr>
            		<td width="12%">
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