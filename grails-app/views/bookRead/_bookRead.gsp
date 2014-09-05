<div>
<table id="bookRead_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<div id="bookRead_list_pager" class="scroll" style="text-align:center;"></div>						
</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
  jQuery("#bookRead_list").jqGrid({
  	         url:'${createLink(controller:'BookRead',action:'jq_bookRead_list',params:['individual.id':individualid])}',
  	         editurl:'${createLink(controller:'bookRead',action:'jq_edit_bookRead',params:['individual.id':individualid])}',
  	         datatype: "json",
  	         colNames:['Books Read','Id'],
  	         colModel:[
  	        {name:'book.id',search:true, editable: true,edittype:"select",editoptions:{value:"${':--Please Select--;'+(ics.Book.list()?.collect{it.id+':'+it.toString()}.join(';'))}"}},
  	   	{name:'id',hidden:true}
  	        ],
  	       rowNum:10,
  	       rowList:[10,20,30,40,50,100,200],
  	       pager: '#bookRead_list_pager',
  	       viewrecords: true,
  	       sortorder: "asc",
  	       width:500 ,
  	       height: "100%",
  	       multiselect: true,
  	       caption:"Books Read",
  	       });
  	       $("#bookRead_list").jqGrid('filterToolbar',{autosearch:true});
  	           $("#bookRead_list").jqGrid('navGrid',"#bookRead_list_pager",{edit:false,add:false,del:true,search:false});
  	           $("#bookRead_list").jqGrid('inlineNav',"#bookRead_list_pager");


  });
  
  </script>
