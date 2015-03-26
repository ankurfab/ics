<%@ page import="ics.*" %>
<%@ page import="org.codehaus.groovy.grails.commons.DefaultGrailsDomainClass" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>MB Profile Search</title>
		<r:require module="grid" />
	</head>
	<body>
		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
		</div>

            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>


		<div id="dialogSuggest" title="Suggest">
		</div>            

		<div id='message' class="message" style="display:none;"></div>
	<h1>Match making for ${mbProfile?.candidate}</h1>
		
		%{--<div>
			Matchmaking for?<g:select name="mbprofileid"
				  from="${ics.MbProfile.createCriteria().list{'in'('workflowStatus',['AVAILABLE']) candidate{order('legalName', 'asc')}}}"
                  noSelection="${['null':'Select One...']}"
                  optionKey="id" optionValue="candidate"
            />
		</div>--}%

<g:set var="mbclass" value="${new DefaultGrailsDomainClass(ics.MbProfile.class)}" />
<g:set var="mbproperties" value="${mbclass.persistentProperties}" />
<g:form name="expectationsForm" id="expectationsForm">
    <g:hiddenField name="mbProfileId" value="${mbProfile?.id}"/>
    <g:hiddenField name="mbprofileid" value="${mbProfile?.id}"/>
	%{--<fieldset>
            <table id="genericSearchTab">
                <tr>
                    <td>Attribute</td>
                    <td>
                        <g:select name="attrName"
                                  from="${mbproperties*.name}"
                                  value=""/>
                    </td>
                    <td>Value</td>
                    <td>
			<g:textField name="attrValue" value="" placeholder="Please enter value to search"/>
		    </td>
		  </tr>
		</table>
	</fieldset>--}%

	<!--Ignore Expectations:<g:checkBox name="showAll" value="${false}" />-->
	<!--Flexibile on all expectations:<g:checkBox name="checkboxAllFlexible" value="${false}" />-->
	<!--Flexibile on no expectations:<g:checkBox name="checkboxNoneFlexible" value="${false}" />-->
	
	Flexibile: <g:radioGroup name="radioFlex" labels="['None','All']" values="['NONE','ALL']" >
	<span>${it.radio} ${it.label}</span>
	</g:radioGroup>

	<fieldset>
            <table id="searchExpectations">
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="prefChanting">Preferably Chanting:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:select name="prefChanting"
                                  from="${['Any','Not Chanting', 'Sometimes', 'Upto 4 rounds', 'Between 5 to 8 rounds', 'Between 9 to 12 rounds', 'Between 13 to 15 rounds', '16 rounds']}"
                                  value="${mbProfile?.prefChanting}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleChanting">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleChanting" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleChanting}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                    <td valign="top" class="name">
                        <label for="prefSpMaster">Preferred Aspiring Spiritual Master:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:textField name="prefSpMaster" placeholder="Enter Name of Preferred aspiring Spiritual Master of Partner"
                                     maxlength="40" value="${mbProfile?.prefSpMaster}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleSpMaster">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleSpMaster" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleSpMaster}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="prefCentre">Preferred Centre:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:textField name="prefCentre" placeholder="Enter ISKCON Centre Name here" value="${mbProfile?.prefCentre}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleCentre">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name='flexibleCentre' labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleCentre}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                    <td valign="top" class="name">
                        <label for="prefNationality">Preferred Nationality:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:select name="prefNationality" from="${['Indian', 'Non-Indian']}" value="${mbProfile?.prefNationality}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleNationality">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleNationality" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleNationality}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="prefOrigin">Preferred State of Birth</label>
                    </td>
                    <td valign="top" class="value">
                        <g:select name="prefOrigin" multiple="multiple"
                                  from="${['Andaman&Nicobar Islands', 'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chandigarh', 'Chhattisgarh', 'Dadara and Nagar Haveli', 'Daman and Diu', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jammu and Kashmir', 'Jharkhand', 'Karnataka', 'Kerala', 'Lakshadweep', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'NCT of Delhi', 'Orissa', 'Pondicherry', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Foreign State']}"
                                  value="${mbProfile?.prefOrigin}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleOrigin">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleOrigin" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleOrigin}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                    <td valign="top" class="name">
                        <label for="prefVarna">Preferred  Varna:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:select name="prefVarna" from="${['Brahmin', 'Kshatriya', 'Vaishya', 'Sudra','Not Known']}" multiple="multiple"
                                  value="${mbProfile?.prefVarna}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleVarna">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleVarna" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleVarna}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="prefCategory">Preferred Category:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:select name="prefCategory"
                                  from="${['Open','Other Backward Class','Backward Class','Scheduled Caste','Scheduled Tribe','Nomadic Tribes']}"
                                  value="${mbProfile?.prefCategory}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleCategory">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleCategory" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleCategory}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                    <td valign="top" class="name">
                        <label for="prefCaste">Preferred Caste:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:textField name="prefCaste" placeholder="Enter preferred Caste here" value="${mbProfile?.prefCaste}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleCaste">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleCaste" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleCaste}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="prefSubCaste">Preferred Sub-Caste:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:textField name="prefSubCaste" placeholder="Enter preferred Sub Caste" value="${mbProfile?.prefsubCaste}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleSubcaste">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleSubcaste" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleSubcaste}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                    <td valign="top" class="name">
                        <label for="prefeducationCategory">Preferred Education Category:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:select name="prefeducationCategory"
                                  from="${['SSC(or equivalent)&above', 'HSC(or equivalent)&above', 'Diploma &above', 'Graduate &above', 'Post Graduate&above', 'Doctorate']}"
                                  value="${mbProfile?.prefeducationCategory}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleEducationCat">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleEducationCat" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleEducationCat}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="prefCandIncome">Preferred Candidate Income:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:select name="prefCandIncome"
                                  from="${['Receiving Stipend', 'Above 1 lakh', 'Above 2 lakhs', 'Above 3 lakhs', 'Above 4 lakhs', 'Above 5 lakhs', 'Above 6 lakhs', 'Above 7 lakhs', 'Above 8 lakhs', 'Above 9 lakhs', 'Above 10 lakhs', 'Above 11 lakhs', 'Above 12 lakhs', 'Above 13 lakhs', 'Above 14 lakhs', 'Above 15 lakhs', 'Above 16 lakhs']}"
                                  value="${mbProfile?.prefCandIncome}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleCandidateIncome">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleCandidateIncome" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleCandidateIncome}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                    <td valign="top" class="name">
                        <label for="prefLangKnown">Preferred Languages Known:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:select name="prefLangKnown" multiple="multiple"
                                  from="${['Assamese', 'Bengali', 'English', 'Gujarati', 'Hindi', 'Kannada', 'Kashmiri', 'Konkani', 'Malayalam', 'Manipuri', 'Marathi', 'Marwari', 'Nepali', 'Oriya', 'Punjabi', 'Sanskrit', 'Sindhi', 'Tamil', 'Telugu', 'Urdu', 'Other Indian languages', 'Foreign languages']}"
                                  value="${mbProfile?.prefLangKnown}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleLangknown">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleLangknown" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleLangknown}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="prefAgeDiff">Preferred Age difference:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:select name="prefAgeDiff"
                                  from="${['More or less same', '6 months', '1 year', '2 years', '3 years', '4 years', '5 years', '6 years', '7 years', '8 years', '9 years', '10 years']}"
                                  value="${mbProfile?.prefAgeDiff}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleAgediff">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleAgediff" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleAgediff}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                    <td valign="top" class="name">
                        <label for="prefHeight">Preferred Height:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:select name="prefHeight"
                                  from="${['less than 5 feet', 'Between 5 to 5.4', 'Between 5.5 to 5.8', 'Between 5.9 to 6.0', 'Above 6 feet']}"
                                  value="${mbProfile?.prefHeight}" optionKey=""/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleHeight">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleHeight" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleHeight}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="prefqualification">Preferred Qualifications:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:textField name="prefqualification" placeholder="Enter your qualification here"
                                     value="${mbProfile?.prefqualification}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleQualifications">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleQualifications" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleQualifications}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                    <td valign="top" class="name">
                        <label for="prefLooks">Preferred Looks:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:textField name="prefLooks" placeholder="Enter any specific looks you prefer"
                                     value="${mbProfile?.prefLooks}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleLooks">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleLooks" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleLooks}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="prefManglik">Manglik preferences:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:select name="prefManglik" from="${['Not Manglik', 'Low', 'Medium', 'High']}" multiple="multiple"
                                  value="${mbProfile?.prefManglik}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleManglik">Flexible :</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleManglik" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleManglik}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                    <g:if test="${mbProfile?.candidate?.isMale}">
                        <td valign="top" class="name">
                            <label for="settleAbroadWorkingWife">Do you want a working wife</label>
                        </td>
                    </g:if>
                    <g:else>
                        <td valign="top" class="name">
                            <label for="settleAbroadWorkingWife">Are you open to Settle Abroad after marriage</label>
                        </td>
                    </g:else>
                    <td valign="top" class="value">
                        <g:select name="settleAbroadWorkingWife" from="${['Flexible','Yes', 'No']}" value="${mbProfile?.settleAbroadWorkingWife}"/>
                    </td>
                </tr>
