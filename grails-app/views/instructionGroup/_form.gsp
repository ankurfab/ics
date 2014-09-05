<%@ page import="ics.InstructionGroup" %>



<div class="fieldcontain ${hasErrors(bean: instructionGroupInstance, field: 'instructionSeq', 'error')} ">
	<label for="instructionSeq">
		<g:message code="instructionGroup.instructionSeq.label" default="Instruction Seq" />
		
	</label>
	<g:select name="instructionSeq" from="${ics.InstructionSequence.list()}" multiple="multiple" optionKey="id" size="5" value="${instructionGroupInstance?.instructionSeq*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: instructionGroupInstance, field: 'sequence', 'error')} required">
	<label for="sequence">
		<g:message code="instructionGroup.sequence.label" default="Sequence" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sequence" required="" value="${fieldValue(bean: instructionGroupInstance, field: 'sequence')}"/>
</div>


	<!-- table tag will hold our grid -->
	<table id="instruction_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
	<!-- pager will hold our paginator -->
	<div id="instruction_list_pager" class="scroll" style="text-align:center;"></div>

	<script>
	$(function() {
	    jQuery("#instruction_list").jqGrid({
	      url:'${createLink(controller:'instructionGroup',action:'jq_ig_list',params:['rvid':instructionGroupInstance.recipeVersion.id])}',
	      editurl:'${createLink(controller:'instructionGroup',action:'jq_ig_edit_list',params:['recipeVersion.id':instructionGroupInstance.recipeVersion.id])}',
	      datatype: "json",
	      colNames:['instruction','instid','id'],
	      colModel:[
		{name:'instruction', editable:true},
		{name:'instid', editable:false},
		{name:'id',hidden:true}
	     ],
	    rowNum:10,
	    rowList:[10,20,30,40,50],
	    pager: '#instruction_list_pager',
	    viewrecords: true,
	    gridview: true,
	    sortorder: "desc",
	    height: "100%",
	    caption:"Instructions",
	    subGrid: true,
		subGridRowExpanded: function(subgrid_id, row_id) {
			// we pass two parameters
			// subgrid_id is a id of the div tag created whitin a table data
			// the id of this elemenet is a combination of the "sg_" + id of the row
			// the row_id is the id of the row
			// If we wan to pass additinal parameters to the url we can use
			// a method getRowData(row_id) - which returns associative array in type name-value
			// here we can easy construct the flowing
			var subgrid_table_id, pager_id;
			
			var instrid = jQuery("#instruction_list").jqGrid('getRowData',row_id);//
			
					
			subgrid_table_id = subgrid_id+"_t";
			pager_id = "p_"+subgrid_table_id;
			$("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
			jQuery("#"+subgrid_table_id).jqGrid({
				url:'${createLink(controller:'instructionGroup',action:'jq_item_list',params:['instid':''])}'+instrid.instid,
				editurl:'${createLink(controller:'instructionGroup',action:'jq_item_edit_list',params:['instid':''])}'+instrid.instid,
				
				datatype: "json",
				colNames:['name','quantity', 'unit','id'],
				colModel:[
				   {name:'name', editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
   				     }},
				   {name:'quantity', editable:true},
		                   {name:'unit', editable:true},
		                   {name:'id',hidden:true}
				],
				rowNum:10,
			        rowList:[10,20,30,40,50],
			        pager: pager_id,			     
			        viewrecords: true,
			        sortorder: "desc",

			    height: '100%'
			});
			jQuery("#"+subgrid_table_id).jqGrid('navGrid',"#"+pager_id,{edit:false,add:true,del:false},{},{addCaption:'Create New Instruction',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},{})
		},
		subGridRowColapsed: function(subgrid_id, row_id) {
			// this function is called before removing the data
			//var subgrid_table_id;
			//subgrid_table_id = subgrid_id+"_t";
			//jQuery("#"+subgrid_table_id).remove();
		}	    
	    }).navGrid('#instruction_list_pager',
			{add:true,edit:true,del:true, search: false}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New Instruction',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
		    );

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
	    
	    function autocomplete_element(value, options) {
	    		  // creating input element
	    		  var $ac = $('<input type="text"/>');
	    		  // setting value to the one passed from jqGrid
	    		  $ac.val(value);
	    		  // creating autocomplete
	    		  $ac.autocomplete({source: "${createLink(controller:'item',action:'list')}"+".json"});
	    		  // returning element back to jqGrid
	    		  return $ac;
	    		}
	    
	    function autocomplete_value(elem, op, value) {
	    			alert(elem) 
	    			alert(op) 
	    			alert(value)
	    		  if (op == "set") {
	    		    $(elem).val(value);
	    		  }
	    		  return $(elem).val();
	    		}


	</script>
