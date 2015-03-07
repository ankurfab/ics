<div>
<div id="SpiritualInformation">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
				<tr>
					<td valign="top">
						<label for="introductionDate"><b>Introduction Date</b></label>
					</td>
					<td valign="top">
						${individualInstance?.introductionDate?.format('dd-MM-yyyy')}                                    
					</td>
					<td valign="top">
						<label for="sixteenRoundsDate"><b>Chanting 16 rounds since</b></label>
					</td>
					<td valign="top">
						${individualInstance?.sixteenRoundsDate?.format('dd-MM-yyyy')}                                    
					</td>
					<td valign="top">
						<label for="voiceDate"><b>Voice Training Date</b></label>
					</td>
					<td valign="top">
						${individualInstance?.voiceDate?.format('dd-MM-yyyy')}                                    
					</td>
					<td valign="top">
						<label for="joinAshram"><b>Ashram joining Date</b></label>
					</td>
					<td valign="top">
						${individualInstance?.joinAshram?.format('dd-MM-yyyy')}                                    
					</td>

				</tr>
				<tr>
					<td valign="top">
						<label for="ashram"><b>Ashram</b></label>
					</td>
					<td valign="top">
						${individualInstance?.ashram}                                 
					</td>
					<td valign="top">
						<label for="firstInitiationStatus"><b>First Initiation Status</b></label>
					</td>
					<td valign="top">
						${individualInstance?.firstInitiationStatus}                           
					</td>
					<td valign="top">
						<label for="currentCentre"><b>Current Centre</b></label>
					</td>
					<td valign="top">
						${ics.IndividualCentre.findByIndividualAndStatus(individualInstance,'VALID')?.centre}
					</td>						
					<td valign="top">
						<label for="numRounds"><b>Number of rounds Chanting currently</b></label>
					</td>
					<td valign="top">
						${individualInstance?.numRounds}
					</td>
				</tr>
				<tr>
					<td valign="top">
						<label for="initiatedName"><b><g:message code="individual.initiatedName.label" default="Initiated Name" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'initiatedName', 'errors')}">
						${individualInstance?.initiatedName}
					</td>
					<td valign="top" ><b>
						Guru</b>
					</td>
					<td valign="top" >
						<g:set var="rel" value="${ics.Relation.findByName('Disciple of')}" />
						<g:set var="gururel" value="${ics.Relationship.findByIndividual1AndRelation(individualInstance,rel)}" />
						<sec:ifAnyGranted roles="ROLE_VOICE_ADMIN">
							<g:link controller="individual" action="show" id="${gururel?.individual2?.id}">${gururel?.individual2?.initiatedName}</g:link>
						</sec:ifAnyGranted>
						<sec:ifNotGranted roles="ROLE_VOICE_ADMIN">
							${gururel?.individual2?.initiatedName}
						</sec:ifNotGranted>
					</td>

						<g:set var="crel" value="${ics.Relation.findByName('Councellee of')}" />
						<g:set var="counsellor" value="${ics.Relationship.findWhere(individual1 : individualInstance, relation:crel, status:'ACTIVE')?.individual2}" />

						<g:set var="mrel" value="${ics.Relation.findByName('Mentee of')}" />
						<g:set var="mentor" value="${ics.Relationship.findByIndividual1AndRelation(individualInstance,mrel)?.individual2}" />

						<g:set var="curel" value="${ics.Relation.findByName('Cultivated by')}" />
						<g:set var="cultivator" value="${ics.Relationship.findByIndividual1AndRelation(individualInstance,curel)?.individual2}" />


					<td valign="top" >
						<b>
						<g:if test="${counsellor}">
						Counsellor
						</g:if>
						<g:elseif test="${mentor}">
						Mentor
						</g:elseif>
						<g:elseif test="${cultivator}">
						Cultivator
						</g:elseif>
						</b>
					</td>
					<td valign="top" >
						<g:if test="${counsellor}">
						<sec:ifAnyGranted roles="ROLE_VOICE_ADMIN">
							<g:link controller="individual" action="show" id="${counsellor?.id}">${counsellor}</g:link>
						</sec:ifAnyGranted>
						<sec:ifNotGranted roles="ROLE_VOICE_ADMIN">
							${counsellor}
						</sec:ifNotGranted>
						</g:if>
						<g:elseif test="${mentor}">
						<sec:ifAnyGranted roles="ROLE_VOICE_ADMIN">
							<g:link controller="individual" action="show" id="${mentor?.id}">${mentor}</g:link>
						</sec:ifAnyGranted>
						<sec:ifNotGranted roles="ROLE_VOICE_ADMIN">
							${mentor}
						</sec:ifNotGranted>
						</g:elseif>
						<g:elseif test="${cultivator}">
						<sec:ifAnyGranted roles="ROLE_VOICE_ADMIN">
							<g:link controller="individual" action="show" id="${cultivator?.id}">${cultivator}</g:link>
						</sec:ifAnyGranted>
						<sec:ifNotGranted roles="ROLE_VOICE_ADMIN">
							${cultivator}
						</sec:ifNotGranted>
						</g:elseif>

					</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td valign="top" >
						<label for="firstInitiation"><b><g:message code="individual.firstInitiation.label" default="First Initiation" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'firstInitiation', 'errors')}" width="15%">

						${individualInstance?.firstInitiation?.format('dd-MM-yyyy')}                                  
					</td>

					<td valign="top" >
						<label for="firstInitiationPlace"><b><g:message code="individual.firstInitiationPlace.label" default="First Initiation Place" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'firstInitiationPlace', 'errors')}" >
						${individualInstance?.firstInitiationPlace}
					</td>
					<td valign="top" >
						<label for="secondInitiation"><b><g:message code="individual.secondInitiation.label" default="Second Initiation" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'secondInitiation', 'errors')}" >
						${individualInstance?.secondInitiation?.format('dd-MM-yyyy')}                                   
					</td>                            
					<td valign="top" >
						<label for="secondInitiationPlace"><b><g:message code="individual.secondInitiationPlace.label" default="Second Initiation Place" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'secondInitiationPlace', 'errors')}">
						${individualInstance?.secondInitiationPlace}
					</td>
				</tr>

			</tbody>
		</table>

		<g:if test="${individualInstance?.initiatedName?.contains('Swami') || individualInstance?.initiatedName?.contains('H.H.')}">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
				<tr>
				    <td valign="top" class="name" width="14%"><b>Disciple List</b></td>

				    <td valign="top" style="text-align: left;" class="value" colspan="5">
					<ul>
					<g:each in="${ics.Relationship.findAllWhere(relation:ics.Relation.findByName('Disciple of'),individual2:individualInstance,status:'ACTIVE',[sort: "individual1.legalName"])}" var="r">
						    <li><g:link controller="individual" action="show" id="${r.individual1?.id}">${r.individual1}</g:link></li>
					</g:each>
					</ul>
				    </td>

				</tr>
			</tbody>
		</table>                            
		</g:if>
		<g:else>
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
				<tr>
				    <td valign="top" class="name" width="14%"><b>Counsellee List</b></td>

				    <td valign="top" style="text-align: left;" class="value" colspan="5">
					<ul>
					<g:each in="${ics.Relationship.findAllWhere(relation:ics.Relation.findByName('Councellee of'),individual2:individualInstance,status:'ACTIVE',[sort: "individual1.legalName"])}" var="r">
						    <li><g:link controller="individual" action="show" id="${r.individual1?.id}">${r.individual1}</g:link></li>
					</g:each>
					</ul>
				    </td>

				</tr>
			</tbody>
		</table>                            
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
				<tr>
				    <td valign="top" class="name" width="14%"><b>Mentee List</b></td>

				    <td valign="top" style="text-align: left;" class="value" colspan="5">
					<ul>
					<g:each in="${ics.Relationship.findAllWhere(relation:ics.Relation.findByName('Mentee of'),individual2:individualInstance,status:'ACTIVE',[sort: "individual1.legalName"])}" var="r">
						    <li><g:link controller="individual" action="show" id="${r.individual1?.id}">${r.individual1}</g:link></li>
					</g:each>
					</ul>
				    </td>

				</tr>
			</tbody>
		</table>                            
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
				<tr>
				    <td valign="top" class="name" width="14%"><b>Wellwisher List</b></td>

				    <td valign="top" style="text-align: left;" class="value" colspan="5">
					<ul>
					<g:each in="${ics.Relationship.findAllWhere(relation:ics.Relation.findByName('Cultivated by'),individual2:individualInstance,status:'ACTIVE',[sort: "individual1.legalName"])}" var="r">
						    <li><g:link controller="individual" action="show" id="${r.individual1?.id}">${r.individual1}</g:link></li>
					</g:each>
					</ul>
				    </td>

				</tr>
			</tbody>
		</table>                            

		</g:else>


    	 </div>
	</div>