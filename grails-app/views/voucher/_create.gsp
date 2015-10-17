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
	<g:textField name="description" value=""/>
</div>

<div id="divAnotherLedger">
	<g:select id="anotherLedger" name='anotherLedger' value=""
	    noSelection="${['':'Select To Department...']}"
	    from='${ics.CostCenter.findAllByStatusIsNull([sort:'name'])}' optionKey="id"></g:select>	
</div>

</fieldset>

</div>

<script>
  $(document).ready(function () {
	$("#divAnotherLedger").hide();
	$( "#type" ).change(function() {
		if($( "#type option:selected" ).text()=="Journal")
			$("#divAnotherLedger").show();
		else
			$("#divAnotherLedger").hide();
	});
  });
</script>