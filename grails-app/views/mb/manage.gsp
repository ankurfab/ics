<%@ page import="ics.*" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>MB Search</title>
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
		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
		    <sec:ifAnyGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC,ROLE_MB_MEMBER">
			<span class="menuButton"><g:link class="create" action="startProfile">Start Profile</g:link></span>
		    </sec:ifAnyGranted>
		</div>

            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>

	<sec:ifAnyGranted roles="ROLE_MB_ADMIN">
		<div>
		Upload profiles in bulk: <br />
		    <g:uploadForm action="upload">
			<input type="file" name="myFile" />
			<input type="submit" value="Upload"/>
		    </g:uploadForm>
		</div>
	</sec:ifAnyGranted>


		<div id='message' class="message" style="display:none;"></div>

		<g:form name="searchTab" action="list">
			<table class="searchForm" id="searchTab">
				<tr>	
					<td class="searchLabel"><label>Workflow Status:</label></td>
					<td colspan="3">
					<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">	
						<g:radioGroup name="workflowStatus" id="workflowStatus"
								  values="${['UNAPPROVED','OPEN','INPROGRESS','PROPOSED','WAITING','READY','CONSULTATION','REJECTED','ANNOUNCE']}" 
								  labels="${['UNAPPROVED','OPEN','INPROGRESS','PROPOSED','WAITING','READY','CONSULTATION','REJECTED','ANNOUNCE']}" 
								  onClick="gridReload()">
							${it.radio}&nbsp;<g:message code="${it.label}" />&nbsp;&nbsp;
						</g:radioGroup></td>
					</sec:ifNotGranted>
				</tr>
				<tr>	
					<td class="searchLabel"><label>Profile Status:</label></td>
					<td colspan="3">
					<g:radioGroup name="profileStatus" id="profileStatus"
							  values="${['COMPLETE','INCOMPLETE']}" 
							  labels="${['COMPLETE','INCOMPLETE']}" 
							  onClick="gridReload()">
						${it.radio}&nbsp;<g:message code="${it.label}" />&nbsp;&nbsp;
					</g:radioGroup></td>
				</tr>
				<tr>
					<td class="searchLabel"><label>UnResolved:</label></td>
					<td><input type="checkbox" name="unresolved" id="unresolved"/></td>
					<td class="searchLabel"><label>Resolved:</label></td>
					<td><input type="checkbox" name="resolved" id="resolved"/></td>
				</tr>
				<tr>
					<td><input align="left" class="searchButton" type="submit" value="Clear" onclick="resetSearch()"/></td>
					<td></td>
				</tr>
			    </table>
		</g:form>

		

		<!-- table tag will hold our grid -->
		<table id="mbProfile_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="mbProfile_list_pager" class="scroll" style="text-align:center;"></div>
		
	        <sec:ifAnyGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC">
		<div><input class="menuButton" type="BUTTON" id="btnSMS" value="SMS" gridName="#mbProfile_list" entityName="MbProfile"/>
		<input class="menuButton" type="BUTTON" id="btnEMAIL" value="EMAIL" gridName="#mbProfile_list" entityName="MbProfile"/></div>
		</sec:ifAnyGranted>
		
	        <sec:ifAnyGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC">
		<div>
		<table><tr><td>Export
		<export:formats formats="['excel']" controller="mb" action="exportProfile"/>
		</td>
		</tr></table>
		</div>
		</sec:ifAnyGranted>

		<div>
			<table>
				<tr>
					<td style="background:yellow">OPEN</td>
					<td style="background:red">UNAPPROVED</td>
					<td style="background:skyblue">PROPOSED</td>
					<td style="background:steelblue">READY</td>
					<td style="background:lightgreen">ANNOUNCE</td>
					<td style="background:green">RESOLVED</td>
				</tr>
			</table>
		</div>

		<g:render template="/common/sms" />
		<g:render template="/common/email" />

		<script type="text/javascript">// <![CDATA[
		  /* when the page has finished loading.. execute the follow */
		  $(document).ready(function () {		    
		    jQuery("#mbProfile_list").jqGrid({
		      url:'jq_mbManageProfile_list',
		      datatype: "json",
		      colNames:['ICSid','Name','Temple/Centre','PhoneNumber','ProfileStatus','WorkflowStatus','MatchMakingStatus','id'],
		      colModel:[
			{name:'icsid', search:true},
			{name:'name', search:true,
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'show'}},
			{name:'centre', search:true},
			{name:'contactNumber', search:true},
			{name:'profileStatus', search:true},
			{name:'workflowStatus',search:true,sortable:false,
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
							//alert(rowObject[20]+" : "+rowObject[17]);
							if(rowObject[20]!=0 && rowObject[20] != rowObject[17])
								{
								//alert("something wrong with allocation");
								return 'style="background-color:darkred"';
								}
							}
				},
			{name:'matchMakingStatus', search:true},
			{name:'id',hidden:true}
		     ],
		    rowNum:10,
		    rowList:[10,20,30,40,50,100,200],
		    pager:'#mbProfile_list_pager',
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
		    caption:"MB Profile List"
		    });

		    $("#mbProfile_list").jqGrid('filterToolbar',{autosearch:true});
		    $("#mbProfile_list").jqGrid('navGrid',"#mbProfile_list_pager",
			{add:false,edit:false,del:false, search: false}, // which buttons to show?
			{},         // edit options
			{},  // add options
			{}          // delete options
		    );
	    $("#mbProfile_list").jqGrid('navGrid',"#mbProfile_list_pager").jqGrid('navButtonAdd',"#mbProfile_list_pager",{caption:"Match", buttonicon:"ui-icon-zoomin", onClickButton:match, position: "last", title:"Match", cursor: "pointer"});

		 function match()  {
			var id = $('#mbProfile_list').jqGrid('getGridParam','selrow');
			if(id) {
				var url = "${createLink(controller:'mb',action:'search')}"+"?id="+id
				window.open(url,"_self")
			}
			else
				alert("Please select a row!!");

		 }

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
			jQuery("#mbProfile_list").jqGrid('setGridParam',{url:"jq_mbManageProfile_list?"+query}).trigger("reloadGrid");

		}

//		function resetSearch() {
//			alert("Hi");
//		}

		// ]]></script>
	</body>
</html>


