<!--
Pls copy below snippet in the main gsp page
Incase more than one EMAIL buttons are required, pls preserve the id naming pattern..maybe something like btnEMAIL1,btnEMAIL2 or equivalent..
Also modify the gridName and entityName accordingly
<input class="menuButton" type="BUTTON" id="btnEMAIL" value="EMAIL" gridName="#eventRegistration_list" entityName="EventRegistration"/>
-->

<div id="dialogEmailForm" title="EMAIL" gridName="" entityName="">
	<form>
	<fieldset>
		<table>
		<tr>
		<td><label for="emailfrom">From</label></td>
		<td><input type="text" name="emailfrom" id="emailfrom" value="${session.individualemail}" maxlength="100" size="50" class="text ui-widget-content ui-corner-all"></td>
		<tr>
		<td><label for="emailsub">Subject</label></td>
		<td><input type="text" name="emailsub" id="emailsub" maxlength="255" size="100" class="text ui-widget-content ui-corner-all"></td>
		</tr>
		<tr>
		<td><label for="emailbody">Body</label></td>
		<td><textarea rows="3" cols="80" name="emailbody" id="emailbody" maxlength="4096" class="text ui-widget-content ui-corner-all"></textarea></td>
		</tr>
		<tr>
		<td>CC Sender<g:checkBox name="ccSender" id="ccSender" checked="true"/></td>
		<td>BCC Recipients<g:checkBox name="bccRecipients" id="bccRecipients" checked="true"/></td>
		</tr>
		</table>
	</fieldset>
	</form>
</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
		$( "[id^='btnEMAIL']" )
			.button()
			.click(function() {
				var idlist = jQuery($(this).attr('gridName')).jqGrid('getGridParam','selarrrow');
				if(idlist=='')	//try for multipleselect=false case
					idlist = jQuery($(this).attr('gridName')).jqGrid('getGridParam','selrow');
				
				if(idlist!='')
					{
					$( "#dialogEmailForm" ).attr('gridName',$(this).attr('gridName'));
					$( "#dialogEmailForm" ).attr('entityName',$(this).attr('entityName'));
					$( "#dialogEmailForm" ).dialog( "open" );
					}
				else
					alert("Select at least 1 record to EMAIL!!");
			});

		$( "#dialogEmailForm" ).dialog({
			autoOpen: false,
			//height: 300,
			width: 700,
			modal: true,
			buttons: {
				"Send": function() {
					var emailfrom = $('#emailfrom').val();
					var emailsub = $('#emailsub').val();
					var emailbody = $('#emailbody').val();
					var ccSender = $('#ccSender').attr('checked')?'true':'false';
					var bccRecipients = $('#bccRecipients').attr('checked')?'true':'false';
					var idlist = jQuery($(this).attr('gridName')).jqGrid('getGridParam','selarrrow')
					
					var url = "${createLink(controller:'helper',action:'eventSendEMAIL')}"+"?entityName="+$(this).attr('entityName')
					$.getJSON(url, {'ids':""+idlist,'emailfrom':emailfrom,'emailsub':emailsub,'emailbody':emailbody,'ccSender':ccSender,'bccRecipients':bccRecipients}, function(data) {
						alert("Sent EMAIL: "+data.count);
					    });	

					$('#emailsub').val('');
					$('#emailbody').val('');
					$( this ).attr('gridName','');
					$( this ).attr('entityName','');
					$( this ).dialog( "close" );
				},
				Cancel: function() {
					$('#emailsub').val('');
					$('#emailbody').val('');
					$( this ).dialog( "close" );
				}
			},
			close: function() {
					$('#emailsub').val('');
					$('#emailbody').val('');
			}
		});
    });
</script>
