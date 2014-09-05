<%@ page import="ics.Recipe"	 %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'recipe.label', default: 'Recipe')}" />
		<title>Recipe</title>
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
			
			<table><tr><td>
			<div class="editDelete">
			    <a href="javascript:editFunction()">			    
			        Edit</a>    
			    <a href="${createLink(uri:'/recipe/recipe?id='+ recipeInstance?.id +'')}&cmd=delete">			        
			        Delete</a>			    
			</div>
			</td></tr></table>
			
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
					<g:hiddenField name="Command" value="${cmd}" />
					<g:hiddenField name="recipeId" value="${recipeInstance?.id}"/>					
				</fieldset>
				
			<div id="submitButton">	
				<fieldset class="buttons">
					<g:submitButton id="btn" name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />					
				</fieldset>
			</div>				
				
			</g:formRemote>
						
			<!--<div id="updateMe">this div is updated with the result of the show call</div>-->									
		</div>	
				
		<div id="gridWrapper">			       
		      <center>
		        
			<!-- table tag will hold our grid for preproccesor instructions-->
			<table id="instruction_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
		      	<div id="instruction_list_pager" class="scroll" style="text-align:center;"></div>		      				        	
			
			<br/><div> 
			 	Yield <input type="text" id="set_yield" /> 
			 	<!--Unit <input type="text" id="set_unit" /> -->
			 	Unit <g:select name="set_unit" id="set_unit" from="${[recipeInstance?.defaultRecipe?.yield1? recipeInstance?.defaultRecipe?.yieldUnit1:'',recipeInstance?.defaultRecipe?.yield2? recipeInstance?.defaultRecipe?.yieldUnit2:'',recipeInstance?.defaultRecipe?.yield3? recipeInstance?.defaultRecipe?.yieldUnit3:'']}"/>
			 	
				<button onclick="gridyieldReload()" id="submitButton">Submit Yield</button> 
			</div> <br/>
					      				        
		      	<!-- table tag will hold our grid -->
		      	<table id="item_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		      	<!-- pager will hold our paginator -->
		      	<div id="item_list_pager" class="scroll" style="text-align:center;"></div>

			
			<button type="button" class="menuButton" id="create-instruction" value="InstructionDialog">				
			<font size='2'>Select items & add recipe instruction</font>
			</button>   
			
			<button type="button" class="menuButton" id="formula" value="formula">				
			<font size='2'>Item formula</font>
			</button>   

			<button type="button" class="menuButton" id="edit-instruction" value="InstructionEdit">				
			<font size='2'>Edit selected instruction</font>
			</button>   

			<br/><br/>
			
		      	<!-- table tag will hold our grid for postproccesor instructions-->
			<table id="foot_note" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="foot_note_pager" class="scroll" style="text-align:center;"></div>
						
		      </center>			      		      		      
		</div>
				
		<div id="dialog-form" title="Instruction">
			<form>
			<fieldset>
				<label for="desc">Instruction For Selected Items</nlabel>
				<textarea rows="2" cols="2" name="instruction" id="instr" class="text ui-widget-content ui-corner-all"></textarea> 
			</fieldset>
			</form>
		</div>

		<div id="edit-form" title="Edit Instruction">
			<form>
			<fieldset>
				<label for="desc">Edit Selected Instruction</nlabel>
				<textarea rows="2" cols="2" name="editinstruction" id="editInstr" class="text ui-widget-content ui-corner-all"></textarea> 

			</fieldset>
			</form>
		</div>
		
		<div id="formula-form" title="Enter conditional yield : quantity pairs">
			<form>
			<fieldset>
				<!--textarea rows="2" cols="2" name="formula" id="formula" class="text ui-widget-content ui-corner-all"></textarea> -->
			<table>
			  <tr>
			      <td>
				<label for="desc"> if Yield > </nlabel>
				<input type="text" name="yieldFormula1" id="yieldFormula1" class="text ui-widget-content ui-corner-all"/>
			      </td>
			      <td>
				<label for="desc">then Quantity = </nlabel>
				<input type="text" name="qtyFormula1" id="qtyFormula1" class="text ui-widget-content ui-corner-all"/>
			      </td>
			  </tr>
			  <tr>
			      <td>
				<label for="desc"> or if Yield > </nlabel>
				<input type="text" name="yieldFormula2" id="yieldFormula2" class="text ui-widget-content ui-corner-all"/>
			      </td>
			      <td>
				<label for="desc">then Quantity = </nlabel>
				<input type="text" name="qtyFormula2" id="qtyFormula2" class="text ui-widget-content ui-corner-all"/>
			      </td>
			  </tr>			  
			</table>
			
			<br/>OR<br/>
			
			<table>
			  <tr>
			      <td>
				<label for="desc">Quantity= </nlabel>				
      			      </td>
      			      <td>
      			      	<label for="desc"> Yield* </nlabel>
      			      </td>
			      <td>
				<input type="text" name="formulaCoeff" id="formulaCoeff" class="text ui-widget-content ui-corner-all"/>
			      </td>
			      <td>
			      	<g:select name="formulaOper" id="formulaOper" from="${['+', '-', '*', '/']}"/> 	     
			      </td>
			      <td>
			      	<input type="text" name="formulaConstant" id="formulaConstant" class="text ui-widget-content ui-corner-all"/>
      			      </td>
			  </tr>
			 </table> 

			<br/>OR<br/>
			
			<table>
			  <tr>
			      <td>
				<label for="desc">Quantity= </nlabel>				
      			      </td>
      			      <td>
      			      	<label for="desc">(item)</nlabel>
      			      </td>
			      <td>
				<input type="text" name="formulaItem1" id="formulaItem1" class="text ui-widget-content ui-corner-all"/>
			      </td>
      			      <td>
      			      	<label for="desc">(coeff)</nlabel>
      			      </td>			      
      			      <td>
				<input type="text" name="formulaItemCoeff1" id="formulaItemCoeff1" class="text ui-widget-content ui-corner-all"/>
			      </td>			      			     
			  </tr>
			  <tr>
			      <td>+</td>
			  </tr>

						  
			</table>
			
			</fieldset>
			</form>
		</div>
		
