<g:form name="formChangeWorkflowStatus" controller="Mb" action="changeWorkflowStatus" method="post" >

<g:hiddenField name="mbprofileid" value="" />

<div class="dialog">
    <table>
	<tbody>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="status">Status</label>
		</td>
		<td valign="top" class="value">
		    <g:select name="status" from="${['UNASSIGNED','AVAILABLE','PROPOSED','BOYGIRLMEET','PARENTSMEET','PROPOSALAGREED','ANNOUNCE','MARRIEDTHRUMB','MARRIEDOSMB','UNAVAILABLE','ONHOLD','WITHDRAWN']}"  noSelection="['':'-Select New Workflow Status-']"/>
		</td>
	    </tr>

	</tbody>
    </table>
</div>
</g:form>