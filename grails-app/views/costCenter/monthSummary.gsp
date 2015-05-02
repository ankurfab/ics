
<%@ page import="ics.CostCenter" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Month Summary</title>
	<r:require module="grid" />

		<style>
			.bgGreen{
			   background: none repeat scroll 0 0 green !important;
			  }
			.bgLightGreen{
			   background: none repeat scroll 0 0 lightgreen !important;
			  }
			.bgOrange{
			   background: none repeat scroll 0 0 orange !important;
			  }
			.bgRed{
			   background: none repeat scroll 0 0 red !important;
			  }
			.bgYellow{
			   background: none repeat scroll 0 0 yellow !important;
			  }
		</style>		

    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="monthSummary_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="monthSummary_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>


<script>
  $(document).ready(function () {
    jQuery("#monthSummary_list").jqGrid({
      url:'jq_monthSummary_list',
      datatype: "json",
      colNames:['CostCategory','Name','Alias','Budget','RemainingBudget','Consumption','ApprovedExpense','DraftSettlement','RejectedSettlement','SubmittedSettlement','ApprovedSettlement','SettledExpense','check','Id'],
      colModel:[
	{name:'ccat',search:true},
	{name:'name',search:true, formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'CostCenter',action:'show')}'}
        },
	{name:'alias',search:true},
	{name:'budget',search:false},
	{name:'remainingbudget',search:false},
	{name:'balance',search:false},
	{name:'approvedExpense',search:false},
	{name:'draftSettlement',search:false},
	{name:'rejectedSettlement',search:false},
	{name:'submittedSettlement',search:false},
	{name:'approvedSettlement',search:false},
	{name:'settledExpense',search:false},
	{name:'check',hidden:true},
	{name:'id',hidden:true}
     ],
    rowattr: function (rd) {
	    if (rd.check!= null && rd.check.indexOf("notok") > -1 ) {
		return {"class": "bgRed"};
		}
	    },		             
    rowNum:10,
    rowList:[10,20,30,40,50,100,200,500],
    pager: '#monthSummary_list_pager',
    viewrecords: true,
    sortname: "name",
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
	footerrow : true,
	userDataOnFooter : true,							    
    caption:"Month Summary"
    });
    $("#monthSummary_list").jqGrid('filterToolbar',{autosearch:true,});
    $("#monthSummary_list").jqGrid('navGrid', "#monthSummary_list_pager", {edit: false, add: false, del: false, search: false});
    
    });

</script>


    </body>
</html>
