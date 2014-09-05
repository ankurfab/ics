<g:form name="formSubscription" controller="Topic" action="saveSubscription" method="post" >

<g:hiddenField name="personid" value="" />

<div class="dialog">
    <table>
	<tbody>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="mode">Topic</label>
		</td>
		<td valign="top" class="value">
		    <g:select name="topic.id" from="${ics.Topic.findAllByStatus('ACTIVE',[sort:'name'])}" optionKey="id" value=""   noSelection="['':'-Select Topic(s) to be subscribed-']" multiple="multiple"/>
		</td>
	    </tr>

	</tbody>
    </table>
</div>
</g:form>

