    <div>
	<table>
		<thead>
			<th>Bill Payment Mode</th>
			<th>Particulars</th>
			<th>Bill Availability</th>
			<th>Amount </th>
			<th>Vendor</th>
			<th>Bill No</th>
			<th>Bill Date</th>
		</thead>
				
		<!-- show the part payment row(s) if any -->
		<g:each in="${childProjects}" var="ppProject">
			<tr>				
				<td>${ppProject.advancePaymentVoucher?.mode}</td> 
				<td>${ppProject.advancePaymentVoucher?.description}</td> 
				<td>${ppProject.advancePaymentVoucher?.voucherNo}</td>
				<td>${ppProject.advancePaymentVoucher?.amount}</td>
				<td>${ppProject.advanceIssuedTo}</td>
				<td>${ppProject.advancePaymentVoucher?.voucherNo}</td>
				<td>${ppProject.advancePaymentVoucher?.voucherDate?.format('dd-MM-yyyy')}</td>
			</tr>
		</g:each>
		        
	</table>		       
		
        </div>
