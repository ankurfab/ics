
<%@ page import="ics.Challan" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Challan Management</title>
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

		<div id="dialogPrintChallan" title="Print Challan">
			<div id="divToPrintChallan"></div>
		</div>
            
		<div id="dialogPrintPaymentReference" title="Print Payment Receipt">
			<div id="divToPrintPaymentReference"></div>
		</div>

		<div id="dialogPayForm" title="Payment Reference">
			<g:render template="/paymentReference/paymentReferenceChallan" />
		</div>            

		<div id="dialogTeam" title="Team">
			<div class="dialog">
				<table border="1">
					<tr>
						<td>
							Team Members
						</td>
						<td>
							<g:textField name="teamMembers" value="" placeholder="Please enter comma seperated team member names" size="150" rows="5" cols="40"/>
						</td>
					</tr>
				</table>
			</div>
		</div>            

		<div id="dialogSettleForm" title="Challan Settlement">
			<div id="divToSettleChallan">
			</div>
		</div>            

		<div id="dialogPrintSettlement" title="Print Challan Settlement">
			<div id="divToPrintSettlement"></div>
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
            <div>
			<!-- table tag will hold our grid -->
			<table id="payment_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="payment_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="expense_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="expense_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
	    <g:hiddenField name="iediturl" value="" />
	    <g:hiddenField name="editurl" value="" />
        </div>

