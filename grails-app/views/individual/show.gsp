
<%@ page import="ics.Individual" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'individual.label', default: 'Individual')}" />
        <title>${individualInstance}</title>
	<r:require module="grid" />
	<r:require module="dateTimePicker" />
    </head>
    <body>
	<script>
		$(function() {
			$( "#tabs" ).tabs();
            /*<sec:ifAnyGranted roles="ROLE_COUNSELLOR,ROLE_VOICE_ADMIN,ROLE_COUNSELLOR_GROUP">
			$("#tabs").tabs("remove", "#Donations" );
			$("#tabs").tabs("remove", "#GiftsReceived" );
			$("#tabs").tabs("remove", "#FundsCollected" );
			$("#tabs").tabs("remove", "#FundsReceived" );
			$("#tabs").tabs("remove", "#NVCCFields" );
			$("#tabs").tabs("remove", "#RecordInfo" );
			$("#tabs").tabs( "select" , "#SpiritualInformation" );
            </sec:ifAnyGranted>
            <sec:ifNotGranted roles="ROLE_COUNSELLOR,ROLE_VOICE_ADMIN,ROLE_COUNSELLOR_GROUP">
			$("#tabs").tabs("remove", "#Services" );
			$("#tabs").tabs( "remove" , "#KCTraining" );
            </sec:ifNotGranted>*/
		});
	</script>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="show" id="${individualInstance?.id}" params="[profile:'true']">Simple View</g:link></span>
            <sec:ifNotGranted roles="ROLE_COUNSELLOR,ROLE_VOICE_ADMIN">
		    <sec:ifNotGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">	
		        <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
		    	<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
		    </sec:ifNotGranted>
            </sec:ifNotGranted>

            <!--<sec:ifAnyGranted roles="ROLE_NVCC_ADMIN,ROLE_VOICE_ADMIN,ROLE_DONATION_EXECUTIVE">
            	<g:each in ="${ics.Scheme.list()}" var="scheme">
            		<span class="menuButton"><g:link class="create" controller="schemeMember" action="find" params="['individualid': individualInstance?.id,'schemeid':scheme?.id]">View ${scheme?.name?.encodeAsHTML()} Scheme</g:link></span>
            	</g:each>            	
            </sec:ifAnyGranted>-->

            <sec:ifNotGranted roles="ROLE_COUNSELLOR,ROLE_VOICE_ADMIN,ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
	            <span class="menuButton"><g:link class="list" controller="helper" action="searchIndividual">SearchIndividual</g:link></span>
            </sec:ifNotGranted>
            <!--<sec:ifAnyGranted roles="ROLE_COUNSELLOR,ROLE_VOICE_ADMIN">
		    <g:if test="${session.individualid!=individualInstance?.id}">
		    	<span class="menuButton"><g:link class="create" controller="relationship" action="edit" params="[ind1id: individualInstance?.id,ind2id: session.individualid]">Edit Relationship</g:link></span>
		    </g:if>
            </sec:ifAnyGranted>-->
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
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
		<div class="buttons">
		    <g:form>
			<g:hiddenField name="id" value="${individualInstance?.id}" />
			<sec:ifAnyGranted roles="ROLE_VOICE_ADMIN,ROLE_COUNSELLOR,ROLE_COUNSELLOR_GROUP">
				<span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
			</sec:ifAnyGranted>
			<sec:ifNotGranted roles="ROLE_COUNSELLOR,ROLE_VOICE_ADMIN,ROLE_PATRONCARE,ROLE_PATRONCARE_USER,ROLE_COUNSELLOR_GROUP,ROLE_DONATION_EXECUTIVE,ROLE_DONATION_COORDINATOR">
				<span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
				<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>				
			</sec:ifNotGranted>
			<sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
				<span class="button"><g:actionSubmit class="edit" action="editPatronCare" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
			</sec:ifAnyGranted>
			<sec:ifAnyGranted roles="ROLE_BACKOFFICE">
				<span class="button"><g:actionSubmit class="edit" action="linkdonation" value="Link Donation" /></span>
			</sec:ifAnyGranted>
			<sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
				<span class="menuButton"><g:link controller="donationRecord" action="quickCreate"  params="[icsid: individualInstance?.icsid]">Donation Record</g:link></span>
			</sec:ifAnyGranted>
			<sec:ifAnyGranted roles="ROLE_DUMMY,ROLE_BACKOFFICE">
				<!--<span class="menuButton"><g:link class="create" controller="donation" action="dummydonation" params="['donatedBy.id': individualInstance?.id]">Donation </g:link></span>-->
				<span class="menuButton"><g:link class="create" controller="donation" action="entry" id="${individualInstance?.id}">Donation </g:link></span>
				<span class="menuButton"><g:link class="create" controller="flags" action="create" params="[indid: individualInstance?.id]">Flags</g:link></span>
			</sec:ifAnyGranted>
			<sec:ifAnyGranted roles="ROLE_DUMMY,ROLE_BACKOFFICE,ROLE_DONATION_EXECUTIVE">
				<span class="menuButton"><g:link class="create" controller="schemeMember" action="createfromindividual" params="['individualid': individualInstance?.id]">AssociateScheme</g:link></span>
			</sec:ifAnyGranted>
		    </g:form>
		</div>
                            
            <div>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tbody bgcolor="lavender">
                        <tr>
                            <td valign="top" class="name"><b><g:message code="individual.id.label" default="Id" /></b></td>
                            <td valign="top" class="value"><g:formatNumber number="${individualInstance?.id}" format="#" /> (IcsId:${individualInstance?.icsid})</td>

                            <td valign="top" class="name"><b><g:message code="individual.title.label" default="Title" /></b></td>
                            <td valign="top" class="value">${individualInstance?.title?.encodeAsHTML()}</td>

                            <td valign="top" class="name"><b>Name</b></td>
                            <td valign="top" class="value">${individualInstance?.initiatedName?(individualInstance?.initiatedName+" ( "+ individualInstance?.legalName +" )"):individualInstance?.legalName}</td>

            <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
                            <td valign="top" class="name"><b>Category</b></td>
                            <td valign="top" class="value">${individualInstance?.category}</td>
            </sec:ifAnyGranted>

            <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
                            <td valign="top" class="name"><b>Type</b></td>
                            <td valign="top" class="value">${individualInstance?.type}</td>
            </sec:ifAnyGranted>

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
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${individualInstance?.dob}" /></td>
                            
                            <g:if test="${individualInstance?.marriageAnniversary}">
				    <td valign="top" class="name"><b><g:message code="individual.marriageAnniversary.label" default="Marriage Anniversary" /></b></td>
				    <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${individualInstance?.marriageAnniversary}" /></td>
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
                                <g:each in="${individualInstance.address}" var="a">
                                    <!--<li>${a?.encodeAsHTML()}</li>-->
                                    <li><g:link controller="address" action="edit" id="${a.id}" target="_blank">${a?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                <li><g:link controller="address" action="create" params="['individual.id': individualInstance?.id]" id="addAddress" target="_blank">${message(code: 'default.add.label', args: [message(code: 'address.label', default: 'Address')])}</g:link></li>
                                </ul>
                            </td>

                            <td valign="top" class="name"><b>Contact</b></td>
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.voiceContact}" var="v">
                                    <!--<li>${v?.encodeAsHTML()}</li>-->
                                    <li><g:link controller="voiceContact" action="edit" id="${v.id}" target="_blank">${v?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                <li><g:link controller="voiceContact" action="create" params="['individual.id': individualInstance?.id]" target="_blank">Add Contact</g:link></li>
                                </ul>
                            </td>
                            
                            <td valign="top" class="name"><b>Email</b></td>
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.emailContact}" var="e">
                                    <!--<li>${e?.encodeAsHTML()}</li>-->
                                    <li><g:link controller="emailContact" action="edit" id="${e.id}" target="_blank">${e?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                <li><g:link controller="emailContact" action="create" params="['individual.id': individualInstance?.id]" target="_blank">${message(code: 'default.add.label', args: [message(code: 'emailContact.label', default: 'EmailContact')])}</g:link></li>
                                </ul>
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

	<g:if test="${individualInstance.description}">
            <div>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tbody bgcolor="lavender">
                        <tr>
                            <td valign="top" class="name"><b>Description</b></td>
                            <td valign="top" style="text-align: left;" class="value">
                                ${individualInstance.description}
                            </td>
                        </tr>
                    </tbody>
                </table>
	    </div>
	 </g:if>
      
	<div id="tabs">
	 <ul>    

		<li><a href="#RecordInfo">RecordInfo</a></li>
		<li><a href="${g.createLink(controller:'individual',action:'family',params:['id':individualInstance.id])}">Family</a></li>
		<li><a href="${g.createLink(controller:'individual',action:'professionalInfo',params:['id':individualInstance.id])}">ProfessionalInfo</a></li>
		<li><a href="${g.createLink(controller:'individual',action:'languages',params:['id':individualInstance.id])}">Languages</a></li>
		<li><a href="${g.createLink(controller:'individual',action:'communicationPreferences',params:['id':individualInstance.id])}">CommunicationPreferences</a></li>
		<li><a href="${g.createLink(controller:'individual',action:'spiritualInformation',params:['id':individualInstance.id])}">SpiritualInformation</a></li>
		<li><a href="${g.createLink(controller:'individual',action:'lifeMember',params:['id':individualInstance.id])}">LifeMember</a></li>
		<li><a href="${g.createLink(controller:'individual',action:'donationsList',params:['id':individualInstance.id])}">Donations</a></li>
		<!--<li><a href="#GiftsReceived">GiftsReceived</a></li>-->
		<li><a href="${g.createLink(controller:'giftIssued',action:'list',params:['issuedTo.id':individualInstance.id])}">GiftsIssued</a></li>
		<li><a href="${g.createLink(controller:'individual',action:'fundsCollected',params:['id':individualInstance.id])}">FundsCollected</a></li>
		<li><a href="${g.createLink(controller:'individual',action:'fundsReceived',params:['id':individualInstance.id])}">FundsReceived</a></li>
		<li><a href="${g.createLink(controller:'individual',action:'nvccFields',params:['id':individualInstance.id])}">NVCCFields</a></li>
		<li><a href="${g.createLink(controller:'individual',action:'kcTraining',params:['id':individualInstance.id])}">KC Training</a></li>
		<li><a href="${g.createLink(controller:'individual',action:'kcRoles',params:['id':individualInstance.id])}">Roles</a></li>
		<li><a href="${g.createLink(controller:'individual',action:'services',params:['id':individualInstance.id])}">Services</a></li>		
		<li><a href="${g.createLink(controller:'commitment',action:'list',params:['committedBy.id':individualInstance.id])}">Commitment</a></li>
		<li><a href="${g.createLink(controller:'followup',action:'list',params:['cmd':'fwith','findwithid':individualInstance.id])}">Followups</a></li>
		<li><a href="${g.createLink(controller:'schemeMember',action:'list',params:['individual.id':individualInstance.id])}">SchemeMemberships</a></li>
		<li><a href="${g.createLink(controller:'relationship',action:'list',params:['individualid':individualInstance.id])}">Relationships</a></li>
	</ul>
	  
	  
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
	
	<!--<div id="GiftsReceived">
            <sec:ifAnyGranted roles="ROLE_DUMMY,ROLE_BACKOFFICE,ROLE_NVCC_ADMIN,ROLE_PATRONCARE_HEAD,ROLE_PATRONCARE,ROLE_PATRONCARE_USER,ROLE_COUNSELLOR">
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
	</div>-->
   

	 </div>
	
   </div>
   
<div class="col2">
 <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN,ROLE_DUMMY,ROLE_BACKOFFICE,ROLE_PATRONCARE,ROLE_PATRONCARE_USER,ROLE_COUNSELLOR">
   <div id ="donationSummary"></div> 
   <fieldset class="buttons">
        <input type="button" id="donationsummary" value="Donation Summary">
     </fieldset>
     </div>
 </sec:ifAnyGranted>
</div> <!-- col2 ends -->

  </div>
<script>
 $(function()
 {
$('#donationsummary').click(function(){

     var url="${g.createLink(controller:'individual',action:'showDonationSummary',params:['id':individualInstance.id])}";
     $.ajax({
         url:url,
         type:'POST',
         processData: false,  // tell jQuery not to process the data
         contentType: false ,
         success:function (data) {
         $('#donationSummary').html($(data));    
         }
         });
     });
 });

</script>
  </body>
</html>
