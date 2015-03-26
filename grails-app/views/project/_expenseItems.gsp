<div>
	<table>
		<thead>
			<th>Date</th>
			<th>Particulars</th>
			<th>Type</th>
			<th>Amount</th>
		</thead>
		<g:set var="totalExp" value="${new BigDecimal(0)}" />
		<g:set var="advance" value="${projectInstance.advanceIssued?projectInstance.advanceAmountIssued:new BigDecimal(0)}" />
		<g:set var="balance" value="${totalExp-advance}" />
		<g:each in="${expenses}" var="expense">
			<tr>
				<td>
					${expense.expenseDate?.format('dd-MM-yyyy')}
				</td>
				<td>
					${expense.description}
				</td>
				<td>
					${expense.type}
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
					Approved Amount
				</td>
				<td>
					${projectInstance.amount}
				</td>
			   </tr>	
		
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
