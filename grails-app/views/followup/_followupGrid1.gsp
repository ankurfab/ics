<div>
<!-- table tag will hold our grid -->
<table id="followup_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<!-- pager will hold our paginator -->
<div id="followup_list_pager" class="scroll" style="text-align:center;"></div>

</div>

<script type="text/javascript">
  jQuery(document).ready(function () {
	var lastsel;
    jQuery("#followup_list").jqGrid({
      url:'${createLink(controller:'followup',action:'jq_followup_list1',params:['cmd':cmd,'findwithid':findwithid,'findbyid':findbyid])}',
      editurl:'${createLink(controller:'followup',action:'jq_edit_followup',params:['cmd':cmd,'findwithid':findwithid,'findbyid':findbyid])}',
      datatype: "json",
      colNames:['Category','StartDate','EndDate','Description','Comments','Status','Reference','By','With','WithId','id'],
      colModel:[
	{name:'category', editable:true,edittype:"select",editoptions:{value:"PREACHING:PREACHING;DONATION:DONATION;EVENT:EVENT;OTHER:OTHER"},
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'Followup',action:'show')}'}
	},
	{name:'startDate', editable:true, editoptions:{size:20, 
                  dataInit:function(el){ 
                        $(el).datetimepicker({dateFormat:'dd-mm-yy'}); 
                  }}},
	{name:'endDate', editable:true, editoptions:{size:20, 
                  dataInit:function(el){ 
                        $(el).datetimepicker({dateFormat:'dd-mm-yy'}); 
                  }}},
	{name:'description', editable:true},
	{name:'comments', editable:true,edittype:"textarea", editoptions:{rows:"2",cols:"20"}},
	{name:'status', editable:true,edittype:"select",editoptions:{value:"OPEN:OPEN;CLOSE:CLOSE"}},
	{name:'ref', editable:true},
	{name:'followupBy'},
	{name:'followupWith',
		formatter: function (cellvalue, options, rowObject) {
		    return '<a href="${createLink(controller:'Individual',action:'show')}?id='+rowObject[9]+ '">' +
			   cellvalue + '</a>'; 
		}
	},
	{name:'withid',hidden:true},
	{name:'id',hidden:true}
     ],
    /*onSelectRow: function(id){ 
    	if(id && id!==lastsel){ 
    		jQuery('#followup_list').jqGrid('restoreRow',lastsel);
    		jQuery('#followup_list').jqGrid('editRow',id,true,pickdates);
    		lastsel=id; }
    		},*/ 
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#followup_list_pager',
    viewrecords: true,
    gridview: true,
    sortorder: "desc",
    width: 1200,
    height: "100%",
    caption:"Followup List"
    });
    $("#followup_list").jqGrid('filterToolbar',{autosearch:true});
   $("#followup_list").jqGrid('navGrid',"#followup_list_pager",
	{add:false,edit:false,del:false,search:false}, // which buttons to show?
	{},         // edit options
	{addCaption:'Create New Followup',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
	{}          // delete options
	//{multipleSearch:true}	
    );
    
    function pickdates(id){
  	jQuery("#"+id+"_startDate","#followup_list").datetimepicker({dateFormat:"dd-mm-yy"});
  	jQuery("#"+id+"_endDate","#followup_list").datetimepicker({dateFormat:"dd-mm-yy"});
  	}
  	
  });

 function afterSubmitEvent(response, postdata) {
	var success = true;

	var json = eval('(' + response.responseText + ')');
	var message = json.message;

	if(json.state == 'FAIL') {
	    success = false;
	} else {
	  $('#message').html(message);
	  $('#message').show().fadeOut(10000);
	}

	var new_id = json.id
	return [success,message,new_id];
    }

</script>
