<div>
<table id="address_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
 <div id="address_list_pager" class="scroll" style="text-align:center;"></div>		   							    	  
</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
  jQuery("#address_list").jqGrid({
  	       	         url:'${createLink(controller:'Address',action:'jq_address_list',params:['individual.id':individualid])}',
  	       	         editurl:'${createLink(controller:'Address',action:'jq_edit_address',params:['individual.id':individualid])}',
  	       	         datatype: "json",
  	       	         colNames:['Category','Address','City','State','Country','Pincode','Id'],
  	       	         colModel:[
  	       	        {name:'category', search:true, editable: true, editrules:{required:true},edittype:"select",editoptions:{value:":--Please Select --;Correspondence:Correspondence;Residence:Residence;Permanent:Permanent;Company:Company;Location:Location;Other:Other"},formatter: 'select',stype:'select', searchoptions: { value: ':All;Correspondence:Correspondence;Residence:Residence;Permanent:Permanent;Company:Company;Location:Location;Other:Other'}},
  	       	   	{name:'addressLine1',width:500, search:true, editable: true, editrules:{required:true}},
  	       	   	{name:'city.id', search:true, editable: true, editrules:{required:true},edittype:"select",editoptions:{value:"${':--Please Select City--;'+(ics.City.list()?.collect{it.id+':'+it.toString()}.join(';'))}"}},
  	       	   	{name:'state.id', search:true, editable: true, editrules:{required:true},edittype:"select",editoptions:{value:"${':--Please Select State--;'+(ics.State.list()?.collect{it.id+':'+it.toString()}.join(';'))}"}},
  	       	   	{name:'country.id', search:true, editable: true, editrules:{required:true},edittype:"select",editoptions:{value:"${':--Please Select Country--;'+(ics.Country.list()?.collect{it.id+':'+it.toString()}.join(';'))}"}},
  	       	   	{name:'pincode', search:true, editable: true, editrules:{required:true}},
  	       	   	{name:'id',hidden:true}
  	       	        ],
  	       	       rowNum:10,
  	       	       rowList:[10,20,30,40,50,100,200],
  	       	       pager: '#address_list_pager',
  	       	       viewrecords: true,
  	       	       sortorder: "asc",
  	       	       width:1000 ,
  	       	       height: "100%",
  	       	       multiselect: true,
  	       	       caption:"Address",
  	       	       });
  	       	       $("#address_list").jqGrid('filterToolbar',{autosearch:true});
  	       	           $("#address_list").jqGrid('navGrid',"#address_list_pager",{edit:false,add:false,del:true,search:false});
  	       	           $("#address_list").jqGrid('inlineNav',"#address_list_pager");

  
  });
  
  </script>
