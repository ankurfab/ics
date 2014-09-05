<%@ page import="ics.EventRegistration" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'eventRegistration.label', default: 'EventRegistration')}" />
		<title>Local Registrations</title>
		<r:require module="grid" />
		<r:require module="export"/>
	</head>
	<body>
		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
		    <span class="menuButton"><g:link class="create" action="createlocal">New Local Registration</g:link></span>
		</div>

		<!-- table tag will hold our grid -->
		<table id="eventRegistration_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="eventRegistration_list_pager" class="scroll" style="text-align:center;"></div>

		<sec:ifAnyGranted roles="ROLE_EVENTADMIN,ROLE_REGISTRATION_COORDINATOR">
		<export:formats formats="['excel']" controller="helper" action="eventRegLocalReport"/>
		</sec:ifAnyGranted>
		
		<script type="text/javascript">// <![CDATA[
		  /* when the page has finished loading.. execute the follow */
		  $(document).ready(function () {		    
		    jQuery("#eventRegistration_list").jqGrid({
		      url:'jq_eventRegistration_list_local',
		      editurl:'jq_eventRegistration_edit_local',
		      datatype: "json",
		      colNames:['Name','Category','Phone','Counselor','Service','id'],
		      colModel:[
			{name:'name', search:true, editable: true, editrules:{required:true}},
			{name:'category', search:true, editable: true,edittype:"select",editoptions:{value:":--Please Select Category--;Brahmachari/Student:Brahmachari/Student;Prji:Prji;Mataji:Mataji;Child:Child"}},
			{name:'phone', search:true, editable: true, editrules:{required:true, integer:true, minValue:0, maxValue:9999999999}},
			<sec:ifNotGranted roles="ROLE_RVTO_COUNSELOR">
			{name:'relation', search:true, editable: true, editrules:{required:true},edittype:"select",editoptions:{value:"${':--Please Select Counselor--;'+(ics.Individual.findAllByCategory('RVTOCounselor','[sort:"legaName"]')?.collect{it.legalName+':'+it.legalName}.join(';'))}"}},
			</sec:ifNotGranted>
			<sec:ifAnyGranted roles="ROLE_RVTO_COUNSELOR">
			{name:'relation', search:true, editable: true, editrules:{required:true},edittype:"select",editoptions:{value:"${session?.individualname+':'+session?.individualname}"}},
			</sec:ifAnyGranted>
			{name:'reference', search:true, editable: true, editrules:{required:true},edittype:"select",editoptions:{value:"${':--Please Select Service--;'+(ics.Seva.findAllByCategory('RVTO','[sort:"name"]')?.collect{it.name+':'+it.name}.join(';'))}"}},
			{name:'id',hidden:true}
		     ],
		    rowNum:10,
		    rowList:[10,20,30,40,50,100,200],
		    pager:'#eventRegistration_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortorder: "asc",
		    multiselect: true,
		    width: 1250,
		    height: "100%",
		    caption:"Local Registration List"
		    });

		    $("#eventRegistration_list").jqGrid('filterToolbar',{autosearch:true});
		    $("#eventRegistration_list").jqGrid('navGrid',"#eventRegistration_list_pager",
			{add:false,edit:false,del:true, search: false}, // which buttons to show?
			{},         // edit options
			{},  // add options
			{}          // delete options
		    );
		    jQuery("#eventRegistration_list").jqGrid('inlineNav',"#eventRegistration_list_pager");

	        });

		// ]]></script>
	</body>
</html>


