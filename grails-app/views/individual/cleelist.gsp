<%@ page import="ics.Individual"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>Individual Management</title>
<r:require module="grid" />
<r:require module="export" />
</head>
<body>
	<div class="nav">
		<span class="menuButton"><a class="ist"
			href="${createLink(uri: '/')}"><g:message
					code="default.home.label" /></a></span>
		<sec:ifAnyGranted roles="ROLE_COUNSELLOR">
			<!--<span class="menuButton"><g:link class="create" action="createprofile" params="[type: 'Counsellee']">New Counsellee</g:link></span>
			<span class="menuButton"><g:link class="create" action="createprofile" params="[type: 'Wellwisher']">New WellWisher</g:link></span>-->
		</sec:ifAnyGranted>

	</div>
	<div class="body">
	
		Type: <g:select name="type" from="${['Counsellee','Wellwisher','All']}" value="${'All'}"
		  noSelection="['':'-Choose individual type-']" onChange="gridReload()"/>

		<table id="counsellee_list" class="scroll jqTable" cellpadding="0"
			cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="counsellee_list_pager" class="scroll"
			style="text-align: center;"></div>
		 <input class="menuButton" type="BUTTON" id="mergeBtn" value="MergeRecords" />
		 <input class="menuButton" type="BUTTON" id="cleeBtn" value="MarkAsCounsellee" />
		 <input class="menuButton" type="BUTTON" id="wwBtn" value="MarkAsWellwisher" />

	</div>

	<script>
  $(document).ready(function () {
    jQuery("#counsellee_list").jqGrid({
        url:'jq_counsellee_list',
        editurl:'jq_edit_cclist',
        datatype: "json",
        colNames:['Legal Name','Initiated Name','DoB','MarriageAnniversary','Contact','Email','Category','Address','Type','Id'],
        colModel:[
    {name:'legalName', editable:true,editrules:{required:true},sortable:true,
		formatter:'showlink', 
 		formatoptions:{baseLinkUrl:'show',addParam: '&dashboard=true'}
        },
  	{name:'initiatedName', editable:true,editrules:{required:true},sortable:true},
  	{name:'dob'},
  	{name:'marriageAnniversary'},
  	{name:'voiceContact', search:true, editable:true, editrules:{required:true, integer:true, minValue:0, maxValue:9999999999}},
  	{name:'emailContact', search:true, editable:true, editrules:{required:true, email:true}},
  	{name:'category', search:false, editable:true,hidden:true},
  	{name:'address', search:true, editable:true, editrules:{required:true, email:true}},
  	{name:'relation.name',editable:false,search:false},
  	{name:'id',hidden:true}
       ],
      rowNum:10,
      rowList:[10,20,30,40,50,100,200,500,1000],
      pager: '#counsellee_list_pager',
      viewrecords: true,
      sortorder: "asc",
      width: 1200,
      height: "100%",
      caption:"Individual List",
      multiselect: true
      });
      $("#counsellee_list").jqGrid('filterToolbar',{autosearch:true});
      $("#counsellee_list").jqGrid('navGrid',"#counsellee_list_pager",{edit:false,add:false,del:true,search:false});

	$( "#mergeBtn" )
		.button()
		.click(function() {
			var ids = jQuery("#counsellee_list").jqGrid('getGridParam','selarrrow');
			if(ids) {
					var url = "${createLink(controller:'individual',action:'mergeRecords')}"+"?idList="+ids
					$.getJSON(url, {}, function(data) {
						alert(data.message);
						jQuery("#counsellee_list").jqGrid().trigger("reloadGrid");
					    });	
			}
			else
				alert("Please select rows!!");
		});
	$( "#cleeBtn" )
		.button()
		.click(function() {
			var ids = jQuery("#counsellee_list").jqGrid('getGridParam','selarrrow');
			if(ids) {
					var url = "${createLink(controller:'individual',action:'changeRelation')}"+"?type=Counsellee&idList="+ids
					$.getJSON(url, {}, function(data) {
						alert(data.message);
						jQuery("#counsellee_list").jqGrid().trigger("reloadGrid");
					    });	
			}
			else
				alert("Please select rows!!");
		});

	$( "#wwBtn" )
		.button()
		.click(function() {
			var ids = jQuery("#counsellee_list").jqGrid('getGridParam','selarrrow');
			if(ids) {
					var url = "${createLink(controller:'individual',action:'changeRelation')}"+"?type=Wellwisher&idList="+ids
					$.getJSON(url, {}, function(data) {
						alert(data.message);
						jQuery("#counsellee_list").jqGrid().trigger("reloadGrid");
					    });	
			}
			else
				alert("Please select rows!!");
		});


  });

		function gridReload(){
			var query = "type="+$('#type').val();
			    
			//alert(query);
			jQuery("#counsellee_list").jqGrid('setCaption',"Individual List ("+$('#type').val()+")");
			jQuery("#counsellee_list").jqGrid('setGridParam',{url:"jq_counsellee_list?"+query}).trigger("reloadGrid");

		}
  
    </script>

</body>
</html>

