<!--
Pls copy below snippet in the main gsp page
Incase more than one EMAIL buttons are required, pls preserve the id naming pattern..maybe something like btnEMAIL1,btnEMAIL2 or equivalent..
Also modify the gridName and entityName accordingly
<input class="menuButton" type="BUTTON" id="btnEMAIL" value="EMAIL" gridName="#eventRegistration_list" entityName="EventRegistration" departmentId="${ics.Department.findByName('Guest Reception Department')?.id}"/>
-->

<div id="dialogEmailForm" title="EMAIL" gridName="" entityName="" departmentId="">
	<form>
	<fieldset>
		<table>
		<td><label for="emailsub">Subject</label></td>
		<td><input type="text" name="emailsub" id="emailsub" maxlength="255" size="100" class="text ui-widget-content ui-corner-all"></td>
		</tr>
		<tr>
		<td><label for="emailbody">Body</label></td>
		<td><textarea rows="3" cols="80" name="emailbody" id="emailbody" maxlength="4096" class="text ui-widget-content ui-corner-all"></textarea></td>
		</tr>
		<tr>
		<td>HTML Content<g:checkBox name="htmlContent" id="htmlContent" checked="true"/></td>
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
				var answer = true;
				var idlist = jQuery($(this).attr('gridName')).jqGrid('getGridParam','selarrrow');
				if(idlist=="")	//try for multipleselect=false case
					idlist = jQuery($(this).attr('gridName')).jqGrid('getGridParam','selrow');
				if(!idlist) {
					answer = confirm("You havent select any record. Email would be sent to all. Are you sure?");
				}
				
				if(answer)
					{
					$( "#dialogEmailForm" ).attr('gridName',$(this).attr('gridName'));
					$( "#dialogEmailForm" ).attr('entityName',$(this).attr('entityName'));
					$( "#dialogEmailForm" ).attr('departmentId',$(this).attr('departmentId'));
					$( "#dialogEmailForm" ).dialog( "open" );
					}
			});

		$( "#dialogEmailForm" ).dialog({
			autoOpen: false,
			//height: 300,
			width: 700,
			modal: true,
			buttons: {
				"Send": function() {
					var emailsub = $('#emailsub').val();
					var emailbody = $('#emailbody').val();
					var htmlContent = $('#htmlContent').attr('checked')?'true':'false';
					var idlist = jQuery($(this).attr('gridName')).jqGrid('getGridParam','selarrrow')
					if(idlist=="")
						idlist = jQuery($(this).attr('gridName')).jqGrid('getGridParam','selrow')
					
					var url = "${createLink(controller:'helper',action:'commsMandrill')}"+"?entityName="+$(this).attr('entityName')+"&depid="+$(this).attr('departmentId')
					$.getJSON(url, {'ids':""+idlist,'emailsub':emailsub,'emailbody':emailbody,'htmlContent':htmlContent}, function(data) {
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
