<div>
<table id="individualSkill_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<div id="individualSkill_list_pager" class="scroll" style="text-align:center;"></div>						
</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
  jQuery("#individualSkill_list").jqGrid({
  	         url:'${createLink(controller:'IndividualSkill',action:'jq_individualSkill_list',params:['individual.id':individualid])}',
  	         editurl:'${createLink(controller:'IndividualSkill',action:'jq_edit_individualSkill',params:['individual.id':individualid])}',
  	         datatype: "json",
  	         colNames:['Skill','Status','Id'],
  	         colModel:[
  	        {name:'skill.id',search:true, editable: true,edittype:"select",editoptions:{value:"${':--Please Select --;'+(ics.Skill.list()?.collect{it.id+':'+it.toString()}.join(';'))}"}},
  	   	{name:'status',width:300,search:true, editable: true,edittype:"select",editoptions:{value:":--Please Select --;ACTIVE:ACTIVE;INACTIVE:INACTIVE"},formatter:'select',stype:'select', searchoptions: { value: ':ALL;ACTIVE:ACTIVE;INACTIVE:INACTIVE'}},
  	   	{name:'id',hidden:true}
  	        ],
  	       rowNum:10,
  	       rowList:[10,20,30,40,50,100,200],
  	       pager: '#individualSkill_list_pager',
  	       viewrecords: true,
  	       sortorder: "asc",
  	       width:500 ,
  	       height: "100%",
  	       multiselect: true,
  	       caption:"Skills",
  	       });
  	       $("#individualSkill_list").jqGrid('filterToolbar',{autosearch:true});
  	           $("#individualSkill_list").jqGrid('navGrid',"#individualSkill_list_pager",{edit:false,add:false,del:true,search:false});
  	           $("#individualSkill_list").jqGrid('inlineNav',"#individualSkill_list_pager");


  });
  
  </script>
