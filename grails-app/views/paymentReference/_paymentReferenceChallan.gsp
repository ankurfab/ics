<g:form name="formPaymentReference" controller="Challan" action="savePaymentReference" method="post" >

<g:hiddenField name="paymentReferenceEntityId" value="" />

<div class="dialog">
    <table>
	<tbody>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="mode">Payment Mode</label>
		</td>
		<td valign="top" class="value">
		    <g:select name="mode.id" from="${ics.PaymentMode.findAllByInperson(true,[sort:'name'])}" optionKey="id" value="${ ics.PaymentMode.findByNameAndInperson('Cash',true)?.id}"   noSelection="['':'-Select Payment Mode-']"/>
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
		    <label for="instrumentNo">Instrument No</label>
		</td>
		<td valign="top" class="value">
		    <g:textField name="instrumentNo"/>
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="instrumentDate">Instrument Date</label>
		</td>
		<td valign="top" class="value">
		    <g:textField name="instrumentDate"/>
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="bankName">Bank Name</label>
		</td>
		<td valign="top" class="value">
		    <g:textField name="bankName"/>
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="bankBranch">Bank Branch</label>
		</td>
		<td valign="top" class="value">
		    <g:textField name="bankBranch"/>
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

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="paymentDate">Payment Date</label>
		</td>
		<td valign="top" class="value">
		    <g:textField name="paymentDate" value="${new Date().format('dd-MM-yyyy')}"/>
		</td>
	    </tr>



	</tbody>
    </table>
</div>
</g:form>


<script type="text/javascript">
  jQuery(document).ready(function () {

	$("#paymentDate").datepicker({
		yearRange : "-1:+0",
		changeMonth : true,
		changeYear : true,
		dateFormat : 'dd-mm-yy'
	});

	$("#instrumentDate").datepicker({
		yearRange : "-1:+0",
		changeMonth : true,
		changeYear : true,
		dateFormat : 'dd-mm-yy'
	});

    });
</script>
