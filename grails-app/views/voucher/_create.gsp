<%@ page import="ics.Voucher" %>


<g:hiddenField name="expids" value="${expids}" />

<div class="allbody"> 

   
<fieldset class="form">

<div>
	<label for="type">Type</label>
	<g:select name="type" from="${['Payment','Journal']}"/>
</div>

<div>
	<label for="description">Description</label>
	<g:textArea name="description" value="" rows="5" cols="40"/>
</div>

<div>
	<label for="anotherLedger">Department</label>
	<g:textField name="anotherLedger"/>
</div>

</fieldset>

</div>