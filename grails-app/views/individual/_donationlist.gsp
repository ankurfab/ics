<div>

<div id="Donations">
            <sec:ifAnyGranted roles="ROLE_DUMMY,ROLE_BACKOFFICE,ROLE_NVCC_ADMIN,ROLE_PATRONCARE,ROLE_COUNSELLOR">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
			<tr>
				<td valign="top" class="name" colspan="2">
					<b><g:message code="individual.donations.label" default="Donations" /></b><br>
					<table>
					<thead>
						<th>
							Donation
						</th>
						<th>
							Collector
						</th>            
						<th>
							Scheme
						</th>                                 	
                                	
						<th>
							Remarks
						</th>                                 	
						</thead> 	
						<tr>
							<td colspan="9">
							</td>
						</tr>

						<g:each in="${individualInstance.donations?.sort{it.donationDate}?.reverse()}" status="i" var="d">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

								<td>
									<g:link controller="donation" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link>
								</td>
								<td>
									<g:link controller="individual" action="show" id="${d.collectedById}">${d?.collectedBy}</g:link>
								</td>    
								<td>
									${d?.scheme}
								</td>                                  			
								<td>
									${d?.comments}
								</td>                                  			

							</tr>    
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							<td colspan="9">&nbsp;
							</td>
							</tr>
						</g:each>



					</table>
				</td>

			</tr>
			</tbody>
		</table>
		<!-- Donation Records -->
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
			<tr>
				<td valign="top" class="name" colspan="2">
					<b>Donation Records (Donations via ECS/NEFT/Other channels)</b><br>
					<table>
					<thead>
						<th>
							DonationDate
						</th>
						<th>
							Amount
						</th>            
						<th>
							Mode
						</th>                                 	
						<th>
							PaymentDetails
						</th>                                 	                                	
						<th>
							ReceiptStatus
						</th>                                 	
						<th>
							Scheme
						</th>                                 	
						</thead> 	

						<g:each in="${ics.DonationRecord.createCriteria().list{
										eq('donatedBy',individualInstance)
										or{
											isNull('receiptReceivedStatus')
											and {
												ne('receiptReceivedStatus','GENERATED')
												ne('receiptReceivedStatus','NOTGENERATED')
											}
										}
										order('donationDate', 'desc')
										}}" status="i" var="dr">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

								<td>
									${dr.donationDate.format('dd-MM-yyyy')}
								</td>
								<td>
									${dr.amount}
								</td>    
								<td>
									${dr.mode}
								</td>    
								<td>
									${dr.paymentDetails}
								</td>                                  			
								<td>
									${dr.receiptReceivedStatus}
								</td>                                  			
								<td>
									${dr.scheme}
								</td>                                  			

							</tr>    
						</g:each>



					</table>
				</td>

			</tr>
			</tbody>
		</table>                            
  	 </sec:ifAnyGranted>
  	</div>
  	
  	</div>