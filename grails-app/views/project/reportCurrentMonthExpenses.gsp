  <%@ page import="ics.Project" %>
  <!doctype html>
  <html>
  	<head>
  		<meta name="layout" content="main">
  		<title>Current Month Voucher Expenses Report</title>
   
  		<r:require module="grid" />
  	</head>
  	<body>  		
  		<!-- table tag will hold our grid -->
  		<table id="expensevoucher_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
  		<!-- pager will hold our paginator -->
  		<div id="expensevoucher_list_pager" class="scroll" style="text-align:center;"></div>

  		<!-- table tag will hold our grid -->
  		<table id="voucherexpense_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
  		<!-- pager will hold our paginator -->
  		<div id="voucherexpense_list_pager" class="scroll" style="text-align:center;"></div>
  		  
            <script type="text/javascript">		
  		  $(document).ready(function () {
  		    jQuery("#expensevoucher_list").jqGrid({
  		      url:"${createLink(controller:'Project',action:'jq_expensevoucher_list')}",
	               datatype:"json",  	 	   
  	            colNames:['CostCategory','CostCenter','VoucherNo','Type','Date','Amount','Cheque Number','Cheque Date','Bank Name','Bank Branch','Id'],
  		      colModel:[
  			{name:'costCategory',search: true, editable: false},
  			{name:'costCenter',search: true, editable: false},
  			{name:'voucherNo',search: true, editable: false},
  			{name:'type',search: true, editable: false},
  			{name:'voucherDate',search: true, editable: false},
  			{name:'amount',search: true, editable: false},
  			{name:'instrumentNo',search: true, editable: false},
  			{name:'instrumentDate',search: true, editable: false},
  			{name:'bankName',search: true, editable: false},
  			{name:'bankBranch',search: true, editable: false},
  			{name:'id',hidden:true}  				
  		     ], 
  		    rowNum:10,
  		    rowList:[5,10,20,50,100],
  		    pager:'#expensevoucher_list_pager',
  		    viewrecords: true,
  		    gridview: true,  		    
  		    width: "1250",
  		    height: "100%",
  		    multiselect: false,
  		    viewrecords:true,
                    showPager:true,
		    sortname: 'id',
		    sortorder: "desc",
  		    caption:"Current Month Voucher Expenses List",
		    onSelectRow: function(ids) { 
			if(ids!='new_row')
				{
				var selName = jQuery('#expensevoucher_list').jqGrid('getCell', ids, 'voucherNo');

				//set detail grid for expense items
				jQuery("#voucherexpense_list").jqGrid('setGridParam',{url:"jq_voucherexpense_list?voucherid="+ids});
				jQuery("#voucherexpense_list").jqGrid('setCaption',"Expense(s) List for Voucher: "+selName).trigger('reloadGrid');   	

				}
			}      		    
                   });		   
  		   
  		    $("#expensevoucher_list").jqGrid('filterToolbar',{autosearch:true});
  		    $("#expensevoucher_list").jqGrid('navGrid', "#expensevoucher_list_pager", {edit: false, add: false, del: false, search: false});


  		    jQuery("#voucherexpense_list").jqGrid({
  		      url:"${createLink(controller:'Project',action:'jq_voucherexpense_list')}",
	               datatype:"json",  	 	   
  	            colNames:['EAR/ERR Ref','Particulars','Date','Amount','Id'],
  		      colModel:[
  			{name:'expref',search: true, editable: false},
  			{name:'exppart',search: true, editable: false},
  			{name:'expdate',search: true, editable: false},
  			{name:'expamount',search: true, editable: false},
  			{name:'id',hidden:true}  				
  		     ], 
  		    rowNum:10,
  		    rowList:[50],
  		    pager:'#voucherexpense_list_pager',
  		    viewrecords: true,
  		    gridview: true,  		    
  		    width: "1250",
  		    height: "100%",
  		    multiselect: false,
  		    viewrecords:true,
                    showPager:true,
		    sortname: 'id',
		    sortorder: "desc",
  		    caption:"Expenses List"  	  
                   });		   
  		   
  		    $("#voucherexpense_list").jqGrid('filterToolbar',{autosearch:true});
  		    $("#voucherexpense_list").jqGrid('navGrid', "#voucherexpense_list_pager", {edit: false, add: false, del: false, search: false});
  		    
  		 });    
  		</script>
  	</body>
  </html>
