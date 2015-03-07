<div>
	<table border="1">
		<tr>
			<th>Item</th>
			<th>Purchased Quantity</th>
			<th>Purchase Worth</th>
			<th>Sold Quantity</th>
			<th>Sold Worth</th>
		</tr>
		<g:set var="totalPQ" value="${new BigDecimal(0)}" />
		<g:set var="totalPW" value="${new BigDecimal(0)}" />
		<g:set var="totalSQ" value="${new BigDecimal(0)}" />
		<g:set var="totalSW" value="${new BigDecimal(0)}" />
		<g:each var="itemstock" in="${stock}">
		<tr>
			<td>${itemstock['ITEM']}</td>
			<td>${itemstock['PURCHASE'][0]?:0}</td>
			<td>${itemstock['PURCHASE'][1]?:0}</td>
			<td>${itemstock['SALES'][0]?:0}</td>
			<td>${itemstock['SALES'][1]?:0}</td>
			<g:set var="totalPQ" value="${totalPQ+(itemstock['PURCHASE'][0]?:0)}" />
			<g:set var="totalPW" value="${totalPW+(itemstock['PURCHASE'][1]?:0)}" />
			<g:set var="totalSQ" value="${totalSQ+(itemstock['SALES'][0]?:0)}" />
			<g:set var="totalSW" value="${totalSW+(itemstock['SALES'][1]?:0)}" />
		</tr>
		</g:each>
		<tr>
			<td>Totals:</td>
			<td>${totalPQ}</td>
			<td>${totalPW}</td>
			<td>${totalSQ}</td>
			<td>${totalSW}</td>
		</tr>
		
	</table>
</div>


