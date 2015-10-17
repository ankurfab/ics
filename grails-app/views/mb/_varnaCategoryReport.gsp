<div>
	<!-- table tag will hold our grid -->
	<table id="result_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
	<!-- pager will hold our paginator -->
	<div id="result_list_pager" class="scroll" style="text-align:center;"></div>
</div>

<script>
  $(document).ready(function () {
    jQuery("#result_list").jqGrid({
      url:'jq_varnaCategory_list',
      datatype: "json",
      colNames:['DB','Centre','Gender','WorkflowStatus','Name','Nationality','OriginState','Varna','Category','Caste','SubCaste','Manglik','Id'],
      colModel:[
	{name:'db',search:true,stype:'select', searchoptions: {value:"${':ALL;'+['MB','DADMOM'].collect{it+':'+it}.join(';')}"}},
	{name:'centre',search:true,stype:'select', searchoptions: {value:"${':ALL;'+ics.MbProfile.createCriteria().list{projections{distinct('referrerCenter')}}.collect{it+':'+it}.join(';')}"}},
	{name:'gender',search:true,stype:'select', searchoptions: {value:"${':ALL;'+['BOY','GIRL'].collect{it+':'+it}.join(';')}"}},
	{name:'workflowStatus',search:true,
		stype:'select', searchoptions: { value: "${':ALL;'+(['UNASSIGNED','AVAILABLE','PROPOSED','BOYGIRLMEET','PARENTSMEET','PROPOSALAGREED','ANNOUNCE','MARRIEDTHRUMB','MARRIEDOSMB','UNAVAILABLE','ONHOLD','WITHDRAWN'].collect{(it?:'')+':'+(it?:'')}.join(';'))}"}						
		},
	{name:'name', search:true,
	formatter:'showlink', 
	formatoptions:{baseLinkUrl:'show'}},
	{name:'nationality', search:true},
	{name:'origin', search:true},
	{name:'varna', search:true},
	{name:'scstCategory', search:true},
	{name:'caste', search:true},
	{name:'subCaste', search:true},
	{name:'manglik', search:true},
	{name:'id',hidden:true}
     ],
     
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#result_list_pager',
    viewrecords: true,
    sortname: "id",
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Varna Category Report"
    });
    $("#result_list").jqGrid('filterToolbar',{autosearch:true,});
    $("#result_list").jqGrid('navGrid', "#result_list_pager", {edit: false, add: false, del: false, search: false});
    
    });
</script>
