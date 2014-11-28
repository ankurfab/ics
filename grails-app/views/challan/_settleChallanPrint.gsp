<g:set var="items" value="${challan.lineItems.sort{it.book.name}}" />
<g:set var="paymentsTotal" value="${challan.paymentReferences?.sum{it.amount}}" />
<g:set var="expensesTotal" value="${challan.expenses?.sum{it.approvedAmount}}" />
<g:set var="numItems" value="${items?.size()}" />
<g:set var="bookOrder" value="${ics.BookOrder.findByChallan(challan)}" />

<div class="dialog">
	<table border="1">
		<tr>
			<td>
				Challan Number
			</td>
			<td>
				${challan.refNo}
			</td>
			<td>
				Challan Date
			</td>
			<td>
				${challan.issueDate?.format('dd-MM-yyyy HH:mm')}
			</td>
		</tr>
		<tr>
			<td>
				Issued To
			</td>
			<td>
				${challan.issuedTo.toString()+" (ICS ID:"+challan.issuedTo.icsid+")"}
			</td>
			<td>
				Counsellor
			</td>
			<td>
				${(challan.issuedTo?.category=='JivaDayaDistributor')?challan.issuedTo?.nvccIskconRef:(ics.Relationship.findWhere(individual1:challan.issuedTo,relation:ics.Relation.findByName('Councellee of'),status:'ACTIVE')?.individual2?.toString())}
			</td>
		</tr>
		<tr>
			<td>
				Phone
			</td>
			<td>
				${ics.VoiceContact.findByCategoryAndIndividual('CellPhone',challan.issuedTo)?.number}
			</td>
			<td>
				Email
			</td>
			<td>
				${ics.EmailContact.findByCategoryAndIndividual('Personal',challan.issuedTo)?.emailAddress}
			</td>
		</tr>
		<tr>
			<td>
				Challan Amount
			</td>
			<td>
				${challan.totalAmount}
			</td>
			<td>
				Payments Received
			</td>
			<td>
				${paymentsTotal}
			</td>
		</tr>
		<tr>
			<td>
				<g:if test="${challan.advanceAmount && challan.advanceAmount>0}">
				     Advance Amount
				</g:if>				
			</td>
			<td>
				${challan.advanceAmount}
			</td>
			<td>
				<g:if test="${expensesTotal && expensesTotal>0}">
				     Expenses Made
				</g:if>				
			</td>
			<td>
				${expensesTotal}
			</td>
		</tr>
		<tr>
			<td>
				Settled By
			</td>
			<td>
				${challan.settleBy}
			</td>
			<td>
				Settlement Date
			</td>
			<td>
				${challan.settleDate?.format('dd-MM-yyyy HH:mm')}
			</td>
		</tr>
		<tr>
			<td>
				Comments
			</td>
			<td colspan="3">
				${challan?.comments}
			</td>
		</tr>
	</table>
</div>


<div>
	<table border="1">
		<tr>
			<th>Name</th>
			<th>Language</th>
			<th>Type</th>
			<th>Rate</th>
			<th>Issued</th>
			<th>Returned</th>
			<th>Distributed</th>
			<th>SaleValue</th>
		</tr>
		<g:set var="total" value="${new BigDecimal(0)}" />
		<g:each var="lineItem" in="${items}">
		<tr>
			<g:set var="saleValue" value="${(lineItem?.issuedQuantity-lineItem?.returnedQuantity)*lineItem?.rate}" />
			<td>${lineItem?.book?.name}</td>
			<td>${lineItem?.book?.language}</td>
			<td>${lineItem?.book?.type}</td>
			<td>${lineItem?.rate}</td>
			<td>${lineItem?.issuedQuantity}</td>
			<td>${lineItem?.returnedQuantity}</td>
			<td>${lineItem?.issuedQuantity - lineItem?.returnedQuantity}</td>
			<td>${saleValue}</td>
		</tr>
		<g:set var="total" value="${(total?:0)+saleValue}" />
		</g:each>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>Totals</td>
			<td></td>
			<td>${total}</td>
		</tr>
		
	</table>
</div>

<g:if test="${paymentReference}">
     <div><table><tr><td><b>Final Payment Receipt</b></td></tr></table></div>
     <g:render template="printPaymentReference" model="['challan':challan,'paymentReference':paymentReference]" />
</g:if>

<g:if test="${bookOrder}">
     <div><table border="1"><tr>
     	<td>Team Members</td>
     	<td>${bookOrder.team?.comments}</td>
     	</tr></table></div>
</g:if>