<script>
  $(document).ready(function () {

    var editOptions = {
            keys: true,
            successfunc: function () {
                var $self = $(this);
                setTimeout(function () {
                    $self.trigger("reloadGrid");
                }, 50);
            }
    };

    jQuery("#challan_list").jqGrid({
      url:'jq_challan_list?type=OUTWARD',
      editurl:'jq_edit_challan?type=OUTWARD',
      datatype: "json",
      colNames:['ChallanNo','ChallanDate','IssuedTo','Status','Comments','SettleDate','ChallanAmount','PaymentsReceived','Expenses','ReturnValue','SaleValue','SettleAmount','AdvanceAmount','toid','Id'],
      colModel:[
	{name:'refNo', search:true, editable: false},
	{name:'issueDate', search:true, editable: false,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy',defaultDate: new Date()}); 
				  }}
	},
	{name:'issuedTo', search:true, editable: false,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).autocomplete({source:'${createLink(controller:'challan',action:'allDevoteesAsJSON_JQ')}',
					minLength: 1,
					  select: function(event, ui) { // event handler when user selects an  item from the list.
					  	var newURL = $("#editurl").val();
					  	newURL += "&item.id="+ui.item.id;
    					   jQuery("#lineitem_list").jqGrid('setGridParam',{editurl:newURL});
					  }					
					}); 
				  }},
		//formatter:showIndividual 
	},
	{name:'status', search:true, editable: false, editrules:{required:false},
		edittype:"select",editoptions:{value:"${':--Please Select Status--;DRAFT:DRAFT;PREPARED:PREPARED;SETTLED:SETTLED;CANCELLED:CANCELLED'}"},
		formatter:'select',stype:'select', searchoptions: { value: ':ALL;DRAFT:DRAFT;PREPARED:PREPARED;SETTLED:SETTLED;CANCELLED:CANCELLED'}
	},
	{name:'comments', search:true, editable: true},
	{name:'settleDate', search:true, editable: false,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}
	},
	{name:'totalAmount', search:false, editable: false, editrules:{required:false}},
	{name:'paymentAmount', search:false, editable: false},
	{name:'expenseAmount', search:false, editable: false},
	{name:'returnValue', search:false, editable: false},
	{name:'saleValue', search:false, editable: false},
	{name:'settleAmount', search:false, editable: false},
	{name:'advanceAmount', search:false, editable: true},
	{name:'toid',hidden:true},
	{name:'id',hidden:true}
     ],
    rowNum:5,
    rowList:[5,10,20,30],
    pager: '#challan_list_pager',
    viewrecords: true,
    sortname: "id",
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Challan List",
    onSelectRow: function(ids) { 
    	if(ids!='new_row')
    		{
		var selName = jQuery('#challan_list').jqGrid('getCell', ids, 'refNo');
		
		//set detail grid for challan line items
		jQuery("#lineitem_list").jqGrid('setGridParam',{url:"jq_lineitem_list?challanid="+ids});
		var url = "jq_edit_lineitem?type=OUTWARD&challan.id="+ids;
		jQuery("#lineitem_list").jqGrid('setGridParam',{editurl:url});
		jQuery("#lineitem_list").jqGrid('setCaption',"Challan Line Item(s) for Challan: "+selName).trigger('reloadGrid');   	
		$("#editurl").val(url);

		//set detail grid for payments
		jQuery("#payment_list").jqGrid('setGridParam',{url:"jq_payment_list?challanid="+ids});
		var url = "jq_edit_payment?type=OUTWARD&challan.id="+ids;
		jQuery("#payment_list").jqGrid('setGridParam',{editurl:url});
		jQuery("#payment_list").jqGrid('setCaption',"Payment(s) for Challan: "+selName).trigger('reloadGrid');   	

		//set detail grid for expenses
		jQuery("#expense_list").jqGrid('setGridParam',{url:"jq_expense_list?challanid="+ids});
		var url = "jq_edit_expense?type=OUTWARD&challan.id="+ids;
		jQuery("#expense_list").jqGrid('setGridParam',{editurl:url});
		jQuery("#expense_list").jqGrid('setCaption',"Expense(s) for Challan: "+selName).trigger('reloadGrid');   	

		}
    	}    
    });
    $("#challan_list").jqGrid('filterToolbar',{autosearch:true});
    $("#challan_list").jqGrid('navGrid',"#challan_list_pager",{edit:false,add:false,del:true,search:false});
    $("#challan_list").jqGrid('inlineNav',"#challan_list_pager",
	    { 
	       edit: true,
	       add: false,
	       save: true,
	       cancel: true,
	    }
    );

    $("#challan_list").jqGrid('navGrid',"#challan_list_pager").jqGrid('navButtonAdd',"#challan_list_pager",{caption:"Prepare", buttonicon:"ui-icon-document", onClickButton:prepareChallan, position: "last", title:"Prepare", cursor: "pointer"});
    $("#challan_list").jqGrid('navGrid',"#challan_list_pager").jqGrid('navButtonAdd',"#challan_list_pager",{caption:"Pay", buttonicon:"ui-icon-calculator", onClickButton:pay, position: "last", title:"Pay", cursor: "pointer"});
    $("#challan_list").jqGrid('navGrid',"#challan_list_pager").jqGrid('navButtonAdd',"#challan_list_pager",{caption:"Settle", buttonicon:"ui-icon-check", onClickButton:settle, position: "last", title:"Settle", cursor: "pointer"});
    $("#challan_list").jqGrid('navGrid',"#challan_list_pager").jqGrid('navButtonAdd',"#challan_list_pager",{caption:"Team", buttonicon:"ui-icon-script", onClickButton:team, position: "last", title:"Team", cursor: "pointer"});
    $("#challan_list").jqGrid('navGrid',"#challan_list_pager").jqGrid('navButtonAdd',"#challan_list_pager",{caption:"Print", buttonicon:"ui-icon-print", onClickButton:printChallan, position: "last", title:"Print", cursor: "pointer"});
    /*$("#challan_list").jqGrid('navGrid',"#challan_list_pager").jqGrid('navButtonAdd',"#challan_list_pager",{caption:"SettleAndClose", buttonicon:"ui-icon-check", onClickButton:settleAndClose, position: "last", title:"SettleAndClose", cursor: "pointer"});
    $("#challan_list").jqGrid('navGrid',"#challan_list_pager").jqGrid('navButtonAdd',"#challan_list_pager",{caption:"SettleAndCarryForward", buttonicon:"ui-icon-newwin", onClickButton:settleAndCarryForward, position: "last", title:"SettleAndCarryForward", cursor: "pointer"});*/

    jQuery("#lineitem_list").jqGrid({
      url:'jq_lineitem_list',
      editurl:'jq_edit_lineitem',
      datatype: "json",
      colNames:['Name','Rate','IssuedQty','ReturnQty','SoldQty','SaleValue','bookid','Id'],
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
		//formatter:showBook
	},
	{name:'rate', search:true, editable: true},
	{name:'issuedQuantity', search:true, editable: true},
	{name:'returnedQuantity', search:true, editable: true},
	{name:'soldQuantity', search:false, editable: false},
	{name:'sellValue', search:false, editable: false},
	{name:'bookid',hidden:true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[5,10,20,30],
    pager: '#lineitem_list_pager',
    viewrecords: true,
    sortname: 'bookname',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Challan Line Item(s)"
    });
    $("#lineitem_list").jqGrid('filterToolbar',{autosearch:true});
    $("#lineitem_list").jqGrid('navGrid',"#lineitem_list_pager",{edit:false,add:false,del:true,search:false});
    $("#lineitem_list").jqGrid('inlineNav',"#lineitem_list_pager",
	{
	    addParams: {
		addRowParams: editOptions
	    },
	    editParams: editOptions
	}        
    );
    //$("#lineitem_list").jqGrid('navGrid',"#lineitem_list_pager").jqGrid('navButtonAdd',"#lineitem_list_pager",{caption:"NewBook", buttonicon:"ui-icon-document", onClickButton:newBook, position: "last", title:"NewItem", cursor: "pointer"});

    jQuery("#payment_list").jqGrid({
      url:'jq_payment_list',
      editurl:'jq_edit_payment',
      datatype: "json",
      colNames:['Amount','Mode','Details','Date','Reference','Id'],
      colModel:[
	{name:'amount', search:true, editable: true},
	{name:'mode.id', search:true, editable: true,
        	edittype:"select",editoptions:{value:"${':--Please Select Mode--;'+(ics.PaymentMode.findAllByInperson(true,[sort:'name'])?.collect{it.id+':'+it.name}.join(';'))}"},
        	stype:'select', searchoptions: {value:"${':--Please Select Mode--;'+(ics.PaymentMode.findAllByInperson(true,[sort:'name'])?.collect{it.id+':'+it.name}.join(';'))}"}
	},
	{name:'details', search:true, editable: true},
	{name:'paymentDate', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy',defaultDate: new Date()}); 
				  }}
	},
	{name:'ref', search:true, editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:5,
    rowList:[5,10,20,30],
    pager: '#payment_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: 'desc',
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Payment(s)"
    });
    //$("#payment_list").jqGrid('filterToolbar',{autosearch:true});
    $("#payment_list").jqGrid('navGrid',"#payment_list_pager",{edit:false,add:false,del:false,search:false});
    $("#payment_list").jqGrid('inlineNav',"#payment_list_pager",
	    { 
	       edit: false,
	       add: true,
	       save: true,
	       cancel: true,
	    }
	);
    $("#payment_list").jqGrid('navGrid',"#payment_list_pager").jqGrid('navButtonAdd',"#payment_list_pager",{caption:"Print", buttonicon:"ui-icon-print", onClickButton:printPaymentReference, position: "last", title:"Print", cursor: "pointer"});

    jQuery("#expense_list").jqGrid({
      url:'jq_expense_list',
      editurl:'jq_edit_expense',
      datatype: "json",
      colNames:['Amount','ExpenseDate','Type','Category','Description','RaisedOn','Status','ApprovedAmount','ApprovalDate','ApprovalComments','Id'],
      colModel:[
	{name:'amount', search:true, editable: true},
	{name:'expenseDate', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy',defaultDate: new Date()}); 
				  }}
	},
	{name:'type', search:true, editable: true},
	{name:'category', search:true, editable: true},
	{name:'description', search:true, editable: true},
	{name:'raisedOn', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy',defaultDate: new Date()}); 
				  }}
	},
	{name:'status', search:true, editable: true},
	{name:'approvedAmount', search:true, editable: true},
	{name:'approvalDate', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy',defaultDate: new Date()}); 
				  }}
	},
	{name:'approvalComments', search:true, editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:5,
    rowList:[5,10,20,30],
    pager: '#expense_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Expense(s)"
    });
    //$("#expense_list").jqGrid('filterToolbar',{autosearch:true});
    $("#expense_list").jqGrid('navGrid',"#expense_list_pager",{edit:false,add:false,del:false,search:false});
    $("#expense_list").jqGrid('inlineNav',"#expense_list_pager",
	{
	    addParams: {
		addRowParams: editOptions
	    },
	    editParams: editOptions
	}    
    );

	function prepareChallan() {
		var answer = confirm("Are you sure?");
		if (!answer){
			return false;
			}
		var id = $('#challan_list').jqGrid('getGridParam','selrow');
		if(id) {
				var url = "${createLink(controller:'Challan',action:'prepareChallan')}"+"?challanid="+id;
				$( "#divToPrintChallan" ).val("");
				$( "#divToPrintChallan" ).load( url, function(responseTxt,statusTxt,xhr){
				    if(statusTxt=="success")
				    {
					jQuery("#challan_list").jqGrid().trigger("reloadGrid");
					$( "#dialogPrintChallan" ).dialog( "open" );	
				    }
				    if(statusTxt=="error")
				      alert("Error: "+xhr.status+": "+xhr.statusText);
				  });
		}
		else
			alert("Please select a row!!");
	}

	function printChallan() {
		var id = $('#challan_list').jqGrid('getGridParam','selrow');
		if(id) {
				var url = "${createLink(controller:'Challan',action:'printChallan')}"+"?challanid="+id;
				$( "#divToPrintChallan" ).val("");
				$( "#divToPrintChallan" ).load( url, function(responseTxt,statusTxt,xhr){
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
	}

	function printPaymentReference() {
		var challanid = $('#challan_list').jqGrid('getGridParam','selrow');
		var prefid = $('#payment_list').jqGrid('getGridParam','selrow');
		if(challanid && prefid) {
				var url = "${createLink(controller:'Challan',action:'printPaymentReference')}"+"?challanid="+challanid+"&paymentReferenceid="+prefid;
				$( "#divToPrintPaymentReference" ).val("");
				$( "#divToPrintPaymentReference" ).load( url, function(responseTxt,statusTxt,xhr){
				    if(statusTxt=="success")
				    {
					$( "#dialogPrintPaymentReference" ).dialog( "open" );	
				    }
				    if(statusTxt=="error")
				      alert("Error: "+xhr.status+": "+xhr.statusText);
				  });
		}
		else
			alert("Please select a row!!");
	}

	 $( "#dialogPrintChallan" ).dialog({
		autoOpen: false,
		 width:800,
		 height:500,
		modal: true,
		buttons: {
		"Print": function() {
		$('#divToPrintChallan').printArea();
		$( this ).dialog( "close" );
		},
		Cancel: function() {
		$( this ).dialog( "close" );
		}
		}
	});

	 $( "#dialogPrintPaymentReference" ).dialog({
		autoOpen: false,
		 width:800,
		 height:500,
		modal: true,
		buttons: {
		"Print": function() {
		$('#divToPrintPaymentReference').printArea();
		$( this ).dialog( "close" );
		},
		Cancel: function() {
		$( this ).dialog( "close" );
		}
		}
	});

	 $( "#dialogPrintSettlement" ).dialog({
		autoOpen: false,
		 width:800,
		 height:600,
		modal: true,
		buttons: {
		"Print": function() {
		$('#divToPrintSettlement').printArea();
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

	function team() {
		var id = $('#challan_list').jqGrid('getGridParam','selrow');
		if(id) {
			var url = "${createLink(controller:'Challan',action:'getTeam')}"+"?challanid="+id;
			$.getJSON(url, {}, function(data) {
				$( "#teamMembers" ).val( data.teamMembers );
				$( "#dialogTeam" ).dialog( "open" );
			    });
		}
		else
			alert("Please select a row!!");
	}

	function settle() {
		var challanid = $('#challan_list').jqGrid('getGridParam','selrow');
		if(challanid) {
			var url = "${createLink(controller:'Challan',action:'settleChallan')}"+"?challanid="+challanid;
			$( "#divToSettleChallan" ).val("");
			$( "#divToSettleChallan" ).load( url, function(responseTxt,statusTxt,xhr){
			    if(statusTxt=="success")
			    {
				$( "#dialogSettleForm" ).dialog( "open" );	
			    }
			    if(statusTxt=="error")
			      alert("Error: "+xhr.status+": "+xhr.statusText);
			  });
		}
		else
			alert("Please select the challan!!");
	}

	function settleAndClose() {
		var answer = confirm("Are you sure?");
		if (answer){
			var challanid = $('#challan_list').jqGrid('getGridParam','selrow');
			if(challanid) {
				var url = "${createLink(controller:'challan',action:'settle')}"+"?challanid="+challanid+"&settleoper=settleAndClose"
				$.getJSON(url, {}, function(data) {
					alert(data.message);
					jQuery("#challan_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select the order!!");
		} else {
		    return false;
		}
	}

	function settleAndCarryForward() {
		var answer = confirm("Are you sure?");
		if (answer){
			var challanid = $('#challan_list').jqGrid('getGridParam','selrow');
			if(challanid) {
				var url = "${createLink(controller:'challan',action:'settle')}"+"?challanid="+challanid+"&settleoper=settleAndCarryForward"
				$.getJSON(url, {}, function(data) {
					alert(data.message);
					jQuery("#challan_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select the order!!");
		} else {
		    return false;
		}
	}

	function newBook() {
		$( "#dialogNewBookForm" ).dialog( "open" );
	}

	function newDevotee() {
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

	$('#formSettleChallan').submit(function(){

	      var url = "${createLink(controller:'Challan',action:'settle')}";
	      
	      // gather the form data
	      var data=$(this).serialize();
	      // post data
	      $.post(url, data , function(returnData){
			  alert(returnData);
			  jQuery("#challan_list").jqGrid().trigger("reloadGrid");
			  // insert returned html 
			  $('#divToPrintSettlement').html( returnData);
			  $( "#dialogPrintSettlement" ).dialog( "open" );
			  
	      })

	      return false; // stops browser from doing default submit process
	});


	$('#formPaymentReference').submit(function(){

	      var url = "${createLink(controller:'Challan',action:'savePaymentReference')}";
	      
	      // gather the form data
	      var data=$(this).serialize();
	      // post data
	      $.post(url, data , function(returnData){
			  $('#amount').val('');
			  $('#details').val('');
			  $('#instrumentNo').val('');
			  $('#instrumentDate').val('');
			  $('#bankName').val('');
			  $('#bankBranch').val('');
			  
			  jQuery("#payment_list").jqGrid().trigger("reloadGrid");
			  jQuery("#challan_list").jqGrid().trigger("reloadGrid");
			  // insert returned html 
			  $('#divToPrintPaymentReference').html( returnData);
			  $( "#dialogPrintPaymentReference" ).dialog( "open" );
			  
	      })

	      return false; // stops browser from doing default submit process
	});


		$( "#dialogPayForm" ).dialog({
			autoOpen: false,
			height: 400,
			width: 300,
			modal: true,
			buttons: {
				"Submit": function() {
					    $("#paymentReferenceEntityId").val($('#challan_list').jqGrid('getGridParam','selrow'));
					    $("#formPaymentReference").submit();					    
						
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

		$( "#dialogTeam" ).dialog({
			autoOpen: false,
			height: 200,
			width: 1000,
			modal: true,
			buttons: {
				"Submit": function() {
					var id = $('#challan_list').jqGrid('getGridParam','selrow');
					var url = "${createLink(controller:'Challan',action:'setTeam')}"+"?challanid="+id+"&teamMembers="+$( "#teamMembers" ).val();
					$.getJSON(url, {}, function(data) {
						$( "#teamMembers" ).val( '' );
						$( this ).dialog( "close" );
					    });
						$( "#teamMembers" ).val( '' );
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
					$( "#teamMembers" ).val( '' );
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

		$( "#dialogSettleForm" ).dialog({
			autoOpen: false,
			height: 650,
			width: 950,
			modal: true,
			buttons: {
				"SettleAndClose": function() {
					    $("#settlechallanid").val($('#challan_list').jqGrid('getGridParam','selrow'));
					    $("#settleoper").val("settleAndClose")
					    //$("#formSettleChallan").submit();					    
					      var url = "${createLink(controller:'Challan',action:'settle')}";

					      // gather the form data
					      var data=$("#formSettleChallan").serialize();
					      // post data
					      $.post(url, data , function(returnData){
							  //alert(returnData);
							  $( "#dialogSettleForm" ).dialog( "close" );
							  jQuery("#challan_list").jqGrid().trigger("reloadGrid");
							  // insert returned html 
							  $('#divToPrintSettlement').html( returnData);
							  $( "#dialogPrintSettlement" ).dialog( "open" );
							})
						
						$( this ).dialog( "close" );
				},
				"SettleAndCarryForward": function() {
					    $("#settlechallanid").val($('#challan_list').jqGrid('getGridParam','selrow'));
					    $("#settleoper").val("settleAndCarryForward")
					    //$("#formSettleChallan").submit();					    
					      var url = "${createLink(controller:'Challan',action:'settle')}";

					      // gather the form data
					      var data=$("#formSettleChallan").serialize();
					      // post data
					      $.post(url, data , function(returnData){
							  //alert(returnData);
							  $( "#dialogSettleForm" ).dialog( "close" );
							  jQuery("#challan_list").jqGrid().trigger("reloadGrid");
							  // insert returned html 
							  $('#divToPrintSettlement').html( returnData);
							  $( "#dialogPrintSettlement" ).dialog( "open" );
							})
						
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
