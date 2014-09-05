<div>
<table id="individualCentre_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<div id="individualCentre_list_pager" class="scroll" style="text-align:center;"></div>						
</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
  jQuery("#individualCentre_list").jqGrid({
  	         url:'${createLink(controller:'individualCentre',action:'jq_individualCentre_list',params:['individual.id':individualid])}',
  	         editurl:'${createLink(controller:'individualCentre',action:'jq_edit_individualCentre',params:['individual.id':individualid])}',
  	         datatype: "json",
  	         colNames:['Name','Status','Comments','Id'],
  	         colModel:[
  	        {name:'centre.id',search:true, editable: true,edittype:"select",editoptions:{value:"${':--Please Select--;'+(ics.Centre.list()?.collect{it.id+':'+it.toString()}.join(';'))}"}},
  	   	{name:'status',width:300,search:true, editable: true,edittype:"select",editoptions:{value:":--Please Select --;ACTIVE:ACTIVE;INACTIVE:INACTIVE"},formatter:'select',stype:'select', searchoptions: { value: ':ALL;ACTIVE:ACTIVE;INACTIVE:INACTIVE'}},
  	   	{name:'comments',search:true, editable: true},
  	   	{name:'id',hidden:true}
  	        ],
  	       rowNum:10,
  	       rowList:[10,20,30,40,50,100,200],
  	       pager: '#individualCentre_list_pager',
  	       viewrecords: true,
  	       sortorder: "asc",
  	       width:500 ,
  	       height: "100%",
  	       multiselect: true,
  	       caption:"Centres",
  	       });
  	       $("#individualCentre_list").jqGrid('filterToolbar',{autosearch:true});
  	           $("#individualCentre_list").jqGrid('navGrid',"#individualCentre_list_pager",{edit:false,add:false,del:true,search:false});
  	           $("#individualCentre_list").jqGrid('inlineNav',"#individualCentre_list_pager");


  });
  
  </script>
