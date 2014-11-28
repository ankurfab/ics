
<%@ page import="ics.Voucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="voucher.list" default="Voucher List" /></title>
	<r:require module="grid" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="voucher.new" default="New Voucher" /></g:link></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="voucher_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="voucher_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    jQuery("#voucher_list").jqGrid({
      url:'jq_voucher_list',
      datatype: "json",
      colNames:['VoucherDate','DepartmentCode','VoucherNo','Description','Withdrawal','Deposit','Updator','LastUpdated','Id'],
      colModel:[
	{name:'voucherDate',search:true},
	{name:'departmentCode',search:true},
	{name:'voucherNo',search:true, formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'Voucher',action:'show')}'}
        },
	{name:'description',search:true},
	{name:'amount',search:true},
	{name:'amountSettled',search:true},
	{name:'updator',search:true},
	{name:'lastUpdated',search:false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#voucher_list_pager',
    viewrecords: true,
    sortname: "lastUpdated",
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Voucher List"
    });
    $("#voucher_list").jqGrid('filterToolbar',{autosearch:true});
    $("#voucher_list").jqGrid('navGrid',"#voucher_list_pager",{edit:false,add:false,del:false,search:false});
    //$("#voucher_list").jqGrid('inlineNav',"#voucher_list_pager");
    });
</script>


    </body>
</html>