</g:form>
                <tr>
                    <td>
                        <input id="btnSearch" type="submit" value="Search">
                    </td>
                    <td></td>
                </tr>
            </table>
			</fieldset>

            <div>
			<!-- table tag will hold our grid -->
			<table id="profile_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="profile_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="prospect_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="prospect_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
		

<script type="text/javascript">
  $(document).ready(function () {
      $('#mbprofileid').change(function() {
          $.ajax({
             url:'/ics/mb/search',
             data:{id: $(this).val()}
          });
      });

	 $( "#btnSearch" )
	.button()
	.click(function( event ) {
		event.preventDefault();
                 $("#profile_list").jqGrid('GridUnload');
                 $("#profile_list").jqGrid('GridUnload');
                 jQuery("#profile_list").jqGrid({
                     url:'jq_mbProfile_list',
                     postData: $('#expectationsForm').serialize()+"&sidx=id&sord=asc&rows=10&page=1",
                     datatype: "json",
                     colNames:['Photo','Name','Centre','AssignedTo','Id'],
                     colModel:[
			{
			name: 'photo',
			formatter: function (cellvalue, options, rowObject) {
				    return '<img height="70" width="70" src="${createLink(controller:'Mb',action:'showImage')}?id='+rowObject[0]+ '"/>'; 
				}
			},				
                         {name:'name',
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'show'}},                         
                         {name:'referrerCenter'},
                         {name:'assignedTo'},
                         {name:'id',hidden:true}
                     ],
                     rowNum:10,
                     rowList:[10,20,30,40,50,100,200],
                     pager: '#profile_list_pager',
                     viewrecords: true,
                     sortname: 'id',
                     sortorder: "asc",
                     width: 1200,
                     height: "100%",
                     multiselect: true,
                     caption:"Profile Search Result"
                 });
                 $("#profile_list").jqGrid('filterToolbar',{autosearch:true});
                 $("#profile_list").jqGrid('navGrid',"#profile_list_pager",{edit:false,add:false,del:true,search:false});
                 $("#profile_list").jqGrid('inlineNav',"#profile_list_pager",
                         {
                             edit: false,
                             add: false,
                             save: false,
                             cancel: false
                         })
                 $("#profile_list").jqGrid('navGrid',"#profile_list_pager").jqGrid('navButtonAdd',"#profile_list_pager",{caption:"Suggest", buttonicon:"ui-icon-person", onClickButton:suggest, position: "last", title:"Suggest", cursor: "pointer"});

                 jQuery("#prospect_list").jqGrid({
                     url:'jq_mbProspect_list',
                     postData:{
                         candidateid:function(){return $('#mbprofileid').val();},
                     },
                     datatype: "json",
                     colNames:['Photo','Name','WorkflowStatus','Stage','CandidateStatus','CandidateReason','CandidateDate','MbStatus','MbReason','MbDate','Id'],
                     colModel:[
			{
			name: 'photo',
			formatter: function (cellvalue, options, rowObject) {
				    return '<img height="70" width="70" src="${createLink(controller:'Mb',action:'showImage')}?id='+rowObject[0]+ '"/>'; 
				}
			},				
                         {name:'name',
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'show'}},                                                  
                         {name:'workflowStatus'},
                         {name:'stage'},
                         {name:'candidateStatus'},
                         {name:'candidateReason'},
                         {name:'candidateDate'},
                         {name:'mbStatus'},
                         {name:'mbReason'},
                         {name:'mbDate'},
                         {name:'id',hidden:true}
                     ],
                     rowNum:10,
                     rowList:[10,20,30,40,50,100,200],
                     pager: '#prospect_list_pager',
                     viewrecords: true,
                     sortname: 'id',
                     sortorder: "asc",
                     width: 1200,
                     height: "100%",
                     multiselect: true,
                     caption:"Prospect List"
                 });
                 $("#prospect_list").jqGrid('filterToolbar',{autosearch:true});
                 $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager",{edit:false,add:false,del:true,search:false});
                 $("#prospect_list").jqGrid('inlineNav',"#prospect_list_pager",
                         {
                             edit: false,
                             add: false,
                             save: false,
                             cancel: false
                         });
                 $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager").jqGrid('navButtonAdd',"#prospect_list_pager",{caption:"Propose", buttonicon:"ui-icon-person", onClickButton:propose, position: "last", title:"Propose", cursor: "pointer"});
                 $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager").jqGrid('navButtonAdd',"#prospect_list_pager",{caption:"Announce", buttonicon:"ui-icon-flag", onClickButton:announce, position: "last", title:"Announce", cursor: "pointer"});
                         
	});


	function propose() {
		var answer = confirm("Are you sure?");
		if (answer){
			var ids = $('#prospect_list').jqGrid('getGridParam','selarrrow');
			if(ids) {
				var url = "${createLink(controller:'mb',action:'propose')}"+"?candidateid="+$('#mbprofileid').val()+"&prospects="+ids;
				$.getJSON(url, {}, function(data) {
					alert(data.status);
					jQuery("#prospect_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select one or more prospects!!");
		} else {
		    return false;
		}
	}
  
	function announce() {
		var answer = confirm("Are you sure?");
		if (answer){
			var ids = $('#prospect_list').jqGrid('getGridParam','selarrrow');
			if(ids) {
				var url = "${createLink(controller:'mb',action:'announce')}"+"?candidateid="+$('#mbprofileid').val()+"&prospects="+ids;
				$.getJSON(url, {}, function(data) {
					alert(data.status);
					jQuery("#prospect_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select one or more prospects!!");
		} else {
		    return false;
		}
	}

	function suggest() {
		$( "#dialogTeam" ).dialog( "open" );
		var answer = confirm("Are you sure?");
		if (answer){
			var ids = $('#profile_list').jqGrid('getGridParam','selarrrow');
			if(ids) {
				var url = "${createLink(controller:'mb',action:'suggest')}"+"?candidateid="+$('#mbprofileid').val()+"&prospects="+ids;
				$.getJSON(url, {}, function(data) {
					alert(data.status);
					jQuery("#profile_list").jqGrid().trigger("reloadGrid");
					jQuery("#prospect_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select one or more profiles!!");
		} else {
		    return false;
		}
	}

		$( "#dialogSuggest" ).dialog({
			autoOpen: false,
			modal: true,
			buttons: {
				"OnlyToCandidate": function() {
					var ids = $('#profile_list').jqGrid('getGridParam','selarrrow');
					if(ids) {
						var url = "${createLink(controller:'mb',action:'suggest')}"+"?candidateid="+$('#mbprofileid').val()+"&prospects="+ids;
						$.getJSON(url, {}, function(data) {
							$( this ).dialog( "close" );
							alert(data.status);
							jQuery("#profile_list").jqGrid().trigger("reloadGrid");
							jQuery("#prospect_list").jqGrid().trigger("reloadGrid");
						    });	
					}
					else
						alert("Please select one or more profiles!!");
					$( this ).dialog( "close" );
				},
				"ToBothCandidateAndProspect": function() {
					var ids = $('#profile_list').jqGrid('getGridParam','selarrrow');
					if(ids) {
						var url = "${createLink(controller:'mb',action:'suggest')}"+"?candidateid="+$('#mbprofileid').val()+"&prospects="+ids+"&type=both";
						$.getJSON(url, {}, function(data) {
							$( this ).dialog( "close" );
							alert(data.status);
							jQuery("#profile_list").jqGrid().trigger("reloadGrid");
							jQuery("#prospect_list").jqGrid().trigger("reloadGrid");
						    });	
					}
					else
						alert("Please select one or more profiles!!");
					$( this ).dialog( "close" );
				},
				"Cancel": function() {
					$( "#teamMembers" ).val( '' );
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

      $('#checkboxAllFlexible').change(function() {
          if($(this).is(":checked")) {
          	$("input:radio[name^=flexible][value ='true']").prop('checked', true);
          }
          else
          	$("input:radio[name^=flexible][value ='false']").prop('checked', true);
    });

      $('#checkboxNoneFlexible').change(function() {
          if($(this).is(":checked")) {
          	$("input:radio[name^=flexible][value ='false']").prop('checked', true);
          }
    });
    
    
    $('input:radio[name=radioFlex]').change(
        function(){
            var toggleValue = $('input[name=radioFlex]:checked').val()
            //alert('changed val:'+toggleValue);   
            if(toggleValue=='ALL')
            	$("input:radio[name^=flexible][value ='true']").prop('checked', true);
            if(toggleValue=='NONE')
            	$("input:radio[name^=flexible][value ='false']").prop('checked', true);
        }
    );          

  
  });
</script>


	</body>
</html>
