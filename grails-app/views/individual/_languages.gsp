<div>
<div id="Languages">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
			<tr>
					<td valign="top">

					<ul>
					<g:each in="${individualLanguageList}" var="il">
						<li>${il?.encodeAsHTML()}</li>
					</g:each>
					</ul>
				</td>
			</tr>
			</tbody>
		</table>
	</div>
</div>	