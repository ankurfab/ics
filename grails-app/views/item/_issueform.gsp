<g:form name="formItemIssue" controller="Item" action="vsUserSubmitItemIssue" method="post" >

<g:hiddenField name="idlist" value="" />
<div class="dialog">
    <table>
	<tbody>

	<g:each in="${items}">
	    <tr class="prop">
		<td valign="top" class="value">
		    ${it.toString()}
		</td>
		<td valign="top" class="value">
		    <g:textField name="qtyitem${it.id}" value="1" />
		</td>
		<td valign="top" class="value">
		    <g:select name="unititem${it.id}" from="${ics.Unit.values()}" />
		</td>
	    </tr>
	</g:each>

	</tbody>
    </table>
</div>
</g:form>

