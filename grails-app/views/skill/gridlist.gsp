
<%@ page import="ics.Skill" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'skill.label', default: 'Skill')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<r:require module="grid" />
	</head>
	<body>
		<g:render template="/common/sms" />
		<g:render template="/common/email" />

		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
		</div>
		<div class="body">
		<!-- table tag will hold our grid -->
		<table id="skill_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="skill_list_pager" class="scroll" style="text-align:center;"></div>

		<!-- table tag will hold our grid -->
		<table id="individualSkill_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="individualSkill_list_pager" class="scroll" style="text-align:center;"></div>
		<input class="menuButton" type="BUTTON" id="btnSMS_ISList" value="SMS" gridName="#individualSkill_list" entityName="IndividualSkill"/>
		<input class="menuButton" type="BUTTON" id="btnEMAIL_ISList" value="EMAIL" gridName="#individualSkill_list" entityName="IndividualSkill"/>
		</div>

		<script type="text/javascript">
		  $(document).ready(function () {
		    jQuery("#skill_list").jqGrid({
		      url:'jq_skill_list',
		      editurl:'jq_edit_skill',
		      datatype: "json",
		      colNames:['Name','Description','Type','Category','id'],
		      colModel:[
			{name:'name', editable:true},
			{name:'description', editable:true},
			{name:'type', editable:true},
			{name:'category', editable:true,
				    /*'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
   					 }*/
			},
			{name:'id',hidden:true}
		     ],
		    rowNum:10,
		    rowList:[5,10,20,30,50,100],
		    pager: '#skill_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortname: 'name',
		    sortorder: "asc",
		    width: 1200,
		    height: "100%",
		    caption:"Skill List",
			onSelectRow: function(ids) {
						var selSkillName = jQuery('#skill_list').jqGrid('getCell', ids, 'name');
						jQuery("#individualSkill_list").jqGrid('setGridParam',{url:"${createLink(controller:'individualSkill',action:'jq_depskill_list',params:['skill.id':''])}"+ids,page:1});
						jQuery("#individualSkill_list").jqGrid('setGridParam',{editurl:"${createLink(controller:'individualSkill',action:'jq_edit_depskill',params:['skill.id':''])}"+ids});
						jQuery("#individualSkill_list").jqGrid('setCaption',"IndividualSkill List for Skill: "+selSkillName) .trigger('reloadGrid');
					}
		    });
		   $("#skill_list").jqGrid('navGrid',"#skill_list_pager",
			{add:true,edit:true,del:true}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New Skill',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
		    );
		   $("#skill_list").jqGrid('filterToolbar',{autosearch:true});


		jQuery("#individualSkill_list").jqGrid({ 
			height: "100%",
			width: 1200,
			url:'${createLink(controller:'individualSkill',action:'jq_depskill_list',params:['skill.id':0])}', 
			editurl:'${createLink(controller:'individualSkill',action:'jq_edit_depskill',params:['skill.id':0])}', 
			datatype: "json", 
			colNames:['Individual','Phone','Email','id'], 
			colModel:[
				{name:'name', editable:false},
				{name:'phone', editable:false,search:false},
				{name:'email', editable:false,search:false},
				{name:'id',hidden:true}
				], 
			rowNum:5, 
			rowList:[5,10,20,30,50,100],
			pager: '#individualSkill_list_pager', 
			multiselect: true,
			sortname: 'name', 
			viewrecords: true, 
			sortorder: "asc", 
			caption:"IndividualSkill List" }).navGrid('#individualSkill_list_pager',{add:false,edit:false,del:false}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New IndividualSkill',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
			); 
		  	$("#individualSkill_list").jqGrid('filterToolbar',{autosearch:true});


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
	</body>
</html>
