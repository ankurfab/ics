<div>
<table id="family_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
 <div id="family_list_pager" class="scroll" style="text-align:center;"></div>		   							    	  
</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
  jQuery("#family_list").jqGrid({
  	       	         url:'${createLink(controller:'individual',action:'jq_family_list',params:['individual.id':individualid])}',
  	       	         editurl:'${createLink(controller:'individual',action:'jq_edit_family',params:['individual.id':individualid])}',
  	       	         datatype: "json",
  	       	         colNames:['Name','Relation','Id'],
  	       	         colModel:[
  	       	        {name:'legalName', search:true, editable: true,
				formatter:'showlink', 
				formatoptions:{baseLinkUrl:'show',addParam: '&profile=true'}
  	       	        },
  	       	   	{name:'relation.id', search:true, editable: true, editrules:{required:true},edittype:"select",editoptions:{value:"${':--Please Select Relation--;'+(ics.Relation.findAllByCategory('FAMILY',[sort:'name'])?.collect{it.id+':'+it.toString()}.join(';'))}"}},
  	       	   	{name:'id',hidden:true}
  	       	        ],
  	       	       rowNum:10,
  	       	       rowList:[10,20,30,40,50,100,200],
  	       	       pager: '#family_list_pager',
  	       	       viewrecords: true,
  	       	       sortorder: "asc",
  	       	       width:1000 ,
  	       	       height: "100%",
  	       	       multiselect: true,
  	       	       caption:"Family Member(s)",
  	       	       });
  	       	       $("#family_list").jqGrid('filterToolbar',{autosearch:false});
  	       	           $("#family_list").jqGrid('navGrid',"#family_list_pager",{edit:false,add:false,del:true,search:false});
  	       	           $("#family_list").jqGrid('inlineNav',"#family_list_pager");

  
  });
  
  </script>
