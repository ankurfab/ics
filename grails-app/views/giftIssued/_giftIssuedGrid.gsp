<div>
<!-- table tag will hold our grid -->
<table id="giftIssued_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<!-- pager will hold our paginator -->
<div id="giftIssued_list_pager" class="scroll" style="text-align:center;"></div>

</div>


<script type="text/javascript">
  jQuery(document).ready(function () {
    jQuery("#giftIssued_list").jqGrid({
      url:'${createLink(controller:'giftIssued',action:'jq_giftIssued_list',params:['issuedTo.id':issuedToid])}',
      editurl:'${createLink(controller:'giftIssued',action:'jq_edit_giftIssued',params:['issuedTo.id':issuedToid])}',
      datatype: "json",
      colNames:['Gift','Qty','Worth','GiftIssuedOn','Comments','id'],
      colModel:[
	{name:'gift.id',editable: true,editrules:{required:true},edittype:"select",
	editoptions:{value:"${':--Please Select Gift--;'+(ics.Gift.createCriteria().list{
						    order('name', 'asc')
					})?.collect{it.id+':'+it.name}.join(';')}"}
	},
	{name:'issuedQty',editable: true},
	{name:'worth',editable: false},
	{name:'issueDate',editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}
	
	},
	{name:'comments',editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50],
    pager: '#giftIssued_list_pager',
    viewrecords: true,
    gridview: true,
    sortname: 'name',
    sortorder: "asc",
    width: 800,
    height: "100%",
    caption:"GiftIssued List"
    });
  	           $("#giftIssued_list").jqGrid('navGrid',"#giftIssued_list_pager",{edit:false,add:false,del:true,search:false});
  	           $("#giftIssued_list").jqGrid('inlineNav',"#giftIssued_list_pager");
    });

</script>
