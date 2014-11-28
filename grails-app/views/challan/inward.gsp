
<%@ page import="ics.Challan" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Inward Entry</title>
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

		<div id="dialogPrintChallan" title="Print Challan?">
			<div id="divToPrint"></div>
		</div>
            

		<div id="dialogPayForm" title="Payment Reference">
			<g:render template="/paymentReference/paymentReference" />
		</div>

		<div id="dialogNewBookForm" title="Add New Item">
			<g:render template="/item/addItem" />
		</div>

           <div>
			<!-- table tag will hold our grid -->
			<table id="challan_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="challan_list_pager" class="scroll" style="text-align:center;"></div>
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
    jQuery("#challan_list").jqGrid({
      url:'jq_challan_list?type=INWARD',
      editurl:'jq_edit_challan?type=INWARD',
      datatype: "json",
      colNames:['InvoiceNo','Date','Supplier','InvoiceAmount','Status','Comments','DueDate','PaymentReference','fromid','Id'],
      colModel:[
	{name:'refNo', search:true, editable: true},
	{name:'issueDate', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy',defaultDate: new Date()}); 
				  }}
	},
	{name:'from', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).autocomplete({source:'${createLink(controller:'challan',action:'allSuppliersAsJSON_JQ')}',
					minLength: 1,
					  select: function(event, ui) { // event handler when user selects an  item from the list.
					  	var newURL = $("#editurl").val();
					  	newURL += "&item.id="+ui.item.id;
    					   jQuery("#lineitem_list").jqGrid('setGridParam',{editurl:newURL});
					  }					
					}); 
				  }},
		formatter:showIndividual 
	},
	{name:'challanAmount', search:true, editable: true, editrules:{required:false}},
	{name:'status', search:true, editable: true, editrules:{required:false},
		edittype:"select",editoptions:{value:"${':--Please Select Status--;DRAFT:DRAFT;PREPARED:PREPARED;SENT:SENT;CANCELLED:CANCELLED;PAID:PAID;HOLD:HOLD'}"},
		formatter:'select',stype:'select', searchoptions: { value: ':ALL;DRAFT:DRAFT;PREPARED:PREPARED;SENT:SENT;CANCELLED:CANCELLED;PAID:PAID;HOLD:HOLD'}
	},
	{name:'comments', search:true, editable: true},
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
    pager: '#challan_list_pager',
    viewrecords: true,
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Inward Invoice List",
    onSelectRow: function(ids) { 
    	if(ids!='new_row')
    		{
		var selName = jQuery('#challan_list').jqGrid('getCell', ids, 'challanNumber');
		jQuery("#lineitem_list").jqGrid('setGridParam',{url:"jq_lineitem_list?challanid="+ids});
		var url = "jq_edit_lineitem?type=INWARD&challan.id="+ids;
		jQuery("#lineitem_list").jqGrid('setGridParam',{editurl:url});
		jQuery("#lineitem_list").jqGrid('setCaption',"Challan Line Item(s) for Challan: "+selName).trigger('reloadGrid');   	
		$("#editurl").val(url);
		}
    	}    
    });
    $("#challan_list").jqGrid('filterToolbar',{autosearch:true});
    $("#challan_list").jqGrid('navGrid',"#challan_list_pager",{edit:false,add:false,del:true,search:false});
    $("#challan_list").jqGrid('inlineNav',"#challan_list_pager");

    $("#challan_list").jqGrid('navGrid',"#challan_list_pager").jqGrid('navButtonAdd',"#challan_list_pager",{caption:"NewSupplier", buttonicon:"ui-icon-document", onClickButton:newSupplier, position: "last", title:"NewSupplier", cursor: "pointer"});
    $("#challan_list").jqGrid('navGrid',"#challan_list_pager").jqGrid('navButtonAdd',"#challan_list_pager",{caption:"Print", buttonicon:"ui-icon-print", onClickButton:print, position: "last", title:"Print", cursor: "pointer"});
    $("#challan_list").jqGrid('navGrid',"#challan_list_pager").jqGrid('navButtonAdd',"#challan_list_pager",{caption:"Pay", buttonicon:"ui-icon-calculator", onClickButton:pay, position: "last", title:"Pay", cursor: "pointer"});

    jQuery("#lineitem_list").jqGrid({
      url:'jq_lineitem_list',
      editurl:'jq_edit_lineitem',
      datatype: "json",
      colNames:['BookName','Qty','Rate','bookid','Id'],
      colModel:[
	{name:'bookname', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).autocomplete({source:'${createLink(controller:'book',action:'allBooksAsJSON_JQ')}',
					minLength: 0,
					  select: function(event, ui) { // event handler when user selects an  item from the list.
					  	var newURL = $("#editurl").val();
					  	if(ui.item.id)
					  		newURL += "&item.id="+ui.item.id;
    					   jQuery("#lineitem_list").jqGrid('setGridParam',{editurl:newURL});
					  }					
					}); 
				  }},
		formatter:showBook
	},
	{name:'qty', search:true, editable: true},
	{name:'rate', search:true, editable: true},
	{name:'bookid',hidden:true},
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
    caption:"Invoice Line Item(s)"
    });
    $("#lineitem_list").jqGrid('filterToolbar',{autosearch:true});
    $("#lineitem_list").jqGrid('navGrid',"#lineitem_list_pager",{edit:false,add:false,del:false,search:false});
    $("#lineitem_list").jqGrid('inlineNav',"#lineitem_list_pager");
    $("#lineitem_list").jqGrid('navGrid',"#lineitem_list_pager").jqGrid('navButtonAdd',"#lineitem_list_pager",{caption:"NewBook", buttonicon:"ui-icon-document", onClickButton:newBook, position: "last", title:"NewItem", cursor: "pointer"});

	function print() {
		var id = $('#challan_list').jqGrid('getGridParam','selrow');
		if(id) {
				var url = "${createLink(controller:'Challan',action:'print')}"+"?id="+id;
				/*$.getJSON(url, {}, function(data) {
					$('#divToPrint').html(data.message).printArea();
				    });	*/
				$( "#divToPrint" ).val("");
				$( "#divToPrint" ).load( url, function(responseTxt,statusTxt,xhr){
				    if(statusTxt=="success")
				    {
					$( "#dialogPrintChallan" ).dialog( "open" );	
				    }
				    if(statusTxt=="error")
				      alert("Error: "+xhr.status+": "+xhr.statusText);
				  });
		}
		else
			alert("Please select a row!!");
		/*$("#dialogPrint").html("");
		$("#dialogPrint").dialog("option", "title", "Loading...").dialog("open");
		$("#dialogPrint").load("${createLink(controller:'Challan',action:'print',id:id)}", function() {
			$(this).dialog("option", "title", $(this).find("h1").text());
			$(this).find("h1").remove();
		});*/
	}

	 $( "#dialogPrintChallan" ).dialog({
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
			var url = "${createLink(controller:'Challan',action:'checkTrip')}"+"?id="+id;
			$.getJSON(url, {}, function(data) {
				jQuery("#trip_list").jqGrid().trigger("reloadGrid");
				alert(data.message);
			    });
		}
		else
			alert("Please select a row!!");
	}


	function pay() {
		var ids = $('#challan_list').jqGrid('getGridParam','selarrrow');
		if(ids) {
				$( "#dialogPayForm" ).dialog( "open" );
		}
		else
			alert("Please select a row!!");
	}

	function newBook() {
		$( "#dialogNewBookForm" ).dialog( "open" );
	}

	function newSupplier() {
		alert("coming soon..");
	}

        function showIndividual(cellValue, options, rowdata, action)
        {
            var url = "${createLink(controller:'Individual',action:'show')}"+"?id="+rowdata[14];
            if(cellValue)
            	return "<a href='"+url+"' target='_new'>"+cellValue+"</a>";
            else
            	return ''
        }

        function showBook(cellValue, options, rowdata, action)
        {
            var url = "${createLink(controller:'Book',action:'show')}"+"?id="+rowdata[9];
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
					    $("#challanids").val($('#challan_list').jqGrid('getGridParam','selarrrow'));
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

		$( "#dialogNewBookForm" ).dialog({
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
