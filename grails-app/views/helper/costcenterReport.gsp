
<%@ page import="ics.Donation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Cost Center Wise Transactions</title>
	<r:require module="grid" />
    </head>
    <body>
	<script type="text/javascript" language="javascript">
		$(document).ready(function() {
			$("#dtFrom").datepicker({
				yearRange : "-1:+0",
				changeMonth : true,
				changeYear : true,
				dateFormat : 'dd-mm-yy',
				defaultDate: -1
			});
			$("#dtTill").datepicker({
				yearRange : "-1:+0",
				changeMonth : true,
				changeYear : true,
				dateFormat : 'dd-mm-yy'
			});
		});
	</script>
	
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <div>
			Date From: <g:textField name="dtFrom" value="${new Date().format('dd-MM-yyyy')}" />
			Date Till: <g:textField name="dtTill" value="${new Date().format('dd-MM-yyyy')}" />
                    	<br>
                    	<g:submitButton name="update" value="Search" onClick='refreshGrid();'/>
			
			<!-- table tag will hold our grid -->
			<table id="costcenter_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="costcenter_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    jQuery("#costcenter_list").jqGrid({
      url:'jq_costcenter_list',
      datatype: "json",
      colNames:['CostCenter','Scheme','ReceiptNo','ReceiptDate','Amount','Donor','Id'],
      colModel:[
	{name:'costCenter', search:false, editable: false},
	{name:'scheme', search:false, editable: false}, 
	{name:'receiptNo', search:false, editable: false},
	{name:'receiptDate', search:false, editable: false},
	{name:'amount', search:false, editable: false},
	{name:'donor', search:false, editable: false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#costcenter_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Cost Center Wise Transactions"
    });
    $("#costcenter_list").jqGrid('filterToolbar',{autosearch:true});
    $("#costcenter_list").jqGrid('navGrid',"#costcenter_list_pager",{edit:false,add:false,del:false,search:false});

	// add custom button to export the detail data to excel	
	jQuery("#costcenter_list").jqGrid('navGrid',"#costcenter_list_pager").jqGrid('navButtonAdd',"#costcenter_list_pager",{caption:"AllTransactions", buttonicon:"ui-icon-disk",title:"Export",
	       onClickButton : function () { 
			var query = formUrl();			
			jQuery("#costcenter_list").jqGrid('excelExport',{"url":query});
	       }
	       });
	// add custom button to export the bank wise cheque details data to excel	
	jQuery("#costcenter_list").jqGrid('navGrid',"#costcenter_list_pager").jqGrid('navButtonAdd',"#costcenter_list_pager",{caption:"ChequeReport", buttonicon:"ui-icon-disk",title:"ChequeReportExport",
	       onClickButton : function () { 
			var query = formUrl();	
			query +="&reportName=bankwisecheque"
			jQuery("#costcenter_list").jqGrid('excelExport',{"url":query});
	       }
	       });


    });
    
		function formUrl() {
			var query = "jq_costcenter_list?dtFrom="+$('#dtFrom').val()+"&dtTill="+$('#dtTill').val()
			return query;
		}
		
		function refreshGrid() {
			var query = formUrl();
						
			$("#costcenter_list").jqGrid('setGridParam',{url:query});
			$("#costcenter_list").jqGrid().trigger("reloadGrid");
		}
		
    
</script>


    </body>
</html>
