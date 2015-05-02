
<%@ page import="ics.CostCenter" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Income Summary</title>
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
			<table id="incomeSummary_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="incomeSummary_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>


<script>
  $(document).ready(function () {
    jQuery("#incomeSummary_list").jqGrid({
      url:'jq_incomeSummary_list',
      datatype: "json",
      colNames:['CostCategory','Name','Alias','Apr','May','June','July','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Id'],
      colModel:[
	{name:'ccat',search:true},
	{name:'name',search:true, formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'CostCenter',action:'show')}'}
        },
	{name:'alias',search:true},
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
    rowList:[10,20,30,40,50,100,200,500],
    pager: '#incomeSummary_list_pager',
    viewrecords: true,
    sortname: "name",
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
	footerrow : true,
	userDataOnFooter : true,							    
    caption:"Income Summary"
    });
    $("#incomeSummary_list").jqGrid('filterToolbar',{autosearch:true,});
    $("#incomeSummary_list").jqGrid('navGrid', "#incomeSummary_list_pager", {edit: false, add: false, del: false, search: false});
    
    });

</script>


    </body>
</html>
