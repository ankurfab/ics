<div>
<!-- table tag will hold our grid -->
<table id="commitment_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<!-- pager will hold our paginator -->
<div id="commitment_list_pager" class="scroll" style="text-align:center;"></div>

</div>


<script type="text/javascript">
  jQuery(document).ready(function () {
    jQuery("#commitment_list").jqGrid({
      url:'${createLink(controller:'commitment',action:'jq_commitment_list',params:['committedBy.id':committedByid])}',
      editurl:'${createLink(controller:'commitment',action:'jq_edit_commitment',params:['committedBy.id':committedByid])}',
      datatype: "json",
      colNames:['Scheme','DonationCommitment','CollectionCommitment','TotalCommittedAmount','ECSMandate','CommitmentOn','CommitmentTill','Status','HoldTill','id'],
      colModel:[
	{name:'scheme.id',editable: true,editrules:{required:true},edittype:"select",
	editoptions:{value:"${':--Please Select Scheme--;'+(ics.Scheme.createCriteria().list{
						and {
							le('effectiveFrom', new Date())
							ge('effectiveTill', new Date())
						    }
						    order('name', 'asc')
					})?.collect{it.id+':'+it.name}.join(';')}"}
	},
	{name:'committedAmount',editable: true},
	{name:'ccAmount',editable: true},
	{name:'totalCommittedAmount',editable: true},
	{name:'ecsMandate',editable: true},
	{name:'commitmentOn',editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}
	
	},
	{name:'commitmentTill',editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}
	
	},
	{name:'status',editable:true,editrules:{required:true},edittype:"select",editoptions:{value:"ACTIVE:ACTIVE;INACTIVE:INACTIVE;ON-HOLD:ON-HOLD"}},
	{name:'holdTill',editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50],
    pager: '#commitment_list_pager',
    viewrecords: true,
    gridview: true,
    sortname: 'id',
    sortorder: "asc",
    width: 800,
    height: "100%",
    caption:"Commitment List"
    });
  	           $("#commitment_list").jqGrid('navGrid',"#commitment_list_pager",{edit:false,add:false,del:true,search:false});
  	           $("#commitment_list").jqGrid('inlineNav',"#commitment_list_pager");
    });

</script>
