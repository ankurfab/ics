
<%@ page import="ics.EventSeva" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Volunteer List</title>
	<r:require module="grid" />
	<r:require module="export"/>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="seva_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="seva_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="volunteer_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="volunteer_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
		<export:formats formats="['excel']" controller="helper" action="eventServiceInchargeReport"/>
        </div>

<script>
  $(document).ready(function () {
    var lastsel3; 
    jQuery("#seva_list").jqGrid({
      url:'jq_seva_list',
      datatype: "json",
      colNames:['Service','Id'],
      colModel:[
	{name:'seva.name'},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10],
    pager: '#seva_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    caption:"Service List",
    onSelectRow: function(ids) { 
    	jQuery("#volunteer_list").jqGrid('setGridParam',{url:"jq_volunteer_list?eventsevaid="+ids}).trigger('reloadGrid');    	
    	}    
    });
    $("#seva_list").jqGrid('navGrid',"#seva_list_pager",{edit:false,add:false,del:false,search:false});

    jQuery("#volunteer_list").jqGrid({
      url:'jq_volunteer_list',
      datatype: "json",
      colNames:['Name','Category','Phone','Counselor','Id'],
      colModel:[
	{name:'name'},
	{name:'category'},
	{name:'phone'},
	{name:'relation'},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#volunteer_list_pager',
    viewrecords: true,
    sortname: 'name',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Volunteer List"
    });
    $("#volunteer_list").jqGrid('filterToolbar',{autosearch:true});
    $("#volunteer_list").jqGrid('navGrid',"#volunteer_list_pager",{edit:false,add:false,del:false,search:false});
    });
</script>


    </body>
</html>
