
<%@ page import="ics.Individual" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'individual.label', default: 'Individual')}" />
		<link rel="stylesheet" href="${resource(dir: 'css/blue', file: 'style.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">

        <title>${individualInstance}(EditPatronCare)</title>
    </head>

    <body onLoad="return tabOrders();">
    <g:javascript src="jquery-ui-1.8.18.custom.min.js" />
	<script>
		$(function() {
			$( "#tabs" ).tabs();
		});
	</script>
    <script type="text/javascript">
        $(document).ready(function()
        {
          $("#dob").datepicker({yearRange: "-100:+0",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#marriageAnniversary").datepicker({yearRange: "-100:+0",changeMonth: true,
			changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#firstInitiation").datepicker({yearRange: "-100:+0",changeMonth: true,
			changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#secondInitiation").datepicker({yearRange: "-100:+0",changeMonth: true,
			changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#introductionDate").datepicker({yearRange: "-100:+0",changeMonth: true,
			changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#sixteenRoundsDate").datepicker({yearRange: "-100:+0",changeMonth: true,
			changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#voiceDate").datepicker({yearRange: "-100:+0",changeMonth: true,
			changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#joinAshram").datepicker({yearRange: "-100:+0",changeMonth: true,
			changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#commitmentOn").datepicker({yearRange: "-6:+6",changeMonth: true,
			changeYear: true,
			dateFormat: 'dd-mm-yy'});
          $("#commitmentTill").datepicker({yearRange: "-6:+6",changeMonth: true,
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
			/*$("#dialog").dialog({
			autoOpen: true,
			modal: true});*/
			
			/*$("#dialog").load("D:\NVCC\ics\grails-app\views\address\create.gsp", function() {
			    var container = $(this);
			    container.dialog({
			        modal: true,
			        autoOpen: true
			    })
			    .find("form").submit(function() {
			        container.dialog("close");
			        return false;
			    });
			});*/

			
			/*$( "#addAddress" )
			.link()
			.click(function() {
				$( "#dialog" ).dialog( "open" );
				
			});*/
			
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


    <div id="dialog" title="Dialog Title" ></div>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <sec:ifNotGranted roles="ROLE_COUNSELLOR">
		    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
		    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
		    <span class="menuButton"><g:link class="list" controller="helper" action="searchIndividual">SearchIndividual</g:link></span>
            </sec:ifNotGranted>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${individualInstance}">
            <div class="errors">
                <g:renderErrors bean="${individualInstance}" as="list" />
            </div>
            </g:hasErrors>

	<fieldset>
	  <legend><b>Image Upload</b></legend>
	  <g:form action="upload_avatar" method="post" enctype="multipart/form-data">
            <g:hiddenField name="id" value="${individualInstance?.id}" />
	    <label for="avatar"><b>Image (max 100K)</b></b></b></label>
	    <input type="file" name="avatar" id="avatar" />
	    <div style="font-size:0.8em; margin: 1.0em;">
	      For best results, your image should have a width-to-height ratio of 4:5.
	      For example, if your image is 80 pixels wide, it should be 100 pixels high.
	    </div>
	    <input type="submit" class="buttons" value="Upload" />
	  </g:form>
	</fieldset>


            <g:form method="post" >
                <g:hiddenField name="id" value="${individualInstance?.id}" />
                <g:hiddenField name="version" value="${individualInstance?.version}" />
		<g:hiddenField name="patroncare" value="${true}" />
                <div class="dialog">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">

                            <tr>
                                <td valign="top" class="name" width="12%">
                                  <label for="legalName"><b><g:message code="individual.legalName.label" default="Legal Name" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'legalName', 'errors')}">
                                    ${individualInstance?.legalName}
                                </td>

                                <td valign="top" class="name">
                                  <label for="initiatedName"><b><g:message code="individual.initiatedName.label" default="Initiated Name" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'initiatedName', 'errors')}">
                                    ${individualInstance?.initiatedName}
                                </td>
                                <td rowspan="4">
					<g:if test="${individualInstance.avatar}">
					  <img class="avatar" src="${createLink(controller:'individual', action:'avatar_image', id:individualInstance?.id)}" />
					</g:if>                        
                                </td>
                                
                            </tr>

                            <tr>
                                <td valign="top" class="name" width="12%">
                                  <label for="address"><b><g:message code="individual.address.label" default="Address" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'address', 'errors')}" colspan="5">
                                    
					<ul>
					<g:each in="${individualInstance?.address?}" var="a">
					    <li><g:link controller="address" action="edit" id="${a.id}" target="_blank">${a?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
					<g:link controller="address" action="create" params="['individual.id': individualInstance?.id]" id="addAddress" target="_blank">${message(code: 'default.add.label', args: [message(code: 'address.label', default: 'Address')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr>
                                <td valign="top" class="name" width="12%">
                                  <label for="voiceContact"><b><g:message code="individual.voiceContact.label" default="Voice Contact" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'voiceContact', 'errors')}" colspan="5">
                                    
					<ul>
					<g:each in="${individualInstance?.voiceContact?}" var="v">
					    <li><g:link controller="voiceContact" action="edit" id="${v.id}" target="_blank">${v?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
					<g:link controller="voiceContact" action="create" params="['individual.id': individualInstance?.id]" target="_blank">${message(code: 'default.add.label', args: [message(code: 'voiceContact.label', default: 'VoiceContact')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr>
                                <td valign="top" class="name" width="12%">
                                  <label for="emailContact"><b><g:message code="individual.emailContact.label" default="Email Contact" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'emailContact', 'errors')}" colspan="5">
                                    
					<ul>
					<g:each in="${individualInstance?.emailContact?}" var="e">
					    <li><g:link controller="emailContact" action="edit" id="${e.id}" target="_blank">${e?.encodeAsHTML()}</g:link></li>
					</g:each>
					</ul>
					<g:link controller="emailContact" action="create" params="['individual.id': individualInstance?.id]" target="_blank">${message(code: 'default.add.label', args: [message(code: 'emailContact.label', default: 'EmailContact')])}</g:link>

                                </td>
                            </tr>

                        

            		<sec:ifAnyGranted roles="ROLE_NVCC_ADMIN,ROLE_PATRONCARE_HEAD,ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
                            <tr>
                                <td valign="top" class="name" width="12%">
                                  <b>ISKCON Representative</b>
                                </td>
                                <td valign="top" colspan="5" >
                                    
					<ul>
					<g:set var="hasCultivator" value="false" />
					<g:each in="${individualInstance?.relative1?}" var="r">
						<g:if test="${r?.relation?.name == 'Cultivated by' && r.status == 'ACTIVE'}">
							<g:set var="hasCultivator" value="true" />
			    				<li><g:link controller="relationship" action="edit" id="${r.id}" target="_blank">${r?.encodeAsHTML()}</g:link></li>
						</g:if>
					</g:each>
					</ul>
					<g:if test="${hasCultivator=='false'}">
						<g:link controller="relationship" action="create" params="['individual1.id': individualInstance?.id, 'relationName' : 'Cultivated by']" target="_blank">Add ISKCON Representative</g:link>
					</g:if>
                                </td>
                            </tr>
            		</sec:ifAnyGranted>

                            <tr>
                                <td valign="top" class="name" width="12%">
                                  <b>Family Relations</b>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'relative2', 'errors')}" colspan="5">
                                    
					<ul>
					<g:each in="${individualInstance?.relative2?}" var="r">
						<g:if test="${r?.relationshipGroup?.groupName != 'dummy'}">
						    <li><g:link controller="relationship" action="edit" id="${r.id}" target="_blank">${r?.encodeAsHTML()}</g:link></li>
						</g:if>
					</g:each>
					</ul>
					<g:link controller="relationship" action="create" params="['individual2.id': individualInstance?.id, family: true]" target="_blank">Add Family Member</g:link>

                                </td>
                            </tr>

                            <tr>
                                <td valign="top" class="name" width="12%">
                                  <b>Spiritual Relations</b></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'relative1', 'errors')}" colspan="5">
                                    
					<ul>
					<g:set var="isDisciple" value="false" />
					<g:set var="isCouncelle" value="false" />
					<g:each in="${individualInstance?.relative1?}" var="r">
						<g:if test="${r?.relation?.name == 'Disciple of' && r.status == 'ACTIVE'}">
							<g:set var="isDisciple" value="true" />
							    <li><g:link controller="relationship" action="edit" id="${r.id}" target="_blank">${r?.encodeAsHTML()}</g:link></li>
						</g:if>
						<g:elseif test="${r?.relation?.name == 'Councellee of' && r.status == 'ACTIVE'}">
							<g:set var="isCouncelle" value="true" />
							<li>${r?.encodeAsHTML()}</li>
						</g:elseif>
					</g:each>
					</ul>
					
					<g:if test="${isDisciple == 'false'}">
						<g:link controller="relationship" action="create" params="['individual1.id': individualInstance?.id , 'relationName' : 'Disciple of']" target="_blank">Add Guru</g:link>
					</g:if>


                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                    <!--<a href="javascript:togglePersonalDetails()"><font color="navy">PersonalInformation</font></a> -->
