<div>
<div id="KCRoles">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
                        <tr>
                            <td valign="top" class="name"><b><g:message code="individual.individualRoles.label" default="Individual Roles"  width="14%"/></b></td>
                            
                            <td valign="top" style="text-align: left;" class="value" colspan="5">
                                <ul>
				<g:set var="isCollector" value="false" />
                                <g:each in="${individualInstance.individualRoles}" var="i">
					<g:if test="${i?.role?.name == 'Collector'}">
						<g:set var="isCollector" value="true" />
					</g:if>
                                    <g:if test="${i?.status == 'VALID'}">
                                    	<li><g:link controller="individualRole" action="show" id="${i.id}">${i.role}</g:link></li>
                                    </g:if>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
			</tbody>
		</table>

	</div>
	
</div>