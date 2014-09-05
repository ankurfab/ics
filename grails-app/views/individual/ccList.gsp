<%@ page import="ics.Individual"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>Counsellor - Counsellee Management</title>
<r:require module="grid" />
<r:require module="export" />
</head>
<body>
	<div class="nav">
		<span class="menuButton"><a class="ist"
			href="${createLink(uri: '/')}"><g:message
					code="default.home.label" /></a></span>
		<sec:ifAnyGranted roles="ROLE_DATA_CLEAN">
		<span class="menuButton"><g:link class="list"
				controller="helper" action="searchIndividual">SearchIndividual</g:link></span>
		</sec:ifAnyGranted>
		<sec:ifAnyGranted roles="ROLE_VOICE_ADMIN">
		<span class="menuButton"><g:link controller="individual" action="createprofile">New Profile</g:link></span>
		</sec:ifAnyGranted>
	</div>
	<div class="body">

		<!-- table tag will hold our grid -->
		<table id="counsellor_list" class="scroll jqTable" cellpadding="0"
			cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="counsellor_list_pager" class="scroll"
			style="text-align: center;"></div>
		<sec:ifAnyGranted roles="ROLE_DATA_CLEAN">
		<input class="menuButton" type="BUTTON" id="mergeBtn" value="MergeRecords" />
		</sec:ifAnyGranted>

		<table id="counsellee_list" class="scroll jqTable" cellpadding="0"
			cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="counsellee_list_pager" class="scroll"
			style="text-align: center;"></div>
		<sec:ifAnyGranted roles="ROLE_DATA_CLEAN">
		<input class="menuButton" type="BUTTON" id="mergeBtnClee" value="MergeRecords" />
		</sec:ifAnyGranted>

	</div>

	<script>
  $(document).ready(function () {

		$( "#counsellor" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allCounsellorsAsJSON_JQ')}",
			minLength: 0,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $("#counsellorid").val(ui.item.id); // update the hidden field.
			  }
		});
		
    jQuery("#counsellor_list").jqGrid({
      url:'jq_counsellor_list',
      editurl:'jq_edit_cclist',
      datatype: "json",
      colNames:['Name','Guru Name', 'Contact','Email','Category','Id'],
      colModel:[
	{name:'name', editable:true,editrules:{required:true},sortable:true,
		formatter:'showlink', 
 		formatoptions:{baseLinkUrl:'show'}
	},
	{name:'guruName', search:false, editable:true, editrules:{required:true}},
	{name:'voiceContact', search:false, editable:true, editrules:{required:true, integer:true, minValue:0, maxValue:9999999999}},
	{name:'emailContact', search:false, editable:true, editrules:{required:true, email:true}},
	{name:'category', search:false, editable:true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#counsellor_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    caption:"Counsellor List",
    multiselect: true,
    onSelectRow: function(ids) { 
    	var selConsellorName = jQuery('#counsellor_list').jqGrid('getCell', ids, 'name');
    	jQuery("#counsellee_list").jqGrid('setCaption',"Counsellee list for : "+selConsellorName);    	
    	jQuery("#counsellee_list").jqGrid('setGridParam',{url:"jq_counsellee_list?counsellorid="+ids}).trigger('reloadGrid');    	
    	}    
    });
    $("#counsellor_list").jqGrid('filterToolbar',{autosearch:true});
    $("#counsellor_list").jqGrid('navGrid',"#counsellor_list_pager",{edit:false,add:false,del:true,search:false});


    jQuery("#counsellee_list").jqGrid({
        url:'jq_counsellee_list',
        editurl:'jq_edit_cclist',
        datatype: "json",
        colNames:['Legal Name','Initiated Name','Contact','Email','Category','Id'],
        colModel:[
    {name:'legalName', editable:true,editrules:{required:true},sortable:true,
		formatter:'showlink', 
 		formatoptions:{baseLinkUrl:'show'}
        },
  	{name:'initiatedName', editable:true,editrules:{required:true},sortable:true},
  	{name:'voiceContact', search:true, editable:true, editrules:{required:true, integer:true, minValue:0, maxValue:9999999999}},
  	{name:'emailContact', search:true, editable:true, editrules:{required:true, email:true}},
  	{name:'category', search:false, editable:true},
  	{name:'id',hidden:true}
       ],
      rowNum:10,
      rowList:[10,20,30,40,50,100,200],
      pager: '#counsellee_list_pager',
      viewrecords: true,
      sortorder: "asc",
      width: 1200,
      height: "100%",
      caption:"Counsellee List",
      multiselect: true
      });
      $("#counsellee_list").jqGrid('filterToolbar',{autosearch:true});
      $("#counsellee_list").jqGrid('navGrid',"#counsellee_list_pager",{edit:false,add:false,del:true,search:false});

	$( "#mergeBtn" )
		.button()
		.click(function() {
			var ids = jQuery("#counsellor_list").jqGrid('getGridParam','selarrrow');
			if(ids) {
					var url = "${createLink(controller:'individual',action:'mergeRecords')}"+"?idList="+ids
					$.getJSON(url, {}, function(data) {
						alert(data.message);
					    });	
			}
			else
				alert("Please select rows!!");
		});

	$( "#mergeBtnClee" )
		.button()
		.click(function() {
			var ids = jQuery("#counsellee_list").jqGrid('getGridParam','selarrrow');
			if(ids) {
					var url = "${createLink(controller:'individual',action:'mergeRecords')}"+"?idList="+ids
					$.getJSON(url, {}, function(data) {
						alert(data.message);
					    });	
			}
			else
				alert("Please select rows!!");
		});

  });
  
    </script>

</body>
</html>

