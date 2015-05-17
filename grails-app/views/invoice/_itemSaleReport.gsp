<div>
	<table border="1">
		<tr>
			<th>Item</th>
			<th>SoldTo</th>
			<th>SellDate</th>
			<th>InvoiceNo</th>
			<th>Quantity</th>
			<th>UnitSize</th>
			<th>Unit</th>
			<th>Rate</th>
			<th>TaxRate</th>
			<th>Amount</th>
		</tr>
		<g:set var="totalQ" value="${new BigDecimal(0)}" />
		<g:set var="totalA" value="${new BigDecimal(0)}" />
		<g:each var="ili" in="${ilis}">
		<tr>
			<td>${ili.item.name}</td>
			<td>${ili.invoice.personTo}</td>
			<td>${ili.invoice.invoiceDate?.format('dd-MM-yyyy')}</td>
			<td>${ili.invoice.invoiceNumber}</td>
			<td>${ili.qty}</td>
			<g:set var="totalQ" value="${totalQ+(ili.qty?:0)}" />			
			<td>${ili.unitSize}</td>
			<td>${ili.unit}</td>
			<td>${ili.rate}</td>
			<td>${ili.taxRate}</td>
			<g:set var="amt" value="${new Double(ili.qty*ili.rate*(1+((ili.taxRate?:0)/100))).round(2)}" />			
			<g:set var="totalA" value="${totalA+(amt?:0)}" />		
			<td>${amt}</td>
		</tr>
		</g:each>		
		<tr>
			<td/>
			<td/>
			<td/>
			<td>Totals:</td>
			<td>${totalQ}</td>
			<td/>
			<td/>
			<td/>
			<td/>
			<td>${new Double(totalA).round(2)}</td>
		</tr>
	</table>
</div>


