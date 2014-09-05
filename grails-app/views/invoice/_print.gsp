<div>
	<table border="1">
		<tr>
			<td>
				Invoice Number
			</td>
			<td>
				${invoiceInstance.invoiceNumber}
			</td>
			<td>
				Invoice Date
			</td>
			<td>
				${invoiceInstance.invoiceDate?.format('dd-MM-yyyy')}
			</td>
		</tr>
		<tr>
			<td>
				Prepared By
			</td>
			<td>
				${invoiceInstance.preparedBy}
			</td>
			<td>
				Department By
			</td>
			<td>
				${invoiceInstance.departmentBy}
			</td>
		</tr>
		<tr>
			<td>
				Person To
			</td>
			<td>
				${invoiceInstance.personTo}
			</td>
			<td>
				Department To
			</td>
			<td>
				${invoiceInstance.departmentTo}
			</td>
		</tr>
		<tr>
			<td>
				Due Date
			</td>
			<td>
				${invoiceInstance.dueDate?.format('dd-MM-yyyy')}
			</td>
			<td>
				Status
			</td>
			<td>
				${invoiceInstance.status}
			</td>
		</tr>
		<tr>
			<td>
				Item Total
			</td>
			<td>
				${invoiceInstance.itemTotalAmount}
			</td>
			<td>
				Item Total With Tax
			</td>
			<td>
				${invoiceInstance.itemTotalAmountWithTax}
			</td>
		</tr>
		<tr>
			<td>
				Extra Amount
			</td>
			<td>
				${invoiceInstance.extraAmount}
			</td>
			<td>
				Discount Amount
			</td>
			<td>
				${invoiceInstance.discountAmount}
			</td>
		</tr>
		<tr>
			<td>
				Invoice Amount
			</td>
			<td>
				${invoiceInstance.invoiceAmount}
			</td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td>
				Type
			</td>
			<td>
				${invoiceInstance.type}
			</td>
			<td>
				Description
			</td>
			<td>
				${invoiceInstance.description}
			</td>
		</tr>
	</table>
</div>


<div>
	<table border="1">
		<tr>
			<th>Item Name</th>
			<th>Quantity</th>
			<th>UnitSize</th>
			<th>Unit</th>
			<th>Rate</th>
			<th>TaxRate(%)</th>
			<th>TotalWithoutTax</th>
			<th>TotalWithTax</th>
			<th>Description</th>
		</tr>
		<g:set var="invoiceTotalWitoutTax" value="${new BigDecimal(0)}" />
		<g:set var="invoiceTotalWithTax" value="${new BigDecimal(0)}" />
		<g:each var="lineItem" in="${invoiceInstance?.lineItems}">
		<tr>
			<td>${lineItem?.item?.name}</td>
			<td>${lineItem?.qty}</td>
			<td>${lineItem?.unitSize}</td>
			<td>${lineItem?.unit}</td>
			<td>${lineItem?.rate}</td>
			<td>${lineItem?.taxRate}</td>
			<td>${lineItem?.totalWithoutTax}</td>
			<td>${lineItem?.totalWithTax}</td>
			<td>${lineItem?.description}</td>
		</tr>
		<g:set var="invoiceTotalWitoutTax" value="${(invoiceTotalWitoutTax?:0)+(lineItem?.totalWithoutTax?:0)}" />
		<g:set var="invoiceTotalWithTax" value="${(invoiceTotalWithTax?:0)+(lineItem?.totalWithTax?:0)}" />
		</g:each>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>Totals</td>
			<td></td>
			<td>${invoiceTotalWitoutTax}</td>
			<td>${invoiceTotalWithTax}</td>
			<td></td>
		</tr>
		
	</table>
</div>