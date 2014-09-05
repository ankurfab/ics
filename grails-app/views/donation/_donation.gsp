<div>
<table id="donation_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<div id="donation_list_pager" class="scroll" style="text-align:center;"></div>						
</div>


<script type="text/javascript">
  jQuery(document).ready(function () {
  jQuery("#donation_list").jqGrid({
  	         url:'${createLink(controller:'Donation',action:'jq_donation_list',params:['individual.id':individualInstance?.id])}',
  	         editurl:'${createLink(controller:'Donation',action:'jq_edit_donation')}',
  	         datatype: "json",
  	         colNames:['Donation Type','Collected By','Book No','Receipt No','Payment Type','Amount','Receipt Date','Submission Date','Received By','Id'],
  	         colModel:[
  	        {name:'nvccDonationType',search:true, editable: true,edittype:"select",editoptions:{value:"${':--Please Select --;'+(ics.Scheme.list()?.collect{it.id+':'+it.toString()}.join(';'))}"}},
  	   	{name:'collectedBy',width:300,search:true, editable: true, editrules:{required:true},edittype:"select",editoptions:{value:"${':--Please Select --;'+(ics.Individual.list()?.collect{it.id+':'+it.toString()}.join(';'))}"}},
  	   	{name:'nvccReceiptBookNo',width:300,search:true, editable: true, editrules:{required:true}},
  	   	{name:'nvccReceiptNo',width:300,search:true, editable: true, editrules:{required:true}},
  	   	{name:'mode',width:300,search:true, editable: true, editrules:{required:true},edittype:"select",editoptions:{value:"${':--Please Select --;'+(ics.PaymentMode.list()?.collect{it.id+':'+it.toString()}.join(';'))}"}},
  	   	{name:'amount',width:300,search:true, editable: true, editrules:{required:true}},
  	   	{name:'donationDate',width:300,search:true, editable: true, editrules:{required:true},sorttype:"date"},
  	   	{name:'fundReceiptDate',width:300,search:true, editable: true, editrules:{required:true}},
  	   	{name:'receivedBy',width:300,search:true, editable: true, editrules:{required:true},edittype:"select",editoptions:{value:"${':--Please Select --;'+(ics.Individual.list()?.collect{it.id+':'+it.toString()}.join(';'))}"}},
  	   	{name:'id',hidden:true}
  	        ],
  	       onSelectRow: function(id){
	       	       		if(id && id!==lastsel3){
	       	       			jQuery('#donation_list').jqGrid('restoreRow',lastsel3);
	       	       			jQuery('#donation_list').jqGrid('editRow',id,true,pickdates);
	       	       			lastsel3=id;
	       	       		}
	       	              },

  	       rowNum:10,
  	       rowList:[10,20,30,40,50,100,200],
  	       pager: '#donation_list_pager',
  	       viewrecords: true,
  	       sortorder: "asc",
  	       width:1000 ,
  	       height: "100%",
  	         	       
  	       multiselect: true,
  	       caption:"Donation",
  	       });
  	       $("#donation_list").jqGrid('filterToolbar',{autosearch:true});
  	           $("#donation_list").jqGrid('navGrid',"#donation_list_pager",{edit:false,add:false,del:true,search:false});
  	           $("#donation_list").jqGrid('inlineNav',"#donation_list_pager");


  });
  
  function pickdates(id){
  	jQuery("#"+id+"_donationDate","#donation_list").datepicker({dateFormat:"yy-mm-dd"});
        }
  
  </script>
