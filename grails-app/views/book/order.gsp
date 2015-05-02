
<%@ page import="ics.Book" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="order.list" default="BookOrder List" /></title>
	<r:require module="grid" />
	<r:require module="dateTimePicker" />
	<r:require module="ajaxform"/>
	<r:require module="printarea" />

	<!-- @TODO needed for autocomplete in order creation for clor -->
	<gui:resources components="['autoComplete']" />
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
	<!-->
    </head>
    <body>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="orderTemplate">DownloadOrderTemplate</g:link></span>
        </div>
        <div class="body">

			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

	    <g:hiddenField name="editurl" value="" />

		<div id="dialogPrintChallan" title="Print Challan">
			<div id="divToPrintChallan"></div>
		</div>

            <div>
			<!-- table tag will hold our grid -->
			<table id="order_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="order_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="lineitem_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="lineitem_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>

		<div>
		Upload book order in bulk: <br />
		    <g:uploadForm action="orderBulkUpload">
			<g:textField name="distributorIcsId" placeholder="IcsId of the Distributor" />
			<input type="file" name="myFile" />
			<input type="submit" value="Upload"/>
		    </g:uploadForm>
		</div>

		<div>
		Upload challan settlement in bulk: <br />
		    <g:uploadForm action="orderBulkSettle">
			<g:textField name="challanRef" placeholder="Challan Reference No" />
			<input type="file" name="myFile" />
			<input type="submit" value="Upload"/>
		    </g:uploadForm>
		</div>

		<div id="dialogOrderForm" title="New Order">
			<g:render template="order" />
		</div>
		<div id="dialogPrint" title="Print?">
			<div id="divToPrint"></div>
		</div>		
        </div>

