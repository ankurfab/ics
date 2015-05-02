	<script>
	$(function() {
		$( "#ind" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allIndividualsFuzzyAsJSON_JQ')}",//todo take care of data from other departments
			minLength: 3,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $("#linkedid").val(ui.item.id); // update the hidden field.
			  }
		});
	});
	</script>

<div class="dialog">
    <table>
	<tbody>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="linkedIndividual">Linked Individual</label>*
		</td>
		<td valign="top" class="value ${hasErrors(bean: icsUserInstance, field: 'linkedIndividual', 'errors')}">
		    <g:hiddenField name="linkedid" value=""/>
		    <g:hiddenField name="indname" value=""/>
		    <input id="ind" size="40" />
		</td>
	    </tr>

	</tbody>
    </table>
</div>