<script>

        $(function() {
		if("${cmd}"=="create")
		    {						
			$('#gridWrapper').hide();	
			$('#editDelete').hide();				
			//Setting the pager div parameter
			
			
		    } 			
		if("${cmd}"=="show")
		    {
			$('#submitButton').hide();			
			disableBoxes();
			
			//Setting the pager div parameter			
		    }
		
	    
	    jQuery("#instruction_list").jqGrid({
	    	      url:'${createLink(controller:'instructionGroup',action:'jq_ig_list',params:['recipeVersion.id':recipeInstance?.defaultRecipe?.id?:0])}',
	    	      editurl:'${createLink(controller:'instructionGroup',action:'jq_ig_edit_list',params:['recipeVersion.id':recipeInstance?.defaultRecipe?.id?:0])}',
	    	      datatype: "json",
	    	      colNames:['sno','instid','instruction','id'],
	    	      colModel:[
	    	        {name:'sno', hidden:false, width:5},  
	    	        {name:'instid', hidden:true}, 
	    		{name:'instruction', editable:true},	    		
	    		{name:'id',hidden:true}
	    	     ],
	    	    rowNum:10,
	    	    rowList:[10],
	    	    pager: '#instruction_list_pager',
	    	    viewrecords: true,
	    	    gridview: true,
	    	    sortorder: "desc",
	    	    height: "100%",
	    	    width: "1100",
	    	    caption:"Preprocessing Instructions"
	    	    }).navGrid('#instruction_list_pager',
	    			{add:true,edit:true,del:true, search: false}, // which buttons to show?	    			
	    			{afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterEdit:true},
	    			{addCaption:'New Preprocessing Instruction',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
	    			{}          // delete options
	    	    );
	    	   
	    jQuery("#foot_note").jqGrid({
	    	    	     
	    	    	     	url:'${createLink(controller:'Instruction',action:'jq_instruction_list',params:['recipeVersion.id':recipeInstance?.defaultRecipe?.id?:0])}',
	    	    		editurl:'${createLink(controller:'Instruction',action:'jq_instruction_edit_list',params:['recipeVersion.id':recipeInstance?.defaultRecipe?.id?:0])}',
	    	    
	    	    		datatype: "json",
	    	    		
	    	    		colNames:['sno','instruction', 'id'],
	    	    		colModel:[
	    	    		   {name:'sno', editable:false, width:5},
	    	    		   {name:'instruction', editable:true},
	    	    		   {name:'id',hidden:true}
	    	    		],
	    	    		rowNum:10,
	    	    		rowList:[10,20],
	    	    		pager: foot_note_pager,			     
	    	    		viewrecords: true,
	    	    		sortorder: "desc",
	    	    	        height: "100%",
	    	    	        width: "1100",	    	    	        
	    	    	        caption:"Foot note"	    	    	        	    	    	   	    	   
	    	    	}).navGrid('#foot_note_pager',
	    	    		{add:true,edit:true,del:true, search: false}, // which buttons to show?
	    	    		{afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterEdit:true},         // edit options
	    	    		{addCaption:'New foot note',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
	    	    		{}          // delete options
	    	    );
	    
	    
	    
	    
	    var prevCellVal = { cellId: undefined, value: undefined };
	 
	    jQuery("#item_list").jqGrid({
	     
	     	url:'${createLink(controller:'ItemCount',action:'jq_item_list',params:['recipeVersion.id':recipeInstance?.defaultRecipe?.id?:0])}',
		editurl:'${createLink(controller:'ItemCount',action:'jq_item_edit_list',params:['recipeVersion.id':recipeInstance?.defaultRecipe?.id?:0])}',

		datatype: "json",
		
		colNames:['seq no','ic num','name','qualifier','qty', 'unit','qty', 'unit', 'subqty', 'subunit','instruction', 'id'],
		colModel:[
		   {name:'seq no', editable:false, hidden:true},
		   {name:'ic no', editable:false, hidden:true},
		   {name:'name', editable:true, formatter: 'showlink', 
		     formatoptions:{baseLinkUrl:'${createLink(controller:'Item',action:'show')}',addParam:'&ic_id=true'},
		    'edittype'    : 'custom',
		    'editoptions' : {
		      'custom_element' : autocomplete_element,
		      'custom_value'   : autocomplete_value
			     }, cellattr: function (rowId, tv, rawObject, cm, rdata) { return 'style="white-space: normal;"' }},
		   {name:'qualifier', editable:true}, 
		   {name:'nqty', editable:true, width:150},
		   {name:'nunit', editable:true, width:150,
		   	   edittype:"select", formatoptions: {disabled : false}, editoptions:{value:"ML:ML;L:L;GMS:GMS;KG:KG;PIECES:PIECES;SPOONS:SPOONS;CUPS:CUPS;BUNCHES:BUNCHES"}
			   },
		   {name:'qty', editable:false, width:300},
		   {name:'unit', editable:false, hidden:true,
			   edittype:"select", formatoptions: {disabled : false}, editoptions:{value:"ML:ML;L:L;GMS:GMS;KG:KG;PIECES:PIECES;SPOONS:SPOONS;CUPS:CUPS;BUNCHES:BUNCHES"}
			   },
		   {name:'subqty', editable:false, hidden:true},  
		   {name:'subunit', editable:false, hidden:true},
		   {name:'inst',width:800, editable:false,
		   	cellattr: function (rowId, val, rawObject, cm, rdata) {
				var result;

				if (prevCellVal.value == val) {
				    result = ' style="display: none" rowspanid="' + prevCellVal.cellId + '"';
				}
				else {
				    var cellId = this.id + '_row_' + rowId + '_' + cm.name;

				    result = ' style="white-space: normal;" rowspan="1" id="' + cellId + '"';
				    prevCellVal = { cellId: cellId, value: val };
				}
				
				return result;				
			 }		   
		   },			
		   {name:'id',hidden:true}
		],
		rowNum:10,
		rowList:[10,20,30,40,50],
		pager: item_list_pager,			     
		viewrecords: true,
		sortorder: "desc",
	        height: "100%",
	        width: "1350",
	        multiselect: true,
	        caption:"Items",
	        		
		beforeSelectRow: function () {
			return true;
		},
		
		ondblClickRow: function (rowid) {
		                var rowData = jQuery("#item_list").jqGrid("getRowData",rowid); 			    		                
		                
		                var url = "${createLink(controller:'ItemCount',action:'jq_item_list',params:['recipeVersion.id':recipeInstance?.defaultRecipe?.id?:0])}"
					    		                        
				jQuery("#item_list").jqGrid('setGridParam',{url:url +"&ic_no="+ rowData['ic no'] +"",page:1}).trigger("reloadGrid");				    			             
            	},
            	
		gridComplete: function () {
			var grid = this;

			$('td[rowspan="1"]', grid).each(function () {
			    var spans = $('td[rowspanid="' + this.id + '"]', grid).length + 1;

			    if (spans > 1) {
				$(this).attr('rowspan', spans);
			    }
			});
	    	}	

	}).navGrid('#item_list_pager',
		{add:true,edit:true,del:true, search: false}, // which buttons to show?
		{afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterEdit:true},         // edit options
		{addCaption:'Create new Item',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
		{}          // delete options
	    );
		    
	//$("#item_list").jqGrid('inlineNav',"#item_list_pager");
	
	/*if("${cmd}"=="show")
	{
		jQuery("#item_list").jqGrid('hideCol',["nqty","nunit"]);
		jQuery("#item_list").jqGrid('showCol',["qty"]);	
	}
	if("${cmd}"=="create")
	{
		jQuery("#item_list").jqGrid('showCol',["nqty","nunit"]);
		jQuery("#item_list").jqGrid('hideCol',["qty"]);	

	}*/
	
		
	jQuery("#item_list").jqGrid(
	    'sortableRows',
	     { update : function(ev,ui) {
	                
			var rowData1, rowData2, rowData3;
			
			var item = ui.item[0], ri = item.rowIndex, itemId = item.id, value = item.value ;					
			
			rowData2 = jQuery("#item_list").jqGrid("getRowData",item.id); 					
			
			var message = "The row with the id=" + itemId + "(" + rowData2['ic no'] + ") is moved. The new row index is " + ri;
			
			var string, constant;
			var i=0, rd2, incr=0;
			
			if (ri > 1 && ri < this.rows.length - 1) {
			
			    rowData1 = jQuery("#item_list").jqGrid("getRowData",this.rows[ri-1].id); 			    
			    rowData3 = jQuery("#item_list").jqGrid("getRowData",this.rows[ri+1].id); 			    
			    
			    alert(message + '\nThe row is inserted between item with rowid=' +
				this.rows[ri-1].id +'('+ rowData1['ic no'] + ') and the item with the rowid=' +
				this.rows[ri+1].id);
							    
			    string = ''+ item.id ; 			    
			    
			    if(ri<rowData2['ic no'])
			    {
			       constant =  parseInt(rowData1['ic no']) + 1;
			       rd2=parseInt(rowData2['ic no'])+1;
			       alert(rd2)
			    	for(i=ri+1; i<rd2; i++)
			    	{			    		
			    		string += ','+this.rows[i].id+'';
			    	}			    
			    	incr=1;
			    }
			    else
			    {
			    	constant =  parseInt(rowData3['ic no']) - 1;
			    	rd2=parseInt(rowData2['ic no'])-1;
			    	for(i=ri-1; i>rd2; i--)
			    	{
					string += ','+this.rows[i].id+'';
			    	}
			    	incr=0;
			    				    	
			    }					    			     
								
			} else if (ri > 1) {
			    rowData1 = jQuery("#item_list").jqGrid("getRowData",this.rows[ri-1].id); 
						
			    alert(message +
				'\nThe row is inserted as the last item after the item with rowid=' + this.rows[ri-1].id + '(' + rowData1['ic no'] +')' );
				
			    string = ""+ item.id +"";
			    constant =  this.rows.length - 1;        		        	
			    
			    rd2=parseInt(rowData2['ic no'])-1;
			    for(i=ri-1; i>rd2; i--)
			    {
				string += ','+this.rows[i].id+'';
			    }
			    incr=0;

			} else if (ri < this.rows.length - 1) {
			    rowData1 = jQuery("#item_list").jqGrid("getRowData",this.rows[ri+1].id); 
						
			    alert(message +
				'\nThe row is inserted as the first item before the item with rowid=' + this.rows[ri+1].id + '(' + rowData1['name'] +')');
			    
			    string = ""+ item.id +"";	
			    constant =  1;	
			    
			    rd2=parseInt(rowData2['ic no'])+1;
			    for(i=ri+1; i<rd2; i++)
			    {			    		
				string += ','+this.rows[i].id+'';
			    }
			    incr=1;

			 
			} else {
			    rowData1 = jQuery("#item_list").jqGrid("getRowData",this.rows[ri-1].id); 
						
			    alert(message);
        		}
        		
        		//rowData = jQuery("#item_list").jqGrid("getRowData",rowId); 
        		//var no_rows = this.rows.length - 1;        		        	
        		
        		var urlString = "${createLink(controller:'ItemCount',action:'jq_item_list')}";
					
		        jQuery("#item_list").jqGrid('setGridParam',{url:urlString +"?recipeVersion.id="+ ${recipeInstance?.defaultRecipe?.id} +"&id1="+rowData1['id']+"&constant="+constant+"&string="+string+"&incr="+incr+"&seq1="+rowData1['seq no']+"&seq2="+rowData2['seq no']+"",page:1}).trigger("reloadGrid");		
		
			//$.getJSON("${g.createLink(controller:'itemCount',action:'jq_sequence_order')}"+"?id1="+rowData1['id']+"&constant="+constant+"&string="+string+"&incr="+incr+"&seq1="+rowData1['seq no']+"&seq2="+rowData2['seq no']+"");
	          }
    	     });
    	     
    	jQuery("#item_list").jqGrid('setGroupHeaders', {     	           	        
    		useColSpanStyle: true, 
    		groupHeaders:[     		        
    			{startColumnName: 'nqty', numberOfColumns: 2, titleText: '<center><em>For Yield:</em><br/><br/>' + ${recipeInstance?.defaultRecipe?.yield1} + ' ' + ${"'"+recipeInstance?.defaultRecipe?.yieldUnit1+"'"} + ' <font size="1">or</font> ' + ${recipeInstance?.defaultRecipe?.yield2} + ' ' + ${"'"+recipeInstance?.defaultRecipe?.yieldUnit2+"'"} + ' <font size="1">or</font> ' + ${recipeInstance?.defaultRecipe?.yield3?:" "} + ' ' + ${"'"+recipeInstance?.defaultRecipe?.yieldUnit3+"'"} + '<br/><br/></center>'}, 
    			{startColumnName: 'qty', numberOfColumns: 1, titleText: '<center><em>For input yield:</em><br/><br/>' } 
    		    ] 
    		});
	
	$( "#create-instruction" )
	    		.button()
	    		.click(function() {				
	    			//$('#item_list').jqGrid('sortGrid', 'id');
	    			
	    			var idlist = jQuery("#item_list").jqGrid('getGridParam','selarow');
	    			
	    			if(idlist!='')
	    				{
	    					//alert(idlist);
	    					$( "#dialog-form" ).dialog( "open" );
	    				}
	    			else
	    				alert("Select at least 1 item!!");
	    		});
	    
	 $( "#edit-instruction" )
	    		.button()
	    		.click(function() {				
	    			//$('#item_list').jqGrid('sortGrid', 'id');
	    			
	    			var idlist = jQuery("#item_list").jqGrid('getGridParam','selarrrow');
	    			
	    			if(idlist!='')
	    				{	    					
	    					$( "#edit-form" ).dialog( "open" );
	    				}
	    			else
	    				alert("Select an instrucution to edit!!");
	    		});
	    		
	 $( "#formula" )
			.button()
			.click(function() {								

				var idlist = jQuery("#item_list").jqGrid('getGridParam','selarrrow');

				if(idlist =='')
					alert("Please select an item !!");
				else if(idlist.length > 1)
					alert("Please select only one item !!");
				else
					{	    					
						$( "#formula-form" ).dialog( "open" );
					}								
			});

	 $( "#formula-form" ).dialog({
	 				autoOpen: false,
					height: 370,
					width: 500,
					modal: true,
					open: function(){					
					},
					buttons: {
						"OK": function() {
							
							$( this ).dialog( "close" );
						},
						Cancel: function() {
							$( this ).dialog( "close" );
						}
					},
					close: function() {
	    				}
	 		});
	 		
	 $( "#edit-form" ).dialog({
	 	    			autoOpen: false,
	 	    			height: 370,
	 	    			width: 375,
	 	    			modal: true,
	 	    			open: function(){
	 	    				var idlist = jQuery("#item_list").jqGrid('getGridParam','selarrrow');
	 	    				var i, rowData, previousInstr, count=0;	    					    			
	 	    				
	 	    				for(i=0; i<idlist.length; i++)
	 	    				{
	 	    					rowData = jQuery("#item_list").jqGrid("getRowData",idlist[i]); 	    						    				
	 	    					
	 	    					if(count==0)
	 	    						previousInstr = rowData['inst']
	 	    						
	 	    					if(previousInstr != rowData['inst'])
	 	    					{	    					
	 							alert("Please select only one instruction to edit");
	 							$( this ).dialog( "close" );
	 	    					}
	 	    					
	 	    					if(count!=0)
	 	    						previousInstr = rowData['inst']
	 	    					
	 	    					count++;
	 	    				}
	 	    				
	 	    				$('#editInstr').attr('disabled', false);
	 	    				
	 	    				if(rowData['inst'] != "dummy instruction" && rowData['inst'] != "")
	 	    				{	    					
	 	    					$('#editInstr').val(rowData['inst']);
	 	    				}
	 	    				else
	 	    				{
	 	    					$('#editInstr').val('');
	 	    				}	    					    							
	 	    			},
	 	    			buttons: {
	 	    				"EDIT":function(){
	 	    					var instructionDialog = $('#editInstr').val();
	 	    					var idlist = jQuery("#item_list").jqGrid('getGridParam','selarrrow')
	 	    					
	 	    					rowData = jQuery("#item_list").jqGrid("getRowData",idlist[0]); 
	 	    					
	 	    					var seqno = rowData['seq no'];
	 	    					var instruction = rowData['instruction']; 
	 	    					
	 	    					var url = "${createLink(controller:'ItemCount',action:'jq_item_list',params:['recipeVersion.id':recipeInstance?.defaultRecipe?.id?:0])}"
	 	    		                        
	 	    		                        jQuery("#item_list").jqGrid('setGridParam',{url:url +"&instruction="+instruction+"&seqno="+seqno+"&ids="+idlist+"&instructionDialog="+instructionDialog+"&edit=1",page:1}).trigger("reloadGrid");				    			                
	 	    
	 	    					$( this ).dialog( "close" );	    						    				
	 	    				},
	 	    				Cancel: function() {
	 	    					$( this ).dialog( "close" );
	 	    				}
	 	    			},
	 	    			close: function() {
	 	    
	 	    			}
	 	    		});
	
	 
	 
	 $( "#dialog-form" ).dialog({
	    			autoOpen: false,
	    			height: 370,
	    			width: 375,
	    			modal: true,
	    			open: function(){	    			
    					$('#instr').attr('disabled', false);
    					$('#instr').val('');	    					    					    						
	    			},
	    			buttons: {
	    				"OK": function() {
	    					var instructionDialog = $('#instr').val();
	    					var idlist = jQuery("#item_list").jqGrid('getGridParam','selarrrow')
	    					
	    					var url = "${createLink(controller:'ItemCount',action:'jq_item_list',params:['recipeVersion.id':recipeInstance?.defaultRecipe?.id?:0])}"
	    		                        
	    		                        jQuery("#item_list").jqGrid('setGridParam',{url:url +"&ids="+idlist+"&instructionDialog="+instructionDialog+"&edit=0",page:1}).trigger("reloadGrid");			
	    			             
	    					$( this ).dialog( "close" );
	    				},
	    				Cancel: function() {
	    					$( this ).dialog( "close" );
	    				}
	    			},
	    			close: function() {
	    
	    			}
	    		});
	
		    
	});

	/*
	jQuery("#m1").click( function() {
		var url = "${createLink(controller:'ItemCount',action:'printids',params:['ids':''])}"+jQuery("#item_list").jqGrid('getGridParam','selarrrow');
		window.location = url;
	});*/

	function gridyieldReload()
	{
		var yield_mask = jQuery("#set_yield").val(); 
		var unit_mask = jQuery("#set_unit").val(); 
		
		var urlString = "${createLink(controller:'ItemCount',action:'jq_item_list')}";
		
		jQuery("#item_list").jqGrid('setGridParam',{url:urlString +"?recipeVersion.id="+ ${recipeInstance?.defaultRecipe?.id} +"&yield="+yield_mask+"&unit="+unit_mask+"",page:1}).trigger("reloadGrid");		
	}
	
	
	function editFunction()
	{		
		$('#submitButton').show();			
		enableBoxes();
		document.getElementById("btn").value= "Update";	
		document.getElementById("Command").value= "edit";		
	}

	function gridReload(e)
	{ 			
		/*var row_id= jQuery("#instruction_list").jqGrid('getGridParam','selrow');
		var instrid = jQuery("#instruction_list").jqGrid('getRowData',row_id);//
		alert(instrid.instid);
		*/

		//disable all other boxes			
		disableBoxes();			

		$('#submitButton').hide();

		$('#gridWrapper').show();

		jQuery("#instruction_list").jqGrid('setGridParam',{editurl:'${createLink(controller:'instructionGroup',action:'jq_ig_edit_list',params:['recipeVersion.id':''])}'+e}); 
		jQuery("#instruction_list").jqGrid('setGridParam',{url:'${createLink(controller:'instructionGroup',action:'jq_ig_list',params:['recipeVersion.id':''])}'+e,page:1}).trigger("reloadGrid"); 

		jQuery("#item_list").jqGrid('setGridParam',{editurl:'${createLink(controller:'itemCount',action:'jq_item_edit_list',params:['recipeVersion.id':''])}'+e}); 
		jQuery("#item_list").jqGrid('setGridParam',{url:'${createLink(controller:'itemCount',action:'jq_item_list',params:['recipeVersion.id':''])}'+e,page:1}).trigger("reloadGrid"); 
	}
  		
  		
  	function disableBoxes()
  	{
  		$("#name").attr('disabled', true);
  		$("#cuisineACBox").attr('disabled', true);
  		$("#category").attr('disabled', true);
  		$("#rating").attr('disabled', true);
  		$("#chef").attr('disabled', true); 
  		
  		$("#recipeStatus").attr('disabled', true); 
  		$("#spicy").attr('disabled', true); 
  		$("#healthy").attr('disabled', true); 
  		$("#economical").attr('disabled', true); 
  		$("#preprationtime").attr('disabled', true); 
  		$("#shelflife").attr('disabled', true); 
  		$("#feedback").attr('disabled', true); 
  	}
  		
  	function enableBoxes()
  	{
  		$("#name").attr('disabled', false);
		$("#cuisineACBox").attr('disabled', false);
		$("#category").attr('disabled', false);
		$("#rating").attr('disabled', false);
		$("#chef").attr('disabled', false);  
		
		$("#recipeStatus").attr('disabled', false); 
		$("#spicy").attr('disabled', false); 
		$("#healthy").attr('disabled', false); 
		$("#economical").attr('disabled', false); 
		$("#preprationtime").attr('disabled', false); 
		$("#shelflife").attr('disabled', false); 
		$("#feedback").attr('disabled', false);   		
  	}
  		
  	function beforeSubmitEvent() {	
  			//alert('hello');
  			//alert(rowid);
  			//alert(properties);
  			
  			var row_id= jQuery("#instruction_list").jqGrid('getGridParam','selrow');
			if(row_id)
			{
				var instrid = jQuery("#instruction_list").jqGrid('getRowData',row_id);//
				alert(instrid.instruction);
				
				//var url = "instructionGroup/jq_ig_edit_list?instid="+instrid.instid+"&instructionString="+instrid.instruction;
				//jQuery("#instruction_list").jqGrid('setGridParam',{url:url}).trigger("reloadGrid"); 				
				jQuery("#instruction_list").jqGrid('setGridParam',{url:'${createLink(controller:'instructionGroup',action:'jq_ig_edit_list')}?instructionString=' + instrid.instruction + '&instid=' +instrid.instid}).trigger("reloadGrid"); 		
			}
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
		    		  $ac.autocomplete({
						source: "${createLink(controller:'item',action:'list')}"+".json",
						select: function(event, ui) {
						
							if(ui.item){
							    //alert("Selected item: "+ui.item.value);							            
							    if(ui.item.value == 'NEW')
							    {
								//open dialog here
								//$( "#" ).dialog( "open" );
								var url = "${createLink(controller:'item',action:'create')}";
								alert(url)
								window.location.href = url;
								//$jQuery(window).attr("location",url);						
							    }
							}
							//$('#search').submit();
							}
		    		  		});
		    		  // returning element back to jqGrid		    		  
		    		  return $ac;
		    		}
		    
	function autocomplete_value(elem, op, value) {	
	
		    		if (op == "set") {
		    		    $(elem).val(value);
		    		  }
		    		  return $(elem).val();
		    		}
	$(function() {
			$( "#formulaItem1" ).autocomplete({
				source: "${createLink(controller:'item',action:'list')}",
				minLength: 1,
				  select: function(event, ui) { // event handler when user selects a company from the list.
				   $("#formulaItem1").val(ui.item); // update the hidden field.
				  }
			});
		});
</script>


	</body>
</html>

			

