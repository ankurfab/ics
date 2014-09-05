
<%@ page import="ics.EventPrasadam" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventPrasadam.list" default="EventPrasadam List" /></title>
	<r:require module="grid" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="runtimelist" controller="EventPrasadam">Runtime Data</g:link></span>
        </div>

		<!-- table tag will hold our grid -->
		<table id="net_prasadam_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="net_prasadam_list_pager" class="scroll" style="text-align:center;"></div>

		<!-- table tag will hold our grid -->
		<table id="prasadam_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="prasadam_list_pager" class="scroll" style="text-align:center;"></div>

		<!-- table tag will hold our grid -->
		<table id="travelling_prasadam_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="travelling_prasadam_list_pager" class="scroll" style="text-align:center;"></div>


        </div>
<script>
  $(document).ready(function () {
    jQuery("#net_prasadam_list").jqGrid({
      url:'jq_net_prasadam_list',
      datatype: "json",
      colNames:['Date','<10am','<3pm','<10pm','Id'],
      colModel:[
	{name:'date'},
	{name:'num10am'},
	{name:'num3pm'},
	{name:'num10pm'},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10],
    pager: '#net_prasadam_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    caption:"Net RVTO Prasadam List (Arrival-Departure)"
    });
    $("#net_prasadam_list").jqGrid('navGrid',"#net_prasadam_list_pager",{edit:false,add:false,del:false,search:false});

    jQuery("#prasadam_list").jqGrid({
      url:'jq_prasadam_list',
      datatype: "json",
      colNames:['Date','<10am','<3pm','<10pm','Id'],
      colModel:[
	{name:'date'},
	{name:'num10am'},
	{name:'num3pm'},
	{name:'num10pm'},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10],
    pager: '#prasadam_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    caption:"RVTO Prasadam List (Only arrivals)"
    });
    $("#prasadam_list").jqGrid('navGrid',"#prasadam_list_pager",{edit:false,add:false,del:false,search:false});

    jQuery("#travelling_prasadam_list").jqGrid({
      url:'jq_travelling_prasadam_list',
      datatype: "json",
      colNames:['Date','Breakfast','Lunch','Dinner','Id'],
      colModel:[
	{name:'date'},
	{name:'breakfast'},
	{name:'lunch'},
	{name:'dinner'},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10],
    pager: '#travelling_prasadam_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    caption:"Travelling Prasadam List"
    });
    $("#travelling_prasadam_list").jqGrid('navGrid',"#travelling_prasadam_list_pager",{edit:false,add:false,del:false,search:false});

    });


</script>

    </body>
</html>
