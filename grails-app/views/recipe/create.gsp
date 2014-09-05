<%@ page import="ics.Recipe" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'recipe.label', default: 'Recipe')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<r:require module="grid" />
	</head>
	<body>
		<a href="#create-recipe" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="create-recipe" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${recipeInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${recipeInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:formRemote name="recipeForm" update="updateMe" action="save" url="[controller: 'recipe', action:'save']" onSuccess="gridReload(data)">
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:formRemote>
			
			<!--<div id="updateMe">this div is updated with the result of the show call</div> Dont get confused - update attribute is just one amongst one amont several features that formremote tag provides -->
			
						
		</div>
		
		
		<div id="gridWrapper">
			<!-- table tag will hold our grid -->
			<table id="instruction_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="instruction_list_pager" class="scroll" style="text-align:center;"></div>
		</div>




<script>


        $(function() {
		$('#gridWrapper').hide();
	    jQuery("#instruction_list").jqGrid({
	      url:'${createLink(controller:'instructionGroup',action:'jq_ig_list',params:['rvid':recipeInstance?.defaultRecipe?.id?:0])}',
	      editurl:'${createLink(controller:'instructionGroup',action:'jq_ig_edit_list',params:['recipeVersion.id':1])}',
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
	       /*gridComplete: function() {
	            var recs = parseInt($("#instruction_list").getGridParam("records"),10);
	            if (isNaN(recs) || recs == 0) {
	                $("#gridWrapper").hide();
	            }
	            else {
	                $('#gridWrapper').show();
	                alert('records > 0');
	            }
	        },*/
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



	function gridReload(e)
		{ 
			//disable all other boxes
			disableBoxes()
			//alert("inside gridrelaod:"+e)
			$('#gridWrapper').show();
			jQuery("#instruction_list").jqGrid('setGridParam',{editurl:'${createLink(controller:'instructionGroup',action:'jq_ig_edit_list',params:['recipeVersion.id':''])}'+e})	; 
			jQuery("#instruction_list").jqGrid('setGridParam',{url:'${createLink(controller:'instructionGroup',action:'jq_ig_list',params:['rvid':''])}'+e,page:1}).trigger("reloadGrid"); 
  		}
  		
  		
  	function disableBoxes()
  		{
  		$("#name").attr('disabled', true);
  		$("#cuisineACBox").attr('disabled', true);
  		$("#category").attr('disabled', true);
  		$("#rating").attr('disabled', true);
  		$("#chef").attr('disabled', true);  		
  		}
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


	</body>
</html>

			

