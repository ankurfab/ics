
<%@ page import="ics.Invoice" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Purchase Invoice Management</title>
	<r:require module="grid" />
	<r:require module="dateTimePicker" />
	<r:require module="qtip" />
	<r:require module="printarea" />
	<r:require module="ajaxform"/>
    </head>
    <body>

	<style>
		.lex {
		    color: green;
		    text-decoration: underline;
		}	
	</style>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">

		<div id="dialogPrintInvoice" title="Print Invoice?">
			<div id="divToPrint"></div>
		</div>
            

		<div id="dialogPayForm" title="Payment Reference">
			<g:render template="/paymentReference/paymentReference" />
		</div>

		<div id="dialogNewItemForm" title="Add New Item">
			<g:render template="/item/addItem" />
		</div>

             <div>
			<!-- table tag will hold our grid -->
			<table id="trip_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="trip_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
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
	    <g:hiddenField name="iediturl" value="" />
	    <g:hiddenField name="editurl" value="" />
        </div>

<script>
  $(document).ready(function () {
    var lastsel3; 

    jQuery("#trip_list").jqGrid({
      url:'jq_trip_list?type=PURCHASE',
      editurl:'jq_edit_trip?type=PURCHASE',
      datatype: "json",
      colNames:['StartDateTime','EndDateTime','Incharge','Driver','Vehicle','Comments','AmountTaken','Balance','CashPurchase','CreditPurchase','Donation Received','Total Purchase','Ideal Balance','Id'],
      colModel:[
	{name:'departureTime', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datetimepicker({dateFormat:'dd-mm-yy',defaultDate: new Date()}); 
				  }}	
	},
	{name:'arrivalTime', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datetimepicker({dateFormat:'dd-mm-yy',defaultDate: new Date()}); 
				  }}	
	},
	{name:'incharge.id', search:true, editable: true,
        	edittype:"select",editoptions:{value:"${':--Please Select Incharge--;'+(ics.IndividualDepartment.createCriteria().list{eq('status','ACTIVE') department{ilike('name','%Kitchen%')}  }?.collect{it.individual?.id+':'+it.individual?.toString()}.join(';'))}"},
        	stype:'select', searchoptions:{value:"${':--Please Select Incharge--;'+(ics.IndividualDepartment.createCriteria().list{eq('status','ACTIVE') department{ilike('name','%Kitchen%')} }?.collect{it.individual?.id+':'+it.individual?.toString()}.join(';'))}"}
		},
	{name:'driver.id', search:true, editable: true,
        	edittype:"select",editoptions:{value:"${':--Please Select Incharge--;'+(ics.IndividualDepartment.createCriteria().list{eq('status','ACTIVE') department{ilike('name','%Kitchen%')}  }?.collect{it.individual?.id+':'+it.individual?.toString()}.join(';'))}"},
        	stype:'select', searchoptions:{value:"${':--Please Select Incharge--;'+(ics.IndividualDepartment.createCriteria().list{eq('status','ACTIVE') department{ilike('name','%Kitchen%')} }?.collect{it.individual?.id+':'+it.individual?.toString()}.join(';'))}"}
	},
	{name:'vehicle.id', search:true, editable: true,
        	edittype:"select",editoptions:{value:"${':--Please Select Vehicle--;'+(ics.Vehicle.list([sort:"regNum"])?.collect{it.id+':'+it.toString()}.join(';'))}"},
        	stype:'select', searchoptions: {value:"${':--Please Select Vehicle--;'+(ics.Vehicle.list([sort:"regNum"])?.collect{it.id+':'+it.toString()}.join(';'))}"}
		},
	{name:'comments', search:true, editable: true},
	{name:'amountTaken', search:true, editable: true, editrules:{required:false}},
	{name:'balance', search:true, editable: true, editrules:{required:false}},
	{name:'cashPurchase', search:true, editable: false, editrules:{required:false}},
	{name:'creditPurchase', search:true, editable: false},
	{name:'donationReceived', search:true, editable: false},
	{name:'totalPurchase', search:true, editable: false},
	{name:'idealBalance', search:true, editable: false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30],
    pager: '#trip_list_pager',
    viewrecords: true,
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Purchase Trip List",
    onSelectRow: function(ids) { 
    	if(ids!='new_row')
    		{
		var selName = jQuery('#trip_list').jqGrid('getCell', ids, 'departureTime');
		jQuery("#invoice_list").jqGrid('setGridParam',{url:"jq_invoice_list?type=PURCHASE&purchaseTrip.id="+ids});
		var url = "jq_edit_invoice?type=PURCHASE&purchaseTrip.id="+ids;
		jQuery("#invoice_list").jqGrid('setGridParam',{editurl:url});
		jQuery("#invoice_list").jqGrid('setCaption',"Purchase Invoice(s) for trip: "+selName).trigger('reloadGrid');   	
		$("#iediturl").val(url);

		jQuery("#lineitem_list").jqGrid('setGridParam',{url:"jq_lineitem_list?type=PURCHASE"});
		var url = "jq_edit_lineitem?type=PURCHASE";
		jQuery("#lineitem_list").jqGrid('setGridParam',{editurl:url});
		jQuery("#lineitem_list").jqGrid('setCaption',"Invoice Line Item(s)").trigger('reloadGrid');   	
		$("#editurl").val(url);

		}
    	}    
    });
    $("#trip_list").jqGrid('filterToolbar',{autosearch:true});
    $("#trip_list").jqGrid('navGrid',"#trip_list_pager",{edit:false,add:false,del:true,search:false});
    $("#trip_list").jqGrid('inlineNav',"#trip_list_pager");
    $("#trip_list").jqGrid('navGrid',"#trip_list_pager").jqGrid('navButtonAdd',"#trip_list_pager",{caption:"Check", buttonicon:"ui-icon-flag", onClickButton:check, position: "last", title:"Check", cursor: "pointer"});

    jQuery("#invoice_list").jqGrid({
      url:'jq_invoice_list?type=PURCHASE',
      editurl:'jq_edit_invoice?type=PURCHASE',
      datatype: "json",
      colNames:['InvoiceNo','Date','Vendor','ItemTotal','ItemTotalWithTax','Extra','Discount','InvoiceAmount','Status','Description','Comments','Mode','DueDate','PaymentReference','fromid','Id'],
      colModel:[
	{name:'invoiceNumber', search:true, editable: true},
	{name:'invoiceDate', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy',defaultDate: new Date()}); 
				  }}
	},
	{name:'from', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).autocomplete({source:'${createLink(controller:'invoice',action:'allVendorsAsJSON_JQ')}',
					minLength: 0,
					  select: function(event, ui) { // event handler when user selects an  item from the list.
					  	var newURL = $("#editurl").val();
					  	newURL += "&item.id="+ui.item.id;
    					   jQuery("#lineitem_list").jqGrid('setGridParam',{editurl:newURL});
					  }					
					}); 
				  }},
		formatter:showIndividual 
	},
	{name:'itemTotalAmount', search:true, editable: true, editrules:{required:false}},
	{name:'itemTotalAmountWithTax', search:true, editable: true, editrules:{required:false}},
	{name:'extraAmount', search:true, editable: true, editrules:{required:false}},
	{name:'discountAmount', search:true, editable: true, editrules:{required:false}},
	{name:'invoiceAmount', search:true, editable: true, editrules:{required:false}},
	{name:'status', search:true, editable: true, editrules:{required:false},
		edittype:"select",editoptions:{value:"${':--Please Select Status--;DRAFT:DRAFT;PREPARED:PREPARED;SENT:SENT;CANCELLED:CANCELLED;PAID:PAID;HOLD:HOLD'}"},
		formatter:'select',stype:'select', searchoptions: { value: ':ALL;DRAFT:DRAFT;PREPARED:PREPARED;SENT:SENT;CANCELLED:CANCELLED;PAID:PAID;HOLD:HOLD'}
	},
	{name:'description', search:true, editable: true},
	{name:'comments', search:true, editable: true},
	{name:'mode', search:true, editable: true, editrules:{required:false},
		edittype:"select",editoptions:{value:"${':--Please Select Mode--;CASH:CASH;CREDIT:CREDIT;DONATION:DONATION'}"},
		formatter:'select',stype:'select', searchoptions: { value: ':ALL;CASH:CASH;CREDIT:CREDIT;DONATION:DONATION'}
	},
	{name:'dueDate', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}
	},
	{name:'paymentReference', search:true, editable: true},
	{name:'fromid',hidden:true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30],
    pager: '#invoice_list_pager',
    viewrecords: true,
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Purchase Invoice List",
    onSelectRow: function(ids) { 
    	if(ids!='new_row')
    		{
		var selName = jQuery('#invoice_list').jqGrid('getCell', ids, 'invoiceNumber');
		jQuery("#lineitem_list").jqGrid('setGridParam',{url:"jq_lineitem_list?invoiceid="+ids});
		var url = "jq_edit_lineitem?type=PURCHASE&invoice.id="+ids;
		jQuery("#lineitem_list").jqGrid('setGridParam',{editurl:url});
		jQuery("#lineitem_list").jqGrid('setCaption',"Invoice Line Item(s) for Invoice: "+selName).trigger('reloadGrid');   	
		$("#editurl").val(url);
		}
    	}    
    });
    $("#invoice_list").jqGrid('filterToolbar',{autosearch:true});
    $("#invoice_list").jqGrid('navGrid',"#invoice_list_pager",{edit:false,add:false,del:true,search:false});
    $("#invoice_list").jqGrid('inlineNav',"#invoice_list_pager");

    $("#invoice_list").jqGrid('navGrid',"#invoice_list_pager").jqGrid('navButtonAdd',"#invoice_list_pager",{caption:"Print", buttonicon:"ui-icon-print", onClickButton:print, position: "last", title:"Print", cursor: "pointer"});
    $("#invoice_list").jqGrid('navGrid',"#invoice_list_pager").jqGrid('navButtonAdd',"#invoice_list_pager",{caption:"Pay", buttonicon:"ui-icon-calculator", onClickButton:pay, position: "last", title:"Pay", cursor: "pointer"});

    jQuery("#lineitem_list").jqGrid({
      url:'jq_lineitem_list',
      editurl:'jq_edit_lineitem',
      datatype: "json",
      colNames:['ItemName','Qty','UnitSize','Unit','Rate','TaxRate(%)','TotalWithoutTax','TotalWithTax','Description','Item Id','Id'],
      colModel:[
	{name:'itemname', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).autocomplete({source:'${createLink(controller:'item',action:'allItemsAsJSON_Fuzzy_JQ')}',
					minLength: 0,
					  select: function(event, ui) { // event handler when user selects an  item from the list.
					  	var newURL = $("#editurl").val();
					  	if(ui.item.id)
					  		newURL += "&item.id="+ui.item.id;
    					   jQuery("#lineitem_list").jqGrid('setGridParam',{editurl:newURL});
					  }					
					}); 
				  }},
		formatter:showItem
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
	{name:'description', search:true, editable: true},
	{name:'itemid',hidden:true},
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
    caption:"Purchase Line Item(s)"
    });
    $("#lineitem_list").jqGrid('filterToolbar',{autosearch:true});
    $("#lineitem_list").jqGrid('navGrid',"#lineitem_list_pager",{edit:false,add:false,del:false,search:false});
    $("#lineitem_list").jqGrid('inlineNav',"#lineitem_list_pager");
    $("#lineitem_list").jqGrid('navGrid',"#lineitem_list_pager").jqGrid('navButtonAdd',"#lineitem_list_pager",{caption:"NewItem", buttonicon:"ui-icon-document", onClickButton:newItem, position: "last", title:"NewItem", cursor: "pointer"});

	function print() {
		var id = $('#invoice_list').jqGrid('getGridParam','selrow');
		if(id) {
				var url = "${createLink(controller:'Invoice',action:'print')}"+"?id="+id;
				/*$.getJSON(url, {}, function(data) {
					$('#divToPrint').html(data.message).printArea();
				    });	*/
				$( "#divToPrint" ).val("");
				$( "#divToPrint" ).load( url, function(responseTxt,statusTxt,xhr){
				    if(statusTxt=="success")
				    {
					$( "#dialogPrintInvoice" ).dialog( "open" );	
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

	 $( "#dialogPrintInvoice" ).dialog({
		autoOpen: false,
		 width:800,
		 height:500,
		modal: true,
		buttons: {
		"Print": function() {
		$('#divToPrint').printArea();
		$( this ).dialog( "close" );
		},
		Cancel: function() {
		$( this ).dialog( "close" );
		}
		}
	});

	function check() {
		var id = $('#trip_list').jqGrid('getGridParam','selrow');
		if(id) {
			var url = "${createLink(controller:'Invoice',action:'checkTrip')}"+"?id="+id;
			$.getJSON(url, {}, function(data) {
				jQuery("#trip_list").jqGrid().trigger("reloadGrid");
				alert(data.message);
			    });
		}
		else
			alert("Please select a row!!");
	}


	function pay() {
		var ids = $('#invoice_list').jqGrid('getGridParam','selarrrow');
		if(ids) {
				$( "#dialogPayForm" ).dialog( "open" );
		}
		else
			alert("Please select a row!!");
	}

	function newItem() {
		$( "#dialogNewItemForm" ).dialog( "open" );
	}

        function showIndividual(cellValue, options, rowdata, action)
        {
            var url = "${createLink(controller:'Individual',action:'show')}"+"?id="+rowdata[14];
            if(cellValue)
            	return "<a href='"+url+"' target='_new'>"+cellValue+"</a>";
            else
            	return ''
        }

        function showItem(cellValue, options, rowdata, action)
        {
            var url = "${createLink(controller:'Item',action:'show')}"+"?id="+rowdata[9];
            if(cellValue)
            	return "<a href='"+url+"' target='_new'>"+cellValue+"</a>";
            else
            	return ''
        }


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


	    $('.lex').on('mouseover', function() {
		var _self = $(this);
		qTip(_self);
	    });
	    $('a.lex').click(function(e) {
	        e.preventDefault();
	        //do other stuff when a click happens
		});



// We'll encapsulate our .qtip() call in your .on() handler method
$(document).on('mouseover', 'a.lex', function(event) {
    // Bind the qTip within the event handler
    $(this).qtip({
        overwrite: false, // Make sure the tooltip won't be overridden once created
        content: {
		    text: "loading...",
		    ajax: {
			url: url,
			type: 'post',
			data: { html: 'test' }
		    }
		},
        show: {
            event: event.type, // Use the same show event as the one that triggered the event handler
            ready: true // Show the tooltip as soon as it's bound, vital so it shows up the first time you hover!
        }
    }, event); // Pass through our original event to qTip
});


		$( "#dialogPayForm" ).dialog({
			autoOpen: false,
			height: 400,
			width: 300,
			modal: true,
			buttons: {
				"Submit": function() {
					    $("#invoiceids").val($('#invoice_list').jqGrid('getGridParam','selarrrow'));
					    $("#formPaymentReference").ajaxForm({
						success: function() {alert("Payment reference submitted");}
					    }).submit();
						
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

		$( "#dialogNewItemForm" ).dialog({
			autoOpen: false,
			height: 500,
			width: 300,
			modal: true,
			buttons: {
				"Submit": function() {
					    $("#formAddItem").ajaxForm({
						success: function() {alert("New Item added!");}
					    }).submit();
						
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});


    });
</script>


    </body>
</html>
