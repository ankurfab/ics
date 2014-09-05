<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Collectorwise Donors Report</title>
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
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Collectorwise Donors Report</a></span>
        </div> 
        <g:form  method="post">

	<g:if test="${donationList?.size()>0}">
	<g:set var="sum" value="${0}" />
	
	
		<g:hiddenField name="acCollector_id" value="${acCollector_id}" />
		<g:hiddenField name="acCollector" value="${acCollector}" />
	
		<div class="list">

				<!--<div id="ft">

					<a style="text-decoration:underline; color:black;" href="http://www.iskconpune.com">Collectorwise Donors Report</a>

</div>-->
			<table>
				<tr>
				<td>
				<b>CollectorName: <g:link controller="individual" action="show" id="${collector?.id}">${collector}</b></g:link>
				
				</td>
				</tr>
			</table>
			</div>
		<div class="list">
			<table id="example">
			
				<thead>
					<tr>
						<th>Sr.No.</th>

						<th>Name</th>
						<th>DonationAmount</th>
						<th>Address</th>
						<th>Phone</th>
						<th>EmailId</th>
						<th>DateOfBirth</th>
						<th>MarriageDate</th>
						<th>Other Collectors</th>
						<!--<th>BookNo</th>
						<th>ReceiptNo</th>
						<th>SubmissionDate</th>
						<th>ReceiptDate</th>
						<th>ReceiverName</th>-->

					</tr>
				</thead>
				<tbody>

				<g:each in="${donors}" status="i" var="donationInstance">

					<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
						<td><b>${i+1}</b></td>

						<g:if test="${donationInstance?.initiated_name}">
							<td  style="word-wrap: break-word"><g:link controller="individual" action="show" id="${donationInstance?.id}">${donationInstance?.initiated_name}(${donationInstance?.legal_name})</g:link></td>
						</g:if>
						<g:else>
							<td  style="word-wrap: break-word"><g:link controller="individual" action="show" id="${donationInstance?.id}">${donationInstance?.legal_name}</g:link></td>
						</g:else>
							<td  style="word-wrap: break-word"><b>${donationInstance?.amt}</b></td>
						<g:set var="sum" value="${sum + donationInstance?.amt}" />
						<td><b>${Indv?.address[i]}</b></td>
						<td><b>${Indv?.voiceContact[i]}</b></td>
						<td><b>${Indv?.emailContact[i]}</b></td>
						<td><b>${Indv?.dob[i]?.format('dd-MM-yyyy')}</b></td>
						<td><b>${Indv?.marriageAnniversary[i]?.format('dd-MM-yyyy')}</b></td>

						<td><b>
							<ul>
								<g:each var="c" in="${otherCollectorsList[i]}">
									<g:if test="${c}">
										<li><g:link controller="individual" action="show" id="${c.id}">${c}</g:link></li>
									</g:if>

								</g:each>
							</ul>
						</b></td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<table>
				<tr class="none"}">

					<td width="10%"><b>Total</b></td>
					<td width="90%"><b>${sum}</b></td>

				</tr>
			</table>			
		</div>
		
	</g:if>
</g:form>
        </div>
    </body>
</html>