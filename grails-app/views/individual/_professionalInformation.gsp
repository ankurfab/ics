<div>
<div id="ProfessionalInformation">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
			<tr>
				<td valign="top" class="name" width="14%"><b><g:message code="individual.profession.label" default="Profession"/></b></td>

				<td valign="top" class="value" width="18%">${fieldValue(bean: individualInstance, field: "profession")}</td>

				<td valign="top" class="name"><b><g:message code="individual.designation.label" default="Designation" /></b></td>

				<td valign="top" class="value">${fieldValue(bean: individualInstance, field: "designation")}</td>

				<td valign="top" class="name"><b><g:message code="individual.companyName.label" default="Company Name" /></b></td>

				<td valign="top" class="value">${fieldValue(bean: individualInstance, field: "companyName")}</td>

				<td valign="top" class="name"><b>Education</b></td>

				<td valign="top" class="value">${individualInstance?.education}</td>

			</tr>
			<tr>
				<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN,ROLE_DUMMY">
					<td valign="top" class="name"><b><g:message code="individual.businessRemarks.label" default="Business Remarks" /></b></td>

					<td colspan="7" valign="top" class="value">${fieldValue(bean: individualInstance, field: "businessRemarks")}</td>
				</sec:ifAnyGranted>
			</tr>
			</tbody>
		</table>
	 </div>	
</div>	