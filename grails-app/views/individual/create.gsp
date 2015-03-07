<%@ page import="ics.Individual" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'individual.label', default: 'Individual')}" />
        <title>Add ${type?:"Individual"}</title>
	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
    </head>

    <body onLoad="return tabOrders();">
	<r:require module="jqui" />
	<script>
		$(function() {
			$( "#tabs" ).tabs();
            <sec:ifNotGranted roles="ROLE_COUNSELLOR,ROLE_COUNSELLOR_GROUP">
			$("#tabs").tabs("remove", "#KCRoles" );
			$("#tabs").tabs("remove", "#Services" );
            </sec:ifNotGranted>

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
    var tabindex = 1;
    $('input,select,textarea').each(function() {
        if (this.type != "hidden") {
            var $input = $(this);
            $input.attr("tabindex", tabindex);
            tabindex++;
        }
    });          
			
        })
    </script>


	<style>
	#demo-frame > div.demo { padding: 10px !important; };
	</style>
	<script>
	$(function() {
		$( "#slider-range-max-rf-0" ).slider({
			range: "max",
			min: 1,
			max: 10,
			value: 2,
			slide: function( event, ui ) {
				$( "#readFluency0" ).val( ui.value );
			},
		        change: function(event, ui) {
		           $('#hreadFluency0').attr('value', ui.value);
			}
		});
		$( "#readFluency0" ).val( $( "#slider-range-max-rf-0" ).slider( "value" ) );
		$( "#slider-range-max-wf-0" ).slider({
			range: "max",
			min: 1,
			max: 10,
			value: 2,
			slide: function( event, ui ) {
				$( "#writeFluency0" ).val( ui.value );
			},
		        change: function(event, ui) {
		           $('#hwriteFluency0').attr('value', ui.value);
			}
		});
		$( "#writeFluency0" ).val( $( "#slider-range-max-wf-0" ).slider( "value" ) );
		$( "#slider-range-max-rf-1" ).slider({
			range: "max",
			min: 1,
			max: 10,
			value: 2,
			slide: function( event, ui ) {
				$( "#readFluency1" ).val( ui.value );
			},
		        change: function(event, ui) {
		           $('#hreadFluency1').attr('value', ui.value);
			}
		});
		$( "#readFluency1" ).val( $( "#slider-range-max-rf-1" ).slider( "value" ) );
		$( "#slider-range-max-wf-1" ).slider({
			range: "max",
			min: 1,
			max: 10,
			value: 2,
			slide: function( event, ui ) {
				$( "#writeFluency1" ).val( ui.value );
			},
		        change: function(event, ui) {
		           $('#hwriteFluency1').attr('value', ui.value);
			}
		});
		$( "#writeFluency1" ).val( $( "#slider-range-max-wf-1" ).slider( "value" ) );
		$( "#slider-range-max-rf-2" ).slider({
			range: "max",
			min: 1,
			max: 10,
			value: 2,
			slide: function( event, ui ) {
				$( "#readFluency2" ).val( ui.value );
			},
		        change: function(event, ui) {
		           $('#hreadFluency2').attr('value', ui.value);
			}
		});
		$( "#readFluency2" ).val( $( "#slider-range-max-rf-2" ).slider( "value" ) );
		$( "#slider-range-max-wf-2" ).slider({
			range: "max",
			min: 1,
			max: 10,
			value: 2,
			slide: function( event, ui ) {
				$( "#writeFluency2" ).val( ui.value );
			},
		        change: function(event, ui) {
		           $('#hwriteFluency2').attr('value', ui.value);
			}
		});
		$( "#writeFluency2" ).val( $( "#slider-range-max-wf-2" ).slider( "value" ) );
		$( "#slider-range-max-rf-3" ).slider({
			range: "max",
			min: 1,
			max: 10,
			value: 2,
			slide: function( event, ui ) {
				$( "#readFluency3" ).val( ui.value );
			},
		        change: function(event, ui) {
		           $('#hreadFluency3').attr('value', ui.value);
			}
		});
		$( "#readFluency3" ).val( $( "#slider-range-max-rf-3" ).slider( "value" ) );
		$( "#slider-range-max-wf-3" ).slider({
			range: "max",
			min: 1,
			max: 10,
			value: 2,
			slide: function( event, ui ) {
				$( "#writeFluency3" ).val( ui.value );
			},
		        change: function(event, ui) {
		           $('#hwriteFluency3').attr('value', ui.value);
			}
		});
		$( "#writeFluency3" ).val( $( "#slider-range-max-wf-3" ).slider( "value" ) );
		$( "#slider-range-max-rf-4" ).slider({
			range: "max",
			min: 1,
			max: 10,
			value: 2,
			slide: function( event, ui ) {
				$( "#readFluency4" ).val( ui.value );
			},
		        change: function(event, ui) {
		           $('#hreadFluency4').attr('value', ui.value);
			}
		});
		$( "#readFluency4" ).val( $( "#slider-range-max-rf-4" ).slider( "value" ) );
		$( "#slider-range-max-wf-4" ).slider({
			range: "max",
			min: 1,
			max: 10,
			value: 2,
			slide: function( event, ui ) {
				$( "#writeFluency4" ).val( ui.value );
			},
		        change: function(event, ui) {
		           $('#hwriteFluency4').attr('value', ui.value);
			}
		});
		$( "#writeFluency4" ).val( $( "#slider-range-max-wf-4" ).slider( "value" ) );
	});
	</script>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <sec:ifNotGranted roles="ROLE_COUNSELLOR">
	            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            </sec:ifNotGranted>
        </div>
        <div>
            <h1>Add ${type?:"Individual"}</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${individualInstance}">
            <div class="errors">
                <g:renderErrors bean="${individualInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" onsubmit="return validate();" enctype="multipart/form-data">
	
		<g:hiddenField name="type" value="${type}" />
		
                <div class="dialog">
               		
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                        
                            <tr>
                                <td valign="top" class="name" width="5%">
                                    <label for="title"><b><g:message code="individual.title.label" default="Title" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'title', 'errors')}" width="10%">
                                    <g:select name="title.id" from="${ics.Title.list()}" optionKey="id" value="${individualInstance?.title?.id?:(ics.Title.findByName('Mr.')?.id)}" noSelection="['': '--Select--']" tabindex="1"/>
                                </td>

                                <td valign="top" width="10%">
                                    &nbsp<label for="legalName"><b><g:message code="individual.legalName.label" default="Legal Name" /></b></label>*
                                </td>

                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'legalName', 'errors')}" width="60%">
                                    <g:textField name="legalName" size="110" maxlength="127" value="${individualInstance?.legalName}" tabindex="2"/>
                                </td>
                                <td valign="top"  width="10%">
                                    <label for="isMale"><b>Gender</b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'isMale', 'errors')}" width="5%">
					<select id="isMale" name="isMale">
						<option value="true">Male</option>
						<option value="false">Female</option>
					</select>
                                </td>                            
                                <td>
	    				<b>Image</b><i>(Max 100K - 4:5 ratio)</i>
	    			</td>
	    			<td>
	    				<input type="file" name="avatar" id="avatar" />
                                </td>
                            </tr>
                  	</tbody>
                        </table>
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                        
                            <tr >
                                <td valign="top">
                                    <label for="remarks"><b><g:message code="individual.remarks.label" default="Remarks" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'remarks', 'errors')}">
                                    <g:textArea name="remarks" value="${individualInstance?.remarks}" tabindex="15" style="width: 1155px; height: 36px;"/>
                                </td>
                            </tr>
			</tbody>
                        </table>
                        
                        
                        <div class="dialog" >
	              <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr>
                                <td valign="top">
                                    <label for="dob"><b><g:message code="individual.dob.label" default="Dob" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'dob', 'errors')}">
                                    <g:textField name="dob" value="${individualInstance?.dob?.format('dd-MM-yyyy')}" tabindex="12"/>
                                </td>
                                <td valign="top">
                                    <label for="marriageAnniversary"><b><g:message code="individual.marriageAnniversary.label" default="Marriage Anniversary" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'marriageAnniversary', 'errors')}">
                                    <g:textField name="marriageAnniversary"  value="${individualInstance?.marriageAnniversary?.format('dd-MM-yyyy')}" tabindex="13"/>
                                </td>
                                <td valign="top">
                                    <label for="panNo"><b><g:message code="individual.panNo.label" default="Pan No" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'panNo', 'errors')}">
                                    <g:textField name="panNo" value="${individualInstance?.panNo}" tabindex="11"/>
                                </td>
                                <td valign="top">
                                    <label for="bg"><b><g:message code="individual.bloodGroup.label" default="Blood Group" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'bloodGroup', 'errors')}">
                                    <g:select name="bloodGroup" from="${['O+','A+','B+','AB+','O-','A-','B-','AB-']}" value="${individualInstance?.bloodGroup}" noSelection="['':'-Choose Blood Group-']" tabindex="3"/>
                                </td>
                               </tr>
                        	
                               <tr>
            <!--<sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
                                <td valign="top">
                                    <label for="category"><b><g:message code="individual.category.label" default="Category" /></b></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'category', 'errors')}">
					<g:select multiple="multiple" name="category" from="${ics.DevoteeCategory.list(sort:'name')}" value="${individualInstance?.category}" noSelection="['':'-Choose Category-']" tabindex="4"/>
                                </td>
            </sec:ifAnyGranted>-->
                                <td></td>
                                <td></td>
            <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN,ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
                                <td valign="top">
                                    <b>ISKCON Representative</b>
                                </td>
                                <td valign="top">
					<div style="width: 300px">
						<gui:autoComplete
							id="acCultivator"
							width="200px"
							controller="individual"
							action="allCultivatorsAsJSON"
							useShadow="true"
							queryDelay="0.5" minQueryLength='3'
						tabindex="14"/>
					</div>
                                </td>
            </sec:ifAnyGranted>
            <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
                                <td valign="top">
                                    <label for="bg"><b>Type</b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'type', 'errors')}">
                                    <g:select name="type" from="${'A'..'Z'}" value="${individualInstance?.type}" noSelection="['':'-Choose Type-']"/>
                                </td>
                        	</tr>
            </sec:ifAnyGranted>

                        </tbody>
                    </table>
                </div>

				<div id="tabs">
					<ul>
						<li><a href="#Address">Address</a></li>
						<li><a href="#Contact">Contact</a></li>
						<li><a href="#CommunicationPreferences">CommunicationPreferences</a></li>
						<li><a href="#ProfessionalInformation">ProfessionalInformation</a></li>
						<li><a href="#Languages">Languages</a></li>
						<li><a href="#Family">Family</a></li>
						<li><a href="#Lifemember">LifeMember</a></li>
						<li><a href="#SpiritualInformation">SpiritualInformation</a></li>
						<li><a href="#KCTraining">KC Training</a></li>
						<li><a href="#KCRoles">KC Roles</a></li>
						<li><a href="#Services">Services</a></li>
					</ul>
                
                    <!--
                    <a href="javascript:toggleAddress()"><font color="navy">Address</font>&nbsp;&nbsp;</a> 
                    <a href="javascript:toggleContact()"><font color="navy">Contact</font>&nbsp;&nbsp;</a>
                    <a href="javascript:toggleBusiness()"><font color="navy">ProfessionalInformation</font>&nbsp;&nbsp;</a> 
                    <a href="javascript:togglePref()"><font color="navy">CommunicationPreferences</font>&nbsp;&nbsp;</a> 
                    <a href="javascript:toggleSpiritualDetails()"><font color="navy">SpiritualInformation</font>&nbsp;&nbsp;</a> 
                    <a href="javascript:toggleFamily()"><font color="navy">Family</font>&nbsp;&nbsp;</a>
                    -->

                        <div class="dialog" id="Languages">
				<table cellspacing="0" cellpadding="0" border="0">
					<tbody bgcolor="lavender">
					   <g:each in="${0..<5}"> 
						<g:hiddenField name="hreadFluency${it}"/>
						<g:hiddenField name="hwriteFluency${it}"/>

					   <tr>
							<td valign="top">
								<label for="language"><b>Language</b></label>
							</td>
							<td valign="top">
								<g:select name="language${it}.id" from="${ics.Language.list(sort:'name')}" optionKey="id" value="" noSelection="['': '--Select--']" />

							</td>
							<td valign="top">
								<label for="motherTongue"><b>Is Mother Tongue</b></label>*
							</td>
							<td valign="top">
								<g:radio name="mtge" value="mt${it}" />
							</td>
							<td valign="top">
								<label for="readFluency"><b>Reading Fluency</b><i>(Novice:1 Expert:10)</i></label>
							</td>
							<td valign="top">
								<input type="text" id="readFluency${it}" style="border:0; color:#f6931f; font-weight:bold;" />
								<div id="slider-range-max-rf-${it}"></div>
							</td>
							<td valign="top">
								<label for="writeFluency"><b>Writing Fluency</b><i>(Novice:1 Expert:10)</i></label>
							</td>
							<td valign="top">
								<input type="text" id="writeFluency${it}" style="border:0; color:#f6931f; font-weight:bold;" />
								<div id="slider-range-max-wf-${it}"></div>
							</td>
						</tr>
					   </g:each>
					</tbody>
				</table>
                        </div>

                        <div class="dialog" id="Lifemember">
                        <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr >
                                <td valign="top" class="name"  width="10%">
                                    <label for="membershipNo"><b><g:message code="individual.membershipNo.label" default="Membership No" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'membershipNo', 'errors')}" width="6%">
                                    <g:textField name="membershipNo" value="${individualInstance?.membershipNo}" tabindex="9"/>
                                </td>

                                <td valign="top" class="name" width="11%">
                                    <label for="membershipPlace"><b><g:message code="individual.membershipPlace.label" default="Membership Place" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'membershipPlace', 'errors')}" width="6%">
                                    <g:textField name="membershipPlace" value="${individualInstance?.membershipPlace}" tabindex="10"/>
                                </td>
                                
                                <td>&nbsp;</td>
                            </tr>
                            
                        </tbody>
                        </table>
                        </div>


		<div id="Address">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr>
                                <td valign="top"  width="9%">
                                    <label for="acategory"><b><g:message code="address.category.label" default="Category" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'category', 'errors')}" >
									<g:select name="acategory" from="${['Correspondence','Permanent','Company','Location','Other']}" value="${addressInstance?.category}" tabindex="16"/>
                                </td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td valign="top"  width="9%">
                                    <label for="addressLine1"><b><g:message code="address.addressLine1.label" default="Address Line1" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'addressLine1', 'errors')}" width="10%">
                                    <g:textField name="addressLine1" maxlength="255" value="${addressInstance?.addressLine1}" size="50" tabindex="17"/>
                                </td>
                                <td valign="top"  width="9%">
                                    <label for="addressLine2"><b><g:message code="address.addressLine2.label" default="Address Line2" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'addressLine2', 'errors')}"  width="10%">
                                    <g:textField name="addressLine2" maxlength="100" value="${addressInstance?.addressLine2}" size="50" tabindex="18"/>
                                </td>
                                <td valign="top" width="9%">
                                    <label for="addressLine3"><b><g:message code="address.addressLine3.label" default="Address Line3" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'addressLine3', 'errors')}" width="10%">
                                    <g:textField name="addressLine3" maxlength="100" value="${addressInstance?.addressLine3}" size="50" tabindex="19"/>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" width="5%">
                                    <label for="city"><b><g:message code="address.city.label" default="City" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'city', 'errors')}" width="10%">
                                    <g:select name="city.id" from="${ics.City.list(sort:'name')}" optionKey="id" value="${addressInstance?.city?.id}" value="${ics.City.findByName('Pune')?.id}" tabindex="20"/>
                                </td>
                                <td valign="top" width="5%">
                                    <label for="state"><b><g:message code="address.state.label" default="State" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'state', 'errors')}" width="10%">
                                    <g:select name="state.id" from="${ics.State.list(sort:'name')}" optionKey="id" value="${addressInstance?.state?.id}"  value="${ics.State.findByName('Maharashtra')?.id}" tabindex="21"/>
                                </td>                                
                                <td valign="top" width="5%">
                                    <label for="country"><b><g:message code="address.country.label" default="Country" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'country', 'errors')}" width="10%">
                                    <g:select name="country.id" from="${ics.Country.list(sort:'name')}" optionKey="id" value="${addressInstance?.country?.id}" value="${ics.Country.findByName('India')?.id}" tabindex="22"/>
                                </td>
                            </tr>
                        
                            <tr>
                                <td valign="top" width="5%">
                                    <label for="pincode"><b><g:message code="address.pincode.label" default="Pincode" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'pincode', 'errors')}"  colspan="5">
                                    <g:textField name="pincode" value="${addressInstance?.pincode}" tabindex="23"/>
                                </td>                         	

                            </tr>

                        
                        </tbody>
					</table>
					<table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr>
                                <td valign="top"  width="9%">
                                    <label for="acategory"><b><g:message code="address.category.label" default="Category" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'category', 'errors')}" >
									<g:select name="c_acategory" from="${['Correspondence','Permanent','Company','Location','Other']}" value="${addressInstance?.category}"  value="Company" tabindex="24"/>
                                </td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td valign="top"  width="9%">
                                    <label for="addressLine1"><b><g:message code="address.addressLine1.label" default="Address Line1" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'addressLine1', 'errors')}" width="10%">
                                    <g:textField name="c_addressLine1" maxlength="255" value="${addressInstance?.addressLine1}" size="50" tabindex="25"/>
                                </td>
                                <td valign="top"  width="9%">
                                    <label for="addressLine2"><b><g:message code="address.addressLine2.label" default="Address Line2" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'addressLine2', 'errors')}"  width="10%">
                                    <g:textField name="c_addressLine2" maxlength="100" value="${addressInstance?.addressLine2}" size="50" tabindex="26"/>
                                </td>
                                <td valign="top" width="9%">
                                    <label for="addressLine3"><b><g:message code="address.addressLine3.label" default="Address Line3" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'addressLine3', 'errors')}" width="10%">
                                    <g:textField name="c_addressLine3" maxlength="100" value="${addressInstance?.addressLine3}" size="50" tabindex="27"/>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" width="5%">
                                    <label for="city"><b><g:message code="address.city.label" default="City" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'city', 'errors')}" width="10%">
                                    <g:select name="c_city.id" from="${ics.City.list(sort:'name')}" optionKey="id" value="${addressInstance?.city?.id}" value="${ics.City.findByName('Pune')?.id}" tabindex="28"/>
                                </td>
                                <td valign="top" width="5%">
                                    <label for="state"><b><g:message code="address.state.label" default="State" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'state', 'errors')}" width="10%">
                                    <g:select name="c_state.id" from="${ics.State.list(sort:'name')}" optionKey="id" value="${addressInstance?.state?.id}"  value="${ics.State.findByName('Maharashtra')?.id}" tabindex="29"/>
                                </td>                                
                                <td valign="top" width="5%">
                                    <label for="country"><b><g:message code="address.country.label" default="Country" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'country', 'errors')}" width="10%">
                                    <g:select name="c_country.id" from="${ics.Country.list(sort:'name')}" optionKey="id" value="${addressInstance?.country?.id}" value="${ics.Country.findByName('India')?.id}" tabindex="30"/>
                                </td>
                            </tr>
                        
                            <tr>
                                <td valign="top" width="5%">
                                    <label for="pincode"><b><g:message code="address.pincode.label" default="Pincode" /></b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'pincode', 'errors')}"  colspan="5">
                                    <g:textField name="c_pincode" value="${addressInstance?.pincode}" tabindex="31"/>
                                </td>                         	

                            </tr>

                        
                        </tbody>                        
                    </table>
                   </div>

					<div id="Contact">
						<table border="0" cellspacing="0" cellpadding="0">
						<tbody bgcolor="lavender">


					   <tr>
							<td valign="top" width="8%">
							   <label for="homePhone"><b><g:message code="voiceContact.homePhone.label" default="Home Phone" /></b></label>
							 </td>
							 <td valign="top" class="value ${hasErrors(bean: voiceContactInstance, field: 'homePhone', 'errors')}" width="10%">
							   <g:textField name="homePhone" maxlength="255" value="${voiceContactInstance?.homePhone}" tabindex="32"/>
							 </td>

						   <td valign="top" width="8%">
							  <label for="cellPhone"><b><g:message code="voiceContact.cellPhone.label" default="Cell Phone" /></b></label>
						   </td>
						   <td valign="top" class="value ${hasErrors(bean: voiceContactInstance, field: 'cellPhone', 'errors')}" width="10%">
							  <g:textField name="cellPhone" maxlength="255" value="${voiceContactInstance?.cellPhone}" tabindex="33"/>
						   </td>

						   <td valign="top" width="10%">
							  <label for="companyPhone"><b><g:message code="voiceContact.companyPhone.label" default="Company Phone" /></b></label>
						   </td>
						   <td valign="top" class="value ${hasErrors(bean: voiceContactInstance, field: 'companyPhone', 'errors')}" width="10%">
							  <g:textField name="companyPhone" maxlength="255" value="${voiceContactInstance?.companyPhone}" tabindex="34"/>
						   </td>
						   <td>
						   &nbsp;
						   </td>
						   <td>
						   &nbsp;
						   </td>
					   </tr>
					   <tr>
							<td valign="top" class="name" width="8%">
							  <label for="emailContact"><b>Personal Email</b></label>
							</td>
							<td valign="top" class="value width="10%">
								<g:textField name="personalEmail" value="${emailContactInstance?.emailAddress}" tabindex="35"/>
							</td>
							<td valign="top" class="name" width="8%">
							  <label for="emailContact"><b>Official Email</b></label>
							</td>
							<td valign="top" class="value width="10%">
								<g:textField name="officialEmail" value="${emailContactInstance?.emailAddress}" tabindex="36"/>
							</td>
							<td valign="top" class="name" width="8%">
							  <label for="emailContact"><b>Other Email</b></label>
							</td>
							<td valign="top" class="value width="10%">
								<g:textField name="otherEmail" value="${emailContactInstance?.emailAddress}" tabindex="37"/>
							</td>


						   <td>
						   &nbsp;
						   </td>
						   <td>
						   &nbsp;
						   </td>

						</tr>	               
					   </tr>

					</tbody>
				</table>
		    </div>
                
			<div id="ProfessionalInformation">
				<table border="0" cellspacing="0" cellpadding="0">
					<tbody bgcolor="lavender">
						<tr>
							<td valign="top">
								<label for="profession"><b><g:message code="individual.profession.label" default="Profession" /></b></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'profession', 'errors')}" >
								<g:select name="profession" from="${ics.Profession.list(sort:'name')}" value="${individualInstance?.profession}" noSelection="['':'-Choose Profession-']" tabindex="38"/>
							</td>

							<td valign="top" >
								<label for="designation"><b><g:message code="individual.designation.label" default="Designation" /></b></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'designation', 'errors')}">
								<g:textField name="designation" value="${individualInstance?.designation}" tabindex="39"/>
							</td>

							<td valign="top" >
								<label for="company"><b>Company Name</b></label>
							</td>
							<td valign="top">
								<g:textField name="companyName" value="${individualInstance?.companyName}" tabindex="39"/>
							</td>

							<td valign="top" >
								<label for="edu"><b>Education</b></label>
							</td>
							<td valign="top">
								<g:textField name="education" value="${individualInstance?.education}" tabindex="39"/>
							</td>

							</tr>
							<tr>
							<td valign="top">
								<label for="businessRemarks"><b><g:message code="individual.businessRemarks.label" default="Business Remarks" /></b></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'businessRemarks', 'errors')}" >
								<g:textArea name="businessRemarks" value="${individualInstance?.businessRemarks}" tabindex="40"/>
							</td>
							<td/>
							<td/>
							<td/>
							<td/>
							<td/>
							<td/>
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
							<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'communicationsPreference', 'errors')}" width="6%">
								<!--<g:textField name="communicationsPreference" value="${individualInstance?.communicationsPreference}" />-->
								<g:select name="communicationsPreference" from="${['RESIDENCE','OFFICE']}" value="${individualInstance?.communicationsPreference}" noSelection="['':'-Choose-']" tabindex="41"/>
							</td>

							<td valign="top" width="7%">
								<label for="languagePreference"><b><g:message code="individual.languagePreference.label" default="Language Preference" /></b></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'languagePreference', 'errors')}" width="6%">
								<!--<g:textField name="languagePreference" value="${individualInstance?.languagePreference}" />-->
								<g:select name="languagePreference" from="${['ENGLISH','HINDI','MARATHI']}" value="${individualInstance?.languagePreference}" noSelection="['':'-Choose-']" tabindex="42"/>
							</td>

							<td valign="top" width="12%">
								<label for="literatureLanguagePreference"><b><g:message code="individual.literatureLanguagePreference.label" default="Literature Language Preference" /></b></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'literatureLanguagePreference', 'errors')}" width="6%">
								<!--<g:textField name="literatureLanguagePreference" value="${individualInstance?.literatureLanguagePreference}" />-->
								<g:select name="literatureLanguagePreference" from="${['ENGLISH','HINDI','MARATHI']}" value="${individualInstance?.literatureLanguagePreference}" noSelection="['':'-Choose-']" tabindex="43"/>
							</td>
							<td>&nbsp;
							</td>


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
							<td valign="top">
								<label for="initiatedName"><b><g:message code="individual.initiatedName.label" default="Initiated Name" /></b></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'initiatedName', 'errors')}">
								<g:textField name="initiatedName" size="30" maxlength="127" value="${individualInstance?.initiatedName}" tabindex="44"/>
							</td>
							<td valign="top" ><b>
								Guru</b>
							</td>
							<td valign="top" >
							   <div style="width: 200px">
								<gui:autoComplete
									id="acGuru"
									width="100px"
									controller="individual"
									action="allGurusAsJSON"
									useShadow="true"
									queryDelay="0.5" minQueryLength='3'
									tabindex="45"
								/>
							</div>
							</td>

							<td valign="top" ><b>
								Councellor</b>
							</td>
							<td valign="top" >
					        <sec:ifNotGranted roles="ROLE_COUNSELLOR">
							   <div style="width: 200px">
								<gui:autoComplete
									id="acCouncellor"
									width="100px"
									controller="individual"
									action="allCouncellorsAsJSON"
									useShadow="true"
									queryDelay="0.5" minQueryLength='3'
									tabindex="46"
								/>
							</div>
						</sec:ifNotGranted>
						<sec:ifAllGranted roles="ROLE_COUNSELLOR">
							${session.individualname}
						</sec:ifAllGranted>
							</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
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

			<div id="Family">
				<table cellspacing="0" cellpadding="0" border="0">
					<tbody bgcolor="lavender">

					   <g:each in="${0..<7}"> 

					   <tr>
							<td valign="top" width="3%">
								<label for="title"><b><g:message code="individual.title.label" default="Title" /></b></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'title', 'errors')}" width="10%">
								<g:select name="title${it}.id" from="${ics.Title.list()}" optionKey="id" value="" noSelection="['': '--Select--']" />

							</td>
							<td valign="top" width="8%">
								<label for="legalName"><b><g:message code="individual.legalName.label" default="Legal Name" /></b></label>*
							</td>
							<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'legalName', 'errors')}" width="10%">
								<g:textField name="legalName${it}" maxlength="127" value="" />

							</td>
							<td valign="top" width="9%">
								<label for="initiatedName"><b><g:message code="individual.initiatedName.label" default="Initiated Name" /></b></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'initiatedName', 'errors')}" width="10%">
								<g:textField name="initiatedName${it}" maxlength="127" value="" />

							</td>
							<td valign="top" width="5%">
								<label for="isMale"><b><g:message code="individual.isMale.label" default="Is Male" /></b></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'isMale', 'errors')}" width="2%">
								<g:checkBox name="isMale${it}"  checked="false"/>

							</td>
							<td valign="top" width="5%">
								<label for="nvccRelation"><b><g:message code="individual.nvccRelation.label" default="Relation" /></b></label>*
							</td>
							<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'nvccRelation', 'errors')}" width="10%">
							   <div style="width: 100px">
								   <g:hiddenField name="relation${it}.id" value="" />
									<gui:autoComplete
										id="acRelation${it}"
										width="91px"
										controller="relation"
										action="findRelationsAsJSON"
										useShadow="true"
										queryDelay="0.5" minQueryLength='3'
										forceSelection="false"
									/>
								</div>
							</td>
							<td>&nbsp;
							</td>


						</tr>
					   </g:each>

					</tbody>
				</table>
			</div>
			
			
			<div id="KCTraining">
				<table border="0" cellspacing="0" cellpadding="0">
					<tbody bgcolor="lavender">
						<tr>
							<td valign="top">
								<label for="courses"><b>Courses</b></label>
							</td>
							<td valign="top">
            						<sec:ifAllGranted roles="ROLE_VOICE_ADMIN">
							    <g:select size="30" name="courses" from="${ics.Course.findAllByCategory('Voice',[sort:'name'])}" optionKey="id"  noSelection="['':'-Choose courses/workshops-']" multiple="true"/>
							</sec:ifAllGranted>
            						<sec:ifAllGranted roles="ROLE_COUNSELLOR_GROUP">
							    <g:select size="30" name="courses" from="${ics.Course.findAllByCategory('Temple',[sort:'name'])}" optionKey="id"  noSelection="['':'-Choose Programs-']" multiple="true"/>
							</sec:ifAllGranted>
            						<sec:ifNotGranted roles="ROLE_VOICE_ADMIN,ROLE_COUNSELLOR_GROUP">
							    <g:select size="30" name="courses" from="${ics.Course.list([sort:'name'])}" optionKey="id"  noSelection="['':'-Choose courses/workshops-']" multiple="true"/>
							</sec:ifNotGranted>
							</td>                                

							<td valign="top">
								<label for="books"><b>SP Books Read</b></label>
							</td>
							<td valign="top">
							    <g:select size="30" name="books" from="${ics.Book.findAllByAuthor('Srila Prabhupada',[sort:'name'])}" optionKey="id"  noSelection="['':'-Choose books read-']" multiple="true"/>
							</td>                                
						</tr>
					</tbody>
				</table>

			</div>

			<div id="KCRoles">
				<table border="0" cellspacing="0" cellpadding="0">
					<tbody bgcolor="lavender">
						<tr>
							<td valign="top">
								<label for="roles"><b>Roles</b></label>
							</td>
							<td valign="top">
							    <g:select size="30" name="roles" from="${ics.Role.findAllByCategory('Voice',[sort:'name'])}" optionKey="id"  noSelection="['':'-Choose roles-']" multiple="true"/>
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
							    <g:select size="30" name="servicesrendered" from="${ics.Seva.findAll("from Seva as s order by s.type, s.name")}" optionKey="id"  noSelection="['':'-Choose Services Rendered-']" multiple="true"/>
							</td>                                

							<td valign="top">
								<label for="skills"><b>Services Interested In</b></label>
							</td>
							<td valign="top">
							    <g:select size="30" name="servicesinterested" from="${ics.Seva.findAll("from Seva as s order by s.type, s.name")}" optionKey="id"  noSelection="['':'-Choose Services Interested In-']" multiple="true"/>
							</td>                                
						</tr>
					</tbody>
				</table>

			</div>
			
		</div>

                

                 
				<div class="buttons">
					<span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
				</div>
            </g:form>
        </div>

        <script language="javascript"> 
        function tabOrders()
        {
        	
        	//alert('hi');
        	return true;
        }
        
	    function toggleSpiritualDetails() {
		var ele = document.getElementById("spiritualinfo");
		if (ele.style.display == "block") 
			{
				ele.style.display = "none";
			}
		else
			ele.style.display = "block";
	    } 
	    function togglePref() {
		var ele = document.getElementById("div-pref");
		if (ele.style.display == "block") 
			{
				ele.style.display = "none";
			}
		else
			ele.style.display = "block";
	    } 
	    function toggleBusiness() {
		var ele = document.getElementById("div-business");
		if (ele.style.display == "block") 
			{
				ele.style.display = "none";
			}
		else
			ele.style.display = "block";
	    } 
	    function toggleAddress() {
		var ele = document.getElementById("div-address");
		if (ele.style.display == "block") 
			{
				ele.style.display = "none";
			}
		else
			ele.style.display = "block";
	    }
	    function toggleContact() {
			var ele = document.getElementById("div-contact");
			if (ele.style.display == "block") 
				{
					ele.style.display = "none";
				}
			else
				ele.style.display = "block";
	    }
	    function toggleFamily() {
			var ele = document.getElementById("div-family");
			if (ele.style.display == "block") 
				{
					ele.style.display = "none";
				}
			else
				ele.style.display = "block";
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

		function validate() {   
			if (document.getElementById("legalName").value=='')
			{
				alert("Please provide Legal Name!!");
				document.getElementById('legalName').focus();
				return false;
			}
			return true;
		}


	 </script>

    </body>
</html>
