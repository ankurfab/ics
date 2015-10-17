  <%@ page import="ics.Project" %>
  <!doctype html>
  <html>
  	<head>
  		<meta name="layout" content="main">
  		<title>Budget Summary Report</title>
   
  		<r:require module="grid" />
  	</head>
  	<body>  		
  		<!-- table tag will hold our grid -->
  		<table id="budget_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
  		<!-- pager will hold our paginator -->
  		<div id="budget_list_pager" class="scroll" style="text-align:center;"></div>

  		<!-- table tag will hold our grid -->
  		<table id="manualupdates_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
  		<!-- pager will hold our paginator -->
  		<div id="manualupdates_list_pager" class="scroll" style="text-align:center;"></div>

  		<!-- table tag will hold our grid -->
  		<table id="budgetupdates_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
  		<!-- pager will hold our paginator -->
  		<div id="budgetupdates_list_pager" class="scroll" style="text-align:center;"></div>

  		<!-- table tag will hold our grid -->
  		<table id="donationsummary_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
  		<!-- pager will hold our paginator -->
  		<div id="donationsummary_list_pager" class="scroll" style="text-align:center;"></div>

  		<!-- table tag will hold our grid -->
  		<table id="donations_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
  		<!-- pager will hold our paginator -->
  		<div id="donations_list_pager" class="scroll" style="text-align:center;"></div>
  		  
            <script type="text/javascript">		
  		  $(document).ready(function () {
  		    jQuery("#budget_list").jqGrid({
  		      url:"${createLink(controller:'Project',action:'jq_CurrentMonthBudgetSummary_list')}",
	               datatype:"json",  	 	   
  	            colNames:['CostCategory','CostCenter',
  	            //'InitialBudget','ManualUpdates',
  	            'Donations','Budget','Consumption','Available','SubmittedEAR','ApprovedEAR','DraftERR','RejectedERR','SubmittedERR','ApprovedERR','Settled','Id'],
  		      colModel:[
  			{name:'costCategory',search: true, editable: false},
  			{name:'costCenter',search: true, editable: false},
  			//{name:'initialBudget',search: true, editable: false},
  			//{name:'manualUpdates',search: true, editable: false},
  			{name:'donations',search: true, editable: false},
  			{name:'budget',search: true, editable: false},
  			{name:'balance',search: true, editable: false},
  			{name:'available',search: true, editable: false},
			{name:'submittedExpense',search:false},
			{name:'approvedExpense',search:false},
			{name:'draftSettlement',search:false},
			{name:'rejectedSettlement',search:false},
			{name:'submittedSettlement',search:false},
			{name:'approvedSettlement',search:false},
			{name:'settledExpense',search:false},
  			{name:'id',hidden:true}  				
  		     ], 
  		    rowNum:10,
  		    rowList:[5,10,20,50,100],
  		    pager:'#budget_list_pager',
  		    viewrecords: true,
  		    gridview: true,  		    
  		    width: "1250",
  		    height: "100%",
  		    multiselect: false,
  		    viewrecords:true,
                    showPager:true,
		    sortname: 'id',
		    sortorder: "desc",
  		    caption:"Budget Summary",
		    onSelectRow: function(ids) { 
			if(ids!='new_row')
				{
				var selName = jQuery('#budget_list').jqGrid('getCell', ids, 'costCenter');

				//set detail grid for manual updates
				jQuery("#manualupdates_list").jqGrid('setGridParam',{url:"jq_manualupdates_list?ccid="+ids});
				jQuery("#manualupdates_list").jqGrid('setCaption',"Manual Budget Updates for CostCenter: "+selName).trigger('reloadGrid');   	

				//set detail grid for budget updates
				jQuery("#budgetupdates_list").jqGrid('setGridParam',{url:"jq_budgetupdates_list?ccid="+ids});
				jQuery("#budgetupdates_list").jqGrid('setCaption',"Budget Updates by EMS system for CostCenter: "+selName).trigger('reloadGrid');   	

				//set detail grid for donationsummary
				jQuery("#donationsummary_list").jqGrid('setGridParam',{url:"jq_donationsummary_list?ccid="+ids});
				jQuery("#donationsummary_list").jqGrid('setCaption',"Summary of Donations for CostCenter: "+selName).trigger('reloadGrid');   	

				//set detail grid for donations
				jQuery("#donations_list").jqGrid('setGridParam',{url:"jq_donations_list?ccid="+ids});
				jQuery("#donations_list").jqGrid('setCaption',"Donations for CostCenter: "+selName).trigger('reloadGrid');   	

				}
			}      		      		    
                   });		   
  		   
  		    $("#budget_list").jqGrid('filterToolbar',{autosearch:true});
  		    $("#budget_list").jqGrid('navGrid', "#budget_list_pager", {edit: false, add: false, del: false, search: false});

  		    jQuery("#manualupdates_list").jqGrid({
  		      url:"${createLink(controller:'Project',action:'jq_manualupdates_list')}",
	               datatype:"json",  	 	   
		      colNames:['Date','By','Old','New','Difference','Details','Id'],
		      colModel:[
			{name:'dateCreated', search:false, editable: false},
			{name:'creator', search:false, editable: false},
			{name:'old', search:false, editable: false},
			{name:'new', search:false, editable: false},
			{name:'difference', search:false, editable: false},
			{name:'value', search:false, editable: false},
			{name:'id',hidden:true}
		     ],
  		    rowNum:10,
  		    rowList:[10,20,50],
  		    pager:'#manualupdates_list_pager',
  		    viewrecords: true,
  		    gridview: true,  		    
  		    width: "1250",
  		    height: "100%",
  		    multiselect: false,
  		    viewrecords:true,
                    showPager:true,
		    sortname: 'id',
		    sortorder: "desc",
  		    caption:"Manual Updates List"  	  
                   });		   
  		   
  		    $("#manualupdates_list").jqGrid('navGrid', "#manualupdates_list_pager", {edit: false, add: false, del: false, search: false});

  		    jQuery("#budgetupdates_list").jqGrid({
  		      url:"${createLink(controller:'Project',action:'jq_budgetupdates_list')}",
	               datatype:"json",  	 	   
		      colNames:['Date','By','OldBudget','NewBudget','BudgetChange','OldConsumption','NewConsumption','ConsumptionChange','Details','Id'],
		      colModel:[
			{name:'dateCreated', search:false, editable: false},
			{name:'creator', search:false, editable: false},
			{name:'oldBudget', search:false, editable: false},
			{name:'newBudget', search:false, editable: false},
			{name:'differenceBudget', search:false, editable: false},
			{name:'oldConsumption', search:false, editable: false},
			{name:'newConsumption', search:false, editable: false},
			{name:'differenceConsumption', search:false, editable: false},
			{name:'value', search:false, editable: false},
			{name:'id',hidden:true}
		     ],
  		    rowNum:10,
  		    rowList:[10,20,50],
  		    pager:'#budgetupdates_list_pager',
  		    viewrecords: true,
  		    gridview: true,  		    
  		    width: "1250",
  		    height: "100%",
  		    multiselect: false,
  		    viewrecords:true,
                    showPager:true,
		    sortname: 'id',
		    sortorder: "desc",
  		    caption:"Budget updates by EMS Process"  	  
                   });		   
  		   
  		    $("#budgetupdates_list").jqGrid('navGrid', "#budgetupdates_list_pager", {edit: false, add: false, del: false, search: false});


  		    jQuery("#donationsummary_list").jqGrid({
  		      url:"${createLink(controller:'Project',action:'jq_donationsummary_list')}",
	               datatype:"json",  	 	   
  	            colNames:['PaymentMode','Amount','Id'],
  		      colModel:[
  			{name:'mode',search: true, editable: false},
  			{name:'amount',search: true, editable: false},
  			{name:'id',hidden:true}  				
  		     ], 
  		    rowNum:10,
  		    rowList:[10,20,50,100],
  		    pager:'#donationsummary_list_pager',
  		    viewrecords: true,
  		    gridview: true,  		    
  		    width: "1250",
  		    height: "100%",
  		    multiselect: false,
  		    viewrecords:true,
                    showPager:true,
		    sortname: 'id',
		    sortorder: "desc",
  		    caption:"Donationsummary List"  	  
                   });		   
  		   
  		    $("#donationsummary_list").jqGrid('navGrid', "#donationsummary_list_pager", {edit: false, add: false, del: false, search: false});
  		    
  		    jQuery("#donations_list").jqGrid({
  		      url:"${createLink(controller:'Project',action:'jq_donations_list')}",
	               datatype:"json",  	 	   
  	            colNames:['Donor','Amount','Mode','DonationDate','FundReceiptDate','ReceiptBookNo','ReceiptNo','Id'],
  		      colModel:[
  			{name:'donor',search: true, editable: false},
  			{name:'amount',search: true, editable: false},
  			{name:'mode',search: true, editable: false},
  			{name:'donationDate',search: true, editable: false},
  			{name:'fundReceiptDate',search: true, editable: false},
  			{name:'bookNo',search: true, editable: false},
  			{name:'receiptNo',search: true, editable: false},
  			{name:'id',hidden:true}  				
  		     ], 
  		    rowNum:10,
  		    rowList:[10,20,50,100],
  		    pager:'#donations_list_pager',
  		    viewrecords: true,
  		    gridview: true,  		    
  		    width: "1250",
  		    height: "100%",
  		    multiselect: false,
  		    viewrecords:true,
                    showPager:true,
		    sortname: 'id',
		    sortorder: "desc",
  		    caption:"Donations List"  	  
                   });		   
  		   
  		    $("#donations_list").jqGrid('navGrid', "#donations_list_pager", {edit: false, add: false, del: false, search: false});

  		 });    
  		</script>
  	</body>
  </html>
