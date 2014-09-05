
<%@ page import="ics.Book" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
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
		<table id="book_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="book_list_pager" class="scroll" style="text-align:center;"></div>

		<!-- table tag will hold our grid -->
		<table id="bookRead_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="bookRead_list_pager" class="scroll" style="text-align:center;"></div>
		<input class="menuButton" type="BUTTON" id="btnSMS_BRList" value="SMS" gridName="#bookRead_list" entityName="BookRead"/>
		<input class="menuButton" type="BUTTON" id="btnEMAIL_BRList" value="EMAIL" gridName="#bookRead_list" entityName="BookRead"/>
		</div>

		<script type="text/javascript">
		  $(document).ready(function () {
		    jQuery("#book_list").jqGrid({
		      url:'jq_book_list',
		      editurl:'jq_edit_book',
		      datatype: "json",
		      colNames:['Name','Author','Category','id'],
		      colModel:[
			{name:'name', editable:true},
			{name:'author', editable:true},
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
		    pager: '#book_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortname: 'name',
		    sortorder: "asc",
		    width: 1200,
		    height: "100%",
		    caption:"Book List",
			onSelectRow: function(ids) {
						var selBookName = jQuery('#book_list').jqGrid('getCell', ids, 'name');
						jQuery("#bookRead_list").jqGrid('setGridParam',{url:"${createLink(controller:'bookRead',action:'jq_depbook_list',params:['book.id':''])}"+ids,page:1});
						jQuery("#bookRead_list").jqGrid('setGridParam',{editurl:"${createLink(controller:'bookRead',action:'jq_edit_depbook',params:['book.id':''])}"+ids});
						jQuery("#bookRead_list").jqGrid('setCaption',"BookRead List for Book: "+selBookName) .trigger('reloadGrid');
					}
		    });
		   $("#book_list").jqGrid('navGrid',"#book_list_pager",
			{add:true,edit:true,del:true}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New Book',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
		    );
		   $("#book_list").jqGrid('filterToolbar',{autosearch:true});


		jQuery("#bookRead_list").jqGrid({ 
			height: "100%",
			width: 1200,
			url:'${createLink(controller:'bookRead',action:'jq_depbook_list',params:['book.id':0])}', 
			editurl:'${createLink(controller:'bookRead',action:'jq_edit_depbook',params:['book.id':0])}', 
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
			pager: '#bookRead_list_pager', 
			multiselect: true,
			sortname: 'name', 
			viewrecords: true, 
			sortorder: "asc", 
			caption:"BookRead List" }).navGrid('#bookRead_list_pager',{add:false,edit:false,del:false}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New BookRead',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
			); 
		  	$("#bookRead_list").jqGrid('filterToolbar',{autosearch:true});


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
