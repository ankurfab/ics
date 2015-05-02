<h1>Order Entry</h1>
<g:form name="formOrder" action="createOrder" method="post" onsubmit="return validate();">

<g:hiddenField name="distributorid" value="${distributorid}"/>
<g:hiddenField name="contactid" value="${contactid}"/>
<g:hiddenField name="emailid" value="${emailid}"/>
<g:hiddenField name="clorid" value="${clorid}"/>

<div class="dialog">
    <table border="0" cellspacing="0" cellpadding="0">
	<tbody bgcolor="lavender">
	    <tr class="prop">
		<td valign="top" width="18%">
		    <label for="icsid">Distributor's IcsId:</label>
		</td>
		<td valign="top" class="value ${hasErrors(bean: bookOrder, field: 'distributorName', 'errors')}">
		    <g:textField id="icsid" name="icsid" value="${bookOrder?.placedBy?.icsid}" size="8" />
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top">
		    <label for="distributorName">Distributor Name</label>
		</td>
		<td valign="top" class="value ${hasErrors(bean: bookOrder, field: 'distributorName', 'errors')}">
		    <g:textField name="distributorName" value="${bookOrder?.placedBy}"/>
		    Modify Contact?<g:checkBox name="modifyContact" value="${false}" onClick="toggleModify()"/>
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top">
		    Contact Number
		</td>
		<td valign="top" class="value">
			<g:textField name="distributorContact" value="${bookOrder?.distributorContact}" size="30"/>
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top">
		    Email
		</td>
		<td valign="top" class="value">
			<g:textField name="distributorEmail" value="${bookOrder?.distributorEmail}" size="75"/>
		</td>
	    </tr>
	</tbody>
    </table>
</div>

<div class="dialog" id="clorDiv">
    <table border="0" cellspacing="0" cellpadding="0">
	<tbody bgcolor="lavender">
	    <tr >
		<td valign="top">
		    <label for="clor">Counsellor</label>
		</td>
		<td valign="top" align="left" class="value">
		   <div style="width: 300px">
			<gui:autoComplete
				id="acClor"
				width="300px"
				controller="individual"
				action="allCouncellorsAsJSON"
				useShadow="true"
				queryDelay="0.5" minQueryLength='1'

			/>
			</div>
		   </td>
	    </tr>

	</tbody>
	</table>
</div>

<div class="dialog">
    <table border="0" cellspacing="0" cellpadding="0">
	<tbody bgcolor="lavender">

	    <tr class="prop">
		<td valign="top">
		    <label for="comments">Comments</label>
		</td>
		<td valign="top" class="value ${hasErrors(bean: bookOrder, field: 'comments', 'errors')}">
		    <g:textArea name="comments" value="${bookOrder?.comments}" maxlength="100" style="width: 550px; height: 50px;"/>
		</td>
	    </tr>

	</tbody>
    </table>
</div>

</g:form>


<script type="text/javascript">

function validate() {  
	return true;
}

$(document).ready(function()
{
$('#icsid').focusout(getDetails);

$( "#distributorName" ).autocomplete({
	source: "${createLink(controller:'individual',action:'allIndividualsAsJSON_JQ')}",
	minLength: 3,
	  select: function(event, ui) { // event handler when user selects a company from the list.
	   $("#icsid").val(100000+ui.item.id); // update the hidden field.
	   getDetails();
	  }
});
        

});  

function getDetails(){
		var icsid = $('#icsid').val();
		if(icsid=='')
			return;
		//clear open jgrowls
		$("div.jGrowl").jGrowl("close");
		//$('.jGrowl-notification').trigger('jGrowl.close');

		//alert(icsid);
		var url = "${createLink(controller:'individual',action:'info')}"+"?icsid="+icsid;
		//alert(url);
		$.getJSON(url, {}, function(data) {
			$('#distributorName').val(data.name);
			$('#distributorContact').val(data.contact);
			$('#distributorEmail').val(data.email);
			$('#contactid').val(data.contactid);
			$('#emailid').val(data.emailid);
			$('#distributorid').val(data.id);
			$('#acClor').val(data.counsellorName);
			$('#acClor_id').val(data.counsellorid);

			//now make these fields readonly (if id was valid)
			if(data.valid=="yes")
				{
				//$('#distributorName').attr("readonly", true);
				$('#distributorContact').attr("readonly", true);
				$('#distributorEmail').attr("readonly", true);
				$('#acClor').attr("readonly", true);

				//fire request for challan summary
				var csurl = "${g.createLink(controller:'challan',action:'summary')}"+ "?id="+$('#distributorid').val();
				$.getJSON(csurl, function(data) {
					var hdr = 'Challan Summary for '+data.name;
					var summary = data.summary;
					$.jGrowl(summary ,{ header: hdr ,sticky: true});
				    });
				}
			else
				{
				$('#icsid').val("")
				$('#distributorName').attr("readonly", false)
				$('#distributorContact').attr("readonly", false)
				$('#distributorEmail').attr("readonly", false)
				$('#acClor').attr("readonly", false)
				$('#distributorName').val("")
				$('#distributorContact').val("")
				$('#distributorEmail').val("")
				$('#acClor').val("")
				}
		    });	

	}

function toggleModify() {
	if($("#modifyContact").is(':checked'))
		{
			$('#distributorContact').attr("readonly", false)
			$('#distributorEmail').attr("readonly", false)
			$('#acClor').attr("readonly", false)
		}
	else
		{
			$('#distributorContact').attr("readonly", true)
			$('#distributorEmail').attr("readonly", true)
			$('#acClor').attr("readonly", true)
		}
}

</script>

