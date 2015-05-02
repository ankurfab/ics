
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
            <div class="message">${flash.message}</div>
            </g:if>
            <div>
			<!-- table tag will hold our grid -->
			<table id="budget_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="budget_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
	    <div>
		Financial Year Starting 1 April <g:datePicker name="finyear" value="${new Date()}" precision="year"
	              noSelection="['':'-Choose Financial Year-']" relativeYears="[-2..2]"/>	    
	    <g:form name="downloadForm" action="downloadBudget" >
		    <input id = "btnDownloadGrid" type="submit" value="Download"/>
		    <g:hiddenField name="dlyear" value="" />
	    </g:form>
	    <input id = "btnLoadGrid" type="submit" value="Show"/>
		<!--<button id="btnDownload">Download</button>-->
		<!--<button id="btnReset">Reset</button>-->
		<div>
		Upload: <br />
		    <g:uploadForm name="formBudgetUpload" controller="CostCenter" action="uploadBudget">
			<input type="file" name="myFile" />
			<input id = "btnUploadBudget" type="submit" value="Upload"/>
			<g:hiddenField name="ulyear" value="" />
		    </g:uploadForm>
		</div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    jQuery("#budget_list").jqGrid({
      url:'jq_budget_list',
      editurl:'jq_edit_budget',
      datatype: "local",
      postData:{
      	year:function(){return $("#finyear").val();}
       },
      colNames:['CostCategory','CostCenter','Vertical','ProfitCenter','ServiceCenter','Category','Type','Apr','May','June','July','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Id'],
      colModel:[
	{name:'ccatname', search:true, editable: false},
	{name:'ccname', search:true, editable: false},
	{name:'cgname', search:true, editable: false},
	{name:'isProfitCenter', search:true, editable: false,stype:'select', searchoptions: { value: ':ALL;Yes:Yes;No:No'}},
	{name:'isServiceCenter', search:true, editable: false,stype:'select', searchoptions: { value: ':ALL;Yes:Yes;No:No'}},
	{name:'category', search:true, editable: false,stype:'select', searchoptions: { value: ':ALL;Income:Income;Expense:Expense'}},
	{name:'type', search:true, editable: false,stype:'select', searchoptions: { value: ':ALL;Projected:Projected;Actual:Actual'}},
	//{name:'apr', search:false, editable: false,sorttype:'number',formatter:'number', summaryType:'max'},
	{name:'apr', search:false, editable: false,sorttype:'number',formatter:'number'},
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
    rowNum:2000,
    //rowList:[10,20,30,40,50,100,200],
    pager: '#budget_list_pager',
    viewrecords: true,
    sortname: 'ccname',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Budget Plan",
    /*grouping: true,
    groupingView : { 
    	groupField : ['ccatname','ccname', 'category'],
    	groupSummary : [true,true,true],
    	groupColumnShow : [true, true, true],
    	//groupText : ['<b>{0}</b> Total: {apr}', '<b>{0}</b> Total: {apr}', '{0} Total: {apr}'],
    	groupCollapse : true,
    	groupOrder: ['asc','asc', 'asc'],
    	showSummaryOnHide:false
    	},*/     
    });
    $("#budget_list").jqGrid('filterToolbar',{autosearch:true});
    $("#budget_list").jqGrid('navGrid',"#budget_list_pager",{edit:false,add:false,del:false,search:true});
    $("#budget_list").jqGrid('inlineNav',"#budget_list_pager",
	    { 
	       edit: false,
	       add: false,
	       save: false,
	       cancel: false,
	    }    
    );

    $("#budget_list").jqGrid('setGroupHeaders', { useColSpanStyle: true, groupHeaders:[ 
	    {startColumnName: 'apr', numberOfColumns: 3, titleText: '<em>Q1</em>'},
	    {startColumnName: 'july', numberOfColumns: 3, titleText: '<em>Q2</em>'},
	    {startColumnName: 'oct', numberOfColumns: 3, titleText: '<em>Q3</em>'},
	    {startColumnName: 'jan', numberOfColumns: 3, titleText: '<em>Q4</em>'},
	    ] });

    $("#btnLoadGrid").click(function(){
	alert("Showing budget grid for FY starting 1 April "+$("#finyear_year").val());
	$("#budget_list").jqGrid('setGridParam',{datatype:'json'}).trigger('reloadGrid');
    }); 	

    $("#btnDownloadGrid").click(function(){
	var selYear = $("#finyear_year").val();
	$("#dlyear").val(selYear);
	alert("Downloading for FY starting 1 April "+selYear);
    }); 	

    $("#btnUploadBudget").click(function(){
	var selYear = $("#finyear_year").val();
	$("#ulyear").val(selYear);
	alert("Uploading for FY starting 1 April "+selYear);
    }); 	

   $("#btnReset").button().click(function() {
	var selYear = $("#finyear_year").val();
	var answer = confirm("Are you sure you want to reset the budget and related data for FY starting 1 April "+selYear+" ?");
	if (answer){
		var url = "${createLink(controller:'CostCenter',action:'resetStatsAttributes')}"+"?year="+selYear;
		$.getJSON(url, {}, function(data) {
			if(data.error)
				alert(data.error);
			else
				{
				alert(data.message);
				}
		    });	
	} else {
	    return false;
	}
	});

   $("#btnDownload").button().click(function() {
	var selYear = $("#finyear_year").val();
	var answer = confirm("Are you sure you want to download the budget and related data for FY starting 1 April "+selYear+" ?");
	if (answer){
		var url = "${createLink(controller:'CostCenter',action:'downloadBudget')}"+"?year="+selYear;
		$.getJSON(url, {}, function(data) {
			if(data.error)
				alert(data.error);
			else
				{
				alert(data.message);
				}
		    });	
	} else {
	    return false;
	}
	});

    });


</script>

    </body>
</html>
