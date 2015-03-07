<div>
<div id="Services">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
				<tr>
					<td valign="top">
						<label for="services"><b>Services Rendered</b></label>
					</td>
					<td valign="top">
						<ul>
						<g:each in="${servicesrendered}" var="s">
							<li>${s.seva}</li>
						</g:each>
						</ul>
					</td>                                

					<td valign="top">
						<label><b>Services Interested In</b></label>
					</td>
					<td valign="top">
						<ul>
						<g:each in="${servicesinterested}" var="sk">
							<li>${sk.seva}</li>
						</g:each>
						</ul>
					</td>                                
				</tr>
			</tbody>
		</table>
	</div>
</div>