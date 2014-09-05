
<%@ page import="ics.PurchaseList" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="purchaseList.list" default="PurchaseList List" /></title>
	<r:require module="grid" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="purchaseList_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="purchaseList_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="requiredItem_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="requiredItem_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="purchasedItem_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="purchasedItem_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    jQuery("#purchaseList_list").jqGrid({
      url:'jq_purchaseList_list',
      editurl:'jq_edit_purchaseList',
      datatype: "json",
      colNames:['Name','Status','PreparedBy','PreparedOn','PreparationComments','PurchasedBy','PurchasedOn','PurchaseComments','Id'],
      colModel:[
	{name:'name', search:true, editable: true, editrules:{required:true}},
	{name:'status', search:true, editable: true, editrules:{required:false}, edittype:"select", editoptions:{value:"OPEN:OPEN;CLOSE:CLOSE;REJECTED:REJECTED;PARKED:PARKED"}},
	{name:'preparedBy', search:true, editable: false, editrules:{required:false}}, 
	{name:'purchaseListDate', search:true, editable: false},
	{name:'preparationComments', search:true, editable: false},
	{name:'purchasedBy', search:true, editable: false},
	{name:'purchaseDateDate', search:true, editable: false},
	{name:'purchaseComments', search:true, editable: false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#purchaseList_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Purchase List",
    onSelectRow: function(ids) { 
    	if(ids!='new_row')
    		{
		jQuery("#requiredItem_list").jqGrid('setGridParam',{url:"jq_requiredItem_list?purchaseListid="+ids}).trigger('reloadGrid');    	
		jQuery("#purchasedItem_list").jqGrid('setGridParam',{url:"jq_purchasedItem_list?purchaseListid="+ids}).trigger('reloadGrid');    	
    		}
    	}        
    });
    $("#purchaseList_list").jqGrid('filterToolbar',{autosearch:true});
    $("#purchaseList_list").jqGrid('navGrid',"#purchaseList_list_pager",{edit:false,add:false,del:true,search:false});
    $("#purchaseList_list").jqGrid('inlineNav',"#purchaseList_list_pager");

    jQuery("#requiredItem_list").jqGrid({
      url:'jq_requiredItem_list',
      editurl:'jq_edit_requiredItem',
      datatype: "json",
      colNames:['Item','Quantity','Unit','Rate','Id'],
      colModel:[
	{name:'item.name', search:true, editable: true,edittype:'select',editoptions:{value:'${ics.Item.list([sort:"name"])?.collect{it.id+':'+it.name}.join(';')}'}},
	{name:'qty', search:true, editable: true},
	{name:'unit', search:true, editable: true},
	{name:'rate', search:true, editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#requiredItem_list_pager',
    viewrecords: true,
    sortname: 'item.name',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Required Item List"
    });
    $("#requiredItem_list").jqGrid('filterToolbar',{autosearch:true});
    $("#requiredItem_list").jqGrid('navGrid',"#requiredItem_list_pager",{edit:false,add:false,del:true,search:false});
    $("#requiredItem_list").jqGrid('inlineNav',"#requiredItem_list_pager",
		{
		    addParams: {
			useDefValues: true,
			addRowParams: {
			    extraparam: { 'purchaseList.id': selectedPurchaseListId }
			}
		    },
		    editParams: {
			extraparam: { 'purchaseList.id': selectedPurchaseListId }
		    },
		    add: true,
		    edit: true,
		    save: true,
		    cancel: true
		}
    );

    jQuery("#purchasedItem_list").jqGrid({
      url:'jq_purchasedItem_list',
      editurl:'jq_edit_purchasedItem',
      datatype: "json",
      colNames:['Item','Quantity','Unit','Rate','Id'],
      colModel:[
	{name:'item.name', search:true, editable: true},
	{name:'qty', search:true, editable: true},
	{name:'unit', search:true, editable: true},
	{name:'rate', search:true, editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#purchasedItem_list_pager',
    viewrecords: true,
    sortname: 'item.name',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Purchased Item List"
    });
    $("#purchasedItem_list").jqGrid('filterToolbar',{autosearch:true});
    $("#purchasedItem_list").jqGrid('navGrid',"#purchasedItem_list_pager",{edit:false,add:false,del:true,search:false});
    $("#purchasedItem_list").jqGrid('inlineNav',"#purchasedItem_list_pager",
		{
		    addParams: {
			useDefValues: true,
			addRowParams: {
			    extraparam: { 'purchaseList.id': selectedPurchaseListId }
			}
		    },
		    editParams: {
			extraparam: { 'purchaseList.id': selectedPurchaseListId }
		    },
		    add: true,
		    edit: true,
		    save: true,
		    cancel: true
		}
    );


    });

function selectedPurchaseListId() {
	var grid = jQuery('#purchaseList_list');
	var sel_id = grid.jqGrid('getGridParam', 'selrow');
	return sel_id;
}
function selectedPurchaseListName() {
	var grid = jQuery('#purchaseList_list');
	var sel_id = grid.jqGrid('getGridParam', 'selrow');
	var cellData = grid.jqGrid('getCell', sel_id, 'name');
	return cellData;
}

</script>


    </body>
</html>
