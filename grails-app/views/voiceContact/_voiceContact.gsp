<div>
<table id="mobile_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<div id="mobile_list_pager" class="scroll" style="text-align:center;"></div>						
</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
  
  jQuery("#mobile_list").jqGrid({
  	         url:'${createLink(controller:'VoiceContact',action:'jq_mobile_list',params:['individual.id':individualid])}',
  	         editurl:'${createLink(controller:'VoiceContact',action:'jq_edit_mobile',params:['individual.id':individualid])}',
  	         datatype: "json",
  	         colNames:['Category','Number','Id'],
  	         colModel:[
  	        {name:'category', search:true, editable: true, editrules:{required:true},edittype:"select",editoptions:{value:":--Please Select --;CellPhone:CellPhone;HomePhone:HomePhone;CompanyPhone:CompanyPhone;Other:Other"},formatter: 'select',stype:'select', searchoptions: { value: ':All;CellPhone:CellPhone;HomePhone:HomePhone;CompanyPhone:CompanyPhone;Other:Other'}},
  	   	{name:'number', search:true, editable: true, editrules:{required:true}},
  	   	{name:'id',hidden:true}
  	        ],
  	       rowNum:10,
  	       rowList:[10,20,30,40,50,100,200],
  	       pager: '#mobile_list_pager',
  	       viewrecords: true,
  	       sortorder: "asc",
  	       width:500 ,
  	       height: "100%",
  	       multiselect: true,
  	       caption:"Contact Numbers",
  	       });
  	       $("#mobile_list").jqGrid('filterToolbar',{autosearch:true});
  	           $("#mobile_list").jqGrid('navGrid',"#mobile_list_pager",{edit:false,add:false,del:true,search:false});
  	           $("#mobile_list").jqGrid('inlineNav',"#mobile_list_pager");

  
  
  
   });
  
</script>