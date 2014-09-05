<div>
<!-- table tag will hold our grid -->
<table id="guidedBy_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<!-- pager will hold our paginator -->
<div id="guidedBy_list_pager" class="scroll" style="text-align:center;"></div>

</div>

<div>
<!-- table tag will hold our grid -->
<table id="guiding_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<!-- pager will hold our paginator -->
<div id="guiding_list_pager" class="scroll" style="text-align:center;"></div>

</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
    jQuery("#guidedBy_list").jqGrid({
      url:'${createLink(controller:'relationship',action:'jq_guidedBy_list',params:['individualid':individualid])}',
      editurl:'${createLink(controller:'guidedBy',action:'jq_edit_guidedBy')}',
      datatype: "json",
      colNames:['Relation','Individual','id'],
      colModel:[
	{name:'relation.name',formatter:'showlink',
	formatoptions:{baseLinkUrl:'${createLink(controller:'relationship',action:'show')}'}
	},
	{name:'name'},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50],
    pager: '#guidedBy_list_pager',
    viewrecords: true,
    gridview: true,
    sortname: 'name',
    sortorder: "asc",
    width: 800,
    height: "100%",
    caption:"Guided By List"
    });
   $("#guidedBy_list").jqGrid('navGrid',"#guidedBy_list_pager",
	{add:false,edit:false,del:false,search:false}, // which buttons to show?
	{},         // edit options
	{},  // add options
	{}          // delete options
    );

    jQuery("#guiding_list").jqGrid({
      url:'${createLink(controller:'relationship',action:'jq_guiding_list',params:['individualid':individualid])}',
      editurl:'${createLink(controller:'guiding',action:'jq_edit_guiding')}',
      datatype: "json",
      colNames:['Legal Name','Initiated Name','Relation','id'],
      colModel:[
	{name:'legalName'},
	{name:'initiatedName'},
	{name:'name',formatter:'showlink',
	formatoptions:{baseLinkUrl:'${createLink(controller:'relationship',action:'show')}'}
	},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50],
    pager: '#guiding_list_pager',
    viewrecords: true,
    gridview: true,
    sortname: 'legalName',
    sortorder: "asc",
    width: 800,
    height: "100%",
    caption:"Guiding List"
    });
   $("#guiding_list").jqGrid('navGrid',"#guiding_list_pager",
	{add:false,edit:false,del:false,search:false}, // which buttons to show?
	{},         // edit options
	{},  // add options
	{}          // delete options
    );
    
    });

</script>
