<%@ page import="ics.*" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>MB Search</title>
		<r:require module="grid" />
		<r:require module="export"/>
		<r:require module="dateTimePicker" />
	</head>
	<body>

		<g:javascript src="tinymce/tinymce.min.js" />    

		<g:render template="/common/apisms" />
		<g:render template="/common/mandrillemail" />

		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
		    <sec:ifAnyGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC,ROLE_MB_MEMBER">
			<span class="menuButton"><g:link class="create" action="startProfile">Start Profile</g:link></span>
		    </sec:ifAnyGranted>
		</div>

            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>


		<div id="dialogAssignForm" title="Assign Profile">
			<div id="divToAssign">
			</div>
		</div>            

		<div id="dialogStatus" title="Change Workflow Status">
			<g:render template="changeWorkflowStatus" />
		</div>            


		<div id='message' class="message" style="display:none;"></div>

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

	<sec:ifAnyGranted roles="ROLE_MB_ADMIN">
		<div>
		Upload profiles in bulk: <br />
		    <g:uploadForm action="upload">
			<input type="file" name="myFile" />
			<input type="submit" value="Upload"/>
		    </g:uploadForm>
		</div>
	</sec:ifAnyGranted>
	

		<script type="text/javascript">// <![CDATA[
		  /* when the page has finished loading.. execute the follow */
		  $(document).ready(function () {		    
		    jQuery("#mbProfile_list").jqGrid({
		      url:'jq_mbManageProfile_list',
		      datatype: "json",
		      colNames:['Photo','ICSid','Name','Temple/Centre','PhoneNumber','AssignedTo','ProfileStatus','WorkflowStatus','id'],
		      colModel:[
			{
			name: 'photo',
			formatter: function (cellvalue, options, rowObject) {
				    return '<img height="70" width="70" src="${createLink(controller:'Mb',action:'showImage')}?id='+rowObject[0]+ '"/>'; 
				}
			},				
			{name:'icsid', search:true},
			{name:'name', search:true,
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'show'}},
			{name:'referrerCenter', search:true,
				stype:'select', searchoptions: { value: "${':ALL;'+(ics.MbProfile.createCriteria().list{projections{distinct('referrerCenter')}}?.collect{(it?:'')+':'+(it?:'')}.join(';'))}"}						
			},
			{name:'contactNumber', search:true},
			{name:'assignedTo', search:true},
			{name:'profileStatus', search:true,
				stype:'select', searchoptions: { value: "${':ALL;'+(ics.MbProfile.createCriteria().list{projections{distinct('profileStatus')}}?.collect{it+':'+it}.join(';'))}"}			
				},
			{name:'workflowStatus',search:true,
				stype:'select', searchoptions: { value: "${':ALL;'+(['UNASSIGNED','AVAILABLE','PROPOSED','BOYGIRLMEET','PARENTSMEET','PROPOSALAGREED','ANNOUNCE','MARRIEDTHRUMB','MARRIEDOSMB','UNAVAILABLE','ONHOLD','WITHDRAWN'].collect{(it?:'')+':'+(it?:'')}.join(';'))}"}						
				},
			{name:'id',hidden:true}
		     ],
		    rowNum:10,
		    rowList:[10,20,30,40,50,100,200],
		    pager:'#mbProfile_list_pager',
		    viewrecords: true,
		    gridview: true,
		    multisearch: false,
		    multiselect:false,
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
	    $("#mbProfile_list").jqGrid('navGrid',"#mbProfile_list_pager").jqGrid('navButtonAdd',"#mbProfile_list_pager",{caption:"Assign", buttonicon:"ui-icon-arrowthick-2-e-w", onClickButton:assign, position: "last", title:"Assign", cursor: "pointer"});
	    $("#mbProfile_list").jqGrid('navGrid',"#mbProfile_list_pager").jqGrid('navButtonAdd',"#mbProfile_list_pager",{caption:"MatchHistory", buttonicon:"ui-icon-zoomin", onClickButton:match, position: "last", title:"MatchHistory", cursor: "pointer"});
	    $("#mbProfile_list").jqGrid('navGrid',"#mbProfile_list_pager").jqGrid('navButtonAdd',"#mbProfile_list_pager",{caption:"Status", buttonicon:"ui-icon-shuffle", onClickButton:status, position: "last", title:"Status", cursor: "pointer"});

		 function match()  {
			var id = $('#mbProfile_list').jqGrid('getGridParam','selrow');
			if(id) {
				var url = "${createLink(controller:'mb',action:'search')}"+"?id="+id
				window.open(url,"_self")
			}
			else
				alert("Please select a row!!");

		 }

		 function assign()  {
			var id = $('#mbProfile_list').jqGrid('getGridParam','selrow');
			if(id) {
				var url = "${createLink(controller:'Mb',action:'assign')}"+"?profileid="+id;
				$( "#divToAssign" ).val("");
				$( "#divToAssign" ).load( url, function(responseTxt,statusTxt,xhr){
				    if(statusTxt=="success")
				    {
					$( "#dialogAssignForm" ).dialog( "open" );	
				    }
				    if(statusTxt=="error")
				      alert("Error: "+xhr.status+": "+xhr.statusText);
				  });
			}
			else
				alert("Please select a row!!");

		 }


		$( "#dialogAssignForm" ).dialog({
			autoOpen: false,
			modal: true,
			buttons: {
				"Assign": function() {
					      var url = "${createLink(controller:'Mb',action:'assignProfile')}";

					      // gather the form data
					      var data=$("#formAssignProfile").serialize();
					      // post data
					      $.post(url, data , function(returnData){
							  //alert(returnData);
							  $( "#dialogAssignForm" ).dialog( "close" );
							  jQuery("#mbProfile_list").jqGrid().trigger("reloadGrid");
							})
						
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

	function status() {
		var ids = $('#mbProfile_list').jqGrid('getGridParam','selarrrow');
		if(ids) {
				$( "#dialogStatus" ).dialog( "open" );
		}
		else
			alert("Please select a row!!");
	}
		
	$( "#dialogStatus" ).dialog({
		autoOpen: false,
		modal: true,
		buttons: {
			"Submit": function() {
				    $("#mbprofileid").val($('#mbProfile_list').jqGrid('getGridParam','selrow'));
				    $("#formChangeWorkflowStatus").submit();					    

					$( this ).dialog( "close" );
			},
			"Cancel": function() {
				$( this ).dialog( "close" );
			}
		},
		close: function() {

		}
	});
	
	$('#formChangeWorkflowStatus').submit(function(){

	      var url = "${createLink(controller:'Mb',action:'changeWorkflowStatus')}";
	      
	      // gather the form data
	      var data=$(this).serialize();
	      // post data
	      $.post(url, data , function(returnData){
			  jQuery("#mbProfile_list").jqGrid().trigger("reloadGrid");
	      })
	      return false; // stops browser from doing default submit process
	});

	

});


		// ]]></script>
	</body>
</html>


