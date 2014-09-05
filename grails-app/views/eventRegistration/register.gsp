<%@ page import="ics.EventRegistration" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'eventRegistration.label', default: 'EventRegistration')}" />
		<title>Runtime Registration</title>
		<r:require module="grid" />
	</head>
	<body>
		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
		</div>
		
		Override allotment check?<g:checkBox id="override" name="override" value="${true}" />
		
		<!-- table tag will hold our grid -->
		<table id="runtime_eventRegistration_summary_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="runtime_eventRegistration_summary_list_pager" class="scroll" style="text-align:center;"></div>

		<!-- table tag will hold our grid -->
		<table id="runtime_eventRegistration_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="runtime_eventRegistration_list_pager" class="scroll" style="text-align:center;"></div>

		<div><input class="menuButton" type="BUTTON" id="btnSMS" value="SMS" gridName="#runtime_eventRegistration_list" entityName="EventRegistration"/>
		<input class="menuButton" type="BUTTON" id="btnEMAIL" value="EMAIL" gridName="#runtime_eventRegistration_list" entityName="EventRegistration"/>
		<input class="menuButton" type="BUTTON" id="btnACS" value="ACS" /></div>
		<g:render template="/common/sms" />
		<g:render template="/common/email" />

		<div id="dialogACS" title="Accommodation Confirmation Slip">
			<p id="acsText">Loading.....<img src="${resource(dir:'images',file:'spinner.gif')}"/></p>
		</div>
		
		<script type="text/javascript">// <![CDATA[
		  /* when the page has finished loading.. execute the follow */
		  $(document).ready(function () {		    

		    jQuery("#runtime_eventRegistration_summary_list").jqGrid({
		      url:'${createLink(controller:'EventRegistration',action:'jq_runtime_eventRegistration_summary_list')}'+'?ergid=${erGroup?.id?:""}',
		      datatype: "json",
		      colNames:['GroupLeaderName','Phone','Temple/Centre','RegistrationCode','Accommodation','Number of Groups','Total Prji','Total Mataji','Total Children','Total Brahmachari','Total Guest','id'],
		      colModel:[
			{name:'glname',sortable:false
				,
				formatter:'showlink', 
				formatoptions:{baseLinkUrl:"${createLink(controller:'EventRegistration',action:'showFromGroup')}"}},
			{name:'phone',sortable:false},
			{name:'centre',sortable:false},
			{name:'regcode',sortable:false},
			{name:'acco',sortable:false,search:false},
			{name:'numGroups',sortable:false,search:false},
			{name:'numPrji',sortable:false,search:false},
			{name:'numMataji',sortable:false,search:false},
			{name:'numChildren',sortable:false,search:false},
			{name:'numBrahmachari',sortable:false,search:false},
			{name:'total',sortable:false,search:false},
			{name:'id',hidden:true}
		     ],
		    rowNum:10,
		    rowList:[10],
		    pager:'#runtime_eventRegistration_summary_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortorder: "asc",
		    multiselect: false,
		    width: 1250,
		    height: "100%",
		    caption:"Runtime Registration Summary",
		    onSelectRow: function(ids) { 
			var selGLName = jQuery('#runtime_eventRegistration_summary_list').jqGrid('getCell', ids, 'glname');
			var selGLRegCode = jQuery('#runtime_eventRegistration_summary_list').jqGrid('getCell', ids, 'regcode');
			var isChecked = $('#override').is(':checked');
			jQuery("#runtime_eventRegistration_list").jqGrid('setCaption',"Runtime Registration Group List: "+selGLName+" ("+selGLRegCode+")");
			jQuery("#runtime_eventRegistration_list").jqGrid('setGridParam',{url:"${createLink(controller:'EventRegistration',action:'jq_runtime_eventRegistration_list')}"+"?ergid="+ids}).trigger('reloadGrid');
			jQuery("#runtime_eventRegistration_list").jqGrid('setGridParam',{editurl:"${createLink(controller:'EventRegistration',action:'jq_runtime_eventRegistration_edit')}"+"?ergid="+ids+"&override="+isChecked});
			},
			footerrow : true,
			userDataOnFooter : true							
		    });

		    $("#runtime_eventRegistration_summary_list").jqGrid('filterToolbar',{autosearch:true});

		    $("#runtime_eventRegistration_summary_list").jqGrid('navGrid',"#runtime_eventRegistration_summary_list_pager",
			{add:false,edit:false,del:false, search: false}, // which buttons to show?
			{},         // edit options
			{},  // add options
			{},          // delete options
			{} //search options
		    );


		    jQuery("#runtime_eventRegistration_list").jqGrid({
		      url:'${createLink(controller:'EventRegistration',action:'jq_runtime_eventRegistration_list')}'+'?ergid=${erGroup?.id}',
		      editurl:'${createLink(controller:'EventRegistration',action:'jq_runtime_eventRegistration_edit')}'+'?ergid=${erGroup?.id}',
		      datatype: "json",
		      colNames:['SubGroupLeaderName','Phone','Temple/Centre','RegistrationCode','Accommodation','Number of Group','Total Prji','Total Mataji','Total Children','Total Brahmachari','Total Guest','id'],
		      colModel:[
			{name:'subglname',editable:true, editrules:{required:true}, editoptions:{defaultValue:getGLName}},
			{name:'phone',editable:true, editrules:{required:true, integer:true, minValue:0, maxValue:9999999999}, editoptions:{defaultValue:getGLPhone}},
			{name:'temple',editable:false},
			{name:'code',editable:false},
			{name:'acco',editable:false},
			{name:'gno',editable:false},
			{name:'numberofPrabhujis',editable:true, editrules:{required:true, integer:true, minValue:0}},
			{name:'numberofMatajis',editable:true, editrules:{required:true, integer:true, minValue:0}},
			{name:'numberofChildren',editable:true, editrules:{required:true, integer:true, minValue:0}},
			{name:'numberofBrahmacharis',editable:true, editrules:{required:true, integer:true, minValue:0}},
			{name:'total',editable:false},
			{name:'id',hidden:true}
		     ],
		    rowNum:10,
		    rowList:[10,20,50,100,200],
		    pager:'#runtime_eventRegistration_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortorder: "asc",
		    multiselect: false,
		    width: 1250,
		    height: "100%",
		    reloadAfterSubmit:true,
		    caption:"Runtime Registration Group List"
		    });

		    //$("#runtime_eventRegistration_list").jqGrid('filterToolbar',{autosearch:true});
		    $("#runtime_eventRegistration_list").jqGrid('navGrid',"#runtime_eventRegistration_list_pager",
			{add:false,edit:false,del:true, search: false}, // which buttons to show?
			{},         // edit options
			{afterSubmit:afterSubmitEvent},  // add options
			{afterSubmit:afterSubmitEvent}          // delete options
		    );
		    jQuery("#runtime_eventRegistration_list").jqGrid('inlineNav',"#runtime_eventRegistration_list_pager",{
		    		addParams: {
		    			"aftersavefunc" : refresh,
					    successfunc: function( response ) {
						var json = eval('(' + response.responseText + ')');
						var message = json.message;
						alert("In addParams:"+message); 
						return true;
					    	},
					    addRowParams : {successfunc: function( response ) {
						var json = eval('(' + response.responseText + ')');
						var message = json.message;
						alert("In addRowParams:"+message); 
						return true;
					    	}}
					    },
				editParams: {
					"aftersavefunc" : refresh,
					    successfunc: function( response ) {
						var json = eval('(' + response.responseText + ')');
						var message = json.message;
						alert(message); 
						return true;
					    	}
		    			},
		    	add:true,edit:true,del:true});


		$( "#btnACS" )
			.button()
			.click(function() {
				var idlist = jQuery("#runtime_eventRegistration_list").jqGrid('getGridParam','selrow');
				
				if(idlist!='')
					{
					var url = "${createLink(controller:'helper',action:'eventGenACS')}"+"?idlist="+idlist
					$('#acsText').load(url)
					$( "#dialogACS" ).dialog("open");
					}
				else
					alert("Select at least 1 record for generating ACS!!");
			});

		$( "#dialogACS" ).dialog({
			autoOpen: false,
			//height: 600,
			width: 800,
			modal: true,
			buttons: {
				"Print": function() {
					PrintDiv('acsText');
				},
				Cancel: function() {
					$('#acsText').text('')
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});


	        });

		 function refresh() {
		 	jQuery('#runtime_eventRegistration_list').trigger('reloadGrid');
		 	jQuery('#runtime_eventRegistration_summary_list').trigger('reloadGrid');
		 }

		 function afterSubmitEvent(response, postdata) {
			jQuery('#runtime_eventRegistration_summary_list').trigger('reloadGrid');
			var success = true;

			var json = eval('(' + response.responseText + ')');
			var message = json.message;

			/*if(json.state == 'FAIL') {
			    success = false;
			} else {
			  $('#message').html(message);
			  $('#message').show().fadeOut(10000);
			}*/

			var new_id = json.id
			return [success,message,new_id];
		    }

		function getGLName() {
			var grid = jQuery('#runtime_eventRegistration_summary_list');
			var sel_id = grid.jqGrid('getGridParam', 'selrow');
			var cellData = grid.jqGrid('getCell', sel_id, 'glname');
			return cellData;
		}
		function getGLPhone() {
			var grid = jQuery('#runtime_eventRegistration_summary_list');
			var sel_id = grid.jqGrid('getGridParam', 'selrow');
			var cellData = grid.jqGrid('getCell', sel_id, 'phone');
			return cellData;
		}

		function PrintDiv(divName) {    
		   var divToPrint = document.getElementById(divName);
		   var popupWin = window.open('', '_blank', 'width=600,height=300');
		   popupWin.document.open();
		   popupWin.document.write('<html><body onload="window.print()">' + divToPrint.innerHTML + '</html>');
		    popupWin.document.close();
                }
                
		// ]]></script>
	</body>
</html>


