            <div class="dialog">

		<g:set var="attOn" value="${retMap.attOn}" />
		<g:set var="result" value="${retMap.pairs}" />
		<g:set var="counter" value="${retMap.numEvents-1}" />

                <table border='1'>
                    <thead>
			<th>S.No.</th>
			<th>ICS Id</th>
			<th>Name</th>
			<th>Phone</th>
			<th>Email</th>
			<g:each var="i" in="${(counter..0)}"> 
				<th>Attendance On ${attOn?attOn[i]?.eventDate?.format('dd-MM'):''}</th>
			</g:each>
			<th>Today's Attendance</th>
                    </thead>
                    <tbody>
			<g:each in="${result}" var="pair" status="sno"> 
				<g:each in="${pair}" var="ind" status="inssno"> 				
					<tr class="${(sno % 2) == 0 ? 'oddrow' : 'evenrow'}" style="${(sno % 2) == 0 ? 'background:lightblue' : ''}">
						<td>${sno+1}</td>
						<!--<td><g:link target="_new" controller="individual" action="show" id="${ind.icsid}">${ind.icsid} (${ind.loginid})</g:link></td>-->
						<td>${ind.icsid} (${ind.loginid})</td>
						<td>
							<g:if test="${inssno==0}">
							<b>${ind.toString()}</b>
							</g:if>
							<g:else>
							${ind.toString()}
							</g:else>
						</td>
						<td>${ics.VoiceContact.findByIndividualAndCategory(ind,'CellPhone')?.number?:''}</td>
						<td>${ics.EmailContact.findByIndividualAndCategory(ind,'Personal')?.emailAddress?:''}</td>
						<g:each var="j" in="${(counter..0)}"> 
							<td>${(attOn?attOn[j]?.get(ind.icsid):'')?'Y':''}</td>
						</g:each>
						<td/>
					</tr>
				 </g:each>
		       </g:each>                    
                    </tbody>
                </table>
            </div>