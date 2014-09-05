<g:form name="formPaymentReference" controller="Invoice" action="savePaymentReference" method="post" >

<g:hiddenField name="invoiceids" value="" />

<div class="dialog">
    <table>
	<tbody>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="paymentBy">Payment By</label>
		</td>
		<td valign="top" class="value">
			<g:select id="paymentBy" name='paymentBy.id'
			    noSelection="${['null':'Paid by...']}"
			    optionKey="id" 
			    from='${ics.IndividualDepartment.createCriteria().list{eq('status','ACTIVE') department{ilike('name','%Kitchen%')}}?.collect{it.individual}}'>
			    </g:select>
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="paymentTo">Payment To</label>
		</td>
		<td valign="top" class="value">
			<g:select id="paymentTo" name='paymentTo.id'
			    noSelection="${['null':'Paid to...']}"
			    optionKey="id" 
			    from='${ics.Individual.findAllByCategory("VENDOR")}'>
			    </g:select>
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="mode">Payment Mode</label>
		</td>
		<td valign="top" class="value">
		    <g:select name="mode.id" from="${ics.PaymentMode.findAllByInperson(true,[sort:'name'])}" optionKey="id" value="${ ics.PaymentMode.findByNameAndInperson('Cheque',true)?.id}"   noSelection="['':'-Select Payment Mode-']"/>
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="amount">Amount</label>
		</td>
		<td valign="top" class="value">
		    <g:textField name="amount"/>
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="paymentDate">Payment Date</label>
		</td>
		<td valign="top" class="value">
		    <g:textField name="paymentDate"/>
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="details">Details</label>
		</td>
		<td valign="top" class="value">
		    <g:textField name="details"/>
		</td>
	    </tr>

	</tbody>
    </table>
</div>
</g:form>


<script type="text/javascript">
  jQuery(document).ready(function () {

	$("#paymentDate").datepicker({
		yearRange : "-2:+0",
		changeMonth : true,
		changeYear : true,
		dateFormat : 'dd-mm-yy'
	});

    });
</script>
