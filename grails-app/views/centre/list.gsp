
<%@ page import="ics.Centre" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'centre.label', default: 'Centre')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<r:require module="grid" />
	</head>
	<body>
		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
		</div>
		<div class="body">
		<!-- table tag will hold our grid -->
		<table id="centre_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="centre_list_pager" class="scroll" style="text-align:center;"></div>

		<!-- table tag will hold our grid -->
		<table id="department_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="department_list_pager" class="scroll" style="text-align:center;"></div>
		</div>

		<script type="text/javascript">
		  $(document).ready(function () {
		    jQuery("#centre_list").jqGrid({
		      url:'jq_centre_list',
		      editurl:'jq_edit_centre',
		      datatype: "json",
		      colNames:['Name','Address','Description','id'],
		      colModel:[
			{name:'name', editable:true},
			{name:'address', editable:true,
				    /*'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
   					 }*/
			},
			{name:'description', editable:true},
			{name:'id',hidden:true}
		     ],
		    rowNum:10,
		    rowList:[10,20,30,40,50],
		    pager: '#centre_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortname: 'name',
		    sortorder: "asc",
		    width: 1200,
		    height: "100%",
		    caption:"Centre List",
			onSelectRow: function(ids) {
						var selCentreName = jQuery('#centre_list').jqGrid('getCell', ids, 'name');
						jQuery("#department_list").jqGrid('setGridParam',{url:"${createLink(controller:'department',action:'jq_depcentre_list',params:['centre.id':''])}"+ids,page:1});
						jQuery("#department_list").jqGrid('setGridParam',{editurl:"${createLink(controller:'department',action:'jq_edit_depcentre',params:['centre.id':''])}"+ids});
						jQuery("#department_list").jqGrid('setCaption',"Department List for Centre: "+selCentreName) .trigger('reloadGrid');
					}
		    });
		   $("#centre_list").jqGrid('navGrid',"#centre_list_pager",
			{add:true,edit:true,del:true}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New Centre',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
		    );

		jQuery("#department_list").jqGrid({ 
			height: "100%",
			width: 1200,
			url:'${createLink(controller:'department',action:'jq_depcentre_list',params:['centre.id':0])}', 
			editurl:'${createLink(controller:'department',action:'jq_edit_depcentre',params:['centre.id':0])}', 
			datatype: "json", 
			colNames:['Name','Description','Alias','id'], 
			colModel:[
				{name:'name', editable:true},
				{name:'description', editable:true},
				{name:'alias', editable:true},
				{name:'id',hidden:true}
				], 
			rowNum:5, 
			rowList:[5,10,20],
			pager: '#department_list_pager', 
			sortname: 'name', 
			viewrecords: true, 
			sortorder: "asc", 
			caption:"Department List" }).navGrid('#department_list_pager',{add:true,edit:true,del:true}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New Department',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
			); 

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
