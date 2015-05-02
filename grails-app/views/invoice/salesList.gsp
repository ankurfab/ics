
<%@ page import="ics.Invoice" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Sales Invoice Management</title>
	<r:require module="grid" />
	<r:require module="dateTimePicker" />
	<r:require module="qtip" />
	<r:require module="printarea" />
    </head>
    <body>

	<style>
		.lex {
		    color: green;
		    text-decoration: underline;
		}	
	</style>

	<script>
	function qTip(node) {
	    var url = node.attr("href");
	    node.qtip({
		content: {
		    text: "loading...",
		    ajax: {
			url: url,
			type: 'post',
			data: { html: 'test' }
		    }
		},
		show: {
		            ready: true // Show it immediately
        }
	    });
	}
	</script>
			
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <div id="divToPrint"></div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="invoice_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="invoice_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="lineitem_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="lineitem_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
	    <g:hiddenField name="editurl" value="" />
        </div>

<script>
  $(document).ready(function () {
    var lastsel3; 
    jQuery("#invoice_list").jqGrid({
      url:'jq_invoice_list?type=SALES',
      editurl:'jq_edit_invoice?type=SALES',
      datatype: "json",
      colNames:['Number','Date','From','FromDepartment','To','ToCostCenter','DueDate','ItemTotal','Extra','Discount','InvoiceAmount','Status','Description','Comments','Mode','PaymentReference','Id'],
      colModel:[
	{name:'invoiceNumber', search:true, editable: false},
	{name:'invoiceDate', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy',defaultDate: new Date()}); 
				  }}
	},
	{name:'from', search:true, editable: false},
	{name:'departmentBy.id', search:true, editable: true, editrules:{required:false},
		edittype:"select",
		editoptions:{value:"${':--Please Select Department--;'+(ics.Department.findAllByName('Kitchen',[sort:'name'])?.collect{it.id+':'+it.toString()}.join(';'))}"},
		stype:'select', searchoptions: { value: "${':--Please Select Department--;'+(ics.Department.findAllByName('Kitchen',[sort:'name'])?.collect{it.id+':'+it.toString()}.join(';'))}"}
	},
	{name:'personTo', search:true, editable: true},
	{name:'departmentTo.id', search:true, editable: true, editrules:{required:false},
		edittype:"select",
		editoptions:{value:"${':--Please Select Department--;'+(ics.CostCenter.findAllByStatusIsNull([sort:'name'])?.collect{it.id+':'+it.toString()}.join(';'))}"},
		stype:'select', searchoptions: { value: "${':--Please Select Department--;'+(ics.CostCenter.findAllByStatusIsNull([sort:'name'])?.collect{it.id+':'+it.toString()}.join(';'))}"}
	},	
	{name:'dueDate', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}
	},
	{name:'itemTotalAmount', search:true, editable: false, editrules:{required:false}},
	{name:'extraAmount', search:true, editable: true, editrules:{required:false}},
	{name:'discountAmount', search:true, editable: true, editrules:{required:false}},
	{name:'invoiceAmount', search:true, editable: false, editrules:{required:false}},
	{name:'status', search:true, editable: true, editrules:{required:false},
		edittype:"select",editoptions:{value:"${':--Please Select Status--;DRAFT:DRAFT;PREPARED:PREPARED;SENT:SENT;CANCELLED:CANCELLED;PAID:PAID;HOLD:HOLD'}"},
		formatter:'select',stype:'select', searchoptions: { value: ':ALL;DRAFT:DRAFT;PREPARED:PREPARED;SENT:SENT;CANCELLED:CANCELLED;PAID:PAID;HOLD:HOLD'}
	},
	{name:'description', search:true, editable: true},
	{name:'comments', search:true, editable: true},
	{name:'mode', search:true, editable: true, editrules:{required:false},
		edittype:"select",editoptions:{value:"${':--Please Select Mode--;CASH:CASH;KIND:KIND'}"},
		formatter:'select',stype:'select', searchoptions: { value: ':ALL;CASH:CASH;KIND:KIND'}
	},
	{name:'paymentReference', search:true, editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30],
    pager: '#invoice_list_pager',
    viewrecords: true,
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Sales Invoice List",
    onSelectRow: function(ids) { 
    	if(ids!='new_row')
    		{
    		var selName = jQuery('#invoice_list').jqGrid('getCell', ids, 'invoiceNumber');
		jQuery("#lineitem_list").jqGrid('setGridParam',{url:"jq_lineitem_list?invoiceid="+ids});
		var url = "jq_edit_lineitem?type=SALES&invoice.id="+ids;
		jQuery("#lineitem_list").jqGrid('setGridParam',{editurl:url});
		jQuery("#lineitem_list").jqGrid('setCaption',"Invoice Line Item(s) for Invoice: "+selName).trigger('reloadGrid');   	
		$("#editurl").val(url);
    		}
    	}    
    });
    $("#invoice_list").jqGrid('filterToolbar',{autosearch:true});
    $("#invoice_list").jqGrid('navGrid',"#invoice_list_pager",{edit:false,add:false,del:false,search:false});
    $("#invoice_list").jqGrid('inlineNav',"#invoice_list_pager");

    $("#invoice_list").jqGrid('navGrid',"#invoice_list_pager").jqGrid('navButtonAdd',"#invoice_list_pager",{caption:"Print", buttonicon:"ui-icon-print", onClickButton:print, position: "last", title:"Print", cursor: "pointer"});

    jQuery("#lineitem_list").jqGrid({
      url:'jq_lineitem_list',
      editurl:'jq_edit_lineitem',
      datatype: "json",
      colNames:['ItemName','Qty','UnitSize','Unit','Rate','TaxRate(%)','TotalWithoutTax','TotalWithTax','Id'],
      colModel:[
	{name:'itemname', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).autocomplete({source:'${createLink(controller:'item',action:'allItemsAsJSON_Fuzzy_JQ')}',
					minLength: 0,
					  select: function(event, ui) { // event handler when user selects an  item from the list.
					  	var newURL = $("#editurl").val();
					  	newURL += "&item.id="+ui.item.id;
    					   jQuery("#lineitem_list").jqGrid('setGridParam',{editurl:newURL});
					  }					
					}); 
				  }}
	},
	{name:'qty', search:true, editable: true},
	{name:'unitSize', search:true, editable: true},
	{name:'unit', search:true, editable: true, editrules:{required:true},
		edittype:"select",editoptions:{value:"${':--Please Select Unit--;'+(ics.Unit.values())?.collect{it.toString()+':'+it.toString()}.join(';')}"},
		formatter:'select',stype:'select', searchoptions: { value: "${':ALL;'+(ics.Unit.values())?.collect{it.toString()+':'+it.toString()}.join(';')}"}
	},
	{name:'rate', search:true, editable: true},
	{name:'taxRate', search:true, editable: true},
	{name:'totalWithoutTax', search:true, editable: true},
	{name:'totalWithTax', search:true, editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30],
    pager: '#lineitem_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Sales Line Item(s)"
    });
    $("#lineitem_list").jqGrid('filterToolbar',{autosearch:true});
    $("#lineitem_list").jqGrid('navGrid',"#lineitem_list_pager",{edit:false,add:false,del:true,search:false});
    $("#lineitem_list").jqGrid('inlineNav',"#lineitem_list_pager");

	function print() {
		var id = $('#invoice_list').jqGrid('getGridParam','selrow');
		if(id) {
				var url = "${createLink(controller:'Invoice',action:'print')}"+"?id="+id
				/*$.getJSON(url, {}, function(data) {
					$('#divToPrint').html(data.message).printArea();
				    });	*/
				$( "#divToPrint" ).load( url, function(responseTxt,statusTxt,xhr){
				    if(statusTxt=="success")
				    {
				      $('#divToPrint').printArea();
					$( "#divToPrint" ).hide();
				      }
				    if(statusTxt=="error")
				      alert("Error: "+xhr.status+": "+xhr.statusText);
				  });
		}
		else
			alert("Please select a row!!");
		/*$("#dialogPrint").html("");
		$("#dialogPrint").dialog("option", "title", "Loading...").dialog("open");
		$("#dialogPrint").load("${createLink(controller:'Invoice',action:'print',id:id)}", function() {
			$(this).dialog("option", "title", $(this).find("h1").text());
			$(this).find("h1").remove();
		});*/
	}

	/*$("#dialogPrint").dialog({
		autoOpen: false,
		modal: true,
		width: 600,
		height: 300,
		buttons: {
			"Dismiss": function() {
				$(this).dialog("close");
			}
		}
	});*/

        function editLink(cellValue, options, rowdata, action)
        {
            var url = "${createLink(controller:'Individual',action:'show')}"+"?id="+rowdata[7];
            if(cellValue)
            	return "<a href='"+url+"' class='lex' >"+cellValue+"</a>";
            else
            	return ''
        }

	    $('.lex').on('mouseover', function() {
		var _self = $(this);
		qTip(_self);
	    });
	    $('a.lex').click(function(e) {
	        e.preventDefault();
	        //do other stuff when a click happens
		});

	function autocomplete_element(value, options) {
	  // creating input element
	  var $ac = $('<input type="text"/>');
	  // setting value to the one passed from jqGrid
	  $ac.val(value);
	  // creating autocomplete
	  $ac.autocomplete({source: "${createLink(controller:'item',action:'allItemsAsJSON_JQ')}"});
	  // returning element back to jqGrid
	  return $ac;
	}

	function autocomplete_value(elem, op, value) {
	  if (op == "set") {
	    $(elem).val(value);
	  }
	  return $(elem).val();
	}

    });
</script>


    </body>
</html>
