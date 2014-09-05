<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Daily Transaction Report</title>
       
    </head>
    <body>
        <div class="body">
         
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Daily Transaction Report</a></span>
			<g:jasperReport jasper="${reportName}" format="PDF,XLS" name="Report" >
				<input type="hidden" name="param_receivers" value=${param_receivers} />
				<input type="hidden" name="param_fromDate" value=${param_fromDate} />
				<input type="hidden" name="param_toDate" value=${param_toDate} />
				<input type="hidden" name="param_grandTotal" value=${param_grandTotal} />
				<!--<input type="hidden" name="param_totalsByMode" value=${totalsByMode} />-->
			</g:jasperReport>
            
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
            
                <table>
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
                        
                            <td><g:link controller="denomination" action="show" id="${denominationInstance.id}">${fieldValue(bean: denominationInstance, field: "id")}</g:link></td>
                        
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

	<br>
	<g:if test="${donationList?.size()>0}">
	<g:set var="sum" value="${0}" />
            <div class="list">
                <table>
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
				    <g:if test="${donationInstance?.donationReceipt?.id==1}">
					<td><b>${donationInstance?.nvccReceiptBookNo}</b></td>
				    </g:if>
				    <g:else>
					<td><b>${donationInstance?.donationReceipt?.book}</b></td>
				    </g:else>                            	
                            </g:if>
                            <g:else>
                            	<td><b>${bulkDonationReceiptBookNo[i]}</b></td>
                            </g:else>
                            <g:if test="${donationInstance?.nvccReceiptNo}">
				    <g:if test="${donationInstance?.donationReceipt?.id==1}">
					<td><b>${donationInstance?.nvccReceiptNo}</b></td>
				    </g:if>
				    <g:else>
					<td><b>${donationInstance?.donationReceipt?.receiptNumber}</b></td>
				    </g:else>                            	                            	
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
            <table>
            	<tr>
            		<td>
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
			   </td>
            		<td>
			    <g:each in="${totalsByScheme}" status="i" var="ts">
				<table>
				<tr>
					<td width="12%">
						<b>${ts.scheme}</b>
					</td>
					<td>
						<b>${ts.amount}</b>
					</td>
				</tr>
				</table>
			    </g:each>
			   </td>
            		<td>
			    <g:each in="${totalsByCostCenter}" status="i" var="ts">
				<table>
				<tr>
					<td >
						<b>${ts.costcategory}</b>
					</td>
					<td >
						<b>${ts.costcenter}</b>
					</td>
					<td >
						<b>${ts.mode}</b>
					</td>
					<td>
						<b>${ts.amount}</b>
					</td>
				</tr>
				</table>
			    </g:each>
			   </td>
		</tr>
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