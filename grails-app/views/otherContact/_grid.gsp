<div>
<table id="otherContact_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<div id="otherContact_list_pager" class="scroll" style="text-align:center;"></div>						
</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
  jQuery("#otherContact_list").jqGrid({
  	         url:'${createLink(controller:'otherContact',action:'jq_otherContact_list',params:['individual.id':individualid])}',
  	         editurl:'${createLink(controller:'otherContact',action:'jq_edit_otherContact',params:['individual.id':individualid])}',
  	         datatype: "json",
  	         colNames:['Category','Type','Address','Id'],
  	         colModel:[
  	        {name:'category',search:true, editable: true,edittype:"select",editoptions:{value:":--Please Select --;Personal:Personal;Official:Official;Other:Other"},formatter:'select',stype:'select', searchoptions: { value: ':all;Personal:Personal;Official:Official;Other:Other'}},
  	   	{name:'contactType',width:300,search:true, editable: true, editrules:{required:true}},
  	   	{name:'contactValue',width:300,search:true, editable: true, editrules:{required:true}},
  	   	{name:'id',hidden:true}
  	        ],
  	       rowNum:10,
  	       rowList:[10,20,30,40,50,100,200],
  	       pager: '#otherContact_list_pager',
  	       viewrecords: true,
  	       sortorder: "asc",
  	       width:500 ,
  	       height: "100%",
  	       multiselect: true,
  	       caption:"Other Contact List",
  	       });
  	       $("#otherContact_list").jqGrid('filterToolbar',{autosearch:true});
  	           $("#otherContact_list").jqGrid('navGrid',"#otherContact_list_pager",{edit:false,add:false,del:true,search:false});
  	           $("#otherContact_list").jqGrid('inlineNav',"#otherContact_list_pager");


  });
  
  </script>
