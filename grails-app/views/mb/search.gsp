<%@ page import="ics.*" %>
<%@ page import="org.codehaus.groovy.grails.commons.DefaultGrailsDomainClass" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>MB Profile Search</title>
		<r:require module="grid" />
        <r:require module="jqui"/>
        <r:require module="jqval"/>
        <r:require module="ajaxform"/>
        <r:require module="multiselect"/>
        <style>
            .ui-jqgrid .ui-state-highlight { background: #FFFF99 !important; }
            .ui-jqgrid tr.jqgrow td {
                white-space: normal !important;
            }
        </style>
	</head>
	<body>
    <g:set var="iskconCentres" value="${ics.AttributeValue.findAllByAttribute(ics.Attribute.findByDomainClassNameAndDomainClassAttributeNameAndCategory('Mb','iskcon_centre','Config'))?.collect{it.value}}" />
    <g:set var="spiritualMasters" value="${ics.AttributeValue.findAllByAttribute(ics.Attribute.findByDomainClassNameAndDomainClassAttributeNameAndCategory('Mb','sp_master','Config'))?.collect{it.value}}" />
		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
		</div>

            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>


		<div id="dialogSuggest" title="Suggest">
		</div>
        <div id="dialogMbReason" title="Reason">
            <span>By specifying a reason and submitting you shall decline any further progress for this match. In future to Reinstate the match please re-suggest the same prospect to the candidate.</span>
            <br><br>
            <strong>Reason: </strong>
            <g:textArea name="mbReason" value="" rows="5" cols="40"/>
        </div>
    <div id='dialogMessage' title="Information">
        <strong><span class="dialogMsgContent"></span></strong>
    </div>
	<h1>Match making for ${mbProfile?.candidate} ( ${mbProfile?.candidate?.dob?.format("dd/MM/y")} )</h1>
		
		%{--<div>
			Matchmaking for?<g:select name="mbprofileid"
				  from="${ics.MbProfile.createCriteria().list{'in'('workflowStatus',['AVAILABLE']) candidate{order('legalName', 'asc')}}}"
                  noSelection="${['null':'Select One...']}"
                  optionKey="id" optionValue="candidate"
            />
		</div>--}%
    <div>
        <!-- table tag will hold our grid -->
        <table id="prospect_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
        <!-- pager will hold our paginator -->
        <div id="prospect_list_pager" class="scroll" style="text-align:center;"></div>
    </div>
<g:set var="mbclass" value="${new DefaultGrailsDomainClass(ics.MbProfile.class)}" />
<g:set var="mbproperties" value="${mbclass.persistentProperties}" />
<g:form name="expectationsForm" id="expectationsForm">
    <g:hiddenField name="mbProfileId" value="${mbProfile?.id}"/>
    <g:hiddenField name="mbprofileid" value="${mbProfile?.id}"/>
	<!--Ignore Expectations:<g:checkBox name="showAll" value="${false}" />-->
	<!--Flexibile on all expectations:<g:checkBox name="checkboxAllFlexible" value="${false}" />-->
	<!--Flexibile on no expectations:<g:checkBox name="checkboxNoneFlexible" value="${false}" />-->
	<div style="margin:20px">
	Flexibile: <g:radioGroup name="radioFlex" labels="['None','All','Default']" values="['NONE','ALL','DEFAULT']" value="DEFAULT" >
	<span>${it.radio} ${it.label}</span>
	</g:radioGroup>
    </div>
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
                        <label for="Chanting">Flexible :</label>
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
                        <g:select name="prefSpMaster" class="multiple" multiple="multiple"
                                  from="${spiritualMasters}"
                                  value="${org.springframework.util.StringUtils.commaDelimitedListToStringArray(mbProfile?.prefSpMaster).toList()}"/>
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
                        <g:select name="prefCentre" from="${iskconCentres}" class="multiple" multiple="multiple"
                                  value="${org.springframework.util.StringUtils.commaDelimitedListToStringArray(mbProfile?.prefCentre).toList()}" noSelection="['':'Select One']"/>
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
                        <label for="prefCurrentCountry">Preferred Current Country:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:select name="prefCurrentCountry" from="${['India', 'Abroad']}" value="${mbProfile?.prefCurrentCountry}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleCurrentCountry">Flexible:</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleCurrentCountry" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleCurrentCountry}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="prefVarna">Preferred  Varna:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:select name="prefVarna" class="multiple" multiple="multiple" from="${['Brahmin', 'Kshatriya', 'Vaishya', 'Sudra','Not Known']}"
                                  value="${org.springframework.util.StringUtils.commaDelimitedListToStringArray(mbProfile?.prefVarna).toList()}"/>
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
                    <td valign="top" class="name">
                        <label for="prefCulturalInfluence">Preferred<br>Cultural Influence</label>
                    </td>
                    <td valign="top" class="value">
                        <g:select class="multiple" name="prefCulturalInfluence" multiple="multiple"
                                  from="${['Assamese','Andhraite','Bengali','Bihari','Gujarati','Himachal Pradesh','Kannadiga','Kasmiri','Konkani','Keralite','Madhya Pradesh','Manipuri','Maharashtrian','Marwari','Nepali','Oriyan','Punjabi','Sindhi','Tamilian','Typical North Indian','Typical South Indian','Typical Cosmopolitan','Typical Village','Uttar Pradesh','Urdu','Western']}"
                                  value="${org.springframework.util.StringUtils.commaDelimitedListToStringArray(mbProfile?.prefCulturalInfluence).toList()}"/>
                    </td>
                    <td valign="top" class="name">
                        <label for="flexibleCulturalInfluence">Flexible:</label>
                    </td>
                    <td>
                        <g:radioGroup name="flexibleCulturalInfluence" labels="['No', 'Yes']" values="[false, true]"
                                      value="${mbProfile?.flexibleCulturalInfluence}">
                            <span>${it.radio} ${it.label}</span>
                        </g:radioGroup>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="prefCategory">Preferred Category:</label>
                    </td>
                    <td valign="top" class="value">
                        <g:select name="prefCategory" class="multiple" multiple="multiple"
                                  from="${['Open', 'Backward Class', 'Other Backward Class', 'Scheduled Caste', 'Scheduled Tribe', 'Nomadic Tribes','Others']}"
                                  value="${org.springframework.util.StringUtils.commaDelimitedListToStringArray(mbProfile?.prefCategory).toList()}"/>
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
                        <g:select name="prefeducationCategory" style="width: 80%"
                                  from="${['SSC (10th equivalent)', 'HSC (12th equivalent)', 'Undergraduate', 'Diploma(or equivalent)', 'Graduate', 'Post Graduate', 'Doctorate']}"
                                  value="${mbProfile?.prefeducationCategory}"/>
                        <span> & above</span>
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
                        <input type="text" class="slider-input" name="prefCandIncome" id="prefCandIncome" readonly data-min-val="1" data-max-val="100" data-min="${mbProfile?.prefCandIncome? mbProfile?.prefCandIncome.split(" - ")[0]:4}" data-max="${mbProfile?.prefCandIncome? mbProfile?.prefCandIncome.split(" - ")[1]:16}"><span> Lakhs Per Annum</span>
                        <div class="slider-range"></div>
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
                        <g:select class="multiple" name="prefLangKnown" multiple="multiple"
                                  from="${['Assamese', 'Bengali', 'English', 'Gujarati', 'Hindi', 'Kannada', 'Kashmiri', 'Konkani', 'Malayalam', 'Manipuri', 'Marathi', 'Marwari', 'Nepali', 'Oriya', 'Punjabi', 'Sanskrit', 'Sindhi', 'Tamil', 'Telugu', 'Urdu', 'Other Indian languages', 'Foreign languages']}"
                                  value="${org.springframework.util.StringUtils.commaDelimitedListToStringArray(mbProfile?.languagesKnown).toList()}"/>
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
                        <input type="text" class="slider-input" name="prefAgeDiff" id="prefAgeDiff" readonly data-min-val="0" data-max-val="10" data-min="${mbProfile?.prefAgeDiff? mbProfile?.prefAgeDiff.split(" - ")[0]: 0}" data-max="${mbProfile?.prefAgeDiff? mbProfile?.prefAgeDiff.split(" - ")[1]:10}"><span> Years</span>
                        <div class="slider-range"></div>
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
                        <input type="text" class="slider-input" name="prefHeight" id="prefHeight" readonly data-min-val="53" data-max-val="77" data-min="${mbProfile?.prefHeight? mbProfile?.prefHeight.split(" - ")[0]:53}" data-max="${mbProfile?.prefHeight? mbProfile?.prefHeight.split(" - ")[1]:77}">
                        <div class="slider-range"></div>
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
                        <g:select name="prefManglik" class="multiple" multiple="multiple" from="${['Not Manglik', 'Low', 'Medium', 'High']}"
                                  value="${org.springframework.util.StringUtils.commaDelimitedListToStringArray(mbProfile?.prefManglik).toList()}"/>
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

<script type="text/javascript">
  $(document).ready(function () {
      $('#mbprofileid').change(function() {
          $.ajax({
             url:'/ics/mb/search',
             data:{id: $(this).val()}
          });
      });
      jQuery("#prospect_list").jqGrid({
          url:'jq_mbProspect_list',
          postData:{
              candidateid:function(){return $('#mbprofileid').val();}
          },
          datatype: "json",
          colNames:['Photo','Name','WorkflowStatus','CandidateStatus','CandidateReason','CandidateDate','MbStatus','MbReason','MbDate','Id'],
          colModel:[
              {
                  name: 'photo',
                  formatter: function (cellvalue, options, rowObject) {
                      return '<img height="70" width="70" src="${createLink(controller:'Mb',action:'showImage')}?imgType=closePrim&entity=mbProfile&entityId='+rowObject[0]+'"/>';
                  }
              },
              {name:'name',
                  formatter:'showlink',
                  formatoptions:{baseLinkUrl:'show'}},
              {name:'workflowStatus'},
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
      $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager",{edit:false,add:false,del:false,search:false});
      $("#prospect_list").jqGrid('inlineNav',"#prospect_list_pager",
              {
                  edit: false,
                  add: false,
                  save: false,
                  cancel: false
              });
      $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager").jqGrid('navButtonAdd',"#prospect_list_pager",{caption:"Approve", buttonicon:"ui-icon-check", onClickButton:approve, position: "last", title:"Approve", cursor: "pointer"});
      $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager").jqGrid('navButtonAdd',"#prospect_list_pager",{caption:"Decline", buttonicon:"ui-icon-close", onClickButton:decline, position: "last", title:"Decline", cursor: "pointer"});

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
                     colNames:['Photo','Name','Dob','Centre','AssignedTo','Id'],
                     colModel:[
			{
			name: 'photo',
			formatter: function (cellvalue, options, rowObject) {
				    return '<img height="70" width="70" src="${createLink(controller:'Mb',action:'showImage')}?imgType=closePrim&entity=mbProfile&entityId='+rowObject[0]+'"/>';
				}
			},				
                         {name:'name',
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'show'}},
                         {name:'dob'},
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
                 $("#profile_list").jqGrid('navGrid',"#profile_list_pager",{edit:false,add:false,del:false,search:false});
                 $("#profile_list").jqGrid('inlineNav',"#profile_list_pager",
                         {
                             edit: false,
                             add: false,
                             save: false,
                             cancel: false
                         })
                 $("#profile_list").jqGrid('navGrid',"#profile_list_pager").jqGrid('navButtonAdd',"#profile_list_pager",{caption:"Suggest", buttonicon:"ui-icon-person", onClickButton:suggest, position: "last", title:"Suggest", cursor: "pointer"});
	});

    function approve(){
        var answer = confirm("Are you sure?");
        if (answer){
            var id = $('#prospect_list').jqGrid('getGridParam','selrow');
            if(id) {
                var url = "${createLink(controller:'mb',action:'mbNextStep')}";
                $.ajax({
                    url: url,
                    type: "POST",
                    data: {
                        matchid: id
                    }
                }).success(function(data) {
                    !!data.status && $('.dialogMsgContent').html(data.status) && $( "#dialogMessage" ).dialog('open');
                    jQuery("#prospect_list").trigger( 'reloadGrid' );
                });
            }
            else
                $('.dialogMsgContent').html("Please select the profile by clicking on the candidate's photo!!") && $( "#dialogMessage" ).dialog('open');
        } else {
            return false;
        }
    }

      function decline() {
          var id = $('#prospect_list').jqGrid('getGridParam','selrow');
          if(id) {
              $( "#dialogMbReason" ).dialog( "open" );
          }
          else
              $('.dialogMsgContent').html(data.status) && $( "#dialogMessage" ).dialog('open');
      }

	function suggest() {
		var answer = confirm("Are you sure?");
		if (answer){
            $( "#dialogSuggest").dialog('open');
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
      $( "#dialogMbReason" ).dialog({
          autoOpen: false,
          height: 300,
          width: 350,
          modal: true,
          buttons: {
              "Submit": function() {
                  var id = $('#prospect_list').jqGrid('getGridParam','selrow');
                  if(id) {
                      var url = "${createLink(controller:'mb',action:'decline')}";
                      $.ajax({
                          url: url,
                          type: "POST",
                          data: {
                              matchid: id,
                              origin: 'mb',
                              reason: $( "#mbReason").val()
                          }
                      }).success(function(data) {
                          $( "#dialogMbReason" ).dialog( "close" );
                          !!data.status && alert(data.status);
                          setTimeout(function(){
                              jQuery("#prospect_list").trigger( 'reloadGrid' );
                          },10);
                      });
                      jQuery("#prospect_list").jqGrid().trigger("reloadGrid");
                  }
              },
              "Cancel": function() {
                  $( "#candidateReason" ).val( '' );
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
            if(toggleValue=='DEFAULT') {
                $("#expectationsForm")[0].reset();
                setTimeout(function(){
                    $('.multiple').multiselect({
                        noneSelectedText: 'Select One/More option',
                        menuWidth: 225,
                        checkAllText: 'Select All',
                        uncheckAllText: 'Select None',
                        selectedList: 40,
                        minWidth: 300
                    });
                    $('.ui-multiselect').css('width', '300px');
                },10);
            }
        }
    );
      $('.multiple').multiselect({
          noneSelectedText: 'Select One',
          menuWidth: 225,
          checkAllText: 'Select All',
          uncheckAllText: 'Select None',
          selectedList: 40,
      });

      $('.ui-multiselect').css('width', '300px');

      $(".slider-range").each(function() {
          var slideInput = $(this).siblings();
          $(this).slider({
              range: true,
              min: slideInput.data('min-val'),
              max: slideInput.data('max-val'),
              values: [slideInput.data('min'), slideInput.data('max')],
              step: slideInput.data('step') || 1,
              slide: function (event, ui) {
                  var slideInput = $(this).siblings();
                  if(slideInput.attr('id')=='prefHeight'){
                      slideInput.val(Math.floor(ui.values[0]/12) + '"' + ui.values[0]%12 + "'" + " - " + Math.floor(ui.values[1]/12) + '"' + ui.values[1]%12 + "'");
                  }
                  else{
                      slideInput.val(ui.values[0] + " - " + ui.values[1]);
                  }
              }
          });
          if(slideInput.attr('id')=='prefHeight'){
              slideInput.val(Math.floor($(this).slider( "values", 0 )/12) + '"' + $(this).slider( "values", 0 )%12 + "'" + " - " + Math.floor($(this).slider( "values", 1 )/12) + '"' + $(this).slider( "values", 1 )%12 + "'");
          }
          else{
              slideInput.val($(this).slider("values",0) + " - " + $(this).slider("values",1));
          }
          slideInput.attr('size',slideInput.val().length);
        });

      $( "#dialogMessage" ).dialog({
          autoOpen: false,
          height: 300,
          width: 350,
          modal: true,
          buttons: {
              "Ok": function(){
                  $( "#dialogMessage").dialog('close');
              },
              "Cancel": function(){
                  $( "#dialogMessage").dialog('close');
              }
          }
      });
  
  });
</script>


	</body>
</html>
