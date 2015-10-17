  <%@ page import="ics.Project" %>
  <!doctype html>
  <html>
  	<head>
  		<meta name="layout" content="main">
  		<title>FMA Report</title>
   
  		<r:require module="grid" />
  	</head>
  	<body>  		
  		<!-- table tag will hold our grid -->
  		<table id="fma_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
  		<!-- pager will hold our paginator -->
  		<div id="fma_list_pager" class="scroll" style="text-align:center;"></div>
  		  
            <script type="text/javascript">		
  		  $(document).ready(function () {
  		    jQuery("#fma_list").jqGrid({
  		      url:"${createLink(controller:'Project',action:'jq_fma_list')}",
	               datatype:"json",  	 	   
  	            colNames:['CostCategory','CostCenter','ReferenceNo','Date','Mode of Payment','Particulars','Vendor Name','Bill Number','Amount','Voucher Number','Cheque Number','Cheque Date','Bank Name','Bank Branch','Id'],
  		      colModel:[
  			{name:'costCategory',search: true, editable: false},
  			{name:'costCenter',search: true, editable: false},
  			{name:'ref',search: true, editable: false},
  			{name:'invoiceDate',search: true, editable: false},
  			{name:'invoicePaymentMode',search: true, editable: false},
  			{name:'description',search: true, editable: false},
  			{name:'invoiceRaisedBy',search: true, editable: false},
  			{name:'invoiceNo',search: true, editable: false},
  			{name:'amount',search: true, editable: false},
  			{name:'voucherNo',search: true, editable: false},
  			{name:'instrumentNo',search: true, editable: false},
  			{name:'instrumentDate',search: true, editable: false},
  			{name:'bankName',search: true, editable: false},
  			{name:'bankBranch',search: true, editable: false},
  			{name:'id',hidden:true}  				
  		     ], 
  		    rowNum:10,
  		    rowList:[5,10,20,50,100],
  		    pager:'#fma_list_pager',
  		    viewrecords: true,
  		    gridview: true,  		    
  		    width: "1250",
  		    height: "100%",
  		    multiselect: false,
  		    viewrecords:true,
                    showPager:true,
		    sortname: 'id',
		    sortorder: "desc",
  		    caption:"FMA List"  	  
                   });		   
  		   
  		    $("#fma_list").jqGrid('filterToolbar',{autosearch:true});
  		    $("#fma_list").jqGrid('navGrid', "#fma_list_pager", {edit: false, add: false, del: false, search: false});
  		    
  		 });    
  		</script>
  	</body>
  </html>