<script>
  $(document).ready(function () {
    jQuery("#order_list").jqGrid({
      url:'jq_order_list',
      editurl:'jq_edit_order',
      datatype: "json",
      colNames:['Team','Comments','OrderNo','OrderDate','Status','Challan','PlacedBy','Id'],
      colModel:[
	{name:'team.id', search:true, editable: true, editrules:{required:false},
        	edittype:"select",editoptions:{value:"${':--Please Select Team--;'+(ics.RelationshipGroup.findAllWhere('category':'JIVADAYA','refid':indid.toInteger(),'status':'ACTIVE',[sort:'groupName'])?.collect{it.id+':'+it.toString()}.join(';'))}"},
        	stype:'select', searchoptions: {value:"${':--Please Select Team--;'+(ics.RelationshipGroup.findAllWhere('category':'JIVADAYA','refid':indid.toInteger(),'status':'ACTIVE',[sort:'groupName'])?.collect{it.id+':'+it.toString()}.join(';'))}"}
	},
	{name:'comments', search:true, editable: true},
	{name:'orderNo', search:true, editable: false},
	{name:'orderDate', search:true, editable: false,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}	
	},
	{name:'status', search:true, editable: false,
		edittype:"select",editoptions:{value:"${'Draft:Draft;Submitted:Submitted;In-Progress:In-Progress;Fulfilled:Fulfilled;Cancelled:Cancelled;Rejected:Rejected'}"},
		formatter:'select',stype:'select', searchoptions: { value: ':ALL;Draft:Draft;Submitted:Submitted;In-Progress:In-Progress;Fulfilled:Fulfilled;Cancelled:Cancelled;Rejected:Rejected'}
	},
	{name:'challan', search:true, editable: false},
	{name:'placedBy', search:true, editable: false},
	{name:'id',hidden:true}
     ],
    rowNum:5,
    rowList:[5,10,20,30,40,50],
    pager: '#order_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"BookOrder List",
    onSelectRow: function(ids) { 
      	if(ids!='new_row')
    		{
		var sel = jQuery('#order_list').jqGrid('getCell', ids, 'orderNo');
		jQuery("#lineitem_list").jqGrid('setCaption',"Book Order Line Item(s) List for BookOrder: "+sel);
		$("#editurl").val("jq_edit_orderlineitem?orderid="+ids);
		jQuery("#lineitem_list").jqGrid('setGridParam',{url:"jq_orderlineitem_list?orderid="+ids,editurl:"jq_edit_orderlineitem?orderid="+ids}).trigger('reloadGrid');    	
    		}
    	}    
    });
    $("#order_list").jqGrid('filterToolbar',{autosearch:true});
    $("#order_list").jqGrid('navGrid',"#order_list_pager",{edit:false,add:false,del:false,search:false});
    $("#order_list").jqGrid('inlineNav',"#order_list_pager"
    <sec:ifAnyGranted roles="ROLE_JIVADAYA_ADMIN,ROLE_JIVADAYA_CLERK">
	    ,{ 
	       edit: false,
	       add: false,
	       save: false,
	       cancel: false,
	    }
    </sec:ifAnyGranted>    
    );

    <sec:ifAnyGranted roles="ROLE_JIVADAYA_USER">
	    $("#order_list").jqGrid('navGrid',"#order_list_pager").jqGrid('navButtonAdd',"#order_list_pager",{caption:"Submit", buttonicon:"ui-icon-cart", onClickButton:submit, position: "last", title:"Submit", cursor: "pointer"});
    </sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_JIVADAYA_ADMIN,ROLE_JIVADAYA_CLERK">
	    $("#order_list").jqGrid('navGrid',"#order_list_pager").jqGrid('navButtonAdd',"#order_list_pager",{caption:"New", buttonicon:"ui-icon-document", onClickButton:create, position: "last", title:"New", cursor: "pointer"});
	    $("#order_list").jqGrid('navGrid',"#order_list_pager").jqGrid('navButtonAdd',"#order_list_pager",{caption:"Reject", buttonicon:"ui-icon-trash", onClickButton:reject, position: "last", title:"Reject", cursor: "pointer"});
	    $("#order_list").jqGrid('navGrid',"#order_list_pager").jqGrid('navButtonAdd',"#order_list_pager",{caption:"Process", buttonicon:"ui-icon-wrench", onClickButton:process, position: "last", title:"Process", cursor: "pointer"});
	    $("#order_list").jqGrid('navGrid',"#order_list_pager").jqGrid('navButtonAdd',"#order_list_pager",{caption:"Issue", buttonicon:"ui-icon-extlink", onClickButton:issue, position: "last", title:"Issue", cursor: "pointer"});
	    $("#order_list").jqGrid('navGrid',"#order_list_pager").jqGrid('navButtonAdd',"#order_list_pager",{caption:"QuickIssue", buttonicon:"ui-icon-arrow-4-diag", onClickButton:quickissue, position: "last", title:"QuickIssue", cursor: "pointer"});
    </sec:ifAnyGranted>
	    $("#order_list").jqGrid('navGrid',"#order_list_pager").jqGrid('navButtonAdd',"#order_list_pager",{caption:"Print", buttonicon:"ui-icon-print", onClickButton:print, position: "last", title:"Print", cursor: "pointer"});
    
    var editOptions = {
            keys: true,
            successfunc: function () {
                var $self = $(this);
                setTimeout(function () {
                    $self.trigger("reloadGrid");
                }, 50);
            }
    };

    jQuery("#lineitem_list").jqGrid({
      url:'jq_orderlineitem_list',
      editurl:'jq_edit_orderlineitem',
      datatype: "json",
      colNames:['Name','Quantity','Id'],
      colModel:[
	{name:'book', search:true, editable: true,
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
	},
	{name:'requiredQuantity', search:true, editable: true,editrules:{required:true}},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#lineitem_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Book Order Line Item(s) List"
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
    


	function submit() {
		var answer = confirm("Are you sure?");
		if (answer){
			var orderid = $('#order_list').jqGrid('getGridParam','selrow');
			if(orderid) {
				var url = "${createLink(controller:'book',action:'orderSubmit')}"+"?orderid="+orderid
				$.getJSON(url, {}, function(data) {
					alert(data.message);
					jQuery("#order_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select the order!!");
		} else {
		    return false;
		}
	}

	function process() {
		var answer = confirm("Are you sure?");
		if (answer){
			var orderid = $('#order_list').jqGrid('getGridParam','selrow');
			if(orderid) {
				var url = "${createLink(controller:'book',action:'orderProcess')}"+"?orderid="+orderid
				$.getJSON(url, {}, function(data) {
					alert(data.message);
					jQuery("#order_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select the order!!");
		} else {
		    return false;
		}
	}

	function issue() {
		var answer = confirm("Are you sure?");
		if (answer){
			var orderid = $('#order_list').jqGrid('getGridParam','selrow');
			if(orderid) {
				var url = "${createLink(controller:'book',action:'orderIssue')}"+"?orderid="+orderid
				$.getJSON(url, {}, function(data) {
					alert("Order Fulfilled!! Challan No: "+data.challanRefNo);
					jQuery("#order_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select the order!!");
		} else {
		    return false;
		}
	}

	function quickissue() {
		var answer = confirm("Are you sure?");
		if (answer){
			var orderid = $('#order_list').jqGrid('getGridParam','selrow');
			if(orderid) {
				var url = "${createLink(controller:'book',action:'orderIssue')}"+"?orderid="+orderid+"&quick=true"
				$.getJSON(url, {}, function(data) {
					//alert(data.message);
					jQuery("#order_list").jqGrid().trigger("reloadGrid");
					var url = "${createLink(controller:'Challan',action:'printChallan')}"+"?challanid="+data.challanid;
					$( "#divToPrintChallan" ).val("");
					$( "#divToPrintChallan" ).load( url, function(responseTxt,statusTxt,xhr){
					    if(statusTxt=="success")
					    {
						$( "#dialogPrintChallan" ).dialog( "open" );	
					    }
					    if(statusTxt=="error")
					      alert("Error: "+xhr.status+": "+xhr.statusText);
					  });
					
				    });	
			}
			else
				alert("Please select the order!!");
		} else {
		    return false;
		}
	}

	function reject() {
		var answer = confirm("Are you sure?");
		if (answer){
			var orderid = $('#order_list').jqGrid('getGridParam','selrow');
			if(orderid) {
				var url = "${createLink(controller:'book',action:'orderReject')}"+"?orderid="+orderid
				$.getJSON(url, {}, function(data) {
					alert(data.message);
					jQuery("#order_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select the order!!");
		} else {
		    return false;
		}
	}

	function create() {
		$( "#dialogOrderForm" ).dialog( "open" );
	}

		$( "#dialogOrderForm" ).dialog({
			autoOpen: false,
			height: 450,
			width: 700,
			modal: true,
			buttons: {
				"Submit": function() {
					    $("#formOrder").ajaxForm({
						success: function() {
							alert("New order created");
							jQuery("#order_list").jqGrid().trigger("reloadGrid");
							}
					    }).submit();

						$('#distributorid').val('');
						$('#contactid').val('');
						$('#emailid').val('');
						$('#acClor_id').val('');
						$('#formOrder').clearForm();
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
						$('#distributorid').val('');
						$('#contactid').val('');
						$('#emailid').val('');
						$('#acClor_id').val('');
						$('#formOrder').clearForm();
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

	function print() {
		var id = $('#order_list').jqGrid('getGridParam','selrow');
		if(id) {
				var url = "${createLink(controller:'Book',action:'printOrder')}"+"?orderid="+id;
				$( "#divToPrint" ).val("");
				$( "#divToPrint" ).load( url, function(responseTxt,statusTxt,xhr){
				    if(statusTxt=="success")
				    {
					$( "#dialogPrint" ).dialog( "open" );	
				    }
				    if(statusTxt=="error")
				      alert("Error: "+xhr.status+": "+xhr.statusText);
				  });
		}
		else
			alert("Please select a row!!");
	}

	 $( "#dialogPrint" ).dialog({
		autoOpen: false,
		 //width:800,
		 //height:500,
		 width:'auto',
		 height:'auto',
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


    });
</script>


    </body>
</html>