</div>
<div id="tabs">
	<ul>
		<li><a href="#PersonalInformation">PersonalInformation</a></li>
		<li><a href="#SpiritualInformation">SpiritualInformation</a></li>
		<sec:ifNotGranted roles="ROLE_PATRONCARE">
			<li><a href="#KCTraining">KC Training</a></li>
			<li><a href="#KCRoles">Roles</a></li>
			<li><a href="#Services">Services</a></li>
			<li><a href="#Commitment">Commitment</a></li>
		</sec:ifNotGranted>
		<li><a href="${g.createLink(controller:'followup',action:'list',params:['cmd':'fwith','findwithid':individualInstance.id])}">Followups</a></li>
	</ul>

	<div id="KCRoles">

	<div class="dialog" id="SpiritualInformation">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">

			<tr>
				<td valign="top">
					<label for="introductionDate"><b>Introduction Date</b></label>
				</td>
				<td valign="top">
					<g:textField name="introductionDate" value="${individualInstance?.introductionDate?.format('dd-MM-yyyy')}"/>                                    
				</td>
				<td valign="top">
					<label for="sixteenRoundsDate"><b>Chanting 16 rounds since</b></label>
				</td>
				<td valign="top">
					<g:textField name="sixteenRoundsDate" value="${individualInstance?.sixteenRoundsDate?.format('dd-MM-yyyy')}"/>                                    
				</td>
				<td valign="top">
					<label for="voiceDate"><b>Voice Training Date</b></label>
				</td>
				<td valign="top">
					<g:textField name="voiceDate" value="${individualInstance?.voiceDate?.format('dd-MM-yyyy')}"/>                                    
				</td>
				<td valign="top">
					<label for="joinAshram"><b>Ashram joining Date</b></label>
				</td>
				<td valign="top">
					<g:textField name="joinAshram" value="${individualInstance?.joinAshram?.format('dd-MM-yyyy')}"/>                                    
				</td>

			</tr>
			<tr>
				<td valign="top">
					<label for="ashram"><b>Ashram</b></label>
				</td>
				<td valign="top">
					<g:select name="ashram" from="${['Brahmachari','Grahastha','Vanaprastha','Sanyas','Other']}" value="${individualInstance?.ashram}" noSelection="['':'-Choose-']"/>                                  
				</td>
				<td valign="top">
					<label for="firstInitiationStatus"><b>First Initiation Status</b></label>
				</td>
				<td valign="top">
					<g:select name="firstInitiationStatus" from="${['Not Decided','Aspiring','Initiated']}" value="${individualInstance?.firstInitiationStatus}" noSelection="['':'-Choose-']"/>                                  
				</td>
				<td valign="top">
					<label for="currentCentre"><b>Current Centre</b></label>
				</td>
				<td valign="top">
					<g:select name="currentCentre" from="${ics.Centre.list(sort:'name')}" optionKey="id" value="${centre}" noSelection="['':'-Choose-']"/>                                  
				</td>						
				<td valign="top">
					<label for="numRounds"><b>Number of rounds Chanting currently</b></label>
				</td>
				<td valign="top">
					<g:textField name="numRounds" value="${individualInstance?.numRounds}"/>
				</td>
			</tr>

			<tr>
				<td valign="top" >
					<label for="firstInitiation"><b><g:message code="individual.firstInitiation.label" default="First Initiation" /></b></label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'firstInitiation', 'errors')}" width="15%">

					<g:textField name="firstInitiation" value="${individualInstance?.firstInitiation?.format('dd-MM-yyyy')}" tabindex="47"/>                                    
				</td>

				<td valign="top" >
					<label for="firstInitiationPlace"><b><g:message code="individual.firstInitiationPlace.label" default="First Initiation Place" /></b></label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'firstInitiationPlace', 'errors')}" >
					<g:select name="firstInitiationPlace" from="${ics.Country.list(sort:'name')}" value="${individualInstance?.firstInitiationPlace}" noSelection="['':'-Choose First Initiation Place-']" tabindex="48"/>
				</td>
				<td valign="top" >
					<label for="secondInitiation"><b><g:message code="individual.secondInitiation.label" default="Second Initiation" /></b></label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'secondInitiation', 'errors')}" >
					<g:textField name="secondInitiation" value="${individualInstance?.secondInitiation?.format('dd-MM-yyyy')}" tabindex="49"/>                                    
				</td>                            
				<td valign="top" >
					<label for="secondInitiationPlace"><b><g:message code="individual.secondInitiationPlace.label" default="Second Initiation Place" /></b></label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'secondInitiationPlace', 'errors')}">
					<g:select name="secondInitiationPlace" from="${ics.Country.list(sort:'name')}" value="${individualInstance?.secondInitiationPlace}" noSelection="['':'-Choose Second Initiation Place-']" tabindex="50"/>
				</td>
			</tr>
			</tbody>
		</table>
	</div>

	<div id="PersonalInformation">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
				<tr>
					<td valign="top" class="name" width="6%">
					  <label for="title"><b><g:message code="individual.title.label" default="Title" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'title', 'errors')}" width="11%">
						${individualInstance?.title}
					</td>
					<td valign="top" class="name" width="10%">
					  <label for="dob"><b><g:message code="individual.dob.label" default="Dob" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'dob', 'errors')}" width="11%">
						
						<g:textField name="dob" value="${individualInstance?.dob?.format('dd-MM-yyyy')}"/>                                    
					</td>


					<td valign="top" class="name" width="10%">
					  <label for="marriageAnniversary"><b><g:message code="individual.marriageAnniversary.label" default="Marriage Anniversary" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'marriageAnniversary', 'errors')}" width="11%">
						<!--<g:datePicker name="marriageAnniversary" precision="day" value="${individualInstance?.marriageAnniversary}" noSelection="['': '']"  default="none" />-->
						<g:textField name="marriageAnniversary"  value="${individualInstance?.marriageAnniversary?.format('dd-MM-yyyy')}"/>
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>                                
				</tr>

				<tr>
					<td valign="top" class="name" width="6%">
					  <label for="isDonor"><b><g:message code="individual.isDonor.label" default="Is Donor" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'isDonor', 'errors')}" width="11%">
						${individualInstance?.isDonor}
					</td>
					<!--<td valign="top" class="name" width="10%">
					  <label for="isWellWisher"><b><g:message code="individual.isWellWisher.label" default="Is Well Wisher" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'isWellWisher', 'errors')}" width="11%">
						${individualInstance?.isWellWisher}
					</td>-->
					<td valign="top" class="name" width="8%">
					  <label for="motherTongue"><b><g:message code="individual.motherTongue.label" default="Mother Tongue" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'motherTongue', 'errors')}" width="11%">
						<!--<g:textField name="motherTongue" value="${individualInstance?.motherTongue}" />-->
						${individualInstance?.motherTongue}
					</td>

					<td valign="top" class="name" width="8%" rowspan="4">
					  <label for="type"><b><g:message code="individual.type.label" default="Type" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'type', 'errors')}" width="11%" rowspan="4">
	                                    <g:select name="type" from="${'A'..'Z'}" value="${individualInstance?.type}" noSelection="['':'-Choose Type-']"/>
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>

				</tr>

				<tr>
					<td valign="top" class="name" width="8%">
					  <label for="isMale"><b><g:message code="individual.isMale.label" default="Is Male" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'isMale', 'errors')}" width="11%">
						${individualInstance?.isMale}
					</td>                        	
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>

				</tr>
				<tr>
					<td valign="top" class="name" width="10%">
					  <label for="panNo"><b><g:message code="individual.panNo.label" default="PAN No" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'panNo', 'errors')}" width="11%">
						<g:textField name="panNo" value="${individualInstance?.panNo}" />
					</td>                
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>

				</tr>
				<tr>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>              
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>

				</tr>                        	
				<tr>
					<td valign="top" class="name" width="6%">
					  <label for="status"><b><g:message code="individual.status.label" default="Status" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'status', 'errors')}" width="11%">
						${individualInstance?.status}
					</td>

					<td valign="top" class="name" width="10%">
					  <label for="remarks"><b><g:message code="individual.remarks.label" default="Remarks" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'remarks', 'errors')}" width="11%">
						${individualInstance?.remarks}
					</td>

					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>

				</tr>
				<tr>
					<td valign="top" class="name" width="8%">
					  <label for="profession"><b><g:message code="individual.profession.label" default="Profession" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'profession', 'errors')}" width="11%">
						<!--<g:textField name="profession" value="${individualInstance?.profession}" />-->
						<g:select name="profession" from="${ics.Profession.list(sort:'name')}" value="${individualInstance?.profession}" optionKey="name" noSelection="['':'-Choose Profession-']" />
					</td>
					<td valign="top" >
						<label for="edu"><b>Education</b></label>
					</td>
					<td valign="top">
						${individualInstance?.education}
					</td>
					<td valign="top" class="name" width="10%" rowspan="5">
					  <label for="businessRemarks"><b><g:message code="individual.businessRemarks.label" default="Business Remarks" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'businessRemarks', 'errors')}" width="11%" rowspan="5">
						${individualInstance?.businessRemarks}
					</td>

					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>

				</tr>
				<tr>
					<td valign="top" class="name" width="6%">
					  <label for="companyName"><b><g:message code="individual.companyName.label" default="CompanyName" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'companyName', 'errors')}" width="11%">
						${individualInstance?.companyName}
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>

				</tr>							
				<tr>
					<td valign="top" class="name" width="6%">
					  <label for="designation"><b><g:message code="individual.designation.label" default="Designation" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'designation', 'errors')}" width="11%">
						${individualInstance?.designation}
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>

				</tr>
				<tr>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>

				</tr>                            
				<tr>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>

				</tr>                            

				<tr>
					<td valign="top" class="name" width="6%">
					  <label for="literatureLanguagePreference"><b><g:message code="individual.literatureLanguagePreference.label" default="Literature Language Preference" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'literatureLanguagePreference', 'errors')}" width="11%">
						<g:select name="literatureLanguagePreference" from="${['ENGLISH','HINDI','MARATHI']}" value="${individualInstance?.literatureLanguagePreference}" noSelection="['':'-Select-']"/>
					</td>
					<td valign="top" class="name" width="10%">
					  <label for="communicationsPreference"><b><g:message code="individual.communicationsPreference.label" default="Communications Preference" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'communicationsPreference', 'errors')}" width="11%">
						<g:select name="communicationsPreference" from="${['RESIDENCE','OFFICE']}" value="${individualInstance?.communicationsPreference}" noSelection="['':'-Select-']" />
					</td>

					<td valign="top" class="name" width="8%">
					  <label for="languagePreference"><b><g:message code="individual.languagePreference.label" default="Language Preference" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'languagePreference', 'errors')}" width="11%">
						<g:select name="languagePreference" from="${['ENGLISH','HINDI','MARATHI']}" value="${individualInstance?.languagePreference}"  noSelection="['':'-Select-']"/>
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>

				</tr>

				<tr>
					<td valign="top" class="name" width="6%">
					  <label for="picFileURL"><b><g:message code="individual.picFileURL.label" default="Pic File URL" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'picFileURL', 'errors')}" width="11%">
						${individualInstance?.picFileURL}
					</td>

					<td valign="top" class="name" width="10%">
					  <label for="isLifeMember"><b><g:message code="individual.isLifeMember.label" default="Is Life Member" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'isLifeMember', 'errors')}" width="11%">                                    
						${individualInstance?.isLifeMember}

					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>

				</tr>

				</table>
			</tbody>
			</div>

			<div class="dialog" id="donorTable" style="display: none">
			<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">
				<tr >
					<td valign="top" class="name"  width="10%">
						<label for="membershipNo"><b><g:message code="individual.membershipNo.label" default="Membership No" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'membershipNo', 'errors')}" width="11%">
						${individualInstance?.membershipNo}
					</td>

					<td valign="top" class="name" width="10%">
						<label for="membershipPlace"><b><g:message code="individual.membershipPlace.label" default="Membership Place" /></b></label>
					</td>
					<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'membershipPlace', 'errors')}" width="11%">
						${individualInstance?.membershipPlace}
					</td>
					<td>&nbsp;
					</td>
					<td>&nbsp;
					</td>

				</tr>
			</tbody>
			</table>
			</div>


                
	</div>                
                
				

				
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>

        <script language="javascript"> 
	    function togglePersonalDetails() {
		var ele = document.getElementById("div-personalinfo");
		if (ele.style.display == "block") 
			{
				ele.style.display = "none";
				document.getElementById("donorTable2").style.display = "none";
				document.getElementById("donorTable").style.display = "none";
			}
		else
			{
			ele.style.display = "block";
			document.getElementById("donorTable2").style.display = "block";
			if (document.getElementById('isLifeMember').checked)
			{
				document.getElementById("donorTable").style.display = "block";

			}
			else
				{
				document.getElementById("donorTable").style.display = "none";

				}
			}
	    } 
	    function checkLifeMember() {
			var cb = document.getElementById('isLifeMember');
			var ele = document.getElementById("donorTable");

			if (cb.checked)
			{
				ele.style.display = "block";
			}
			else
			{
				ele.style.display = "none";
			}
		} 
	    
	 </script>


    </body>
</html>
