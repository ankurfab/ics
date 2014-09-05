<%@ page import="ics.EventRegistration" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'eventRegistration.label', default: 'EventRegistration')}" />
		<title>Runtime Registration</title>
		<r:require module="grid" />
	</head>
	<body>
		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
		</div>

		<!-- table tag will hold our grid -->
		<table id="runtime_eventRegistration_summary_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="runtime_eventRegistration_summary_list_pager" class="scroll" style="text-align:center;"></div>

		<!-- table tag will hold our grid -->
		<table id="runtime_eventRegistration_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="runtime_eventRegistration_list_pager" class="scroll" style="text-align:center;"></div>

		
		<script type="text/javascript">// <![CDATA[
		  /* when the page has finished loading.. execute the follow */
		  $(document).ready(function () {		    

		    jQuery("#runtime_eventRegistration_summary_list").jqGrid({
		      url:'${createLink(controller:'EventRegistration',action:'jq_runtime_eventRegistration_summary_list')}'+'?ergid='+${erGroup?.id},
		      datatype: "json",
		      colNames:['GroupLeaderName','Phone','Temple/Centre','RegistrationCode','Number of Groups','Total Prji','Total Mataji','Total Children','Total Brahmachari','Total Guest','id'],
		      colModel:[
			{name:'glname',
				formatter:'showlink', 
				formatoptions:{baseLinkUrl:'show'}},
			{name:'phone'},
			{name:'centre'},
			{name:'regcode'},
			{name:'numGroups'},
			{name:'numPrji'},
			{name:'numMataji'},
			{name:'numChildren'},
			{name:'numBrahmachari'},
			{name:'total'},
			{name:'id',hidden:true}
		     ],
		    rowNum:10,
		    rowList:[10],
		    pager:'#runtime_eventRegistration_summary_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortorder: "asc",
		    multiselect: false,
		    width: 1250,
		    height: "100%",
		    caption:"Runtime Registration Summary"
		    });

		    $("#runtime_eventRegistration_summary_list").jqGrid('navGrid',"#runtime_eventRegistration_summary_list_pager",
			{add:false,edit:false,del:false, search: false}, // which buttons to show?
			{},         // edit options
			{},  // add options
			{}          // delete options
		    );


		    jQuery("#runtime_eventRegistration_list").jqGrid({
		      url:'${createLink(controller:'EventRegistration',action:'jq_runtime_eventRegistration_list')}'+'?ergid='+${erGroup?.id},
		      editurl:'${createLink(controller:'EventRegistration',action:'jq_runtime_eventRegistration_edit')}'+'?ergid='+${erGroup?.id},
		      datatype: "json",
		      colNames:['SubGroupLeaderName','Phone','Total Prji','Total Mataji','Total Children','Total Brahmachari','Total Guest','id'],
		      colModel:[
			{name:'subglname',editable:true, editrules:{required:true}},
			{name:'phone',editable:true, editrules:{required:true, integer:true, minValue:0, maxValue:9999999999}},
			{name:'numPrji',editable:true, editrules:{required:true, integer:true, minValue:0}},
			{name:'numMataji',editable:true, editrules:{required:true, integer:true, minValue:0}},
			{name:'numChildren',editable:true, editrules:{required:true, integer:true, minValue:0}},
			{name:'numBrahmachari',editable:true, editrules:{required:true, integer:true, minValue:0}},
			{name:'total',editable:false},
			{name:'id',hidden:true}
		     ],
		    rowNum:10,
		    rowList:[10],
		    pager:'#runtime_eventRegistration_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortorder: "asc",
		    multiselect: false,
		    width: 1250,
		    height: "100%",
		    caption:"Runtime Registration Group List"
		    });

		    //$("#runtime_eventRegistration_list").jqGrid('filterToolbar',{autosearch:true});
		    $("#runtime_eventRegistration_list").jqGrid('navGrid',"#runtime_eventRegistration_list_pager",
			{add:false,edit:false,del:true, search: false}, // which buttons to show?
			{},         // edit options
			{},  // add options
			{}          // delete options
		    );
		    jQuery("#runtime_eventRegistration_list").jqGrid('inlineNav',"#runtime_eventRegistration_list_pager",{add:true,edit:false,del:true});

	        });

		// ]]></script>
	</body>
</html>


