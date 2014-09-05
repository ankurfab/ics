<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Councellorwise Advance Donation Detailed Report</title>
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
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Councellorwise Advance Donation Detailed Report</a></span>
        </div>

	
            <div class="list">
		<div id="ft">
			<!-- PUT FOOTER CODE HERE -->
			<a style="text-decoration:underline; color:black;" href="http://www.iskconpune.com">Councellorwise Advance Donation Detailed Report</a>

		</div>
		<br>
		<div>
			<b>Councellor: ${councellor}<b>
		</div>
 		<br>
                <table id="example">
                    <thead>
                        <tr>
                        	<th>AdvanceDonationId</th>
                                <th>AdvanceDonationBy</th>
                        	<th>AdvanceDonationDate</th>
                        	<th>AdvanceDonationStartDate</th>
                        	<th>AdvanceDonationEndDate</th>
                        	<th>ModeOfPayment</th>
                        	<th>ReceiptNo</th>
                        	<th>Amount</th>
                        	<th>Status</th>
                        	<th>FD Number</th>
                        	<th>FD Amount</th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    
                    	<g:each in="${councellorLoanDetailedList}" status="i" var="loanInstance">
                        <tr class="none"}">
                            <td><g:link controller="loan" action="show" id="${loanInstance?.id}">${loanInstance?.id}</g:link></td>
                            <td>${loanInstance?.loanedBy?.toString()}</td>
                            <td>${loanInstance?.loanDate?.format('dd-MM-yyyy')}</td>
                            <td>${loanInstance?.loanStartDate?.format('dd-MM-yyyy')}</td>
                            <td>${loanInstance?.loanEndDate?.format('dd-MM-yyyy')}</td>
                            <td>${loanInstance?.mode?.name}
                            <g:if test="${loanInstance?.mode?.name == 'Cheque'}">
                            	ChequeNo: ${loanInstance?.chequeNo}
                            	ChequeDate: ${loanInstance?.chequeDate?.format('dd-MM-yyyy')}
                            	BankName: ${loanInstance?.bankName}
                            	BankBranch: ${loanInstance?.bankBranch}
                            </g:if>
                            </td>
                            <td>${loanInstance?.loanReceiptNo}</td>
                            <td>${loanInstance?.amount}</td>
                            <td>${loanInstance?.status}</td>
                            <td>${loanInstance?.fdNumber}</td>
                            <td>
				<g:if test="${loanInstance?.fdNumber}">
				${(loanInstance?.amount).toInteger()/2}
				</g:if>
                            </td>
                        </tr>
                        </g:each>
                    </tbody>
                </table>
                <table>
                        <tr class="none"}">                            
                            <td width="10%"><b>Total Amount</b></td>
                            <td width="90%"><b>${totalAmount}</b></td>
			</tr>
			<tr>
                            <td width="10%"><b>Total FD Amount</b></td>
                            <td width="90%"><b>${totalFDAmount}</b></td>
                        </tr>
                </table>
                
            </div>


        </div>
    </body>
</html>