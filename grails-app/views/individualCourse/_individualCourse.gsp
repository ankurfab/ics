<div>
<table id="individualCourse_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<div id="individualCourse_list_pager" class="scroll" style="text-align:center;"></div>						
</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
  jQuery("#individualCourse_list").jqGrid({
  	         url:'${createLink(controller:'IndividualCourse',action:'jq_individualCourse_list',params:['individual.id':individualid])}',
  	         editurl:'${createLink(controller:'IndividualCourse',action:'jq_edit_individualCourse',params:['individual.id':individualid])}',
  	         datatype: "json",
  	         colNames:['Camps,Workshops & Courses','Id'],
  	         colModel:[
  	        {name:'course.id',search:true, editable: true,edittype:"select",editoptions:{value:"${':--Please Select--;'+(ics.Course.list()?.collect{it.id+':'+it.toString()}.join(';'))}"}},
  	   	{name:'id',hidden:true}
  	        ],
  	       rowNum:10,
  	       rowList:[10,20,30,40,50,100,200],
  	       pager: '#individualCourse_list_pager',
  	       viewrecords: true,
  	       sortorder: "asc",
  	       width:500 ,
  	       height: "100%",
  	       multiselect: true,
  	       caption:"Camps,Workshops & Courses",
  	       });
  	       $("#individualCourse_list").jqGrid('filterToolbar',{autosearch:true});
  	           $("#individualCourse_list").jqGrid('navGrid',"#individualCourse_list_pager",{edit:false,add:false,del:true,search:false});
  	           $("#individualCourse_list").jqGrid('inlineNav',"#individualCourse_list_pager");


  });
  
  </script>
