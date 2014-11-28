<g:set var="items" value="${bookOrder.lineItems.sort{it.book.name}}" />
<g:set var="numItems" value="${items?.size()}" />
<g:set var="worth" value="${items.sum{it.requiredQuantity*it.book.sellPrice}}" />

<div>
	<table border="1">
		<tr>
			<td>
				Order Number
			</td>
			<td>
				${bookOrder.orderNo}
			</td>
			<td>
				Order Date
			</td>
			<td>
				${bookOrder.orderDate?.format('dd-MM-yyyy HH:mm')}
			</td>
		</tr>
		<tr>
			<td>
				Placed By
			</td>
			<td>
				${bookOrder.placedBy}
			</td>
			<td>
				Counsellor
			</td>
			<td>
				${(bookOrder.placedBy?.category=='JivaDayaDistributor')?bookOrder.placedBy?.nvccIskconRef:(ics.Relationship.findWhere(individual1:bookOrder.placedBy,relation:ics.Relation.findByName('Councellee of'),status:'ACTIVE')?.individual2?.toString())}
			</td>
		</tr>
		<tr>
			<td>
				Phone
			</td>
			<td>
				${ics.VoiceContact.findByCategoryAndIndividual('CellPhone',bookOrder.placedBy)?.number}
			</td>
			<td>
				Email
			</td>
			<td>
				${ics.EmailContact.findByCategoryAndIndividual('Personal',bookOrder.placedBy)?.emailAddress}
			</td>
		</tr>
		<tr>
			<td>
				No of Items
			</td>
			<td>
				${numItems}
			</td>
			<td>
				Worth
			</td>
			<td>
				${worth}
			</td>
		</tr>
		<tr>
			<td>
				Status
			</td>
			<td>
				${bookOrder.status}
			</td>
			<td>
				Challan
			</td>
			<td>
				${bookOrder.challan?.refNo}
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
			<th>SellingPrice</th>
			<th>Quantity</th>
			<th>Total</th>
		</tr>
		<g:set var="total" value="${new BigDecimal(0)}" />
		<g:each var="lineItem" in="${items}">
		<tr>
			<td>${lineItem?.book?.name}</td>
			<td>${lineItem?.book?.language}</td>
			<td>${lineItem?.book?.type}</td>
			<td>${lineItem?.book?.sellPrice}</td>
			<td>${lineItem?.requiredQuantity}</td>
			<td>${lineItem?.requiredQuantity * lineItem?.book?.sellPrice}</td>
		</tr>
		<g:set var="total" value="${(total?:0)+(lineItem?.requiredQuantity * lineItem?.book?.sellPrice)}" />
		</g:each>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td>Totals</td>
			<td></td>
			<td>${total}</td>
		</tr>
		
	</table>
</div>