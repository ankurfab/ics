<!--
Pls copy below snippet in the main gsp page
Incase more than one SMS buttons are required, pls preserve the id naming pattern..maybe something like btnSMS1,btnSMS2 or equivalent..
Also modify the gridName and entityName accordingly
<input class="menuButton" type="BUTTON" id="btnSMS" value="SMS" gridName="#eventRegistration_list" entityName="EventRegistration"/>
-->

<div id="dialogSmsForm" title="SMS" gridName="" entityName="">
	<form>
	<fieldset>
		<table>
			<tr>
				<td><label for="smstext">Text</label></td>
				<td><textarea rows="3" cols="40" maxlength="160" name="description" id="smstext" class="text ui-widget-content ui-corner-all"></textarea></td>
			</tr>
			<tr>
				<td>CC</td>
				<td><g:textField name="ccNos" id="ccNos" value="${session.individualphone}" /></td>
			</tr>
		</table>
	</fieldset>
	</form>
</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
		$("[id^='btnSMS']")
			.button()
			.click(function() {
				var idlist = jQuery($(this).attr('gridName')).jqGrid('getGridParam','selarrrow');
				if(idlist=='')	//try for multipleselect=false case
					idlist = jQuery($(this).attr('gridName')).jqGrid('getGridParam','selrow');
				if(idlist!='')
					{
					$( "#dialogSmsForm" ).attr('gridName',$(this).attr('gridName'));
					$( "#dialogSmsForm" ).attr('entityName',$(this).attr('entityName'));
					$( "#dialogSmsForm" ).dialog( "open" );
					}
				else
					alert("Select at least 1 record to SMS!!");
			});

		$( "#dialogSmsForm" ).dialog({
			autoOpen: false,
			height: 350,
			width: 350,
			modal: true,
			buttons: {
				"CheckBalance": function() {
					var url = "${createLink(controller:'helper',action:'eventCheckSMSBalance')}"
					$.getJSON(url, {}, function(data) {
						alert("SMS Balance: "+data.balance);
					    });	
				},
				"Send": function() {
					var smstext = $('#smstext').val();
					var ccNos = $('#ccNos').val();
					var idlist = jQuery($(this).attr('gridName')).jqGrid('getGridParam','selarrrow')
					
					var url = "${createLink(controller:'helper',action:'eventSendSMS')}"+"?entityName="+$(this).attr('entityName')
					$.getJSON(url, {'ids':""+idlist,'smstext':smstext,'ccNos':""+ccNos}, function(data) {
						alert("Sent SMS: "+data.count);
					    });	

					$('#smstext').val('');
					$( this ).attr('gridName','');
					$( this ).attr('entityName','');
					$( this ).dialog( "close" );
				},
				Cancel: function() {
					$('#smstext').val('');
					$( this ).attr('gridName','');
					$( this ).attr('entityName','');
					$( this ).dialog( "close" );
				}
			},
			close: function() {
					$('#smstext').val('');
					$( this ).attr('gridName','');
					$( this ).attr('entityName','');
			}
		});
    });
</script>
