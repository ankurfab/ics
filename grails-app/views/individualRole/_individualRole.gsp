<div>
<table id="individualRole_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<div id="individualRole_list_pager" class="scroll" style="text-align:center;"></div>						
</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
  jQuery("#individualRole_list").jqGrid({
  	         url:'${createLink(controller:'individualRole',action:'jq_individualRole_list',params:['individual.id':individualid])}',
  	         editurl:'${createLink(controller:'individualRole',action:'jq_edit_individualRole',params:['individual.id':individualid])}',
  	         datatype: "json",
  	         colNames:['Roles','Status','Id'],
  	         colModel:[
  	        {name:'role.id',search:true, editable: true,edittype:"select",editoptions:{value:"${':--Please Select--;'+(ics.Role.findAllByCategory('Voice',[sort:'name'])?.collect{it.id+':'+it.toString()}.join(';'))}"}},
  	   	{name:'status',width:300,search:true, editable: true,edittype:"select",editoptions:{value:":--Please Select --;VALID:VALID;INVALID:INVALID"},formatter:'select',stype:'select', searchoptions: { value: ':ALL;ACTIVE:ACTIVE;INACTIVE:INACTIVE'}},
  	   	{name:'id',hidden:true}
  	        ],
  	       rowNum:10,
  	       rowList:[10,20,30,40,50,100,200],
  	       pager: '#individualRole_list_pager',
  	       viewrecords: true,
  	       sortorder: "asc",
  	       width:500 ,
  	       height: "100%",
  	       multiselect: true,
  	       caption:"Roles",
  	       });
  	       $("#individualRole_list").jqGrid('filterToolbar',{autosearch:true});
  	           $("#individualRole_list").jqGrid('navGrid',"#individualRole_list_pager",{edit:false,add:false,del:true,search:false});
  	           $("#individualRole_list").jqGrid('inlineNav',"#individualRole_list_pager");


  });
  
  </script>
