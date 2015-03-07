
<%@ page import="ics.Course" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'course.label', default: 'Course')}" />
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
		<table id="course_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="course_list_pager" class="scroll" style="text-align:center;"></div>

		<!-- table tag will hold our grid -->
		<table id="individualCourse_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="individualCourse_list_pager" class="scroll" style="text-align:center;"></div>
		<input class="menuButton" type="BUTTON" id="btnSMS_ICList" value="SMS" gridName="#individualCourse_list" entityName="IndividualCourse"/>
		<input class="menuButton" type="BUTTON" id="btnEMAIL_ICList" value="EMAIL" gridName="#individualCourse_list" entityName="IndividualCourse"/>
		</div>

		<script type="text/javascript">
		  $(document).ready(function () {
		    jQuery("#course_list").jqGrid({
		      url:'jq_course_list',
		      editurl:'jq_edit_course',
		      datatype: "json",
		      colNames:['Name','Description','Type','Category','Instructor','id'],
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
			{name:'instructor', editable:true},
			{name:'id',hidden:true}
		     ],
		    rowNum:10,
		    rowList:[5,10,20,30,50,100],
		    pager: '#course_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortname: 'name',
		    sortorder: "asc",
		    width: 1200,
		    height: "100%",
		    caption:"Course List",
			onSelectRow: function(ids) {
						var selCourseName = jQuery('#course_list').jqGrid('getCell', ids, 'name');
						jQuery("#individualCourse_list").jqGrid('setGridParam',{url:"${createLink(controller:'individualCourse',action:'jq_depcourse_list',params:['course.id':''])}"+ids,page:1});
						jQuery("#individualCourse_list").jqGrid('setGridParam',{editurl:"${createLink(controller:'individualCourse',action:'jq_edit_depcourse',params:['course.id':''])}"+ids});
						jQuery("#individualCourse_list").jqGrid('setCaption',"CourseRead List for Course: "+selCourseName) .trigger('reloadGrid');
					}
		    });
		   $("#course_list").jqGrid('navGrid',"#course_list_pager",
			{add:true,edit:true,del:true}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New Course',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
		    );
		   $("#course_list").jqGrid('filterToolbar',{autosearch:true});


		jQuery("#individualCourse_list").jqGrid({ 
			height: "100%",
			width: 1200,
			url:'${createLink(controller:'individualCourse',action:'jq_depcourse_list',params:['course.id':0])}', 
			editurl:'${createLink(controller:'individualCourse',action:'jq_edit_depcourse',params:['course.id':0])}', 
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
			pager: '#individualCourse_list_pager', 
			multiselect: true,
			sortname: 'name', 
			viewrecords: true, 
			sortorder: "asc", 
			caption:"Individual Course List" }).navGrid('#individualCourse_list_pager',{add:false,edit:false,del:false}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New CourseRead',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
			); 
		  	$("#individualCourse_list").jqGrid('filterToolbar',{autosearch:true});


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
