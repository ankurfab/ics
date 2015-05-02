<g:form name="formSettleChallan" controller="Challan" action="settle" method="post" >

<g:hiddenField name="settlechallanid" value="" />
<g:hiddenField name="settleoper" value="" />

<g:set var="items" value="${challan.lineItems.sort{it.book.name}}" />
<g:set var="issuedTotal" value="${challan.lineItems?.sum{it.issuedQuantity*it.rate}?:0}" />
<g:set var="returnTotal" value="${challan.lineItems?.sum{it.returnedQuantity*it.rate}?:0}" />
<g:set var="paymentsTotal" value="${challan.paymentReferences?.sum{it.amount}?:0}" />
<g:set var="expensesTotal" value="${challan.expenses?.sum{it.approvedAmount}?:0}" />
<g:set var="due" value="${issuedTotal+(challan.advanceAmount?:0)-paymentsTotal-expensesTotal}" />
<g:set var="numItems" value="${items?.size()}" />

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
				Challan Amount
			</td>
			<td>
				${issuedTotal}
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
				${expensesTotal==0?'':expensesTotal}
			</td>
		</tr>
		<tr>
			<td>
				Total Sale Value
			</td>
			<td id="saleTotalSummary">
				
			</td>
			<td>
				Total Return Value
			</td>
			<td  id="returnTotalSummary">
			</td>
		</tr>
		<tr>
			<td>
				Total Payment Due
			</td>
			<td>
				<g:textField name="amountDue" value="${due}"/>
			</td>
			<td>
				<g:select name="mode.id" from="${ics.PaymentMode.findAllByInperson(true,[sort:'name'])}" optionKey="id" value="${ ics.PaymentMode.findByNameAndInperson('Cash',true)?.id}"   noSelection="['':'-Select Payment Mode-']"/>
			</td>
			<td>
				<g:textField name="instrumentNo" placeholder="Instrument No"/>
				<g:textField name="instrumentDate" placeholder="Instrument Date(dd-mm-yyyy)"/>
				<g:textField name="bankName" placeholder="Bank Name"/>
				<g:textField name="bankBranch" placeholder="Bank Branch"/>
				<g:textField name="details" placeholder="Payment Comments"/>
			</td>
		</tr>
	</table>
</div>


<div>
	<table class="details" border="1">
		<thead>
			<th>Name</th>
			<th>Language</th>
			<th>Type</th>
			<th>Rate</th>
			<th>IssuedQuantity</th>
			<th>ReturnedQuantity</th>
			<th>ReturnedValue</th>
			<th>NoOfBooksDistributed</th>
			<th>SaleValue</th>
		</thead>
		<g:set var="total" value="${new BigDecimal(0)}" />
		<g:each var="lineItem" in="${items}">
		<tr>
			<td>${lineItem?.book?.name}</td>
			<td>${lineItem?.book?.language}</td>
			<td>${lineItem?.book?.type}</td>
			<td id="${'rate_'+lineItem.id}">${lineItem?.rate}</td>
			<td id="${'issuedQuantity_'+lineItem.id}">${lineItem?.issuedQuantity}</td>
			<td class="returnQuantity"><g:textField name="${'returnedQuantity_'+lineItem.id}" value="${lineItem?.returnedQuantity==0?'':lineItem?.returnedQuantity}"/></td>
			<td class="returnvalue" id="${'return_'+lineItem.id}"></td>
			<td class="numdist" id="${'numdist_'+lineItem.id}"></td>
			<td class="salevalue" id="${'sale_'+lineItem.id}"></td>
		</tr>
		<g:set var="total" value="${(total?:0)+((lineItem?.issuedQuantity-lineItem?.returnedQuantity) * lineItem?.rate)}" />
		</g:each>
		<tr class="sum">
			<td></td>
			<td>Total</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td id="returnTotal">${returntotal}</td>
			<td></td>
			<td id="saleTotal">${total}</td>
		</tr>
		
	</table>
</div>

<div class="dialog">
	<table border="1">
		<tr>
			<td>
				Team Members
			</td>
			<td>
				<g:textField name="teamMembers" value="" placeholder="Please enter comma seperated team member names" size="150" rows="5" cols="40"/>
			</td>
		</tr>
	</table>
</div>

</g:form>


<script type="text/javascript">
  jQuery(document).ready(function () {

	$( ".returnQuantity" ).change(function(event) {
		var elementId = event.target.id;
		var cliId = elementId.split('_')[1];
		//alert( "Handler for .change() called for CLI:"+cliId );
		  //get rate  
		  var rate = $('#rate_'+cliId).html();
		  var iqty = $('#issuedQuantity_'+cliId).html();
		  var rqty = $('#returnedQuantity_'+cliId).val();
		  var qty = iqty-rqty;
		  //alert(iqty+" - "+rqty+"="+qty);
		  var saleValue = rate  * qty
		  //change sale value
		  $('#sale_'+cliId).html(saleValue);
		  //change return value
		  $('#return_'+cliId).html(rate*rqty);
		  //change num dist value
		  $('#numdist_'+cliId).html(qty);
		  
		  //update totals
		  var table = $('#details');
		  //$('#saleTotal').html(sumOfColumns(table, 3));
		  var total = calculateSum('.salevalue');
		  //alert(total);
		  $('#saleTotal').html(total);
		  $('#saleTotalSummary').html(total);

		  var returntotal = calculateSum('.returnvalue');
		  //alert(returntotal);
		  $('#returnTotal').html(returntotal);
		  $('#returnTotalSummary').html(returntotal);


		  var sum = ${due};
		  //var sum = 0;
		   $('#amountDue').val(sum-returntotal);
	});


function sumOfColumns(table, columnIndex) {
    var tot = 0;
    table.find("tr").children("td:nth-child(" + columnIndex + ")")
    .each(function() {
        $this = $(this);
        alert($this);
        if (!$this.hasClass("sum") && $this.html() != "") {
            alert($this.html());
            tot += parseInt($this.html());
        }
    });
    return tot;
}

function calculateSum(cls) {
    var tot = 0;
	$(cls).each(function(i, obj) {
        if ($(this).html() != "") {
            //alert($this.html());
            tot += parseInt($(this).html());
        	}
	});
    return tot;
}

	$("#instrumentDate").datepicker({
		yearRange : "-1:+0",
		changeMonth : true,
		changeYear : true,
		dateFormat : 'dd-mm-yy'
	});

    });
</script>