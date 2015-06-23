<g:set var="ppTotalAmount" value="${new BigDecimal(0)}" />

<g:if test="${childProjects?.size()>0}">
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
				<g:set var="ppTotalAmount" value="${ppTotalAmount+(ppProject?.advancePaymentVoucher?.amount?:0)}" />				
			</tr>
		</g:each>
		        
	</table>		       
		
        </div>
</g:if>

<div>
	<table class="middletable">
		<thead>
			<td><b>S.No</b></td>
			<td><b>Particulars</b></td>
			<td></td>
			<td><b>Amount</b></td>
		</thead>
		<g:set var="totalExp" value="${new BigDecimal(0)}" />
		<g:set var="advance" value="${(projectInstance.advanceAmountIssued?:new BigDecimal(0))+ppTotalAmount}" />
		<g:each in="${expenses}" var="expense" status="i">
			<tr>
				<td>
					${i+1}
				</td>
				<td>
					${expense.description}
				</td>
				<td>
					
				</td>
				<td>
					${expense.amount}
					<g:set var="totalExp" value="${totalExp+expense.amount}" />
				</td>
			</tr>
		</g:each>
		
			<tr>
				<td>
				</td>
				<td> 
				</td>
				<td>
					Less: Advance Taken
				</td>
				<td>
					<div id="advance">${advance}</div>
				</td>
			</tr>
			<tr>
				<td>
				</td>
				<td>
				</td>
				<td>
					Balance returned/payable
				</td>
				<td>
					<g:set var="balance" value="${totalExp-advance}" />
					<div id="balance">${balance}</div>
				</td>
			</tr>
	</table>
</div>
