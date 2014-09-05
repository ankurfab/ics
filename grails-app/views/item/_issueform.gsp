<g:form name="formItemIssue" controller="Item" action="vsUserSubmitItemIssue" method="post" >

<div class="dialog">
    <table>
	<tbody>

	<g:each in="${items}">
	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="item${it.id}">Item</label>
		</td>
		<td valign="top" class="value">
		    ${it.toString()}
		</td>
		<td valign="top" class="name">
		    <label for="qtyitem${it.id}">Item Quantity</label>
		</td>
		<td valign="top" class="value">
		    <g:textField name="qtyitem${it.id}" value="1" />
		</td>
	    </tr>
	</g:each>

	</tbody>
    </table>
</div>
</g:form>

