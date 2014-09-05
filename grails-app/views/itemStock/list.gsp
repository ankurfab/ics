
<%@ page import="ics.ItemStock" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'itemStock.label', default: 'ItemStock')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<r:require module="grid" />
	</head>
	<body>
		<!-- table tag will hold our grid -->
		<table id="stock_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="stock_list_pager" class="scroll" style="text-align:center;"></div>

		<script type="text/javascript">
		  $(document).ready(function () {
		    jQuery("#stock_list").jqGrid({
		      url:'jq_stock_list',
		      editurl:'jq_edit_stock',
		      datatype: "json",
		      colNames:['Name','OtherNames','Category','Variety','Brand','Qty','Unit','Rate','id'],
		      colModel:[
			{name:'name', editable:true},
			{name:'otherNames', editable:true},
			{name:'category', editable:true},
			{name:'variety', editable:true},
			{name:'brand', editable:true},
			{name:'qty', editable:true},
			{name:'unit', editable:true},
			{name:'rate', editable:true},
			{name:'id',hidden:true}
		     ],
		    rowNum:10,
		    rowList:[10,20,30,40,50,100,200],
		    pager: '#stock_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortorder: "asc",
		    width: 960,
		    height: "100%",
		    caption:"Stock List"
		    });
		   $("#stock_list").jqGrid('filterToolbar',{autosearch:true});
		   jQuery("#stock_list").jqGrid('navGrid',"#stock_list_pager",{edit:false,add:false,del:true});
		   $("#stock_list").jqGrid('inlineNav',"#stock_list_pager");

		$("#btnMatch").click(function(){
			var gr = jQuery("#person_list").jqGrid('getGridParam','selrow');
			if( gr != null )
				{
				var grid = jQuery('#person_list');
				var sel_id = grid.jqGrid('getGridParam', 'selrow');
				var url = "${createLink(controller:'person',action:'match',params:['category':session.individualid])}"+"\u0026"+"id="+sel_id;
				window.location = url;
				}
			else
				alert("Please Select Row"); });

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

		function gridReload(code){
			jQuery("#person_list").jqGrid('setGridParam',{url:"jq_person_list?code="+code}).trigger("reloadGrid");
			}


		</script>

	</body>
</html>
