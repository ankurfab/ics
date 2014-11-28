
<%@ page import="ics.Event" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="event.list" default="Event List" /></title>
	<r:require module="grid" />
	<r:require module="dateTimePicker" />
    </head>
    <body>
		<g:render template="/common/sms" />
		<g:render template="/common/email" />

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list" controller="Event">CalendarView</g:link></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="event_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="event_list_pager" class="scroll" style="text-align:center;"></div>
			<input class="menuButton" type="BUTTON" id="btnSMS_EventList" value="SMS" gridName="#event_list" entityName="Event"/>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="participant_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="participant_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    var lastsel3; 
    jQuery("#event_list").jqGrid({
      url:'jq_event_list',
      editurl:'jq_edit_event',
      datatype: "json",
      colNames:['Title','Description','Id'],
      colModel:[
	{name:'title', search:true, editable: true, editrules:{required:true}},
	{name:'description', search:true, editable: true, editrules:{required:true}},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#event_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Event List",
    onSelectRow: function(ids) { 
    	jQuery("#participant_list").jqGrid('setGridParam',{url:"jq_participant_list?eventid="+ids}).trigger('reloadGrid');    	
    	}    
    });
    $("#event_list").jqGrid('filterToolbar',{autosearch:true});
    $("#event_list").jqGrid('navGrid',"#event_list_pager",{edit:false,add:false,del:true,search:false});
    $("#event_list").jqGrid('inlineNav',"#event_list_pager");

    jQuery("#participant_list").jqGrid({
      url:'jq_participant_list',
      editurl:'jq_edit_participant',
      datatype: "json",
      colNames:['Name','Id'],
      colModel:[
	{name:'name', search:true, editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#participant_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Event Participant List"
    });
    $("#participant_list").jqGrid('filterToolbar',{autosearch:true});
    $("#participant_list").jqGrid('navGrid',"#participant_list_pager",{edit:false,add:false,del:false,search:false});
    //$("#participant_list").jqGrid('inlineNav',"#participant_list_pager");


    });
</script>


    </body>
</html>
