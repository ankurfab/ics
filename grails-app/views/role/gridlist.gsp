
<%@ page import="ics.Role" %>
<!doctype html>
<html>
	<head>
        	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<r:require module="grid" />
	</head>
	<body>
		<g:render template="/common/apisms" />
		<g:render template="/common/mandrillemail" />

		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
		</div>
		<div class="body">
		<!-- table tag will hold our grid -->
		<table id="role_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="role_list_pager" class="scroll" style="text-align:center;"></div>
		<input class="menuButton" type="BUTTON" id="btnSMS_RoleList" value="SMS_ALL" gridName="#role_list" entityName="Role"  departmentId="${ics.Department.findByName('TMC')?.id}"/>
		<input class="menuButton" type="BUTTON" id="btnEMAIL_RoleList" value="EMAIL_ALL" gridName="#role_list" entityName="Role" departmentId="${ics.Department.findByName('TMC')?.id}"/>

		<!-- table tag will hold our grid -->
		<table id="individualRole_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="individualRole_list_pager" class="scroll" style="text-align:center;"></div>
		<input class="menuButton" type="BUTTON" id="btnSMS_IndividualRoleList" value="SMS" gridName="#individualRole_list" entityName="IndividualRole"  departmentId="${ics.Department.findByName('TMC')?.id}"/>
		<input class="menuButton" type="BUTTON" id="btnEMAIL_IndividualRoleList" value="EMAIL" gridName="#individualRole_list" entityName="IndividualRole" departmentId="${ics.Department.findByName('TMC')?.id}"/>
		</div>

		<script type="text/javascript">
		  $(document).ready(function () {
		    jQuery("#role_list").jqGrid({
		      url:'jq_role_list',
		      editurl:'jq_edit_role',
		      datatype: "json",
		      colNames:['Name','Description','Category','id'],
		      colModel:[
			{name:'name', editable:true,
				formatter:'showlink', 
				formatoptions:{baseLinkUrl:'show'}
			},
			{name:'description', editable:true},
			{name:'category', editable:true,
				stype:'select', searchoptions: { value: "${':ALL;'+(ics.Role.createCriteria().list{projections{distinct('category')}}?.collect{it+':'+it}.join(';'))}"}
				    /*'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
   					 }*/
			},
			{name:'id',hidden:true}
		     ],
		    rowNum:10,
		    rowList:[5,10,20,30,50,100],
		    pager: '#role_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortname: 'name',
		    sortorder: "asc",
		    width: 1200,
		    height: "100%",
		    multiselect: true,
		    caption:"Role List",
			onSelectRow: function(ids) {
						var selRoleName = jQuery('#role_list').jqGrid('getCell', ids, 'name');
						jQuery("#individualRole_list").jqGrid('setGridParam',{url:"${createLink(controller:'individualRole',action:'jq_deprole_list',params:['role.id':''])}"+ids,page:1});
						jQuery("#individualRole_list").jqGrid('setGridParam',{editurl:"${createLink(controller:'individualRole',action:'jq_edit_deprole',params:['role.id':''])}"+ids});
						jQuery("#individualRole_list").jqGrid('setCaption',"IndividualRole List for Role: "+selRoleName) .trigger('reloadGrid');
					}
		    });
		   $("#role_list").jqGrid('navGrid',"#role_list_pager",
			{add:false,edit:false,del:false}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New Role',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
		    );
		   $("#role_list").jqGrid('filterToolbar',{autosearch:true});


		jQuery("#individualRole_list").jqGrid({ 
			height: "100%",
			width: 1200,
			url:'${createLink(controller:'individualRole',action:'jq_deprole_list',params:['role.id':0])}', 
			editurl:'${createLink(controller:'individualRole',action:'jq_edit_deprole',params:['role.id':0])}', 
			datatype: "json", 
			colNames:['Photo','Individual','Phone','Email','Description','Department','Centre','Remarks','Status','id'], 
			colModel:[
				{
				name: 'photo',
				formatter: function (cellvalue, options, rowObject) {
					    return '<img height="70" width="70" src="${createLink(controller:'Individual',action:'avatar_image')}?id='+rowObject[0]+ '"/>'; 
					}
				},				
				{name:'name', editable:false,
					formatter:'showlink', 
					formatoptions:{baseLinkUrl:'${createLink(controller:'IndividualRole',action:'show')}'}				
				},
				{name:'phone', editable:false,search:false},
				{name:'email', editable:false,search:false},
				{name:'description', editable:false,search:false},
				{name:'department', editable:true},
				{name:'centre', editable:true},
				{name:'remarks', editable:true},
				{name:'status', editable:true},
				{name:'id',hidden:true}
				], 
			rowNum:5, 
			rowList:[5,10,20,30,50,100],
			pager: '#individualRole_list_pager', 
			multiselect: true,
			sortname: 'name', 
			viewrecords: true, 
			sortorder: "asc", 
			caption:"IndividualRole List" }).navGrid('#individualRole_list_pager',{add:false,edit:false,del:false}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New IndividualRole',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
			); 
		  	$("#individualRole_list").jqGrid('filterToolbar',{autosearch:true});
	// add custom button to export the detail data to excel	
	jQuery("#individualRole_list").jqGrid('navGrid',"#individualRole_list_pager").jqGrid('navButtonAdd',"#individualRole_list_pager",{caption:"Export", buttonicon:"ui-icon-disk",title:"Export",
	       onClickButton : function () { 
			var url = formUrl();			
			jQuery("#individualRole_list").jqGrid('excelExport',{"url":url});
	       }
	       });


		  });


		function formUrl() {
			var idlist = jQuery("#role_list").jqGrid('getGridParam','selarrrow');
			if(idlist=='')	//try for multipleselect=false case
				idlist = jQuery("#role_list").jqGrid('getGridParam','selrow');
			if(idlist==null)
				idlist=''
			var url = "${createLink(controller:'individualRole',action:'jq_indrole_list_export')}"+"?roleids="+idlist

			return url;
		}

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

		function autocomplete_element(value, options) {
		  // creating input element
		  var $ac = $('<input type="text"/>');
		  // setting value to the one passed from jqGrid
		  $ac.val(value);
		  // creating autocomplete
		  $ac.autocomplete({source: "${createLink(controller:'item',action:'list')}"+".json"});
		  // returning element back to jqGrid
		  return $ac;
		}

		function autocomplete_value(elem, op, value) {
			alert(elem) 
			alert(op) 
			alert(value)
		  if (op == "set") {
		    $(elem).val(value);
		  }
		  return $(elem).val();
		}

		</script>
	</body>
</html>
