<div>
<div id="FundsReceived">
            <sec:ifAnyGranted roles="ROLE_DUMMY,ROLE_BACKOFFICE,ROLE_NVCC_ADMIN,ROLE_PATRONCARE,ROLE_COUNSELLOR">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
				<tr>
					<td valign="top" class="name"><b><g:message code="individual.fundsReceived.label" default="Funds Received" /></b></td>

					<td valign="top" style="text-align: left;" class="value">
						<ul>
						<g:each in="${individualInstance.fundsReceived}" var="f">
							<li><g:link controller="donation" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
						</g:each>
						</ul>
					</td>

				</tr>
			</tbody>
		</table>
	</sec:ifAnyGranted>
	</div>
<div>