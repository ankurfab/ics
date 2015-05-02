<div>
	<table border="1">
		<tr>
			<th>Vendor</th>
			<th>Invoice Date</th>
			<th>Invoice Number</th>
			<th>Invoice Status</th>
			<th>Donation Amount</th>
			<th>Cash Amount</th>
			<th>Credit Amount</th>
			<th>Credit Amount Due</th>
			<th>Credit Amount Paid</th>
			<th>Payment Details</th>
			<th>Invoice Items</th>
		</tr>
		<g:set var="donationTotal" value="${new BigDecimal(0)}" />
		<g:set var="cashTotal" value="${new BigDecimal(0)}" />
		<g:set var="creditTotal" value="${new BigDecimal(0)}" />
		<g:set var="dueTotal" value="${new BigDecimal(0)}" />
		<g:set var="paidTotal" value="${new BigDecimal(0)}" />
		<g:each var="invoice" in="${invoices}">
		<tr>
			<td>${invoice.preparedBy}</td>
			<td>${invoice.invoiceDate?.format('dd-MM-yy')}</td>
			<td>${invoice.invoiceNumber}</td>
			<td>${invoice.status}</td>
			<td>${invoice.mode=='DONATION'?invoice.invoiceAmount:''}</td>
			<g:set var="donationTotal" value="${donationTotal+(invoice.mode=='DONATION'?invoice.invoiceAmount:0)}" />
			<td>${invoice.mode=='CASH'?invoice.invoiceAmount:''}</td>
			<g:set var="cashTotal" value="${cashTotal+(invoice.mode=='CASH'?invoice.invoiceAmount:0)}" />
			<td>${invoice.mode=='CREDIT'?invoice.invoiceAmount:''}</td>
			<g:set var="creditTotal" value="${creditTotal+(invoice.mode=='CREDIT'?invoice.invoiceAmount:0)}" />
			<td>${invoice.mode=='CREDIT'?(invoice.invoiceAmount-(invoice.paymentReference?.amount?:0)):''}</td>
			<g:set var="dueTotal" value="${dueTotal+(invoice.mode=='CREDIT'?(invoice.invoiceAmount-(invoice.paymentReference?.amount?:0)):0)}" />
			<td>${invoice.paymentReference?.amount}</td>
			<g:set var="paidTotal" value="${paidTotal+(invoice.paymentReference?.amount?:0)}" />
			<td>${invoice.paymentReference}</td>
			<td>${invoice.lineItems?.collect{it.item?.name+" Qty:"+(it.qty?:0)+(it.unit?:'')+" Rate:"+(it.rate?:0)+"/- Tax:"+(it.taxRate?:0)+"%"}}</td>
		</tr>
		</g:each>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td>Totals:</td>
			<td>${donationTotal}</td>
			<td>${cashTotal}</td>
			<td>${creditTotal}</td>
			<td>${dueTotal}</td>
			<td>${paidTotal}</td>
			<td></td>
			<td></td>
		</tr>
		
	</table>
</div>


