
<%@ page import="ics.Recipe" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'recipe.label', default: 'Recipe')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<r:require module="grid" />
	</head>
	<body>
		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
		    <span class="menuButton"><g:link class="create" action="recipe" params="[cmd:'create']">Create</g:link></span>
		</div>
		<div class="h">Search By:</div>
		
		
		<div> Name <br /> <input type="text" id="search_name" /> </div> 
		<div> Category <br /> <input type="text" id="search_category" /> </div> 
		<div> Cuisine <br /> <input type="text" id="search_cuisine" /> </div>
		<div> Chef <br /> <input type="text" id="search_chef" /> </div>
		<div> Item <br /> <input type="text" id="search_item" /> </div>
		<div> Instruction <br /> <input type="text" id="search_instruction" /> </div>
		
		<div> <button onclick="gridReloadSearch()" id="submitButton" style="margin-left:30px;">Search</button> </div> 
		<br />
	
		<!-- table tag will hold our grid -->
		<table id="recipe_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="recipe_list_pager" class="scroll" style="text-align:center;"></div>

		<!-- table tag will hold our grid -->
		<table id="recipeversion_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="recipeversion_list_pager" class="scroll" style="text-align:center;"></div>

		<script type="text/javascript">
		  $(document).ready(function () {
		    jQuery("#recipe_list").jqGrid({
		      url:'jq_recipe_list',
		      editurl:'jq_edit_recipe',
		      datatype: "json",
		      colNames:['Name','Cuisine','Category','Spicy', 'Healthy', 'Economical', 'Prepration Time', 'Shelflife', 'Rating', 'Feedback', 'id'],
		      colModel:[
			{name:'name', editable:true, formatter: 'showlink', formatoptions:{baseLinkUrl:'recipe',addParam:'&cmd=show'}},
			
			{name:'cuisine', editable:true},
			{name:'category', editable:true, cellattr: function (rowId, tv, rawObject, cm, rdata) { return 'style="white-space: normal;"' }},				
			{name:'spicy', editable:true},
			{name:'healthy', editable:true},
			{name:'economical', editable:true},
			{name:'preprationtime', editable:true},
			{name:'shelflife', editable:true},
			{name:'rating', editable:true},
			{name:'feedback', editable:true},
			{name:'id',hidden:true}
		     ],
		    rowNum:10,
		    rowList:[10,20,30,40,50],
		    pager: '#recipe_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortorder: "desc",
		    width: 1250,
		    height: "100%",
		    caption:"Recipe List"			
		    });
		   $("#recipe_list").jqGrid('navGrid',"#recipe_list_pager",
			{add:true,edit:true,del:true}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New Recipe',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
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
		  if (op == "set") {
		    $(elem).val(value);
		  }
		  return $(elem).val();
		}
		
		
		function gridReloadSearch()
				{ 
				        var search_name = jQuery("#search_name").val();
				        var search_category = jQuery("#search_category").val();
				        var search_cuisine = jQuery("#search_cuisine").val();
				        var search_chef = jQuery("#search_chef").val();
				        var search_item = jQuery("#search_item").val();
				        var search_instruction = jQuery("#search_instruction").val();
				        var url = "jq_recipe_list?search_name="+search_name+"&search_category="+search_category+"&search_cuisine="+search_cuisine+"&search_chef="+search_chef+"&search_item="+search_item+"&search_instruction="+search_instruction;
				        //alert("Search URL: "+url);
					jQuery("#recipe_list").jqGrid('setGridParam',{url:url}).trigger("reloadGrid"); 
		  		}
  	
		
		
		</script>		
		
		
	</body>
</html>
