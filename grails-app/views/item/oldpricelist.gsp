
<%@ page import="ics.Item" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>PriceList</title>
	<r:require module="grid" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="item_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="item_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="itemVendor_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="itemVendor_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    jQuery("#item_list").jqGrid({
      url:'jq_itemprice_list',
      datatype: "json",
      colNames:['Name','OtherNames','Category','Variety','Brand','LastRate','Last-1Rate','Last-2Rate','Id'],
      colModel:[
	{name:'name', search:true, editable: true, editrules:{required:true}},
	{name:'otherNames', search:true, editable: true, editrules:{required:false}},
	{name:'category', search:true, editable: true, editrules:{required:false}}, 
	{name:'variety', search:true, editable: true},
	{name:'brand', search:true, editable: true},
	{name:'lastRate', search:true, editable: true},
	{name:'last-1Rate', search:true, editable: true},
	{name:'last-2Rate', search:true, editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#item_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Item Price List",
    onSelectRow: function(ids) { 
    	jQuery("#itemVendor_list").jqGrid('setGridParam',{url:"jq_itemVendor_list?itemid="+ids}).trigger('reloadGrid');    	
    	}        
    });
    $("#item_list").jqGrid('filterToolbar',{autosearch:true});
    $("#item_list").jqGrid('navGrid',"#item_list_pager",{edit:false,add:false,del:true,search:false});
    //$("#item_list").jqGrid('inlineNav',"#item_list_pager");

    jQuery("#itemVendor_list").jqGrid({
      url:'jq_itemVendor_list',
      datatype: "json",
      colNames:['Vendor','PurchaseDate','Qty','UnitSize','Unit','Rate','TaxRate(%)','Description','Id'],
      colModel:[
	{name:'vendor', search:true, editable: true, editoptions:{defaultValue:selectedItemName}},
	{name:'purchaseDate', search:true, editable: true},
	{name:'qty', search:true, editable: true},
	{name:'unitSize', search:true, editable: true},
	{name:'unit', search:true, editable: true, editrules:{required:true},
		edittype:"select",editoptions:{value:"${':--Please Select Unit--;'+(ics.Unit.values())?.collect{it.toString()+':'+it.toString()}.join(';')}"},
		formatter:'select',stype:'select', searchoptions: { value: "${':ALL;'+(ics.Unit.values())?.collect{it.toString()+':'+it.toString()}.join(';')}"}
	},
	{name:'rate', search:true, editable: true},
	{name:'taxRate', search:true, editable: true},
	{name:'description', search:true, editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#itemVendor_list_pager',
    viewrecords: true,
    sortname: 'item.name',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Item Vendor List"
    });
    $("#itemVendor_list").jqGrid('filterToolbar',{autosearch:true});
    $("#itemVendor_list").jqGrid('navGrid',"#itemVendor_list_pager",{edit:false,add:false,del:true,search:false});
    $("#itemVendor_list").jqGrid('inlineNav',"#itemVendor_list_pager",
		{
		    addParams: {
			useDefValues: true,
			addRowParams: {
			    extraparam: { 'item.id': selectedItemId }
			}
		    },
		    editParams: {
			extraparam: { 'item.id': selectedItemId }
		    },
		    add: true,
		    edit: true,
		    save: true,
		    cancel: true
		}
    );
    });

function selectedItemId() {
	var grid = jQuery('#item_list');
	var sel_id = grid.jqGrid('getGridParam', 'selrow');
	return sel_id;
}
function selectedItemName() {
	var grid = jQuery('#item_list');
	var sel_id = grid.jqGrid('getGridParam', 'selrow');
	var cellData = grid.jqGrid('getCell', sel_id, 'name');
	return cellData;
}

</script>


    </body>
</html>
