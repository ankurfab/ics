<div>
<table id="individualLanguage_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<div id="individualLanguage_list_pager" class="scroll" style="text-align:center;"></div>						
</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
  jQuery("#individualLanguage_list").jqGrid({
  	         url:'${createLink(controller:'individualLanguage',action:'jq_individualLanguage_list',params:['individual.id':individualid])}',
  	         editurl:'${createLink(controller:'individualLanguage',action:'jq_edit_individualLanguage',params:['individual.id':individualid])}',
  	         datatype: "json",
  	         colNames:['Languages','Mother Tongue','Read Fluency','Write Fluency','Id'],
  	         colModel:[
  	        {name:'language.id',search:true, editable: true,edittype:"select",editoptions:{value:"${':--Please Select--;'+(ics.Language.list()?.collect{it.id+':'+it.toString()}.join(';'))}"}},
  	   	{name:'motherTongue',search:true, editable: true},
  	   	{name:'readFluency',search:true, editable: true},
  	   	{name:'writeFluency',search:true, editable: true},
  	   	{name:'id',hidden:true}
  	        ],
  	       rowNum:10,
  	       rowList:[10,20,30,40,50,100,200],
  	       pager: '#individualLanguage_list_pager',
  	       viewrecords: true,
  	       sortorder: "asc",
  	       width:500 ,
  	       height: "100%",
  	       multiselect: true,
  	       caption:"Roles",
  	       });
  	       $("#individualLanguage_list").jqGrid('filterToolbar',{autosearch:true});
  	           $("#individualLanguage_list").jqGrid('navGrid',"#individualLanguage_list_pager",{edit:false,add:false,del:true,search:false});
  	           $("#individualLanguage_list").jqGrid('inlineNav',"#individualLanguage_list_pager");


  });
  
  </script>
