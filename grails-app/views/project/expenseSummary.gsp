
<%@ page import="ics.CostCenter" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Expense Summary</title>
	<r:require module="grid" />

    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
	    <div>
	    	<table>
	    		<thead>
	    			<th>CostCategory</th>
	    			<th>CostCenter</th>
	    			<th>AllocatedBudget</th>
	    			<th>ConsumedBudget</th>
	    			<th>AvailableBudget</th>
	    		</thead>
	    		<tbody>
				<g:each in="${costCenters}" var="costCenter">
				<tr>
					<td>${costCenter.costCategory?.name}</td>
					<td>${costCenter.name}</td>
					<td>${costCenter.budget}</td>
					<td>${costCenter.balance}</td>
					<td>${costCenter.budget - costCenter.balance}</td>
				</tr>
				</g:each>	    		
	    		</tbody>
	    	</table>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="expenseSummary_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="expenseSummary_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>


<script>
  $(document).ready(function () {
    jQuery("#expenseSummary_list").jqGrid({
      url:'jq_expenseSummary_list',
      datatype: "json",
      colNames:['CostCategory','Name','Date','Particulars','Ledger','Vendor','Amount','ExpenseRef','VoucherRef','Id'],
      colModel:[
	{name:'ccat',search:true},
	{name:'name',search:true, formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'CostCenter',action:'show')}'}
        },
	{name:'date',search:true},
	{name:'description',search:true},
	{name:'ledgerHead',search:true},
	{name:'invoiceRaisedBy',search:true},
	{name:'amount',search:true},
	{name:'projectRef',search:true},
	{name:'voucherRef',search:true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200,500],
    pager: '#expenseSummary_list_pager',
    viewrecords: true,
    sortname: "id",
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
	footerrow : true,
	userDataOnFooter : true,							    
    caption:"Expense Summary"
    });
    $("#expenseSummary_list").jqGrid('filterToolbar',{autosearch:true,});
    $("#expenseSummary_list").jqGrid('navGrid', "#expenseSummary_list_pager", {edit: false, add: false, del: false, search: false});
    
    });

</script>


    </body>
</html>
