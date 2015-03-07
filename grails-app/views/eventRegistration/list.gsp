<%@ page import="ics.EventRegistration" %>
<%@ page import="ics.VerificationStatus" %>
<%@ page import="ics.AccommodationAllotmentStatus" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'eventRegistration.label', default: 'EventRegistration')}" />
		<title>Event Registrations</title>
		<r:require module="grid" />
		<r:require module="export"/>
		<r:require module="dateTimePicker" />
		<style>
			.bgGreen{
			   background: none repeat scroll 0 0 green !important;
			  }
			.bgLightGreen{
			   background: none repeat scroll 0 0 lightgreen !important;
			  }
			.bgSkyBlue{
			   background: none repeat scroll 0 0 skyblue !important;
			  }
			.bgSteelBlue{
			   background: none repeat scroll 0 0 steelblue !important;
			  }
			.bgRed{
			   background: none repeat scroll 0 0 red !important;
			  }
			.bgYellow{
			   background: none repeat scroll 0 0 yellow !important;
			  }
		</style>		
	</head>
	<body>
		<g:javascript src="tinymce/tinymce.min.js" />    

		<g:render template="/common/apisms" />
		<g:render template="/common/mandrillemail" />

		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
		    <sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_REGISTRATION_COORDINATOR,ROLE_EVENTADMIN">
			<span class="menuButton"><g:link class="create" action="create">New Registration</g:link></span>
		    </sec:ifAnyGranted>
		    <sec:ifAnyGranted roles="ROLE_REGISTRATION_COORDINATOR,ROLE_EVENTADMIN">
			<span class="menuButton"><g:link class="list" action="listlocal">SSRKB BhaktaSamaj Registrations</g:link></span>
		    </sec:ifAnyGranted>
		    <sec:ifAnyGranted roles="ROLE_REGISTRATION_COORDINATOR,ROLE_VIP_REGISTRATION">
			<span class="menuButton"><g:link class="create" action="regCleanup">Cleanup Rejected Registrations</g:link></span>
		    </sec:ifAnyGranted>
		    <span class="menuButton"><g:link class="list" action="register">Runtime Registration List</g:link></span>
		</div>

		<div id='message' class="message" style="display:none;"></div>

		<g:form name="searchTab" action="list">
			Registrations for Event:<g:select id="eventid" name="eventid" from="${ics.Event.list(['sort':'title'])}" optionKey="id" optionValue="title" onchange="gridReload()" value="${params.eid}"/>
			<table class="searchForm" id="searchTab">
				<tr>	
					<td class="searchLabel"><label>Verification Status:</label></td>
					<td colspan="3">
					<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">	
						<g:radioGroup name="verificationStatus" id="verificationStatus"
								  values="${VerificationStatus?.values()}" 
								  labels="${VerificationStatus?.values().displayName}"
								  onClick="gridReload()">
							${it.radio}&nbsp;<g:message code="${it.label}" />&nbsp;&nbsp;
						</g:radioGroup></td>
					</sec:ifNotGranted>
					<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">	
						<g:radioGroup name="verificationStatus" id="verificationStatus"
								  values="${VerificationStatus?.values()}" 
								  labels="${VerificationStatus?.values().vipDisplayName}"
								  onClick="gridReload()">
							${it.radio}&nbsp;<g:message code="${it.label}" />&nbsp;&nbsp;
						</g:radioGroup></td>
					</sec:ifAnyGranted>
				</tr>
				<tr>	
					<td class="searchLabel"><label>Accommodation Allotment Status:</label></td>
					<td colspan="3">
					<g:radioGroup name="accommodationAllotmentStatus" id="accommodationAllotmentStatus"
							  values="${AccommodationAllotmentStatus?.values()}" 
							  labels="${AccommodationAllotmentStatus?.values().displayName}"
							  onClick="gridReload()">
						${it.radio}&nbsp;<g:message code="${it.label}" />&nbsp;&nbsp;
					</g:radioGroup></td>
				</tr>
				<tr>
					<td class="searchLabel"><label>Accommodation Required:</label></td>
					<td><input type="checkbox" name="accommodationRequired" id="accommodationRequired"/></td>
					<td class="searchLabel"><label>Accommodation Not Required:</label></td>
					<td><input type="checkbox" name="accommodationNotRequired" id="accommodationNotRequired"/></td>
					<td class="searchLabel"><label>Pick Up Required:</label></td>
					<td><input type="checkbox" name="pickUpRequired" id="pickUpRequired"/></td>
					<td class="searchLabel"><label>Drop Required:</label></td>
					<td><input type="checkbox" name="dropRequired" id="dropRequired"/></td>
				</tr>
				<tr>
					<td><input align="left" class="searchButton" type="submit" value="Clear" onclick="resetSearch()"/></td>
					<td></td>
				</tr>
			    </table>
		</g:form>

		

		<!-- table tag will hold our grid -->
		<table id="eventRegistration_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="eventRegistration_list_pager" class="scroll" style="text-align:center;"></div>

	        <sec:ifAnyGranted roles="ROLE_EVENTADMIN,ROLE_REGISTRATION_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_COORDINATOR">
		<div><input class="menuButton" type="BUTTON" id="btnSMS" value="SMS" gridName="#eventRegistration_list" entityName="EventRegistration"/>
		<input class="menuButton" type="BUTTON" id="btnEMAIL" value="EMAIL" gridName="#eventRegistration_list" entityName="EventRegistration"/></div>
		</sec:ifAnyGranted>

	        <sec:ifAnyGranted roles="ROLE_EVENTADMIN">
		<div>
		Upload accommodation allotment in bulk: <br />
		    <g:uploadForm controller="EventRegistration" action="bulkAccoAllot">
			<g:hiddenField name="eid" value="${params.eid}" />
			<input type="file" name="myFile" />
			<input type="submit" value="Upload"/>
		    </g:uploadForm>
		</div>            
		</sec:ifAnyGranted>
		
	        <!--<sec:ifAnyGranted roles="ROLE_REGISTRATION_COORDINATOR,ROLE_ACCOMMODATION_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION,ROLE_EVENTADMIN">
		<div>
		<table><tr><td>Download Registration Data(With Acco)
		<export:formats formats="['excel']" controller="helper" action="eventRegWithAccoReport"/>
		</td><td>Download Registration Data
		<export:formats formats="['excel']" controller="helper" action="eventRegReport"/></td>
		<td>Download Accommodation Allotment Data
		<export:formats formats="['excel']" controller="helper" action="eventAccoAllotmentReport"/></td>
		<td>Download Accommodation Checkin Data
		<export:formats formats="['excel']" controller="helper" action="eventAccoCheckinReport"/></td>
		</tr></table>
		</div>
		</sec:ifAnyGranted>-->

		<div>
			<table>
				<tr>
					<td style="background:yellow">Not specified arrival time (with none arrived till now)</td>
					<td style="background:red">No show even after 3 hours from arrival time</td>
					<td style="background:skyblue">Lesser number has arrived (with some yet to checkin)</td>
					<td style="background:steelblue">Lesser number has arrived (with all checkedin)</td>
					<td style="background:lightgreen">All arrived (with some yet to checkin)</td>
					<td style="background:green">All arrived (with all checkedin)</td>
				</tr>
			</table>
		</div>

		<script type="text/javascript">// <![CDATA[
		  /* when the page has finished loading.. execute the follow */
		  $(document).ready(function () {		    
		    jQuery("#eventRegistration_list").jqGrid({
		      url:'jq_eventRegistration_list',
		      postData:{
				eventid:function(){return $("#eventid").val();}
			},
		      datatype: "json",
		      colNames:['Name','Temple/Center','Country','PhoneNumber','Email','Status','Registration Code','Registered By','Registration Date','Arrival Date','Departure Date','Registered','Arrived','CheckedIn','Accommodation','Last Updated By','Last Updated On','defArr','ns','rc','ac','cc','ta','id'],
		      colModel:[
			{name:'name', search:true,
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'registrationDetails'}},
			{name:'connectedIskconCenter', search:true},
			{name:'country', search:true},
			{name:'contactNumber', search:true},
			{name:'email', search:true},
			{name:'status', search:true},
			{name:'regCode', search:true},
			{name:'creator', search:true},
			{name:'dateCreated', search:false},
			{name:'arrivalDate', search:true,searchoptions: {dataInit: function(el){
										$(el).datetimepicker({dateFormat:'dd-mm-yy'});
										}
									}},
			{name:'departureDate', search:false},
			{name:'regCount', search:false,sortable:false},
			{name:'arrivalCount', search:false,sortable:false},
			{name:'checkinCount', search:false,sortable:false},
			{name:'acco',search:false,sortable:false,
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
							//alert(rowObject[20]+" : "+rowObject[17]);
							if(rowObject[20]!=0 && rowObject[20] != rowObject[17])
								{
								//alert("something wrong with allocation");
								return 'style="background-color:darkred"';
								}
							}
				},
			{name:'updator', search:true},
			{name:'lastUpdated', search:false},
			{name:'defArr',hidden:true},//default arrival date (without any physical arrival till now)
			{name:'ns',hidden:true},//no show
			{name:'rc',hidden:true},//registered count 17
			{name:'ac',hidden:true},//arrived count
			{name:'cc',hidden:true},//checkedin count
			{name:'ta',hidden:true},//allocated count 20
			{name:'id',hidden:true}
		     ],
		    rowNum:10,
		    rowList:[10,20,30,40,50,100,200],
		    pager:'#eventRegistration_list_pager',
		    viewrecords: true,
		    gridview: true,
		    rowattr: function (rd) {
			    if (rd.defArr == 1) {
				return {"class": "bgYellow"};
				}
			    if (rd.ns ==1) {
				return {"class": "bgRed"};
				}
			    if (rd.ac>0 && (rd.ac < rd.rc) && (rd.cc<rd.ac)) {
				return {"class": "bgSkyBlue"};
				}
			    if (rd.ac>0 && (rd.ac < rd.rc) && (rd.cc==rd.ac)) {
				return {"class": "bgSteelBlue"};
				}
			    if (rd.ac>0 && (rd.rc == rd.ac)&&(rd.cc<rd.ac)) {
				return {"class": "bgLightGreen"};
				}
			    if (rd.ac>0 && (rd.rc == rd.ac)&&(rd.cc==rd.ac)) {
				return {"class": "bgGreen"};
				}
			    },		    
		    multisearch: true,
		    multiselect:true,
		    sopt:['eq','ne','cn','bw','bn', 'ilike'],
		    sortname: "lastUpdated",
		    sortorder: "desc",
		    width: 1250,
		    height: "100%",
		    caption:"Registration List"
		    });

		    $("#eventRegistration_list").jqGrid('filterToolbar',{autosearch:true});
		    $("#eventRegistration_list").jqGrid('navGrid',"#eventRegistration_list_pager",
			{add:false,edit:false,del:true, search: false}, // which buttons to show?
			{},         // edit options
			{},  // add options
			{}          // delete options
		    );

    <sec:ifAnyGranted roles="ROLE_REGISTRATION_COORDINATOR,ROLE_ACCOMMODATION_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION,ROLE_EVENTADMIN">
	// add custom button to export the detail data to excel	
	$("#eventRegistration_list").jqGrid('navGrid',"#eventRegistration_list_pager").jqGrid('navButtonAdd',"#eventRegistration_list_pager",{caption:"Export", buttonicon:"ui-icon-disk",title:"Export",
	       onClickButton : function () { 
			var url = "${createLink(controller:'eventRegistration',action:'export')}"+"?eid="+$("#eventid").val();		
			jQuery("#eventRegistration_list").jqGrid('excelExport',{"url":url});
	       }
	       });
     </sec:ifAnyGranted>      



	        });

		$(function(){
		    $('input[name$="Required"]').click(function() {
			    gridReload();
		    });
		});

		 function afterSubmitEvent(response, postdata) {
			var success = true;

			var json = eval('(' + response.responseText + ')');
			var message = json.message;

			if(json.state == 'FAIL') {
			    success = false;
			} else {
			  $('#message').html(message);
			  $('#message').show().fadeOut(10000);
			}

			var new_id = json.id
			return [success,message,new_id];
		    }

		
		function gridReload(){
			var query = "isVipDevotee=false";
			    
			if ($('#dropRequired').is(':checked')) {
				query = query.concat("&dropRequired=true");
			}
			if ($('#pickUpRequired').is(':checked')) {
				query = query.concat("&pickUpRequired=true");
			}
			if ($('#accommodationRequired').is(':checked')) {
				query = query.concat("&accommodationRequired=true");
			}
			if ($('#accommodationNotRequired').is(':checked')) {
				query = query.concat("&accommodationRequired=false");
			}
			if ($("input:radio[name='verificationStatus']:checked").val()) {
				//alert($("input:radio['name=verificationStatus']:checked").val());
				query = query.concat("&verificationStatus="+$("input:radio[name='verificationStatus']:checked").val());
				//query = query.concat($("input:radio['name=verificationStatus']:checked").val());
				//alert("hi");

			}
			if ($("input:radio[name='accommodationAllotmentStatus']:checked").val()) {
				//alert($("input:radio['name=verificationStatus']:checked").val());
				query = query.concat("&accommodationAllotmentStatus="+$("input:radio[name='accommodationAllotmentStatus']:checked").val());
				//query = query.concat($("input:radio['name=verificationStatus']:checked").val());
				//alert("hi");

			}
			//alert(query);
			jQuery("#eventRegistration_list").jqGrid('setGridParam',{url:"jq_eventRegistration_list?"+query}).trigger("reloadGrid");

		}

//		function resetSearch() {
//			alert("Hi");
//		}

		// ]]></script>
	</body>
</html>


