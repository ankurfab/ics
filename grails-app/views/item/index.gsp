
<%@ page import="ics.Item" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="item.list" default="Item List" /></title>
	<r:require module="grid" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="pricelist">PriceList</g:link></span>
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
            <div>
			<!-- table tag will hold our grid -->
			<table id="itemStock_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="itemStock_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    jQuery("#item_list").jqGrid({
      url:'jq_item_list',
      editurl:'jq_edit_item',
      datatype: "json",
      colNames:['Name','OtherNames','Category','SubCategory','Variety','Brand','Description','Updator','LastUpdated','Creator','DateCreated','Id'],
      colModel:[
	{name:'name', search:true, editable: true, editrules:{required:true},formatter:'showlink',
	formatoptions:{baseLinkUrl:'${createLink(controller:'item',action:'show')}',target:'_blank'}
	},
	{name:'otherNames', search:true, editable: true, editrules:{required:false}},
	{name:'category', search:true, editable: true, editrules:{required:false}}, 
	{name:'subcategory', search:true, editable: true, editrules:{required:false}}, 
	{name:'variety', search:true, editable: true},
	{name:'brand', search:true, editable: true},
	{name:'comments', search:true, editable: true},
	{name:'updator', search:true, editable: false},
	{name:'lastUpdated', search:true, editable: false},
	{name:'creator', search:true, editable: false},
	{name:'dateCreated', search:true, editable: false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#item_list_pager',
    viewrecords: true,
    sortname: 'lastUpdated',
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Item List",
    onSelectRow: function(ids) { 
    		jQuery("#itemStock_list").jqGrid('setGridParam',{url:"jq_itemStock_list?itemid="+ids}).trigger('reloadGrid');    	
		var selName = jQuery('#item_list').jqGrid('getCell', ids, 'name');
		jQuery("#itemVendor_list").jqGrid('setGridParam',{url:"jq_itemVendor_list?item.id="+ids});
		jQuery("#itemVendor_list").jqGrid('setCaption',"Vendors for Item: "+selName).trigger('reloadGrid');   	
    	}        
    });
    $("#item_list").jqGrid('filterToolbar',{autosearch:true});
    $("#item_list").jqGrid('navGrid',"#item_list_pager",{edit:false,add:false,del:true,search:false});
    $("#item_list").jqGrid('inlineNav',"#item_list_pager");

    jQuery("#itemVendor_list").jqGrid({
      url:'jq_itemVendor_list',
      datatype: "json",
      colNames:['Vendor','PurchaseDate','Qty','UnitSize','Unit','Rate','TaxRate(%)','Description','Id'],
      colModel:[
	{name:'vendor', search:true, editable: true, editoptions:{defaultValue:selectedItemName}},
	{name:'invoiceDate', search:true, editable: true},
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
    sortname: 'invoiceDate',
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Item Vendor List"
    });
    $("#itemVendor_list").jqGrid('navGrid',"#itemVendor_list_pager",{edit:false,add:false,del:false,search:false});

    jQuery("#itemStock_list").jqGrid({
      url:'jq_itemStock_list',
      editurl:'jq_edit_itemStock',
      datatype: "json",
      colNames:['Item','Quantity','Unit','Rate','Supplemented By','Supplemented On','Supplement Comments','Consumed By','Consumed On','Consumption Comments','Audited By','Audited On','Audit Comments','Updator','LastUpdated','Creator','DateCreated','Id'],
      colModel:[
	{name:'item.name', search:true, editable: true, editoptions:{defaultValue:selectedItemName}},
	{name:'qty', search:true, editable: true},
	{name:'unit', search:true, editable: true},
	{name:'rate', search:true, editable: true},
	{name:'supplementedBy', search:true, editable: false},
	{name:'supplementedOn', search:true, editable: false},
	{name:'supplementComments', search:true, editable: false},
	{name:'consumedBy', search:true, editable: false},
	{name:'consumedOn', search:true, editable: false},
	{name:'consumeComments', search:true, editable: false},
	{name:'auditedBy', search:true, editable: false},
	{name:'auditedOn', search:true, editable: false},
	{name:'auditComments', search:true, editable: false},
	{name:'updator', search:true, editable: false},
	{name:'lastUpdated', search:true, editable: false},
	{name:'creator', search:true, editable: false},
	{name:'dateCreated', search:true, editable: false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#itemStock_list_pager',
    viewrecords: true,
    sortname: 'item.name',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Item Stock List"
    });
    $("#itemStock_list").jqGrid('filterToolbar',{autosearch:true});
    $("#itemStock_list").jqGrid('navGrid',"#itemStock_list_pager",{edit:false,add:false,del:true,search:false});
    $("#itemStock_list").jqGrid('inlineNav',"#itemStock_list_pager",
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
