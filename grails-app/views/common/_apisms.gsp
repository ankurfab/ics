<!--
Pls copy below snippet in the main gsp page
Incase more than one SMS buttons are required, pls preserve the id naming pattern..maybe something like btnSMS1,btnSMS2 or equivalent..
Also modify the gridName and entityName accordingly
<input class="menuButton" type="BUTTON" id="btnSMS" value="SMS" gridName="#eventRegistration_list" entityName="EventRegistration" departmentId="${ics.Department.findByName('Guest Reception Department')?.id}"/>
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
				var answer = true;
				var idlist = jQuery($(this).attr('gridName')).jqGrid('getGridParam','selarrrow');
				if(idlist=="")	//try for multipleselect=false case
					idlist = jQuery($(this).attr('gridName')).jqGrid('getGridParam','selrow');
				if(!idlist) {
					answer = confirm("You havent select any record. SMS would be sent to all. Are you sure?");
				}
				
				if(answer)
					{
					$( "#dialogSmsForm" ).attr('gridName',$(this).attr('gridName'));
					$( "#dialogSmsForm" ).attr('entityName',$(this).attr('entityName'));
					$( "#dialogSmsForm" ).attr('departmentId',$(this).attr('departmentId'));
					$( "#dialogSmsForm" ).dialog( "open" );
					}
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
					if(idlist=="")
						idlist = jQuery($(this).attr('gridName')).jqGrid('getGridParam','selrow')
					
					var url = "${createLink(controller:'helper',action:'eventSendAPISMS')}"+"?entityName="+$(this).attr('entityName')+"&depid="+$(this).attr('departmentId')
					$.ajaxSetup({ scriptCharset: "utf-8" , contentType: "application/json; charset=utf-8"});
					$.getJSON(url, {'ids':""+idlist,'smstext':smstext,'ccNos':""+ccNos}, function(data) {
						alert("Sent SMS: "+data.count);
					    });
					    
					/*$.ajax({
					    type: "POST",
					    url: url,
					    contentType: "application/json; charset=utf-8",
					    dataType: "json",
					    data: "{id: '" + idlist + "','smstext':"+smstext+",'ccNos':"+ccNos+"}",
					    //data: "{id: '" + someid + "'}",
					    success: function(json) {
						//$("#success").html("json.length=" + json.length);
						//itemAddCallback(json);
						alert("Sent SMS: "+json.count);
					    },
					    error: function (xhr, textStatus, errorThrown) {
						//$("#error").html(xhr.responseText);
						alert("Error in sending SMS: "+xhr.responseText);
					    }
					});*/


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
