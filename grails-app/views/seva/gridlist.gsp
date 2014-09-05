
<%@ page import="ics.Seva" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'seva.label', default: 'Seva')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<r:require module="grid" />
	</head>
	<body>
		<g:render template="/common/sms" />
		<g:render template="/common/email" />

		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
		</div>
		<div class="body">
		<!-- table tag will hold our grid -->
		<table id="seva_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="seva_list_pager" class="scroll" style="text-align:center;"></div>

		<!-- table tag will hold our grid -->
		<table id="individualSeva_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="individualSeva_list_pager" class="scroll" style="text-align:center;"></div>
		<input class="menuButton" type="BUTTON" id="btnSMS_ISList" value="SMS" gridName="#individualSeva_list" entityName="IndividualSeva"/>
		<input class="menuButton" type="BUTTON" id="btnEMAIL_ISList" value="EMAIL" gridName="#individualSeva_list" entityName="IndividualSeva"/>
		</div>

		<script type="text/javascript">
		  $(document).ready(function () {
		    jQuery("#seva_list").jqGrid({
		      url:'jq_seva_list',
		      editurl:'jq_edit_seva',
		      datatype: "json",
		      colNames:['Name','Description','Type','Category','id'],
		      colModel:[
			{name:'name', editable:true},
			{name:'description', editable:true},
			{name:'type', editable:true},
			{name:'category', editable:true,
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
		    pager: '#seva_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortname: 'name',
		    sortorder: "asc",
		    width: 1200,
		    height: "100%",
		    caption:"Seva List",
			onSelectRow: function(ids) {
						var selSevaName = jQuery('#seva_list').jqGrid('getCell', ids, 'name');
						jQuery("#individualSeva_list").jqGrid('setGridParam',{url:"${createLink(controller:'individualSeva',action:'jq_depseva_list',params:['seva.id':''])}"+ids,page:1});
						jQuery("#individualSeva_list").jqGrid('setGridParam',{editurl:"${createLink(controller:'individualSeva',action:'jq_edit_depseva',params:['seva.id':''])}"+ids});
						jQuery("#individualSeva_list").jqGrid('setCaption',"IndividualSeva List for Seva: "+selSevaName) .trigger('reloadGrid');
					}
		    });
		   $("#seva_list").jqGrid('navGrid',"#seva_list_pager",
			{add:true,edit:true,del:true}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New Seva',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
		    );
		   $("#seva_list").jqGrid('filterToolbar',{autosearch:true});


		jQuery("#individualSeva_list").jqGrid({ 
			height: "100%",
			width: 1200,
			url:'${createLink(controller:'individualSeva',action:'jq_depseva_list',params:['seva.id':0])}', 
			editurl:'${createLink(controller:'individualSeva',action:'jq_edit_depseva',params:['seva.id':0])}', 
			datatype: "json", 
			colNames:['Individual','Phone','Email','id'], 
			colModel:[
				{name:'name', editable:false},
				{name:'phone', editable:false,search:false},
				{name:'email', editable:false,search:false},
				{name:'id',hidden:true}
				], 
			rowNum:5, 
			rowList:[5,10,20,30,50,100],
			pager: '#individualSeva_list_pager', 
			multiselect: true,
			sortname: 'name', 
			viewrecords: true, 
			sortorder: "asc", 
			caption:"IndividualSeva List" }).navGrid('#individualSeva_list_pager',{add:false,edit:false,del:false}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New IndividualSeva',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
			); 
		  	$("#individualSeva_list").jqGrid('filterToolbar',{autosearch:true});


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
