<g:form name="formUpdateBudget" controller="CostCenter" action="updateBudget" method="post" >

<g:hiddenField name="ccid_updatebudget" value="" />

<div class="dialog">
    <table>
	<tbody>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="amount">Amount</label>
		</td>
		<td valign="top" class="value">
		    <g:textField name="amount"/>
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="details">Details</label>
		</td>
		<td valign="top" class="value">
		    <g:textArea name="details" maxlength="100"/>
		</td>
	    </tr>

	</tbody>
    </table>
</div>
</g:form>