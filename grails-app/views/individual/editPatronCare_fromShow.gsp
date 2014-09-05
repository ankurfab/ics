
<%@ page import="ics.Individual" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'individual.label', default: 'Individual')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
		<link rel="stylesheet" href="${resource(dir: 'css/blue', file: 'style.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir:'css',file:'ui.jqgrid.css')}" />        
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'timepicker.css')}" type="text/css">
    </head>
    <body>
	<g:javascript src="jquery-ui-1.8.18.custom.min.js" />    
    	<g:javascript src="jquery-ui-timepicker-addon.js" />
	<g:javascript src="grid.locale-en.js"/>
	<g:javascript src="jquery.jqGrid.min.js"/>
	<script>
		$(function() {
			$( "#tabs" ).tabs();
            <sec:ifAnyGranted roles="ROLE_COUNSELLOR,ROLE_VOICE_ADMIN">
			$("#tabs").tabs("remove", "#Donations" );
			$("#tabs").tabs("remove", "#GiftsReceived" );
			$("#tabs").tabs("remove", "#FundsCollected" );
			$("#tabs").tabs("remove", "#FundsReceived" );
			$("#tabs").tabs("remove", "#NVCCFields" );
			$("#tabs").tabs("remove", "#RecordInfo" );
			$("#tabs").tabs( "select" , "#SpiritualInformation" );
            </sec:ifAnyGranted>
            <sec:ifNotGranted roles="ROLE_COUNSELLOR,ROLE_VOICE_ADMIN">
			$("#tabs").tabs("remove", "#Services" );
			$("#tabs").tabs( "remove" , "#KCTraining" );
            </sec:ifNotGranted>
		});
		$(document).ready(function()
		{
		  $("#dob").datepicker({yearRange: "-100:+0",changeMonth: true,changeYear: true,
				dateFormat: 'dd-mm-yy'});
		  $("#marriageAnniversary").datepicker({yearRange: "-100:+0",changeMonth: true,
				changeYear: true,
				dateFormat: 'dd-mm-yy'});

	    var tabindex = 1;
	    $('input,select,textarea').each(function() {
		if (this.type != "hidden") {
		    var $input = $(this);
		    $input.attr("tabindex", tabindex);
		    tabindex++;
		}
	var $dialog = $('<div></div>')
		.html('This dialog will show every time!')
		.dialog({
			autoOpen: false,
			title: 'Basic Dialog'
		});

	$('#opener').click(function() {
		$dialog.dialog('open');
		// prevent the default action, e.g., following a link
		return false;
	});
        
    });          

			
       $('addAddress').click( function(){$("#dialog").load("D:\NVCC\ics\grails-app\views\address\create.gsp", function() {
                var container = $(this);
                container.dialog({
                    modal: true
                })
                .find("form").submit(function() {
                    container.dialog("close");
                    return false;
                });
            });

        })
        ;
			

        })		
	</script>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <sec:ifNotGranted roles="ROLE_COUNSELLOR,ROLE_VOICE_ADMIN">
		    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
		    <sec:ifNotGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">	
		    	<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
		    	<span class="menuButton"><g:link class="create" controller="donation" action="dummydonation" params="['donatedBy.id': individualInstance?.id]">Donation </g:link></span>
		    	<span class="menuButton"><g:link class="create" controller="flags" action="create" params="[indid: individualInstance?.id]">Flags</g:link></span>
		    </sec:ifNotGranted>
            </sec:ifNotGranted>
            <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
            	<span class="menuButton"><g:link class="create" controller="schemeMember" action="createfromindividual" params="['individualid': individualInstance?.id]">AssociateScheme</g:link></span>
            </sec:ifAnyGranted>
            <sec:ifNotGranted roles="ROLE_COUNSELLOR,ROLE_VOICE_ADMIN">
	            <span class="menuButton"><g:link class="list" controller="helper" action="searchIndividual">SearchIndividual</g:link></span>
            </sec:ifNotGranted>
            <sec:ifAnyGranted roles="ROLE_COUNSELLOR,ROLE_VOICE_ADMIN">
		    <g:if test="${session.individualid!=individualInstance?.id}">
		    	<span class="menuButton"><g:link class="create" controller="relationship" action="edit" params="[ind1id: individualInstance?.id,ind2id: session.individualid]">Edit Relationship</g:link></span>
		    </g:if>
            </sec:ifAnyGranted>
            <!--<sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
            	<span class="menuButton"><g:link class="create" controller="followup" action="create" params="['individualid': individualInstance?.id]">Followup</g:link></span>
            	<g:if test="${cultivatorLink == 'Cultivated by me'}">
            		<span class="menuButton"><g:link controller="individual" action="updateCultivator" params="['individual1Id': individualInstance?.id, 'individual2Id': session.individualid,'relationId' : '3']">${cultivatorLink}</g:link></span>
            	</g:if>
            	<g:if test="${cultivatorLink == 'Remove Cultivator'}">
            		<span class="menuButton"><g:link controller="relationship" action="delete" params="['id': cultivatorRel?.id]">${cultivatorLink}</g:link></span>
            	</g:if>
            	<g:hiddenField name="cultivatorLink" value="${cultivatorLink}" />
            </sec:ifAnyGranted>-->
        </div>
	
	<div class="colmask rightmenu">
	<div class="colleft">
        <div class="col1">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
		<div class="buttons">
		    <g:form>
			<g:hiddenField name="id" value="${individualInstance?.id}" />
			<sec:ifNotGranted roles="ROLE_COUNSELLOR,ROLE_VOICE_ADMIN,ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
				<span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
				<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
				<span class="button"><g:actionSubmit class="edit" action="linkdonation" value="Link Donation" /></span>
			</sec:ifNotGranted>

		    </g:form>
		</div>
                            
            <div>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tbody bgcolor="lavender">
                        <tr>
                            <td valign="top" class="name"><b><g:message code="individual.id.label" default="Id" /></b></td>
                            <td valign="top" class="value"><g:formatNumber number="${individualInstance?.id}" format="#" /></td>

                            <td valign="top" class="name"><b><g:message code="individual.title.label" default="Title" /></b></td>
                            <td valign="top" class="value">${individualInstance?.title?.encodeAsHTML()}</td>

                            <td valign="top" class="name"><b>Name</b></td>
                            <td valign="top" class="value">${individualInstance?.initiatedName?(individualInstance?.initiatedName+" ( "+ individualInstance?.legalName +" )"):individualInstance?.legalName}</td>

                            <td valign="top" class="name"><b>Category</b></td>
                            <td valign="top" class="value">${individualInstance?.category}</td>

                            <td rowspan="4">
				<g:if test="${individualInstance.avatar}">
				  <img class="avatar" src="${createLink(controller:'individual', action:'avatar_image', id:individualInstance?.id)}" />
				</g:if>                                                    	
                            </td>
                        </tr>
                        <tr>
				<td class="name"><b>PAN</b></td>
				<td class="value">${individualInstance?.panNo} </td>
				<td class="name"><b>BloodGroup</b></td>
				<td class="value">${individualInstance?.bloodGroup} </td>

                            <td valign="top" class="name"><b><g:message code="individual.dob.label" default="Dob" /></b></td>
                            <td valign="top" class="value"><g:textField name="dob" value="${individualInstance?.dob?.format('dd-MM-yyyy')}"/></td>
                            
                            <g:if test="${individualInstance?.marriageAnniversary}">
				    <td valign="top" class="name"><b><g:message code="individual.marriageAnniversary.label" default="Marriage Anniversary" /></b></td>
				    <td valign="top" class="value"><g:textField name="marriageAnniversary" value="${individualInstance?.marriageAnniversary?.format('dd-MM-yyyy')}"/></td>
                            </g:if>
                            <g:else>
				<td/>
				<td/>
                            </g:else>
				
                        </tr>

                    </tbody>
                </table>
	    </div>


            <div>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tbody bgcolor="lavender">
                        <tr>
                            <td valign="top" class="name"><b><g:message code="individual.address.label" default="Address" /></b></td>
                            <td valign="top" style="text-align: left;" class="value">
				<ul>
				<g:each in="${individualInstance?.address?}" var="a">
				    <li><g:link controller="address" action="edit" id="${a.id}" target="_blank">${a?.encodeAsHTML()}</g:link></li>
				</g:each>
				</ul>
				<g:link controller="address" action="create" params="['individual.id': individualInstance?.id]" id="addAddress" target="_blank">${message(code: 'default.add.label', args: [message(code: 'address.label', default: 'Address')])}</g:link>
                            </td>

                            <td valign="top" class="name"><b>Contact</b></td>
                            <td valign="top" style="text-align: left;" class="value">
				<ul>
				<g:each in="${individualInstance?.voiceContact?}" var="v">
				    <li><g:link controller="voiceContact" action="edit" id="${v.id}" target="_blank">${v?.encodeAsHTML()}</g:link></li>
				</g:each>
				</ul>
				<g:link controller="voiceContact" action="create" params="['individual.id': individualInstance?.id]" target="_blank">${message(code: 'default.add.label', args: [message(code: 'voiceContact.label', default: 'VoiceContact')])}</g:link>
                            </td>
                            
                            <td valign="top" class="name"><b>Email</b></td>
                            <td valign="top" style="text-align: left;" class="value">
				<ul>
				<g:each in="${individualInstance?.emailContact?}" var="e">
				    <li><g:link controller="emailContact" action="edit" id="${e.id}" target="_blank">${e?.encodeAsHTML()}</g:link></li>
				</g:each>
				</ul>
				<g:link controller="emailContact" action="create" params="['individual.id': individualInstance?.id]" target="_blank">${message(code: 'default.add.label', args: [message(code: 'emailContact.label', default: 'EmailContact')])}</g:link>
                            </td>
                        </tr>
                    </tbody>
                </table>
	    </div>

            <div>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tbody bgcolor="lavender">
                        <tr>
                            <td valign="top" class="name"><b>Remarks</b></td>
                            <td valign="top" style="text-align: left;" class="value">
                                ${individualInstance.remarks}
                            </td>
                        </tr>
                    </tbody>
                </table>
	    </div>


	<div id="tabs">
	<ul>
		<li><a href="#Family">Family</a></li>
		<li><a href="#ProfessionalInformation">ProfessionalInformation</a></li>
		<li><a href="#Languages">Languages</a></li>
		<li><a href="#CommunicationPreferences">CommunicationPreferences</a></li>
		<li><a href="#SpiritualInformation">SpiritualInformation</a></li>
		<li><a href="#LifeMember">LifeMember</a></li>
		<li><a href="#Donations">Donations</a></li>
		<li><a href="#GiftsReceived">GiftsReceived</a></li>
		<li><a href="#FundsCollected">FundsCollected</a></li>
		<li><a href="#FundsReceived">FundsReceived</a></li>
		<li><a href="#NVCCFields">NVCCFields</a></li>
		<li><a href="#RecordInfo">RecordInfo</a></li>
		<li><a href="#KCTraining">KC Training</a></li>
		<li><a href="#KCRoles">Roles</a></li>
		<li><a href="#Services">Services</a></li>
		<li><a href="#Commitment">Commitment</a></li>
		<li><a href="${g.createLink(controller:'followup',action:'list',params:['cmd':'fwith','findwithid':individualInstance.id])}">Followups</a></li>
	</ul>
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
							<li><g:link controller="individual" action="show" id="${r.individual1.id}">${r?.encodeAsHTML()}</g:link></li>
						</g:if>
					</g:each>
					</ul>
					
				</td>
			</tr>
			</tbody>
		</table>
	</div>

	<div id="LifeMember">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
			<tr>
				<td valign="top"><b>LifeMembership No</b></td>
				<td>${individualInstance?.membershipNo}</td>
			</tr>
			<tr>
				<td valign="top"><b>LifeMembership Place</b></td>
				<td>${individualInstance?.membershipPlace}</td>
			</tr>

			</tbody>
		</table>
	</div>

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
	<div id="CommunicationPreferences">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
				<tr>
					<td valign="top" width="10%">
						<label for="communicationsPreference"><b><g:message code="individual.communicationsPreference.label" default="Communications Preference" /></b></label>
					</td>
					<td valign="top" class="value">${individualInstance?.communicationsPreference}</td>

					<td valign="top" width="7%">
						<label for="languagePreference"><b><g:message code="individual.languagePreference.label" default="Language Preference" /></b></label>
					</td>
					<td valign="top" class="value">${individualInstance?.languagePreference}</td>

					<td valign="top" width="12%">
						<label for="literatureLanguagePreference"><b><g:message code="individual.literatureLanguagePreference.label" default="Literature Language Preference" /></b></label>
					</td>
					<td valign="top" class="value">${individualInstance?.literatureLanguagePreference}</td>
				</tr>

			</tbody>
		</table>
	 </div>

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
						${centre}
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
	
	<div id="Donations">
            <sec:ifAnyGranted roles="ROLE_DUMMY,ROLE_BACKOFFICE,ROLE_NVCC_ADMIN,ROLE_PATRONCARE">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
			<tr>
				<td valign="top" class="name" colspan="2">
					<b><g:message code="individual.donations.label" default="Donations" /></b><br>
					<table>
					<thead>
						<th>
							Donation
						</th>
						<th>
							Collector
						</th>            
						<th>
							Scheme
						</th>                                 	
                                	
						<th>
							Remarks
						</th>                                 	
						</thead> 	
						<tr>
							<td colspan="9">
							</td>
						</tr>

						<g:each in="${individualInstance.donations}" status="i" var="d">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

								<td>
									<g:link controller="donation" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link>
								</td>
								<td>
									<g:link controller="individual" action="show" id="${d.collectedById}">${d?.collectedBy}</g:link>
								</td>    
								<td>
									${d?.scheme}
								</td>                                  			
								<td>
									${d?.comments}
								</td>                                  			

							</tr>    
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							<td colspan="9">&nbsp;
							</td>
							</tr>
						</g:each>



					</table>
				</td>

			</tr>
			</tbody>
		</table>                            
  	 </sec:ifAnyGranted>
  	</div>
  	
	<div id="GiftsReceived">
            <sec:ifAnyGranted roles="ROLE_DUMMY,ROLE_BACKOFFICE,ROLE_NVCC_ADMIN,ROLE_PATRONCARE">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
			<tr>
				<td valign="top" class="name"><b>Gifts Received</b></td>

				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${individualInstance.giftIssuedTo}" var="g">
						<li><g:link controller="giftIssued" action="show" id="${g.id}">${g.toString()?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
				</td>

			</tr>
			</tbody>
		</table>
	</sec:ifAnyGranted>
	</div>

	<div id="FundsCollected">
            <sec:ifAnyGranted roles="ROLE_DUMMY,ROLE_BACKOFFICE,ROLE_NVCC_ADMIN,ROLE_PATRONCARE">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
				<tr>
					<td valign="top" class="name"><b><g:message code="individual.fundCollections.label" default="Fund Collections" /></b></td>

					<td valign="top" style="text-align: left;" class="value">
						<ul>
						<g:each in="${individualInstance.fundCollections}" var="f">
						<g:if test="${f.collectedById != f.donatedById}">
							<li><g:link controller="donation" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
						</g:if>
						</g:each>
						</ul>
					</td>

				</tr>
			</tbody>
		</table>
	</sec:ifAnyGranted>
	</div>
	
	<div id="FundsReceived">
            <sec:ifAnyGranted roles="ROLE_DUMMY,ROLE_BACKOFFICE,ROLE_NVCC_ADMIN,ROLE_PATRONCARE">
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

	<div id="NVCCFields">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
			<tr>
				<td valign="top" class="name" width="15%"><b><g:message code="individual.nvccId.label" default="Nvcc Id" /></b></td>

				<td valign="top" class="value">${fieldValue(bean: individualInstance, field: "nvccId")}</td>

				<td valign="top" class="name" width="15%"><b><g:message code="individual.nvccDonarCode.label" default="Nvcc Donar Code" /></b></td>

				<td valign="top" class="value" width="10%">${fieldValue(bean: individualInstance, field: "nvccDonarCode")}</td>

				<td valign="top" class="name" width="12%"><b><g:message code="individual.nvccName.label" default="Nvcc Name" /></b></td>

				<td valign="top" class="value">${fieldValue(bean: individualInstance, field: "nvccName")}</td>
				<td>&nbsp;
				</td>
				<td>&nbsp;
				</td>

			</tr>

			<tr>
				<td valign="top" class="name" width="14%"><b><g:message code="individual.nvccIskconRef.label" default="Nvcc Iskcon Ref" /></b></td>

				<td valign="top" class="value">${fieldValue(bean: individualInstance, field: "nvccIskconRef")}</td>

				<td valign="top" class="name" width="15%"><b><g:message code="individual.nvccFamilyId.label" default="Nvcc Family Id" /></b></td>

				<td valign="top" class="value" width="10%">${fieldValue(bean: individualInstance, field: "nvccFamilyId")}</td>

				<td valign="top" class="name" width="12%"><b><g:message code="individual.nvccRelation.label" default="Nvcc Relation" /></b></td>

				<td valign="top" class="value">${fieldValue(bean: individualInstance, field: "nvccRelation")}</td>
				<td>&nbsp;
				</td>
				<td>&nbsp;
				</td>

			</tr>
			</tbody>
		</table>
	</div>

	<div id="RecordInfo">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">

				<tr>
					<td valign="top" class="name"><b><g:message code="individual.dateCreated.label" default="Date Created" /></b></td>

					<td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${individualInstance?.dateCreated}" /></td>

					<td valign="top" class="name"><b><g:message code="individual.creator.label" default="Creator" /></b></td>

					<td valign="top" class="value">${fieldValue(bean: individualInstance, field: "creator")}</td>

					<td valign="top" class="name" width="14%"><b><g:message code="individual.lastUpdated.label" default="Last Updated" /></b></td>

					<td valign="top" class="value" width="18%"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${individualInstance?.lastUpdated}" /></td>

					<td valign="top" class="name"><b><g:message code="individual.updator.label" default="Updator" /></b></td>

					<td valign="top" class="value">${fieldValue(bean: individualInstance, field: "updator")}</td>
						<td>&nbsp;
						</td>
						<td>&nbsp;
						</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div id="KCTraining">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">

				<tr>
					<td valign="top" class="name">
					  <b>Courses/Workshops</b>
					</td>
					<td valign="top">

						<ul>
						<g:each in="${courses}" var="c">
							<li>${c.course}</li>
						</g:each>
						</ul>
					</td>
					<td valign="top" class="name">
					  <b>Books</b>
					</td>
					<td valign="top">

						<ul>
						<g:each in="${booksRead}" var="b">
							<li>${b.book}</li>
						</g:each>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

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
                                    <li><g:link controller="individualRole" action="show" id="${i.id}">${i.role}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
			</tbody>
		</table>

	</div>

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
	
	<div id="Commitment">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
			<tr>
				<td width="20%"><b>Committed Amount</b></td>
				<td width="80%">${ics.Commitment.findByCommittedBy(individualInstance)?.committedAmount}</td>
			</tr>
			<tr>
				<td width="20%"><b>Committed On</b></td>
				<td width="80%">${ics.Commitment.findByCommittedBy(individualInstance)?.commitmentOn?.format('dd-MM-yyyy')}</td>
			</tr>
			<tr>
				<td width="20%"><b>Committed Till</b></td>
				<td width="80%">${ics.Commitment.findByCommittedBy(individualInstance)?.commitmentTill?.format('dd-MM-yyyy')}</td>
			</tr>

			</tbody>
		</table>
	</div>
	
	</div>
</div>
                
<div class="col2">
      <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN,ROLE_DUMMY,ROLE_BACKOFFICE,ROLE_PATRONCARE">
		<g:if test="${amtBCInd > 0}">
		<div style="background-color:#FF0000">
			<h2>Dishonoured Cheques</h2>
			<table >
			    <tbody>

				<tr>
				    <td valign="top" class="name">Individual:</td>

				    <td valign="top" class="value">${amtBCInd}</td>

					</tr>
				<tr>
				    <td valign="top" class="name">Family+Own:</td>

				    <td valign="top" class="value">${amtBCFam}</td>

					</tr>

			    </tbody>
		</table>
		</div>
		</g:if>

		<h2>Scheme Wise Donation Summary</h2>
		<table cellspacing="0" cellpadding="0" align="left" border="0">
		    <tbody>

		<g:each in="${sList}" status="i" var="sInstance">

		<tr>
		    <td style="word-wrap: break-word" valign="top" class="name" width="50%" align="left" >${sInstance?.scheme}:</td>

		    <td style="word-wrap: break-word" valign="middle" class="value" align="left" >${sInstance?.amt}</td>

			</tr>
		    </g:each>
		    </tbody>
		</table>

		<br><br><br>
		<h2>Donation Summary</h2>
		<table>
		<tbody>

		<tr>
		    <td valign="top" class="name">Individual Donation:</td>

		    <td style="word-wrap: break-word" valign="top" class="value">${amtInd}</td>

		</tr>

		<tr>
		    <td valign="top" class="name">Family Donation:</td>

		    <g:set var="fam" value="${(amtFam?:0) - (amtInd?:0)}" />

		    <td style="word-wrap: break-word" valign="top" class="value">${fam?:''}</td>

		</tr>
		<g:if test="${isCollector == 'true'}">
			<tr>
			    <td valign="top" class="name" width="45%">Collection:</td>

			    <td style="word-wrap: break-word" valign="middle" class="value" align="left">${amtColExclOwn}</td>

			</tr>

		</g:if>
		</tbody>
		</table>


		<h2>Gifts Received Summary</h2>
		<table>
		    <tbody>

		<tr>
		    <td valign="top" class="name">Individual:</td>

		    <td style="word-wrap: break-word" valign="top" class="value">${amtGiftInd}</td>

			</tr>

		<tr>
		    <td valign="top" class="name">Family+Own:</td>

		    <td style="word-wrap: break-word" valign="top" class="value">${amtGiftFam}</td>

			</tr>
		    </tbody>
		</table>

		<!--<g:if test="${isCollector == 'true'}">
			<h2>Collections Summary</h2>
			<table cellspacing="0" cellpadding="0" align="left" border="0">
			    <tbody>

				<tr>
				    <td valign="top" class="name" width="45%">Collection (incl own):</td>

				    <td style="white-space: -moz-pre-wrap" valign="middle" class="value" align="left" >${amtCol}</td>

				</tr>
				<tr>
				    <td valign="top" class="name" width="45%">Collection (excl own):</td>

				    <td style="word-wrap: break-word" valign="middle" class="value" align="left">${amtColExclOwn}</td>

				</tr>

			    </tbody>
		</table>
		</g:if>-->

		<h2>Datewise Donations Summary</h2>
		<table>
		    <tbody>
				<thead>
					<th>Donation Date</th>
					<th>Donation Amount</th>
				</thead>
			<g:each in="${individualInstance.donations}" var="d">
				<tr>
					<td><g:formatDate format="dd-MM-yyyy" date="${d.donationDate}"/></td>
					<td>${d.amount}</td>
				</tr>
				<!--<li><g:link controller="donation" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>-->
			</g:each>

		    </tbody>
		</table>
					
      </sec:ifAnyGranted>

			</div>
	</div>
</div>
	
    </body>
</html>
