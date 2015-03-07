<div>
	<table border="1">
		<tr>
			<th>Consumer</th>
			<th>Invoice Date</th>
			<th>Invoice Number</th>
			<th>Invoice Status</th>
			<th>Invoice Amount</th>
		</tr>
		<g:set var="total" value="${new BigDecimal(0)}" />
		<g:each var="invoice" in="${invoices}">
		<tr>
			<td>${invoice.personTo}</td>
			<td>${invoice.invoiceDate?.format('dd-MM-yy')}</td>
			<td>${invoice.invoiceNumber}</td>
			<td>${invoice.status}</td>
			<td>${invoice.invoiceAmount}</td>
			<g:set var="total" value="${total+(invoice.invoiceAmount?:0)}" />
		</tr>
		</g:each>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td>Totals:</td>
			<td>${total}</td>
		</tr>
		
	</table>
</div>


