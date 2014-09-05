<%@ page import="ics.EventRegistration" %>
<div class="collection_group">

	<div class="dialog">
	
		<table>
			<thead>
				<tr>
					<th>Sr.No.</th>
					<th>Name</th>
					<th>Category</th>
					<th>ContactNumber</th>
			      		<sec:ifNotGranted roles="ROLE_RVTO_COUNSELOR">
					<th>Counselor</th>
					</sec:ifNotGranted>
					<th>Service</th>
				</tr>
			</thead>
			<tbody>
				<g:each var="i" in="${ (1..<11) }">
				  <tr>
					<td>${i}</td>
					<td><g:textField name="${'name'+i}"/></td>
					<td><g:select name="${'category'+i}"
						    noSelection="${['':'Select Category...']}"
						    from="${['Brahmachari/Student','Prji','Mataji','Child']}"></g:select>
					</td>
					<td><g:textField name="${'contact'+i}"/></td>
			      		<sec:ifNotGranted roles="ROLE_RVTO_COUNSELOR">
					<td><g:select name="${'counselorid'+i}"
						    noSelection="${['null':'Select Counselor...']}"
						    from='${ics.Individual.findAllByCategory('RVTOCounselor','[sort:"legaName"]')}'
						    optionKey="id" optionValue="legalName"></g:select>
    					</td>
					</sec:ifNotGranted>
					<td><g:select name="${'sevaid'+i}"
						    noSelection="${['null':'Select Service...']}"
						    from='${ics.Seva.findAllByCategory('RVTO','[sort:"name"]')}'
						    optionKey="id" optionValue="name"></g:select>
					</td>
				  </tr>
				</g:each>
			</tbody>

		</table>
	</div>
</div>
