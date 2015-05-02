<div>
<div id="Family">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
			<tr>
					<td valign="top">

					<ul>
					<g:set var="relatives" value="${individualInstance?.relative2?.sort{it.relation?.name}}"/>
					<g:each in="${relatives}" var="r">
						.
						<g:if test="${r?.relationshipGroup?.groupName.startsWith('Family')}">
							<li><g:link controller="individual" action="show" id="${r.individual1.id}">${"("+r.relation.name+")"+r.individual1.toString()}</g:link></li>
						</g:if>
					</g:each>
					</ul>
					
				</td>
			</tr>
			</tbody>
		</table>
	</div>
</div>	