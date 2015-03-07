
<%@ page import="ics.CostCenter" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Budget</title>
	<r:require module="grid" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div>
			<!-- table tag will hold our grid -->
			<table id="budget_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="budget_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    jQuery("#budget_list").jqGrid({
      url:'jq_budget_list',
      editurl:'jq_edit_budget',
      datatype: "json",
      colNames:['Vertical','Department','Budget','Apr','May','June','July','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Id'],
      colModel:[
	{name:'vertical', search:true, editable: false},
	{name:'department', search:true, editable: false},
	{name:'budget', search:true, editable: true},
	{name:'apr', search:false, editable: false},
	{name:'may', search:false, editable: false},
	{name:'june', search:false, editable: false},
	{name:'july', search:false, editable: false},
	{name:'aug', search:false, editable: false},
	{name:'sep', search:false, editable: false},
	{name:'oct', search:false, editable: false},
	{name:'nov', search:false, editable: false},
	{name:'dec', search:false, editable: false},
	{name:'jan', search:false, editable: false},
	{name:'feb', search:false, editable: false},
	{name:'mar', search:false, editable: false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#budget_list_pager',
    viewrecords: true,
    sortname: 'vertical',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Budget"
    });
    //$("#budget_list").jqGrid('filterToolbar',{autosearch:true});
    $("#budget_list").jqGrid('navGrid',"#budget_list_pager",{edit:false,add:false,del:false,search:false});
    $("#budget_list").jqGrid('inlineNav',"#budget_list_pager");

    });
</script>

    </body>
</html>
