<div>
<table id="email_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<div id="email_list_pager" class="scroll" style="text-align:center;"></div>						
</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
  jQuery("#email_list").jqGrid({
  	         url:'${createLink(controller:'EmailContact',action:'jq_email_list',params:['individual.id':individualid])}',
  	         editurl:'${createLink(controller:'EmailContact',action:'jq_edit_email',params:['individual.id':individualid])}',
  	         datatype: "json",
  	         colNames:['Category','Email Address','Id'],
  	         colModel:[
  	        {name:'category',search:true, editable: true,edittype:"select",editoptions:{value:":--Please Select --;Personal:Personal;Official:Official;Other:Other"},formatter:'select',stype:'select', searchoptions: { value: ':all;Personal:Personal;Official:Official;Other:Other'}},
  	   	{name:'emailAddress',width:300,search:true, editable: true, editrules:{required:true}},
  	   	{name:'id',hidden:true}
  	        ],
  	       rowNum:10,
  	       rowList:[10,20,30,40,50,100,200],
  	       pager: '#email_list_pager',
  	       viewrecords: true,
  	       sortorder: "asc",
  	       width:500 ,
  	       height: "100%",
  	       multiselect: true,
  	       caption:"Email List",
  	       });
  	       $("#email_list").jqGrid('filterToolbar',{autosearch:true});
  	           $("#email_list").jqGrid('navGrid',"#email_list_pager",{edit:false,add:false,del:true,search:false});
  	           $("#email_list").jqGrid('inlineNav',"#email_list_pager");


  });
  
  </script>
