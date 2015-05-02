
<%@ page import="ics.Book" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<r:require module="grid" />
		<r:require module="dateTimePicker" />
	</head>
	<body>
		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
		</div>
		<div class="body">

			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

		<!-- table tag will hold our grid -->
		<table id="book_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="book_list_pager" class="scroll" style="text-align:center;"></div>

		<!-- table tag will hold our grid -->
		<table id="bookstock_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="bookstock_list_pager" class="scroll" style="text-align:center;"></div>
		</div>

		<div>
		Upload book stock in bulk: <br />
		    <g:uploadForm action="uploadBookStock">
			<input type="file" name="myFile" />
			<input type="submit" value="Upload"/>
		    </g:uploadForm>
		</div>

		<script type="text/javascript">
		  $(document).ready(function () {
		    jQuery("#book_list").jqGrid({
		      url:'jq_book_list',
		      editurl:'jq_edit_book',
		      datatype: "json",
		      colNames:['Name','Author','Publisher','Category','Type','Language','Alias','CostPrice','SellPrice','Stock','ReorderLevel','id'],
		      colModel:[
			{name:'name', editable:true},
			{name:'author', editable:true,editrules:{required:true}},
			{name:'publisher', editable:true},
			{name:'category', editable:true,
				edittype:"select",editoptions:{value:"${'MahaBig:MahaBig;Big:Big;Medium:Medium;Small:Small;Other:Other'}"},
				formatter:'select',stype:'select', searchoptions: { value: ':ALL;MahaBig:MahaBig;Big:Big;Medium:Medium;Small:Small;Other:Other'}
			},
			{name:'type', editable:true,
				edittype:"select",editoptions:{value:"${'Normal:Normal;Deluxe:Deluxe;Pocket:Pocket;Other:Other'}"},
				formatter:'select',stype:'select', searchoptions: { value: ':ALL;Normal:Normal;Deluxe:Deluxe;Pocket:Pocket;Other:Other'}
			},
			{name:'language', editable:true,
				edittype:"select",editoptions:{value:"${'English:English;Hindi:Hindi;Bengali:Bengali;Gujarati:Gujarati;Kannada:Kannada;Malayalam:Malayalam;Marathi:Marathi;Nepali:Nepali;Odiya:Odiya;Punjabi:Punjabi;Sindhi:Sindhi;Tamil:Tamil;Telugu:Telugu;Urdu:Urdu'}"},
				formatter:'select',stype:'select', searchoptions: { value: ':ALL;English:English;Hindi:Hindi;Bengali:Bengali;Gujarati:Gujarati;Kannada:Kannada;Malayalam:Malayalam;Marathi:Marathi;Nepali:Nepali;Odiya:Odiya;Punjabi:Punjabi;Sindhi:Sindhi;Tamil:Tamil;Telugu:Telugu;Urdu:Urdu'}
			},
			{name:'alias', editable:true},
			{name:'costPrice', editable:true},
			{name:'sellPrice', editable:true},
			{name:'stock', editable:true},
			{name:'reorderLevel', editable:true},
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
					if(ids!='new_row')
						{
						var sel = jQuery('#book_list').jqGrid('getCell', ids, 'name');
						jQuery("#bookstock_list").jqGrid('setCaption',"Stock/Price List for Book: "+sel);
						$("#editurl").val("jq_edit_bookstock?bookid="+ids);
						jQuery("#bookstock_list").jqGrid('setGridParam',{url:"jq_bookstock_list?bookid="+ids,editurl:"jq_edit_bookstock?bookid="+ids}).trigger('reloadGrid');    	
						}
					}
		    });
		   $("#book_list").jqGrid('navGrid',"#book_list_pager",
			{add:true,edit:true,del:true}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New Book',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
		    );
		   $("#book_list").jqGrid('filterToolbar',{autosearch:true});


		jQuery("#bookstock_list").jqGrid({ 
			height: "100%",
			width: 1200,
			url:'jq_bookstock_list', 
			editurl:'jq_edit_bookstock', 
			datatype: "json", 
			colNames:['StockDate','Quantity','Price','id'], 
			colModel:[
				{name:'stockDate', search:true, editable: true,
					editoptions:{ 
							  dataInit:function(el){ 
								$(el).datepicker({dateFormat:'dd-mm-yy'}); 
							  }}	
				},
				{name:'stock', editable:true},
				{name:'price', editable:true,search:false},
				{name:'id',hidden:true}
				], 
			rowNum:5, 
			rowList:[5,10,20,30,50,100],
			pager: '#bookstock_list_pager', 
			multiselect: false,
			sortname: 'name', 
			viewrecords: true, 
			sortname: 'id',
			sortorder: "desc",
			caption:"BookStock List"
			});
		    $("#bookstock_list").jqGrid('filterToolbar',{autosearch:false});
		    $("#bookstock_list").jqGrid('navGrid',"#bookstock_list_pager",{edit:false,add:false,del:true,search:false});
		    $("#bookstock_list").jqGrid('inlineNav',"#bookstock_list_pager");


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
