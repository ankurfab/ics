<div>
<!-- table tag will hold our grid -->
<table id="schemeMember_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<!-- pager will hold our paginator -->
<div id="schemeMember_list_pager" class="scroll" style="text-align:center;"></div>

</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
    jQuery("#schemeMember_list").jqGrid({
      url:'${createLink(controller:'schemeMember',action:'jq_schemeMember_list',params:['individual.id':individualid])}',
      editurl:'${createLink(controller:'schemeMember',action:'jq_edit_schemeMember')}',
      datatype: "json",
      colNames:['Scheme','Department','Category','MembershipLevel','Status','Centre','id'],
      colModel:[
	{name:'scheme.name',formatter:'showlink',
	formatoptions:{baseLinkUrl:'${createLink(controller:'schemeMember',action:'show')}'}
	},
	{name:'scheme.department.name'},
	{name:'scheme.category'},
	{name:'membershipLevel'},
	{name:'status'},
	{name:'centre.name'},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50],
    pager: '#schemeMember_list_pager',
    viewrecords: true,
    gridview: true,
    sortname: 'id',
    sortorder: "asc",
    width: 800,
    height: "100%",
    caption:"SchemeMembership List"
    });
   $("#schemeMember_list").jqGrid('navGrid',"#schemeMember_list_pager",
	{add:false,edit:false,del:false,search:false}, // which buttons to show?
	{},         // edit options
	{},  // add options
	{}          // delete options
    );
    
    });

</script>
