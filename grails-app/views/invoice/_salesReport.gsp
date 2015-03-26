<div>
	<table border="1">
		<tr>
			<th>Consumer</th>
			<th>Invoice Date</th>
			<th>Invoice Number</th>
			<th>Invoice Status</th>
			<th>Invoice Amount</th>
			<th>Invoice Item Amount</th>
			<th>Invoice Items</th>
		</tr>
		<g:set var="total" value="${new BigDecimal(0)}" />
		<g:each var="invoice" in="${invoices}">
		<tr>
			<td>${invoice.personTo}</td>
			<td>${invoice.invoiceDate?.format('dd-MM-yy')}</td>
			<td>${invoice.invoiceNumber}</td>
			<td>${invoice.status}</td>
			<td>${invoice.invoiceAmount}</td>
			<g:set var="invoicetotal" value="${new BigDecimal(0)}" />
			<g:set var="invoicetotal" value="${invoice.lineItems?.sum{(it.qty?:0)*(it.rate?:0)*(1+(it.taxRate?:0)/100)}}" />
			<td>${invoicetotal}</td>
			<td>${invoice.lineItems?.collect{it.item?.name+" Qty:"+(it.qty?:0)+(it.unit?:'')+" Rate:"+(it.rate?:0)+"/- Tax:"+(it.taxRate?:0)+"%"}}</td>
			<!--<g:set var="total" value="${total+(invoice.invoiceAmount?:0)}" />-->
			<g:set var="total" value="${total+invoicetotal}" />
		</tr>
		</g:each>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>Totals:</td>
			<td>${total}</td>
			<td></td>
		</tr>
		
	</table>
</div>


