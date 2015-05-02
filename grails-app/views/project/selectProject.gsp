
<%@ page import="ics.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>File Expense Report</title>
	<r:require module="grid" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>

        <div class="body">
	    No. of Items in SettlementForm:<g:select id="itemCount" name="itemCount" from="${[5,10,15,20,25,30,35,40,45,50]}" value="10"/>
            <div>
			<!-- table tag will hold our grid -->
			<table id="approvedProject_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="approvedProject_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

	<g:form name="projectForm" controller="Project" action="createReport" method="POST" data-ajax="false">	
		<g:hiddenField name="specificProjectIds" value="" />
		<g:hiddenField name="numItems" value="" />
	</g:form>

<script>
  $(document).ready(function () {
    jQuery("#approvedProject_list").jqGrid({
      url:'jq_approvedProject_list',
      datatype: "json",
      colNames:['Ref','Name','Category','Date','ApprovedAmount','IssuedAdvance','Type','IssuedTo','Id'],
      colModel:[
	{name:'ref',search:true},         
	{name:'name',search:true},         
	{name:'category',search:true,stype:'select', searchoptions: {value:"${':ALL;'+['CAPITAL','REVENUE'].collect{it+':'+it}.join(';')}"}},
	{name:'submitDate',search:true,
		searchoptions: {dataInit: function(el){$(el).datepicker({dateFormat:'dd-mm-yy'});}}                    			    
	},
	{name:'amount',search:true},
	{name:'advanceAmountIssued',search:true},
	{name:'type',search:true,stype:'select', searchoptions: {value:"${':ALL;'+['NORMAL','CREDIT'].collect{it+':'+it}.join(';')}"}},
	{name:'issueTo',search:true},         
	{name:'id',hidden:true}
     ],
     
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#approvedProject_list_pager',
    viewrecords: true,
    sortname: "lastUpdated",
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Approved Expense List"
    });
    $("#approvedProject_list").jqGrid('filterToolbar',{autosearch:true,});
    $("#approvedProject_list").jqGrid('navGrid', "#approvedProject_list_pager", {edit: false, add: false, del: false, search: false});

    $("#approvedProject_list").jqGrid('navGrid',"#approvedProject_list_pager").jqGrid('navButtonAdd',"#approvedProject_list_pager",{caption:"Settle", buttonicon:"ui-icon-calculator", onClickButton:settle, position: "last", title:"Settle", cursor: "pointer"});
    
    function settle() {
	var ids = $('#approvedProject_list').jqGrid('getGridParam','selarrrow');
	if(ids) {
		$('#numItems').val($('#itemCount').val());
		$('#specificProjectIds').val(ids);
		$('#projectForm').submit();
	}
	else
		alert("Please select expense(s)!!");

    }
    
    

    });
</script>


    
    </body>
</html>
