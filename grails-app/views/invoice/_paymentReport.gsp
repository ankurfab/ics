<div>
	<table border="1">
		<tr>
			<th>Vendor</th>
			<th>Invoice Date</th>
			<th>Invoice Number</th>
			<th>Credit Amount</th>
			<th>Credit Amount Due</th>
			<th>Credit Amount Paid</th>
			<th>Payment Details</th>
		</tr>
		<g:set var="creditTotal" value="${new BigDecimal(0)}" />
		<g:set var="dueTotal" value="${new BigDecimal(0)}" />
		<g:set var="paidTotal" value="${new BigDecimal(0)}" />
		<g:each var="invoice" in="${invoices}">
		<tr>
			<td>${invoice.preparedBy}</td>
			<td>${invoice.invoiceDate?.format('dd-MM-yy')}</td>
			<td>${invoice.invoiceNumber}</td>
			<td>${invoice.mode=='CREDIT'?invoice.invoiceAmount:''}</td>
			<g:set var="creditTotal" value="${creditTotal+(invoice.mode=='CREDIT'?invoice.invoiceAmount:0)}" />
			<td>${invoice.mode=='CREDIT'?(invoice.invoiceAmount-(invoice.paymentReference?.amount?:0)):''}</td>
			<g:set var="dueTotal" value="${dueTotal+(invoice.mode=='CREDIT'?(invoice.invoiceAmount-(invoice.paymentReference?.amount?:0)):0)}" />
			<td>${invoice.paymentReference?.amount}</td>
			<g:set var="paidTotal" value="${paidTotal+(invoice.paymentReference?.amount?:0)}" />
			<td>${invoice.paymentReference}</td>
		</tr>
		</g:each>
		<tr>
			<td></td>
			<td></td>
			<td>Totals:</td>
			<td>${creditTotal}</td>
			<td>${dueTotal}</td>
			<td>${paidTotal}</td>
			<td></td>
		</tr>
		
	</table>
</div>


