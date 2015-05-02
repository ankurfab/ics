<%@ page import="ics.Voucher" %>


<g:hiddenField name="voucheridForCollected" value="${voucherInstance?.id}" />

<div class="allbody"> 

   
<fieldset class="form">

<div>
	<label for="instrumentCollectedComments">Comments</label>
	<g:textArea name="instrumentCollectedComments" value="${voucherInstance?.instrumentCollectedComments}" rows="5" cols="40"/>
</div>

</fieldset>

</div>