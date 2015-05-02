<%@ page import="ics.Voucher" %>


<g:hiddenField name="voucheridForReady" value="${voucherInstance?.id}" />

<div class="allbody"> 

   
<fieldset class="form">

<div>
	<label for="instrumentNo">InstrumentNo</label>
	<g:textField name="instrumentNo" value="${voucherInstance?.instrumentNo}" required="required"/>

	<label for="instrumentDate">InstrumentDate</label>
	<g:textField class="date-input" name="instrumentDate" value="${voucherInstance?.instrumentDate}" />

	<label for="bankName">BankName</label>
	<g:textField name="bankName" value="${voucherInstance?.bankName}" />

	<label for="bankBranch">BankBranch</label>
	<g:textField name="bankBranch" value="${voucherInstance?.bankBranch}" />

	<label for="instrumentReadyComments">Comments</label>
	<g:textArea name="instrumentReadyComments" value="${voucherInstance?.instrumentReadyComments}" rows="5" cols="40"/>
</div>

</fieldset>

</div>

<script>
 $(document).ready(function()
 {   
	$( ".date-input" ).datepicker({dateFormat: 'dd-mm-yy'});

 });
</script>
