<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="ics.Individual"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>Profile</title>
<r:require module="grid" />
<r:require module="dateTimePicker" />
<link rel="stylesheet" type="text/css"
	href="${resource(dir: 'css', file: 'faary.css')}" />

</head>
<body>

        <g:javascript src="chosen.jquery.js" />
	<script type="text/javascript" language="javascript">
		$(document).ready(function() {
			
			
			$("#tabs").tabs();
			

			$("#dob").datepicker({
				yearRange : "-100:+0",
				changeMonth : true,
				changeYear : true,
				dateFormat : 'dd-mm-yy'
			});
			$("#introductionDate").datepicker({
				yearRange : "-100:+0",
				changeMonth : true,
				changeYear : true,
				dateFormat : 'dd-mm-yy'
			});
			$("#sixteenRoundsDate").datepicker({
				yearRange : "-100:+0",
				changeMonth : true,
				changeYear : true,
				dateFormat : 'dd-mm-yy'
			});
			$("#voiceDate").datepicker({
				yearRange : "-100:+0",
				changeMonth : true,
				changeYear : true,
				dateFormat : 'dd-mm-yy'
			});
			$("#firstInitiation").datepicker({
				yearRange : "-100:+0",
				changeMonth : true,
				changeYear : true,
				dateFormat : 'dd-mm-yy'
			});

			$("#secondInitiation").datepicker({
				yearRange : "-100:+0",
				changeMonth : true,
				changeYear : true,
				dateFormat : 'dd-mm-yy'
			});

			$("#joinAshram").datepicker({
				yearRange : "-100:+0",
				changeMonth : true,
				changeYear : true,
				dateFormat : 'dd-mm-yy'
			});
                        $(".chzn-select").chosen();

			$("#ImageUploadDialog").dialog({
				autoOpen : false,
				modal : true,
				buttons : {
					Ok : function() {
						$(this).dialog("close");
					}
				}
			});
			$("#photoLink").children().click(function() {
				$("#ImageUploadDialog").dialog("open");
			});
		
		
		});
		$(function() {
				$( "#guruAC" ).autocomplete({
					source: "${createLink(controller:'individual',action:'allGurusAsJSON_JQ')}",//todo take care of data from other departments
					minLength: 0,
					  select: function(event, ui) { // event handler when user selects a company from the list.
					   $("#guruid").val(ui.item.id); // update the hidden field.
					  }

				});
	});
	$(function() {
					$( "#indcounc" ).autocomplete({
						source: "${createLink(controller:'individual',action:'allIndividualsWithNoLoginIdAsJSON_JQ')}",//todo take care of data from other departments
						minLength: 0,
						  select: function(event, ui) { // event handler when user selects a company from the list.
						   $("#lid").val(ui.item.id); // update the hidden field.
						  }
	
					});
	});
	 $(function() {
	      $( "#dialog" ).dialog({
	        autoOpen: false,
	                
	      });
	   
	      $( "#img" ).click(function() {
	        $( "#dialog" ).dialog( "open" );
	      });
        });
	</script>
	




	<div class="nav" role="navigation">
		<ul>
			<span class="menuButton"><a class="home"
				href="${createLink(uri: '/')}"><g:message
						code="default.home.label" /></a></span>
			<sec:ifAnyGranted
				roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_COMMUNICATION_COORDINATOR,ROLE_REGISTRATION_COORDINATOR,ROLE_EVENTMANAGER,ROLE_EVENTADMIN,ROLE_NVCC_ADMIN">
				<span class="menuButton"><g:link class="list" action="list">
					List</g:link></span>
			</sec:ifAnyGranted>
		</ul>
	</div>

	<div id="dialog" title="Image" gridName="" entityName="">
		<fieldset>
			  <legend><b>Image Upload</b></legend>
			  <g:form action="upload_avatar" method="post" enctype="multipart/form-data">
			    <g:hiddenField name="id" value="${individualInstance?.id}" />
			    <g:hiddenField name="profile" value="${true}" />
			    <label for="avatar"><b>Image (max 100K)</b></b></b></label>
			    <input type="file" name="avatar" id="avatar" />
			    <div style="font-size:0.8em; margin: 1.0em;">
			      For best results, your image should have a width-to-height ratio of 4:5.
			      For example, if your image is 80 pixels wide, it should be 100 pixels high.
			    </div>
			    <input type="submit" class="img" value="Upload" />
			  </g:form>
			</fieldset>

	</div>
	
	<g:form method="post">
		<g:hiddenField name="indid" value="${individualInstance?.id}" />

		<div class="">



			<div class="iform">


				<ul>

					<table>
						<tr class="prop">
							<td colspan=5><div class="caption_title">Personal
									Information (Id:${individualInstance?.id} IcsId:${individualInstance?.icsid})</div></td>
						</tr>
					</table>
					</table>
					<table>
						<tr>
							<td><li><label for="Name">Legal Name</label> <g:if
										test="${mode == 'READ'}">
										<g:textField name="legalName"
											value="${individualInstance?.legalName}" class="itext" readonly="true" />									</g:if> <g:elseif test="${mode == 'EDIT'}">
										<g:textField name="legalName"
											value="${individualInstance?.legalName}" class="itext"
											placeholder="Full Name" />
									</g:elseif></li></td>
							<td><li><label for="DOB">DOB</label> <g:if
										test="${mode == 'READ'}">
										<g:textField name="dob"
											value="${individualInstance?.dob?.format('dd-MM-yyyy')}"
											class="itext" readonly="true"/>
									</g:if> <g:elseif test="${mode == 'EDIT'}">
										<g:textField name="dob"
											value="${individualInstance?.dob?.format('dd-MM-yyyy')}"
											class="itext" placeholder="Date of Birth" />
									</g:elseif></li></td>
							<td><li><label for="Gender">Gender</label> <g:if
										test="${mode == 'READ'}">
										<g:textField name="gender"
											value="${individualInstance?.isMale?'MALE':'FEMALE'}"
											class="itext"  readonly="true"/>
                                                                         
									</g:if> <g:elseif test="${mode == 'EDIT'}">
										<g:select name="isMale" from="${['MALE','FEMALE']}"
											value="${individualInstance?.isMale?'MALE':'FEMALE'}"
											class="chzn-select" data-placeholder="I am...." />
									</g:elseif></li></td>
							<td><li><label for="BloodGroup">Blood Group</label> <g:if
										test="${mode == 'READ'}">
									<g:textField name="bloodGroup"
									value="${individualInstance?.bloodGroup}" class="itext"
									readonly="true"/>

								</g:if> <g:elseif test="${mode == 'EDIT'}">
										<g:textField name="bloodGroup"
											value="${individualInstance?.bloodGroup}" class="itext"
											placeholder="Blood Group" />
									</g:elseif></li></td>
							<td rowspan="2" id="photoLink" width="50%"><img
								class="avatar"
								src="${createLink(controller:'individual', action:'avatar_image', id:individualInstance?.id)}" />
								<g:if test="${mode == 'EDIT'}">
										<p>
											<input class="img" type="BUTTON" id="img" value="Image" />
										</p>
								</g:if></td>
						
						</tr>
						<tr>
							<td><li><label for="initiatedName">Initiated Name</label> <g:if
								test="${mode == 'READ'}">
								<g:textField name="initiatedName"
									value="${individualInstance?.initiatedName}" class="itext" readonly="true" />									</g:if> <g:elseif test="${mode == 'EDIT'}">
								<g:textField name="initiatedName"
									value="${individualInstance?.initiatedName}" class="itext"
									placeholder="Initiated Name" />
									</g:elseif></li></td>

						<sec:ifAnyGranted roles="ROLE_VOICE_ADMIN,ROLE_NVCC_ADMIN,ROLE_ADMIN">
							<td><li><label for="remarks">Remarks</label> <g:if
								test="${mode == 'READ'}">
								<g:textField name="remarks"
									value="${individualInstance?.remarks}" class="itext" readonly="true" />									</g:if> <g:elseif test="${mode == 'EDIT'}">
								<g:textField name="remarks"
									value="${individualInstance?.remarks}" class="itext"
									placeholder="Any remarks?" />
									</g:elseif></li></td>
						</sec:ifAnyGranted>
						</tr>
						
					</table>
				</ul>

				<ul>

					<table>
						<tr class="prop">
							<td colspan=5><div class="caption_title">Professional
									Information</div></td>
						</tr>
					</table>
					<table>
						<tr>
							<td><li><label for="education">Education</label> <g:if
										test="${mode == 'READ'}">
										<g:textField  name="education"
											value="${individualInstance?.education}" class="itext" readonly="true"/>
									</g:if> <g:elseif test="${mode == 'EDIT'}">
										<g:textField placeholder="Education" name="education"
											value="${individualInstance?.education}" class="itext" />
									</g:elseif></li></td>
							<td><li><label for="profession">Profession</label> <g:if
										test="${mode == 'READ'}">
										<g:textField  name="profession"
											value="${individualInstance?.profession}" class="itext" readonly="true" />
									</g:if> <g:elseif test="${mode == 'EDIT'}">
										<g:textField placeholder="Profession" name="profession"
											value="${individualInstance?.profession}" class="itext" />
									</g:elseif></li></td>
							<td><li><label for="designation">Designation</label> <g:if
										test="${mode == 'READ'}">
										<g:textField  name="designation"
											value="${individualInstance?.designation}" class="itext" readonly="true"/>
									</g:if> <g:elseif test="${mode == 'EDIT'}">
										<g:textField placeholder="Designation" name="designation"
											value="${individualInstance?.designation}" class="itext" />
									</g:elseif></li></td>
							<td><li><label for="companyName">Company Name</label> <g:if
										test="${mode == 'READ'}">
										<g:textField  name="companyName"
											value="${individualInstance?.companyName}" class="itext" readonly="true" />
									</g:if> <g:elseif test="${mode == 'EDIT'}">
										<g:textField placeholder="Company Name" name="companyName"
											value="${individualInstance?.companyName}" class="itext" />
									</g:elseif></li></td>
						</tr>

					</table>
				</ul>

				<ul>
					<table>
						<tr class="prop">
							<td colspan=5><div class="caption_title">Devotional
									Information</div></td>
						</tr>
					</table>
					<table>
						<tr>
							<td><li><label for="introductionDate">Year of
										Introduction</label> <g:if test="${mode == 'READ'}">
										<g:textField 
										name="introductionDate"
										value="${individualInstance?.introductionDate?.format('dd-MM-yyyy')}"
											class="itext" readonly="true"/>
									</g:if> <g:elseif test="${mode == 'EDIT'}">
										<g:textField placeholder="Year of Introduction"
											name="introductionDate"
											value="${individualInstance?.introductionDate?.format('dd-MM-yyyy')}"
											class="itext" />
									</g:elseif></li></td>
							<td><li><label for="sixteenRoundsDate">Chanting
										16 Rounds since</label> <g:if test="${mode == 'READ'}">
										<g:textField 
										name="sixteenRoundsDate"
										value="${individualInstance?.sixteenRoundsDate?.format('dd-MM-yyyy')}"
											class="itext" readonly="true" />
									</g:if> <g:elseif test="${mode == 'EDIT'}">
										<g:textField placeholder="Chanting 16 Rounds since"
											name="sixteenRoundsDate"
											value="${individualInstance?.sixteenRoundsDate?.format('dd-MM-yyyy')}"
											class="itext" />
									</g:elseif></li></td>
																				
						<td><li><label for="numRounds">Currently
																Chanting</label> <g:if test="${mode == 'READ'}">
																<g:textField  name="numRounds"
																value="${individualInstance?.numRounds}" class="itext" readonly="true" />
															</g:if> <g:elseif test="${mode == 'EDIT'}">
																<g:textField placeholder="Currently Chanting" name="numRounds"
																value="${individualInstance?.numRounds}" class="itext" />
																		</g:elseif></li></td>
						
						<td>
														<li><label for="currentCounselor">Current
																Councellor</label> <g:if test="${mode == 'READ' || mode == 'EDIT'}">
																<g:each
																	in="${ics.Relationship.findAllWhere(relation:ics.Relation.findByName('Councellee of'),individual1:individualInstance,status:'ACTIVE',[sort: "individual2.legalName"])}"
																	var="r">
																	<li><g:link controller="individual" action="show"
																			id="${r.individual2?.id}" params="[profile:true]">
																			${r.individual2}
																		</g:link></li>
																</g:each>
															</g:if> 
															</li>
													</td>

						
						
						                                                                   
						</tr>
						
						
						
						<tr>
										
										<td><li><label for="firstInitiationStatus">First
										Initiation Status</label> <g:if test="${mode == 'READ'}">
										<g:textField  name="firstInitiationStatus"
										value="${individualInstance?.firstInitiationStatus}" class="itext" readonly="true"/>
										
									</g:if> <g:elseif test="${mode == 'EDIT'}">
										<g:select name="firstInitiationStatus"
											from="${['Not Decided','Aspiring From','Initiated by']}"
											value="${individualInstance?.firstInitiationStatus}"
											class="chzn-select" />
									</g:elseif></li></td>

						<td>
														<li><label for="firstInitiation">Date of First
																Initiation</label> <g:if test="${mode == 'READ'}">
																<g:textField 
																name="firstInitiation"
																value="${individualInstance?.firstInitiation?.format('dd-MM-yyyy')}"
																	class="itext" readonly="true"/>
															</g:if> <g:elseif test="${mode == 'EDIT'}">
																<g:textField placeholder="Date of First Initiation"
																	name="firstInitiation"
																	value="${individualInstance?.firstInitiation?.format('dd-MM-yyyy')}"
																	class="itext" />
															</g:elseif></li>
							</td>
						<td><li><label for="secondInitiation">Date of Brahmin Initiation</label> <g:if test="${mode == 'READ'}">
																<g:textField 
																name="secondInitiation"
																value="${individualInstance?.secondInitiation?.format('dd-MM-yyyy')}"
																	class="itext" readonly="true"/>
															</g:if> <g:elseif test="${mode == 'EDIT'}">
																<g:textField placeholder="Date of Brahmin Initiation"
																	name="secondInitiation"
																	value="${individualInstance?.secondInitiation?.format('dd-MM-yyyy')}"
																	class="itext" />
															</g:elseif></li></td>
							<td><li><label for="Guru">Spiritual Master</label> <g:if
										test="${mode == 'READ'}">
										<g:set var="rel"
											value="${ics.Relation.findByName('Disciple of')}" />
										<g:set var="gururel"
											value="${ics.Relationship.findWhere(individual1:individualInstance,relation:rel,status:'ACTIVE')}" />
										<g:link controller="individual" action="show"
											id="${gururel?.individual2?.id}" params="[profile:true]">
											${gururel?.individual2?.sanyasName?:gururel?.individual2?.initiatedName}
										</g:link>
									</g:if> <g:elseif test="${mode == 'EDIT'}">
										<g:set var="rel"
											value="${ics.Relation.findByName('Disciple of')}" />
										<g:set var="gururel"
											value="${ics.Relationship.findWhere(individual1:individualInstance,relation:rel,status:'ACTIVE')}" />
										<g:hiddenField name="guruid" value=""/>
                                                                                <g:hiddenField name="guruname" value=""/>
										<g:textField id="guruAC" placeholder="Spiritual Master" name="Guru"
											value="${gururel?.individual2}" class="itext" />
									</g:elseif></li></td>


						</tr>
						<tr>
							
														<td><li><label for="ashram">Ashram</label> <g:if
																test="${mode == 'READ'}">
																<g:textField 
																name="ashram"
																value="${individualInstance?.ashram}"
																	class="itext" readonly="true"/>
															</g:if> <g:elseif test="${mode == 'EDIT'}">
																<g:select name="ashram"
																	from="${['Brahmachari','Grahastha','Vanaprastha','Sanyasi']}"
																	value="${individualInstance?.ashram}" class="chzn-select" 
																	noSelection="['':'-Choose-']"/>
															</g:elseif></li></td>

													<td><li><label for="joinAshram">Year of joining
										Ashram</label> <g:if test="${mode == 'READ'}">
										<g:textField 
										name="joinAshram"
										value="${individualInstance?.joinAshram?.format('yyyy')}"
											class="itext" readonly="true" />
									</g:if> <g:elseif test="${mode == 'EDIT'}">
										<g:textField placeholder="Year of joining Ashram"
											name="joinAshram"
											value="${individualInstance?.joinAshram?.format('yyyy')}"
											class="itext" />
									</g:elseif></li></td>
						</tr>
					</table>


				</ul>



			</div>


			<g:if test="${mode == 'EDIT'}">
				<div class="buttons">
					<g:hiddenField name="profile" value="true" />
					<span class="button"><g:actionSubmit class="save"
							action="update"
							value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
				</div>
			</g:if>
			<g:if test="${mode == 'READ'}"> <!-- TODO: also check for authority -->
				<div class="buttons">
					<span class="menuButton"><g:link class="img" action="show" params="['id': individualInstance?.id,profile:true,editprofile:true]">Edit</g:link></span>
				</div>
			</g:if>
	</g:form>

	<div id="tabs">
		<ul>
			<li><a href="${g.createLink(controller:'individual',action:'contactDetails',params:['individual.id':individualInstance?.id])}">ContactDetails</a></li>
			<li><a href="${g.createLink(controller:'individual',action:'familyMembers',params:['individual.id':individualInstance?.id])}">FamilyMembers</a></li>
			<li><a href="${g.createLink(controller:'individualCentre',action:'indCenList',params:['individual.id':individualInstance?.id])}">Centre</a></li>
			<li><a href="${g.createLink(controller:'individualSeva',action:'indsevaList',params:['individual.id':individualInstance?.id])}">Services</a></li>
			<li><a href="${g.createLink(controller:'individualSkill',action:'indskillList',params:['individual.id':individualInstance?.id])}">Skills</a></li>
			<li><a href="${g.createLink(controller:'individualLanguage',action:'indlangList',params:['individual.id':individualInstance?.id])}">Languages</a></li>
			<li><a href="${g.createLink(controller:'individual',action:'kctDetails',params:['individual.id':individualInstance?.id])}">KC Training</a></li>
			<li><a href="${g.createLink(controller:'individualRole',action:'indroleList',params:['individual.id':individualInstance?.id])}">Roles</a></li>
			<li><a href="${g.createLink(controller:'schemeMember',action:'list',params:['individual.id':individualInstance?.id])}">SchemeMemberships</a></li>
			<li><a href="${g.createLink(controller:'relationship',action:'list',params:['individualid':individualInstance?.id])}">Relationships</a></li>

		</ul>

	</div>
</body>
</html>
