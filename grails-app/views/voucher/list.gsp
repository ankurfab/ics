
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
            <span class="menuButton"><g:link class="create" action="createPayment">New Payment Voucher</g:link></span>
            <span class="menuButton"><g:link class="create" action="createReceipt">New Receipt Voucher</g:link></span>
            <span class="menuButton"><g:link class="create" action="createContra">New Contra Voucher</g:link></span>
            <span class="menuButton"><g:link class="create" action="createJournal">New Journal Voucher</g:link></span>
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
      colNames:['VoucherDate','VoucherNo','DepartmentCode','Description','Deposit(Dr)','Withdrawal(Cr)','Type','From','To','Amount','Debit/Credit','RefNo','Status','Id'],
      colModel:[
	{name:'voucherDate',search:true},
	{name:'voucherNo',search:true, formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'Voucher',action:'show')}'}
        },         
	{name:'departmentCode',search:true},
	{name:'description',search:true},
	{name:'amountSettled',search:true},
	{name:'amount',search:true},
	{name:'type',search:true},
	{name:'ledger',search:true},
	{name:'anotherLedger',search:true},
	{name:'amount',search:true},
	{name:'debit',search:true},
	
	
	{name:'refNo',search:true,
			formatter:'showlink', 
			formatoptions:{target:"_new",baseLinkUrl:'${createLink(controller:'Voucher',action:'showRef')}'}
	},	
	{name:'status',search:true},
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
  $("#voucher_list").jqGrid('filterToolbar',{autosearch:true,});
    $("#voucher_list").jqGrid('navGrid', "#voucher_list_pager", {edit: false, add: false, del: false, search: true});
    jQuery("#voucher_list").jqGrid('navGrid',"#voucher_list_pager").jqGrid('navButtonAdd',"#voucher_list_pager",{caption:"Export", buttonicon:"ui-icon-disk",title:"Export",
    onClickButton : function () { 
    var query = 'jq_voucher_list?eid='+$('#event').val();            
    jQuery("#voucher_list").jqGrid('excelExport',{"url":query});
         }
      });
    });
</script>


    </body>
</html>
