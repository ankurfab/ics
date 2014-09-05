
<%@ page import="ics.Topic" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="topic.list" default="Topic List" /></title>
	<r:require module="grid" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="topic_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="topic_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="topicSubscription_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="topicSubscription_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    jQuery("#topic_list").jqGrid({
      url:'jq_topic_list',
      editurl:'jq_edit_topic',
      datatype: "json",
      colNames:['Name','Frequency','SMS','Email','Post','Comments','Status','Id'],
      colModel:[
	{name:'name', search:true, editable: true, editrules:{required:true}},
	{name:'frequency', search:true, editable: true, editrules:{required:true},edittype:"select",editoptions:{value:"DAILY:DAILY;WEEKLY:WEEKLY;MONTHLY:MONTHLY"},formatter: 'select',stype:'select', searchoptions: { value: ':All;DAILY:DAILY;WEEKLY:WEEKLY;MONTHLY:MONTHLY'}},
	{name:'viaSMS', search:true, editable: true, edittype:"checkbox",stype:'select', searchoptions: { value: ':All;true:TRUE;false:FALSE'}}, 
	{name:'viaEmail', search:true, editable: true, edittype:"checkbox",stype:'select', searchoptions: { value: ':All;true:TRUE;false:FALSE'}},
	{name:'viaPost', search:true, editable: true, edittype:"checkbox",stype:'select', searchoptions: { value: ':All;true:TRUE;false:FALSE'}},
	{name:'comments', search:true, editable: true},
	{name:'status', search:true, editable: true,edittype:"select",editoptions:{value:"ACTIVE:ACTIVE;INACTIVE:INACTIVE"},formatter: 'select',stype:'select', searchoptions: { value: ':All;ACTIVE:ACTIVE;INACTIVE:INACTIVE'}},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#topic_list_pager',
    viewrecords: true,
    sortname: "name",
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Topic List",
    onSelectRow: function(ids) { 
    	jQuery("#topicSubscription_list").jqGrid('setGridParam',{url:"jq_topicSubscription_list?topicid="+ids}).trigger('reloadGrid');    	
    	}    
    });
    $("#topic_list").jqGrid('filterToolbar',{autosearch:true});
    $("#topic_list").jqGrid('navGrid',"#topic_list_pager",{edit:false,add:false,del:true,search:false});
    $("#topic_list").jqGrid('inlineNav',"#topic_list_pager");

    jQuery("#topicSubscription_list").jqGrid({
      url:'jq_topicSubscription_list',
      editurl:'jq_edit_topicSubscription',
      datatype: "json",
      colNames:['Name','SMS','Email','Post','Id'],
      colModel:[
	{name:'name', search:true, editable: true},
	{name:'viaSMS', search:true, editable: true, edittype:"checkbox",stype:'select', searchoptions: { value: ':All;true:TRUE;false:FALSE'}}, 
	{name:'viaEmail', search:true, editable: true, edittype:"checkbox",stype:'select', searchoptions: { value: ':All;true:TRUE;false:FALSE'}},
	{name:'viaPost', search:true, editable: true, edittype:"checkbox",stype:'select', searchoptions: { value: ':All;true:TRUE;false:FALSE'}},
	{name:'id',hidden:true}
     ],
    rowNum:50,
    rowList:[10,20,30,40,50,100,200],
    pager: '#topicSubscription_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Topic TopicSubscription List"
    });
    $("#topicSubscription_list").jqGrid('filterToolbar',{autosearch:true});
    $("#topicSubscription_list").jqGrid('navGrid',"#topicSubscription_list_pager",{edit:false,add:false,del:false,search:false});
    //$("#topicSubscription_list").jqGrid('inlineNav',"#topicSubscription_list_pager");


    });
</script>


    </body>
</html>
