<div>
	<table border="1">
		<tr>
			<th>Item</th>
			<th>Quantity</th>
			<th>Rate</th>
			<th>Cost</th>
		</tr>
		<g:set var="total" value="${new BigDecimal(0)}" />
		<g:each var="consumption" in="${consumptions}">
		<tr>
			<td>${consumption.name}</td>
			<td>${consumption.quantity}</td>
			<td>${new Double(consumption.amount/consumption.quantity).round(2)}</td>
			<td>${new Double(consumption.amount).round(2)}</td>
			<g:set var="total" value="${total+consumption.amount}" />
		</tr>
		</g:each>
		<tr>
			<td></td>
			<td></td>
			<td>Totals:</td>
			<td>${new Double(total).round(2)}</td>
		</tr>
		
	</table>
</div>


