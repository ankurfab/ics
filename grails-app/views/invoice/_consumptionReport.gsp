<div>
	<table border="1">
		<tr>
			<th>Item</th>
			<th>Quantity</th>
			<th>Rate</th>
			<th>Tax Rate(%)</th>
			<th>Cost</th>
		</tr>
		<g:set var="total" value="${new BigDecimal(0)}" />
		<g:each var="consumption" in="${consumptions}">
		<tr>
			<td>${consumption.name}</td>
			<td>${consumption.quantity}</td>
			<td>${consumption.rate}</td>
			<td>${consumption.tax_rate}</td>
			<g:set var="cost" value="${new Double(consumption.quantity*((1+(consumption.tax_rate?:0)/100)*consumption.rate)).round(2)}" />
			<td>${cost}</td>
			<g:set var="total" value="${total+cost}" />
		</tr>
		</g:each>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td>Totals:</td>
			<td>${new Double(total).round(2)}</td>
		</tr>
		
	</table>
</div>


