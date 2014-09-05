<div>
<table id="indSeva_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<div id="indSeva_list_pager" class="scroll" style="text-align:center;"></div>						
</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
  jQuery("#indSeva_list").jqGrid({
  	         url:'${createLink(controller:'IndividualSeva',action:'jq_indSeva_list',params:['individual.id':individualid])}',
  	         editurl:'${createLink(controller:'IndividualSeva',action:'jq_edit_indSeva',params:['individual.id':individualid])}',
  	         datatype: "json",
  	         colNames:['Services','Rendered','Interested','Id'],
  	         colModel:[
  	        {name:'seva.id',search:true, editable: true,edittype:"select",editoptions:{value:"${':--Please Select Seva--;'+(ics.Seva.list()?.collect{it.id+':'+it.toString()}.join(';'))}"}},
  	   	{name:'rendered',search:true, editable: true,edittype:"select",editoptions:{value:":--Please Select --;true:true;false:false"},formatter:'select',stype:'select', searchoptions: { value: ':ALL;true:true;false:false;'}},
  	   	{name:'interested',search:true, editable: true,edittype:"select",editoptions:{value:":--Please Select --;true:true;false:false"},formatter:'select',stype:'select', searchoptions: { value: ':ALL;true:true;false:false;'}},
  	   	{name:'id',hidden:true}
  	        ],
  	       rowNum:10,
  	       rowList:[10,20,30,40,50,100,200],
  	       pager: '#indSeva_list_pager',
  	       viewrecords: true,
  	       sortorder: "asc",
  	       width:500 ,
  	       height: "100%",
  	       multiselect: true,
  	       caption:"Services Rendered",
  	       });
  	       $("#indSeva_list").jqGrid('filterToolbar',{autosearch:true});
  	       $("#indSeva_list").jqGrid('navGrid',"#indSeva_list_pager",{edit:false,add:false,del:true,search:false});
  	       $("#indSeva_list").jqGrid('inlineNav',"#indSeva_list_pager");


  });
  
  </script>
